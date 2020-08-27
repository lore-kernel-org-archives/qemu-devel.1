Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B20FC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 09:27:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17C1722BEA
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 09:27:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NUbQaIB1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17C1722BEA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBEC2-0003l9-B6
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 05:27:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57402)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1kBE8p-00060E-7e
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 05:24:19 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:41925)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1kBE8m-0003Sb-Gp
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 05:24:18 -0400
Received: by mail-lf1-x144.google.com with SMTP id y17so1509130lfa.8
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 02:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=jAc9QkYcpJS5T0cX52ZPY/FDmlfraaU2jvBIDWWbuuw=;
 b=NUbQaIB19Gu4DGFCkfGQgKBIZwI7MvZTtRoUYXftvckqDMP0kBUenUfsy2MOuwB9NI
 xCgtxMSiRTDGIMqoY8DPRab5/PypID2szF/Y1JWzfOxDjbPoHK7uN5aoXxTQcpwUB6hW
 32jbDlPrC0gAKqi5rUhajnS9Eraen8Kib01FSYUJEUKdDvTrRK0WxM+Gd1A62vBv9JjE
 uleIoqI2tnAKEsMqbTZGDB57x8mwYRwdcZ1/pyI0CsuyQzVuiELgszc7UuKl9S9Qo+xS
 bvGyeXUzWV8PT69gD8J5BJjnAsB7R/UtMDiAF8wliL9it22+8118JYm2OObWpdRjHaFZ
 d06g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=jAc9QkYcpJS5T0cX52ZPY/FDmlfraaU2jvBIDWWbuuw=;
 b=MOjZ8fTafT8d32j6tPUZDcYrgp2TnJcESOLGeUz7Wk5eI4UExO39UdxBMFUlunqZWQ
 yWokCWkuivYVmpO6UsiDGXjCzkELz+e6GBnVKsK3yitEvYsZogedBaqsJAiFCvJR9c6Q
 IFmuFhMLLvduPoweoS9U7HHA2+VN/bgliSgvnuQN1XJlgJFbichv6/HBXochTTr3YIOf
 zAO213Hzs/AgeuKd5nkx2Q/pAjVkc0khmNFsimAGpE3rZRfFhni8IDomcRpLQNBbfBA3
 Kc6+1oMPpa0gi3S/HpyyM7mpxMgXsR9egJKu0Y4Asbi+eUEvFjn2d2OFNw4Nmsxav+od
 XxrQ==
X-Gm-Message-State: AOAM532a5WeB8shgjLAIWxKGfLQhlEoDkNVm2z/KJpKSxJaOCVhHAP0n
 an5BmAOJX5MkYLW3uF7E0Io=
X-Google-Smtp-Source: ABdhPJxUVaOwT5gSxkrPcrgbTidibTdJSexkROKuOvpdESP8X8vBUhQ+6EA8YwQGTwMU/9sVnPbL/Q==
X-Received: by 2002:a05:6512:31c3:: with SMTP id
 j3mr9548125lfe.204.1598520254456; 
 Thu, 27 Aug 2020 02:24:14 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id 10sm345251ljn.22.2020.08.27.02.24.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2020 02:24:13 -0700 (PDT)
Date: Thu, 27 Aug 2020 11:24:13 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 64/77] target/microblaze: Convert mbar to decodetree
Message-ID: <20200827092413.GL2954729@toto>
References: <20200825205950.730499-1-richard.henderson@linaro.org>
 <20200825205950.730499-65-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825205950.730499-65-richard.henderson@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::144;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x144.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FSL_HELO_FAKE=3.066, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 25, 2020 at 01:59:37PM -0700, Richard Henderson wrote:
> Split this out of the normal branch instructions, as it requires
> special handling.  End the TB only for an instruction barrier.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/microblaze/insns.decode |  2 +
>  target/microblaze/translate.c  | 81 ++++++++++++++++++----------------
>  2 files changed, 45 insertions(+), 38 deletions(-)
> 
> diff --git a/target/microblaze/insns.decode b/target/microblaze/insns.decode
> index 53da2b75aa..77b073be9e 100644
> --- a/target/microblaze/insns.decode
> +++ b/target/microblaze/insns.decode
> @@ -124,6 +124,8 @@ lwea            110010 ..... ..... ..... 0001 000 0000  @typea
>  lwx             110010 ..... ..... ..... 1000 000 0000  @typea
>  lwi             111010 ..... ..... ................     @typeb
>  
> +mbar            101110 imm:5 00010 0000 0000 0000 0100
> +
>  mul             010000 ..... ..... ..... 000 0000 0000  @typea
>  mulh            010000 ..... ..... ..... 000 0000 0001  @typea
>  mulhu           010000 ..... ..... ..... 000 0000 0011  @typea
> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
> index fc1c661368..a391e80fb9 100644
> --- a/target/microblaze/translate.c
> +++ b/target/microblaze/translate.c
> @@ -1166,6 +1166,48 @@ static bool trans_brki(DisasContext *dc, arg_typeb_br *arg)
>      return true;
>  }
>  
> +static bool trans_mbar(DisasContext *dc, arg_mbar *arg)
> +{
> +    int mbar_imm = arg->imm;
> +
> +    /*
> +     * Instruction access memory barrier.
> +     * End the TB so that we recognize self-modified code immediately.
> +     */
> +    if (mbar_imm & 1) {
> +        dc->cpustate_changed = 1;
> +    }

This should be (mbar_imm & 1) == 0
But even with that fixed it fails some of our tests because interrupts
that should become visible within a couple of cycles after a
memory data barrier can now be delayed longer.

I think we should always break the TB.

> +    /* Data access memory barrier.  */
> +    if (mbar_imm & 2) {
> +        tcg_gen_mb(TCG_BAR_SC | TCG_MO_ALL);
> +    }

This should be (mbar_imm & 2) == 0


> +
> +    /* Sleep. */
> +    if (mbar_imm & 16) {
> +        TCGv_i32 tmp_1;
> +
> +        if (trap_userspace(dc, true)) {
> +            /* Sleep is a privileged instruction.  */
> +            return true;
> +        }
> +
> +        t_sync_flags(dc);
> +
> +        tmp_1 = tcg_const_i32(1);
> +        tcg_gen_st_i32(tmp_1, cpu_env,
> +                       -offsetof(MicroBlazeCPU, env)
> +                       +offsetof(CPUState, halted));
> +        tcg_temp_free_i32(tmp_1);
> +
> +        tcg_gen_movi_i32(cpu_pc, dc->base.pc_next + 4);
> +
> +        gen_raise_exception(dc, EXCP_HLT);
> +    }
> +    return true;
> +}
> +
> +
>  static void msr_read(DisasContext *dc, TCGv_i32 d)
>  {
>      TCGv_i32 t;
> @@ -1447,50 +1489,13 @@ static void dec_bcc(DisasContext *dc)
>  
>  static void dec_br(DisasContext *dc)
>  {
> -    unsigned int dslot, link, abs, mbar;
> +    unsigned int dslot, link, abs;
>      uint32_t add_pc;
>  
>      dslot = dc->ir & (1 << 20);
>      abs = dc->ir & (1 << 19);
>      link = dc->ir & (1 << 18);
>  
> -    /* Memory barrier.  */
> -    mbar = (dc->ir >> 16) & 31;
> -    if (mbar == 2 && dc->imm == 4) {
> -        uint16_t mbar_imm = dc->rd;
> -
> -        /* Data access memory barrier.  */
> -        if ((mbar_imm & 2) == 0) {
> -            tcg_gen_mb(TCG_BAR_SC | TCG_MO_ALL);
> -        }
> -
> -        /* mbar IMM & 16 decodes to sleep.  */
> -        if (mbar_imm & 16) {
> -            TCGv_i32 tmp_1;
> -
> -            if (trap_userspace(dc, true)) {
> -                /* Sleep is a privileged instruction.  */
> -                return;
> -            }
> -
> -            t_sync_flags(dc);
> -
> -            tmp_1 = tcg_const_i32(1);
> -            tcg_gen_st_i32(tmp_1, cpu_env,
> -                           -offsetof(MicroBlazeCPU, env)
> -                           +offsetof(CPUState, halted));
> -            tcg_temp_free_i32(tmp_1);
> -
> -            tcg_gen_movi_i32(cpu_pc, dc->base.pc_next + 4);
> -
> -            gen_raise_exception(dc, EXCP_HLT);
> -            return;
> -        }
> -        /* Break the TB.  */
> -        dc->cpustate_changed = 1;
> -        return;
> -    }
> -
>      if (dslot && dec_setup_dslot(dc)) {
>          return;
>      }
> -- 
> 2.25.1
> 

