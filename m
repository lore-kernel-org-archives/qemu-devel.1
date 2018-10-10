Received: from eggs.gnu.org ([2001:4830:134:3::10]:36251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gA9Ru-0005d2-0K
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 04:02:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gA9Ri-0000Yw-Rj
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 04:02:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33434)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gA9Rf-0000TQ-F1
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 04:02:18 -0400
References: <1538748792-19444-1-git-send-email-thuth@redhat.com>
	<CAFEAcA8SJ8QBX9fHPm+DvtdpJYq_vwx0CGsH8Uyp_AV-KMqqDA@mail.gmail.com>
	<fcff0b1e-d3e1-4e8d-48e8-35d0420f5bf5@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <a69fa7e5-e1a6-bcc7-3de5-169ecd23ffd7@redhat.com>
Date: Wed, 10 Oct 2018 10:02:07 +0200
MIME-Version: 1.0
In-Reply-To: <fcff0b1e-d3e1-4e8d-48e8-35d0420f5bf5@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] accel: Improve selection of the default
 accelerator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 2018-10-05 23:12, Paolo Bonzini wrote:
> On 05/10/2018 16:22, Peter Maydell wrote:
>> On 5 October 2018 at 15:13, Thomas Huth <thuth@redhat.com> wrote:
>>> When compiling with "--disable-tcg", we currently still use "tcg"
>>> as default accelerator. "kvm" should be used in this case instead.
>>
>> This part is non-controversial and makes good sense.
>=20
> Though it probably should be extended to "whpx" and "hvf" (probably
> "xen" too if !CONFIG_KVM).

Sure, I was just unsure whether anybody has ever tried to compile with
--disable-tcg and --disable-kvm and use one of those accelerators
instead? Does it work?

>>> Also, some downstream distros provide QEMU binaries which have "kvm"
>>> in their names (e.g. "qemu-kvm" on RHEL or "kvm" on Ubuntu) that use
>>> KVM by default - and some users might want to do something similar
>>> with upstream binaries, too. Accomodate them by using "kvm:tcg" as
>>> default when we detect such a binary name.
>>
>> This part is much riskier and less clearly a good plan --
>> do we really want our behaviour to vary based on the name
>> of the executable? Distros who want that sort of qemu-kvm
>> wrapper generally are providing it already (the Ubuntu one
>> is a 2-line shell script).
>=20
> I think it makes sense.  At least RHEL has qemu-kvm but no
> qemu-system-x86_64, so it has a non-upstream patch to change the
> accelerator; for other distros there are two benefits:
>=20
> 1) now: they could switch to a symlink

Right, I think it's a good idea to avoid wrapper scripts - there is less
chance to get things wrong in this case.

 Thomas
