Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF0C6C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 19:31:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F18522208
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 19:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="suuc3koz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F18522208
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGolU-0008LK-K7
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 15:31:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44012)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kGokg-0007eC-BS
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 15:30:30 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:44759)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kGokb-00008r-A3
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 15:30:28 -0400
Received: by mail-pg1-x541.google.com with SMTP id 7so7321788pgm.11
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2020 12:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=a5ylYiCfLG/5mC9/VdcQobGenVWYlduGmkYkyGmqqsI=;
 b=suuc3kozKUt22M0uMeNQ/aN11b6Lbg0zOe0651OHhr8jG9Ua9HQrj1vgWRYDtnVOez
 z1tbMR8FXxMD13ECK15K2pL4N6jc6X1OYzPgj8zujsxnxLOfCYhisIW83sppsQcE/CNT
 F849C7qHrrfl+bh5z9nEnUyQ1El+9oVCAeN8yTG59rmWxW5WjJ6QFa2nWjmlii7dXLBU
 dmdNUwqBULjMyO66toXbc+VZDJKTi3XVCd+n8HGA8ouZDupZJt/xymVDhfNEFgWoG9rX
 atLXxSWWBjEmTmRocg9OrPmWGRAP3C/0eXpZOY2J+/0nGW+cj/y7faC+9/5JMGR/Pxop
 v9Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=a5ylYiCfLG/5mC9/VdcQobGenVWYlduGmkYkyGmqqsI=;
 b=pA1ki1ihW/ihEY2HCWz8b++1hPWq3E+Ar4t+Fcw1aS5ha8tH8HBebJINer3I/9yOhi
 MN5BtwQLtltO3dYvMAN95cANZc2HjgMAa37kDShIEF38HNJXuidlbPNEb9k6b7Bl88r1
 +pLY6rFdgQG+oa+/c+RZFY2U9t4f808hcwrFXddN0VW4UuljObDY6N7iutL80WJW2xlj
 xqrvYJl2+sfSroZgJSpI5NTr6KypCieVVxul/OTu6CssejSetzPtTA9y9BIekwbRWlbH
 o7Ni875sYh+Lg2hLus1dz/naT/l4UQjVUghONORV88x1pbv6Agf3rDrHu/uI08KffCYs
 oYqg==
X-Gm-Message-State: AOAM5328zqf8idOxTrPpOnDzG6Seleo8KTU3Oi8qUYth7TrEnn9ylihQ
 at2D82rZs74B5klUi0w0A288XiM4SKj+hA==
X-Google-Smtp-Source: ABdhPJzFiiWDUbejxMmleAHGIWoNUcuj778zHe8agRMmpN3mksKNKZmnL1bMFf72O+IDhBnWFTC/9g==
X-Received: by 2002:aa7:9592:0:b029:13e:d13d:a054 with SMTP id
 z18-20020aa795920000b029013ed13da054mr3475242pfj.26.1599852622803; 
 Fri, 11 Sep 2020 12:30:22 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id 137sm3004112pfb.183.2020.09.11.12.30.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Sep 2020 12:30:22 -0700 (PDT)
Subject: Re: [PATCH 3/5] hw/intc/armv7m_nvic: Only show ID register values for
 Main Extension CPUs
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200910173855.4068-1-peter.maydell@linaro.org>
 <20200910173855.4068-4-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1e58a799-6380-ee78-9a4b-291f3e100596@linaro.org>
Date: Fri, 11 Sep 2020 12:30:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200910173855.4068-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.469,
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

On 9/10/20 10:38 AM, Peter Maydell wrote:
> M-profile CPUs only implement the ID registers as guest-visible if
> the CPU implements the Main Extension (all our current CPUs except
> the Cortex-M0 do).
> 
> Currently we handle this by having the Cortex-M0 leave the ID
> register values in the ARMCPU struct as zero, but this conflicts with
> our design decision to make QEMU behaviour be keyed off ID register
> fields wherever possible.
> 
> Explicitly code the ID registers in the NVIC to return 0 if the Main
> Extension is not implemented, so we can make the M0 model set the
> ARMCPU struct fields to obtain the correct behaviour without those
> values becoming guest-visible.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/intc/armv7m_nvic.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


