Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7673BC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 19:02:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39CF521475
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 19:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UX6t/pDX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39CF521475
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlGqf-0002pE-E6
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 15:02:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42572)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlGoe-0001am-6o
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 15:00:12 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:54861)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlGoc-0001ht-FB
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 15:00:11 -0400
Received: by mail-pj1-x1044.google.com with SMTP id u8so1838144pje.4
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 12:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=lODIeabYy1sWGEgwJXGcvNIdPesDYL5vG0+jAHyV8WE=;
 b=UX6t/pDXWPzeEjyYzLwdeOE1UqAhIAaN2ZAZyepCcGRYiJdnFLk7Y6OUBQWfMiR5KD
 ne7k7+SpZmq3tIVyRyHUUznFdUItUrVl5XO6hqpVDCTFYMbeEqK+C72aMHShgAYjocD4
 YOm8dso3sLH4rTdR7v7FzfLRk9TZxuqgSlKqsuTwLrOBg0hMtp8Ug90XukhM4uLy/7ac
 GF9R0CY7zo0NqhTaO6D6mKzbh8qaAZOlNIpJReiDREFYiYunXXVA/WdDijZOOzT2pP2Y
 mATXHrjNQiSOumFTu39dMdYOS9i6plYBKsjQZTWLri1Dm9p/cyzImgUzp83ryn5rUif2
 ZgKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lODIeabYy1sWGEgwJXGcvNIdPesDYL5vG0+jAHyV8WE=;
 b=IlsTW/jUrtqZ5GT0DICVyBIblNQskjtVerxv9zZ70odqfE3sstPTDaTfZC35AHrB/3
 OQf7nujv/CkOa0zdApCtFI9PrO/tzaGl5yL7dnBxW0wyAuouAFQeVaaSLX8t8khRmmci
 6oRUEGyATrARPEzyky/bhGZyn5Wmci0ldtf8IclCBXkI49RiOMz9qlKQq81sSfNawxGd
 uE5gA7lPlE2bAuwjYZsvrap+M6dzjDOL4UjB1nQ4aBOlW04+hDNkJ8nB0AFZryLgwEvP
 9B3lu1lN415WpQZQPjSV+u6ne7QRxm230+/MmGwDOv5JRVbp3uCxjmO0WBB9eAIhONDM
 TjvQ==
X-Gm-Message-State: AOAM530TMsvNZsthi7hCnApOR54jOoivW4fyFcP3ucqlLzFdNaQmyuHw
 gz0IqPTcF7YiclU9wHf0gjzZlg==
X-Google-Smtp-Source: ABdhPJzOHX5i184b3TvzIIzm/HUjo5oY+Oec7ahqq93V7Tahvj7WqoBA0L6Rn5J3muRCM4lyGKcz9Q==
X-Received: by 2002:a17:902:8bc7:: with SMTP id
 r7mr3357321plo.57.1592334009034; 
 Tue, 16 Jun 2020 12:00:09 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id jz23sm3333058pjb.2.2020.06.16.12.00.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jun 2020 12:00:08 -0700 (PDT)
Subject: Re: [PATCH RFC 0/3] target/arm: Implement SVE2 fp conversion
To: Stephen Long <steplong@quicinc.com>, qemu-devel@nongnu.org
References: <20200428174332.17162-1-steplong@quicinc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <db57c0a3-634f-caef-cab6-8b692a22e661@linaro.org>
Date: Tue, 16 Jun 2020 12:00:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200428174332.17162-1-steplong@quicinc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1044.google.com
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
Cc: qemu-arm@nongnu.org, apazos@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/28/20 10:43 AM, Stephen Long wrote:
> The only insn left in this category is BFCVTNT. I couldn't find any
> helper functions for bfloats so I'm not sure how to approach this insn.
> 
> Also, for insn FCVTXNT, I'm not sure if it is ok to set the status rounding
> mode to odd like that.
> 
> Stephen Long (3):
>   target/arm: Implement SVE2 FCVTNT
>   target/arm: Implement SVE2 FCVTLT
>   target/arm: Implement SVE2 FCVTXNT

Queued, with the change to the third patch as mentioned.


r~

