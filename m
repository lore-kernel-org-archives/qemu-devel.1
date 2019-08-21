Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 205EEC3A59E
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 00:33:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF9A721848
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 00:33:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="HY+TrLeL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF9A721848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0b2N-0004OS-UD
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 20:33:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55811)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1i0ayY-00012s-8D
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 20:29:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1i0ayX-0008Sy-76
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 20:29:14 -0400
Received: from ozlabs.org ([203.11.71.1]:44321)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1i0ayW-0008Nb-0j; Wed, 21 Aug 2019 20:29:13 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46DQPp108Vz9sNF; Thu, 22 Aug 2019 10:29:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1566433742;
 bh=AEpg+r3FDv8nHfheDF9jZUDYAU1yYj+g7x4MuqWaoXM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HY+TrLeLV+AyoruH9BLqK/3+qYBgd0CFt6IXuFDxRs8vlIx8gnHD7dGjeCr29vRyt
 I/FJqD6/E9wHeSVut5yLXJxpWVTKLxWC+rVgd3NKJZXMK8mr6Wg68nltpWZG7+uVsA
 KcAVb5/7IVLvlQf3P2b1yy0Yu8SfLPYsvXxqZK4A=
Date: Thu, 22 Aug 2019 08:56:01 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: "Paul A. Clarke" <pc@us.ibm.com>
Message-ID: <20190821225601.GG20890@umbus>
References: <1566401321-22419-1-git-send-email-pc@us.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="YrlhzR9YrZtruaFS"
Content-Disposition: inline
In-Reply-To: <1566401321-22419-1-git-send-email-pc@us.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH] ppc: Fix xsmaddmdp and friends
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--YrlhzR9YrZtruaFS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2019 at 10:28:41AM -0500, Paul A. Clarke wrote:
> From: "Paul A. Clarke" <pc@us.ibm.com>
>=20
> A class of instructions of the form:
>   op Target,A,B
> which operate like:
>   Target =3D Target * A + B
> have a bit set which distinguishes them from instructions that operate as:
>   Target =3D Target * B + A
>=20
> This bit is not being checked properly (using PPC_BIT macro), so all
> instructions in this class are operating incorrectly as the second form
> above.  The bit was being checked as if it were part of a 64-bit
> instruction opcode, rather than a proper 32-bit opcode.  Fix by using the
> macro (PPC_BIT32) which treats the opcode as a 32-bit quantity.
>=20
> Signed-off-by: Paul A. Clarke <pc@us.ibm.com>

Applied to ppc-for-4.2, thanks.

> ---
>  target/ppc/translate/vsx-impl.inc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/v=
sx-impl.inc.c
> index 3922686..8287e27 100644
> --- a/target/ppc/translate/vsx-impl.inc.c
> +++ b/target/ppc/translate/vsx-impl.inc.c
> @@ -1308,7 +1308,7 @@ static void gen_##name(DisasContext *ctx)          =
                           \
>      }                                                                   =
      \
>      xt =3D gen_vsr_ptr(xT(ctx->opcode));                                =
        \
>      xa =3D gen_vsr_ptr(xA(ctx->opcode));                                =
        \
> -    if (ctx->opcode & PPC_BIT(25)) {                                    =
      \
> +    if (ctx->opcode & PPC_BIT32(25)) {                                  =
      \
>          /*                                                              =
      \
>           * AxT + B                                                      =
      \
>           */                                                             =
      \

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--YrlhzR9YrZtruaFS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl1dzAEACgkQbDjKyiDZ
s5KLYQ/+Kj3r7+t/5YS20sfJ9YHJqoLazDcScjfAmwXCH8rtpDUwYgFhJ2lUEt1c
C9URmcTKW7Xzh9XAmaSmkN0PDe7DFJISMyscYhXJWi2xvsEnvevL2K2guF1bidGK
zkRX/gH+JExcEySlcLWTmSXjwHG+pq7Mo4epzjqG++ORossf31IPzeL+3ShJvweR
AXlJppCq06C4+7oBZV9L+fTTk3iBSBdyeyiHZcEnsUWiugKcMbdFhFaD9ojgJguk
JhgK38n+j0ersHfxOxl1BcUA+6JUiGHS2S/pqINEsOktBoyPt6gImYq2bhtMhUgB
uRk74GnE0R18Wskq0/6QRA9KiJQ+WWdSvgELjJwExSEpBaxIrL2KUGCE/Wn6vdCT
P2PghiYrx3n417u6dSdeKuiV0sQpDpay/dpgKNw/rRfkBhtpwma1MxrqQrjmsRF6
4WFVZ7+dGYx/FLA5Dy83CSFUYsPYGj2RDkCnx4CEse+DCJ8Z6GLEJubi7acEhXCu
iJuwLHrYoDEfpibN+FG2BF+wS823Xm0VfAZlh2goyg+RttxHQsSdW9xNQCuk8NUL
83GgHrgBldHMdXI9gPXmeFqbGcvQNFciZpjTmw/7/DX37VktuQ1NbjDlmPMVHqdU
NnbrVQ9UW4WC+rmolgeebPWFswkGFkY3ywuf6olN/kDAARNXT4w=
=55wV
-----END PGP SIGNATURE-----

--YrlhzR9YrZtruaFS--

