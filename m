Received: from eggs.gnu.org ([2001:4830:134:3::10]:33260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eJeVC-0007Oh-Ov
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 06:56:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eJeVC-0001LL-31
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 06:56:38 -0500
Received: from mail-oi0-x232.google.com ([2607:f8b0:4003:c06::232]:45515)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eJeVB-0001Jx-T5
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 06:56:38 -0500
Received: by mail-oi0-x232.google.com with SMTP id v123so41686oif.12
	for <qemu-devel@nongnu.org>; Tue, 28 Nov 2017 03:56:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CADYoBw31C0Z2vp0S0ZFBOC6A3146wxtZWvzJabACkGh44ZwC0w@mail.gmail.com>
References: <CADYoBw2dogvU6-3vChG4js0BNdyTPG8eDvMSRoU50eTX_9DdEQ@mail.gmail.com>
	<MWHPR21MB01590CD596A992C93E01B5079E460@MWHPR21MB0159.namprd21.prod.outlook.com>
	<CADYoBw1ksGDo26-PC4eMnyqxZQoZkXNLDeGoWfcRHs-SfTCJkw@mail.gmail.com>
	<MWHPR21MB01591543E188B048145985709E470@MWHPR21MB0159.namprd21.prod.outlook.com>
	<CADYoBw0RjiW2as9jGtPg92E8XK3KR+gM9C5vjC7HHsBauFn4ug@mail.gmail.com>
	<CADYoBw19GifmUR=Rztkzzc-v3-zWR6frjiNb_wjzsevreAqPDQ@mail.gmail.com>
	<CAFEAcA9_+wZJa7Ht6EHCCZYm+hrfdbjd9gUmVJPGgZ0yvbZOPA@mail.gmail.com>
	<MWHPR21MB0480DE1F826056BC8377EE289E250@MWHPR21MB0480.namprd21.prod.outlook.com>
	<CADYoBw31C0Z2vp0S0ZFBOC6A3146wxtZWvzJabACkGh44ZwC0w@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Nov 2017 11:56:16 +0000
Message-ID: <CAFEAcA8iM_Qq=OMr_eo_MnUphzinrfhYNJtmuXx9nkK979H3Rg@mail.gmail.com>
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
To: bzt bzt <bztemail@gmail.com>
Cc: Andrew Baumann <Andrew.Baumann@microsoft.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>

On 28 November 2017 at 11:26, bzt bzt <bztemail@gmail.com> wrote:
> (Although I have a question. I'm not sure what's the preferred
> way to get MachineClass* object in bcm2836. Use a MachineState* cast on it's
> Object* argument with MACHINE_GET_CLASS() or should I use the parameterless
> qdev_get_machine() instead?)

bcm2836.c should be a self contained object, which its caller creates
and configures. The MachineClass is the board model object, and the
SoC object shouldn't have to access it. If there's something (like the
CPU model string) that the SoC needs, the SoC object should have a
property which the board model sets.

hw/arm/stm32f205_soc.c has an example of this (as do some of the
other SoC objects -- 'git grep cpu-type hw/arm' should bring them up).

thanks
-- PMM
