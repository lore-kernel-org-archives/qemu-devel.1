Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C43C47256
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 06:10:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE94D206A5
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 06:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EkwKj3qv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE94D206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVqmF-0006Cc-Tz
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 02:09:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59860)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jVqlZ-0005mh-S8
 for qemu-devel@nongnu.org; Tue, 05 May 2020 02:09:19 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42123)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jVqlY-0005Ov-K6
 for qemu-devel@nongnu.org; Tue, 05 May 2020 02:09:17 -0400
Received: by mail-wr1-x442.google.com with SMTP id s8so1168127wrt.9
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 23:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=CDEp2z/v9D7LWMa0Jk3xE0IKu16qa/IJSWCiRZGLkkw=;
 b=EkwKj3qvwJyiHbbYoviODBOKnqlCxSZF3r2EpgmA061/dfutcKchlOJUHFnMU8+Xun
 T+R0gE2+ZiJ4+3pnCYqmjeyxJje0tYtn7wFTArysPUcJH+6kuVYNaNVBy7HnT2xRYqR/
 iEGB1/+iCxVXfDVn2QnzQ6hviEgWYBIQ8UHVfK8oWQOlyI/kgv2HSw8c0OxdxJDR/PkX
 MDzkBCWjs49mgjNrUauNXAtYtcGLTvYqRSxluVOxZ4yhmLr1YAmBx0QiZIzzowW9O67X
 5sOUbbmN+7UPE7SL2NCTl/omSMoICMy7DL9bLEjvLR6aDzO88/wj0fJDOwmt4bnUeo5A
 qPMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=CDEp2z/v9D7LWMa0Jk3xE0IKu16qa/IJSWCiRZGLkkw=;
 b=cooH97bfj5SsPuzROgxQhB+E72l0r/Gs9JUcKzCqjUaTr39GJCWo2KBB+MP/yrBlQ1
 gEklam9LdIqQLflgTID1dqYaBxOmbCVARyC8z6nmJb2TVO1v6y5x5r6Zxv9VAzjqOoyJ
 0FYuil/kXk5/zefyFyCCmWabRLHAn19H+HfImJR95Pl0V6R24/f/x8n3iQ0LZujWyBzx
 ZGWAQaxj3En3mKdQV7un8lNKoWrY8G7n100RG1QJ1ZGxadyx2P/koLSS7kboNJ8ZcCp7
 vvo0xTMUEkjP77gC8oOjwMJfkrd/Y/V0PtTR/jHr1nxm8uFY43OAs1E5yJhelwrjQmFb
 lM/w==
X-Gm-Message-State: AGi0PuYhtf1Mwj3nkT4NKZMCVQE4X+v5T29TmfzioC+Yls1JJuWXu0mg
 +G6mFo1WqzfHJhZBzuU5cK8=
X-Google-Smtp-Source: APiQypLAth7HhIt/tyNhQCBxIRfx1x1xjYOCk/kSTrh+Yp/HWQ2wxfIZB/Ww1X4oS2y/jygqIi9KcQ==
X-Received: by 2002:a5d:6cce:: with SMTP id c14mr1630736wrc.424.1588658954961; 
 Mon, 04 May 2020 23:09:14 -0700 (PDT)
Received: from [192.168.1.39] (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id j11sm1335258wrr.62.2020.05.04.23.09.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2020 23:09:13 -0700 (PDT)
Subject: Re: [PATCH v3 3/3] target/arm: Use clear_vec_high more effectively
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200504192344.13404-1-richard.henderson@linaro.org>
 <20200504192344.13404-4-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <aaa3d497-3c54-9acf-7ef1-fc47bd9d699d@amsat.org>
Date: Tue, 5 May 2020 08:09:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200504192344.13404-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/4/20 9:23 PM, Richard Henderson wrote:
> Do not explicitly store zero to the NEON high part
> when we can pass !is_q to clear_vec_high.
> 
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Patch easier to review with 'git-diff --function-context'.

>   target/arm/translate-a64.c | 59 +++++++++++++++++++++++---------------
>   1 file changed, 36 insertions(+), 23 deletions(-)
> 
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index 729e746e25..d1c9150c4f 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -939,11 +939,10 @@ static void do_fp_ld(DisasContext *s, int destidx, TCGv_i64 tcg_addr, int size)
>   {
>       /* This always zero-extends and writes to a full 128 bit wide vector */
>       TCGv_i64 tmplo = tcg_temp_new_i64();
> -    TCGv_i64 tmphi;
> +    TCGv_i64 tmphi = NULL;
>   
>       if (size < 4) {
>           MemOp memop = s->be_data + size;
> -        tmphi = tcg_const_i64(0);
>           tcg_gen_qemu_ld_i64(tmplo, tcg_addr, get_mem_index(s), memop);
>       } else {
>           bool be = s->be_data == MO_BE;
> @@ -961,12 +960,13 @@ static void do_fp_ld(DisasContext *s, int destidx, TCGv_i64 tcg_addr, int size)
>       }
>   
>       tcg_gen_st_i64(tmplo, cpu_env, fp_reg_offset(s, destidx, MO_64));
> -    tcg_gen_st_i64(tmphi, cpu_env, fp_reg_hi_offset(s, destidx));
> -
>       tcg_temp_free_i64(tmplo);
> -    tcg_temp_free_i64(tmphi);
>   
> -    clear_vec_high(s, true, destidx);
> +    if (tmphi) {
> +        tcg_gen_st_i64(tmphi, cpu_env, fp_reg_hi_offset(s, destidx));
> +        tcg_temp_free_i64(tmphi);
> +    }
> +    clear_vec_high(s, tmphi != NULL, destidx);

OK.

>   }
>   
>   /*
> @@ -6960,8 +6960,8 @@ static void disas_simd_ext(DisasContext *s, uint32_t insn)
>           return;
>       }
>   
> -    tcg_resh = tcg_temp_new_i64();
>       tcg_resl = tcg_temp_new_i64();
> +    tcg_resh = NULL;
>   
>       /* Vd gets bits starting at pos bits into Vm:Vn. This is
>        * either extracting 128 bits from a 128:128 concatenation, or
> @@ -6973,7 +6973,6 @@ static void disas_simd_ext(DisasContext *s, uint32_t insn)
>               read_vec_element(s, tcg_resh, rm, 0, MO_64);

                            but then ^^^^^^^^ tcg_resh is NULL...

>               do_ext64(s, tcg_resh, tcg_resl, pos);
>           }
> -        tcg_gen_movi_i64(tcg_resh, 0);
>       } else {
>           TCGv_i64 tcg_hh;
>           typedef struct {
> @@ -6988,6 +6987,7 @@ static void disas_simd_ext(DisasContext *s, uint32_t insn)
>               pos -= 64;
>           }
>   
> +        tcg_resh = tcg_temp_new_i64();
>           read_vec_element(s, tcg_resl, elt->reg, elt->elt, MO_64);
>           elt++;
>           read_vec_element(s, tcg_resh, elt->reg, elt->elt, MO_64);
> @@ -7003,9 +7003,12 @@ static void disas_simd_ext(DisasContext *s, uint32_t insn)
>   
>       write_vec_element(s, tcg_resl, rd, 0, MO_64);
>       tcg_temp_free_i64(tcg_resl);
> -    write_vec_element(s, tcg_resh, rd, 1, MO_64);
> -    tcg_temp_free_i64(tcg_resh);
> -    clear_vec_high(s, true, rd);
> +
> +    if (is_q) {
> +        write_vec_element(s, tcg_resh, rd, 1, MO_64);
> +        tcg_temp_free_i64(tcg_resh);
> +    }
> +    clear_vec_high(s, is_q, rd);
>   }
>   
>   /* TBL/TBX
> @@ -7042,17 +7045,21 @@ static void disas_simd_tb(DisasContext *s, uint32_t insn)
>        * the input.
>        */
>       tcg_resl = tcg_temp_new_i64();
> -    tcg_resh = tcg_temp_new_i64();
> +    tcg_resh = NULL;
>   
>       if (is_tblx) {
>           read_vec_element(s, tcg_resl, rd, 0, MO_64);
>       } else {
>           tcg_gen_movi_i64(tcg_resl, 0);
>       }
> -    if (is_tblx && is_q) {
> -        read_vec_element(s, tcg_resh, rd, 1, MO_64);
> -    } else {
> -        tcg_gen_movi_i64(tcg_resh, 0);
> +
> +    if (is_q) {
> +        tcg_resh = tcg_temp_new_i64();
> +        if (is_tblx) {
> +            read_vec_element(s, tcg_resh, rd, 1, MO_64);
> +        } else {
> +            tcg_gen_movi_i64(tcg_resh, 0);
> +        }
>       }
>   
>       tcg_idx = tcg_temp_new_i64();
> @@ -7072,9 +7079,12 @@ static void disas_simd_tb(DisasContext *s, uint32_t insn)
>   
>       write_vec_element(s, tcg_resl, rd, 0, MO_64);
>       tcg_temp_free_i64(tcg_resl);
> -    write_vec_element(s, tcg_resh, rd, 1, MO_64);
> -    tcg_temp_free_i64(tcg_resh);
> -    clear_vec_high(s, true, rd);
> +
> +    if (is_q) {
> +        write_vec_element(s, tcg_resh, rd, 1, MO_64);
> +        tcg_temp_free_i64(tcg_resh);
> +    }
> +    clear_vec_high(s, is_q, rd);

OK.

>   }
>   
>   /* ZIP/UZP/TRN
> @@ -7111,7 +7121,7 @@ static void disas_simd_zip_trn(DisasContext *s, uint32_t insn)
>       }
>   
>       tcg_resl = tcg_const_i64(0);
> -    tcg_resh = tcg_const_i64(0);
> +    tcg_resh = is_q ? tcg_const_i64(0) : NULL;
>       tcg_res = tcg_temp_new_i64();
>   
>       for (i = 0; i < elements; i++) {
> @@ -7162,9 +7172,12 @@ static void disas_simd_zip_trn(DisasContext *s, uint32_t insn)

More context:

            ...
            ofs = i * esize;
            if (ofs < 64) {
                tcg_gen_shli_i64(tcg_res, tcg_res, ofs);
                tcg_gen_or_i64(tcg_resl, tcg_resl, tcg_res);
            } else {
                tcg_gen_shli_i64(tcg_res, tcg_res, ofs - 64);
                tcg_gen_or_i64(tcg_resh, tcg_resh, tcg_res);

                          here ^^^^^^^^ tcg_resh is NULL too.

            }
        }

        tcg_temp_free_i64(tcg_res);

>   
>       write_vec_element(s, tcg_resl, rd, 0, MO_64);
>       tcg_temp_free_i64(tcg_resl);
> -    write_vec_element(s, tcg_resh, rd, 1, MO_64);
> -    tcg_temp_free_i64(tcg_resh);
> -    clear_vec_high(s, true, rd);
> +
> +    if (is_q) {
> +        write_vec_element(s, tcg_resh, rd, 1, MO_64);
> +        tcg_temp_free_i64(tcg_resh);
> +    }
> +    clear_vec_high(s, is_q, rd);
>   }
>   
>   /*
> 

