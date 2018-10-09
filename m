Received: from eggs.gnu.org ([2001:4830:134:3::10]:46207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g9t5x-0003wD-Ec
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 10:34:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g9t5w-0004DW-KD
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 10:34:45 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:40915)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g9t5w-0004CZ-7m
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 10:34:44 -0400
Received: by mail-oi1-x241.google.com with SMTP id j68-v6so1385207oib.7
	for <qemu-devel@nongnu.org>; Tue, 09 Oct 2018 07:34:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181009142309.GH22838@redhat.com>
References: <1538748792-19444-1-git-send-email-thuth@redhat.com>
	<CAFEAcA8SJ8QBX9fHPm+DvtdpJYq_vwx0CGsH8Uyp_AV-KMqqDA@mail.gmail.com>
	<875zybzdzm.fsf@dusky.pond.sub.org> <87zhvntg6k.fsf@dusky.pond.sub.org>
	<20181009154312.771c276a.cohuck@redhat.com>
	<CAFEAcA-EV4YO7TtTqC74LfeLnceM7nphxsYc7WT9nPWTdap22g@mail.gmail.com>
	<20181009142309.GH22838@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Oct 2018 15:34:22 +0100
Message-ID: <CAFEAcA9AfhifaHzGfNPwU7TG-4KUz0aO32utp86XWjHoHn3kUw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 9 October 2018 at 15:23, Daniel P. Berrang=C3=A9 <berrange@redhat.com> w=
rote:
> On Tue, Oct 09, 2018 at 02:58:41PM +0100, Peter Maydell wrote:
>> On 9 October 2018 at 14:43, Cornelia Huck <cohuck@redhat.com> wrote:
>> > I'm not sure why a single accelerator (any of them) would be a good
>> > default. A list (tcg:kvm:<whatever>) sounds much saner, as it would
>> > continue to work even if some accelerators have been disabled (right?)
>> >
>> > (And I'd prefer kvm to be first in that list; anything that relies on
>> > tcg being used should specify it explicitly... a normal user will
>> > likely always want the fast variant.)
>>
>> tcg should be the default for binaries without KVM compiled in,
>> of course... But as Thomas points out, the reason for our current
>> default is the usual "because we tend not to change things that
>> would break existing working command lines".
>
> Putting KVM first shouldn't break existing working command lines
> in general.

There are ARM QEMU command lines which will fail with KVM
and work with TCG (eg ones which use -cpu something-other-than-host
or which ask for a GICv3 when the host has only a GICv2).
These are basically cases where KVM can't provide features
that TCG can. I imagine other archs like power have similar.


thanks
-- PMM
