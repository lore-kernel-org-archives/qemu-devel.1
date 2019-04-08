Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B1FC10F13
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 15:16:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 619632148E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 15:16:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 619632148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54661 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDW0f-0002Ln-LW
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 11:16:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hDVv9-0007Eg-IT
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 11:10:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hDVv8-0002T1-4h
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 11:10:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52102)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>)
	id 1hDVv4-0002R3-VQ; Mon, 08 Apr 2019 11:10:47 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A12D899DDE;
	Mon,  8 Apr 2019 15:10:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id CFB245D72F;
	Mon,  8 Apr 2019 15:10:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 559151138648; Mon,  8 Apr 2019 17:10:39 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
References: <20190204231815.29661-1-philmd@redhat.com>
	<20190204231815.29661-8-philmd@redhat.com>
Date: Mon, 08 Apr 2019 17:10:39 +0200
In-Reply-To: <20190204231815.29661-8-philmd@redhat.com> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Tue, 5 Feb 2019 00:18:11
	+0100")
Message-ID: <87tvf8mt1s.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Mon, 08 Apr 2019 15:10:46 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 07/11] hw/devices: Move TI touchscreen
 declarations into a new header
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
	qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
	Rob Herring <robh@kernel.org>, qemu-trivial@nongnu.org,
	Magnus Damm <magnus.damm@gmail.com>, Joel Stanley <joel@jms.id.au>,
	Richard Henderson <rth@twiddle.net>,
	Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org,
	Jan Kiszka <jan.kiszka@web.de>,
	=?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
	David Gibson <david@gibson.dropbear.id.au>,
	Igor Mitsyanko <i.mitsyanko@gmail.com>,
	Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
	Philippe =?utf-8?Q?Mathieu-?= =?utf-8?Q?Daud=C3=A9?= <f4bug@amsat.org>,
	Andrew Jeffery <andrew@aj.id.au>,
	Michael Walle <michael@walle.cc>, qemu-ppc@nongnu.org,
	Peter Chubb <peter.chubb@nicta.com.au>,
	Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408151039.t3jCADY7RW9iB7-j_6mBwIvMHG0UXIC-A-I1eZ2ZFqI@z>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> Since uWireSlave is only used in this new header, there is no
> need to expose it via "qemu/typedefs.h".
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  MAINTAINERS                |  2 ++
>  hw/arm/nseries.c           |  2 +-
>  hw/arm/palm.c              |  2 +-
>  hw/input/tsc2005.c         |  2 +-
>  hw/input/tsc210x.c         |  4 ++--
>  include/hw/arm/omap.h      |  6 +-----
>  include/hw/devices.h       | 15 ---------------
>  include/hw/input/tsc2xxx.h | 38 ++++++++++++++++++++++++++++++++++++++
>  include/qemu/typedefs.h    |  1 -
>  9 files changed, 46 insertions(+), 26 deletions(-)
>  create mode 100644 include/hw/input/tsc2xxx.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a38086f767..6b0b5ccb41 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -654,6 +654,7 @@ F: hw/input/tsc2005.c
>  F: hw/misc/cbus.c
>  F: hw/timer/twl92230.c
>  F: include/hw/display/blizzard.h
> +F: include/hw/input/tsc2xxx.h
>  F: include/hw/misc/cbus.h
>=20=20
>  Palm
> @@ -663,6 +664,7 @@ L: qemu-arm@nongnu.org
>  S: Odd Fixes
>  F: hw/arm/palm.c
>  F: hw/input/tsc210x.c
> +F: include/hw/input/tsc2xxx.h
>=20=20
>  Raspberry Pi
>  M: Peter Maydell <peter.maydell@linaro.org>
> diff --git a/hw/arm/nseries.c b/hw/arm/nseries.c
> index ac876b5878..5ac2ca0877 100644
> --- a/hw/arm/nseries.c
> +++ b/hw/arm/nseries.c
> @@ -30,8 +30,8 @@
>  #include "ui/console.h"
>  #include "hw/boards.h"
>  #include "hw/i2c/i2c.h"
> -#include "hw/devices.h"
>  #include "hw/display/blizzard.h"
> +#include "hw/input/tsc2xxx.h"
>  #include "hw/misc/cbus.h"
>  #include "hw/block/flash.h"
>  #include "hw/hw.h"
> diff --git a/hw/arm/palm.c b/hw/arm/palm.c
> index 285f43709d..139d27d1cc 100644
> --- a/hw/arm/palm.c
> +++ b/hw/arm/palm.c
> @@ -26,7 +26,7 @@
>  #include "hw/arm/omap.h"
>  #include "hw/boards.h"
>  #include "hw/arm/arm.h"
> -#include "hw/devices.h"
> +#include "hw/input/tsc2xxx.h"
>  #include "hw/loader.h"
>  #include "exec/address-spaces.h"
>  #include "cpu.h"
> diff --git a/hw/input/tsc2005.c b/hw/input/tsc2005.c
> index 2b9108a193..f82771e7a7 100644
> --- a/hw/input/tsc2005.c
> +++ b/hw/input/tsc2005.c
> @@ -23,7 +23,7 @@
>  #include "hw/hw.h"
>  #include "qemu/timer.h"
>  #include "ui/console.h"
> -#include "hw/devices.h"
> +#include "hw/input/tsc2xxx.h"
>  #include "trace.h"
>=20=20
>  #define TSC_CUT_RESOLUTION(value, p)	((value) >> (16 - (p ? 12 : 10)))
> diff --git a/hw/input/tsc210x.c b/hw/input/tsc210x.c
> index ded0db9351..542a9188be 100644
> --- a/hw/input/tsc210x.c
> +++ b/hw/input/tsc210x.c
> @@ -24,8 +24,8 @@
>  #include "audio/audio.h"
>  #include "qemu/timer.h"
>  #include "ui/console.h"
> -#include "hw/arm/omap.h"	/* For I2SCodec and uWireSlave */
> -#include "hw/devices.h"
> +#include "hw/arm/omap.h"            /* For I2SCodec */
> +#include "hw/input/tsc2xxx.h"
>=20=20
>  #define TSC_DATA_REGISTERS_PAGE		0x0
>  #define TSC_CONTROL_REGISTERS_PAGE	0x1
> diff --git a/include/hw/arm/omap.h b/include/hw/arm/omap.h
> index e7fbd340f3..9de867daa4 100644
> --- a/include/hw/arm/omap.h
> +++ b/include/hw/arm/omap.h
> @@ -20,6 +20,7 @@
>  #include "exec/memory.h"
>  # define hw_omap_h		"omap.h"
>  #include "hw/irq.h"
> +#include "hw/input/tsc2xxx.h"
>  #include "target/arm/cpu-qom.h"
>  #include "qemu/log.h"
>=20=20
> @@ -679,11 +680,6 @@ qemu_irq *omap_mpuio_in_get(struct omap_mpuio_s *s);
>  void omap_mpuio_out_set(struct omap_mpuio_s *s, int line, qemu_irq handl=
er);
>  void omap_mpuio_key(struct omap_mpuio_s *s, int row, int col, int down);
>=20=20
> -struct uWireSlave {
> -    uint16_t (*receive)(void *opaque);
> -    void (*send)(void *opaque, uint16_t data);
> -    void *opaque;
> -};
>  struct omap_uwire_s;
>  void omap_uwire_attach(struct omap_uwire_s *s,
>                  uWireSlave *slave, int chipselect);
> diff --git a/include/hw/devices.h b/include/hw/devices.h
> index 7a630da47f..ba9034050b 100644
> --- a/include/hw/devices.h
> +++ b/include/hw/devices.h
> @@ -4,7 +4,6 @@
>  /* Devices that have nowhere better to go.  */
>=20=20
>  #include "hw/hw.h"
> -#include "ui/console.h"
>=20=20
>  /* smc91c111.c */
>  void smc91c111_init(NICInfo *, uint32_t, qemu_irq);
> @@ -12,18 +11,4 @@ void smc91c111_init(NICInfo *, uint32_t, qemu_irq);
>  /* lan9118.c */
>  void lan9118_init(NICInfo *, uint32_t, qemu_irq);
>=20=20
> -/* tsc210x.c */
> -uWireSlave *tsc2102_init(qemu_irq pint);
> -uWireSlave *tsc2301_init(qemu_irq penirq, qemu_irq kbirq, qemu_irq dav);
> -I2SCodec *tsc210x_codec(uWireSlave *chip);
> -uint32_t tsc210x_txrx(void *opaque, uint32_t value, int len);
> -void tsc210x_set_transform(uWireSlave *chip,
> -                MouseTransformInfo *info);
> -void tsc210x_key_event(uWireSlave *chip, int key, int down);
> -
> -/* tsc2005.c */
> -void *tsc2005_init(qemu_irq pintdav);
> -uint32_t tsc2005_txrx(void *opaque, uint32_t value, int len);
> -void tsc2005_set_transform(void *opaque, MouseTransformInfo *info);
> -
>  #endif
> diff --git a/include/hw/input/tsc2xxx.h b/include/hw/input/tsc2xxx.h
> new file mode 100644
> index 0000000000..f23f00cde9
> --- /dev/null
> +++ b/include/hw/input/tsc2xxx.h
> @@ -0,0 +1,38 @@
> +/*
> + * TI touchscreen controller
> + *
> + * Copyright (c) 2006 Andrzej Zaborowski
> + * Copyright (C) 2008 Nokia Corporation
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#ifndef HW_INPUT_TSC2XXX_H
> +#define HW_INPUT_TSC2XXX_H
> +
> +/* TI 4/8-wire resistive touch screen converters */

This sounds like a more specific phrasing of "TI touchscreen controller"
above.  Do we need both, or could this one be merged into the one above?

> +
> +#include "hw/irq.h"
> +#include "ui/console.h"
> +
> +typedef struct uWireSlave {
> +    uint16_t (*receive)(void *opaque);
> +    void (*send)(void *opaque, uint16_t data);
> +    void *opaque;
> +} uWireSlave;
> +
> +/* tsc210x.c */
> +uWireSlave *tsc2102_init(qemu_irq pint);
> +uWireSlave *tsc2301_init(qemu_irq penirq, qemu_irq kbirq, qemu_irq dav);
> +I2SCodec *tsc210x_codec(uWireSlave *chip);
> +uint32_t tsc210x_txrx(void *opaque, uint32_t value, int len);
> +void tsc210x_set_transform(uWireSlave *chip, MouseTransformInfo *info);
> +void tsc210x_key_event(uWireSlave *chip, int key, int down);
> +
> +/* tsc2005.c */
> +void *tsc2005_init(qemu_irq pintdav);
> +uint32_t tsc2005_txrx(void *opaque, uint32_t value, int len);
> +void tsc2005_set_transform(void *opaque, MouseTransformInfo *info);
> +
> +#endif
> diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
> index 5d1a2d8329..4d2e3cfb86 100644
> --- a/include/qemu/typedefs.h
> +++ b/include/qemu/typedefs.h
> @@ -98,7 +98,6 @@ typedef struct RAMBlock RAMBlock;
>  typedef struct Range Range;
>  typedef struct SHPCDevice SHPCDevice;
>  typedef struct SSIBus SSIBus;
> -typedef struct uWireSlave uWireSlave;
>  typedef struct VirtIODevice VirtIODevice;
>  typedef struct Visitor Visitor;
>  typedef void SaveStateHandler(QEMUFile *f, void *opaque);

