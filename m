Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B91C04E53
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 01:50:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E6C220873
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 01:50:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="clu8X6XN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E6C220873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46896 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hR5XU-0001Dt-Er
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 21:50:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hR5WE-0000dX-Qg
	for qemu-devel@nongnu.org; Wed, 15 May 2019 21:49:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hR5WC-0007uH-Pp
	for qemu-devel@nongnu.org; Wed, 15 May 2019 21:49:14 -0400
Received: from ozlabs.org ([203.11.71.1]:50833)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1hR5WB-0007qa-Qk
	for qemu-devel@nongnu.org; Wed, 15 May 2019 21:49:12 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 454DqQ5nzvz9sN6; Thu, 16 May 2019 11:49:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1557971346;
	bh=+Yb/ps7RbInSZhSEu5yH1Y5lF3G1IUCyKY37LtRnC9Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=clu8X6XN4st60fBL++fK2Y3sJLayKMjrPWDa+5Za4CZoW4TX4e2IDqmbh7s58+2c3
	DoqguODlj/gtvLSoKzKTGknFDS1n+7IX8euvlL53uPVg6d4/xXGC9BKjbL5oK7ajqY
	0I3+KI25ApLfKCdc5xIV1xS7dI3woy7+lDAyK2FM=
Date: Thu, 16 May 2019 11:48:52 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20190516014852.GF3207@umbus.fritz.box>
References: <20190510173049.28171-1-richard.henderson@linaro.org>
	<20190510173049.28171-25-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="s5/bjXLgkIwAv6Hi"
Content-Disposition: inline
In-Reply-To: <20190510173049.28171-25-richard.henderson@linaro.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH v6 24/25] target/ppc: Use gen_io_start/end
 around DARN
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--s5/bjXLgkIwAv6Hi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2019 at 10:30:48AM -0700, Richard Henderson wrote:
> Generating a random number counts as I/O, as it cannot be
> replayed and produce the same results.
>=20
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  target/ppc/translate.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
>=20
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 8d08625c33..76628df6dd 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -1847,13 +1847,22 @@ static void gen_darn(DisasContext *ctx)
>  {
>      int l =3D L(ctx->opcode);
> =20
> -    if (l =3D=3D 0) {
> -        gen_helper_darn32(cpu_gpr[rD(ctx->opcode)]);
> -    } else if (l <=3D 2) {
> -        /* Return 64-bit random for both CRN and RRN */
> -        gen_helper_darn64(cpu_gpr[rD(ctx->opcode)]);
> -    } else {
> +    if (l > 2) {
>          tcg_gen_movi_i64(cpu_gpr[rD(ctx->opcode)], -1);
> +    } else {
> +        if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
> +            gen_io_start();
> +        }
> +        if (l =3D=3D 0) {
> +            gen_helper_darn32(cpu_gpr[rD(ctx->opcode)]);
> +        } else {
> +            /* Return 64-bit random for both CRN and RRN */
> +            gen_helper_darn64(cpu_gpr[rD(ctx->opcode)]);
> +        }
> +        if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
> +            gen_io_end();
> +            gen_stop_exception(ctx);
> +        }
>      }
>  }
>  #endif

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--s5/bjXLgkIwAv6Hi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlzcwYMACgkQbDjKyiDZ
s5LMyg//efdbZBeq4qoSsDGWqruAuQcfoOsNvA4ja13b1yhUg3CsBiPqYUdOLtk/
uPgu4DnMH9IK6scPT7aIFh7es4T9NA2LFTmnoT40x5Pog6jL7hyWF3i2QxA8cYat
DtIM5wXbSw7CZRpYKHy7ftj5LVuBvGsappIdlFWdezFs90KhZILVtv7uWTyigiE1
22twHMfSKIJ/5Na0QTWMaTrIuFuoH+qOjvWynzK9TV5+50/de3zzjmzlTLmMUj/b
NHzNhnFI+3loNJBMPBt1huUGx2LpudbeN2d2RWnUQCoiLzqCl/ynfEkl0J0p8pAX
u8ai3qoUdSQ0SDQtl/rdHf6GTvS7Wd90JZzFFtOm3QfWxKJt5P9iaisxQc4vidBj
5WTkdlUZiI5aIqATpWEVTidJpWl0M7CG93+vroJY3TI3/M3rQJOeuoeQwdxixJ4k
xRbKFV+A5T7AMFWIEKRkDe36XLEbjeCYzXaM5bi0yZ0+72YLBYwJHdUrdmla8mR7
KFyiOxNeEGJV/eSORRVM6GDZmFR4RLW37fp27woXX7GUCkuNRECbbD5Hrg1St/Gb
e0MJ5/5LOGm/W1+MJBXWlUSCh2LMJjHVU2G2JbWEVDOsiecV2dYkXZOmmvL21a9+
4/XmALq1lSaBibw7vBrNW6eYJr88lOsagmw5LW/9xV6Ov9kxOMM=
=5xmJ
-----END PGP SIGNATURE-----

--s5/bjXLgkIwAv6Hi--

