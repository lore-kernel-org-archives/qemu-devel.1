Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD6AC004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 06:25:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2DF5206A3
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 06:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="XLTWX8Mm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2DF5206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40735 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNtXZ-00021C-S1
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 02:25:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hNtVh-0000m7-PR
	for qemu-devel@nongnu.org; Tue, 07 May 2019 02:23:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hNtVg-0002dM-Rw
	for qemu-devel@nongnu.org; Tue, 07 May 2019 02:23:29 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:36309)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hNtVf-0002Ym-07; Tue, 07 May 2019 02:23:28 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 44yqL22L2yz9sBr; Tue,  7 May 2019 16:23:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1557210202;
	bh=A39wRRlX3cYbyv9BrRjasHJBrv3tDopDuCY7eSVfa2c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XLTWX8MmZX1munJ1f8Zl62e8k5wJSfyUmReDtQ8HXG9SUy8m0Y1oWUm+QUfgiGN0k
	eyHRxCU5yiIRe1+Cw4loeR2AcZb8rCZuldOTkVbnLwYpFnwSqjXH3jphoRbz9XKlKY
	DqtZBZAaoZ79/52JLnMJeqTWh974Pt5oX7Up+VcU=
Date: Tue, 7 May 2019 15:18:52 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Anton Blanchard <anton@ozlabs.org>
Message-ID: <20190507051852.GE7073@umbus.fritz.box>
References: <20190507004811.29968-1-anton@ozlabs.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="so9zsI5B81VjUb/o"
Content-Disposition: inline
In-Reply-To: <20190507004811.29968-1-anton@ozlabs.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH 1/9] target/ppc: Fix xvxsigdp
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


--so9zsI5B81VjUb/o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 07, 2019 at 10:48:03AM +1000, Anton Blanchard wrote:
> Fix a typo in xvxsigdp where we put both results into the lower
> doubleword.
>=20
> Fixes: dd977e4f45cb ("target/ppc: Optimize x[sv]xsigdp using deposit_i64(=
)")
> Signed-off-by: Anton Blanchard <anton@ozlabs.org>

Applied, thanks.

> ---
>  target/ppc/translate/vsx-impl.inc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/v=
sx-impl.inc.c
> index 11d9b75d01..4d8ca7cf32 100644
> --- a/target/ppc/translate/vsx-impl.inc.c
> +++ b/target/ppc/translate/vsx-impl.inc.c
> @@ -1820,7 +1820,7 @@ static void gen_xvxsigdp(DisasContext *ctx)
>      tcg_gen_movi_i64(t0, 0x0010000000000000);
>      tcg_gen_movcond_i64(TCG_COND_EQ, t0, exp, zr, zr, t0);
>      tcg_gen_movcond_i64(TCG_COND_EQ, t0, exp, nan, zr, t0);
> -    tcg_gen_deposit_i64(xth, t0, xbl, 0, 52);
> +    tcg_gen_deposit_i64(xtl, t0, xbl, 0, 52);
>      set_cpu_vsrl(xT(ctx->opcode), xtl);
> =20
>      tcg_temp_free_i64(t0);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--so9zsI5B81VjUb/o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlzRFTwACgkQbDjKyiDZ
s5JN4g/7BIR5gJNXbH1Sj1XlLQATVsDg693rRoLV9kM4/BkcDY0FLCOKKSEXg3S4
ogxeHJHvlQlTiJkak55DP6BLUY5O7B9iP3f7ZtGrw310dA3O/hGgzovPsotyrhNI
ZnRfFa+3gkNcckwyTtV6Jy9tXa28Va8Pzu9oaPb/VYtQ5Qh7a0XGFo97nsWiU82z
lg6Ea9+RIdyHSg+cPWqcnYSx0ZIzcwf79g9/ddAwxnKij4/Ge5oDNIsz5Z6G5NjE
sv0xG8XM+pSGMrRBPlh/4lTMYaw4PYs9e9EvoBz6NtHRpS+1UWXYsm+QfoSHLkQk
+dstI1atQkiopxQ5vJCYwotp3RpvYxYz1V/knM5E0y3OVdg41RRdNfeK37VEf5Ck
obMh6ln9GLzjxROWOd7/CbMJdm3psirxBywsid2XPATGA1U6QKcFv8adAM8DzESm
6QwbgDKX02Y6OF9wW61K4TSXB6dd43L2FpGpRuLcP91vFSe1w7K8PD4foy7NMxS+
w133MRpEFP6+qv9A0NEQIb2xXk+IAd+YPVZT3ryD4csW2MT4ep5fPbVl9/vMNCar
CMvW2dKo5Vbn6Xfw/m6mngBO8YRt7GfX2yE2ZY9tz3pHhud5VFv22CR9TpbCXd5C
1y7PTwlWw5urBbBU1XJcu7DQIoO9R15HyVHj+cq+51cU/Ci3bfE=
=IMR4
-----END PGP SIGNATURE-----

--so9zsI5B81VjUb/o--

