Received: from eggs.gnu.org ([2001:4830:134:3::10]:57402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bztemail@gmail.com>) id 1e7HQ7-0001hq-VS
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 04:52:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bztemail@gmail.com>) id 1e7HQ6-0008JA-CW
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 04:52:16 -0400
MIME-Version: 1.0
In-Reply-To: <MWHPR21MB01591543E188B048145985709E470@MWHPR21MB0159.namprd21.prod.outlook.com>
References: <CADYoBw2dogvU6-3vChG4js0BNdyTPG8eDvMSRoU50eTX_9DdEQ@mail.gmail.com>
	<MWHPR21MB01590CD596A992C93E01B5079E460@MWHPR21MB0159.namprd21.prod.outlook.com>
	<CADYoBw1ksGDo26-PC4eMnyqxZQoZkXNLDeGoWfcRHs-SfTCJkw@mail.gmail.com>
	<MWHPR21MB01591543E188B048145985709E470@MWHPR21MB0159.namprd21.prod.outlook.com>
From: bzt bzt <bztemail@gmail.com>
Date: Wed, 25 Oct 2017 10:52:12 +0200
Message-ID: <CADYoBw0RjiW2as9jGtPg92E8XK3KR+gM9C5vjC7HHsBauFn4ug@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] BCM2837 and machine raspi3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Baumann <Andrew.Baumann@microsoft.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>

Hi Andrew!

On Tue, Oct 24, 2017 at 6:44 PM, Andrew Baumann <
Andrew.Baumann@microsoft.com> wrote:
[...]

> I see. The address space size sounds like it would affect the SoC
> (although is there really 40 bits of usable physical address space beyond
> the core?). If it's like pi2, however, the wifi and BT are both behind USB,
> so that would be handled more naturally in the board model (raspi.c) than
> the SoC.
>
[...]

>
> Right, but as I wrote above if those devices are behind USB that's not
> part of the SoC model, and belongs in the board logic. If "more registers"
> just refers to the CPU, then that's irrelevant. If there are really more
> devices / device registers on the system bus, then that calls for a deeper
> change in the SoC model and perhaps a new implementation.
>

True, but even if it's behind USB, somehow the USB system should know which
one to emulate. Originally for clear code I was thinking along the line of
if( TYPE(soc) == TYPE_BCM2836 ) {
...
}
if( TYPE(soc) == TYPE_BCM2837 ) {
...
}
when the two are not separated and shares common code. But we are not there
yet, let's focus on one step at a time :-)

[...]

> I'm more open to the need for evolution in the machine init logic
> (raspi.c), so splitting there makes more sense to me than in bcm2836/7.
>
> I see you just posted another patch. FWIW, this isn't quite what I was
> proposing -- rather than have bcm2736.c take a version number that is 2 or
> 3, I would just pass it the CPU model to instantiate. But at this point I
> think it's best waiting for one of the Qemu maintainers to chime in and see
> what they prefer.
>

Again you are right. But I saw Alistair's patch
https://lists.gnu.org/archive/html/qemu-devel/2017-10/msg04153.html When it
makes through, the bcm2836.c could simply use mc->default_cpu_type and
would be no need for anything else in BCM2836State, neither a version nor a
CPU model.

Okay, for now let's see what the maintainers prefer!

Cheers,
bzt


> Andrew
>
