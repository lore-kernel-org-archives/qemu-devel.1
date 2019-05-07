Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6332C04AAD
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 06:25:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 709EF206A3
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 06:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="AUq2852w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 709EF206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40739 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNtXc-00022G-ME
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 02:25:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hNtVh-0000mD-U3
	for qemu-devel@nongnu.org; Tue, 07 May 2019 02:23:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hNtVg-0002dG-RU
	for qemu-devel@nongnu.org; Tue, 07 May 2019 02:23:29 -0400
Received: from ozlabs.org ([203.11.71.1]:51053)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hNtVe-0002Yk-UG; Tue, 07 May 2019 02:23:27 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 44yqL21kCKz9sB8; Tue,  7 May 2019 16:23:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1557210202;
	bh=GbPCRSaNKC2k1UFTcKFQpSOz02oTnGKpP3jVFm9/EtU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AUq2852wAf8PM3eWwSCGNEQaWS8aU5K3hvWZb/fIWL+kfWmETUVHQ1qvuLURJfGx1
	xrgrVAhPoeGpdzDUnkhM8kjCFIgvAgBsnIJUl0V7atBzRS+YR6Swx83TMQS9JmC7jP
	19uUMZN85DhLqL6DvHdL9XO0DyFzJJ2zCc7EXTSI=
Date: Tue, 7 May 2019 15:20:40 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Anton Blanchard <anton@ozlabs.org>, y@umbus.fritz.box
Message-ID: <20190507052039.GF7073@umbus.fritz.box>
References: <20190507004811.29968-1-anton@ozlabs.org>
	<20190507004811.29968-2-anton@ozlabs.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vA66WO2vHvL/CRSR"
Content-Disposition: inline
In-Reply-To: <20190507004811.29968-2-anton@ozlabs.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH 2/9] target/ppc: Fix xxspltib
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: ego@linux.vnet.ibm.com, sandipandas1990@gmail.com,
	mark.cave-ayland@ilande.co.uk, richard.henderson@linaro.org,
	qemu-devel@nongnu.org, f4bug@amsat.org, qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--vA66WO2vHvL/CRSR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 07, 2019 at 10:48:04AM +1000, Anton Blanchard wrote:
> xxspltib raises a VMX or a VSX exception depending on the register
> set it is operating on. We had a check, but it was backwards.
>=20
> Fixes: f113283525a4 ("target-ppc: add xxspltib instruction")
> Signed-off-by: Anton Blanchard <anton@ozlabs.org>
> ---
>  target/ppc/translate/vsx-impl.inc.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/v=
sx-impl.inc.c
> index 4d8ca7cf32..d050cc03ed 100644
> --- a/target/ppc/translate/vsx-impl.inc.c
> +++ b/target/ppc/translate/vsx-impl.inc.c
> @@ -1355,16 +1355,17 @@ static void gen_xxspltib(DisasContext *ctx)
>      int rt =3D xT(ctx->opcode);
> =20
>      if (rt < 32) {
> -        if (unlikely(!ctx->altivec_enabled)) {
> -            gen_exception(ctx, POWERPC_EXCP_VPU);
> +        if (unlikely(!ctx->vsx_enabled)) {
> +            gen_exception(ctx, POWERPC_EXCP_VSXU);
>              return;
>          }
>      } else {
> -        if (unlikely(!ctx->vsx_enabled)) {
> -            gen_exception(ctx, POWERPC_EXCP_VSXU);
> +        if (unlikely(!ctx->altivec_enabled)) {
> +            gen_exception(ctx, POWERPC_EXCP_VPU);
>              return;
>          }
>      }
> +    printf("XT %x IMM8 %x\n", rt, uim8);

Looks like you have some leftover debugging here.

>      tcg_gen_gvec_dup8i(vsr_full_offset(rt), 16, 16, uim8);
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--vA66WO2vHvL/CRSR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlzRFacACgkQbDjKyiDZ
s5LFEBAAqLHwEf1ScoHwymawpzWNxlXP2RTnowU7I/hPzRebuWJipGpZCpGzqO5y
L2IxXOM2sYCwDuskvRl1Npvn9Psg1JAZdAzODcAHaoJxDhc2U1kWVp+awasvUaw5
+wZ/A6uBSewTPNY8U9Oqw62lWdQLLDotkb9dI8pfrY5oEiTf5u2ybQL+xkpsudUA
ylWrz/EXe+tTktIywIFvPRkT3E12qZzfDvbAagGsGFyMwPxsuNF5y8dG43/uQttC
jJUfByeTXjYSZVZ/hhnbgXdc8VBUU1ebn1gh4U5ZnKmy60g0bduRDf98NMiAmcS8
Zhj8Ua++G8pihpG8mLT1aNxbiH9YpwUYR2LHjcvvHJP6HkTDPEbTkyNacva0vh0N
S3+6z5wrMuaGUtPjpO1fwp5WmGIl6TYvIj5NzTPxXiTewal+/Nfb0m81dozQa7yc
34ClH09nCaetA1ZgDOhMdb4jyaMIk9NYSSjo4KsiT0OClAs7yMary2AmYEH2yvh8
ZbUzds1E+keNy+wwkiU8n4k3x5wX1NZbRXUDTeJY+75ckc5yGvP4kS4aLoVFq6DL
FtKZN/VwXw9T9wWmB9VCdLAjrTwEXRw5ybnE+417H1wGJZ9P/m8HLxlcc7uaYp/t
y9YIdQnnZFZLedoTAP69SoZpFfLlYaTP95R/KUM+IS6Vy1gM+RI=
=F6LM
-----END PGP SIGNATURE-----

--vA66WO2vHvL/CRSR--

