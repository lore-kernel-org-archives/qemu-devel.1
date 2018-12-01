Received: from eggs.gnu.org ([2001:4830:134:3::10]:47678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gT41M-0002KM-AA
	for qemu-devel@nongnu.org; Sat, 01 Dec 2018 07:05:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gT41L-000583-4d
	for qemu-devel@nongnu.org; Sat, 01 Dec 2018 07:05:16 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:35088)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gT41K-00057c-Ve
	for qemu-devel@nongnu.org; Sat, 01 Dec 2018 07:05:15 -0500
Received: by mail-oi1-x241.google.com with SMTP id v6so7090255oif.2
	for <qemu-devel@nongnu.org>; Sat, 01 Dec 2018 04:05:14 -0800 (PST)
MIME-Version: 1.0
References: <CAFEAcA9Od4vjo2EeEXhP1iE_XONaK8H22L9eq1qw3w6C2nR_cQ@mail.gmail.com>
	<201812011728499706543@zte.com.cn>
In-Reply-To: <201812011728499706543@zte.com.cn>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 1 Dec 2018 12:05:02 +0000
Message-ID: <CAFEAcA-0DPo=4vzHtfD-bmAsfguOd7RiQUnHMpg0Q0e8aNZ_vA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH V10 7/9] hw/misc/pvpanic: preparing
 foradding configure interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peng Hao <peng.hao2@zte.com.cn>
Cc: Andrew Jones <drjones@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Sat, 1 Dec 2018 at 09:28, <peng.hao2@zte.com.cn> wrote:
> Peter Maydell wrote:
> >This kind of thing is why a PCI device is cleaner -- it just
> >works on any machine with a PCI controller, it by default is
> >something that the user can provide if they want to and not if
> >they don't, and it's not a custom UI that management layers
> >might need to special-case. The guest does need to do a bit
> >of PCI probing and setup initially, but then it can just leave
> >the MMIO BAR permanently mapped and write to that address
> >when the guest panics.

> Usually, it doesn't matter if there is this pvpanic device or not, so I
> haven't considered configurability from the beginning.

It matters to people who don't want it, because it increases
the attack surface presented to the guest.

>  I didn't expect you to strongly recommend the use of PCI devices.
> Doing so is not just going to roll back some of the code in the kernel...
> I'll think about your suggestions.

My view on this hasn't changed since October:
https://lists.nongnu.org/archive/html/qemu-devel/2018-10/msg03861.html
if this really really needs to be an MMIO device then it can
be done, but a PCI device is a much cleaner interface which
is more widely usable than just the virt board.

thanks
-- PMM
