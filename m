Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E8C3C4CECD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 02:47:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC4F320665
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 02:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="LL53jMki"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC4F320665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iA3Wx-0000W7-Rd
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 22:47:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44672)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iA3VN-0007kz-5H
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 22:46:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iA3VK-00018J-MH
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 22:46:13 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:36521)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iA3V9-0000lU-S7; Mon, 16 Sep 2019 22:46:03 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46XSCg4FLZz9sNf; Tue, 17 Sep 2019 12:45:51 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1568688351;
 bh=m/Hi4Jjghm9AqWfIlbwkRzVQo+RODhJ9UkGWglJnJ8w=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=LL53jMkienWUrjhRAxy7/RxQE/SFbWsHLf1ZW6qTPCzznaOQFElfjVHwp1fy9BtWd
 qPA9r5rhaP9IaUQvAlzZya/zONC5TZFQkFIvNfKzKw61mg4gDasu/dDw8HkacLMyOu
 1nYA6mmRcmdppSdpjiWPPD3kAcwBeXhm1ZGGKf6o=
Date: Tue, 17 Sep 2019 12:25:10 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Message-ID: <20190917022510.GD8842@umbus.fritz.box>
References: <20190916154847.28936-1-philmd@redhat.com>
 <20190916154847.28936-5-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="UoPmpPX/dBe4BELn"
Content-Disposition: inline
In-Reply-To: <20190916154847.28936-5-philmd@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH 04/13] hw: Move M48T59 device from
 hw/timer/ to hw/rtc/ subdirectory
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, Helge Deller <deller@gmx.de>,
 =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Andrew Jeffery <andrew@aj.id.au>, qemu-ppc@nongnu.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--UoPmpPX/dBe4BELn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 16, 2019 at 05:48:38PM +0200, Philippe Mathieu-Daud=E9 wrote:
> The M48T59 is a Real Time Clock, not a timer.
> Move it under the hw/rtc/ subdirectory.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
>  MAINTAINERS                         |  4 +-
>  hw/ppc/ppc405_boards.c              |  2 +-
>  hw/ppc/prep.c                       |  2 +-
>  hw/rtc/Kconfig                      |  3 ++
>  hw/rtc/Makefile.objs                |  4 ++
>  hw/{timer =3D> rtc}/m48t59-internal.h |  0
>  hw/{timer =3D> rtc}/m48t59-isa.c      |  4 +-
>  hw/{timer =3D> rtc}/m48t59.c          |  2 +-
>  hw/sparc/sun4m.c                    |  2 +-
>  hw/sparc64/sun4u.c                  |  2 +-
>  hw/timer/Kconfig                    |  3 --
>  hw/timer/Makefile.objs              |  4 --
>  include/hw/rtc/m48t59.h             | 57 +++++++++++++++++++++++++++++

Uh.. this file seems to be coming out of nowhere, which doesn't seem
right for a code motion.

>  13 files changed, 73 insertions(+), 16 deletions(-)
>  rename hw/{timer =3D> rtc}/m48t59-internal.h (100%)
>  rename hw/{timer =3D> rtc}/m48t59-isa.c (98%)
>  rename hw/{timer =3D> rtc}/m48t59.c (99%)
>  create mode 100644 include/hw/rtc/m48t59.h
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 481f2318cb..679b026fe0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1064,9 +1064,9 @@ F: hw/pci-host/prep.[hc]
>  F: hw/isa/i82378.c
>  F: hw/isa/pc87312.c
>  F: hw/dma/i82374.c
> -F: hw/timer/m48t59-isa.c
> +F: hw/rtc/m48t59-isa.c
>  F: include/hw/isa/pc87312.h
> -F: include/hw/timer/m48t59.h
> +F: include/hw/rtc/m48t59.h
>  F: pc-bios/ppc_rom.bin
> =20
>  sPAPR
> diff --git a/hw/ppc/ppc405_boards.c b/hw/ppc/ppc405_boards.c
> index 388cae0b43..1f721feed6 100644
> --- a/hw/ppc/ppc405_boards.c
> +++ b/hw/ppc/ppc405_boards.c
> @@ -29,7 +29,7 @@
>  #include "cpu.h"
>  #include "hw/ppc/ppc.h"
>  #include "ppc405.h"
> -#include "hw/timer/m48t59.h"
> +#include "hw/rtc/m48t59.h"
>  #include "hw/block/flash.h"
>  #include "sysemu/sysemu.h"
>  #include "sysemu/qtest.h"
> diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
> index 3a51536e1a..862345c2ac 100644
> --- a/hw/ppc/prep.c
> +++ b/hw/ppc/prep.c
> @@ -25,7 +25,7 @@
> =20
>  #include "qemu/osdep.h"
>  #include "cpu.h"
> -#include "hw/timer/m48t59.h"
> +#include "hw/rtc/m48t59.h"
>  #include "hw/char/serial.h"
>  #include "hw/block/fdc.h"
>  #include "net/net.h"
> diff --git a/hw/rtc/Kconfig b/hw/rtc/Kconfig
> index 7ffd702268..159c233517 100644
> --- a/hw/rtc/Kconfig
> +++ b/hw/rtc/Kconfig
> @@ -1,3 +1,6 @@
> +config M48T59
> +    bool
> +
>  config PL031
>      bool
> =20
> diff --git a/hw/rtc/Makefile.objs b/hw/rtc/Makefile.objs
> index 3cac0d5a63..c87f81405e 100644
> --- a/hw/rtc/Makefile.objs
> +++ b/hw/rtc/Makefile.objs
> @@ -1,2 +1,6 @@
> +common-obj-$(CONFIG_M48T59) +=3D m48t59.o
> +ifeq ($(CONFIG_ISA_BUS),y)
> +common-obj-$(CONFIG_M48T59) +=3D m48t59-isa.o
> +endif
>  common-obj-$(CONFIG_PL031) +=3D pl031.o
>  obj-$(CONFIG_MC146818RTC) +=3D mc146818rtc.o
> diff --git a/hw/timer/m48t59-internal.h b/hw/rtc/m48t59-internal.h
> similarity index 100%
> rename from hw/timer/m48t59-internal.h
> rename to hw/rtc/m48t59-internal.h
> diff --git a/hw/timer/m48t59-isa.c b/hw/rtc/m48t59-isa.c
> similarity index 98%
> rename from hw/timer/m48t59-isa.c
> rename to hw/rtc/m48t59-isa.c
> index 5e5432abfd..7fde854c0f 100644
> --- a/hw/timer/m48t59-isa.c
> +++ b/hw/rtc/m48t59-isa.c
> @@ -1,5 +1,5 @@
>  /*
> - * QEMU M48T59 and M48T08 NVRAM emulation (ISA bus interface
> + * QEMU M48T59 and M48T08 NVRAM emulation (ISA bus interface)
>   *
>   * Copyright (c) 2003-2005, 2007 Jocelyn Mayer
>   * Copyright (c) 2013 Herv=E9 Poussineau
> @@ -26,7 +26,7 @@
>  #include "qemu/osdep.h"
>  #include "hw/isa/isa.h"
>  #include "hw/qdev-properties.h"
> -#include "hw/timer/m48t59.h"
> +#include "hw/rtc/m48t59.h"
>  #include "m48t59-internal.h"
>  #include "qemu/module.h"
> =20
> diff --git a/hw/timer/m48t59.c b/hw/rtc/m48t59.c
> similarity index 99%
> rename from hw/timer/m48t59.c
> rename to hw/rtc/m48t59.c
> index a9fc2f981a..fc592b9fb1 100644
> --- a/hw/timer/m48t59.c
> +++ b/hw/rtc/m48t59.c
> @@ -27,7 +27,7 @@
>  #include "qemu-common.h"
>  #include "hw/irq.h"
>  #include "hw/qdev-properties.h"
> -#include "hw/timer/m48t59.h"
> +#include "hw/rtc/m48t59.h"
>  #include "qemu/timer.h"
>  #include "sysemu/runstate.h"
>  #include "sysemu/sysemu.h"
> diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
> index 6c5a17a020..2aaa5bf1ae 100644
> --- a/hw/sparc/sun4m.c
> +++ b/hw/sparc/sun4m.c
> @@ -31,7 +31,7 @@
>  #include "qemu/error-report.h"
>  #include "qemu/timer.h"
>  #include "hw/sparc/sun4m_iommu.h"
> -#include "hw/timer/m48t59.h"
> +#include "hw/rtc/m48t59.h"
>  #include "migration/vmstate.h"
>  #include "hw/sparc/sparc32_dma.h"
>  #include "hw/block/fdc.h"
> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
> index 1ded2a4c9a..955082773b 100644
> --- a/hw/sparc64/sun4u.c
> +++ b/hw/sparc64/sun4u.c
> @@ -36,7 +36,7 @@
>  #include "hw/pci-host/sabre.h"
>  #include "hw/char/serial.h"
>  #include "hw/char/parallel.h"
> -#include "hw/timer/m48t59.h"
> +#include "hw/rtc/m48t59.h"
>  #include "migration/vmstate.h"
>  #include "hw/input/i8042.h"
>  #include "hw/block/fdc.h"
> diff --git a/hw/timer/Kconfig b/hw/timer/Kconfig
> index af415c8ef8..a57e9b59fc 100644
> --- a/hw/timer/Kconfig
> +++ b/hw/timer/Kconfig
> @@ -24,9 +24,6 @@ config M41T80
>      bool
>      depends on I2C
> =20
> -config M48T59
> -    bool
> -
>  config TWL92230
>      bool
>      depends on I2C
> diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
> index b0159189cf..fe2d1fbc40 100644
> --- a/hw/timer/Makefile.objs
> +++ b/hw/timer/Makefile.objs
> @@ -7,10 +7,6 @@ common-obj-$(CONFIG_DS1338) +=3D ds1338.o
>  common-obj-$(CONFIG_HPET) +=3D hpet.o
>  common-obj-$(CONFIG_I8254) +=3D i8254_common.o i8254.o
>  common-obj-$(CONFIG_M41T80) +=3D m41t80.o
> -common-obj-$(CONFIG_M48T59) +=3D m48t59.o
> -ifeq ($(CONFIG_ISA_BUS),y)
> -common-obj-$(CONFIG_M48T59) +=3D m48t59-isa.o
> -endif
>  common-obj-$(CONFIG_PUV3) +=3D puv3_ost.o
>  common-obj-$(CONFIG_TWL92230) +=3D twl92230.o
>  common-obj-$(CONFIG_XILINX) +=3D xilinx_timer.o
> diff --git a/include/hw/rtc/m48t59.h b/include/hw/rtc/m48t59.h
> new file mode 100644
> index 0000000000..e7ea4e8761
> --- /dev/null
> +++ b/include/hw/rtc/m48t59.h
> @@ -0,0 +1,57 @@
> +/*
> + * QEMU M48T59 and M48T08 NVRAM emulation
> + *
> + * Copyright (c) 2003-2005, 2007 Jocelyn Mayer
> + * Copyright (c) 2013 Herv=E9 Poussineau
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
> + * of this software and associated documentation files (the "Software"),=
 to deal
> + * in the Software without restriction, including without limitation the=
 rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
> + * THE SOFTWARE.
> + */
> +
> +#ifndef HW_RTC_M48T59_H
> +#define HW_RTC_M48T59_H
> +
> +#include "exec/hwaddr.h"
> +#include "qom/object.h"
> +
> +#define TYPE_NVRAM "nvram"
> +
> +#define NVRAM_CLASS(klass) \
> +    OBJECT_CLASS_CHECK(NvramClass, (klass), TYPE_NVRAM)
> +#define NVRAM_GET_CLASS(obj) \
> +    OBJECT_GET_CLASS(NvramClass, (obj), TYPE_NVRAM)
> +#define NVRAM(obj) \
> +    INTERFACE_CHECK(Nvram, (obj), TYPE_NVRAM)
> +
> +typedef struct Nvram Nvram;
> +
> +typedef struct NvramClass {
> +    InterfaceClass parent;
> +
> +    uint32_t (*read)(Nvram *obj, uint32_t addr);
> +    void (*write)(Nvram *obj, uint32_t addr, uint32_t val);
> +    void (*toggle_lock)(Nvram *obj, int lock);
> +} NvramClass;
> +
> +Nvram *m48t59_init_isa(ISABus *bus, uint32_t io_base, uint16_t size,
> +                       int base_year, int type);
> +Nvram *m48t59_init(qemu_irq IRQ, hwaddr mem_base,
> +                   uint32_t io_base, uint16_t size, int base_year,
> +                   int type);
> +
> +#endif /* HW_M48T59_H */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--UoPmpPX/dBe4BELn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2ARAYACgkQbDjKyiDZ
s5KlVhAAk/e2HfMzKjc/NuIkKSEjYm4fLFRUH+NeEeKAyvzcwLJMeW715Txcuxze
3RJkiXNfdUHtoLhZm4DreLPqOFih04y32flyHvS36d9Ch1iOroha9zgK1kGEjvxV
Jw2d+f9penhSOjNjg+16Udh/83PXUCiVSZeM1zSoGMX7bHYgfcfEDnddLjOxSEt8
7HGdQOwBV2+RUF4s4EnH7X4rWDlbeDzOTt8TJKOKvzkbo7AZdYOokgT281okk9WT
JruArwM4X5cyEyf/Exlu5kkfBeSvq6MDoHQZYzFq+g+shJsd1A7r3y9Eu7S7iE/q
xiZt+eJ07E92PGYwKnkPOFAiFDXfdcQ5xyf5ejFArvisn9959UJsLzadVX/Q7rd0
MDfreSiiRAo9NFea3E8+qfHYNJAjL/tVpPf2Qqe/GD4cfH7Up7Z/HS7FpqX5KzZl
liSvlhbN/Iuwdi+vdlfhB/V6cBijvxbLgBQQoQyKDrAM5t0p9g5J2DeWKbW2f3kG
ze588W+yOc5kt4RXfV+5kU3bCEky2Zw/It3VF/tElTb8R6memKmWTtH0x9m0CLjn
aNCEYV0aoJ82i3HUqNoHYUto0XMMe5AdoT2KQgxsZ1kYK5javcR/x8gsBJM+eewh
GNz2XzEebWQXUxAlvoAm+LQ/fDaFkODvUWwSBOn7I7vCNx2igvI=
=SQNh
-----END PGP SIGNATURE-----

--UoPmpPX/dBe4BELn--

