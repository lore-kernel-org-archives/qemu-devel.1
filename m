Received: from eggs.gnu.org ([209.51.188.92]:49760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1hGDmT-0006Kj-UB
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 22:25:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1hGDmR-0008AH-SB
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 22:25:05 -0400
Received: from mail-it1-x142.google.com ([2607:f8b0:4864:20::142]:35044)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <andrew.smirnov@gmail.com>)
	id 1hGDmR-00089s-EZ
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 22:25:03 -0400
Received: by mail-it1-x142.google.com with SMTP id w15so30166384itc.0
	for <qemu-devel@nongnu.org>; Mon, 15 Apr 2019 19:25:02 -0700 (PDT)
MIME-Version: 1.0
References: <87d0mwatbu.fsf@dusky.pond.sub.org>
In-Reply-To: <87d0mwatbu.fsf@dusky.pond.sub.org>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Mon, 15 Apr 2019 19:24:49 -0700
Message-ID: <CAHQ1cqEDxNMeAGb5t4OrV9DWpq-VTn4GVhjQh4BePZv=JP8-Ow@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Maintainers,
 please tell us how to boot your machines!
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, Alistair Francis <Alistair.Francis@wdc.com>, Alistair Francis <alistair@alistair23.me>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Andrew Jeffery <andrew@aj.id.au>, Andrzej Zaborowski <balrogg@gmail.com>, Anthony Green <green@moxielogic.com>, Anthony Perard <anthony.perard@citrix.com>, Antony Pavlov <antonynpavlov@gmail.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, BALATON Zoltan <balaton@eik.bme.hu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Beniamino Galvani <b.galvani@gmail.com>, Chris Wulff <crwulff@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, David Hildenbrand <david@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Fabien Chouteau <chouteau@adacore.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Halil Pasic <pasic@linux.ibm.com>, Helge Deller <deller@gmx.de>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Jan Kiszka <jan.kiszka@web.de>, Jean-Christophe Dubois <jcd@tribudubois.net>, Jia Liu <proljc@gmail.com>, Joel Stanley <joel@jms.id.au>, Magnus Damm <magnus.damm@gmail.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Marek Vasut <marex@denx.de>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Max Filippov <jcmvbkbc@gmail.com>, Michael Walle <michael@walle.cc>, Palmer Dabbelt <palmer@sifive.com>, Paolo Bonzini <pbonzini@redhat.com>, Paul Burton <pburton@wavecomp.com>, Paul Durrant <paul.durrant@citrix.com>, Peter Chubb <peter.chubb@nicta.com.au>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <rth@twiddle.net>, Rob Herring <robh@kernel.org>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Stafford Horne <shorne@gmail.com>, Stefano Stabellini <sstabellini@kernel.org>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Thomas Huth <huth@tuxfamily.org>

On Tue, Mar 12, 2019 at 10:36 AM Markus Armbruster <armbru@redhat.com> wrote:
>
> Dear board code maintainers,
>
> This is a (rather late) follow-up to the last QEMU summit.  Minutes[*]:
>
>  * Deprecating unmaintained features (devices, targets, backends) in QEMU
>
>    QEMU has a mechanism to deprecate features but there remains a lot of
>    old unmaintained code.  Refactoring is hindered by untested legacy
>    code, so there is a desire to deprecate unmaintained features more
>    often.
>
>    [...]
>
>    We should require at least a minimal test for each board; if nobody
>    cares enough to come up with one, that board should be deprecated.
>
>    [...]
>
>    Also see the qemu-devel discussion about deprecating code:
>    https://lists.nongnu.org/archive/html/qemu-devel/2018-10/msg05828.html.
>
> That's a link to "Minutes of KVM Forum BoF on deprecating stuff".
> Quote:
>
>  * One obvious class of candidates for removal is machines we don't know
>    how to boot, or can't boot, say because we lack required firmware
>    and/or OS.
>
>    Of course, "can boot" should be an automated test.  As a first step
>    towards that, we should at least document how to boot each machine.
>    We're going to ask machine maintainers to do that.
>
> Let's get going on this.
>
> I gathered the machine types, mapped them to source files, which I fed
> to get_maintainer.pl.  Results are appended.  If you're cc'ed,
> MAINTAINERS fingers you for at least one machine type's source file.
> Please tell us for all of them how to to a "meaningful" boot test.
>
> For now, what's "meaningful" is entirely up to you.  Booting Linux
> certainly is.
>
> Make sure to include a complete QEMU command line.  If your QEMU command
> line requires resources beyond the QEMU source tree and what we build
> from it, please detail them, and provide download URLs as far as
> possible.
>
> Goals for this exercise:
>
> * Gather information we need to cover more machines in our automated
>   testing.
>
>   Related work:
>   [PATCH v4 00/19] Acceptance Tests: target architecture support
>   Message-Id: <20190312121150.8638-1-crosa@redhat.com>
>   https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg03881.html
>
> * Maybe identify a few machines we don't know how to boot anymore.
>
> Thanks in advance for your help!
>
>
>
> Machines with at least one maintainer:
>
>
>     = hw/arm/mcimx7d-sabre.c =
>     Peter Maydell <peter.maydell@linaro.org> (odd fixer:MCIMX7D SABRE / i...)
>     Andrey Smirnov <andrew.smirnov@gmail.com> (reviewer:MCIMX7D SABRE / i...)
>     qemu-arm@nongnu.org (open list:MCIMX7D SABRE / i...)
>

Sorry I am late to this party. I haven't used i.MX7 emulation in a
while and things didn't go smoothly out of the box, so I had to create
a number of fixes (submitted to the ML).

I use Linux kernel built using Buildroot for validation. Buildroot
should have a default i.MX7 Sabred SD configuration and that should
probably work. I usually change mine slightly to use compiled-in
rootfs to simplify storage setup.

In case this is helpful here's a number of commands I use to start my
test cases:

* PCIe (e1000 ethernet attached), USB (usb stick attached), SD:
arm-softmmu/qemu-system-arm -smp 2 -m 1024 -machine mcimx7d-sabre
-nographic -serial mon:stdio -kernel <path to zImage> -dtb <path to
DTB> -device e1000e,bus="dw-pcie",netdev=lan0 -netdev
tap,id=lan0,ifname=tap0,script=no,downscript=no -append
"console=ttymxc0,115200 noinitrd" -usb -drive
if=none,id=stick,file=<patch to USB stick image>,format=raw -device
usb-storage,bus=usb-bus.0,drive=stick -drive
id=sd1,if=sd,format=file,file=<path to SD1> -drive
id=sd2,if=sd,format=file,file=<path to SD2> -driv
eid=sd3,if=sd,format=file,file=<path to SD3>

* EHCI USB attached via PCIe with legacy interrupts, Ethernet
connected to built-in controller:
arm-softmmu/qemu-system-arm -smp 2 -m 1024 -machine mcimx7d-sabre
-nographic -serial mon:stdio -kernel <path to zImage> -dtb <path to
DTB> -device usb-ehci,id=ehci,bus="dw-pcie" -net
nic,model=imx.fec,netdev=lan0 -netdev
tap,id=lan0,ifname=tap0,script=no,downscript=no -append
"console=ttymxc0,115200 noinitrd pci=nomsi" -usb -drive
if=none,id=stick,file=<path to USB stick image>,format=raw

Also, I don't think anyone would try to do this, but just as a
warning, building QEMU with --enable-tcg-interpreter doesn't really
work that well (/init gets SIGKILLed every time), so I'd recommend
avoiding using that option.

Hopefully this is enough info, but if not, feel free to ask me more questions.

Thanks,
Andrey Smirnov
