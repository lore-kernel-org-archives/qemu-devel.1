Received: from eggs.gnu.org ([2001:4830:134:3::10]:52904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bztemail@gmail.com>) id 1eJe2F-0003Ws-QR
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 06:26:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bztemail@gmail.com>) id 1eJe2E-0005wN-P9
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 06:26:43 -0500
MIME-Version: 1.0
In-Reply-To: <MWHPR21MB0480DE1F826056BC8377EE289E250@MWHPR21MB0480.namprd21.prod.outlook.com>
References: <CADYoBw2dogvU6-3vChG4js0BNdyTPG8eDvMSRoU50eTX_9DdEQ@mail.gmail.com>
	<MWHPR21MB01590CD596A992C93E01B5079E460@MWHPR21MB0159.namprd21.prod.outlook.com>
	<CADYoBw1ksGDo26-PC4eMnyqxZQoZkXNLDeGoWfcRHs-SfTCJkw@mail.gmail.com>
	<MWHPR21MB01591543E188B048145985709E470@MWHPR21MB0159.namprd21.prod.outlook.com>
	<CADYoBw0RjiW2as9jGtPg92E8XK3KR+gM9C5vjC7HHsBauFn4ug@mail.gmail.com>
	<CADYoBw19GifmUR=Rztkzzc-v3-zWR6frjiNb_wjzsevreAqPDQ@mail.gmail.com>
	<CAFEAcA9_+wZJa7Ht6EHCCZYm+hrfdbjd9gUmVJPGgZ0yvbZOPA@mail.gmail.com>
	<MWHPR21MB0480DE1F826056BC8377EE289E250@MWHPR21MB0480.namprd21.prod.outlook.com>
From: bzt bzt <bztemail@gmail.com>
Date: Tue, 28 Nov 2017 12:26:40 +0100
Message-ID: <CADYoBw31C0Z2vp0S0ZFBOC6A3146wxtZWvzJabACkGh44ZwC0w@mail.gmail.com>
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
Cc: Peter Maydell <peter.maydell@linaro.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>

Hi Andrew!

[...]

>
> In that case, IIRC my high-level suggestion was to either parameterise
> bcm2836 to take a CPU model string, or else move the CPU creation out of
> bcm2836.c into the board file. From what I've understood thus far about
> pi3, it does not seem necessary to have a separate bcm2837 implementation.
> I suspect at that point the patch would be small enough that it didn't
> require further splitting.
>

Yes, I agree. I've provided a parameterised version on Oct 24, which does
not have a separate bcm2837 implementation. Is that patch ok? Or should I
wait for Alistair's patch (
https://lists.gnu.org/archive/html/qemu-devel/2017-10/msg04153.html)?
I would prefer the latter, if I may, and I'm willing to rewrite raspi3
support using the CPU model string in mc->default_cpu_type introduced by
that patch. (Although I have a question. I'm not sure what's the preferred
way to get MachineClass* object in bcm2836. Use a MachineState* cast on
it's Object* argument with MACHINE_GET_CLASS() or should I use the
parameterless qdev_get_machine() instead?)


> > PS: if you send a new patch, send it as a new top level
> > thread -- if you send it as a reply/followup to the
> > first patch it's liable to not be noticed.
>
> Please also CC me on the new patch as I am not very reliable at monitoring
> qemu-devel.
>

Noted :-) Thank you for your help! I'm sure qemu users appreciate it very
much!

bzt


>
> Thanks!
> Andrew
>
