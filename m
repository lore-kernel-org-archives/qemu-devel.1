Received: from eggs.gnu.org ([2001:4830:134:3::10]:40150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eEF38-0002qP-FH
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 08:45:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eEF32-0001Ft-TW
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 08:45:18 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:39777)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eEF32-0001F6-Ky
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 08:45:12 -0500
Received: by mail-wm0-x241.google.com with SMTP id l8so9421014wmg.4
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 05:45:12 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <0e23f2bb-a3be-2ba5-5d90-2b7c42b68d5b@redhat.com>
References: <1504286483-23327-1-git-send-email-eric.auger@redhat.com>
	<1504286483-23327-16-git-send-email-eric.auger@redhat.com>
	<CAFEAcA-BfvNFMFpiQd-XwGPYGasV3D-w3oDcqfHRoAXOAT17Fg@mail.gmail.com>
	<40a0ece3-7498-0dda-9e13-234ba09bedf1@redhat.com>
	<CAFEAcA_d1DzNXoJHpi9afGA-oFcPncuM3L-n8GjiLPcAyic+TA@mail.gmail.com>
	<0e23f2bb-a3be-2ba5-5d90-2b7c42b68d5b@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Nov 2017 13:44:50 +0000
Message-ID: <CAFEAcA_H+sraWNVhEZc48eS11n6dC9CyEwTL44tPERiPBO+hbw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v7 15/20] hw/arm/sysbus-fdt: Pass the
 VirtMachineState to the node creation functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 13 November 2017 at 13:37, Auger Eric <eric.auger@redhat.com> wrote:
> On 13/11/2017 14:08, Peter Maydell wrote:
>> Not being able to conveniently wire up a sysbus device on the
>> command line or pass it options are general problems. I don't
>> think the SMMU is a special case that should work around these
>> general issues by being created in a different way to everything
>> else. If the "hard to pass options to the device" problem needs
>> solving (which it does anyway if we want to drop '-net' for
>> configuring embedded ethernet devices) we should solve it,
>> not have some small set of sysbus devices be weirdly magic.
> do you have examples of other SysbusDevices whose instantiation is made
> conditional with "-device" option and which address the dt node/ACPI
> table creation in a more standard manner? Or do you want me to drop the
> "-device" requirement.

I think that you just can't create sysbus devices with -device.
They're hardwired into the machine model.

> I may manage reaching my goal with yet another machine init done
> notifier that would create the dt node from virt code at fixed base
> address. But this solution still may be be virt specific. Is it the
> direction you want me to follow at the moment?

I still don't really understand why the SMMU has to be any
different from the UART, or the PCI controller, or any of
the other devices in the virt board model. None of those
try to be creatable from the command line.

thanks
-- PMM
