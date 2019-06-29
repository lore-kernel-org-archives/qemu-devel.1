Return-Path: <SRS0=rHaa=U4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6762FC4321A
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2019 05:23:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 337FD2083B
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2019 05:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="nXFimMhe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 337FD2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hh5q8-0008Rj-C9
	for qemu-devel@archiver.kernel.org; Sat, 29 Jun 2019 01:23:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51671)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hh5p2-0007s7-RW
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 01:22:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hh5oy-0002qv-CW
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 01:22:48 -0400
Received: from ozlabs.org ([203.11.71.1]:39691)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hh5oq-0002hk-23; Sat, 29 Jun 2019 01:22:37 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45bMTJ5Ns3z9s5c; Sat, 29 Jun 2019 15:22:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1561785748;
 bh=k5AhlNxHYcLwY3zZPHfUaPJmPgFgdqenxiICViKi8cA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nXFimMhe2seWVC4kXAuxBqGm8S7rXh1BlKE/T3maZ2oVPp7oCU5TAueQaJz4LZOyX
 +LZF7exjT8Hp7nxiHt1Mqb20G7HdQFu1wZt4EU0LM2n6hS97pN/TnNLQppCpl0X9Gl
 h32rAje7HEYv5BnGTmAnZpAk8RQd/d7zWrtWOuPs=
Date: Sat, 29 Jun 2019 15:02:32 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190629050232.GA1870@umbus.fritz.box>
References: <20190628103957.9504-1-kraxel@redhat.com>
 <20190628103957.9504-2-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
In-Reply-To: <20190628103957.9504-2-kraxel@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PULL 1/6] i2c: Move bitbang_i2c.h to
 include/hw/i2c/
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
 Corey Minyard <cminyard@mvista.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2019 at 12:39:52PM +0200, Gerd Hoffmann wrote:
> From: BALATON Zoltan <balaton@eik.bme.hu>
>=20
> The bitbang i2c implementation is also useful for other device models
> such as DDC in display controllers. Move the header to include/hw/i2c/
> to allow it to be used from other device models and adjust users of
> this include. This also reverts commit 2b4c1125ac which is no longer
> needed.
>=20
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> Acked-by: Corey Minyard <cminyard@mvista.com>
> Message-id: 5d1fe4db846ab9be4b77ddb0d43cc74cd200a003.1561028123.git.balat=
on@eik.bme.hu
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

ppc parts
Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  {hw =3D> include/hw}/i2c/bitbang_i2c.h | 2 ++
>  include/hw/i2c/i2c.h                 | 2 --
>  include/hw/i2c/ppc4xx_i2c.h          | 2 +-
>  hw/i2c/bitbang_i2c.c                 | 2 +-
>  hw/i2c/ppc4xx_i2c.c                  | 1 -
>  hw/i2c/versatile_i2c.c               | 2 +-
>  6 files changed, 5 insertions(+), 6 deletions(-)
>  rename {hw =3D> include/hw}/i2c/bitbang_i2c.h (80%)
>=20
> diff --git a/hw/i2c/bitbang_i2c.h b/include/hw/i2c/bitbang_i2c.h
> similarity index 80%
> rename from hw/i2c/bitbang_i2c.h
> rename to include/hw/i2c/bitbang_i2c.h
> index 9443021710d7..3a7126d5dee8 100644
> --- a/hw/i2c/bitbang_i2c.h
> +++ b/include/hw/i2c/bitbang_i2c.h
> @@ -3,6 +3,8 @@
> =20
>  #include "hw/i2c/i2c.h"
> =20
> +typedef struct bitbang_i2c_interface bitbang_i2c_interface;
> +
>  #define BITBANG_I2C_SDA 0
>  #define BITBANG_I2C_SCL 1
> =20
> diff --git a/include/hw/i2c/i2c.h b/include/hw/i2c/i2c.h
> index 8e236f7bb428..75c5bd638bb9 100644
> --- a/include/hw/i2c/i2c.h
> +++ b/include/hw/i2c/i2c.h
> @@ -81,8 +81,6 @@ uint8_t i2c_recv(I2CBus *bus);
> =20
>  DeviceState *i2c_create_slave(I2CBus *bus, const char *name, uint8_t add=
r);
> =20
> -typedef struct bitbang_i2c_interface bitbang_i2c_interface;
> -
>  /* lm832x.c */
>  void lm832x_key_event(DeviceState *dev, int key, int state);
> =20
> diff --git a/include/hw/i2c/ppc4xx_i2c.h b/include/hw/i2c/ppc4xx_i2c.h
> index aa2a2bf9dec2..8437bf070b8b 100644
> --- a/include/hw/i2c/ppc4xx_i2c.h
> +++ b/include/hw/i2c/ppc4xx_i2c.h
> @@ -28,7 +28,7 @@
>  #define PPC4XX_I2C_H
> =20
>  #include "hw/sysbus.h"
> -#include "hw/i2c/i2c.h"
> +#include "hw/i2c/bitbang_i2c.h"
> =20
>  #define TYPE_PPC4xx_I2C "ppc4xx-i2c"
>  #define PPC4xx_I2C(obj) OBJECT_CHECK(PPC4xxI2CState, (obj), TYPE_PPC4xx_=
I2C)
> diff --git a/hw/i2c/bitbang_i2c.c b/hw/i2c/bitbang_i2c.c
> index 5dfc72d9d7b7..3cb0509b0200 100644
> --- a/hw/i2c/bitbang_i2c.c
> +++ b/hw/i2c/bitbang_i2c.c
> @@ -12,7 +12,7 @@
> =20
>  #include "qemu/osdep.h"
>  #include "hw/hw.h"
> -#include "bitbang_i2c.h"
> +#include "hw/i2c/bitbang_i2c.h"
>  #include "hw/sysbus.h"
>  #include "qemu/module.h"
> =20
> diff --git a/hw/i2c/ppc4xx_i2c.c b/hw/i2c/ppc4xx_i2c.c
> index d606d3dbeb81..5fb4f86c38f1 100644
> --- a/hw/i2c/ppc4xx_i2c.c
> +++ b/hw/i2c/ppc4xx_i2c.c
> @@ -30,7 +30,6 @@
>  #include "cpu.h"
>  #include "hw/hw.h"
>  #include "hw/i2c/ppc4xx_i2c.h"
> -#include "bitbang_i2c.h"
> =20
>  #define PPC4xx_I2C_MEM_SIZE 18
> =20
> diff --git a/hw/i2c/versatile_i2c.c b/hw/i2c/versatile_i2c.c
> index e07be9890c8a..24b6e36b6d52 100644
> --- a/hw/i2c/versatile_i2c.c
> +++ b/hw/i2c/versatile_i2c.c
> @@ -23,7 +23,7 @@
> =20
>  #include "qemu/osdep.h"
>  #include "hw/sysbus.h"
> -#include "bitbang_i2c.h"
> +#include "hw/i2c/bitbang_i2c.h"
>  #include "qemu/log.h"
>  #include "qemu/module.h"
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0W8OcACgkQbDjKyiDZ
s5KPdQ/+PhIbfw8GOOh0Q6UFozYqYBCMLZGbryX+C1c39HPc9R7F+AnYLAkiZFkD
GYM4HR26SBVu/VsjSQwNX3iOcNj4QYNXigcHdZJEqBIHl8iwyEWYFAjN5vACyGm8
9cs/jxKr6qWezO+3tYtZYLX34bqHw2jIIIE7p9MuXhLpzljZiIsZ+byFh+Y0pOca
Zx3d8XZ0IGuqCm87QFhrbgk7qmUB/mtDYfHekbDQ1OxBx5h27ZUJ0Su2ljCk8RWF
w3qqetZA80gsOMbTLLycixLesZucjyU2+Ga8PDnf+r0ZflGQaICzH46KOJzI0r8/
fU0xvX5xjMDvvvFgC/4kia1hgzj9TyvibsMJxNiUJH9GIF8Y9Voawvzetj4U3uzx
6Oc6KPqN2WVun1fzZ/RKeupHUc9ETs4SRPrmUG30OFIAeCGOxD3/+R3wF/lbzsR8
I+McRBawFWcw0YuzDfU2XfSj/uMSTrVqkMi0+toZ6HrKDsYAxiFdA2uqbUkSu7zW
+ZQIAtp0qtM27PMPDqhycyWYD6FwqPfeZPXF/ugZ8jklJUF6EhXxtTYsXzR5Co/R
in6pGqT7CNgyCul0eEq23qR08h93qjNb5nr8yIKCLFUekr4gcLRmbGZOTHDKshY5
u/JGMbUyBbNKRJMDdSbUnQyyXuqlOj8dKAnsZxMxNpfXlZZ7mXc=
=4k/l
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--

