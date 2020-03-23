Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81402C1975A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 03:23:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49B2C20724
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 03:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Jrz7Xfdn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49B2C20724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGDgf-0004aq-Ej
	for qemu-devel@archiver.kernel.org; Sun, 22 Mar 2020 23:23:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51709)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jGDeX-0001m2-BO
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 23:21:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jGDeV-0005ps-QT
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 23:21:25 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:59595 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jGDeV-0005om-CK; Sun, 22 Mar 2020 23:21:23 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48m05p6Ntxz9sRN; Mon, 23 Mar 2020 14:21:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1584933678;
 bh=Luzk66egtNPc/JwCC1EXH840Fv9M41gtqX9gvzKZzag=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Jrz7Xfdn+uxk9qpN44dr44GKFKD+Z10USlNybciQ/ypg66QjKx7PZeNRr69jhbM8Y
 M6NHmeDVNPO8Wtx6TIcFT1uuIkKOVgS5hgzTcikW83J7ziqIIjJsoYYM9WTUJfzOAH
 yXA9JFOUfVBALHJX11z+IiO73KVsnA5EA4g414+0=
Date: Mon, 23 Mar 2020 13:33:25 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH for-5.0] hw/ppc: Take QEMU lock when calling
 ppc_dcr_read/write()
Message-ID: <20200323023325.GA2213@umbus.fritz.box>
References: <20200322192258.14039-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
In-Reply-To: <20200322192258.14039-1-peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
Cc: Amit Lazar <abasarlaz@hotmail.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 22, 2020 at 07:22:58PM +0000, Peter Maydell wrote:
> The ppc_dcr_read() and ppc_dcr_write() functions call into callbacks
> in device code, so we need to hold the QEMU iothread lock while
> calling them.  This is the case already for the callsites in
> kvmppc_handle_dcr_read/write(), but we must also take the lock when
> calling the helpers from TCG.
>=20
> This fixes a bug where attempting to initialise the PPC405EP
> SDRAM will cause an assertion when sdram_map_bcr() attempts
> to remap memory regions.
>=20
> Reported-by: Amit Lazar <abasarlaz@hotmail.com>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Applied to ppc-for-5.0.

> ---
> Amit reported this bug via IRC.
>=20
>  target/ppc/timebase_helper.c | 40 +++++++++++++++++++++++-------------
>  1 file changed, 26 insertions(+), 14 deletions(-)
>=20
> diff --git a/target/ppc/timebase_helper.c b/target/ppc/timebase_helper.c
> index 703bd9ed18b..d16360ab667 100644
> --- a/target/ppc/timebase_helper.c
> +++ b/target/ppc/timebase_helper.c
> @@ -21,6 +21,7 @@
>  #include "exec/helper-proto.h"
>  #include "exec/exec-all.h"
>  #include "qemu/log.h"
> +#include "qemu/main-loop.h"
> =20
>  /***********************************************************************=
******/
>  /* SPR accesses */
> @@ -167,13 +168,19 @@ target_ulong helper_load_dcr(CPUPPCState *env, targ=
et_ulong dcrn)
>          raise_exception_err_ra(env, POWERPC_EXCP_PROGRAM,
>                                 POWERPC_EXCP_INVAL |
>                                 POWERPC_EXCP_INVAL_INVAL, GETPC());
> -    } else if (unlikely(ppc_dcr_read(env->dcr_env,
> -                                     (uint32_t)dcrn, &val) !=3D 0)) {
> -        qemu_log_mask(LOG_GUEST_ERROR, "DCR read error %d %03x\n",
> -                      (uint32_t)dcrn, (uint32_t)dcrn);
> -        raise_exception_err_ra(env, POWERPC_EXCP_PROGRAM,
> -                               POWERPC_EXCP_INVAL |
> -                               POWERPC_EXCP_PRIV_REG, GETPC());
> +    } else {
> +        int ret;
> +
> +        qemu_mutex_lock_iothread();
> +        ret =3D ppc_dcr_read(env->dcr_env, (uint32_t)dcrn, &val);
> +        qemu_mutex_unlock_iothread();
> +        if (unlikely(ret !=3D 0)) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "DCR read error %d %03x\n",
> +                          (uint32_t)dcrn, (uint32_t)dcrn);
> +            raise_exception_err_ra(env, POWERPC_EXCP_PROGRAM,
> +                                   POWERPC_EXCP_INVAL |
> +                                   POWERPC_EXCP_PRIV_REG, GETPC());
> +        }
>      }
>      return val;
>  }
> @@ -185,12 +192,17 @@ void helper_store_dcr(CPUPPCState *env, target_ulon=
g dcrn, target_ulong val)
>          raise_exception_err_ra(env, POWERPC_EXCP_PROGRAM,
>                                 POWERPC_EXCP_INVAL |
>                                 POWERPC_EXCP_INVAL_INVAL, GETPC());
> -    } else if (unlikely(ppc_dcr_write(env->dcr_env, (uint32_t)dcrn,
> -                                      (uint32_t)val) !=3D 0)) {
> -        qemu_log_mask(LOG_GUEST_ERROR, "DCR write error %d %03x\n",
> -                      (uint32_t)dcrn, (uint32_t)dcrn);
> -        raise_exception_err_ra(env, POWERPC_EXCP_PROGRAM,
> -                               POWERPC_EXCP_INVAL |
> -                               POWERPC_EXCP_PRIV_REG, GETPC());
> +    } else {
> +        int ret;
> +        qemu_mutex_lock_iothread();
> +        ret =3D ppc_dcr_write(env->dcr_env, (uint32_t)dcrn, (uint32_t)va=
l);
> +        qemu_mutex_unlock_iothread();
> +        if (unlikely(ret !=3D 0)) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "DCR write error %d %03x\n",
> +                          (uint32_t)dcrn, (uint32_t)dcrn);
> +            raise_exception_err_ra(env, POWERPC_EXCP_PROGRAM,
> +                                   POWERPC_EXCP_INVAL |
> +                                   POWERPC_EXCP_PRIV_REG, GETPC());
> +        }
>      }
>  }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl54H/MACgkQbDjKyiDZ
s5JyhxAAiAEX2HT938jt3/C84OE79af6a7hRpgTYutbcgxtpqIKY2QhLhKuTlgiY
AX1KSY9DgwQD+JwuafMDBE11dWomRRqVEPd8hQJJ9O4kHourVzXgK3/kV3P7Xl5X
IwTbwnXjoS9HSImo5CGqBwj0giGgTo/liwLjr3zUBmj1YDL75XW5tmSNZ8OKrWZu
IpCIP5OiN4f9h+oT72fmYQfzVCFxcaBAayQ1lD3jTz5i9FmbJbi9Nkvhj76ocD0j
Oe7QQhmMYLkgcr01khK8i7WInk3fcWuzGqUuoTAeUwDtmDZ/jg9AjyBF+ILScy4o
LBr+nCg0eWdCYa5VFFINb1xPnVK1roedx06mQglZcNFI183wT1f0+IXPUhwC3sJy
zWXjbws7Xxa6F641TQ7sjZODba3+SAEgSjcBrwQdTxvhISa/lxR3HmPb7+3vVrk3
x7+3xYxvHsM1MlGe8QNbFcFKi2lcKeax6X8Q21iiZGJuC2NjzVMTq9DlTcmeKgj6
98waJFTTeaB30JaW0KrLmArO3kCW/FreI7LKg2vpe5hP22TTRY2lP+hiLtF1S/+H
wqzGfLCV/WDyE1luOUoXuG/YTyX2Sq4qoy1j9NvVd1zKOklOe38N5DTogyCqY2B/
kjKBptapWq4FJvFjicRjDjxVBavyqgVV0aMqh4lnVnNpTFRp5BQ=
=EpUD
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--

