Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218BCC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 23:02:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEEDE22403
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 23:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nczX0ANt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEEDE22403
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmQ1g-000694-Tm
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 19:02:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51618)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jmQ0o-0005fW-2M
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 19:01:30 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:33562)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jmQ0k-0004Qr-7T
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 19:01:29 -0400
Received: by mail-pl1-x642.google.com with SMTP id 35so4554762ple.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2020 16:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=Bme/YFEDT6caHVolJgARGL0Hvevln4lHyg+bBmt4CGQ=;
 b=nczX0ANtbEZ2BLkCwa09Pl4uG9c7pPuk6lifICyBg5TK1TsjJ00rIHOLJ9uXyUd1q1
 Nr9E0AnrHw/BuAbY4q2MktcPeo/gA1BuknS80jmDHiE0CtN/6TZVA+2EbGoW/aPssw9z
 9pjHGfE0WqLNuJav7tgG+J79KoPC0IvWBHeEhDLoWHog08MCPAdYfKIPRjOOn1rWTsFQ
 j+B/ZGxyqeARx41UHzcPVFvt5FaUyAHzIrRLkpawawRy+0jYeqpWhmg0Dm4Fk0hFCSFE
 KWSxbUtOZrwCFaEQh7+7rzfRvKeQOPXY5V79RM+LzV1nWKX5vS0yz2gDpuMgdXiuoyS7
 PpWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Bme/YFEDT6caHVolJgARGL0Hvevln4lHyg+bBmt4CGQ=;
 b=hCzULBVKsPs/5vaQUNeXbO/o2I+nKGPWTgydDNvEfkjEScKHegdRQpnb6gA1LloWKO
 cF60hm3DOQqAArpbRuWqLRyog4O0MhJb5MPlxrTPMVjToyhMiuMzaL4/q3bSmU0UMlp9
 lbq49RhiHT9Sh+9GfhgCkcOhqMKkY6pn/lfAiUXImI66UIaDznvKU0dcokjmP3j+dOsJ
 R6FEwFWVom3RWv/yyESFSR5y46nETYGFGhwiL+AZjgtiOd7ahV1RNoLigXOBKOVhig4R
 2slCvyyTIaYhWR4A4WbwP7i8mMDVC+1v9FDVEHDD0xLcpH9SGeCrYrihBphffmXp+KQK
 dKAw==
X-Gm-Message-State: AOAM5315t7VsjdeYQvZUISPmcEF1X5CZzwtysIW/pmhVB7uQ0JU3EdqE
 N31j6adx77KJO+oTCbyoSPHdYnekA1U=
X-Google-Smtp-Source: ABdhPJwaGRMeX0JwrmRgGPqzRLTgdD4mbiNjkrgez9lF18zPF0XkVxBPImpiosl7rk+yEFfIsp1XYg==
X-Received: by 2002:a17:90a:e387:: with SMTP id
 b7mr5966918pjz.176.1592607684241; 
 Fri, 19 Jun 2020 16:01:24 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id b5sm6911790pfg.191.2020.06.19.16.01.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jun 2020 16:01:23 -0700 (PDT)
Subject: Re: [PATCH 06/21] target/arm: Convert Neon VCVT f16/f32 insns to
 decodetree
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200616170844.13318-1-peter.maydell@linaro.org>
 <20200616170844.13318-7-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <fe38891f-7209-bcde-b6b3-d66f606e52f8@linaro.org>
Date: Fri, 19 Jun 2020 16:01:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200616170844.13318-7-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x642.google.com
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

On 6/16/20 10:08 AM, Peter Maydell wrote:
> Convert the Neon insns in the 2-reg-misc group which are
> VCVT between f32 and f16 to decodetree.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/neon-dp.decode       |  3 ++
>  target/arm/translate-neon.inc.c | 96 +++++++++++++++++++++++++++++++++
>  target/arm/translate.c          | 65 ++--------------------
>  3 files changed, 102 insertions(+), 62 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


