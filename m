Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E895CA9EAB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 18:18:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22D5121835
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 18:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tBcp1YV7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22D5121835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLWpz-0008UD-Sm
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 14:18:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60395)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iLWSW-0000hG-16
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 13:54:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iLWSU-0002wl-65
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 13:54:39 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:37893)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iLWST-0002w0-Vo
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 13:54:38 -0400
Received: by mail-wm1-x343.google.com with SMTP id 3so6923588wmi.3
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 10:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=rBJIe4U1DEibCXCDyfU3C9VSKWPN4prYNtcxOf5Z00I=;
 b=tBcp1YV7jQ8owhDtQT2Y1mRIjkFAee8zjHzxMF8fAGMxksuciu7KExYfJq5KbPqfXx
 5gowcamqlZcsEbW7jXYasORvcwbVxaTWznDCrbR3/BsYzJwaCtTzH+OJK0bWshKPOTvO
 0hEYzYaCJWNFDKXvWCzhwe5uBs94JG9ri7pzwb5FUhpmGG6jHLWFBJ2AnowwikCZ0lJI
 yx6d1y3J8MPnx/IEZr3uaXKJQGbsJ3Gc+xlm/EXLGgPMWAk9bInCnfKdg4DhB50riNqD
 Hvi2B0Ibo6moa49Jyj1s+tCl3rBdFfG73Q9/lCwwpjJIEe6dPCs/bVV3tpnWP6ZZuoV4
 ZO4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=rBJIe4U1DEibCXCDyfU3C9VSKWPN4prYNtcxOf5Z00I=;
 b=LPD5OFhELjqW1aYEzzixvDZMGex3FEUDbaofaXNLY5wQqfTKglpwShYVAzlbdXyVzn
 rzPjukOOpxlklfVxTsAx91qlYeT7LZ7T33U9CfAuH5C3kSdAl018XDQGqfKFvwtHbFZT
 bz2IXhR46hLD8XQRToOL011GxyjVEbRc+h695XSs4RNk4MHGam+CTID0x0Wa+xuDncxl
 IfomhlKmpKX8uC2KSnp5H3b9RlHCBzroc8Z6TuydGfydfoNJHgt2Q3m2UVr3tlGiT1n/
 pHY2BQWUCfuDo9k+UgZakZHAhzifOSfbAQ5XT1O5A9tnWQKJ53A1lM8KmhbUo3xWLQmt
 oUfg==
X-Gm-Message-State: APjAAAV61tn7Ig6mwie3Rvl3WvaAYYV6A5PfVbR1SAwDFtSm8vX0zrnC
 RJ7S4WTDJWwgAZSWvg9legkxxw==
X-Google-Smtp-Source: APXvYqxAZYbtpgBbRG5SPjLTXAc6Ohtn9vno1JOM02j77h8lq1nbb7r9ndTgMrnk/MG31Ixo60284w==
X-Received: by 2002:a05:600c:214:: with SMTP id
 20mr8889215wmi.45.1571421276163; 
 Fri, 18 Oct 2019 10:54:36 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id r13sm7876069wra.74.2019.10.18.10.54.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2019 10:54:35 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 91C011FF87;
 Fri, 18 Oct 2019 18:54:34 +0100 (BST)
References: <20191017044232.27601-1-richard.henderson@linaro.org>
 <20191017044232.27601-5-richard.henderson@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-arm@nongnu.org
Subject: Re: [PATCH 4/4] target/arm: Convert PMULL.8 to gvec
In-reply-to: <20191017044232.27601-5-richard.henderson@linaro.org>
Date: Fri, 18 Oct 2019 18:54:34 +0100
Message-ID: <87tv86ndlx.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> We still need two different helpers, since NEON and SVE2 get the
> inputs from different locations within the source vector.  However,
> we can convert both to the same internal form for computation.
>
> The sve2 helper is not used yet, but adding it with this patch
> helps illustrate why the neon changes are helpful.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/helper-sve.h    |  2 ++
>  target/arm/helper.h        |  3 +-
>  target/arm/neon_helper.c   | 32 --------------------
>  target/arm/translate-a64.c | 27 +++++++++++------
>  target/arm/translate.c     | 26 ++++++++---------
>  target/arm/vec_helper.c    | 60 ++++++++++++++++++++++++++++++++++++++
>  6 files changed, 95 insertions(+), 55 deletions(-)
>
> diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
> index 9e79182ab4..2f47279155 100644
> --- a/target/arm/helper-sve.h
> +++ b/target/arm/helper-sve.h
> @@ -1574,3 +1574,5 @@ DEF_HELPER_FLAGS_6(sve_stdd_le_zd, TCG_CALL_NO_WG,
>                     void, env, ptr, ptr, ptr, tl, i32)
>  DEF_HELPER_FLAGS_6(sve_stdd_be_zd, TCG_CALL_NO_WG,
>                     void, env, ptr, ptr, ptr, tl, i32)
> +
> +DEF_HELPER_FLAGS_4(sve2_pmull_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i=
32)
> diff --git a/target/arm/helper.h b/target/arm/helper.h
> index d954399b7e..8a8517cf34 100644
> --- a/target/arm/helper.h
> +++ b/target/arm/helper.h
> @@ -335,7 +335,6 @@ DEF_HELPER_2(neon_sub_u8, i32, i32, i32)
>  DEF_HELPER_2(neon_sub_u16, i32, i32, i32)
>  DEF_HELPER_2(neon_mul_u8, i32, i32, i32)
>  DEF_HELPER_2(neon_mul_u16, i32, i32, i32)
> -DEF_HELPER_2(neon_mull_p8, i64, i32, i32)
>
>  DEF_HELPER_2(neon_tst_u8, i32, i32, i32)
>  DEF_HELPER_2(neon_tst_u16, i32, i32, i32)
> @@ -688,6 +687,8 @@ DEF_HELPER_FLAGS_4(gvec_ushl_h, TCG_CALL_NO_RWG, void=
, ptr, ptr, ptr, i32)
>  DEF_HELPER_FLAGS_4(gvec_pmul_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i3=
2)
>  DEF_HELPER_FLAGS_4(gvec_pmull_q, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i=
32)
>
> +DEF_HELPER_FLAGS_4(neon_pmull_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i=
32)
> +
>  #ifdef TARGET_AARCH64
>  #include "helper-a64.h"
>  #include "helper-sve.h"
> diff --git a/target/arm/neon_helper.c b/target/arm/neon_helper.c
> index 6a107da0e1..c7a8438b42 100644
> --- a/target/arm/neon_helper.c
> +++ b/target/arm/neon_helper.c
> @@ -1129,38 +1129,6 @@ NEON_VOP(mul_u8, neon_u8, 4)
>  NEON_VOP(mul_u16, neon_u16, 2)
>  #undef NEON_FN
>
> -/* Polynomial multiplication is like integer multiplication except the
> -   partial products are XORed, not added.  */
> -uint64_t HELPER(neon_mull_p8)(uint32_t op1, uint32_t op2)
> -{
> -    uint64_t result =3D 0;
> -    uint64_t mask;
> -    uint64_t op2ex =3D op2;
> -    op2ex =3D (op2ex & 0xff) |
> -        ((op2ex & 0xff00) << 8) |
> -        ((op2ex & 0xff0000) << 16) |
> -        ((op2ex & 0xff000000) << 24);
> -    while (op1) {
> -        mask =3D 0;
> -        if (op1 & 1) {
> -            mask |=3D 0xffff;
> -        }
> -        if (op1 & (1 << 8)) {
> -            mask |=3D (0xffffU << 16);
> -        }
> -        if (op1 & (1 << 16)) {
> -            mask |=3D (0xffffULL << 32);
> -        }
> -        if (op1 & (1 << 24)) {
> -            mask |=3D (0xffffULL << 48);
> -        }
> -        result ^=3D op2ex & mask;
> -        op1 =3D (op1 >> 1) & 0x7f7f7f7f;
> -        op2ex <<=3D 1;
> -    }
> -    return result;
> -}
> -
>  #define NEON_FN(dest, src1, src2) dest =3D (src1 & src2) ? -1 : 0
>  NEON_VOP(tst_u8, neon_u8, 4)
>  NEON_VOP(tst_u16, neon_u16, 2)
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index 12588d18df..2934e4fc16 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -10483,10 +10483,6 @@ static void handle_3rd_widening(DisasContext *s,=
 int is_q, int is_u, int size,
>                  gen_helper_neon_addl_saturate_s32(tcg_passres, cpu_env,
>                                                    tcg_passres, tcg_passr=
es);
>                  break;
> -            case 14: /* PMULL */
> -                assert(size =3D=3D 0);
> -                gen_helper_neon_mull_p8(tcg_passres, tcg_op1, tcg_op2);
> -                break;
>              default:
>                  g_assert_not_reached();
>              }
> @@ -10650,11 +10646,21 @@ static void disas_simd_three_reg_diff(DisasCont=
ext *s, uint32_t insn)
>          handle_3rd_narrowing(s, is_q, is_u, size, opcode, rd, rn, rm);
>          break;
>      case 14: /* PMULL, PMULL2 */
> -        if (is_u || size =3D=3D 1 || size =3D=3D 2) {
> +        if (is_u) {
>              unallocated_encoding(s);
>              return;
>          }
> -        if (size =3D=3D 3) {
> +        switch (size) {
> +        case 0: /* PMULL.P8 */
> +            if (!fp_access_check(s)) {
> +                return;
> +            }
> +            /* The Q field specifies lo/hi half input for this insn.  */
> +            gen_gvec_op3_ool(s, true, rd, rn, rm, is_q,
> +                             gen_helper_neon_pmull_h);
> +            break;
> +
> +        case 3: /* PMULL.P64 */
>              if (!dc_isar_feature(aa64_pmull, s)) {
>                  unallocated_encoding(s);
>                  return;
> @@ -10665,9 +10671,13 @@ static void disas_simd_three_reg_diff(DisasConte=
xt *s, uint32_t insn)
>              /* The Q field specifies lo/hi half input for this insn.  */
>              gen_gvec_op3_ool(s, true, rd, rn, rm, is_q,
>                               gen_helper_gvec_pmull_q);
> -            return;
> +            break;
> +
> +        default:
> +            unallocated_encoding(s);
> +            break;
>          }
> -        goto is_widening;
> +        return;
>      case 9: /* SQDMLAL, SQDMLAL2 */
>      case 11: /* SQDMLSL, SQDMLSL2 */
>      case 13: /* SQDMULL, SQDMULL2 */
> @@ -10688,7 +10698,6 @@ static void disas_simd_three_reg_diff(DisasContex=
t *s, uint32_t insn)
>              unallocated_encoding(s);
>              return;
>          }
> -    is_widening:
>          if (!fp_access_check(s)) {
>              return;
>          }
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 4e34249672..c3abf130cc 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -5873,15 +5873,20 @@ static int disas_neon_data_insn(DisasContext *s, =
uint32_t insn)
>                      return 1;
>                  }
>
> -                /* Handle VMULL.P64 (Polynomial 64x64 to 128 bit multipl=
y)
> -                 * outside the loop below as it only performs a single p=
ass.
> -                 */
> -                if (op =3D=3D 14 && size =3D=3D 2) {
> -                    if (!dc_isar_feature(aa32_pmull, s)) {
> -                        return 1;
> +                /* Handle polynomial VMULL in a single pass.  */
> +                if (op =3D=3D 14) {
> +                    if (size =3D=3D 0) {
> +                        /* VMULL.P8 */
> +                        tcg_gen_gvec_3_ool(rd_ofs, rn_ofs, rm_ofs, 16, 1=
6,
> +                                           0, gen_helper_neon_pmull_h);
> +                    } else {
> +                        /* VMULL.P64 */
> +                        if (!dc_isar_feature(aa32_pmull, s)) {
> +                            return 1;
> +                        }
> +                        tcg_gen_gvec_3_ool(rd_ofs, rn_ofs, rm_ofs, 16, 1=
6,
> +                                           0, gen_helper_gvec_pmull_q);
>                      }
> -                    tcg_gen_gvec_3_ool(rd_ofs, rn_ofs, rm_ofs, 16, 16,
> -                                       0, gen_helper_gvec_pmull_q);
>                      return 0;
>                  }
>
> @@ -5959,11 +5964,6 @@ static int disas_neon_data_insn(DisasContext *s, u=
int32_t insn)
>                          /* VMLAL, VQDMLAL, VMLSL, VQDMLSL, VMULL, VQDMUL=
L */
>                          gen_neon_mull(cpu_V0, tmp, tmp2, size, u);
>                          break;
> -                    case 14: /* Polynomial VMULL */
> -                        gen_helper_neon_mull_p8(cpu_V0, tmp, tmp2);
> -                        tcg_temp_free_i32(tmp2);
> -                        tcg_temp_free_i32(tmp);
> -                        break;
>                      default: /* 15 is RESERVED: caught earlier  */
>                          abort();
>                      }
> diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
> index 5c1074374e..04b4d7402d 100644
> --- a/target/arm/vec_helper.c
> +++ b/target/arm/vec_helper.c
> @@ -1197,3 +1197,63 @@ void HELPER(gvec_pmull_q)(void *vd, void *vn, void=
 *vm, uint32_t desc)
>      }
>      clear_tail(d, opr_sz, simd_maxsz(desc));
>  }
> +
> +/*
> + * 8x8->16 polynomial multiply.
> + *
> + * The byte inputs are expanded to (or extracted from) half-words.
> + * Note that neon and sve2 get the inputs from different positions.
> + * This allows 4 bytes to be processed in parallel with uint64_t.
> + */
> +
> +static uint64_t expand_byte_to_half(uint64_t x)
> +{
> +    return  (x & 0x000000ff)
> +         | ((x & 0x0000ff00) << 8)
> +         | ((x & 0x00ff0000) << 16)
> +         | ((x & 0xff000000) << 24);
> +}
> +
> +static uint64_t pmull_h(uint64_t op1, uint64_t op2)
> +{
> +    uint64_t result =3D 0;
> +    int i;
> +
> +    for (i =3D 0; i < 8; ++i) {
> +        uint64_t mask =3D (op1 & 0x0001000100010001ull) * 0xffff;
> +        result ^=3D op2 & mask;
> +        op1 >>=3D 1;
> +        op2 <<=3D 1;
> +    }
> +    return result;
> +}
> +
> +void HELPER(neon_pmull_h)(void *vd, void *vn, void *vm, uint32_t desc)
> +{
> +    int hi =3D simd_data(desc);
> +    uint64_t *d =3D vd, *n =3D vn, *m =3D vm;
> +    uint64_t nn =3D n[hi], mm =3D m[hi];
> +
> +    d[0] =3D pmull_h(expand_byte_to_half(nn), expand_byte_to_half(mm));
> +    nn >>=3D 32;
> +    mm >>=3D 32;
> +    d[1] =3D pmull_h(expand_byte_to_half(nn), expand_byte_to_half(mm));
> +
> +    clear_tail(d, 16, simd_maxsz(desc));
> +}
> +
> +#ifdef TARGET_AARCH64
> +void HELPER(sve2_pmull_h)(void *vd, void *vn, void *vm, uint32_t desc)
> +{
> +    int shift =3D simd_data(desc) * 8;
> +    intptr_t i, opr_sz =3D simd_oprsz(desc);
> +    uint64_t *d =3D vd, *n =3D vn, *m =3D vm;
> +
> +    for (i =3D 0; i < opr_sz / 8; ++i) {
> +        uint64_t nn =3D (n[i] >> shift) & 0x00ff00ff00ff00ffull;
> +        uint64_t mm =3D (m[i] >> shift) & 0x00ff00ff00ff00ffull;
> +
> +        d[i] =3D pmull_h(nn, mm);
> +    }
> +}
> +#endif


--
Alex Benn=C3=A9e

