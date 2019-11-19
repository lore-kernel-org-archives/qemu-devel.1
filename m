Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A95C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 23:41:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C392D222B6
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 23:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="SzRHyfGR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C392D222B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXD7Z-0004Tx-Rm
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 18:41:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45621)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iXD6b-0003RE-0y
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 18:40:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iXD6Z-00022r-GA
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 18:40:20 -0500
Received: from ozlabs.org ([203.11.71.1]:40605)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iXD6Y-00020Y-Fr; Tue, 19 Nov 2019 18:40:19 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47Hj3z0tRyz9sPZ; Wed, 20 Nov 2019 10:40:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1574206815;
 bh=t6PoUaBou3MfsSTtFkdhEwiEaFudGqIHFdMskQnIdUg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=SzRHyfGRbwQVoxsXi9qjZqQak7Ax6T2naEC2ratwLmGI0LTiUq0tLzzSnQypwmf4g
 x8oWoGE01Ju1n0qmOssL8IZJ1MVpIH9vhJ0iOnkvT5aBlK/xMohR4iin1XlJuyU6Zf
 c3d0ru2laQA4GuFeeb5rKAQEeAOEFiSdYq35eq/k=
Date: Wed, 20 Nov 2019 09:07:50 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH for-5.0 v5 05/23] ppc/pnv: Quiesce some XIVE errors
Message-ID: <20191119220750.GZ5582@umbus.fritz.box>
References: <20191115162436.30548-1-clg@kaod.org>
 <20191115162436.30548-6-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Qesg98+uAFykT7J8"
Content-Disposition: inline
In-Reply-To: <20191115162436.30548-6-clg@kaod.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
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
Cc: qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Qesg98+uAFykT7J8
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2019 at 05:24:18PM +0100, C=E9dric Le Goater wrote:
> When dumping the END and NVT tables, the error logging is too noisy.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied, thanks.

> ---
>  hw/intc/pnv_xive.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
> index 02faf4135e48..a394331ddd6a 100644
> --- a/hw/intc/pnv_xive.c
> +++ b/hw/intc/pnv_xive.c
> @@ -29,7 +29,7 @@
> =20
>  #include "pnv_xive_regs.h"
> =20
> -#define XIVE_DEBUG
> +#undef XIVE_DEBUG
> =20
>  /*
>   * Virtual structures table (VST)
> @@ -157,7 +157,9 @@ static uint64_t pnv_xive_vst_addr_indirect(PnvXive *x=
ive, uint32_t type,
>      vsd =3D ldq_be_dma(&address_space_memory, vsd_addr);
> =20
>      if (!(vsd & VSD_ADDRESS_MASK)) {
> +#ifdef XIVE_DEBUG
>          xive_error(xive, "VST: invalid %s entry %x !?", info->name, idx);
> +#endif
>          return 0;
>      }
> =20
> @@ -178,7 +180,9 @@ static uint64_t pnv_xive_vst_addr_indirect(PnvXive *x=
ive, uint32_t type,
>          vsd =3D ldq_be_dma(&address_space_memory, vsd_addr);
> =20
>          if (!(vsd & VSD_ADDRESS_MASK)) {
> +#ifdef XIVE_DEBUG
>              xive_error(xive, "VST: invalid %s entry %x !?", info->name, =
idx);
> +#endif
>              return 0;
>          }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Qesg98+uAFykT7J8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3UZ7YACgkQbDjKyiDZ
s5KXWQ//Zl8tO0CpbjMqEu8lgMGvKffxfYVQ8WIe6Z3m43x4yIk8fkuIyazmyJAp
rBP2bBL/C6xcjIOTAOFVofE6k4hFhDPsz48r7ZqwuFHvocXagz69uro69YywDVcB
lDRU1qTKtmd3F2nPffsVUssUF3rmrq/5ENZc/EZ0vzN9RQxiN451RJCRSjznateI
SpFmf5aiVP6/PH7mLPlZ7U0Bh6IiptavGY9rJbCqLWoK0CsXpSMw22TrqjT4Novl
KQMoWvogNw5AOAUmoHU4PbY9Ep0iPG1TYuybJmJft6UczTnI3SEO+cfVeB+7B6rq
jBWBR7ieIyFQiqRNB3FluA8D+lTu84OtlNr2ELEzZCDQ+CMADZTNGD6+SpgBA4F+
GDVt1sxaE16ZyIdYsuKp92HAZ94YQ5udUHWDcce6CUULxxMk3OlEIe73REcEeOos
jobKO0cLriO5fXxrJySh1dXufw6ncPTlXUm6bZDL3E3MGf6+smqVDIzNlsL2kr/8
LNv0+lcwCKVkDyvkk8BWzP2ZcLvkuQjUkWRW6AHfz3dChug0pMDdjz9576bJcMTW
2n51THX6sUtKcfaL5mkfc+IDmkrkMPMPLBPWod5Vt5m9PTOlDUJ12gY5GVtLddAc
ViOv+MreZMAQ7PAcUKdvOTAlptYT0d8uv0WTZMp6Hfz5Hd5CSH0=
=B8zr
-----END PGP SIGNATURE-----

--Qesg98+uAFykT7J8--

