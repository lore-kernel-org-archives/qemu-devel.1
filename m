Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA5AC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 23:18:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F032120838
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 23:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NW79tk1K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F032120838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBndB-00080T-7W
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 19:18:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBncT-00076e-TI
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 19:17:17 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:42263)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBncS-0005p6-Es
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 19:17:17 -0400
Received: by mail-pf1-x442.google.com with SMTP id 17so1387722pfw.9
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 16:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=WKPuF6nu4k/2N4sO+8gvg9BI3JXuK9p6B4RQgnxh8h8=;
 b=NW79tk1KpnlqiWJXb0vUr20f376PEiJWAA2xuBcXIShPy/9VBu+CkMGgur1WHBFuka
 49dqQIAKStoRg4pnlHKOHjgf03lITChPKG8aNrSjDNTuTjMtFnJKO7MYUHhU05M+D0PB
 RwOL6GalmucfTCp2VF+QekLy9Wfw63k5fAzMvHIp3kGo3LUdgNSxTTcKvk1mh/wIsNgj
 fu7oJC55Y0wKar1Mxmq8GnL0BzSH9TqVUpJaXk20VVIa6bN4XeWEzXHW7b7N3pUa7HVk
 F1XWSrKz4NCKMSEO3UNZen7zvp9zZt289CUFc2UQugGZbCn8rVK/PSaNY1g+/WfgQFTJ
 VGFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WKPuF6nu4k/2N4sO+8gvg9BI3JXuK9p6B4RQgnxh8h8=;
 b=cSgunstqRsrq9Q9tjCmA1VdPePQ/xe7kS3BexRDv7wBVNdKAZeYMXIjHG+CL5qo3+E
 r0q+ytGpIGGN817KNuSkwkyGYAYLgTklfhgfnqPuaJkneNTUA61AeN3CIwH6hcYeB5Hf
 cSNWw53n3Tei3PwuO1PY3W4f/byA92/H21gd0R3nPeXMZEAzPtF6ZpbduUoaJU3XETHN
 ALKeQEw1uQdCabvDKSlcBqzKDmqkv9GDmo0ILcqSos6nVjHGWzzcIlf4o7JXRuWt7xnV
 fgHbH7caLOhALjbkd2rFMzLWhIokidrbLF+15kPpUYkMNuKvjS8Kw/4L/nRMr2vdrjTt
 /Vlw==
X-Gm-Message-State: AOAM533eXxS/nUooqkha4Eqyq/6+kiu3ge4NpHsKyzj9RUhX2EWWyQtG
 KtqrEZIBbFAQDwFZFyYdUEKq9x67DAqLOQ==
X-Google-Smtp-Source: ABdhPJxD6WdhO7+AqCQNuRbCegcbf3T5cEnQbz1oUgDwJKF0Lh+d5O2yMbnXRsiRifCx6ViZChEEjQ==
X-Received: by 2002:aa7:92cb:: with SMTP id k11mr1016253pfa.233.1598656634658; 
 Fri, 28 Aug 2020 16:17:14 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id a12sm471811pfr.217.2020.08.28.16.17.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Aug 2020 16:17:13 -0700 (PDT)
Subject: Re: [PATCH v2 42/45] target/arm/vec_helper: Handle oprsz less than 16
 bytes in indexed operations
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200828183354.27913-1-peter.maydell@linaro.org>
 <20200828183354.27913-43-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <637fa692-1cd6-9860-d895-199a531f8385@linaro.org>
Date: Fri, 28 Aug 2020 16:17:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200828183354.27913-43-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.809,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 8/28/20 11:33 AM, Peter Maydell wrote:
> In the gvec helper functions for indexed operations, for AArch32
> Neon the oprsz (total size of the vector) can be less than 16 bytes
> if the operation is on a D reg. Since the inner loop in these
> helpers always goes from 0 to segment, we must clamp it based
> on oprsz to avoid processing a full 16 byte segment when asked to
> handle an 8 byte wide vector.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/vec_helper.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


