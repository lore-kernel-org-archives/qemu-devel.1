Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB03C04AB5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 00:21:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F13D208E3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 00:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="VsBFHkft"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F13D208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45206 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZ2d6-0007fJ-8X
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 20:21:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53594)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hZ2bK-0006cZ-DK
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 20:19:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hZ2bI-0003NM-Hq
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 20:19:22 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:49833)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hZ2bF-0003Jz-Js; Thu, 06 Jun 2019 20:19:19 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45KjnX2nkvz9s9y; Fri,  7 Jun 2019 10:19:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1559866752;
 bh=d2d8/zZKjP3NHBCqMRizTNvap0TvMAddTzj2SXuAhqE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VsBFHkftp7SXTmdTQvzycDNUiq10Bhug8Z9leSTw5LwVeqm0LryKRhWNsj5KEn/1h
 VSYaFyMT+qt/txXO5mY/5VZK1mk6BYHcVePNbIkuRZ0x0S+1NuSy93bEg/hQw2EHhZ
 PsrydQkyo4j8xOoD2Q+Af1GHH/zTAMbB2+VfQbxY=
Date: Fri, 7 Jun 2019 10:15:28 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Message-ID: <20190607001528.GA3760@umbus.fritz.box>
References: <20190606174732.13051-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline
In-Reply-To: <20190606174732.13051-1-clg@kaod.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH] ppc/pnv: activate the "dumpdtb" option on
 the powernv machine
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 06, 2019 at 07:47:32PM +0200, C=E9dric Le Goater wrote:
> This is a good way to debug the DT creation for current PowerNV
> machines and new ones to come.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied, thanks.

> ---
>  hw/ppc/pnv.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 046f0a83c8e5..ed6892466793 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -23,6 +23,7 @@
>  #include "sysemu/sysemu.h"
>  #include "sysemu/numa.h"
>  #include "sysemu/cpus.h"
> +#include "sysemu/device_tree.h"
>  #include "hw/hw.h"
>  #include "target/ppc/cpu.h"
>  #include "qemu/log.h"
> @@ -554,6 +555,7 @@ static void pnv_reset(void)
>      /* Pack resulting tree */
>      _FDT((fdt_pack(fdt)));
> =20
> +    qemu_fdt_dumpdtb(fdt, fdt_totalsize(fdt));
>      cpu_physical_memory_write(PNV_FDT_ADDR, fdt, fdt_totalsize(fdt));
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlz5rKAACgkQbDjKyiDZ
s5JSSxAAgzCg0sGvAQpEx8yfkzlFKK9hKnw9QBbkt3NOHSykyTdeKhv6DO82hmF8
OjLsP397VdTurKjtmNIaBWWl/AKvZUkU4TfdShWdslTY6GzGs78SjvomgiiutXKt
apanAf2WNZ6TnuMzI+22hstg18mXUAqehByah+T+nkCF3KfLjfIsp9PyUDcBm1wW
nhiygtzpqIl6Ad5DpQPyoDXZ62ikNcKWYhC3cBGw7/F3/H0bnsF30hM8RKgWWc3e
lW+JGHBEr0eP+FoqhsIz/08dK6uzPatdwtcLPtOhCgt70cP1HzXGauYW7cefwUFm
n1IEZCVgDj/iKKOabMxILpJGX9UeqbMHu/XuQPH+qESkB0Y0Of/4tvr2e5KWqBLX
n/NocZyBkYcLJlW3ofFntP2lx1+88m6XEDczw257WBE3Kp0BgJFP+om2jjAuBevj
oIMNOaCbGYnSk3788XpBVYuqJwORvqNp2ZyjrW2OEr3w8MG/bV6GR7hjj4psJzgB
nwZukAIvDBg4A/PjM9VXNPoVNb3VqBlNadsDlARhAVzQ9RBlyslHAVwDYRHD+g1+
Sp5UQ5hv6rC+sIAjptlK2SDVCs8I830UnupSASzBEEUb4ViOf0rfweSeNPppksFn
VvAU7U+228j0MhEaPGo5ZkzqD0kCQvdbpri4l7up2oFeVIOyXRo=
=CAyb
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--

