Return-Path: <SRS0=AgAn=2N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76872C2D0C0
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 06:31:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 368CA206B7
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 06:31:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="YuHv98+b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 368CA206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ijHFu-0005Vj-8a
	for qemu-devel@archiver.kernel.org; Mon, 23 Dec 2019 01:31:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42985)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ijHF6-000519-CD
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 01:31:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ijHF3-0003HE-GB
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 01:30:59 -0500
Received: from ozlabs.org ([203.11.71.1]:59687)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ijHF2-00034J-CM; Mon, 23 Dec 2019 01:30:57 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47h8cX4DnBz9sPV; Mon, 23 Dec 2019 17:30:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1577082652;
 bh=uCqZznU8mM74T1HTRYwE/ohm/NuZ7euWkOrnjR9vhU4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=YuHv98+bbqBFPZgfOOyRZuYLJkQxdwV2LNfPiXot7eNJNfmroSwastu3QE3B6CLu+
 6d1Q4Dd9PHREUMcSZkk2mLY4aDJJnexVvnj1WIy33Srk0oeUri1r7XFDoGqNIgiXdy
 QcvDvYewVmkpRDU5c4V357bhZ0t26+lBiZB+u/XI=
Date: Mon, 23 Dec 2019 17:30:43 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: "Maxiwell S. Garcia" <maxiwell@linux.ibm.com>
Subject: Re: [PATCH] target/ppc: fix memory dump endianness in QEMU monitor
Message-ID: <20191223063043.GH38380@umbus.modem>
References: <20191219163854.8945-1-maxiwell@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="CNfT9TXqV7nd4cfk"
Content-Disposition: inline
In-Reply-To: <20191219163854.8945-1-maxiwell@linux.ibm.com>
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, farosas@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--CNfT9TXqV7nd4cfk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2019 at 01:38:54PM -0300, Maxiwell S. Garcia wrote:
> The env->hflags is computed in ppc_cpu_reset(), using the MSR register
> as input. But at the point ppc_disas_set_info() is called the MSR_LE bit
> in env->hflags doesn't contain the same information that env->msr.
>=20
> Signed-off-by: Maxiwell S. Garcia <maxiwell@linux.ibm.com>
> Signed-off-by: Fabiano Rosas <farosas@linux.ibm.com>

I think the change is ok as far as it goes but,

a) the commit message should expand on what the practical effect of
this is.  Looking, I think the only thing this affects is DEBUG_DISAS
output (i.e. very rarely) which is worth noting.

b) AFAICT this is the *only* thing that looks for the LE bit in
hflags. Given that, and the fact that it would be wrong in most cases,
we should remove it from hflags entirely along with this change.

> ---
>  target/ppc/translate_init.inc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.=
inc.c
> index d33d65dff7..a0b384da9e 100644
> --- a/target/ppc/translate_init.inc.c
> +++ b/target/ppc/translate_init.inc.c
> @@ -10830,7 +10830,7 @@ static void ppc_disas_set_info(CPUState *cs, disa=
ssemble_info *info)
>      PowerPCCPU *cpu =3D POWERPC_CPU(cs);
>      CPUPPCState *env =3D &cpu->env;
> =20
> -    if ((env->hflags >> MSR_LE) & 1) {
> +    if (msr_le) {
>          info->endian =3D BFD_ENDIAN_LITTLE;
>      }
>      info->mach =3D env->bfd_mach;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--CNfT9TXqV7nd4cfk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4AXxAACgkQbDjKyiDZ
s5KcdxAAznu78UmPI6UogjVnpytErRHeYxK/Fzn0HJvwK7/0Uot8tMSNFAsRHyAk
EJkLxCmUo46pjQQw9nY+v3cWyCBkSofE/2JaSEOmU6mN0yLX4xb9k8iK7ZIOqoxd
0j5Hx2+IWZeJgCk9FyIkkuGP0DcO4crb5p7aE2r9Th+WRQvNOcNapc6MqU9RzqyT
g17TuNUbuGLpxfumY6F7SBoTtEpotxZjEUAhZBmGatknl7EpeBuJWjHgsh5RbJI1
HrHX4OlJfGu06PIkzx64naq6TrGi8iD3/lG1+Oy+ghAY7semtAtCPH25oNb1VpqT
gCKhRKIA5pf4M1HrHfUrI0HBMLrL6al6nHdJ5GbYg1wRaV21/zadgS5F6JXeYLyg
jrMFE94CZhNrOaGv0TIsfAsFzLKPLW+ygJ4Ezkqd7anqNU5jUrHIb2GbERBZjlFz
ib8JdDcIYeNPJhfubaNYKp84z8ZDTAZ+PZz+Tj8GmcgCCE/e1ub1ecnJki3CWtdY
JCZBjCwY+q8vnIJPg662xdJpHhgEbFiPs2G5qzDBzgRqe+LUx6RpYtwL9pxkypQr
251UjB2zMcyf7OYdWthTCQZ+eAjN5dScPMtZ67H8lzp0XY2K3u63W4BRZ7uB+7P8
wIy4S4FeoDDNWA0MppmrCD2k+sY11NeIeXrcSYVM+ONeMIvS4YI=
=KOH5
-----END PGP SIGNATURE-----

--CNfT9TXqV7nd4cfk--

