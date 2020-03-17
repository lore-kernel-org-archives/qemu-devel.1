Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CEDDC10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 15:13:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F215A20738
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 15:13:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eymm8XtQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F215A20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEDuV-0006Wr-2m
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 11:13:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57098)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jEDsY-0005Rf-8Q
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:11:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jEDsW-0000em-3W
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:11:37 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:35535)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jEDsV-0000So-8C
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:11:35 -0400
Received: by mail-pg1-x544.google.com with SMTP id 7so11911246pgr.2
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 08:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Tta7EC21Fymxe6MQDAH1hWkr88blEIewHExq5yASP0E=;
 b=eymm8XtQiI5HEMbR6UtNQUbCmYcMFj3GOk2hCkvFrjaKhhnPfJaUfSr4q7WfRJAWcI
 Q/x4HXISuatPO7+G4woHBfjdoCXluP0IRNiw19rM7EzeQWjG5CLs482kN/5MlEIZu8Z/
 g/MwwcYY8C7i3zaoT+3T6fhmQqWKPkLtUR/+j6TjEFzOpeQXs0LhLwgRh5fYkI6lzCgY
 covhyViWpFdI9DGZFUW4PhK/F13EQswuwA0oZZaaqyJau34EUg16xPzbsS5KpMcTO0m7
 mJCJHN2PxsQJOIdnVzg8jmpZJ1M8k69hAQ8H63FeZvGIrcYuFCK0z0FXAfJ8dNawIiPd
 mF8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Tta7EC21Fymxe6MQDAH1hWkr88blEIewHExq5yASP0E=;
 b=L+SAN3ucv2zOOJWW+Yqy8c0PezuPtlLCtzSoAL2iOQnom2cb5ZWbzuxcTwGbop7QQw
 pBzHbmUmpGb464Yzlla1bBOnhSsarxcvvmsO2vj9H5Ljso5jiIrtaOzJY4mdvzsDBj5D
 DMYOGynJwx4ZuJ2b9o1qZckM4tYTcnkU8cfbdd48+bACaiV0O1V755JnH5wMlCyYt23+
 CQ6szZReb0IlXoXcN6WooB+mcm4d/S/vKiknAMiMFs5pwt2m/3HCYuLNWPmlLn6Dk7Rf
 v80BH1hUy1jz2WQRwMzlnFdrkj39IWWolOs7FqfkS3/PrC/5JU43gwm0Wn3LNkzHFB8M
 qhmQ==
X-Gm-Message-State: ANhLgQ3gjRIsbeW4LXfgb68MlhQnpu5dQHploCLsjhkMy8jI8bs6lVBw
 BPjVFcJRBeiS9BKCWSR8mgjpSA==
X-Google-Smtp-Source: ADFU+vumVlcmLzxrLWRFzRsLLMYuQHyeX++NvPFh7Xn+2D3XzkQr7YvkfMxdOvBsGTYzsJreaoz9qg==
X-Received: by 2002:aa7:8156:: with SMTP id d22mr3155152pfn.69.1584457893074; 
 Tue, 17 Mar 2020 08:11:33 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 h19sm3430803pfn.205.2020.03.17.08.11.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Mar 2020 08:11:32 -0700 (PDT)
Subject: Re: [PATCH v5 56/60] target/riscv: floating-point scalar move
 instructions
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200312145900.2054-1-zhiwei_liu@c-sky.com>
 <20200312145900.2054-57-zhiwei_liu@c-sky.com>
 <8b9161d1-f64f-5677-70a7-ec197d9d3d43@linaro.org>
 <f09dfcee-3ac3-80f0-938f-30654d418605@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1d90d6cb-ff65-5c63-d76d-dc375f9dc5bf@linaro.org>
Date: Tue, 17 Mar 2020 08:11:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <f09dfcee-3ac3-80f0-938f-30654d418605@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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

On 3/16/20 11:01 PM, LIU Zhiwei wrote:
> Two questions here. I don't find the answer in the specification.
> 
> 1. Should  I check RVF if the instruction uses float register,  such as all
> float point instructions and some other instructions?

I would think so, but even the 0.8 spec isn't clear.


> 2. Should I check mstatus_fs if the instruction uses float registers, or just
> for instructions that write float point register?

Definitely, just like the regular fp instructions.

This trap is how the kernel implements lazy fp context switching, so if you
allow access to fp when disabled you may be accessing values from a different
process.


r~

