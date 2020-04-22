Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F54C54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 19:44:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 239FF20767
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 19:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sjDEicQ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 239FF20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRLHw-0002uP-94
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 15:44:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50974)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jRLHG-0002UB-U9
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 15:43:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jRLHD-0003QR-01
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 15:43:22 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36541)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jRLHC-0003Q4-Fq
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 15:43:18 -0400
Received: by mail-wr1-x441.google.com with SMTP id d15so2368936wrx.3
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2020 12:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=QW/BZTp0oKnOcCvNjq+2L2V11dGvFweiquRWPQef9QA=;
 b=sjDEicQ+dH5ZQcBjC4epZ/Dgn4G9Bo5vJTy2QqJ6mFIdxHvrJxc9SE+XkqtABE2LEA
 XnRGx1WOgQFK3C0S5WxALJfj1zLdyfP8rfjXWeYF38YMrPvMj6VE4DMKzoi7bKrnCqNv
 Qz6UcOnuYgXHyA2ciEgDLb6ti8sPQGQd58Lry+1K3v5SLya9/MHeqAQy6PzFimwpnLC7
 DUWBblH68d56NaNXJorDebkC+y3izii0WNC4E13fkHWPhKcHmXVxrXvDlDgBSoTR4pIf
 NESHZXik/rCU+tAkJ1x3BVq0cWjmTAjePAfYd+7PvvbCj56qIemb9xYpc+WuwvotT/Fl
 v0cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=QW/BZTp0oKnOcCvNjq+2L2V11dGvFweiquRWPQef9QA=;
 b=EGOc3Kvx4H1baJ+Pqgzn9UZwFZywgQFGsVJxUXS4RzLRVLgOf+vocIyqylsljHm+G5
 mTJS+aKrnCQGAfjiLnIjS9zp2uBiCOK++zGaLSCpEAJ8RNX5XmwupRzwdxo2dkNiXCFM
 YZxEsH8UQVQ2sIwr2Ek3IlENWVk9w8olru2i9KVcczB6XFULMEgiKLL4fp5tTaZ5/NF3
 T+su2KEBxoXP38JP6x/EL0i/FtKiaXoXDL5fyvkK98BArYFOb8k6xB6dTmyNDmDoqrtW
 pafcX7CcOdf90Ri28QeNEYYE5pdj101ygmsa1vcU4bKCs5d1sKQGiXoPFSJ4QOLEW2JW
 4njQ==
X-Gm-Message-State: AGi0PuYF6KuSGDdxxqfsrGIRfMkcyIry/dcxCEmCQfAevgtAj8Z9hW1m
 3+rn0aqIkLQUs79PScEOUlKkEW45ChA=
X-Google-Smtp-Source: APiQypKvKI6I7gcAiwgRTnYF0RFqAyyB7r1wq42XmvuUazIT5JI51ebDkv8iywNIYOwYCrHWtifuRA==
X-Received: by 2002:adf:ca0e:: with SMTP id o14mr781616wrh.254.1587584596675; 
 Wed, 22 Apr 2020 12:43:16 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id k14sm295394wrp.53.2020.04.22.12.43.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2020 12:43:15 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B3CE71FF7E;
 Wed, 22 Apr 2020 20:43:14 +0100 (BST)
References: <20200422011722.13287-1-richard.henderson@linaro.org>
 <20200422011722.13287-25-richard.henderson@linaro.org>
User-agent: mu4e 1.4.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 24/36] tcg/i386: Use tcg_constant_vec with tcg vec
 expanders
In-reply-to: <20200422011722.13287-25-richard.henderson@linaro.org>
Date: Wed, 22 Apr 2020 20:43:14 +0100
Message-ID: <87imhrb92l.fsf@linaro.org>
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
>  tcg/i386/tcg-target.inc.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
> index 9cb627d6eb..deace219d2 100644
> --- a/tcg/i386/tcg-target.inc.c
> +++ b/tcg/i386/tcg-target.inc.c
> @@ -3452,7 +3452,7 @@ static void expand_vec_sari(TCGType type, unsigned =
vece,
>  static void expand_vec_mul(TCGType type, unsigned vece,
>                             TCGv_vec v0, TCGv_vec v1, TCGv_vec v2)
>  {
> -    TCGv_vec t1, t2, t3, t4;
> +    TCGv_vec t1, t2, t3, t4, zero;
>=20=20
>      tcg_debug_assert(vece =3D=3D MO_8);
>=20=20
> @@ -3470,11 +3470,11 @@ static void expand_vec_mul(TCGType type, unsigned=
 vece,
>      case TCG_TYPE_V64:
>          t1 =3D tcg_temp_new_vec(TCG_TYPE_V128);
>          t2 =3D tcg_temp_new_vec(TCG_TYPE_V128);
> -        tcg_gen_dup16i_vec(t2, 0);
> +        zero =3D tcg_constant_vec(TCG_TYPE_V128, MO_8, 0);
>          vec_gen_3(INDEX_op_x86_punpckl_vec, TCG_TYPE_V128, MO_8,
> -                  tcgv_vec_arg(t1), tcgv_vec_arg(v1), tcgv_vec_arg(t2));
> +                  tcgv_vec_arg(t1), tcgv_vec_arg(v1), tcgv_vec_arg(zero)=
);
>          vec_gen_3(INDEX_op_x86_punpckl_vec, TCG_TYPE_V128, MO_8,
> -                  tcgv_vec_arg(t2), tcgv_vec_arg(t2), tcgv_vec_arg(v2));
> +                  tcgv_vec_arg(t2), tcgv_vec_arg(zero), tcgv_vec_arg(v2)=
);
>          tcg_gen_mul_vec(MO_16, t1, t1, t2);
>          tcg_gen_shri_vec(MO_16, t1, t1, 8);
>          vec_gen_3(INDEX_op_x86_packus_vec, TCG_TYPE_V128, MO_8,
> @@ -3489,15 +3489,15 @@ static void expand_vec_mul(TCGType type, unsigned=
 vece,
>          t2 =3D tcg_temp_new_vec(type);
>          t3 =3D tcg_temp_new_vec(type);
>          t4 =3D tcg_temp_new_vec(type);
> -        tcg_gen_dup16i_vec(t4, 0);
> +        zero =3D tcg_constant_vec(TCG_TYPE_V128, MO_8, 0);
>          vec_gen_3(INDEX_op_x86_punpckl_vec, type, MO_8,
> -                  tcgv_vec_arg(t1), tcgv_vec_arg(v1), tcgv_vec_arg(t4));
> +                  tcgv_vec_arg(t1), tcgv_vec_arg(v1), tcgv_vec_arg(zero)=
);
>          vec_gen_3(INDEX_op_x86_punpckl_vec, type, MO_8,
> -                  tcgv_vec_arg(t2), tcgv_vec_arg(t4), tcgv_vec_arg(v2));
> +                  tcgv_vec_arg(t2), tcgv_vec_arg(zero), tcgv_vec_arg(v2)=
);
>          vec_gen_3(INDEX_op_x86_punpckh_vec, type, MO_8,
> -                  tcgv_vec_arg(t3), tcgv_vec_arg(v1), tcgv_vec_arg(t4));
> +                  tcgv_vec_arg(t3), tcgv_vec_arg(v1), tcgv_vec_arg(zero)=
);
>          vec_gen_3(INDEX_op_x86_punpckh_vec, type, MO_8,
> -                  tcgv_vec_arg(t4), tcgv_vec_arg(t4), tcgv_vec_arg(v2));
> +                  tcgv_vec_arg(t4), tcgv_vec_arg(zero), tcgv_vec_arg(v2)=
);
>          tcg_gen_mul_vec(MO_16, t1, t1, t2);
>          tcg_gen_mul_vec(MO_16, t3, t3, t4);
>          tcg_gen_shri_vec(MO_16, t1, t1, 8);
> @@ -3525,7 +3525,7 @@ static bool expand_vec_cmp_noinv(TCGType type, unsi=
gned vece, TCGv_vec v0,
>          NEED_UMIN =3D 8,
>          NEED_UMAX =3D 16,
>      };
> -    TCGv_vec t1, t2;
> +    TCGv_vec t1, t2, t3;
>      uint8_t fixup;
>=20=20
>      switch (cond) {
> @@ -3596,9 +3596,9 @@ static bool expand_vec_cmp_noinv(TCGType type, unsi=
gned vece, TCGv_vec v0,
>      } else if (fixup & NEED_BIAS) {
>          t1 =3D tcg_temp_new_vec(type);
>          t2 =3D tcg_temp_new_vec(type);
> -        tcg_gen_dupi_vec(vece, t2, 1ull << ((8 << vece) - 1));
> -        tcg_gen_sub_vec(vece, t1, v1, t2);
> -        tcg_gen_sub_vec(vece, t2, v2, t2);
> +        t3 =3D tcg_constant_vec(type, vece, 1ull << ((8 << vece) - 1));
> +        tcg_gen_sub_vec(vece, t1, v1, t3);
> +        tcg_gen_sub_vec(vece, t2, v2, t3);
>          v1 =3D t1;
>          v2 =3D t2;
>          cond =3D tcg_signed_cond(cond);


--=20
Alex Benn=C3=A9e

