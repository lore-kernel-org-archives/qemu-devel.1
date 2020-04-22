Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE19C54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 17:02:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0440220776
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 17:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vA8kFi4U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0440220776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRIl7-0008CK-1F
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 13:02:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55188)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jRIjh-000742-S7
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 13:00:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jRIjg-00068E-2H
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 13:00:32 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:45098)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jRIjf-00064g-Jw
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 13:00:31 -0400
Received: by mail-wr1-x441.google.com with SMTP id t14so3277474wrw.12
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2020 10:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=Uvd57UEj3ww5lL5t1lCcDWOxdnPhmW9M5DOScWndnCE=;
 b=vA8kFi4UlnyvcgEsTTVgZhYP5gsbIs2acEYvpEEpEwzJG3244WmyX3Z2KhBsIyGCJL
 Gv1WHgdxy+B64Ntzf24IojP+qDclLu5s/uObArgEKrs8cKm8UOG8+a2bXPa1XzNGeuPH
 oCXZyH6QEzgh9BHmuws4dYPau9OHGBteXWWdujuzpkaP6IEAAye0ghqdxzKMWwnFjQFW
 wK6p72LByVqkpvmH/GXyN940v5hRUgwoUJA1Czpg90aj7O69EjJPUThJr7pfbB2KhjLd
 IE88zr8sLm6y3+Jj8J5KhYoW4OpIzpcQ8ioJRwqB6Fje1GZ35uXSSD9sepyHD3SZqKxP
 3cNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=Uvd57UEj3ww5lL5t1lCcDWOxdnPhmW9M5DOScWndnCE=;
 b=FXeoa7YJ9yiqf/ALWpf4YSjuQUqW5UQsjRiQWnBdqoVLltUiLV2Q5MsVAWTxrJHa9A
 k9XEFn+S/gixiFTXG9EqxR3x93wvwT2L/IGfO8AznAiiKm99FBnBCJ2XkL0gCCsf6no7
 XTQqAETXobYpdIU5ecHhkwHdtbhczkXAD0RABUtanX7XCOVXLeIblNDeL1pN+fpU1Evq
 5IEN76VU5TlNRAVDsXOKoXw/t5G2DrzNB8xYp6XaY8SeRm8Hf7cxGy17OjY8tawYg5Ms
 B6sz9rUPaNLNpqTreMFq0hanXMRGjhhL+y/qPNp8LYZcoTVM+u5ANXkv0Dhx8TXthq71
 D+3A==
X-Gm-Message-State: AGi0PuYvoG///1pK5dDS7kexZ0WvifumnwQRlnwJTA6nd08vSaoEyGAa
 kSA6QYBhxNi/TOyN/Th97g/1ng==
X-Google-Smtp-Source: APiQypJCf4NkPEdGQWROC9FJpNkImJe0y9lKFKdZRkOVpqKox7T9/DLb3vdML44dn5UZWC+ebRKOwQ==
X-Received: by 2002:adf:f704:: with SMTP id r4mr31604678wrp.5.1587574829926;
 Wed, 22 Apr 2020 10:00:29 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l19sm8708892wmj.14.2020.04.22.10.00.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2020 10:00:28 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id F37C41FF7E;
 Wed, 22 Apr 2020 18:00:27 +0100 (BST)
References: <20200422011722.13287-1-richard.henderson@linaro.org>
 <20200422011722.13287-15-richard.henderson@linaro.org>
User-agent: mu4e 1.4.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 14/36] tcg: Use tcg_constant_{i32,vec} with tcg vec
 expanders
In-reply-to: <20200422011722.13287-15-richard.henderson@linaro.org>
Date: Wed, 22 Apr 2020 18:00:27 +0100
Message-ID: <87h7xbcv6c.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::441
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tcg/tcg-op-vec.c | 63 ++++++++++++++++++++++++++----------------------
>  1 file changed, 34 insertions(+), 29 deletions(-)
>
> diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
> index f3927089a7..655b3ae32d 100644
> --- a/tcg/tcg-op-vec.c
> +++ b/tcg/tcg-op-vec.c
> @@ -233,25 +233,17 @@ void tcg_gen_mov_vec(TCGv_vec r, TCGv_vec a)
>      }
>  }
>=20=20
> -#define MO_REG  (TCG_TARGET_REG_BITS =3D=3D 64 ? MO_64 : MO_32)
> -
> -static void do_dupi_vec(TCGv_vec r, unsigned vece, TCGArg a)
> -{
> -    TCGTemp *rt =3D tcgv_vec_temp(r);
> -    vec_gen_2(INDEX_op_dupi_vec, rt->base_type, vece, temp_arg(rt), a);
> -}
> -
>  TCGv_vec tcg_const_zeros_vec(TCGType type)
>  {
>      TCGv_vec ret =3D tcg_temp_new_vec(type);
> -    do_dupi_vec(ret, MO_REG, 0);
> +    tcg_gen_mov_vec(ret, tcg_constant_vec(type, MO_8, 0));
>      return ret;
>  }
>=20=20
>  TCGv_vec tcg_const_ones_vec(TCGType type)
>  {
>      TCGv_vec ret =3D tcg_temp_new_vec(type);
> -    do_dupi_vec(ret, MO_REG, -1);
> +    tcg_gen_mov_vec(ret, tcg_constant_vec(type, MO_8, -1));
>      return ret;
>  }
>=20=20
> @@ -267,37 +259,50 @@ TCGv_vec tcg_const_ones_vec_matching(TCGv_vec m)
>      return tcg_const_ones_vec(t->base_type);
>  }
>=20=20
> -void tcg_gen_dup64i_vec(TCGv_vec r, uint64_t a)
> +void tcg_gen_dupi_vec(unsigned vece, TCGv_vec dest, uint64_t val)
>  {
> -    if (TCG_TARGET_REG_BITS =3D=3D 32 && a =3D=3D deposit64(a, 32, 32, a=
)) {
> -        do_dupi_vec(r, MO_32, a);
> -    } else if (TCG_TARGET_REG_BITS =3D=3D 64 || a =3D=3D (uint64_t)(int3=
2_t)a) {
> -        do_dupi_vec(r, MO_64, a);
> -    } else {
> -        TCGv_i64 c =3D tcg_const_i64(a);
> -        tcg_gen_dup_i64_vec(MO_64, r, c);
> -        tcg_temp_free_i64(c);
> +    TCGType type =3D tcgv_vec_temp(dest)->base_type;
> +
> +    /*
> +     * For MO_64 constants that can't be represented in tcg_target_long,
> +     * we must use INDEX_op_dup2_vec.
> +     */
> +    if (TCG_TARGET_REG_BITS =3D=3D 32) {
> +        val =3D dup_const(vece, val);
> +        if (val !=3D deposit64(val, 32, 32, val) &&
> +            val !=3D (uint64_t)(int32_t)val) {
> +            uint32_t vl =3D extract64(val, 0, 32);
> +            uint32_t vh =3D extract64(val, 32, 32);
> +            TCGArg al =3D tcgv_i32_arg(tcg_constant_i32(vl));
> +            TCGArg ah =3D tcgv_i32_arg(tcg_constant_i32(vh));
> +            TCGArg di =3D tcgv_vec_arg(dest);
> +
> +            vec_gen_3(INDEX_op_dup2_vec, type, MO_64, di, al, ah);
> +            return;
> +        }
>      }
> +
> +    tcg_gen_mov_vec(dest, tcg_constant_vec(type, vece, val));
>  }
>=20=20
> -void tcg_gen_dup32i_vec(TCGv_vec r, uint32_t a)
> +void tcg_gen_dup64i_vec(TCGv_vec dest, uint64_t val)
>  {
> -    do_dupi_vec(r, MO_REG, dup_const(MO_32, a));
> +    tcg_gen_dupi_vec(MO_64, dest, val);
>  }
>=20=20
> -void tcg_gen_dup16i_vec(TCGv_vec r, uint32_t a)
> +void tcg_gen_dup32i_vec(TCGv_vec dest, uint32_t val)
>  {
> -    do_dupi_vec(r, MO_REG, dup_const(MO_16, a));
> +    tcg_gen_dupi_vec(MO_32, dest, val);
>  }
>=20=20
> -void tcg_gen_dup8i_vec(TCGv_vec r, uint32_t a)
> +void tcg_gen_dup16i_vec(TCGv_vec dest, uint32_t val)
>  {
> -    do_dupi_vec(r, MO_REG, dup_const(MO_8, a));
> +    tcg_gen_dupi_vec(MO_16, dest, val);
>  }
>=20=20
> -void tcg_gen_dupi_vec(unsigned vece, TCGv_vec r, uint64_t a)
> +void tcg_gen_dup8i_vec(TCGv_vec dest, uint32_t val)
>  {
> -    do_dupi_vec(r, MO_REG, dup_const(vece, a));
> +    tcg_gen_dupi_vec(MO_8, dest, val);
>  }
>=20=20
>  void tcg_gen_dup_i64_vec(unsigned vece, TCGv_vec r, TCGv_i64 a)
> @@ -502,8 +507,8 @@ void tcg_gen_abs_vec(unsigned vece, TCGv_vec r, TCGv_=
vec a)
>              if (tcg_can_emit_vec_op(INDEX_op_sari_vec, type, vece) > 0) {
>                  tcg_gen_sari_vec(vece, t, a, (8 << vece) - 1);
>              } else {
> -                do_dupi_vec(t, MO_REG, 0);
> -                tcg_gen_cmp_vec(TCG_COND_LT, vece, t, a, t);
> +                tcg_gen_cmp_vec(TCG_COND_LT, vece, t, a,
> +                                tcg_constant_vec(type, vece, 0));
>              }
>              tcg_gen_xor_vec(vece, r, a, t);
>              tcg_gen_sub_vec(vece, r, r, t);


--=20
Alex Benn=C3=A9e

