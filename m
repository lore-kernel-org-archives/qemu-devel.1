Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0936FC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 19:04:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C434720768
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 19:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Or4lqbqw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C434720768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6ezl-0005Ip-4C
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 15:04:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48474)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6ezB-0004nV-8Q
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 15:03:29 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:37278)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6ez9-0002BH-U8
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 15:03:28 -0400
Received: by mail-pl1-x641.google.com with SMTP id v5so2430826plo.4
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 12:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=CeVWo1oyLHlrkCpHXScojQj5RFMRVg5d2AH7RmCjzYY=;
 b=Or4lqbqwuVOuKCM0tL4c3quysXaXvaIz8OoW+Ivb3qFJ7orFklbDtGWnn3H/b6uUhU
 Ka2XXBuL7JQ/hC8FMYZglbmttF3bzpNByFPKoI++JL5r0wX3NPm9shLRvZXXDRMJGfY1
 aHVkNIxm6wB+eXnDAjLJk9yMdBSTZHwDNsj3s8OC7U1dpRuIAMu30V7M+OFxdtR0W/KD
 2psV0BXtxlAnGogQcnr39GckWpM4T+43H6/pxRWMomxPQvnATKobAiQ6xDU5Xo/5gKd9
 V02tf6wv0a+FCpQrdHnFvEbSYlAgLjP79LITt0Ti/PnCi3Z6GDTluR+NeyPmjLkfsg8m
 0mCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=CeVWo1oyLHlrkCpHXScojQj5RFMRVg5d2AH7RmCjzYY=;
 b=fuMN1rIzx3i/IokZIMX2QJbhaPR4plwbNdIj7MmrMXw/I7fOFOTkBZKr+DSb4PQQAz
 DvNleJp2p0813waLJgC0TUJJRe9l8j3MuFwYThz7eS+6fvHogpLt/vRM0b6Kqvc82+vm
 fr7/lmJLPHgX5P4jHypX2RKHmA8H+h7T5CY93rotPNUOzGV+HBsRb5zbEHMWLtYzTrB8
 pL6SxvnillBFNKRe28gfI3fevbeuP5nH08q5uWB4yZ+jwiad/YQ0cMDHQopHiJdJSsyg
 8Yh05vo+kaO23zk7xxGXrY4t4bZpIfBYl2sPzNpsRPj5TyC38rUe8IP9Zb4puS6kL833
 wAHA==
X-Gm-Message-State: AOAM532/SkKbZNy9+ONhXF+IsMHboEQQrYciv+pDc9xc0doXMmlun2Sr
 4vTGqp56u0KOLHBE/j/RJP6ksr02G+ViWw==
X-Google-Smtp-Source: ABdhPJyx7eRR84roXeHXB/poVN9H7RG2Or6KWaoUfwJ07+WiioQObyJUZeRkkhiWZLwg3UVxTj+Eiw==
X-Received: by 2002:a17:902:7291:: with SMTP id
 d17mr2928083pll.141.1597431805813; 
 Fri, 14 Aug 2020 12:03:25 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id s67sm10752350pfs.117.2020.08.14.12.03.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Aug 2020 12:03:24 -0700 (PDT)
Subject: Re: [PATCH 3/7] target/arm/cpu: spe: Add an option to turn on/off
 vSPE support
To: Andrew Jones <drjones@redhat.com>, Haibo Xu <haibo.xu@linaro.org>
References: <cover.1596768588.git.haibo.xu@linaro.org>
 <c4ab709b684bf6505a9721163564d2223d06c49d.1596768588.git.haibo.xu@linaro.org>
 <20200810105056.v33r35x6rex2ywdj@kamzik.brq.redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2259b091-369e-1090-1bd4-e09cf425ac56@linaro.org>
Date: Fri, 14 Aug 2020 12:03:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200810105056.v33r35x6rex2ywdj@kamzik.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, philmd@redhat.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/10/20 3:50 AM, Andrew Jones wrote:
>> @@ -1959,6 +1961,7 @@ enum arm_features {
>>      ARM_FEATURE_VBAR, /* has cp15 VBAR */
>>      ARM_FEATURE_M_SECURITY, /* M profile Security Extension */
>>      ARM_FEATURE_M_MAIN, /* M profile Main Extension */
>> +    ARM_FEATURE_SPE, /* has SPE support */
> 
> We shouldn't need to add this feature bit. SPE should have an ID register
> bit to use instead.

Yes indeed: ID_AA64DFR0_EL1.PMSVer.


r~

