Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C066C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 19:52:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09D6E2087C
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 19:52:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PHEFZHTM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09D6E2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6JHQ-0003KC-A8
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 15:52:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55086)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6JFt-0001R7-VL
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 15:51:17 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:34415)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6JFs-0001O5-AH
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 15:51:17 -0400
Received: by mail-pf1-x443.google.com with SMTP id m71so3362453pfd.1
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2020 12:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=UaLalvKHKqdR6do/OKqw5tdOm+qjSl9wYGD5BALm3k8=;
 b=PHEFZHTMKU9mdoFD8GpJpv4ZHbulhkRwDTHSqUdhnnjQAmayJ+lpm7ec5OqSUSS7Wu
 lkiJ3nRjgF987NndAx3hKkg5k05KinrrNi5/eprG7TX3I7zwvF7GxXVhL+nd2x6aLZBS
 +CzfY9GBrZzDFPT4pgPer9Fi84acTK3eXbuEwvUAEDqLjwwbkOA0I2Ngss2j4/9+DVEY
 YLHcmLAotmFd0joi0jOB5sk96vdJOdqkIo30c6d2GcINvmweDjmLRQupTwbOA4JJZnHs
 pU+XbyBrOY8qVLwDtNz9EOeWNDOV+9B4as/R5EahP6DKs55XtiUpO/DmvsLwdRyAgFm0
 R74A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UaLalvKHKqdR6do/OKqw5tdOm+qjSl9wYGD5BALm3k8=;
 b=Y3Un4/cq3mjjVfLCq1awVqEJ8LntkwS21yRn6VQI/1hvrojtgERBK672nYLQVkfnVa
 dryDEfLsVxvqsXZl/KZRSeWxng4n6vX/GGaJ4RRfVXGJRl7QcikUyDCynksVJbt+nRbK
 sFWmrFHdCB3jZNn2yq83L6kem32ZjJDPgFv0X/ex5LSgugNCkq+8KdIDJKuFvDbibSo0
 JLCkqHdy7+ucB6siO3SgPtpW55FCEewDz3SFixlEE2VHpb48yxRXYP1jiaYrfAHCY/Je
 36sWRZTQ1NeTRez3plXWXHCICfvtgEjTtcGyr1kSu5zMgtUjwia8sharMNPXbgYgzXKo
 9hbw==
X-Gm-Message-State: AOAM533WDFjLiRcFIjQMje0yWwPdmz8yjpc20TzIIY271O4B8RZP+bgl
 KjOgmrFZKoMFNsNzkc3H+vWl0Q==
X-Google-Smtp-Source: ABdhPJw8gkLKDJ2QPgZs7jMjDZZjcZBZOXbkjx8BTPljSswrzKmlKqp/QvPNcCyNHo89Y9M74wH8SA==
X-Received: by 2002:a65:4c4e:: with SMTP id l14mr4636716pgr.200.1597348274918; 
 Thu, 13 Aug 2020 12:51:14 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id y72sm7050606pfg.58.2020.08.13.12.51.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Aug 2020 12:51:14 -0700 (PDT)
Subject: Re: [RFC PATCH v2 2/3] target/mips/op_helper: Document
 Invalidate/Writeback opcodes as no-op
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200813181527.22551-1-f4bug@amsat.org>
 <20200813181527.22551-3-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ce893268-d934-4148-7312-ed4c49c361f2@linaro.org>
Date: Thu, 13 Aug 2020 12:51:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200813181527.22551-3-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/13/20 11:15 AM, Philippe Mathieu-Daudé wrote:
>      switch (cache_operation) {
> -    case 0b010:
> -        /* Index Store Tag */
> +    case 0b010: /* Index Store Tag */
>          memory_region_dispatch_write(env->itc_tag, index, env->CP0_TagLo,
>                                       MO_64, MEMTXATTRS_UNSPECIFIED);
>          break;
> -    case 0b001:
> -        /* Index Load Tag */
> +    case 0b001: /* Index Load Tag */
>          memory_region_dispatch_read(env->itc_tag, index, &env->CP0_TagLo,
>                                      MO_64, MEMTXATTRS_UNSPECIFIED);
>          break;

Merge these lines back to patch 1.  With that, both 1/ and 2/,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


