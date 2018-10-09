Received: from eggs.gnu.org ([2001:4830:134:3::10]:42643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1g9nxn-00012f-Af
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 05:06:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1g9nxh-0004OI-K4
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 05:05:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39492)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1g9nxg-0004Nh-Cq
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 05:05:53 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1538748792-19444-1-git-send-email-thuth@redhat.com>
	<CAFEAcA8SJ8QBX9fHPm+DvtdpJYq_vwx0CGsH8Uyp_AV-KMqqDA@mail.gmail.com>
Date: Tue, 09 Oct 2018 11:05:49 +0200
In-Reply-To: <CAFEAcA8SJ8QBX9fHPm+DvtdpJYq_vwx0CGsH8Uyp_AV-KMqqDA@mail.gmail.com>
	(Peter Maydell's message of "Fri, 5 Oct 2018 15:22:44 +0100")
Message-ID: <875zybzdzm.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On 5 October 2018 at 15:13, Thomas Huth <thuth@redhat.com> wrote:
>> When compiling with "--disable-tcg", we currently still use "tcg"
>> as default accelerator. "kvm" should be used in this case instead.
>
> This part is non-controversial and makes good sense.

Agreed.

>> Also, some downstream distros provide QEMU binaries which have "kvm"
>> in their names (e.g. "qemu-kvm" on RHEL or "kvm" on Ubuntu) that use
>> KVM by default - and some users might want to do something similar
>> with upstream binaries, too. Accomodate them by using "kvm:tcg" as
>> default when we detect such a binary name.
>
> This part is much riskier and less clearly a good plan --
> do we really want our behaviour to vary based on the name
> of the executable? Distros who want that sort of qemu-kvm
> wrapper generally are providing it already (the Ubuntu one
> is a 2-line shell script).

I hate it when argv[0] affects behavior[*].  I hate shell wrappers less.

If a system provides just one qemu executable, and its default
accelerator should be something other than tcg:kvm, then there's a use
for making it compile-time configurable.  Reading the default from /etc/
would also work.  Not sure such a system exists.



[*] Go document the behavior with proper precision, and you might come
to share the feeling.
