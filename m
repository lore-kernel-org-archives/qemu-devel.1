Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C8FC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 23:20:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7087B206E2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 23:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b6XNCVw+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7087B206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jm3ph-0001fq-L9
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 19:20:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38430)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jm3or-00015u-AD
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 19:19:41 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:39485)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jm3op-0007TE-Kl
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 19:19:41 -0400
Received: by mail-pg1-x542.google.com with SMTP id v11so3645165pgb.6
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 16:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=5InoORvBPmdbOOPFve5ytoeM4Ml48I7ZSKl5hkcfQSw=;
 b=b6XNCVw+cCVE841qHYh3TCc/yGHClceF/S1zgCkd9tX67PbfonmRdNcSd/PjV/h9PA
 K2RrUGRf9MUji2RDabsZ4bl5Gnwy7HHFHTu4aKGCcRDh90E0wYZdU9aIPfjTgBKxw4+/
 Nz1Xez6Ve0/OLQ80T1QXiFDYgK6yfnSu696J/vDthkrhJeRPCMW+dbDbLhkK77BJI17w
 PF3C98+WDWcfYQ+nuKovK6X0oSZHKJoVXSu/JScbVuxKfBNQXIk6iSRGWNhv1Yh46BgP
 hr37+zQR/yRuCOjBjUmWSM4y7hAeT6PJXEJ4cD3Frc4HfjMF1X25Ydm8c16Cd3oiukGY
 pBTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5InoORvBPmdbOOPFve5ytoeM4Ml48I7ZSKl5hkcfQSw=;
 b=UbjgFeScIyzdorclXqRx5AQ5+TjNopC/wpahng1EIMS/IYDb7hFN5TIzB/V82J/tKX
 M8PI6YMVP1RfSreOm46BqhrUtw0e8RqKF6vXNt41EUQ1JNzv/cjFn6RLfhlsgQ1TACjE
 rg/IfgjAA6XKVmEpUbO3CAphdxmpkzC6Ycm2q56Y4o8hymakZyM3DRx9FnHRZAjsMeHc
 Fxzej+oGDORRSVPgAzUbOgAaJIRr2pp10ub37LmK2luc/r3Np6MqNJqTFtP9ILRP4zE4
 rulcyPVXXyu1lUgKD9wrTT0U4IqNOgSoxkk2tu7yvTeWzUIDXuD54ui0QXmHfmm7X3Es
 Qp3Q==
X-Gm-Message-State: AOAM531ZGvNsofflhgWVhMBTRAQa0coi5xK63KIXHZo7/C0v7fzqQkVs
 NzA2Tb2LBmZyo7ekUFMLKFb8+lPlXCo=
X-Google-Smtp-Source: ABdhPJxRtStCIiN6Oqhx8gGT4ymyPF42fyvqKfx3PQpfZpOA2tcgD/oFHz59cAon2BIvWl527hS0hw==
X-Received: by 2002:a62:1512:: with SMTP id 18mr5850514pfv.34.1592522377385;
 Thu, 18 Jun 2020 16:19:37 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id m7sm3412610pgg.69.2020.06.18.16.19.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jun 2020 16:19:36 -0700 (PDT)
Subject: Re: [PATCH 1/6] target/ppc: add byte-reverse br[dwh] instructions
To: Lijun Pan <ljp@linux.ibm.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
References: <20200613042029.22321-1-ljp@linux.ibm.com>
 <20200613042029.22321-2-ljp@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e28b81dd-96ab-78ab-52d1-d751dd38315f@linaro.org>
Date: Thu, 18 Jun 2020 16:19:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200613042029.22321-2-ljp@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/12/20 9:20 PM, Lijun Pan wrote:
> POWER ISA 3.1 introduces following byte-reverse instructions:
> brd: Byte-Reverse Doubleword X-form
> brw: Byte-Reverse Word X-form
> brh: Byte-Reverse Halfword X-form
> 
> Signed-off-by: Lijun Pan <ljp@linux.ibm.com>
> ---
>  target/ppc/translate.c | 62 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
> 
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 4ce3d664b5..2d48fbc8db 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -6971,7 +6971,69 @@ static void gen_dform3D(DisasContext *ctx)
>      return gen_invalid(ctx);
>  }
>  
> +/* brd */
> +static void gen_brd(DisasContext *ctx)
> +{
> +	TCGv_i64 temp = tcg_temp_new_i64();
> +
> +	tcg_gen_bswap64_i64(temp, cpu_gpr[rS(ctx->opcode)]);
> +	tcg_gen_st_i64(temp, cpu_env, offsetof(CPUPPCState, gpr[rA(ctx->opcode)]));


The store is wrong.  You cannot modify storage behind a tcg global variable
like that.  This should just be

    tcg_gen_bswap64_i64(cpu_gpr[rA(ctx->opcode)],
                        cpu_gpr[rS(ctx->opcode)]);

Is this code is within an ifdef for TARGET_PPC64?
If not, then this will break the 32-bit qemu-system-ppc build.
Are you sure you have built and tested all configurations?


> +/* brw */
> +static void gen_brw(DisasContext *ctx)
> +{
> +	TCGv_i64 temp = tcg_temp_new_i64();
> +	TCGv_i64 lsb = tcg_temp_new_i64();
> +	TCGv_i64 msb = tcg_temp_new_i64();
> +
> +	tcg_gen_movi_i64(lsb, 0x00000000ffffffffull);
> +	tcg_gen_and_i64(temp, lsb, cpu_gpr[rS(ctx->opcode)]);
> +	tcg_gen_bswap32_i64(lsb, temp);
> +	
> +	tcg_gen_shri_i64(msb, cpu_gpr[rS(ctx->opcode)], 32);
> +	tcg_gen_bswap32_i64(temp, msb);
> +	tcg_gen_shli_i64(msb, temp, 32);
> +	
> +	tcg_gen_or_i64(temp, lsb, msb);
> +
> +	tcg_gen_st_i64(temp, cpu_env, offsetof(CPUPPCState, gpr[rA(ctx->opcode)]));

Again, the store is wrong.

In addition, this can be computed as

    tcg_gen_bswap64_i64(dest, source);
    tcg_gen_rotli_i64(dest, dest, 32);

> +static void gen_brh(DisasContext *ctx)
> +{
> +	TCGv_i64 temp = tcg_temp_new_i64();
> +	TCGv_i64 t0 = tcg_temp_new_i64();
> +	TCGv_i64 t1 = tcg_temp_new_i64();
> +	TCGv_i64 t2 = tcg_temp_new_i64();
> +	TCGv_i64 t3 = tcg_temp_new_i64();
> +
> +	tcg_gen_movi_i64(t0, 0x00ff00ff00ff00ffull);
> +	tcg_gen_shri_i64(t1, cpu_gpr[rS(ctx->opcode)], 8);
> +	tcg_gen_and_i64(t2, t1, t0);
> +	tcg_gen_and_i64(t1, cpu_gpr[rS(ctx->opcode)], t0);
> +	tcg_gen_shli_i64(t1, t1, 8);
> +	tcg_gen_or_i64(temp, t1, t2);
> +	tcg_gen_st_i64(temp, cpu_env, offsetof(CPUPPCState, gpr[rA(ctx->opcode)]));

Again, the store is wrong.


r~

