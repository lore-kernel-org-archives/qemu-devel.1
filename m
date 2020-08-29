Return-Path: <SRS0=OYoK=CH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06398C433E2
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 00:49:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE726207DA
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 00:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xigcu6r4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE726207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBp49-0003YM-RW
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 20:49:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36226)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBp3c-00038W-Og
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 20:49:24 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:42902)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBp3a-0006S4-VV
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 20:49:24 -0400
Received: by mail-pg1-x544.google.com with SMTP id g1so1207659pgm.9
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 17:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=FZx7puFCDZzqaTJ4m52TRSa1loOVNVdWZoKyrt+PEeM=;
 b=Xigcu6r4wsu+NSMLI/Q9MnMHYG0YCxJonQ/xxmzrSIcRjEs/RqmMq2QcB6+8g9AQIA
 EQrU9I4y79F8SzYDpdYDPZ1i3PzmYApTbk8/e21yL8nkVUqY9i/D3lVJVNcLPOMIleJh
 CKaSI48D448WMDm3vz20nHg3hYpurpMuMUuy7GzWRtlq9ErgX78nYIFqPRg8jZ0Klgw3
 Zl8wv+zgGwsV47WQg2P8SsYUOCjIoTkhWKcj5XhlJhrNw6FLpsUCbUBnQDZ7W5E94MgK
 p8yqa4YW3BD+hHUT/a9hWvkVwaIgJaYs9IiKmbND5KNOAGtbQCP1gfKu65TABygJQ2cW
 emlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FZx7puFCDZzqaTJ4m52TRSa1loOVNVdWZoKyrt+PEeM=;
 b=uUZnKpgKZFNdyzVUKrJGAo2LNMYld/zElPzFhaOD9wvBfTuuMkBLC+89ZZ4o+ch/+C
 EK0DjxPhDo5mwefODan/cazl0an3lFRp55JM2E5uQOj1ZVlPgZbHdPmEyKSqrb/s7QO5
 U+5c4KAxhYxHhsMQuoadi/nhRokDOlP6zbETEacdsBH53GzPTtW2C2hPha4p83migvro
 LT+9mWqgqscoAr2jNpbMeQlWTQXPnoTE3h6/4pXleBDBRzPATZcMgFdGaahBD2Rwo9Vk
 cBAx7gBY+leZbE54qGnDqevgJt9zu4UIs8XeGBnymhFKQhIYc88xt8bZQ5ejNn7nM6FY
 f8Nw==
X-Gm-Message-State: AOAM5325+f7b+5cg3mNTntKhOqEVBr5vVDnMKTBItnhF+58oVO9/bmey
 wNfDoSZ0pBX2f4oj/LWwlLdGBg==
X-Google-Smtp-Source: ABdhPJytElRgiC/SSz1ayhMF0rfQO6ii842CSvJnS91ef9JfMBlw8VErQmDvHdOpGYci/Cc1tsS97Q==
X-Received: by 2002:a63:9041:: with SMTP id a62mr916710pge.273.1598662160750; 
 Fri, 28 Aug 2020 17:49:20 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id v18sm603547pfu.15.2020.08.28.17.49.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Aug 2020 17:49:19 -0700 (PDT)
Subject: Re: [RFC PATCH v3 25/34] Hexagon (target/hexagon) macros to interface
 with the generator
To: Taylor Simpson <tsimpson@quicinc.com>, qemu-devel@nongnu.org
References: <1597765847-16637-1-git-send-email-tsimpson@quicinc.com>
 <1597765847-16637-26-git-send-email-tsimpson@quicinc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <56924ad5-7b6a-a05f-7773-e9be5cc9b9e5@linaro.org>
Date: Fri, 28 Aug 2020 17:49:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1597765847-16637-26-git-send-email-tsimpson@quicinc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.809,
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
Cc: ale@rev.ng, riku.voipio@iki.fi, philmd@redhat.com, laurent@vivier.eu,
 aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/18/20 8:50 AM, Taylor Simpson wrote:
> +#define DECL_REG(NAME, NUM, X, OFF) \
> +    TCGv NAME = tcg_temp_local_new(); \
> +    int NUM = REGNO(X) + OFF
> +
> +#define DECL_REG_WRITABLE(NAME, NUM, X, OFF) \
> +    TCGv NAME = tcg_temp_local_new(); \
> +    int NUM = REGNO(X) + OFF; \
> +    do { \
> +        int is_predicated = GET_ATTRIB(insn->opcode, A_CONDEXEC); \
> +        if (is_predicated && !is_preloaded(ctx, NUM)) { \
> +            tcg_gen_mov_tl(hex_new_value[NUM], hex_gpr[NUM]); \
> +        } \
> +    } while (0)
> +/*
> + * For read-only temps, avoid allocating and freeing
> + */
> +#define DECL_REG_READONLY(NAME, NUM, X, OFF) \
> +    TCGv NAME; \
> +    int NUM = REGNO(X) + OFF
> +
> +#define DECL_RREG_d(NAME, NUM, X, OFF) \
> +    DECL_REG_WRITABLE(NAME, NUM, X, OFF)
> +#define DECL_RREG_e(NAME, NUM, X, OFF) \
> +    DECL_REG(NAME, NUM, X, OFF)

Is there a good reason for all these macros?
Why not just bake this knowledge into gen_tcg_funcs.py?
Seems like it would be just a couple of functions...

At present, both this and the intermediary files are unreadable.  One has to
pass genptr.c through -E and indent to see what's going on.


r~

