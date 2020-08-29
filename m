Return-Path: <SRS0=OYoK=CH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D93FC433E2
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 15:47:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2733C207DA
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 15:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="loavMmFw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2733C207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kC34V-0001nH-Bn
	for qemu-devel@archiver.kernel.org; Sat, 29 Aug 2020 11:47:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49026)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kC33W-0001Ky-2F
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 11:46:14 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:46852)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kC33T-0000Zx-CO
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 11:46:13 -0400
Received: by mail-pf1-x443.google.com with SMTP id b124so503201pfg.13
 for <qemu-devel@nongnu.org>; Sat, 29 Aug 2020 08:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=1WHokPjMm+wHrgfJcaanfcWpQi47m3NLKjuRlOmgjAI=;
 b=loavMmFwAWPyzFRfGVgro1M+nL8nUBIhnCG8Ff44yIQvXJAeFiKum47FKVmJLr5gFV
 BPcM+cf1DrIl5rDkhFhGGwBLgD8P9gru4/IsUNegQZhNL9uFn+QYKl9eEwu5LjrwCheW
 S7Samrbvet/OSRE0FE6JLKltz5KAFaxoEAhJmAUoid2oZwBKLYKTeXxJREtkQ0FVOkI+
 e4Pyq4oDYyhbBZjCQSbhAr2CwfTMO8DaJk/7L1QOAHeeOPiZ8MhZVw2GAglf9cZpi6UX
 DDhY08Jr14PJ5yuqJ8lKa9++5dCwrO6C8hdj3IAxIqe9GAY66ACsriMksr1/Q1SNp2uZ
 YhBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1WHokPjMm+wHrgfJcaanfcWpQi47m3NLKjuRlOmgjAI=;
 b=JMVfndJAUW7qSVQZLcQhAeWRxjzokTroLZoajyVCmtUeV8XRg0ny2Zzz4DyrN/KPkL
 P+TrOZNz0TQmBKZskXBh2U6xqFfXUfabFROGe6IvA75EHsZo5+8L7iLg4br/7F3vOrhv
 aoNWX6NATJRczZDKl8/P5NeFEuxtgJm1Rw4U50zo8cznRrHT8ZOLETnyyF0mnVfDx+Oq
 sNnUC5aycjd5ssBupCmlJQ8lt/N2ee0ItzhsLwP4SGPhtiga9dWtLmkAg+DxmwNzJuQ1
 rOJiqHbVq8mfGCDszqkOxeHs1zYxC+gbP+LE8aspyz31r4QqOmeBZ0+LkVtJsEycwvRq
 XK4g==
X-Gm-Message-State: AOAM530TXykh11ChRvU7KSelAVwuNdBYt+45eIp5H8yvi2YvT5W4Pz9s
 cCPxdiM3nBjc3XfhnU9b4kDyqw==
X-Google-Smtp-Source: ABdhPJw2TDA9F0NK4WyGnLk9tsgfBb6nVo8Yt23SRdJS9ByUzN8cgPpIwv5h/SG0OaUm7gL0859cWQ==
X-Received: by 2002:aa7:957b:: with SMTP id x27mr3301373pfq.177.1598715969816; 
 Sat, 29 Aug 2020 08:46:09 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id v13sm2954971pfn.153.2020.08.29.08.46.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 29 Aug 2020 08:46:09 -0700 (PDT)
Subject: Re: [PATCH v2] memory: Directly dispatch alias accesses on origin
 memory region
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200822161449.1327517-1-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8a8e2dd3-9e22-367f-931f-ece0769d6535@linaro.org>
Date: Sat, 29 Aug 2020 08:46:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200822161449.1327517-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x443.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/22/20 9:14 AM, Philippe Mathieu-Daudé wrote:
> There is an issue when accessing an alias memory region via the
> memory_region_dispatch_read() / memory_region_dispatch_write()
> calls.
> 
> Since commit 2cdfcf272d ("memory: assign MemoryRegionOps to all
> regions") we assign &unassigned_mem_ops to all MemoryRegions.
> 
> The memory_region_init_alias() flow is:
> 
>   memory_region_init_alias()
>   -> memory_region_init()
>      -> object_initialize(TYPE_MEMORY_REGION)
>         -> memory_region_initfn()
>            -> mr->ops = &unassigned_mem_ops;
> 
> When accessing the alias using memory_region_dispatch_read(),
> flow is:
> 
>   memory_region_dispatch_read()
>   -> memory_region_access_valid(mr)
>      -> mr->ops->valid.accepts()
>         -> unassigned_mem_accepts()
>         <- false
>      <- false
>    <- MEMTX_DECODE_ERROR
> 
> The caller gets a MEMTX_DECODE_ERROR while the access is OK.
> 
> Fix by directly dispatching aliases accesses to its origin region.
> 
> Fixes: 2cdfcf272d ("memory: assign MemoryRegionOps to all regions")
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> Since v1:
> - reword as not a bugfix (Paolo)
> - access the aliases recursively (Paolo)
> ---
>  softmmu/memory.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

