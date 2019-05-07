Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B1D2C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 06:30:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 051BF206A3
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 06:30:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="bYLlN4w3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 051BF206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40855 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNtcs-0006ui-69
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 02:30:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hNtVn-0000o7-4P
	for qemu-devel@nongnu.org; Tue, 07 May 2019 02:23:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hNtVl-0002hP-AQ
	for qemu-devel@nongnu.org; Tue, 07 May 2019 02:23:34 -0400
Received: from ozlabs.org ([203.11.71.1]:46335)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hNtVi-0002dr-Tz; Tue, 07 May 2019 02:23:31 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 44yqL26ljvz9sNQ; Tue,  7 May 2019 16:23:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1557210202;
	bh=1Q/tBv42AO7m210RbmREzzJVAPcuWnvk2a3Vhjn6h6E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bYLlN4w3DW4n0fG9IaLPubiJyzpKY/6buVsk2t0xJTOF0p1Er6umkVLRXb9zPcZZR
	VqF2MQdQv8zb0TJEOyxQcmLdX48ivZ4ESsuRWVfQb5EKi+194ij1DL7LEs35niVbGq
	7Eikqx+TNgPwqiZQZT3ScAPYdRJcZnacDs8UNUOw=
Date: Tue, 7 May 2019 15:28:15 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Anton Blanchard <anton@ozlabs.org>
Message-ID: <20190507052815.GK7073@umbus.fritz.box>
References: <20190507004811.29968-1-anton@ozlabs.org>
	<20190507004811.29968-4-anton@ozlabs.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mPOSj6iWmtyhwOMz"
Content-Disposition: inline
In-Reply-To: <20190507004811.29968-4-anton@ozlabs.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH 4/9] target/ppc: Fix lxvw4x,
 lxvh8x and lxvb16x
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


--mPOSj6iWmtyhwOMz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 07, 2019 at 10:48:06AM +1000, Anton Blanchard wrote:
> During the conversion these instructions were incorrectly treated as
> stores. We need to use set_cpu_vsr* and not get_cpu_vsr*.
>=20
> Fixes: 8b3b2d75c7c0 ("introduce get_cpu_vsr{l,h}() and set_cpu_vsr{l,h}()=
 helpers for VSR register access")
> Signed-off-by: Anton Blanchard <anton@ozlabs.org>
> ---
>  target/ppc/translate/vsx-impl.inc.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>=20
> diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/v=
sx-impl.inc.c
> index 05b75105be..c13f84e745 100644
> --- a/target/ppc/translate/vsx-impl.inc.c
> +++ b/target/ppc/translate/vsx-impl.inc.c
> @@ -102,8 +102,7 @@ static void gen_lxvw4x(DisasContext *ctx)
>      }
>      xth =3D tcg_temp_new_i64();
>      xtl =3D tcg_temp_new_i64();
> -    get_cpu_vsrh(xth, xT(ctx->opcode));
> -    get_cpu_vsrl(xtl, xT(ctx->opcode));
> +

Something seems amiss here.  Clearly we do need a set..() back to the
loaded register, but with the removal of these gets, it doesn't look
like the xth and xtl temporaries are initialized any more.

>      gen_set_access_type(ctx, ACCESS_INT);
>      EA =3D tcg_temp_new();
> =20
> @@ -126,6 +125,8 @@ static void gen_lxvw4x(DisasContext *ctx)
>          tcg_gen_addi_tl(EA, EA, 8);
>          tcg_gen_qemu_ld_i64(xtl, EA, ctx->mem_idx, MO_BEQ);
>      }
> +    set_cpu_vsrh(xT(ctx->opcode), xth);
> +    set_cpu_vsrl(xT(ctx->opcode), xtl);
>      tcg_temp_free(EA);
>      tcg_temp_free_i64(xth);
>      tcg_temp_free_i64(xtl);
> @@ -185,8 +186,6 @@ static void gen_lxvh8x(DisasContext *ctx)
>      }
>      xth =3D tcg_temp_new_i64();
>      xtl =3D tcg_temp_new_i64();
> -    get_cpu_vsrh(xth, xT(ctx->opcode));
> -    get_cpu_vsrl(xtl, xT(ctx->opcode));
>      gen_set_access_type(ctx, ACCESS_INT);
> =20
>      EA =3D tcg_temp_new();
> @@ -197,6 +196,8 @@ static void gen_lxvh8x(DisasContext *ctx)
>      if (ctx->le_mode) {
>          gen_bswap16x8(xth, xtl, xth, xtl);
>      }
> +    set_cpu_vsrh(xT(ctx->opcode), xth);
> +    set_cpu_vsrl(xT(ctx->opcode), xtl);
>      tcg_temp_free(EA);
>      tcg_temp_free_i64(xth);
>      tcg_temp_free_i64(xtl);
> @@ -214,14 +215,14 @@ static void gen_lxvb16x(DisasContext *ctx)
>      }
>      xth =3D tcg_temp_new_i64();
>      xtl =3D tcg_temp_new_i64();
> -    get_cpu_vsrh(xth, xT(ctx->opcode));
> -    get_cpu_vsrl(xtl, xT(ctx->opcode));
>      gen_set_access_type(ctx, ACCESS_INT);
>      EA =3D tcg_temp_new();
>      gen_addr_reg_index(ctx, EA);
>      tcg_gen_qemu_ld_i64(xth, EA, ctx->mem_idx, MO_BEQ);
>      tcg_gen_addi_tl(EA, EA, 8);
>      tcg_gen_qemu_ld_i64(xtl, EA, ctx->mem_idx, MO_BEQ);
> +    set_cpu_vsrh(xT(ctx->opcode), xth);
> +    set_cpu_vsrl(xT(ctx->opcode), xtl);
>      tcg_temp_free(EA);
>      tcg_temp_free_i64(xth);
>      tcg_temp_free_i64(xtl);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--mPOSj6iWmtyhwOMz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlzRF28ACgkQbDjKyiDZ
s5J5vA/+IKCIyuY3tlDFEicGF5EPkwkERz8exx3RvkHoNvq8Om+Anh2Rqav87bWH
QGZmFcKYHpY5gF79dFueGO1YePFrNHG0E302nE8h7AaoufVQPcdAvWowNh68Au/w
1Vqn1A1G4x8Hcwi2kvoWEAArXePxlHahZBMJi14IacbjzUkKcNTyPnzaITvaoHZu
rtHH2nw4Ccv1EZ3tKakYpDzxUHD2BgUbdQwu2t+n3718XqpgxpEUgHoF7MaEbz9a
DjhUJh05ZJdhw/Eg396TN/dEYJHoRzU4sHPf2s3W4S2zLJ0ZeqErjQrawNFiX/0e
VZiKkd28oms+80hgLxiE5rwt+mNGHrKcd0Xq4SnLLE/aVqLIfh33jeyKeO7IO8Rd
d1+gBQODhe2DOQzSSm/47kpdE4pSTcFeV/ASMhml6U3S+7DSoKHbJhi9Vby+yNTh
EyN25aAkDtGvNlmEYtmAqaV8nxV+Qec9etZOXL7SBeQQSujyujttccWxeFk0bgj3
bA/6YOFcUPLx6/7RcXQjVsRj14Xb6dj43HSbuu4udJMJFS2JFrDHL0zzT8jl8PPk
WnQURqBzVk4Jf/M5ZtrvM+LHPku+flAi5KGK0oYR//wypIOAm4l6wAr/5gHrSAj2
LkxrfVKAI6GayIvumS1uNZMeaaayoXVwuv/jki0Vtp9Qu3oKFr4=
=6aeH
-----END PGP SIGNATURE-----

--mPOSj6iWmtyhwOMz--

