Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B505C10F14
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 15:10:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DB7221473
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 15:10:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DB7221473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54514 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDVue-0006Y3-Cj
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 11:10:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hDVqL-0003xh-99
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 11:05:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hDVqI-0005k4-U2
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 11:05:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42892)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>)
	id 1hDVq5-00058S-Vu; Mon, 08 Apr 2019 11:05:40 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 52254883B8;
	Mon,  8 Apr 2019 15:05:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id DDB9868D61;
	Mon,  8 Apr 2019 15:04:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 654671138648; Mon,  8 Apr 2019 17:04:45 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
References: <20190204231815.29661-1-philmd@redhat.com>
	<20190204231815.29661-7-philmd@redhat.com>
Date: Mon, 08 Apr 2019 17:04:45 +0200
In-Reply-To: <20190204231815.29661-7-philmd@redhat.com> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Tue, 5 Feb 2019 00:18:10
	+0100")
Message-ID: <87y34kmtbm.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Mon, 08 Apr 2019 15:05:12 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 06/11] hw/devices: Move Gamepad
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
Message-ID: <20190408150445.BnYZw5BsEuAwGmI5K7J8Ljo9CXAubdSVtELMjTXo8TY@z>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  MAINTAINERS                |  1 +
>  hw/arm/stellaris.c         |  2 +-
>  hw/input/stellaris_input.c |  2 +-
>  include/hw/devices.h       |  3 ---
>  include/hw/input/gamepad.h | 21 +++++++++++++++++++++
>  5 files changed, 24 insertions(+), 5 deletions(-)
>  create mode 100644 include/hw/input/gamepad.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index daae4a3beb..a38086f767 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -729,6 +729,7 @@ M: Peter Maydell <peter.maydell@linaro.org>
>  L: qemu-arm@nongnu.org
>  S: Maintained
>  F: hw/*/stellaris*
> +F: include/hw/input/gamepad.h
>=20=20
>  Versatile Express
>  M: Peter Maydell <peter.maydell@linaro.org>
> diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
> index 442529cc65..24c20bf612 100644
> --- a/hw/arm/stellaris.c
> +++ b/hw/arm/stellaris.c
> @@ -12,7 +12,6 @@
>  #include "hw/sysbus.h"
>  #include "hw/ssi/ssi.h"
>  #include "hw/arm/arm.h"
> -#include "hw/devices.h"
>  #include "qemu/timer.h"
>  #include "hw/i2c/i2c.h"
>  #include "net/net.h"
> @@ -22,6 +21,7 @@
>  #include "sysemu/sysemu.h"
>  #include "hw/arm/armv7m.h"
>  #include "hw/char/pl011.h"
> +#include "hw/input/gamepad.h"
>  #include "hw/misc/unimp.h"
>  #include "cpu.h"
>=20=20
> diff --git a/hw/input/stellaris_input.c b/hw/input/stellaris_input.c
> index 99168bfeef..20c87d86f4 100644
> --- a/hw/input/stellaris_input.c
> +++ b/hw/input/stellaris_input.c
> @@ -8,7 +8,7 @@
>   */
>  #include "qemu/osdep.h"
>  #include "hw/hw.h"
> -#include "hw/devices.h"
> +#include "hw/input/gamepad.h"
>  #include "ui/console.h"
>=20=20
>  typedef struct {
> diff --git a/include/hw/devices.h b/include/hw/devices.h
> index e400f9eac0..7a630da47f 100644
> --- a/include/hw/devices.h
> +++ b/include/hw/devices.h
> @@ -26,7 +26,4 @@ void *tsc2005_init(qemu_irq pintdav);
>  uint32_t tsc2005_txrx(void *opaque, uint32_t value, int len);
>  void tsc2005_set_transform(void *opaque, MouseTransformInfo *info);
>=20=20
> -/* stellaris_input.c */
> -void stellaris_gamepad_init(int n, qemu_irq *irq, const int *keycode);
> -
>  #endif
> diff --git a/include/hw/input/gamepad.h b/include/hw/input/gamepad.h
> new file mode 100644
> index 0000000000..112bad5e4c
> --- /dev/null
> +++ b/include/hw/input/gamepad.h
> @@ -0,0 +1,21 @@
> +/*
> + * Gamepad style buttons connected to IRQ/GPIO lines
> + *
> + * Copyright (c) 2007 CodeSourcery.
> + * Written by Paul Brook
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#ifndef HW_INPUT_GAMEPAD_H
> +#define HW_INPUT_GAMEPAD_H
> +
> +/* Gamepad devices that have nowhere better to go.  */

Are there any gamepad devices that have a better place to go?  git-grep
gamepad suggests no.  Drop the comment?

> +
> +#include "hw/irq.h"
> +
> +/* stellaris_input.c */
> +void stellaris_gamepad_init(int n, qemu_irq *irq, const int *keycode);
> +
> +#endif

