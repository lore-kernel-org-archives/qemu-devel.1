Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE30DC10F0B
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 08:18:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 656A7214DA
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 08:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n3dMX9lI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 656A7214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37820 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hH2FH-0006kj-4e
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 04:18:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sundeep.lkml@gmail.com>) id 1hH2EG-0006HQ-RW
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 04:17:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sundeep.lkml@gmail.com>) id 1hH2ED-0001wm-HO
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 04:17:08 -0400
Received: from mail-vs1-xe42.google.com ([2607:f8b0:4864:20::e42]:41919)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sundeep.lkml@gmail.com>)
	id 1hH2ED-0001w4-6a
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 04:17:05 -0400
Received: by mail-vs1-xe42.google.com with SMTP id g187so701210vsc.8
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 01:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=H2SJwPKLuntzf7I/askuKyRxU2t6sJ76W89CgraDZVc=;
	b=n3dMX9lIuMjxZhXp9vBLkwQNYE3Sg4Bd/dtFe62Q4lLe9nEbt/bocsIqSTBy/b4pfW
	XeqvQn4PfBuRUl9PG4uRobLYPlRqRQTxyx63M1ZgQzWfVW6XxjxG2BDx2sbo32I0HcNw
	pBoe+bUKj4LbV9A2PS7sLy0SsDkiASUF9XvA1pC+IEJlfSd1VC84A6aFrIZJzdPDjrJ2
	kiUEv1kO7xihchX2VBlfbQoOAVEp6ohlUcp++He2IV2J73DLx9qu1VFya/Vmh0ZdkydE
	LG7piMbchV2tx7sAw06HbvHxBbkID9vv9BxmPx06dH4i21/n1qexTAs++9Hw8v1ZcXNx
	gqAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=H2SJwPKLuntzf7I/askuKyRxU2t6sJ76W89CgraDZVc=;
	b=UU9kaaXxVpHwKbYEELMUwStsfacAdld4oHIYPoTo15yjs8o5B5duPxgYZZpU6ABnB1
	eno1XUT+3vgHewTsUOoHF6S5WDCudzmtGcOUWEpbxsv09ZMUqJVrk0X5cc62ZBQfak9J
	bodpGvAtvyXlb3t1TFvLEEpkN9kXt+I7ytC52vv06FyXyYGDcwDW/cWzrVra9B0DjmdR
	RojsEB+BVinMRlHK9FHJ4xWzJfJemXPGV8oiFuo2dlSrzcUhJ8O/cTBmZfW3zjzyt08o
	OAUT9MqNiQnRHv+euekuh8n921bOpFNN9HeaeDQ86Yy2S6Aq49PPY0jta8IehapPJBn1
	ohMg==
X-Gm-Message-State: APjAAAXwLGl32XfR4WtWAK9XI3LqYREr/WUH0a+HZFGqpataOtcB7l0y
	1HjUrEHBwcZpBMxNuiH9YpYI0E0XYgtxrzrmhpI=
X-Google-Smtp-Source: APXvYqw5D7Kr1ERCKP82QUNubOV0VXCvqCl/Saezn0wnFxaYTn4LLHRftBxMxzzT7tLBOtEaNEg8A5h8v4jnpIyhI5M=
X-Received: by 2002:a67:ba03:: with SMTP id l3mr32828817vsn.96.1555575422832; 
	Thu, 18 Apr 2019 01:17:02 -0700 (PDT)
MIME-Version: 1.0
References: <87d0mwatbu.fsf@dusky.pond.sub.org>
	<CAAdtpL6VCiXLbTWyJo4cbCNLjOCPr6KrH8KTqEq1V=CTMYKubQ@mail.gmail.com>
In-Reply-To: <CAAdtpL6VCiXLbTWyJo4cbCNLjOCPr6KrH8KTqEq1V=CTMYKubQ@mail.gmail.com>
From: sundeep subbaraya <sundeep.lkml@gmail.com>
Date: Thu, 18 Apr 2019 13:46:51 +0530
Message-ID:
 <CALHRZuoH6msZxphuMfkQ2uNu7fXSisbUs_SX94svYZBKn9p9=g@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::e42
Subject: Re: [Qemu-devel] Maintainers,
 please tell us how to boot your machines!
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Paul Burton <pburton@wavecomp.com>, Cornelia Huck <cohuck@redhat.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	Sagar Karandikar <sagark@eecs.berkeley.edu>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Anthony Green <green@moxielogic.com>, Palmer Dabbelt <palmer@sifive.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	"qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Alistair Francis <Alistair.Francis@wdc.com>,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
	Guan Xuetao <gxt@mprc.pku.edu.cn>, Peter Chubb <peter.chubb@nicta.com.au>,
	Marek Vasut <marex@denx.de>, Rob Herring <robh@kernel.org>,
	Stefano Stabellini <sstabellini@kernel.org>, Jia Liu <proljc@gmail.com>,
	Aleksandar Rikalo <arikalo@wavecomp.com>, Helge Deller <deller@gmx.de>,
	David Hildenbrand <david@redhat.com>, Magnus Damm <magnus.damm@gmail.com>,
	Markus Armbruster <armbru@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	=?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
	Antony Pavlov <antonynpavlov@gmail.com>,
	Anthony Perard <anthony.perard@citrix.com>,
	Richard Henderson <rth@twiddle.net>,
	Artyom Tarasenko <atar4qemu@gmail.com>, Joel Stanley <joel@jms.id.au>,
	Eduardo Habkost <ehabkost@redhat.com>,
	Alistair Francis <alistair@alistair23.me>,
	Fabien Chouteau <chouteau@adacore.com>,
	Beniamino Galvani <b.galvani@gmail.com>,
	Paul Durrant <paul.durrant@citrix.com>,
	Igor Mitsyanko <i.mitsyanko@gmail.com>,
	=?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
	Paolo Bonzini <pbonzini@redhat.com>, Stafford Horne <shorne@gmail.com>,
	David Gibson <david@gibson.dropbear.id.au>,
	Andrew Jeffery <andrew@aj.id.au>,
	Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
	Chris Wulff <crwulff@gmail.com>,
	Andrew Baumann <Andrew.Baumann@microsoft.com>,
	Jean-Christophe Dubois <jcd@tribudubois.net>,
	Andrey Smirnov <andrew.smirnov@gmail.com>,
	Michael Walle <michael@walle.cc>, Thomas Huth <huth@tuxfamily.org>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Jan Kiszka <jan.kiszka@web.de>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190418081651.B1uUoHGDOEL6pYfxWAZvW8OoXEuwblfEKwhFLbkjRLE@z>

Hi,

On Wed, Mar 13, 2019 at 6:36 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> '
> On Tue, Mar 12, 2019 at 6:44 PM Markus Armbruster <armbru@redhat.com> wro=
te:
> >
> > Dear board code maintainers,
> >
> > This is a (rather late) follow-up to the last QEMU summit.  Minutes[*]:
> >
> >  * Deprecating unmaintained features (devices, targets, backends) in QE=
MU
> >
> >    QEMU has a mechanism to deprecate features but there remains a lot o=
f
> >    old unmaintained code.  Refactoring is hindered by untested legacy
> >    code, so there is a desire to deprecate unmaintained features more
> >    often.
> >
> >    [...]
> >
> >    We should require at least a minimal test for each board; if nobody
> >    cares enough to come up with one, that board should be deprecated.
> >
> >    [...]
> >
         [...]
> >
> >     =3D hw/arm/msf2-som.c =3D
> >     Subbaraya Sundeep <sundeep.lkml@gmail.com> (maintainer:Emcraft M2S-=
FG484)
> >     Peter Maydell <peter.maydell@linaro.org> (maintainer:Emcraft M2S-FG=
484)
> >     qemu-arm@nongnu.org (open list:ARM)
>
> ./arm-softmmu/qemu-system-arm -M emcraft-sf2 -serial mon:stdio \
> -kernel u-boot.bin -display none -drive file=3Dspi.bin,if=3Dmtd,format=3D=
raw
>
> Binaries u-boot.bin and spi.bin are at:
> https://github.com/Subbaraya-Sundeep/qemu-test-binaries.git
> Sources:
> https://github.com/Subbaraya-Sundeep/emcraft-uboot-sf2.git
> https://github.com/Subbaraya-Sundeep/linux.git
>
These should work as is since nothing changed.
Thanks Philippe.

Sundeep

> >
> >     =3D hw/arm/musca.c =3D
> >     Peter Maydell <peter.maydell@linaro.org> (maintainer:Musca)
> >     qemu-arm@nongnu.org (open list:Musca)
> >
> >     =3D hw/arm/netduino2.c =3D
> >     Alistair Francis <alistair@alistair23.me> (maintainer:Netduino 2)
> >     Peter Maydell <peter.maydell@linaro.org> (maintainer:Netduino 2)
> >     qemu-arm@nongnu.org (open list:ARM)
> >
> >     =3D hw/arm/omap_sx1.c =3D
> >     Peter Maydell <peter.maydell@linaro.org> (maintainer:OMAP)
> >     qemu-arm@nongnu.org (open list:ARM)
> >
> >     =3D hw/arm/realview.c =3D
> >     Peter Maydell <peter.maydell@linaro.org> (maintainer:Real View)
> >     qemu-arm@nongnu.org (open list:Real View)
> >
> >     =3D hw/arm/stellaris.c =3D
> >     Peter Maydell <peter.maydell@linaro.org> (maintainer:Stellaris)
> >     qemu-arm@nongnu.org (open list:Stellaris)
>
> https://docs.zephyrproject.org/1.13.0/boards/arm/qemu_cortex_m3/doc/board=
.html
>
> >     =3D hw/arm/versatilepb.c =3D
> >     Peter Maydell <peter.maydell@linaro.org> (maintainer:Versatile PB)
> >     qemu-arm@nongnu.org (open list:Versatile PB)
>
> https://people.debian.org/~aurel32/qemu/armel/
>
> >     =3D hw/arm/vexpress.c =3D
> >     Peter Maydell <peter.maydell@linaro.org> (maintainer:Versatile Expr=
ess)
> >     qemu-arm@nongnu.org (open list:Versatile Express)
>
> https://people.debian.org/~aurel32/qemu/armhf/
>
> >     =3D hw/arm/virt.c =3D
> >     Peter Maydell <peter.maydell@linaro.org> (maintainer:Virt)
> >     qemu-arm@nongnu.org (open list:Virt)
> >
> >     =3D hw/arm/xilinx_zynq.c =3D
> >     "Edgar E. Iglesias" <edgar.iglesias@gmail.com> (maintainer:Xilinx Z=
ynq)
> >     Alistair Francis <alistair@alistair23.me> (maintainer:Xilinx Zynq)
> >     Peter Maydell <peter.maydell@linaro.org> (maintainer:Xilinx Zynq)
> >     qemu-arm@nongnu.org (open list:Xilinx Zynq)
> >
> >     =3D hw/arm/xlnx-versal-virt.c =3D
> >     Alistair Francis <alistair@alistair23.me> (maintainer:Xilinx ZynqMP=
)
> >     "Edgar E. Iglesias" <edgar.iglesias@gmail.com> (maintainer:Xilinx Z=
ynqMP)
> >     Peter Maydell <peter.maydell@linaro.org> (maintainer:Xilinx ZynqMP)
> >     qemu-arm@nongnu.org (open list:Xilinx ZynqMP)
> >
> >     =3D hw/arm/xlnx-zcu102.c =3D
> >     Alistair Francis <alistair@alistair23.me> (maintainer:Xilinx ZynqMP=
)
> >     "Edgar E. Iglesias" <edgar.iglesias@gmail.com> (maintainer:Xilinx Z=
ynqMP)
> >     Peter Maydell <peter.maydell@linaro.org> (maintainer:Xilinx ZynqMP)
> >     qemu-arm@nongnu.org (open list:Xilinx ZynqMP)
> >
> >     =3D hw/cris/axis_dev88.c =3D
> >     "Edgar E. Iglesias" <edgar.iglesias@gmail.com> (maintainer:Axis Dev=
88)
> >
> >     =3D hw/hppa/machine.c =3D
> >     Richard Henderson <rth@twiddle.net> (maintainer:HPPA (PA-RISC))
> >     Helge Deller <deller@gmx.de> (reviewer:Dino)
> >
> >     =3D hw/i386/pc_piix.c =3D
> >     Paolo Bonzini <pbonzini@redhat.com> (maintainer:X86)
> >     Richard Henderson <rth@twiddle.net> (maintainer:X86)
> >     Eduardo Habkost <ehabkost@redhat.com> (maintainer:X86)
> >     "Michael S. Tsirkin" <mst@redhat.com> (supporter:PC)
> >     Marcel Apfelbaum <marcel.apfelbaum@gmail.com> (supporter:PC)
> >
> >     =3D hw/i386/pc_q35.c =3D
> >     "Michael S. Tsirkin" <mst@redhat.com> (supporter:PC)
> >     Marcel Apfelbaum <marcel.apfelbaum@gmail.com> (supporter:PC)
> >     Paolo Bonzini <pbonzini@redhat.com> (maintainer:X86)
> >     Richard Henderson <rth@twiddle.net> (maintainer:X86)
> >     Eduardo Habkost <ehabkost@redhat.com> (maintainer:X86)
> >
> >     =3D hw/lm32/lm32_boards.c =3D
> >     Michael Walle <michael@walle.cc> (maintainer:LM32)
> >
> >     =3D hw/lm32/milkymist.c =3D
> >     Michael Walle <michael@walle.cc> (maintainer:milkymist)
> >
> >     =3D hw/microblaze/petalogix_ml605_mmu.c =3D
> >     "Edgar E. Iglesias" <edgar.iglesias@gmail.com> (maintainer:petalogi=
x_ml605)
> >
> >     =3D hw/microblaze/petalogix_s3adsp1800_mmu.c =3D
> >     "Edgar E. Iglesias" <edgar.iglesias@gmail.com> (maintainer:petalogi=
x_s3adsp1800)
> >
> >     =3D hw/microblaze/xlnx-zynqmp-pmu.c =3D
> >     Alistair Francis <alistair@alistair23.me> (maintainer:Xilinx ZynqMP=
)
> >     "Edgar E. Iglesias" <edgar.iglesias@gmail.com> (maintainer:Xilinx Z=
ynqMP)
> >     Peter Maydell <peter.maydell@linaro.org> (maintainer:Xilinx ZynqMP)
> >     qemu-arm@nongnu.org (open list:Xilinx ZynqMP)
> >
> >     =3D hw/mips/boston.c =3D
> >     Paul Burton <pburton@wavecomp.com> (maintainer:Boston)
> >     Aleksandar Rikalo <arikalo@wavecomp.com> (reviewer:Boston)
> >     Aurelien Jarno <aurelien@aurel32.net> (maintainer:MIPS)
> >     Aleksandar Markovic <amarkovic@wavecomp.com> (maintainer:MIPS)
>
> See:
> https://lists.gnu.org/archive/html/qemu-devel/2016-08/msg03419.html
>
> linux-v4.17$ make ARCH=3Dmips CROSS_COMPILE=3Dmipsel-linux-gnu- 64r2el_de=
fconfig
> qemu-system-mips64el -M boston -kernel arch/mips/boot/vmlinux.gz.itb
> -serial stdio
>
> >     =3D hw/mips/mips_fulong2e.c =3D
> >     Aleksandar Markovic <amarkovic@wavecomp.com> (odd fixer:Fulong 2E)
> >     Aleksandar Rikalo <arikalo@wavecomp.com> (reviewer:Fulong 2E)
> >     Aurelien Jarno <aurelien@aurel32.net> (maintainer:MIPS)
>
> Linux fuloong2e_defconfig
>
> qemu-system-mips64el -machine fulong2e -kernel vmlinux -append
> 'console=3DttyS0' -nographic -m 1G -serial stdio
>
> prebuilt images: http://acksyn.org/posts/2015/06/running-fedora-mips/
>
> >     =3D hw/mips/mips_jazz.c =3D
> >     "Herv=C3=A9 Poussineau" <hpoussin@reactos.org> (maintainer:Jazz)
> >     Aleksandar Rikalo <arikalo@wavecomp.com> (reviewer:Jazz)
> >     Aurelien Jarno <aurelien@aurel32.net> (maintainer:MIPS)
> >     Aleksandar Markovic <amarkovic@wavecomp.com> (maintainer:MIPS)
> >
> >     =3D hw/mips/mips_malta.c =3D
> >     Aurelien Jarno <aurelien@aurel32.net> (maintainer:Malta)
> >     Aleksandar Rikalo <arikalo@wavecomp.com> (reviewer:Malta)
> >     Aleksandar Markovic <amarkovic@wavecomp.com> (maintainer:MIPS)
>
> https://people.debian.org/~aurel32/qemu/mips/ =3D)
>
> >     =3D hw/mips/mips_mipssim.c =3D
> >     Aleksandar Markovic <amarkovic@wavecomp.com> (odd fixer:Mipssim)
> >     Aleksandar Rikalo <arikalo@wavecomp.com> (reviewer:Mipssim)
> >     Aurelien Jarno <aurelien@aurel32.net> (maintainer:MIPS)
>
> See this thread:
> http://lists.nongnu.org/archive/html/qemu-devel/2018-04/msg04071.html
>
> >     =3D hw/mips/mips_r4k.c =3D
> >     Aurelien Jarno <aurelien@aurel32.net> (maintainer:R4000)
> >     Aleksandar Rikalo <arikalo@wavecomp.com> (reviewer:R4000)
> >     Aleksandar Markovic <amarkovic@wavecomp.com> (maintainer:MIPS)
> >
> >     =3D hw/moxie/moxiesim.c =3D
> >     Anthony Green <green@moxielogic.com> (maintainer:Moxie)
> >
> >     =3D hw/nios2/10m50_devboard.c =3D
> >     Chris Wulff <crwulff@gmail.com> (maintainer:NiosII)
> >     Marek Vasut <marex@denx.de> (maintainer:NiosII)
> >
> >     =3D hw/openrisc/openrisc_sim.c =3D
> >     Jia Liu <proljc@gmail.com> (maintainer:or1k-sim)
> >     Stafford Horne <shorne@gmail.com> (odd fixer:OpenRISC)
> >
> >     =3D hw/ppc/pnv.c =3D
> >     David Gibson <david@gibson.dropbear.id.au> (maintainer:PowerPC)
> >     qemu-ppc@nongnu.org (open list:PowerPC)
> >
> >     =3D hw/ppc/prep.c =3D
> >     "Herv=C3=A9 Poussineau" <hpoussin@reactos.org> (maintainer:PReP)
> >     David Gibson <david@gibson.dropbear.id.au> (maintainer:PowerPC)
> >     qemu-ppc@nongnu.org (open list:PReP)
>
> https://cdimage.debian.org/cdimage/archive/8.10.0/powerpc/iso-cd/
>
> qemu-system-ppc -M prep -cdrom debian-LennyBeta2-powerpc-netinst.iso -nog=
raphic
>
> >     =3D hw/ppc/sam460ex.c =3D
> >     BALATON Zoltan <balaton@eik.bme.hu> (maintainer:sam460ex)
> >     David Gibson <david@gibson.dropbear.id.au> (maintainer:PowerPC)
> >     qemu-ppc@nongnu.org (open list:sam460ex)
>
> images:
> http://aros.sourceforge.net/nightly1.php
>
> >     =3D hw/ppc/virtex_ml507.c =3D
> >     "Edgar E. Iglesias" <edgar.iglesias@gmail.com> (odd fixer:virtex_ml=
507)
> >     David Gibson <david@gibson.dropbear.id.au> (maintainer:PowerPC)
> >     qemu-ppc@nongnu.org (open list:virtex_ml507)
> >
> >     =3D hw/s390x/s390-virtio-ccw.c =3D
> >     Cornelia Huck <cohuck@redhat.com> (supporter:S390 Virtio-ccw)
> >     Halil Pasic <pasic@linux.ibm.com> (supporter:S390 Virtio-ccw)
> >     Christian Borntraeger <borntraeger@de.ibm.com> (supporter:S390 Virt=
io-ccw)
> >     Richard Henderson <rth@twiddle.net> (maintainer:S390)
> >     David Hildenbrand <david@redhat.com> (maintainer:S390)
> >     qemu-s390x@nongnu.org (open list:S390 Virtio-ccw)
> >
> >     =3D hw/sh4/r2d.c =3D
> >     Magnus Damm <magnus.damm@gmail.com> (maintainer:R2D)
> >     Aurelien Jarno <aurelien@aurel32.net> (odd fixer:SH4)
>
> https://people.debian.org/~aurel32/qemu/sh4/
> see also "acceptance: Add test_sh4_r2d in BootLinuxConsole":
> https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg02748.html
>
> >     =3D hw/sparc/leon3.c =3D
> >     Fabien Chouteau <chouteau@adacore.com> (maintainer:Leon3)
> >     Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> (maintainer:SPARC)
> >     Artyom Tarasenko <atar4qemu@gmail.com> (maintainer:SPARC)
>
> built uboot + uImage
> http://www.gaisler.com/anonftp/u-boot/examples/grxc3s1500/
>
> how to build more recent:
> https://vlsiwiki.soe.ucsc.edu/index.php/MASC/uCLinux_On_LEON3
>
> >     =3D hw/sparc/sun4m.c =3D
> >     Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> (maintainer:Sun4m)
> >     Artyom Tarasenko <atar4qemu@gmail.com> (maintainer:SPARC)
>
> https://people.debian.org/~aurel32/qemu/sparc/
>
> >
> >     =3D hw/sparc64/niagara.c =3D
> >     Artyom Tarasenko <atar4qemu@gmail.com> (maintainer:Sun4v)
> >     Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> (maintainer:SPARC)
> >
> >     =3D hw/sparc64/sun4u.c =3D
> >     Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> (maintainer:Sun4u)
> >     Artyom Tarasenko <atar4qemu@gmail.com> (maintainer:SPARC)
> >
> >     =3D hw/tricore/tricore_testboard.c =3D
> >     Bastian Koppelmann <kbastian@mail.uni-paderborn.de> (maintainer:Tri=
Core)
> >
> >     =3D hw/unicore32/puv3.c =3D
> >     Guan Xuetao <gxt@mprc.pku.edu.cn> (maintainer:UniCore32)
> >
> >     =3D hw/xtensa/sim.c =3D
> >     Max Filippov <jcmvbkbc@gmail.com> (maintainer:sim)
> >
> >     =3D hw/xtensa/xtfpga.c =3D
> >     Max Filippov <jcmvbkbc@gmail.com> (maintainer:XTFPGA (LX60, LX2...)
>
> build Zephyr from source:
> http://docs.zephyrproject.org/boards/xtensa/qemu_xtensa/doc/board.html
>
> qemu-system-xtensa -M dc232b -m 128M -semihosting -nographic -monitor
> null -kernel Image.elf
>
> >
> > Machines with no maintainer, but at least one supporter:
> >
> >     =3D hw/ppc/spapr.c =3D
> >     David Gibson <david@gibson.dropbear.id.au> (supporter:sPAPR)
> >     qemu-ppc@nongnu.org (open list:sPAPR)
> >
> >     =3D hw/riscv/sifive_e.c =3D
> >     Palmer Dabbelt <palmer@sifive.com> (supporter:RISC-V)
> >     Alistair Francis <Alistair.Francis@wdc.com> (supporter:RISC-V)
> >     Sagar Karandikar <sagark@eecs.berkeley.edu> (supporter:RISC-V)
> >     Bastian Koppelmann <kbastian@mail.uni-paderborn.de> (supporter:RISC=
-V)
> >     qemu-riscv@nongnu.org (open list:RISC-V)
> >
> >     =3D hw/riscv/sifive_u.c =3D
> >     Palmer Dabbelt <palmer@sifive.com> (supporter:RISC-V)
> >     Alistair Francis <Alistair.Francis@wdc.com> (supporter:RISC-V)
> >     Sagar Karandikar <sagark@eecs.berkeley.edu> (supporter:RISC-V)
> >     Bastian Koppelmann <kbastian@mail.uni-paderborn.de> (supporter:RISC=
-V)
> >     qemu-riscv@nongnu.org (open list:RISC-V)
> >
> >     =3D hw/riscv/spike.c =3D
> >     Palmer Dabbelt <palmer@sifive.com> (supporter:RISC-V)
> >     Alistair Francis <Alistair.Francis@wdc.com> (supporter:RISC-V)
> >     Sagar Karandikar <sagark@eecs.berkeley.edu> (supporter:RISC-V)
> >     Bastian Koppelmann <kbastian@mail.uni-paderborn.de> (supporter:RISC=
-V)
> >     qemu-riscv@nongnu.org (open list:RISC-V)
> >
> >     =3D hw/riscv/virt.c =3D
> >     Palmer Dabbelt <palmer@sifive.com> (supporter:RISC-V)
> >     Alistair Francis <Alistair.Francis@wdc.com> (supporter:RISC-V)
> >     Sagar Karandikar <sagark@eecs.berkeley.edu> (supporter:RISC-V)
> >     Bastian Koppelmann <kbastian@mail.uni-paderborn.de> (supporter:RISC=
-V)
> >     qemu-riscv@nongnu.org (open list:RISC-V)
> >
> >     =3D hw/xenpv/xen_machine_pv.c =3D
> >     Stefano Stabellini <sstabellini@kernel.org> (supporter:X86)
> >     Anthony Perard <anthony.perard@citrix.com> (supporter:X86)
> >     Paul Durrant <paul.durrant@citrix.com> (supporter:X86)
> >     xen-devel@lists.xenproject.org (open list:X86)
> >
> > Machines with no maintainer and no supporter:
> >
> >     =3D hw/arm/collie.c =3D
> >     Peter Maydell <peter.maydell@linaro.org> (odd fixer:Sharp SL-5500 (=
Co...)
> >     qemu-arm@nongnu.org (open list:Sharp SL-5500 (Co...)
> >
> >     =3D hw/arm/cubieboard.c =3D
> >     Beniamino Galvani <b.galvani@gmail.com> (odd fixer:Allwinner-a10)
> >     Peter Maydell <peter.maydell@linaro.org> (odd fixer:Allwinner-a10)
> >     qemu-arm@nongnu.org (open list:Allwinner-a10)
>
> https://romanrm.net/a10/qemu
> https://kashyapc.fedorapeople.org/arm/installing-Fedora-21-on-microSD-car=
d-for-Cubietruck.txt
>
> >     =3D hw/arm/digic_boards.c =3D
> >     Antony Pavlov <antonynpavlov@gmail.com> (odd fixer:Canon DIGIC)
> >     Peter Maydell <peter.maydell@linaro.org> (odd fixer:Canon DIGIC)
> >     qemu-arm@nongnu.org (open list:Canon DIGIC)
>
> canon-a1100-rom1.bin
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg571908.html
>
> >     =3D hw/arm/exynos4_boards.c =3D
> >     Igor Mitsyanko <i.mitsyanko@gmail.com> (odd fixer:Exynos)
> >     Peter Maydell <peter.maydell@linaro.org> (odd fixer:Exynos)
> >     qemu-arm@nongnu.org (open list:Exynos)
> >
> >     =3D hw/arm/gumstix.c =3D
> >     Peter Maydell <peter.maydell@linaro.org> (odd fixer:Gumstix)
> >     "Philippe Mathieu-Daud=C3=A9" <f4bug@amsat.org> (reviewer:Gumstix)
> >     qemu-arm@nongnu.org (open list:Gumstix)
>
> dd of=3Dcflash.img bs=3D128k count=3D128 if=3D/dev/zerodd of=3Dcflash.img
> bs=3D128k conv=3Dnotrunc if=3D/Downloads/u-boot-verdex-400-r1604.bin
> dd of=3Dcflash.img bs=3D128k conv=3Dnotrunc seek=3D2
> if=3DDownloads/Angstrom-gumstix-basic-image-glibc-ipk-2007.9-test-2008051=
2-gumstix-custom-connex.rootfs.jffs2
> dd of=3Dcflash.img bs=3D128k conv=3Dnotrunc seek=3D120
> if=3DDownloads/uImage-2.6.21-r1-gumstix-custom-connex.bin
> qemu-system-arm -M connex -nographic -drive
> if=3Dsd,cache=3Dunsafe,file=3Dcflash.img -pflash cflash.img
>
> >
> >     =3D hw/arm/highbank.c =3D
> >     Rob Herring <robh@kernel.org> (odd fixer:Calxeda Highbank)
> >     Peter Maydell <peter.maydell@linaro.org> (odd fixer:Calxeda Highban=
k)
> >     qemu-arm@nongnu.org (open list:Calxeda Highbank)
>
> vmlinuz from those links
> https://wiki.edubuntu.org/ARM/Server/Install/Calxeda
> https://en.opensuse.org/HCL:Highbank
> https://wiki.linaro.org/LEG/Engineering/Virtualization/Platform_Device_Pa=
ssthrough_on_Midway
>
> >
> >     =3D hw/arm/imx25_pdk.c =3D
> >     Peter Maydell <peter.maydell@linaro.org> (odd fixer:i.MX25 PDK)
> >     Jean-Christophe Dubois <jcd@tribudubois.net> (reviewer:i.MX25 PDK)
> >     qemu-arm@nongnu.org (open list:i.MX25 PDK)
> >
> >     =3D hw/arm/kzm.c =3D
> >     Peter Chubb <peter.chubb@nicta.com.au> (odd fixer:i.MX31 (kzm))
> >     Peter Maydell <peter.maydell@linaro.org> (odd fixer:i.MX31 (kzm))
> >     qemu-arm@nongnu.org (open list:i.MX31 (kzm))
> >
> >     =3D hw/arm/mainstone.c =3D
> >     Andrzej Zaborowski <balrogg@gmail.com> (odd fixer:PXA2XX)
> >     Peter Maydell <peter.maydell@linaro.org> (odd fixer:PXA2XX)
> >     qemu-arm@nongnu.org (open list:PXA2XX)
> >
> >     =3D hw/arm/mcimx6ul-evk.c =3D
> >     Peter Maydell <peter.maydell@linaro.org> (odd fixer:MCIMX6UL EVK / =
i....)
> >     Jean-Christophe Dubois <jcd@tribudubois.net> (reviewer:MCIMX6UL EVK=
 / i....)
> >     qemu-arm@nongnu.org (open list:MCIMX6UL EVK / i....)
> >
> >     =3D hw/arm/mcimx7d-sabre.c =3D
> >     Peter Maydell <peter.maydell@linaro.org> (odd fixer:MCIMX7D SABRE /=
 i...)
> >     Andrey Smirnov <andrew.smirnov@gmail.com> (reviewer:MCIMX7D SABRE /=
 i...)
> >     qemu-arm@nongnu.org (open list:MCIMX7D SABRE / i...)
> >
> >     =3D hw/arm/musicpal.c =3D
> >     Jan Kiszka <jan.kiszka@web.de> (odd fixer:Musicpal)
> >     Peter Maydell <peter.maydell@linaro.org> (odd fixer:Musicpal)
> >     qemu-arm@nongnu.org (open list:Musicpal)
> >
> >     =3D hw/arm/nseries.c =3D
> >     Andrzej Zaborowski <balrogg@gmail.com> (odd fixer:nSeries)
> >     Peter Maydell <peter.maydell@linaro.org> (odd fixer:nSeries)
> >     qemu-arm@nongnu.org (open list:nSeries)
>
> images:
> http://stskeeps.subnetmask.net/meego-n8x0/
>
> $ qemu-system-arm -M n810 -kernel
> meego-arm-n8x0-1.0.80.20100712.1431-vmlinuz-2.6.35~rc4-129.1-n8x0
> -append "root=3D/dev/mmcblk0p1 console=3DttyS0 printk.time=3D0 rootwait" =
-m
> 130 -sd meego-arm-n8x0-1.0.80.20100712.1431-sda.raw -serial stdio
>
> >     =3D hw/arm/palm.c =3D
> >     Andrzej Zaborowski <balrogg@gmail.com> (odd fixer:Palm)
> >     Peter Maydell <peter.maydell@linaro.org> (odd fixer:Palm)
> >     qemu-arm@nongnu.org (open list:Palm)
> >
> >     =3D hw/arm/raspi.c =3D
> >     Peter Maydell <peter.maydell@linaro.org> (odd fixer:Raspberry Pi)
> >     Andrew Baumann <Andrew.Baumann@microsoft.com> (reviewer:Raspberry P=
i)
> >     "Philippe Mathieu-Daud=C3=A9" <f4bug@amsat.org> (reviewer:Raspberry=
 Pi)
> >     qemu-arm@nongnu.org (open list:Raspberry Pi)
>
> Quick Boot Linux uart test:
> https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg04308.html
>
> >
> >     =3D hw/arm/sabrelite.c =3D
> >     Peter Maydell <peter.maydell@linaro.org> (odd fixer:SABRELITE / i.M=
X6)
> >     Jean-Christophe Dubois <jcd@tribudubois.net> (reviewer:SABRELITE / =
i.MX6)
> >     qemu-arm@nongnu.org (open list:SABRELITE / i.MX6)
> >
> >     =3D hw/arm/spitz.c =3D
> >     Andrzej Zaborowski <balrogg@gmail.com> (odd fixer:PXA2XX)
> >     Peter Maydell <peter.maydell@linaro.org> (odd fixer:PXA2XX)
> >     qemu-arm@nongnu.org (open list:PXA2XX)
> >
> >     =3D hw/arm/tosa.c =3D
> >     Andrzej Zaborowski <balrogg@gmail.com> (odd fixer:PXA2XX)
> >     Peter Maydell <peter.maydell@linaro.org> (odd fixer:PXA2XX)
> >     qemu-arm@nongnu.org (open list:PXA2XX)
> >
> >     =3D hw/arm/z2.c =3D
> >     Andrzej Zaborowski <balrogg@gmail.com> (odd fixer:PXA2XX)
> >     Peter Maydell <peter.maydell@linaro.org> (odd fixer:PXA2XX)
> >     qemu-arm@nongnu.org (open list:PXA2XX)
> >
> >     =3D hw/m68k/an5206.c =3D
> >     Thomas Huth <huth@tuxfamily.org> (odd fixer:an5206)
> >
> >     =3D hw/m68k/mcf5208.c =3D
> >     Thomas Huth <huth@tuxfamily.org> (odd fixer:mcf5208)
> >
> >     =3D hw/ppc/e500plat.c =3D
> >     David Gibson <david@gibson.dropbear.id.au> (odd fixer:e500)
> >     qemu-ppc@nongnu.org (open list:e500)
> >
> >     =3D hw/ppc/mac_newworld.c =3D
> >     Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> (odd fixer:New Wor=
ld (mac99))
> >     David Gibson <david@gibson.dropbear.id.au> (reviewer:New World (mac=
99))
> >     qemu-ppc@nongnu.org (open list:New World (mac99))
> >
> >     =3D hw/ppc/mac_oldworld.c =3D
> >     Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> (odd fixer:Old Wor=
ld (g3beige))
> >     David Gibson <david@gibson.dropbear.id.au> (reviewer:Old World (g3b=
eige))
> >     qemu-ppc@nongnu.org (open list:Old World (g3beige))
> >
> >     =3D hw/ppc/mpc8544ds.c =3D
> >     David Gibson <david@gibson.dropbear.id.au> (odd fixer:mpc8544ds)
> >     qemu-ppc@nongnu.org (open list:mpc8544ds)
> >
> >     =3D hw/ppc/ppc405_boards.c =3D
> >     David Gibson <david@gibson.dropbear.id.au> (odd fixer:ppc4xx)
> >     qemu-ppc@nongnu.org (open list:ppc4xx)
> >
> >     =3D hw/ppc/ppc440_bamboo.c =3D
> >     David Gibson <david@gibson.dropbear.id.au> (odd fixer:ppc4xx)
> >     qemu-ppc@nongnu.org (open list:ppc4xx)
> >
> >     =3D hw/sh4/shix.c =3D
> >     Magnus Damm <magnus.damm@gmail.com> (odd fixer:Shix)
> >     Aurelien Jarno <aurelien@aurel32.net> (odd fixer:SH4)
> >
> >
> > [*] Subject: QEMU Summit 2018 minutes
> > Message-ID: <CAFEAcA8WWmwjY+derXd-yM=3D=3DQmPtP7C3TN3pC0TCTPwVFdhZNA@ma=
il.gmail.com>
> > https://lists.nongnu.org/archive/html/qemu-devel/2018-11/msg03367.html

