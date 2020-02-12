Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E84DFC352A4
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 23:52:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B777521569
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 23:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="gmSEyH34"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B777521569
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j21oB-00030E-VV
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 18:52:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60643)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1j21mb-0000ik-Rv
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 18:51:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1j21ma-0004pL-Mk
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 18:51:05 -0500
Received: from ozlabs.org ([203.11.71.1]:45405)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1j21mZ-0004nb-Hq; Wed, 12 Feb 2020 18:51:04 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48HxH73r17z9sPF; Thu, 13 Feb 2020 10:50:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1581551459;
 bh=9AaV8EIijB3c/HD+ZEBPRd/vUs+20dxRBeRLER7h4x4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gmSEyH34vGlyEhAJzh+WSfoOI6uF+XUoxrpgz4GhVrUhW6RYqFOiV3prrMDy9c0ml
 UjeE04sx4q5c6VjJ1JflfhWAHydj3Ym7SZy7suBI5ThuCInUFMWIeaoecpnfCcJAEa
 g0qJtJgXdL9qPFK16A5yuoTYJ1vncS1tgPLItUOY=
Date: Thu, 13 Feb 2020 10:48:13 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: BALATON Zoltan <balaton@eik.bme.hu>
Subject: Re: [PATCH] target/ppc/cpu.h: Remove duplicate includes
Message-ID: <20200212234813.GA124369@umbus.fritz.box>
References: <20200212223207.5A37574637F@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline
In-Reply-To: <20200212223207.5A37574637F@zero.eik.bme.hu>
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
Cc: qemu-trivial@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2020 at 11:26:14PM +0100, BALATON Zoltan wrote:
> Commit 74433bf083b added some includes but added them twice. Since
> these are guarded against multiple inclusion including them once is
> enough.
>=20
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Applied to ppc-for-5.0, thanks.

> ---
>  target/ppc/cpu.h | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 3a1eb76004..07dd2b4da7 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -23,8 +23,6 @@
>  #include "qemu/int128.h"
>  #include "exec/cpu-defs.h"
>  #include "cpu-qom.h"
> -#include "exec/cpu-defs.h"
> -#include "cpu-qom.h"
> =20
>  /* #define PPC_EMULATE_32BITS_HYPV */
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5Ejr0ACgkQbDjKyiDZ
s5K1uBAAi4YYocwjXtjZZoa5hUG7QG2n6wSmTF1/eUw/KIrF4jIQm2y5DwxkWq+w
FWtPVbMPit//jrbyvtzmpzHMQbiDbnePP5zfaySl7dDJbrw3nkErJF8YyCMIhQpM
ohVIjTwcFj0PqVFv65vlHo2ecwFh26oXe3BX5foUtb3XSBNrrMeyQwaP6xYmyQtd
wdsa3d0BRlkZIAhtRiceVel4rcB3HXQ5kxNaTmaNDAtkTNp/LKXpTSYvfEJMAK2N
28Z89k6tdC9dYJ0FhX6tj4EJCAr1YjUTWwSgwmE3WyYxK5w/jF5N2bklQ0IGAM76
5r8MZcWpqvlr69nw8JZfVPI3F4Ee1zEuY8HkW1fvw+u5W5griWaBNpn16TZncP2z
YTZJqhf+CwTCNgop+XrFJrBdfnUur9w8bSkoyhuk7KdebPWp9XLxTOE51/CTtaXG
NNGs81V6MuCxcEQGi8yl9dU2wfHSFcwKmV+bWziAWoOUA4V3WOzltJm+2K9QZHAO
HQDrrX0zwRJ9AXB6GD9qcZDlA4UW64Mdgo+/73eoRw5ByIcjo5T8KyTo7LB20yK0
FF/49l+Vj61LwSi9aoqrNQSME+/LzS6H5LoOQhx/DCj3aD7aWYJjHZaGBMbvBiKE
UykmQt8bIIrCzD6nwsdo1crnsbeKq2ImPwinJ8UMuO653RUH3BI=
=/MHu
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--

