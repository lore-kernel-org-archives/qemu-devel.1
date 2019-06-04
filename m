Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88EF1C04AB5
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 02:17:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4602C2441C
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 02:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="oQohS2nH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4602C2441C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43992 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXz1I-0000o7-BW
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 22:17:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hXyzZ-0008D9-Fq
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 22:16:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hXyzY-0007SM-6a
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 22:16:01 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:55455)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1hXyzW-0006tb-OB
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 22:16:00 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 45HwWD3fX5z9s5c; Tue,  4 Jun 2019 12:15:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1559614536;
	bh=98A1GoWUfcboLTp6dEMOQ8XvfPmi2CSa8rTYlXY+I0A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oQohS2nH+u5u8vg42S3epeOsJkxRw6ta9JPYdBKPBq2Afk8O3wcXZYf9HEzDCEynI
	F+JpWmEfrkhka9tel07uMhhorlbNLzi9087ktDb1XSu013Io1CfEjY+VoJg7dNA51C
	micm+mAdvfIfw6YVr5rfdi2n9FLyQYAA4vncDCyk=
Date: Tue, 4 Jun 2019 11:21:48 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20190604012147.GB9045@umbus.fritz.box>
References: <20190603164927.8336-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="f2QGlHpHGjS2mn6Y"
Content-Disposition: inline
In-Reply-To: <20190603164927.8336-1-richard.henderson@linaro.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH] target/ppc: Use tcg_gen_gvec_bitsel
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


--f2QGlHpHGjS2mn6Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 03, 2019 at 11:49:27AM -0500, Richard Henderson wrote:
> Replace the target-specific implementation of XXSEL.

Applied, thanks.

>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/ppc/translate/vsx-impl.inc.c | 24 ++----------------------
>  1 file changed, 2 insertions(+), 22 deletions(-)
>=20
> diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/v=
sx-impl.inc.c
> index 199d22da97..a7a0a88975 100644
> --- a/target/ppc/translate/vsx-impl.inc.c
> +++ b/target/ppc/translate/vsx-impl.inc.c
> @@ -1338,28 +1338,8 @@ static void glue(gen_, name)(DisasContext *ctx)   =
          \
>  VSX_XXMRG(xxmrghw, 1)
>  VSX_XXMRG(xxmrglw, 0)
> =20
> -static void xxsel_i64(TCGv_i64 t, TCGv_i64 a, TCGv_i64 b, TCGv_i64 c)
> -{
> -    tcg_gen_and_i64(b, b, c);
> -    tcg_gen_andc_i64(a, a, c);
> -    tcg_gen_or_i64(t, a, b);
> -}
> -
> -static void xxsel_vec(unsigned vece, TCGv_vec t, TCGv_vec a,
> -                      TCGv_vec b, TCGv_vec c)
> -{
> -    tcg_gen_and_vec(vece, b, b, c);
> -    tcg_gen_andc_vec(vece, a, a, c);
> -    tcg_gen_or_vec(vece, t, a, b);
> -}
> -
>  static void gen_xxsel(DisasContext *ctx)
>  {
> -    static const GVecGen4 g =3D {
> -        .fni8 =3D xxsel_i64,
> -        .fniv =3D xxsel_vec,
> -        .vece =3D MO_64,
> -    };
>      int rt =3D xT(ctx->opcode);
>      int ra =3D xA(ctx->opcode);
>      int rb =3D xB(ctx->opcode);
> @@ -1369,8 +1349,8 @@ static void gen_xxsel(DisasContext *ctx)
>          gen_exception(ctx, POWERPC_EXCP_VSXU);
>          return;
>      }
> -    tcg_gen_gvec_4(vsr_full_offset(rt), vsr_full_offset(ra),
> -                   vsr_full_offset(rb), vsr_full_offset(rc), 16, 16, &g);
> +    tcg_gen_gvec_bitsel(MO_64, vsr_full_offset(rt), vsr_full_offset(rc),
> +                        vsr_full_offset(rb), vsr_full_offset(ra), 16, 16=
);
>  }
> =20
>  static void gen_xxspltw(DisasContext *ctx)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--f2QGlHpHGjS2mn6Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlz1x6kACgkQbDjKyiDZ
s5KXpxAAtPs6yoR1aghVLej4nlscZZ599yGdqIZQZEfr9AiCrrQQMmQavN1XyQDI
b2qhhJAybaTh2M2btZLPvY7I+aqMerQTZo2/FYXJoJHnan2ga9MsvmuAOQoF6lok
NxVlPLKQP8mHFRgkATguiLA7YKfDZoQd8H+tE9SUf9XHaK4qPiJxgU1wOkL06nL8
I7zek1eTFCIAXJNnpd4gQVAQ9Jx4nQ6dGOGbk29fRfDS3qZON544PbzP+0O8/Dmf
7vytu3Q1cXJHi8Truh/ptvnlYsh6zm6YJ6Lm7rr5/tTxDRFpmO9f+nOykQmBrmMx
69LDeYzWlDlAKixGDhWWg8diutt7MzdKx7YxkTx6dT53ResSgKtdgQvYZ3CBCHBq
OJKugcXOgDkxPlrtVAtx3NO7UydZ26i8+aIWa3wjWxeaYV9+PhU6Q0JSZRLddYfE
Angk/uGrmpwVvJH+jOhP15maSSGWKMR1UBLxfvoYcvN3o6h1LWtxjH5EPMBk3jkJ
m3WmcOhFO9QQvcHtaW8VQ9mV5nZZL/Z/b/Nnz84odWKrYj6EwQbNMHD8EZR+VLx7
jbAmWryh948UWpshw6jyPYvb4WBWumpQ4a8Dfhurc6uoTx0x+G946WJy4JhPEhot
LMCkXXFJ9cUo4PkgT9IRhDNt+tRv6HpQhXYvq4Yz5jVnoo1xFTo=
=WQHf
-----END PGP SIGNATURE-----

--f2QGlHpHGjS2mn6Y--

