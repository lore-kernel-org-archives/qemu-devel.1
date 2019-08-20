Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81536C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 07:35:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49A0E22DD6
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 07:35:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="FZt4ck4W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49A0E22DD6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzygN-0002bS-GJ
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 03:35:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47462)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1hzyfQ-0001yA-PI
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 03:34:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hzyfP-0004fY-Bk
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 03:34:56 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:48273 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hzyfN-0004Zh-En; Tue, 20 Aug 2019 03:34:54 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46CMxx073Wz9s00; Tue, 20 Aug 2019 17:34:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1566286485;
 bh=iHirW2xFS4XqhSLKvGy9j6nKVetW68GwpiF/Ocj7ts8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FZt4ck4WO00kC5p+8jzIG8G7EN6w4kE1Ghw/p+y5TW7E8DmW/6/zxTpcLhR/a+YC5
 QHu+lWL7CokrWVZM04rPtjmJB522wS0imO3Csc7zp11NbYq8WVHIVPOgpvPUB7Ore2
 gtPUf9Bk1NKs28zL091mPae78a3HtnBGo80HEYeE=
Date: Tue, 20 Aug 2019 17:32:41 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Message-ID: <20190820073241.GD20890@umbus>
References: <20190819144926.5297-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ytoMbUMiTKPMT3hY"
Content-Disposition: inline
In-Reply-To: <20190819144926.5297-1-philmd@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH] hw/ppc/spapr: Use the proper include that
 defines 'target_ulong'
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--ytoMbUMiTKPMT3hY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2019 at 04:49:26PM +0200, Philippe Mathieu-Daud=C3=A9 wrote:
> As its name implies, the Option/Architecture Vector is not target
> (per cpu) specific but arch-related.
> Use the proper arch-related header, allowing to use this header
> with non cpu-specific objects.
>=20
> This fixes this error when using this header with $common-obj:
>=20
>   include/hw/ppc/spapr_ovec.h:76:44: error: unknown type name =E2=80=98ta=
rget_ulong=E2=80=99; did you mean =E2=80=98gulong=E2=80=99?
>      SpaprOptionVector *spapr_ovec_parse_vector(target_ulong table_addr, =
int vector);
>                                                 ^~~~~~~~~~~~
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

So, the change here seems sane, but the commit message totally
confuses me.  Where does the term "Option/Architecture Vector" come
=66rom?  What distinction are you drawing between per-target and
per-arch?  What's the symptom if this patch is not applied?

> ---
>  include/hw/ppc/spapr_ovec.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/hw/ppc/spapr_ovec.h b/include/hw/ppc/spapr_ovec.h
> index 7891e9caac..b6b8811998 100644
> --- a/include/hw/ppc/spapr_ovec.h
> +++ b/include/hw/ppc/spapr_ovec.h
> @@ -37,7 +37,7 @@
>  #ifndef SPAPR_OVEC_H
>  #define SPAPR_OVEC_H
> =20
> -#include "cpu.h"
> +#include "exec/cpu-defs.h"
> =20
>  typedef struct SpaprOptionVector SpaprOptionVector;
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ytoMbUMiTKPMT3hY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl1bohkACgkQbDjKyiDZ
s5Jo0RAAgO+OrhBLooQT/umQB3MC2NPmD0B/cebjrXXsoZRuOpNuzJqE/Io6jiy9
3f6/b1/smtPb8dv/EzHUCA+tHPYPw1lKJaQNoHJNOTDgCt83wGrwmlDDLfWBQbUh
jt8+AxRRqWigqqhyl0glNCIR6hOXulGTLjGOmeBFKfWHH8m1Katu9ZyuJm0QEDHJ
7VDFKwgSrBESWKU1l/Htsq7BDgWyS0TmhQEiYD+Un4xAzDuDDN7ieRsErzSZUQ2K
G12Q8hH5F21gdgkL5DNUk7GcUf6eUaTxO1oR1BvjQE8na2vZvpTictl7WnDHSLv6
Q9FjphNmYHP1b6LWKi96xvopu35c+XpwYW3jTsKyQ/IuhLSJNS3etg+bPbkZ7qtF
QesDSyUfwSVSLDZMaPCXw6zBdc6/GN8LPY0sdF1ebAVG4UhEQv1II7Sc7FFnQ6ed
NUOddXeMn5tcFLg8o1PWBIXjBIEFperS08Y8G5NIYho9Q6lfYvj6ugwTSO7CW/FH
joR5zu5lrwVa0pmsNipXCaQmaCY+wEVuwNF+4WVAapA2gQD0S7CVuyov762LXgwl
lc2TVWVP7ojgDwpRFsO9yd3aL+gc9qXxZzo3Fa5kGz27+suSNJbavgiQjZZlWGc+
NztVTU9BFR0wdxW3kUVYxMNyzaTq0107geo5GLCZ+VbB8vqkOsA=
=7KIn
-----END PGP SIGNATURE-----

--ytoMbUMiTKPMT3hY--

