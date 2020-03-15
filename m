Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E40C0044D
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 02:54:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5930320578
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 02:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GTygrW5A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5930320578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDJPn-0002fZ-FR
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 22:54:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45804)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jDJOx-0002FV-T6
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 22:53:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jDJOw-0001Vw-JB
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 22:53:19 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:34754)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jDJOw-0001RS-Bk
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 22:53:18 -0400
Received: by mail-pl1-x642.google.com with SMTP id a23so6207957plm.1
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2020 19:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=0Paoo5Y6QAMXGq0TfWOHgSODC3JwQq6tWpuVY5sT9HQ=;
 b=GTygrW5ANRw+v++vjUJ1WM8BuzucUVVMaClqDl5CrfcnZReY75nEt43AkdenrJVLv6
 rfoNY7W2wW0ID4Q067AGbfIc8sTqfB7DHtKBbgw2dVnVn6EyfxsB47JjRPziGCBD+a3H
 4Y3QWBFmCq1U0KRGD7Bawr7qOJOrm8morSjujL2/ZjaCUwMzA9714yVsMP1QDyPJRa/H
 zURTtwSB3zHktaG98YswDPrPk7HWf3aNwEnvWW1DquRVNsPp2tSq3sibYrPwQT0oTIzv
 Guvh0cq+jyRfa8Cd9NtCZIYAtLjQdaGj8FcR3UpLRBWn4Zf8in/FUxI4zfuSRHn7Xb+a
 uZJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0Paoo5Y6QAMXGq0TfWOHgSODC3JwQq6tWpuVY5sT9HQ=;
 b=YbMFs4yNzjz7OHD9e5UYA8dDLtneb49V9YtSDweDYKYklcyTdVXphZGBzA6SeV/bTW
 tuVLeyro+8uvTXTk3lFNMK3f36YJh1Q8SbLZL4fYWCVa25ecGdKk+NvAK++0BJQGPgWP
 lkzl1WZmUtPe4WNjR34ZPRFg67bLq4bwuaW8dT3Sszn8ON7Xon4e6gGP+AIg9SFgBGtX
 qfSpkUj1bbcnKnfsNDxkbgzAY9LCBMu4/SY/x8HCBzOgeMDEyDbQZzLocz4zB9AayNiE
 XRnz/bnkTC2i8mwTobwxZs/3n7MktnaMrf+SWhedrAbONTtCyfSizmbVr9V9Ue80UX2D
 nZzA==
X-Gm-Message-State: ANhLgQ30vVFNBi7iCdSi1byEt4Rg3zwE4T4rswujvm92ckN8eY0/FRkA
 aBH+qsWkQggxqt0XDX6Tox0Dyg==
X-Google-Smtp-Source: ADFU+vtIK91Z27vUYTorN3Wz4DSOvcE9pNQ+OdfANDwMOCHXoQy1IsmDxEgG2OR9ThKSu16dNRBZ1A==
X-Received: by 2002:a17:902:463:: with SMTP id
 90mr21557172ple.213.1584240797062; 
 Sat, 14 Mar 2020 19:53:17 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 q15sm25080351pgn.68.2020.03.14.19.53.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Mar 2020 19:53:16 -0700 (PDT)
Subject: Re: [PATCH v5 54/60] target/riscv: integer extract instruction
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200312145900.2054-1-zhiwei_liu@c-sky.com>
 <20200312145900.2054-55-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <de89d8bc-f578-ac42-58f3-4f5822c8fcfb@linaro.org>
Date: Sat, 14 Mar 2020 19:53:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200312145900.2054-55-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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
Cc: guoren@linux.alibaba.com, wenmeng_zhang@c-sky.com, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/12/20 7:58 AM, LIU Zhiwei wrote:
> +static bool trans_vext_x_v(DisasContext *s, arg_r *a)
> +{
> +    if (vext_check_isa_ill(s, RVV)) {
> +        TCGv_ptr src2;
> +        TCGv dest, src1;
> +        gen_helper_vext_x_v fns[4] = {
> +            gen_helper_vext_x_v_b, gen_helper_vext_x_v_h,
> +            gen_helper_vext_x_v_w, gen_helper_vext_x_v_d
> +        };
> +
> +        dest = tcg_temp_new();
> +        src1 = tcg_temp_new();
> +        src2 = tcg_temp_new_ptr();
> +
> +        gen_get_gpr(src1, a->rs1);
> +        tcg_gen_addi_ptr(src2, cpu_env, vreg_ofs(s, a->rs2));
> +
> +        fns[s->sew](dest, src2, src1, cpu_env);
> +        gen_set_gpr(a->rd, dest);
> +
> +        tcg_temp_free(dest);
> +        tcg_temp_free(src1);
> +        tcg_temp_free_ptr(src2);
> +        return true;
> +    }
> +    return false;
> +}

This entire operation can be performed inline easily.

static void extract_element(TCGv dest, TCGv_ptr base,
                            int ofs, int sew)
{
    switch (sew) {
    case MO_8:
        tcg_gen_ld8u_tl(dest, base, ofs);
        break;
    case MO_16:
        tcg_gen_ld16u_tl(dest, base, ofs);
        break;
    default:
        tcg_gen_ld32u_tl(dest, base, ofs);
        break;
#if TARGET_LONG_BITS == 64
    case MO_64:
        tcg_gen_ld_i64(dest, base, ofs);
        break;
#endif
    }
}

static bool trans_vext_x_v(DisasContext *s, arg_r *a)
{
...
    if (a->rs1 == 0) {
        /* Special case vmv.x.s rd, vs2. */
        do_extract(dest, cpu_env,
                   vreg_ofs(s, a->rs2), s->sew);
    } else {
        int vlen = s->vlen >> (3 + s->sew);
        TCGv_i32 ofs = tcg_temp_new_i32();
        TCGv_ptr  base = tcg_temp_new_ptr();
        TCGv t_vlen, t_zero;

        /* Mask the index to the length so that we do
           not produce an out-of-range load. */
        tcg_gen_trunc_tl_i32(ofs, cpu_gpr[a->rs1]);
        tcg_gen_andi_i32(ofs, ofs, vlen - 1);

        /* Convert the index to an offset.  */
        tcg_gen_shli_i32(ofs, ofs, s->sew);

        /* Convert the index to a pointer. */
        tcg_gen_extu_i32_ptr(base, ofs);
        tcg_gen_add_ptr(base, base, cpu_env);

        /* Perform the load. */
        do_extract(dest, base,
                   vreg_ofs(s, a->rs2), s->sew);
        tcg_temp_free_ptr(base);
        tcg_temp_free_i32(ofs);

        /* Flush out-of-range indexing to zero.  */
        t_vlen = tcg_const_tl(vlen);
        t_zero = tcg_const_tl(0);
        tcg_gen_movcond_tl(TCG_COND_LTU, dest, cpu_gpr[a->rs1],
                           t_vlen, dest, t_zero);
        tcg_temp_free(t_vlen);
        tcg_temp_free(t_zero);
    }


r~

