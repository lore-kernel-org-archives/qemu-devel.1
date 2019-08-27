Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1DDFC3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 04:23:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80CC52070B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 04:23:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="l/9LSm7/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80CC52070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2T1E-0005gA-O0
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 00:23:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60929)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1i2SyD-00037T-DE
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 00:20:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1i2SyB-0003qK-R9
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 00:20:37 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:44997 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1i2SyB-0003pL-47; Tue, 27 Aug 2019 00:20:35 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46HbJY4lrrz9sML; Tue, 27 Aug 2019 14:20:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1566879629;
 bh=1tAsRpLk3yYA321boYuACIl6sJMqX7Kh+pRfd9XjYOI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=l/9LSm7/YGY3Bw6wOYXbwgZRZwn/0HVYSimnvH2UnOIbWoUllv8/r7rqCCfYTkpqS
 sX9M2IWsNyUQWnlSSQyDEYxFFWp8ihxD4reTXdzFRUwfCe0VWhxi+i6eu/jNeQKNU4
 u8zcQZI8WqPBqufmRWpucguo8SuXvLf4/YlDAEm0=
Date: Tue, 27 Aug 2019 13:42:37 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20190827034237.GA10107@umbus.fritz.box>
References: <20190826165434.18403-1-richard.henderson@linaro.org>
 <20190826165434.18403-2-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline
In-Reply-To: <20190826165434.18403-2-richard.henderson@linaro.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH 1/1] target/ppc: Fix do_float_check_status
 vs inexact
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, pc@us.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2019 at 09:54:34AM -0700, Richard Henderson wrote:
> The underflow and inexact exceptions are not mutually exclusive.
> Check for both of them.  Tidy the reset of FPSCR[FI].
>=20
> Fixes: https://bugs.launchpad.net/bugs/1841442
> Reported-by: Paul Clarke <pc@us.ibm.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Applied to ppc-for-4.2, thanks.

> ---
>  target/ppc/fpu_helper.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>=20
> diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
> index 07bc9051b0..2e023c5204 100644
> --- a/target/ppc/fpu_helper.c
> +++ b/target/ppc/fpu_helper.c
> @@ -630,19 +630,15 @@ static void do_float_check_status(CPUPPCState *env,=
 uintptr_t raddr)
>  {
>      CPUState *cs =3D env_cpu(env);
>      int status =3D get_float_exception_flags(&env->fp_status);
> -    bool inexact_happened =3D false;
> =20
>      if (status & float_flag_overflow) {
>          float_overflow_excp(env);
>      } else if (status & float_flag_underflow) {
>          float_underflow_excp(env);
> -    } else if (status & float_flag_inexact) {
> -        float_inexact_excp(env);
> -        inexact_happened =3D true;
>      }
> -
> -    /* if the inexact flag was not set */
> -    if (inexact_happened =3D=3D false) {
> +    if (status & float_flag_inexact) {
> +        float_inexact_excp(env);
> +    } else {
>          env->fpscr &=3D ~(1 << FPSCR_FI); /* clear the FPSCR[FI] bit */
>      }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--gKMricLos+KVdGMg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl1kpq0ACgkQbDjKyiDZ
s5K1vg/7BAUJRJSPDoWXKykxNofji2F+m8LvOOEx0i8RFBnzIrj+3awsIuIm/tCn
+TUpV3OWCLmT5spP06uu3vBD6FECPdhpCYs3R3M3IN63+tsB7gMXvDS3T5ggAlsr
nXDGeUmxpxv0E0oX5eBQ9oSqBmeEuoZNoLkk4jfOKrVBgL13vF9Fki8xoWMJZvp5
i5+MT7iFTiLIvW81x7Lout/n9bb+4mHACofJInkFXV9tieqP0T6kSe0aQUKQ7KkM
vr9tm0UGx/0soKqXbOu5JyMmE78+ymIjip/wXdXlGMY63mQXKq3C4mZjJl8uII92
uR/tStYAONojG4vi8XUQpq8p4bCNwVKuNO9gYtPFYBBUV03JM0in2pXQt/NwDMSL
JaMCAVnDacK9oEMyTThnhH5CMRkNwu3AGTM9uDOiUMFamYdiVf1W+UdL7K4HfubX
FOfKvtsNL4uUU41fO+2RA13Fs2RcVMSB+HR5kpgVSfHY6dcA17d4KRS2634FL0cx
el6rXrjm7c4jBiiAvsZLK0bNid/ENNYcFceGsOjXQFhRvoRfWcDQtWR9UR3LgdNJ
kMdGS8+fg0lveLA9TBMLZydODkTBvtSyl6Ik2GAxbtyx4v1zl80q0KwLrCSL/hE/
Wa29igX5QfFYPft7bQ+4BvE9/YWNEcBX+5jjXK6k8jr+5sthHmw=
=VHx0
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--

