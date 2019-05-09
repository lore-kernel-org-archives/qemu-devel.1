Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2529FC04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 05:45:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4B312053B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 05:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Hd4BacrK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4B312053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48361 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hObs7-0006DB-Tv
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 01:45:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hObog-0003Qk-CO
	for qemu-devel@nongnu.org; Thu, 09 May 2019 01:42:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hObof-0001fg-8P
	for qemu-devel@nongnu.org; Thu, 09 May 2019 01:42:02 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:50965)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hOboe-0001ZC-RV; Thu, 09 May 2019 01:42:01 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 4502KB3f2Nz9sBV; Thu,  9 May 2019 15:41:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1557380510;
	bh=JJ1XiJXNVJExPmJGjzrTHq2+B2lmtiM1mVECW5XJNbw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hd4BacrKIZVxbHiLsX6hmoQJOJI6wvVTx1PMNJ0UakeZyyE1JDnYjmu/H4k5y8qV8
	PfM1tNNpxVVSi2OrQcBYRYjcJtkC/AL3zYOiWSXHJwsd28WExe1wJbHoO2D7Kd46/4
	GSqFTtK08EmJswvLHVoRsSmGKs88w1xqaXp1TTMI=
Date: Thu, 9 May 2019 15:33:01 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Anton Blanchard <anton@ozlabs.org>
Message-ID: <20190509053301.GQ7073@umbus.fritz.box>
References: <20190507004811.29968-1-anton@ozlabs.org>
	<20190507004811.29968-2-anton@ozlabs.org>
	<20190507052039.GF7073@umbus.fritz.box>
	<20190509061713.69490488@kryten>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7kD9y3RnPUgTZee0"
Content-Disposition: inline
In-Reply-To: <20190509061713.69490488@kryten>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH v2] target/ppc: Fix xxspltib
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


--7kD9y3RnPUgTZee0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 09, 2019 at 06:17:33AM +1000, Anton Blanchard wrote:
> xxspltib raises a VMX or a VSX exception depending on the register
> set it is operating on. We had a check, but it was backwards.
>=20
> Fixes: f113283525a4 ("target-ppc: add xxspltib instruction")
> Signed-off-by: Anton Blanchard <anton@ozlabs.org>

Applied, thanks.

> ---
>  target/ppc/translate/vsx-impl.inc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/v=
sx-impl.inc.c
> index 4d8ca7cf32..4812a374aa 100644
> --- a/target/ppc/translate/vsx-impl.inc.c
> +++ b/target/ppc/translate/vsx-impl.inc.c
> @@ -1355,13 +1355,13 @@ static void gen_xxspltib(DisasContext *ctx)
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

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--7kD9y3RnPUgTZee0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlzTu4oACgkQbDjKyiDZ
s5I9/Q/+NRQaSzQD3rqyOHi00yWsB76tVEmTIU3eg0Tjyih4jiuH2CqGaViuyULi
ceJwDfnC8vgCcXvQEXNb3Yt10/fmCirA/xKHw/lStLT0uFqqKVGlaRq5cVauwPQY
Wd8iRMJveEdtAkrU4C+TxY1MMR7tX0WAf9FmL+nH31WI2Yns7D4J7kIXBHBZF9Tj
SJsqNnZ8KB+093ESo3WsbGjEZybp6QeSktIJy51s8N41dIwc80nrZGGEy6DJ1l5P
5HTaPejuoNthdgXRZnJnPu3EDYyUwNLPvXAxE8g3TB9rnfuxehBf1hzSVsSBD8zl
VDZDIlT1F8ZHVCnqlTxmKtUp53z20jZRzmKtHpJdBKzKphpgY2KwdFuvJHN7CD0z
B47XORDF8mQUeDh6DrqmOlOza2KIspWqILrVGW++oht8gSbTUXpCGPWkhj8eItxr
UIef7YMbAQAXKVyqqJPLYFGvLVFU9BL/vVUqZrFPPIIaCbeSittlYqqdauM1SK4F
44S+/LBjVgjcRx4LotP1n85VBVEXxd4C84GSv+QUOm7YK8I8MnYmkId6aOE6GCvD
7NZjtDKmXBWpCkruIQuaQ+RoA3cJqKVMUU2lVni+wGZEOBy+jNshsf8vc6Rk1Dhu
s+W05hZ2hwC5mSqB/Dq99oRZxYRZ5hj60csB6TgoXABOWvU4Tzc=
=2pLS
-----END PGP SIGNATURE-----

--7kD9y3RnPUgTZee0--

