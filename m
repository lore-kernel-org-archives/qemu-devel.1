Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0322BC3A59B
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 06:31:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C058420851
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 06:31:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="A0SuZRNV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C058420851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzbCI-00088z-SH
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 02:31:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52753)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1hzbBP-0007Sf-OO
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 02:30:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hzbBO-0001WL-B6
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 02:30:23 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:58673 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hzbBN-0001Rq-0x; Mon, 19 Aug 2019 02:30:22 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46BkYw4cWNz9sNF; Mon, 19 Aug 2019 16:30:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1566196212;
 bh=qncahDD/zDfQatmm5dmG4qskxPt8N0CvVbI8Ipq5D68=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=A0SuZRNVLLsBTRV+LeIKXeK/Fj9CZ9g03VsKtaw31yIGfWeaOBD/WBTmTBhTdOoLu
 nquiPC6Ax/TylJ6qb+hu4G0wZ8NJGVUoVS6HfKs1apteXe8hhkV1PlILqLtv+am0Fo
 P/zwOt+l3Qf2gEY6a+NfoTFvcfrA2UBjCpvAiAuA=
Date: Mon, 19 Aug 2019 16:30:03 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: "Paul A. Clarke" <pc@us.ibm.com>
Message-ID: <20190819063003.GB24503@umbus.fritz.box>
References: <1565983669-6886-1-git-send-email-pc@us.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="MfFXiAuoTsnnDAfZ"
Content-Disposition: inline
In-Reply-To: <1565983669-6886-1-git-send-email-pc@us.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH] ppc: Three floating point fixes
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


--MfFXiAuoTsnnDAfZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2019 at 02:27:49PM -0500, Paul A. Clarke wrote:
> From: "Paul A. Clarke" <pc@us.ibm.com>
>=20
> - target/ppc/fpu_helper.c:
>   - helper_todouble() was not properly converting INFINITY from 32 bit
>   float to 64 bit double.
>   - helper_todouble() was not properly converting any denormalized
>   32 bit float to 64 bit double.
>=20
> - GCC, as of version 8 or so, takes advantage of the hardware's
>   implementation of the xscvdpspn instruction to optimize the following
>   sequence:
>     xscvdpspn vs0,vs1
>     mffprwz   r8,f0
>   ISA 3.0B has xscvdpspn leaving its result in word 1 of the target regis=
ter,
>   and mffprwz expecting its input to come from word 0 of the source regis=
ter.
>   This sequence fails with QEMU, as a shift is required between those two
>   instructions.  However, the hardware splats the result to both word 0 a=
nd
>   word 1 of its output register, so the shift is not necessary.
>   Expect a future revision of the ISA to specify this behavior.

As well as addressing Richard's comments, I'd prefer to see each of
the 3 fixes here in separate patches.  The code changes may be tiny,
but I find the fpu emulation code cryptic at the best of times, and
making it clear which change is addressing which bug would help.

> Signed-off-by: Paul A. Clarke <pc@us.ibm.com>
> ---
>  target/ppc/fpu_helper.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
> index 5611cf0..82b5425 100644
> --- a/target/ppc/fpu_helper.c
> +++ b/target/ppc/fpu_helper.c
> @@ -62,13 +62,14 @@ uint64_t helper_todouble(uint32_t arg)
>          ret  =3D (uint64_t)extract32(arg, 30, 2) << 62;
>          ret |=3D ((extract32(arg, 30, 1) ^ 1) * (uint64_t)7) << 59;
>          ret |=3D (uint64_t)extract32(arg, 0, 30) << 29;
> +        ret |=3D (0x7ffULL * (extract32(arg, 23, 8) =3D=3D 0xff)) << 52;
>      } else {
>          /* Zero or Denormalized operand.  */
>          ret =3D (uint64_t)extract32(arg, 31, 1) << 63;
>          if (unlikely(abs_arg !=3D 0)) {
>              /* Denormalized operand.  */
>              int shift =3D clz32(abs_arg) - 9;
> -            int exp =3D -126 - shift + 1023;
> +            int exp =3D -127 - shift + 1023;
>              ret |=3D (uint64_t)exp << 52;
>              ret |=3D abs_arg << (shift + 29);
>          }
> @@ -2871,10 +2872,14 @@ void helper_xscvqpdp(CPUPPCState *env, uint32_t o=
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

--MfFXiAuoTsnnDAfZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl1aQeoACgkQbDjKyiDZ
s5L7Zw/+JiCGfGBRadMSAq+D5vtWNMxIWfUCvDUuL9XWBtdUh3cFp5jnta8f7jFj
CRg6I4bompechW1/2cQy8XHwl09lLMDi+TRH9izE3Wp1L49cplkE5F7WJb7fsHtj
LTFpOxST301GfLeVCHI2Z7PEddI21Aj89dL1GRTZqyzlB3nwXivbmnZXXaPOjYMo
p/HP+IWGwkQa5CJhOs4HK7fbvQZJuqUSyGOn+3yAacIkBgvmK5m47Z6Feve9+I0P
1HqagxUl85oOTOYplo2mRXLIVSJ6SKGPtcs706kkjbVQ0X3lu+P4ZNqJbM4lypxw
ZBGDulL/uDmlM1PYo5926K9jAeVfDBTAk+Ctz8v5ORfJFjV+0uOKWtLSoYxFTx+v
Aldc+XSMq500n3Jj632XVltVVqVUzy3CQVuX6decA/2pQNK1wZcYpAOGK29jtjKL
y7sTvMD64DJJLAd/gbYNiFEcjkbADIS9wh9hvxCBlvwpekzptCZgfC+MsbCQIoGI
W2XtTRi/ck87tHrXc5Mdb1wdrH01Z8xTb/1BT6IRInXWTCrYLJZ/GzUEWwhWdlK7
VLwq5Mt/uuNtZB97eVmcmV+74pndELYjLko02zZzvTY6RueOYXAUyinMxrdadEtd
R1H851kbgZ/um3yAEUAfNij+qOW6asPV+0O8uLk1Zu585lyPgEs=
=sI1V
-----END PGP SIGNATURE-----

--MfFXiAuoTsnnDAfZ--

