Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3648DC3A5A0
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 01:34:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F385B22DA7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 01:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="N1mY3ET3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F385B22DA7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzt2J-00010f-6B
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 21:34:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33689)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1hzszO-0006sg-Rc
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 21:31:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hzszM-0008F2-I1
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 21:31:10 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:51797 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hzszI-0008BZ-QB; Mon, 19 Aug 2019 21:31:06 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46CCtB4YWxz9sML; Tue, 20 Aug 2019 11:30:58 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1566264658;
 bh=KaoGbYN34/ZymmVYggXkmdR5AhYcb5acqMo2xRZcamI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=N1mY3ET3TV2kM8Bk96zxVMJ0Q4GIPLKroUrEVRXRCoLkjbUrq2IxiQdgNeRZJjW70
 aOs6MD1KNIBndWXyEbb30FgSQyaobmAoqqiSVV7NwlvEhAlJ5LtFyGD9ivko9Wm4yQ
 hePuknjlG3ZQD9ikNZvMwxYpccMBHcDHhubYi0ZQ=
Date: Tue, 20 Aug 2019 10:58:19 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: "Paul A. Clarke" <pc@us.ibm.com>
Message-ID: <20190820005819.GD24503@umbus.fritz.box>
References: <1566236601-22954-1-git-send-email-pc@us.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ytoMbUMiTKPMT3hY"
Content-Disposition: inline
In-Reply-To: <1566236601-22954-1-git-send-email-pc@us.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH v2] ppc: conform to processor User's Manual
 for xscvdpspn
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
Cc: richard.henderson@linaro.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--ytoMbUMiTKPMT3hY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2019 at 12:43:21PM -0500, Paul A. Clarke wrote:
> From: "Paul A. Clarke" <pc@us.ibm.com>
>=20
> The POWER8 and POWER9 User's Manuals specify the implementation
> behavior for what the ISA leaves "undefined" behavior for the
> xscvdpspn and xscvdpsp instructions.  This patch corrects the QEMU
> implementation to match the hardware implementation for that case.
>=20
> ISA 3.0B has xscvdpspn leaving its result in word 0 of the target registe=
r,
> with the other words of the target register left "undefined".
>=20
> The User's Manuals specify:
>   VSX scalar convert from double-precision to single-precision (xscvdpsp,
>   xscvdpspn).
>   VSR[32:63] is set to VSR[0:31].
> So, words 0 and 1 both contain the result.
>=20
> Note: this is important because GCC as of version 8 or so, assumes and ta=
kes
> advantage of this behavior to optimize the following sequence:
>   xscvdpspn vs0,vs1
>   mffprwz   r8,f0
> ISA 3.0B has xscvdpspn leaving its result in word 0 of the target registe=
r,
> and mffprwz expecting its input to come from word 1 of the source registe=
r.
> This sequence fails with QEMU, as a shift is required between those two
> instructions.  However, since the hardware splats the result to both word=
s 0
> and 1 of its output register, the shift is not necessary.
>=20
> Expect a future revision of the ISA to specify this behavior.
>=20
> Signed-off-by: Paul A. Clarke <pc@us.ibm.com>

Applied to ppc-for-4.2, thanks.

>=20
> v2
> - Splitting patch "ppc: Three floating point fixes"; this is just one par=
t.
> - Updated commit message to clarify behavior is documented in User's Manu=
als.
> - Updated commit message to correct which words are in output and source =
of
>   xscvdpspn and mffprz.
> - No source changes to this part of the original patch.
>=20
> ---
>  target/ppc/fpu_helper.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
> index 5611cf0..23b9c97 100644
> --- a/target/ppc/fpu_helper.c
> +++ b/target/ppc/fpu_helper.c
> @@ -2871,10 +2871,14 @@ void helper_xscvqpdp(CPUPPCState *env, uint32_t o=
pcode,
> =20
>  uint64_t helper_xscvdpspn(CPUPPCState *env, uint64_t xb)
>  {
> +    uint64_t result;
> +
>      float_status tstat =3D env->fp_status;
>      set_float_exception_flags(0, &tstat);
> =20
> -    return (uint64_t)float64_to_float32(xb, &tstat) << 32;
> +    result =3D (uint64_t)float64_to_float32(xb, &tstat);
> +    /* hardware replicates result to both words of the doubleword result=
=2E  */
> +    return (result << 32) | result;
>  }
> =20
>  uint64_t helper_xscvspdpn(CPUPPCState *env, uint64_t xb)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ytoMbUMiTKPMT3hY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl1bRasACgkQbDjKyiDZ
s5IgGg//YfpBJ6YjzIlJdQC31MsuN9731b03O2tPFYPJ2alSxNxHAVLw8IYCWuFd
VNsUGHvykSzQuNn6uFGUD/SUV1pdMgt6DHMUUL4ATELNDX1i8NGvnOqfh1BauU6i
LpLjmidFG3hrs7yPGJZl4yCCkZ1bvb5IodqoPlIP2SHsdfmrH33OnkyeSxDbcRH0
JjtRaNJLyy9NJW3dOyHlxg+FsHS0u+dap39Wa/kRlM3lnbboLwqLeKtVC4Df5jsQ
+Yg2gCxmxpCyp2bBb6+IzGrJNA/yY1PK71N6gLZj3fFuAk+DqKw51FduXL9+5eCP
D26NzUxInsSpRO58SA9ihGLq4IAokoKyNuUe1v1f94EbtKJKg50jgqSbJag4KizJ
RaHKVsa273+oEBZF+5ygOE6333TXf4mx95CzK7dDUfRa+t4thSqQCBiJ/TPEhGyd
Rcj2UXpodiL7y4QyJh4GURKkjf5YoYwlYY+1BjQ02UgaFSnteqgR2D4ar/znnMoM
stE4p/svO1dr/y19oHgor4OgZm43S0VeKpo3Do0bFwsCBDpBoB+o1Muh2o5s2CpY
IHR5EFS5fnIljLgKGKJIdOzsCjmwjZ2+qDpvO6rgpmvZIaq84tace8UmwZa7Vn7i
NZNMu6JqMCn7BnXkNZFVvRdCVtdtGtH4JmhsKGI0fheKKduQEQ4=
=sULM
-----END PGP SIGNATURE-----

--ytoMbUMiTKPMT3hY--

