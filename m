Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E32EC43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 23:33:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25FED20663
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 23:33:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c5uzQ7r2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25FED20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHbzg-0002vr-6x
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 19:33:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37094)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jHbyv-0002RS-7R
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 19:32:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jHbyt-00085s-R3
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 19:32:12 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:38010)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jHbyt-000841-K6
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 19:32:11 -0400
Received: by mail-pl1-x644.google.com with SMTP id w3so2755707plz.5
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 16:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=pU1lNeZmeol/IzGK+YUex2ZmlBph/TYtG4Nj8RjZ7Bo=;
 b=c5uzQ7r2xn431cJPDfv9yS8fjWFpAiWJhoxbRhvlg/2AWVIPDa4KrumdYHVPTVcAzp
 CapAgRGasyZc3Pr/HZKbv4bwPF8zxFIWEut6Z3Wx8VAxIxMOnOGOG5KihBplgUvEmiq7
 VY0mNUVrQ/5XKoKsh9gr41lG6bhmSBbMhy0nhDIrOJnel4+T8ckiFPsKX4SF982mFntV
 zWAtcwKixqGJdzVJx2n3c2RwLinuDQJ1EiEQTpN9pWpW9z0yTbhPw8Oax4fXnIvHFzRj
 2e9RPrDmOePuJPPxJ0IzajZ8a/N3F1shgMxrTGXIWrvwzo5Xm/8eBR7a92g2H5nZx4p5
 L8Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pU1lNeZmeol/IzGK+YUex2ZmlBph/TYtG4Nj8RjZ7Bo=;
 b=Ue7mJEzGK/S8v+GTqN/y/CBACKf7baSmpHdYw1xcRccMnS4nQr3rHdU6DcA1082Lju
 SFOonTP8SdamsU1WN6qzaaT6MxgIiArRx/ukjMhE2IZvhWov8KJUI9T+EaAd9X1Y6mCR
 cgtYjPztDeJP7qGexWAQ6y7dan3xuLjJQD9ISmek8+XqkzwemJtj8JPQio1NVYV3aDHL
 jGdRzP351IYUJQ8yB1W9MxkAWOJl0PmmcBXy7X3IrM29KQ8fIxQ5cKW/OHybEejchlTD
 FJZVa1HsuZIzX9F3RraV1jv608VQAPuW6aibwJvx+QqBqR8BvEHmDBN+rhl0jFDHqPZY
 +2VA==
X-Gm-Message-State: ANhLgQ1yLZnP1TZtwl9jwocbknMnSmhDmlvH87j/I5qSWq1xY6M/7M6G
 UXYimDpea/jf5SPDBHKoZg24Ww==
X-Google-Smtp-Source: ADFU+vsPtNs7SJAT2UJjddGUB4AepNhTtjsjFxdxJMQitLf7ogn1lTAyBDC5YieWWkvSesGnaE8qog==
X-Received: by 2002:a17:902:4b:: with SMTP id 69mr9903224pla.97.1585265530319; 
 Thu, 26 Mar 2020 16:32:10 -0700 (PDT)
Received: from [192.168.1.11] (174-21-138-234.tukw.qwest.net. [174.21.138.234])
 by smtp.gmail.com with ESMTPSA id d71sm2616691pfd.46.2020.03.26.16.32.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Mar 2020 16:32:09 -0700 (PDT)
Subject: Re: [PATCH for 5.0 v1 2/2] riscv: AND stage-1 and stage-2 protection
 flags
To: Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <cover.1585262586.git.alistair.francis@wdc.com>
 <846f1e18f5922d818bc464ec32c144ef314ec724.1585262586.git.alistair.francis@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c835ef40-6e7a-7639-236c-5fb939bf7fc2@linaro.org>
Date: Thu, 26 Mar 2020 16:32:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <846f1e18f5922d818bc464ec32c144ef314ec724.1585262586.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
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
Cc: alistair23@gmail.com, palmer@dabbelt.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/26/20 3:44 PM, Alistair Francis wrote:
> Take the result of stage-1 and stage-2 page table walks and AND the two
> protection flags together. This way we require both to set permissions
> instead of just stage-2.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/cpu_helper.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index f36d184b7b..50e13a064f 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -707,7 +707,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>  #ifndef CONFIG_USER_ONLY
>      vaddr im_address;
>      hwaddr pa = 0;
> -    int prot;
> +    int prot, prot2;
>      bool pmp_violation = false;
>      bool m_mode_two_stage = false;
>      bool hs_mode_two_stage = false;
> @@ -757,13 +757,15 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>              /* Second stage lookup */
>              im_address = pa;
>  
> -            ret = get_physical_address(env, &pa, &prot, im_address,
> +            ret = get_physical_address(env, &pa, &prot2, im_address,
>                                         access_type, mmu_idx, false, true);
>  
>              qemu_log_mask(CPU_LOG_MMU,
>                      "%s 2nd-stage address=%" VADDR_PRIx " ret %d physical "
>                      TARGET_FMT_plx " prot %d\n",
> -                    __func__, im_address, ret, pa, prot);
> +                    __func__, im_address, ret, pa, prot2);
> +
> +            prot &= prot2;
>  
>              if (riscv_feature(env, RISCV_FEATURE_PMP) &&
>                  (ret == TRANSLATE_SUCCESS) &&
> 

Whee!  Yes, I think this is what you've been looking for.
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

