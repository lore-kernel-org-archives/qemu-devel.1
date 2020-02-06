Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32573C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 03:49:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F104B20838
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 03:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="JT+uxjbL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F104B20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izYAJ-0003of-7i
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 22:49:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36387)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1izY8q-0001uG-3N
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 22:47:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1izY8o-00076w-Q5
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 22:47:47 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:49665 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1izY8n-0006YF-KI; Wed, 05 Feb 2020 22:47:46 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48CksM5ffyz9sRX; Thu,  6 Feb 2020 14:47:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1580960855;
 bh=HRwQaLHz4ranwD5wz3AHcVmBxfe1+G8212tIXHxsvc8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=JT+uxjbL2D7QdqIyEjxdIxoxQOZyBWHIEUPFpl7iUgxcVLr6xYIWZRuufYXg83XCZ
 3hR0Gi6QXauHUNOKSjbKrRPLATo427Qrn5GEvZSCsBPQZr/idNS2QEej258Ql2k0KV
 NlFy4YhiKfPInwfUp/Amv+TvQzQktCZxaaa1/ZU0=
Date: Thu, 6 Feb 2020 14:45:11 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH v2 1/2] qtest: Fix rtas dependencies
Message-ID: <20200206034511.GJ60221@umbus.fritz.box>
References: <20200205232016.588202-1-lvivier@redhat.com>
 <20200205232016.588202-2-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Tu8ztk+XgTAiG9Id"
Content-Disposition: inline
In-Reply-To: <20200205232016.588202-2-lvivier@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: Thomas Huth <thuth@redhat.com>, Greg Kurz <groug@kaod.org>,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Tu8ztk+XgTAiG9Id
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 06, 2020 at 12:20:15AM +0100, Laurent Vivier wrote:
> qtest "rtas" command is only available with pseries not all ppc64 targets,
> so if I try to compile only powernv machine, the build fails with:
>=20
>   /usr/bin/ld: qtest.o: in function `qtest_process_command':
>   .../qtest.c:645: undefined reference to `qtest_rtas_call'
>=20
> We fix this by enabling rtas command only with pseries machine.
>=20
> Fixes: eeddd59f5962 ("tests: add RTAS command in the protocol")
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  qtest.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/qtest.c b/qtest.c
> index 12432f99cf44..587dcbb4b515 100644
> --- a/qtest.c
> +++ b/qtest.c
> @@ -27,7 +27,8 @@
>  #include "qemu/error-report.h"
>  #include "qemu/module.h"
>  #include "qemu/cutils.h"
> -#ifdef TARGET_PPC64
> +#include "config-devices.h"
> +#ifdef CONFIG_PSERIES
>  #include "hw/ppc/spapr_rtas.h"
>  #endif
> =20
> @@ -628,7 +629,7 @@ static void qtest_process_command(CharBackend *chr, g=
char **words)
>  #else
>          qtest_sendf(chr, "OK little\n");
>  #endif
> -#ifdef TARGET_PPC64
> +#ifdef CONFIG_PSERIES
>      } else if (strcmp(words[0], "rtas") =3D=3D 0) {
>          uint64_t res, args, ret;
>          unsigned long nargs, nret;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Tu8ztk+XgTAiG9Id
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl47i8UACgkQbDjKyiDZ
s5J+lg//XsglBaRp3RLfH7BREdSZ0xykAVFX4pu68/uY4vg2PCxknWUe8j5XW7rE
4OvGA1r+u0o03l1nY3moYm3mgR2eG+DDxlEO6ivi+1uEHg251UcG/H/xm90XTgAa
y2uz5scVBv1bPUhOsVfuQyev+BBQ/M0/Tmyt23hAKIMRz94g37lBN4g15Cduzaj+
X7Cr+ufKwQdInICRlqtxrHmQl6V/5zc0XtY29+49N37kYsdZ99cfapv0W6YxeorN
rDcbUNaWqZpv1J2WXgJFFJmbdiDtMI1DMXv7wLCdzq4744SFCxvi9aBY2xWoEZbg
VrWU3oHM5+V0j3espL+WMzO6nc2Q1wB7Heu4G7GY+4nY4hvLYylZFxL9vuIqgi1R
fgmsxnHBpnS/5Ucar+cS6iLe+0ebIf80TM8Bm/miWbX3zi9JGDa2fj1SmI1kujhB
CurjLFYZpEEfN94zTxZjJBPUjS42Lz0e2koGsriVEbneutfx5OVrgfaGA/UZBfMO
Q3o7HAF1MHkk4IE4EYTdyZRccnejjJN6hDTsSvM5TUc10OtGd6I0NwbMkDFe6ebL
AkyNvExTm8M5iAOC9NH4z5vzLTK+YndQBcAu6pxzuyHpuo0YSj1bPMg9Ao2dxH5W
rnyr3k3q31yFUa2uPpvu7zQvTQQIl38gBTKFZbWAJcc+u0j207Q=
=oP5J
-----END PGP SIGNATURE-----

--Tu8ztk+XgTAiG9Id--

