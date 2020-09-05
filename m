Return-Path: <SRS0=twQi=CO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E75BC433E2
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 21:36:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3CF32073B
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 21:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BkBI8Bmi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3CF32073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEfrB-0007LB-Uf
	for qemu-devel@archiver.kernel.org; Sat, 05 Sep 2020 17:36:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35900)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kEfqQ-0006tC-KP
 for qemu-devel@nongnu.org; Sat, 05 Sep 2020 17:35:34 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:36833)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kEfqO-0000XU-GD
 for qemu-devel@nongnu.org; Sat, 05 Sep 2020 17:35:34 -0400
Received: by mail-wm1-x341.google.com with SMTP id z9so9842179wmk.1
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2020 14:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=OpQvted7S7+4FPai6rTn/puQwuIiv2h0VxhnP7TslMc=;
 b=BkBI8BmiLomRgw3w0QfC3ZEM4qd8tqPcl3nvPAe50DwdHfK91lGD8IMmke8nNegRaM
 qyMLDDxrIl7hoWuIhnjd/q4pKHGFKoMCQucSUiT/qp7jbvhQueEGBPl32gblRsF6z5PW
 ADpqjTthOuO5jEOqhitvrIo5Kf9/An6Slofz84DcREju/Vozs20Tm5nroYQ3eiWZT7sS
 ZuTaTiVEJZG+lhTz3+//KuIzJMcDvMgErIq5Mj5uDT9kqIZD1hC9ChgLtSKEn22XLZVD
 ym4kFOK2pm8HQggmWwjLZ9rZFQ/lRHf/jNUYJcKNTjJpF0UOyb3EELDwCA7kt29pDKNl
 tTig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OpQvted7S7+4FPai6rTn/puQwuIiv2h0VxhnP7TslMc=;
 b=sovAOdPvpd3itWNM3uhB61Y4IXXNhqyYLe3I6DEgBMUuFzi1p2Hv78q5L5JyPTKKne
 LeQGAqKc9d+9FHE6LP13WLwRbGOQOofDQviDMuDKnvXmmu1mhrmJruXolu6PUzfAOMhQ
 bPMa2C9DP2whrF99D7bu/K1J0F5xIEuCdHtirUzDZwdDuEOE6yEt0mu+3khaD5r8BROe
 ehx0iHp5fnqv66KJqn26opjajmCdDEyXQR3FBEX0sw/2Cf3PNiBSCqQ5uygPZroAlEMC
 1jggPdwv2afu6fuPvL0zfUL4oyEujQVbCme7x8uHFpvKV8WmukoE94m1IHgzf9qBe9fM
 bHiQ==
X-Gm-Message-State: AOAM531Yd77sYBZIUCsWZXJXEofr/ggRJkc2wBzBfIcOrXuJOBBij7El
 oT+xplpQ8aCZU2OwkOcXCUM=
X-Google-Smtp-Source: ABdhPJyhrRqFzYFCAtn7wRSIdVXgt49wfOqTOsocn9lSSKsGDWUUOyu9u4ngIOy+zHW8lBJVNQgr5A==
X-Received: by 2002:a1c:5906:: with SMTP id n6mr11988958wmb.160.1599341731310; 
 Sat, 05 Sep 2020 14:35:31 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id c14sm19204965wrv.12.2020.09.05.14.35.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Sep 2020 14:35:30 -0700 (PDT)
Subject: Re: [PATCH v3 12/19] target/microblaze: Split out MicroBlazeCPUConfig
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200904190842.2282109-1-richard.henderson@linaro.org>
 <20200904190842.2282109-13-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <78a05885-0456-76d4-18e7-397675f641f8@amsat.org>
Date: Sat, 5 Sep 2020 23:35:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200904190842.2282109-13-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001, NICE_REPLY_A=-0.107,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: edgar.iglesias@xilinx.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/4/20 9:08 PM, Richard Henderson wrote:
> This struct was previously unnamed, and defined in MicroBlazeCPU.
> Pull it out to its own typedef so that we can reuse it.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  target/microblaze/cpu.h | 55 ++++++++++++++++++++++-------------------
>  1 file changed, 29 insertions(+), 26 deletions(-)
> 
> diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
> index 20c2979396..59d2a079c4 100644
> --- a/target/microblaze/cpu.h
> +++ b/target/microblaze/cpu.h
> @@ -291,6 +291,34 @@ struct CPUMBState {
>      } pvr;
>  };
>  
> +/*
> + * Microblaze Configuration Settings
> + */
> +typedef struct {
> +    bool stackprot;
> +    uint32_t base_vectors;
> +    uint8_t addr_size;
> +    uint8_t use_fpu;
> +    uint8_t use_hw_mul;
> +    bool use_barrel;
> +    bool use_div;
> +    bool use_msr_instr;
> +    bool use_pcmp_instr;
> +    bool use_mmu;
> +    bool dcache_writeback;
> +    bool endi;
> +    bool dopb_bus_exception;
> +    bool iopb_bus_exception;
> +    bool illegal_opcode_exception;
> +    bool opcode_0_illegal;
> +    bool div_zero_exception;
> +    bool unaligned_exceptions;
> +    uint8_t pvr_user1;
> +    uint32_t pvr_user2;
> +    char *version;
> +    uint8_t pvr;
> +} MicroBlazeCPUConfig;
> +
>  /**
>   * MicroBlazeCPU:
>   * @env: #CPUMBState
> @@ -305,32 +333,7 @@ struct MicroBlazeCPU {
>  
>      CPUNegativeOffsetState neg;
>      CPUMBState env;
> -
> -    /* Microblaze Configuration Settings */
> -    struct {
> -        bool stackprot;
> -        uint32_t base_vectors;
> -        uint8_t addr_size;
> -        uint8_t use_fpu;
> -        uint8_t use_hw_mul;
> -        bool use_barrel;
> -        bool use_div;
> -        bool use_msr_instr;
> -        bool use_pcmp_instr;
> -        bool use_mmu;
> -        bool dcache_writeback;
> -        bool endi;
> -        bool dopb_bus_exception;
> -        bool iopb_bus_exception;
> -        bool illegal_opcode_exception;
> -        bool opcode_0_illegal;
> -        bool div_zero_exception;
> -        bool unaligned_exceptions;
> -        uint8_t pvr_user1;
> -        uint32_t pvr_user2;
> -        char *version;
> -        uint8_t pvr;
> -    } cfg;
> +    MicroBlazeCPUConfig cfg;
>  };
>  
>  
> 

