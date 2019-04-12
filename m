Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B17FC10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 15:09:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 194C62083E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 15:09:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 194C62083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38494 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hExoN-0007Au-8B
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 11:09:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmathieu@redhat.com>) id 1hExm9-0005tp-Ky
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 11:07:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmathieu@redhat.com>) id 1hExm8-0007tD-Jd
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 11:07:33 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36215)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pmathieu@redhat.com>) id 1hExm8-0007iv-Ad
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 11:07:32 -0400
Received: by mail-wr1-f66.google.com with SMTP id y13so12430033wrd.3
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 08:07:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=/vkyFqCf6pk+dloRPciwSf/AZJ0gqm77Med35Xdj4Y4=;
	b=GNxjhGOPbo8FYXlo6Xr3GaOwbEyOmmeVDqB6rLljJb8piGOUFS4JIHhbtzsBNM9aSN
	kocqrhRe1e7Yiv7ufoAu81DL5s8vPmAs2YQqjhojuoASIzoYxheuD8AlNajmZz7JMnjM
	lVENPAD9OsVFfn8Ak89tAwsbtb/vhx3GeoqFUh3k6jhrHlcHDjsw+O56RL5KdnTvA2Dz
	4TcFkoqpmhM+tuKoq+y22kMeDgG1st2z4kh8ysoCZuBc9WrV4+OU+01nEkG7EiI0MHAa
	m3YpVagnxYGlPijWbZ/xJpl1ZxhMr7tVWFseJJZrCSWUBrKettms0q74aCkFiW79VUHp
	3pcQ==
X-Gm-Message-State: APjAAAW0eVSx8DvvCPSbkJ6lmXnzDsEumxtKoU6OPhnUam8jGLpkEZJB
	W6lRMNmNBVN5TZ/HyP9QJPMS/0G0OKsY+plJMh7Z9w==
X-Google-Smtp-Source: APXvYqzt8ypblr8oxAEKVUdplGLlsd7v64wK8OEIIakW0AievFU8UlsedhehDASHgCiLXPaINxWgb5ARHHLYsFjFQAE=
X-Received: by 2002:adf:ec0a:: with SMTP id x10mr36027855wrn.193.1555081618442;
	Fri, 12 Apr 2019 08:06:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190317002259.25994-1-philmd@redhat.com>
	<20190317002259.25994-5-philmd@redhat.com>
	<20190319152830.4e7771be@redhat.com>
	<536060c6-8243-f157-7f83-74eb04517032@redhat.com>
In-Reply-To: <536060c6-8243-f157-7f83-74eb04517032@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Fri, 12 Apr 2019 17:06:46 +0200
Message-ID:
 <CAP+75-VOVo-fR+7dfeAYJZcjyxt=Wjw9sTAG0DBxTEbA+e4NjA@mail.gmail.com>
To: Igor Mammedov <imammedo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH 4/8] hw/isa/southbridge: Rename
 ACPI_X86_ICH to ACPI_ICH9
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
Cc: Paul Burton <pburton@wavecomp.com>, Thomas Huth <thuth@redhat.com>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Aleksandar Rikalo <arikalo@wavecomp.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Eduardo Habkost <ehabkost@redhat.com>,
	Aurelien Jarno <aurelien@aurel32.net>, Paolo Bonzini <pbonzini@redhat.com>,
	Guan Xuetao <gxt@mprc.pku.edu.cn>, Artyom Tarasenko <atar4qemu@gmail.com>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412150646.5pb_gDyq0jPTH6nf8Ue4oS5o8v0sxyET9DeiRr0UVgs@z>

Hi Igor,

On Fri, Apr 12, 2019 at 5:03 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
> On 3/19/19 3:28 PM, Igor Mammedov wrote:
> > On Sun, 17 Mar 2019 01:22:55 +0100
> > Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
> >
> >> The ICH9 chipset is a generic southbridge and can be used by
> >> non-X86 hardware. Rename it to make this more obvious.
> > Is it actually used by anything else in QEMU beside Q35 board?
>
> Yes, the MIPS Boston board (hw/mips/boston.c:520):
>
>     ahci =3D
> pci_create_simple_multifunction(&PCI_BRIDGE(&pcie2->root)->sec_bus,
>                                            PCI_DEVFN(0, 0),
>                                            true, TYPE_ICH9_AHCI);
>
> See:
>
> commit df1d8a1f29f567567b9d20be685a4241282e7005
> Author: Paul Burton <paul.burton@imgtec.com>
> Date:   Thu Sep 8 15:51:58 2016 +0100
>
>  hw/mips: MIPS Boston board support
>
>  Introduce support for emulating the MIPS Boston development board. The
>  Boston board is built around an FPGA & 3 PCIe controllers, one of which
>  is connected to an Intel EG20T Platform Controller Hub. It is used
>  during the development & debug of new CPUs and the software intended to
>  run on them, and is essentially the successor to the older MIPS Malta
>  board.
>
>  This patch does not implement the EG20T, instead connecting an already
>  supported ICH-9 AHCI controller. Whilst this isn't accurate it's enough
>  for typical stock Boston software (eg. Linux kernels) to work with hard
>  disks given that both the ICH-9 & EG20T implement the AHCI
>  specification.

Sorry I messed with the keyboard and sent this mail without finishing.

So my patch description was not enough, I'll add a paragraph about the
Boston board.

Thanks,

Phil.

> >>
> >> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> >> ---
> >>  hw/acpi/Kconfig       | 2 +-
> >>  hw/acpi/Makefile.objs | 2 +-
> >>  hw/i2c/Makefile.objs  | 2 +-
> >>  hw/isa/Kconfig        | 2 +-
> >>  4 files changed, 4 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/hw/acpi/Kconfig b/hw/acpi/Kconfig
> >> index eca3beed75..e24c895772 100644
> >> --- a/hw/acpi/Kconfig
> >> +++ b/hw/acpi/Kconfig
> >> @@ -8,7 +8,7 @@ config ACPI_X86
> >>      select ACPI_CPU_HOTPLUG
> >>      select ACPI_MEMORY_HOTPLUG
> >>
> >> -config ACPI_X86_ICH
> >> +config ACPI_ICH9
> >>      bool
> >>      select ACPI_X86
> >>
> >> diff --git a/hw/acpi/Makefile.objs b/hw/acpi/Makefile.objs
> >> index c86edfbed9..dff94d35e7 100644
> >> --- a/hw/acpi/Makefile.objs
> >> +++ b/hw/acpi/Makefile.objs
> >> @@ -1,5 +1,5 @@
> >>  common-obj-$(CONFIG_ACPI_X86) +=3D core.o piix4.o pcihp.o
> >> -common-obj-$(CONFIG_ACPI_X86_ICH) +=3D ich9.o tco.o
> >> +common-obj-$(CONFIG_ACPI_ICH9) +=3D ich9.o tco.o
> >>  common-obj-$(CONFIG_ACPI_CPU_HOTPLUG) +=3D cpu_hotplug.o
> >>  common-obj-$(CONFIG_ACPI_MEMORY_HOTPLUG) +=3D memory_hotplug.o
> >>  common-obj-$(CONFIG_ACPI_CPU_HOTPLUG) +=3D cpu.o
> >> diff --git a/hw/i2c/Makefile.objs b/hw/i2c/Makefile.objs
> >> index a98c786918..b632461513 100644
> >> --- a/hw/i2c/Makefile.objs
> >> +++ b/hw/i2c/Makefile.objs
> >> @@ -3,7 +3,7 @@ common-obj-$(CONFIG_SMBUS) +=3D smbus_slave.o smbus_ma=
ster.o
> >>  common-obj-$(CONFIG_SMBUS_EEPROM) +=3D smbus_eeprom.o
> >>  common-obj-$(CONFIG_DDC) +=3D i2c-ddc.o
> >>  common-obj-$(CONFIG_VERSATILE_I2C) +=3D versatile_i2c.o
> >> -common-obj-$(CONFIG_ACPI_X86_ICH) +=3D smbus_ich9.o
> >> +common-obj-$(CONFIG_ACPI_ICH9) +=3D smbus_ich9.o
> >>  common-obj-$(CONFIG_ACPI_SMBUS) +=3D pm_smbus.o
> >>  common-obj-$(CONFIG_BITBANG_I2C) +=3D bitbang_i2c.o
> >>  common-obj-$(CONFIG_EXYNOS4) +=3D exynos4210_i2c.o
> >> diff --git a/hw/isa/Kconfig b/hw/isa/Kconfig
> >> index 57e09a0cb8..19101d349f 100644
> >> --- a/hw/isa/Kconfig
> >> +++ b/hw/isa/Kconfig
> >> @@ -50,4 +50,4 @@ config LPC_ICH9
> >>      # for ICH9.
> >>      select ISA_BUS
> >>      select ACPI_SMBUS
> >> -    select ACPI_X86_ICH
> >> +    select ACPI_ICH9
> >

