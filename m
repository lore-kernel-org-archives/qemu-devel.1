Return-Path: <SRS0=SLMP=AQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B90EDC433DF
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 07:10:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D89D207CD
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 07:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="dGkXUBfT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D89D207CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrymt-0007sL-Pz
	for qemu-devel@archiver.kernel.org; Sun, 05 Jul 2020 03:10:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52734)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jrym1-00078h-Au; Sun, 05 Jul 2020 03:09:13 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:51421 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jrylx-0005xZ-Jz; Sun, 05 Jul 2020 03:09:13 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4B00DP1Qk5z9sSJ; Sun,  5 Jul 2020 17:08:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1593932933;
 bh=ywo6b+L+5gcEpl2+eSCOs43OV+chUDGZ62wu+OU3o6k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=dGkXUBfTm6RXDtJnVowC+IE88Ig0MKFkg8I/GHBUiErx6atEpyTBuwEkpb6qOW+1e
 jcyJYgJ7hs5/7YpN8CadKXGzFm2zFSLVTadyvwaK30CN5ed7gTzfxO3JIshfVG0f5N
 HocfpoP85Q9lpS1dqt0a7DhD4CVWfk/ieic6UPgo=
Date: Sun, 5 Jul 2020 15:34:13 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [PATCH 2/2] hw/ppc: Use TYPE_SYSBUS_OHCI instead of hardcoded
 string
Message-ID: <20200705053413.GA6626@umbus.fritz.box>
References: <20200703184952.4918-1-f4bug@amsat.org>
 <20200703184952.4918-3-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
In-Reply-To: <20200703184952.4918-3-f4bug@amsat.org>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org,
 qemu-devel@nongnu.org, Beniamino Galvani <b.galvani@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 03, 2020 at 08:49:52PM +0200, Philippe Mathieu-Daud=E9 wrote:
> By using the TYPE_* definitions for devices, we can:
> - quickly find where devices are used with 'git-grep'
> - easily rename a non-user-creatable device (one-line change).
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/display/sm501.c | 3 ++-
>  hw/ppc/sam460ex.c  | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/display/sm501.c b/hw/display/sm501.c
> index 9cccc68c35..c122a4eca5 100644
> --- a/hw/display/sm501.c
> +++ b/hw/display/sm501.c
> @@ -36,6 +36,7 @@
>  #include "hw/qdev-properties.h"
>  #include "hw/i2c/i2c.h"
>  #include "hw/display/i2c-ddc.h"
> +#include "hw/usb/hcd-ohci.h"
>  #include "qemu/range.h"
>  #include "ui/pixel_ops.h"
>  #include "qemu/bswap.h"
> @@ -1961,7 +1962,7 @@ static void sm501_realize_sysbus(DeviceState *dev, =
Error **errp)
>      sysbus_init_mmio(sbd, &s->state.mmio_region);
> =20
>      /* bridge to usb host emulation module */
> -    usb_dev =3D qdev_new("sysbus-ohci");
> +    usb_dev =3D qdev_new(TYPE_SYSBUS_OHCI);
>      qdev_prop_set_uint32(usb_dev, "num-ports", 2);
>      qdev_prop_set_uint64(usb_dev, "dma-offset", s->base);
>      sysbus_realize_and_unref(SYS_BUS_DEVICE(usb_dev), &error_fatal);
> diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
> index 1a106a68de..593436937a 100644
> --- a/hw/ppc/sam460ex.c
> +++ b/hw/ppc/sam460ex.c
> @@ -35,6 +35,7 @@
>  #include "hw/char/serial.h"
>  #include "hw/i2c/ppc4xx_i2c.h"
>  #include "hw/i2c/smbus_eeprom.h"
> +#include "hw/usb/hcd-ohci.h"
>  #include "hw/usb/hcd-ehci.h"
>  #include "hw/ppc/fdt.h"
>  #include "hw/qdev-properties.h"
> @@ -370,7 +371,7 @@ static void sam460ex_init(MachineState *machine)
> =20
>      /* USB */
>      sysbus_create_simple(TYPE_PPC4xx_EHCI, 0x4bffd0400, uic[2][29]);
> -    dev =3D qdev_new("sysbus-ohci");
> +    dev =3D qdev_new(TYPE_SYSBUS_OHCI);
>      qdev_prop_set_string(dev, "masterbus", "usb-bus.0");
>      qdev_prop_set_uint32(dev, "num-ports", 6);
>      sbdev =3D SYS_BUS_DEVICE(dev);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl8BZlIACgkQbDjKyiDZ
s5KS4Q/+JirVTbyghqt28vjm/cQzO7HW040SKRBB9iVctieCN4laJvYA3VvUxERH
pujjHh2xnKbDyduzQlKfxO7EPENysPkvMbPxLidKgS/CeD0xNy7+2PWHDmrx2Zm8
36whg9WlJw0BCleIIzBPpztKLB44owOZzpoKkEymGoFQeANE3ExRt8/TUzsIXCp1
Q6lo5h6sr7FvFRnJnJpLupOGlzUn0t1ZeE9Wip/xgivmeTnWU405lfXugKZsblRt
tk0pAYYbI4C8t/xTn3rckQ1ouiuJVYJaI+FAw0cb6RtFaj4L+/20NmAc/CgBSfXK
NQVzAuKIqqjc4UjeCMsEyjGq1i3fmRDewOKJgh9iNMEeP9sZIHTYvgc5Ma1FuYOG
/vNmhzCRxRasLarSO5s7AQNZsO/P1Yw+5pkSUHkHYPazafT8nsOqogH95HKiufRG
eTw6RrwhZTq2QgUgtM/hWfCselfK3Bedg6kWaYkYLcNyQXVlZTzTJhkXEO9wzmg7
YuIbJZuUAnHuW2NwogYwGUi200nhZ3VhdHRJNXl/kY+yHSrIx7ZlJmuS8M+iYbT0
Svlp6AwtJGJJ0S/qrvPJlj71+5/GL5VGUlSLOOPig5qMfSxVFb14CcHp+cYTXclO
yLmzCiVMcsjB5RrhZ8JPq1H0U5Cx9rnOiJVjmFnlqVt2DXdtXr4=
=ah6p
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--

