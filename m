Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F382C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 13:23:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73B7F2089E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 13:23:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73B7F2089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0QaW-0003H5-9a
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 09:23:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44875)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i0QZO-0001kM-Fr
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 09:22:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i0QSG-00047E-SG
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 09:15:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34354)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i0QSG-00046s-Ki
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 09:15:12 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9CC36C04959F
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 13:15:11 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id w11so1206146wru.17
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 06:15:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=A6grVYwmnqVSq9fUgl1/5WKAG0wMSDlNJF1swHncbtg=;
 b=poiU79tKdNWN2TJE2QXepKqhHd+K5Q7nzRpPkf2UNqXw9tpgqsla4IyOJDyHwm/xPU
 UKmRGK3fsE9fP/Xd3l0dfIATilnZh2i1Rbj+LQeLJ7BjGn/CSu0Zq909fo/YnBRdCnX7
 TJA7NkNNzLgQxTooqpcqfwvcXorNDyyRwyxRq1b/obHiuza+nhswRJpLJvi0ORmfmfxI
 f43JFPKpnU1OUxXz7CU2NztnWvoNIyLXp0WhBNGNURZy6YyS96hVpBrb29FPi4cB/HAp
 sEMDHYpcvAGMkUjgN+ObqUWYwWTnOnLaJggz/GR2cGXIJntlGJiGb2t4cu0JwEBpfGh8
 eREg==
X-Gm-Message-State: APjAAAXh4UndPFYUoq88rgFvuLSqsI1+562y3xkrtVVjZpKAEn299omB
 Y7c47xr3/RMnX+UL8sv9o+s+6zAPlAp5HEbKrQoQxyHTpfiWdlexRaerTcopS0K2gOtb2lLkk/5
 sSgIRAujSkfhPwWk=
X-Received: by 2002:a7b:c952:: with SMTP id i18mr6505099wml.44.1566393310402; 
 Wed, 21 Aug 2019 06:15:10 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx1yrctLXu0bMyhComdvFpfSBlJ2eYGPUAp6Yl7XmMNmTDCpmYzjmWbRtNdvBrST4Xy4l2nJg==
X-Received: by 2002:a7b:c952:: with SMTP id i18mr6505079wml.44.1566393310138; 
 Wed, 21 Aug 2019 06:15:10 -0700 (PDT)
Received: from [192.168.1.39] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id u129sm4569800wmb.12.2019.08.21.06.15.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Aug 2019 06:15:09 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190819213755.26175-1-richard.henderson@linaro.org>
 <20190819213755.26175-9-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <e00b405e-f76e-119e-8585-e56b8d0595ae@redhat.com>
Date: Wed, 21 Aug 2019 15:15:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190819213755.26175-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 08/68] target/arm: Convert Saturating
 addition and subtraction
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/19/19 11:36 PM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Nice :)

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>  target/arm/translate.c | 75 +++++++++++++++++++++++++++---------------
>  target/arm/a32.decode  | 10 ++++++
>  target/arm/t32.decode  |  9 +++++
>  3 files changed, 67 insertions(+), 27 deletions(-)
>=20
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 82bd207799..b731e08fe4 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -8099,6 +8099,48 @@ static bool trans_UMAAL(DisasContext *s, arg_UMA=
AL *a)
>      return true;
>  }
> =20
> +/*
> + * Saturating addition and subtraction
> + */
> +
> +static bool op_qaddsub(DisasContext *s, arg_rrr *a, bool add, bool dou=
b)
> +{
> +    TCGv_i32 t0, t1;
> +
> +    if (s->thumb
> +        ? !arm_dc_feature(s, ARM_FEATURE_THUMB_DSP)
> +        : !ENABLE_ARCH_5TE) {
> +        return false;
> +    }
> +
> +    t0 =3D load_reg(s, a->rm);
> +    t1 =3D load_reg(s, a->rn);
> +    if (doub) {
> +        gen_helper_add_saturate(t1, cpu_env, t1, t1);
> +    }
> +    if (add) {
> +        gen_helper_add_saturate(t0, cpu_env, t0, t1);
> +    } else {
> +        gen_helper_sub_saturate(t0, cpu_env, t0, t1);
> +    }
> +    tcg_temp_free_i32(t1);
> +    store_reg(s, a->rd, t0);
> +    return true;
> +}
> +
> +#define DO_QADDSUB(NAME, ADD, DOUB) \
> +static bool trans_##NAME(DisasContext *s, arg_rrr *a)    \
> +{                                                        \
> +    return op_qaddsub(s, a, ADD, DOUB);                  \
> +}
> +
> +DO_QADDSUB(QADD, true, false)
> +DO_QADDSUB(QSUB, false, false)
> +DO_QADDSUB(QDADD, true, true)
> +DO_QADDSUB(QDSUB, false, true)
> +
> +#undef DO_QADDSUB
> +
>  /*
>   * Legacy decoder.
>   */
> @@ -8508,21 +8550,10 @@ static void disas_arm_insn(DisasContext *s, uns=
igned int insn)
>              store_reg(s, rd, tmp);
>              break;
>          }
> -        case 0x5: /* saturating add/subtract */
> -            ARCH(5TE);
> -            rd =3D (insn >> 12) & 0xf;
> -            rn =3D (insn >> 16) & 0xf;
> -            tmp =3D load_reg(s, rm);
> -            tmp2 =3D load_reg(s, rn);
> -            if (op1 & 2)
> -                gen_helper_add_saturate(tmp2, cpu_env, tmp2, tmp2);
> -            if (op1 & 1)
> -                gen_helper_sub_saturate(tmp, cpu_env, tmp, tmp2);
> -            else
> -                gen_helper_add_saturate(tmp, cpu_env, tmp, tmp2);
> -            tcg_temp_free_i32(tmp2);
> -            store_reg(s, rd, tmp);
> -            break;
> +        case 0x5:
> +            /* Saturating addition and subtraction.  */
> +            /* All done in decodetree.  Reach here for illegal ops.  *=
/
> +            goto illegal_op;
>          case 0x6: /* ERET */
>              if (op1 !=3D 3) {
>                  goto illegal_op;
> @@ -9989,18 +10020,8 @@ static void disas_thumb2_insn(DisasContext *s, =
uint32_t insn)
>              op =3D ((insn >> 17) & 0x38) | ((insn >> 4) & 7);
>              if (op < 4) {
>                  /* Saturating add/subtract.  */
> -                if (!arm_dc_feature(s, ARM_FEATURE_THUMB_DSP)) {
> -                    goto illegal_op;
> -                }
> -                tmp =3D load_reg(s, rn);
> -                tmp2 =3D load_reg(s, rm);
> -                if (op & 1)
> -                    gen_helper_add_saturate(tmp, cpu_env, tmp, tmp);
> -                if (op & 2)
> -                    gen_helper_sub_saturate(tmp, cpu_env, tmp2, tmp);
> -                else
> -                    gen_helper_add_saturate(tmp, cpu_env, tmp, tmp2);
> -                tcg_temp_free_i32(tmp2);
> +                /* All done in decodetree.  Reach here for illegal ops=
.  */
> +                goto illegal_op;
>              } else {
>                  switch (op) {
>                  case 0x0a: /* rbit */
> diff --git a/target/arm/a32.decode b/target/arm/a32.decode
> index 87bbb2eec2..7791be5590 100644
> --- a/target/arm/a32.decode
> +++ b/target/arm/a32.decode
> @@ -27,6 +27,7 @@
>  &s_rri_rot       s rn rd imm rot
>  &s_rrrr          s rd rn rm ra
>  &rrrr            rd rn rm ra
> +&rrr             rd rn rm
> =20
>  # Data-processing (register)
> =20
> @@ -122,3 +123,12 @@ UMULL            .... 0000 100 . .... .... .... 10=
01 ....     @s_rdamn
>  UMLAL            .... 0000 101 . .... .... .... 1001 ....     @s_rdamn
>  SMULL            .... 0000 110 . .... .... .... 1001 ....     @s_rdamn
>  SMLAL            .... 0000 111 . .... .... .... 1001 ....     @s_rdamn
> +
> +# Saturating addition and subtraction
> +
> +@rndm            ---- .... .... rn:4 rd:4 .... .... rm:4      &rrr
> +
> +QADD             .... 0001 0000 .... .... 0000 0101 ....      @rndm
> +QSUB             .... 0001 0010 .... .... 0000 0101 ....      @rndm
> +QDADD            .... 0001 0100 .... .... 0000 0101 ....      @rndm
> +QDSUB            .... 0001 0110 .... .... 0000 0101 ....      @rndm
> diff --git a/target/arm/t32.decode b/target/arm/t32.decode
> index 40cc69aee3..7c6226e0af 100644
> --- a/target/arm/t32.decode
> +++ b/target/arm/t32.decode
> @@ -24,6 +24,7 @@
>  &s_rri_rot       !extern s rn rd imm rot
>  &s_rrrr          !extern s rd rn rm ra
>  &rrrr            !extern rd rn rm ra
> +&rrr             !extern rd rn rm
> =20
>  # Data-processing (register)
> =20
> @@ -117,6 +118,7 @@ RSB_rri          1111 0.0 1110 . .... 0 ... .... ..=
......     @s_rri_rot
>  @s0_rnadm        .... .... .... rn:4 ra:4 rd:4 .... rm:4      &s_rrrr =
s=3D0
>  @s0_rn0dm        .... .... .... rn:4 .... rd:4 .... rm:4      &s_rrrr =
ra=3D0 s=3D0
>  @rnadm           .... .... .... rn:4 ra:4 rd:4 .... rm:4      &rrrr
> +@rndm            .... .... .... rn:4 .... rd:4 .... rm:4      &rrr
> =20
>  {
>    MUL            1111 1011 0000 .... 1111 .... 0000 ....      @s0_rn0d=
m
> @@ -128,3 +130,10 @@ UMULL            1111 1011 1010 .... .... .... 000=
0 ....      @s0_rnadm
>  SMLAL            1111 1011 1100 .... .... .... 0000 ....      @s0_rnad=
m
>  UMLAL            1111 1011 1110 .... .... .... 0000 ....      @s0_rnad=
m
>  UMAAL            1111 1011 1110 .... .... .... 0110 ....      @rnadm
> +
> +# Data-processing (two source registers)
> +
> +QADD             1111 1010 1000 .... 1111 .... 1000 ....      @rndm
> +QSUB             1111 1010 1000 .... 1111 .... 1010 ....      @rndm
> +QDADD            1111 1010 1000 .... 1111 .... 1001 ....      @rndm
> +QDSUB            1111 1010 1000 .... 1111 .... 1011 ....      @rndm
>=20

