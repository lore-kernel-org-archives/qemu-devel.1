Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D361C54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 13:10:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 236A3206F5
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 13:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fdbHzyIJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 236A3206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYUfm-0003Pz-66
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 09:10:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45426)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jYUf8-0002lY-Rr
 for qemu-devel@nongnu.org; Tue, 12 May 2020 09:09:34 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:37188)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jYUf7-0008G2-K5
 for qemu-devel@nongnu.org; Tue, 12 May 2020 09:09:34 -0400
Received: by mail-oi1-x243.google.com with SMTP id r25so18136601oij.4
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 06:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=f9iUBhOSWgX5zMT0b6oC2hdjDcRTZ/rPVwX9iqas2w0=;
 b=fdbHzyIJPVDqqG7GRv6n5Vn0MAzX4lJv/bIWcQM5pT+o2GKKd88lNsiIQwTxT1hUrK
 08kQKuFve/zbcNh6xOG8u+sKxBRUxmKAoH7ZbpNShpyRZhYEBUNG3XTJ7FoSaWFCuTmK
 g49dCxiDe1MjTPQ7/NIKGy3wQwwWfmW/nKP6HABQSTgndOn9UvCJ7QbSOtwZNZ+U+noZ
 MvQdeyvWdjcDjhGZ02avsEtWZ91HPQEAPtVQFvQ19eprkfVHBbgJLXgm4vb+ck/DfpKT
 5lu2qy1YLSCAbm44dnaesZl12MpgfQJ89XNXYw4avABP6BwYB22SiErGFxW/bXpp7aej
 EeJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=f9iUBhOSWgX5zMT0b6oC2hdjDcRTZ/rPVwX9iqas2w0=;
 b=AtJabYGCGuCyXjk0djT6w/gu2PwgHG1Bp83xURb7jZ9oLJJiyDzG+pnSZF3Qv5eHcX
 WKmfuUIMpXMzOzmF2Ac2NQn+QLcJFUpGhvBhnQT9sdU52dfOQO2cSvGGTwaJio0KbOZp
 t5wzAFm7oWXH0mPo/35yK+HM35JnS7ALS4tx5QocZ35ircT7189UP5ZjDlrM6kQPSBSG
 rTIhnBrSHABSwNTxE4KD8eXFI8s3IVKWsp7W041KLvIMY9Yk6i/5Zfl00AC5MmZd0Fxw
 MsdVVmHjmNr5XPjYtWrnvWLrdh4OqN/bELTCd1rJCYUvzmQo408sY6pxv+2Jmyx7tP8s
 osQg==
X-Gm-Message-State: AGi0Pub59DRj/1Hy8NYjQI3xN+JhrF0Mo166lPv4SnpBI4B5XCB8aAmE
 w9u35gfIumX0spoC6YGGuI5Qthso6svl8UhdlKmPLA==
X-Google-Smtp-Source: APiQypJte6ReRVrO3rZkfJUrURGEew7APjJjx+KWojR8nbPxLyy16yyJzOSuTTEZ5OewwUseZfqV+Ox3p/MB7jCUMMA=
X-Received: by 2002:a54:400c:: with SMTP id x12mr22432368oie.146.1589288971204; 
 Tue, 12 May 2020 06:09:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200508152200.6547-1-richard.henderson@linaro.org>
 <20200508152200.6547-3-richard.henderson@linaro.org>
In-Reply-To: <20200508152200.6547-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 May 2020 14:09:20 +0100
Message-ID: <CAFEAcA9q6ZJqEzgfSTgLiFp0a708yhGjrEGArqhCKUQDVp8XLg@mail.gmail.com>
Subject: Re: [PATCH v3 02/16] target/arm: Create gen_gvec_{u,s}{rshr,rsra}
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 8 May 2020 at 16:22, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Create vectorized versions of handle_shri_with_rndacc
> for shift+round and shift+round+accumulate.  Add out-of-line
> helpers in preparation for longer vector lengths from SVE.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper.h        |  20 ++
>  target/arm/translate.h     |   9 +
>  target/arm/translate-a64.c |  11 +-
>  target/arm/translate.c     | 461 +++++++++++++++++++++++++++++++++++--
>  target/arm/vec_helper.c    |  50 ++++
>  5 files changed, 525 insertions(+), 26 deletions(-)



> +void gen_gvec_srshr(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
> +                    int64_t shift, uint32_t opr_sz, uint32_t max_sz)
> +{
> +    static const TCGOpcode vecop_list[] = {
> +        INDEX_op_shri_vec, INDEX_op_sari_vec, INDEX_op_add_vec, 0
> +    };
> +    static const GVecGen2i ops[4] = {
> +        { .fni8 = gen_srshr8_i64,
> +          .fniv = gen_srshr_vec,
> +          .fno = gen_helper_gvec_srshr_b,
> +          .opt_opc = vecop_list,
> +          .vece = MO_8 },
> +        { .fni8 = gen_srshr16_i64,
> +          .fniv = gen_srshr_vec,
> +          .fno = gen_helper_gvec_srshr_h,
> +          .opt_opc = vecop_list,
> +          .vece = MO_16 },
> +        { .fni4 = gen_srshr32_i32,
> +          .fniv = gen_srshr_vec,
> +          .fno = gen_helper_gvec_srshr_s,
> +          .opt_opc = vecop_list,
> +          .vece = MO_32 },
> +        { .fni8 = gen_srshr64_i64,
> +          .fniv = gen_srshr_vec,
> +          .fno = gen_helper_gvec_srshr_d,
> +          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
> +          .opt_opc = vecop_list,
> +          .vece = MO_64 },
> +    };
> +
> +    /* tszimm encoding produces immediates in the range [1..esize] */
> +    tcg_debug_assert(shift > 0);

This assert can be triggered:

#4  0x00000000004ee086 in gen_gvec_ursra (vece=3, rd_ofs=3112,
rm_ofs=3296, shift=-6, opr_sz=8,
    max_sz=8) at
/home/petmay01/linaro/qemu-from-laptop/qemu/target/arm/translate.c:4413
#5  0x00000000004f17ad in disas_neon_data_insn (s=0x7fffffffe000,
insn=4089066426)
    at /home/petmay01/linaro/qemu-from-laptop/qemu/target/arm/translate.c:5702
#6  0x0000000000510dfa in disas_arm_insn (s=0x7fffffffe000, insn=4089066426)
    at /home/petmay01/linaro/qemu-from-laptop/qemu/target/arm/translate.c:10803
#7  0x0000000000511b6b in arm_tr_translate_insn
(dcbase=0x7fffffffe000, cpu=0xd04ea0)
    at /home/petmay01/linaro/qemu-from-laptop/qemu/target/arm/translate.c:11277
#8  0x000000000045a833 in translator_loop (ops=0xc2ad40
<arm_translator_ops>, db=0x7fffffffe000,
    cpu=0xd04ea0, tb=0x7fffe80e3540 <code_gen_buffer+931091>, max_insns=512)
    at /home/petmay01/linaro/qemu-from-laptop/qemu/accel/tcg/translator.c:102
#9  0x0000000000512303 in gen_intermediate_code (cpu=0xd04ea0,
    tb=0x7fffe80e3540 <code_gen_buffer+931091>, max_insns=512)
    at /home/petmay01/linaro/qemu-from-laptop/qemu/target/arm/translate.c:11568
#10 0x0000000000458c01 in tb_gen_code (cpu=0xd04ea0, pc=4268188000,
cs_base=0, flags=1196032,
    cflags=-16777216) at
/home/petmay01/linaro/qemu-from-laptop/qemu/accel/tcg/translate-all.c:1718
#11 0x0000000000455f73 in tb_find (cpu=0xd04ea0, last_tb=0x0,
tb_exit=0, cf_mask=0)
    at /home/petmay01/linaro/qemu-from-laptop/qemu/accel/tcg/cpu-exec.c:407
#12 0x00000000004566d3 in cpu_exec (cpu=0xd04ea0)
    at /home/petmay01/linaro/qemu-from-laptop/qemu/accel/tcg/cpu-exec.c:731
#13 0x000000000049a380 in cpu_loop (env=0xd0d180)
    at /home/petmay01/linaro/qemu-from-laptop/qemu/linux-user/arm/cpu_loop.c:219
#14 0x0000000000465637 in main (argc=5, argv=0x7fffffffeb28,
envp=0x7fffffffeb58)
    at /home/petmay01/linaro/qemu-from-laptop/qemu/linux-user/main.c:872

> +    tcg_debug_assert(shift <= (8 << vece));
> +
> +    if (shift == (8 << vece)) {
> +        /*
> +         * Shifts larger than the element size are architecturally valid.
> +         * Signed results in all sign bits.  With rounding, this produces
> +         *   (-1 + 1) >> 1 == 0, or (0 + 1) >> 1 == 0.
> +         * I.e. always zero.
> +         */
> +        tcg_gen_gvec_dup_imm(vece, rd_ofs, opr_sz, max_sz, 0);
> +    } else {
> +        tcg_gen_gvec_2i(rd_ofs, rm_ofs, opr_sz, max_sz, shift, &ops[vece]);
> +    }
> +}


> @@ -5269,6 +5685,28 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
>                      }
>                      return 0;
>
> +                case 2: /* VRSHR */
> +                    /* Right shift comes here negative.  */
> +                    shift = -shift;
> +                    if (u) {
> +                        gen_gvec_urshr(size, rd_ofs, rm_ofs, shift,
> +                                       vec_size, vec_size);
> +                    } else {
> +                        gen_gvec_srshr(size, rd_ofs, rm_ofs, shift,
> +                                       vec_size, vec_size);
> +                    }
> +                    return 0;
> +
> +                case 3: /* VRSRA */
> +                    if (u) {
> +                        gen_gvec_ursra(size, rd_ofs, rm_ofs, shift,
> +                                       vec_size, vec_size);
> +                    } else {
> +                        gen_gvec_srsra(size, rd_ofs, rm_ofs, shift,
> +                                       vec_size, vec_size);
> +                    }
> +                    return 0;

I think the VRSRA case needs the same "shift = -shift" as VRSHR.

thanks
-- PMM

