Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 982F0CA9EA4
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 12:25:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 658152089C
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 12:25:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X5BmvMRi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 658152089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLRKQ-0005yH-8C
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 08:25:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40623)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iLRJ8-0004Vz-Se
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 08:24:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iLRJ6-0000F6-JR
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 08:24:38 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42415)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iLRJ6-0000EA-B1
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 08:24:36 -0400
Received: by mail-wr1-x444.google.com with SMTP id n14so6038911wrw.9
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 05:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=REQ4iVhdXM5bnsXQyG7tM0ti7mDgLdM8A9/x6aZ75QI=;
 b=X5BmvMRiTOqllB9aGsv+BApfPrwDdrW/KKR1IWbBsjcLJBihIHzchA67UDUZDtuUlp
 HZwDtS7HGkfT1ZEdGZ9zMWfmo2HvEKYRmi7MPupT2PY+3c5iHq4orKqARGslmKrn8pgE
 1cu3SEPY+Ela0Jv3IgKQlY2NtXrhi2tnIyiRyvoHHVrbghC1rTjyWGRF5QY5gRhRZQPI
 0RWlHTZnNaFmP+fXTrNjLE2YaBWS7dKGyEFz4P6DOa7mT4YzHCyOkyIOlpmyQOw4Tgd9
 PC9fZcaFgluLiHWjsdQ7zG/458Vjecbb7nroEgLbsR97YWFWdQ+mDflr/Xe6rcZhB4sc
 g14A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=REQ4iVhdXM5bnsXQyG7tM0ti7mDgLdM8A9/x6aZ75QI=;
 b=sbX6wQC66VdHHfMV/KPsnyqu6QhUmsLiVN1JO6UJ5MLaBqFQe7B5fiRONVtru27YmS
 O17e5nzlJbHNOmBOWWUnNRm8KHQQGOWGd5NlWF+uO42ySV6Cqgwn+n6R4gXJStw7kPnC
 gXxYAkRUQhq0AdMgztXkz+7otQnQcxeI7F1C3LBMnDGQNHSICUAqIm6uFA+xZVjHaYL3
 FaBnJSLHgrVMplbQ7tktulspNFcY3goAuE6ZYLZJgYQtEPdk1vg4BY1tOadRKWkPiyco
 5hTnWACQUYMzrFJtOXZs3yzSF3T5Lx1gTwHiwYS7Ko1hcpP1wIIVNIpzwrRubruwOI1Y
 Kx5Q==
X-Gm-Message-State: APjAAAUo9mBSTDzLf0VQ3mFIXC5CLIX9NAsm8YiuFAZ2vgN18QwCQTtt
 gH4LEG9lrsKnKkuNoe5OWcXkcQ==
X-Google-Smtp-Source: APXvYqyk1MvBnZ2Xb5WdTqgr+jMMAPvpTMqwpfFKJZ/FwVXwV2CYswl3bB2ZVglxcxaawKt5+2hBXQ==
X-Received: by 2002:a5d:6cc3:: with SMTP id c3mr1801845wrc.202.1571401474198; 
 Fri, 18 Oct 2019 05:24:34 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z13sm5985985wrm.64.2019.10.18.05.24.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2019 05:24:33 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C79311FF87;
 Fri, 18 Oct 2019 13:24:32 +0100 (BST)
References: <20191017044232.27601-1-richard.henderson@linaro.org>
 <20191017044232.27601-4-richard.henderson@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH 3/4] target/arm: Convert PMULL.64 to gvec
In-reply-to: <20191017044232.27601-4-richard.henderson@linaro.org>
Date: Fri, 18 Oct 2019 13:24:32 +0100
Message-ID: <871rvap7gf.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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


Richard Henderson <richard.henderson@linaro.org> writes:

> The gvec form will be needed for implementing SVE2.

Hmm I'm seeing a failure against:

  aarch32-all-v80/insn_VMULL__INC.risu.bin

From:

  https://fileserver.linaro.org/owncloud/index.php/s/hvEXM2eJ3uZVhlH
  https://fileserver.linaro.org/owncloud/index.php/s/hvEXM2eJ3uZVhlH/downlo=
ad?path=3D%2F&files=3Daarch32-all-v80.tar.xz

And some others. But this seems to be broken in master as well so I
don't know if this is a regression or because I have my -cpu wrong for
qemu-arm for something recorded on a cortex-a53 in aarch32.

>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper.h        |  4 +---
>  target/arm/neon_helper.c   | 30 ------------------------------
>  target/arm/translate-a64.c | 28 +++-------------------------
>  target/arm/translate.c     | 16 ++--------------
>  target/arm/vec_helper.c    | 33 +++++++++++++++++++++++++++++++++
>  5 files changed, 39 insertions(+), 72 deletions(-)
>
> diff --git a/target/arm/helper.h b/target/arm/helper.h
> index 800446e537..d954399b7e 100644
> --- a/target/arm/helper.h
> +++ b/target/arm/helper.h
> @@ -555,9 +555,6 @@ DEF_HELPER_FLAGS_3(crc32, TCG_CALL_NO_RWG_SE, i32, i3=
2, i32, i32)
>  DEF_HELPER_FLAGS_3(crc32c, TCG_CALL_NO_RWG_SE, i32, i32, i32, i32)
>  DEF_HELPER_2(dc_zva, void, env, i64)
>
> -DEF_HELPER_FLAGS_2(neon_pmull_64_lo, TCG_CALL_NO_RWG_SE, i64, i64, i64)
> -DEF_HELPER_FLAGS_2(neon_pmull_64_hi, TCG_CALL_NO_RWG_SE, i64, i64, i64)
> -
>  DEF_HELPER_FLAGS_5(gvec_qrdmlah_s16, TCG_CALL_NO_RWG,
>                     void, ptr, ptr, ptr, ptr, i32)
>  DEF_HELPER_FLAGS_5(gvec_qrdmlsh_s16, TCG_CALL_NO_RWG,
> @@ -689,6 +686,7 @@ DEF_HELPER_FLAGS_4(gvec_ushl_b, TCG_CALL_NO_RWG, void=
, ptr, ptr, ptr, i32)
>  DEF_HELPER_FLAGS_4(gvec_ushl_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i3=
2)
>
>  DEF_HELPER_FLAGS_4(gvec_pmul_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i3=
2)
> +DEF_HELPER_FLAGS_4(gvec_pmull_q, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i=
32)
>
>  #ifdef TARGET_AARCH64
>  #include "helper-a64.h"
> diff --git a/target/arm/neon_helper.c b/target/arm/neon_helper.c
> index 9e7a9a1ac5..6a107da0e1 100644
> --- a/target/arm/neon_helper.c
> +++ b/target/arm/neon_helper.c
> @@ -2152,33 +2152,3 @@ void HELPER(neon_zip16)(void *vd, void *vm)
>      rm[0] =3D m0;
>      rd[0] =3D d0;
>  }
> -
> -/* Helper function for 64 bit polynomial multiply case:
> - * perform PolynomialMult(op1, op2) and return either the top or
> - * bottom half of the 128 bit result.
> - */
> -uint64_t HELPER(neon_pmull_64_lo)(uint64_t op1, uint64_t op2)
> -{
> -    int bitnum;
> -    uint64_t res =3D 0;
> -
> -    for (bitnum =3D 0; bitnum < 64; bitnum++) {
> -        if (op1 & (1ULL << bitnum)) {
> -            res ^=3D op2 << bitnum;
> -        }
> -    }
> -    return res;
> -}
> -uint64_t HELPER(neon_pmull_64_hi)(uint64_t op1, uint64_t op2)
> -{
> -    int bitnum;
> -    uint64_t res =3D 0;
> -
> -    /* bit 0 of op1 can't influence the high 64 bits at all */
> -    for (bitnum =3D 1; bitnum < 64; bitnum++) {
> -        if (op1 & (1ULL << bitnum)) {
> -            res ^=3D op2 >> (64 - bitnum);
> -        }
> -    }
> -    return res;
> -}
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index 04e25cfe06..12588d18df 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -10598,30 +10598,6 @@ static void handle_3rd_narrowing(DisasContext *s=
, int is_q, int is_u, int size,
>      clear_vec_high(s, is_q, rd);
>  }
>
> -static void handle_pmull_64(DisasContext *s, int is_q, int rd, int rn, i=
nt rm)
> -{
> -    /* PMULL of 64 x 64 -> 128 is an odd special case because it
> -     * is the only three-reg-diff instruction which produces a
> -     * 128-bit wide result from a single operation. However since
> -     * it's possible to calculate the two halves more or less
> -     * separately we just use two helper calls.
> -     */
> -    TCGv_i64 tcg_op1 =3D tcg_temp_new_i64();
> -    TCGv_i64 tcg_op2 =3D tcg_temp_new_i64();
> -    TCGv_i64 tcg_res =3D tcg_temp_new_i64();
> -
> -    read_vec_element(s, tcg_op1, rn, is_q, MO_64);
> -    read_vec_element(s, tcg_op2, rm, is_q, MO_64);
> -    gen_helper_neon_pmull_64_lo(tcg_res, tcg_op1, tcg_op2);
> -    write_vec_element(s, tcg_res, rd, 0, MO_64);
> -    gen_helper_neon_pmull_64_hi(tcg_res, tcg_op1, tcg_op2);
> -    write_vec_element(s, tcg_res, rd, 1, MO_64);
> -
> -    tcg_temp_free_i64(tcg_op1);
> -    tcg_temp_free_i64(tcg_op2);
> -    tcg_temp_free_i64(tcg_res);
> -}
> -
>  /* AdvSIMD three different
>   *   31  30  29 28       24 23  22  21 20  16 15    12 11 10 9    5 4   =
 0
>   * +---+---+---+-----------+------+---+------+--------+-----+------+----=
--+
> @@ -10686,7 +10662,9 @@ static void disas_simd_three_reg_diff(DisasContex=
t *s, uint32_t insn)
>              if (!fp_access_check(s)) {
>                  return;
>              }
> -            handle_pmull_64(s, is_q, rd, rn, rm);
> +            /* The Q field specifies lo/hi half input for this insn.  */
> +            gen_gvec_op3_ool(s, true, rd, rn, rm, is_q,
> +                             gen_helper_gvec_pmull_q);
>              return;
>          }
>          goto is_widening;
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index b66a2f6b71..4e34249672 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -5877,23 +5877,11 @@ static int disas_neon_data_insn(DisasContext *s, =
uint32_t insn)
>                   * outside the loop below as it only performs a single p=
ass.
>                   */
>                  if (op =3D=3D 14 && size =3D=3D 2) {
> -                    TCGv_i64 tcg_rn, tcg_rm, tcg_rd;
> -
>                      if (!dc_isar_feature(aa32_pmull, s)) {
>                          return 1;
>                      }
> -                    tcg_rn =3D tcg_temp_new_i64();
> -                    tcg_rm =3D tcg_temp_new_i64();
> -                    tcg_rd =3D tcg_temp_new_i64();
> -                    neon_load_reg64(tcg_rn, rn);
> -                    neon_load_reg64(tcg_rm, rm);
> -                    gen_helper_neon_pmull_64_lo(tcg_rd, tcg_rn, tcg_rm);
> -                    neon_store_reg64(tcg_rd, rd);
> -                    gen_helper_neon_pmull_64_hi(tcg_rd, tcg_rn, tcg_rm);
> -                    neon_store_reg64(tcg_rd, rd + 1);
> -                    tcg_temp_free_i64(tcg_rn);
> -                    tcg_temp_free_i64(tcg_rm);
> -                    tcg_temp_free_i64(tcg_rd);
> +                    tcg_gen_gvec_3_ool(rd_ofs, rn_ofs, rm_ofs, 16, 16,
> +                                       0, gen_helper_gvec_pmull_q);
>                      return 0;
>                  }
>
> diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
> index d401282c6f..5c1074374e 100644
> --- a/target/arm/vec_helper.c
> +++ b/target/arm/vec_helper.c
> @@ -1164,3 +1164,36 @@ void HELPER(gvec_pmul_b)(void *vd, void *vn, void =
*vm, uint32_t desc)
>      }
>      clear_tail(d, opr_sz, simd_maxsz(desc));
>  }
> +
> +/*
> + * 64x64->128 polynomial multiply.
> + * Because of the lanes are not accessed in strict columns,
> + * this probably cannot be turned into a generic helper.
> + */
> +void HELPER(gvec_pmull_q)(void *vd, void *vn, void *vm, uint32_t desc)
> +{
> +    intptr_t i, j, opr_sz =3D simd_oprsz(desc);
> +    intptr_t hi =3D simd_data(desc);
> +    uint64_t *d =3D vd, *n =3D vn, *m =3D vm;
> +
> +    for (i =3D 0; i < opr_sz / 8; i +=3D 2) {
> +        uint64_t nn =3D n[i + hi];
> +        uint64_t mm =3D m[i + hi];
> +        uint64_t rhi =3D 0;
> +        uint64_t rlo =3D 0;
> +
> +        /* Bit 0 can only influence the low 64-bit result.  */
> +        if (nn & 1) {
> +            rlo =3D mm;
> +        }
> +
> +        for (j =3D 1; j < 64; ++j) {
> +            uint64_t mask =3D -((nn >> j) & 1);
> +            rlo ^=3D (mm << j) & mask;
> +            rhi ^=3D (mm >> (64 - j)) & mask;
> +        }
> +        d[i] =3D rlo;
> +        d[i + 1] =3D rhi;
> +    }
> +    clear_tail(d, opr_sz, simd_maxsz(desc));
> +}


--
Alex Benn=C3=A9e

