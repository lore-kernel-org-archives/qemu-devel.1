Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACFE6C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 17:40:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7018B20781
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 17:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zGTOtXBH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7018B20781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5uk8-0007oa-JF
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 13:40:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33330)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k5uj2-00071T-2I
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 13:39:45 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f]:46370)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k5uj0-0003d6-Fe
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 13:39:43 -0400
Received: by mail-pl1-x62f.google.com with SMTP id k13so1413342plk.13
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 10:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=VfkYxypLEv+R/KGEQAol2keRwYVHeqVfUyfcCcZFEEw=;
 b=zGTOtXBH3GqtLOZHKgW2qSgJnKnubvIXLDzIukudO+gT4bvhSoZkk56Hy4Q0DFaDAz
 tYg4MLG+qOFriRSw1X1ARRCC+J4eM5gqQzN9QW4I/Wa98VwkGpKf6DW5iyg3/uWWiO0t
 w7rcRm+6I7MV9moaSszSUs1pAFdCRjiqzDXbeGibD/Ui12jAmnFi8zCsMOX6UJrQCwEo
 jZo49+zMA7BEZSPdHSlL2Y2Tj6juCvvgDt8wiG/RNOR76/1sUghZD8ZqCIB+oZEsQbwb
 Rr3ItP4kZwVnuMgbZ+2VYwNI4y2gFvOOGbJdgNaxry8pzk2JCEzeoG5qiMkPzgRpnZr4
 1YJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VfkYxypLEv+R/KGEQAol2keRwYVHeqVfUyfcCcZFEEw=;
 b=mN/yXS712gwnpfrCaVXlQ0LiLmgFT3khQ5Y/AHR20aGJ6ycba6ezlVb7sdeeO+JN+4
 iHiXf53tLkVZO7sxKqEYiMy997DRY9LSfxcBUA8cFJIqHVMn/IfnvLp/56wmnii94n1J
 X1bwtTcMB2CkUS+wd1KTaX4f88yZt4XFs/RkyuVMWRA9kfOoFtscCvrVSHGFszyWvwNU
 IgKyA3vYGuMa2kxd50bHkUYDfvB6pBJHvmCcLEb8+FULI3Ca3/UfsmebNYO3XE/7tQfe
 xUTkHEgFZv014++UcBTswX5IY7KW8pqYQhQRa8f6XPOU8OYzen6rDDbdxLywZn6wZH2g
 hVYg==
X-Gm-Message-State: AOAM530HahnfUgfuMST6bret/oxO364yxzL1TBvwWcy4ddcyDXvNiXs0
 YMbNK6DijzdjDyuUHSAzKmNFxg==
X-Google-Smtp-Source: ABdhPJz96Az+rO3mbUWFf3KExQOkwbuaLIyZpczuE8ElTPL9dkqYVlNB2H73VdWDJlyS12LiSuoSww==
X-Received: by 2002:a17:90a:2225:: with SMTP id
 c34mr1007605pje.116.1597253979260; 
 Wed, 12 Aug 2020 10:39:39 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id x18sm3190588pfq.124.2020.08.12.10.39.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Aug 2020 10:39:38 -0700 (PDT)
Subject: Re: [PATCH-for-5.2 1/3] hw/clock: Remove unused clock_init*()
 functions
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200806123858.30058-1-f4bug@amsat.org>
 <20200806123858.30058-2-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <690dcfdd-d6ed-459e-6fba-1d4158f2922d@linaro.org>
Date: Wed, 12 Aug 2020 10:39:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200806123858.30058-2-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/6/20 5:38 AM, Philippe Mathieu-Daudé wrote:
> clock_init*() inlined funtions are simple wrappers around
> clock_set*() and are not used. Remove them in favor of clock_set*().
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  include/hw/clock.h | 13 -------------
>  1 file changed, 13 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

