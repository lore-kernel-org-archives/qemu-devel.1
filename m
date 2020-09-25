Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D89C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 14:32:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED321208A9
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 14:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c4qMQTnD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED321208A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLolT-00008Q-MX
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 10:31:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45904)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kLok6-0007cK-PZ
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 10:30:34 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532]:46986)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kLok0-0006Fj-Vi
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 10:30:34 -0400
Received: by mail-pg1-x532.google.com with SMTP id 34so2715521pgo.13
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 07:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=JsPThROO8tPj8vyKkL0m5kULOWCxjGoxcqBvDfRP8rI=;
 b=c4qMQTnDoIewPCba1G4be0V4OFP0u2QGUU4NsiuAFs79IfImPTwd1oIDcmJDCBhHcY
 h+VaWh+Il9Ky2qeoZU8dijHN7rPZdt9LQJL0fzQOpwEIjyVGn5OxGzCx6yAeFrD16XSM
 S0uwJ2+RWuBXMPbLutGTmchVxuXJmQQHi9gfI7FwNJ2TnU0groMraMRtpGlZCndeVWRt
 m11p/PX5dvfCwx4GPY0Y/IbW2UPGCXcdOgdlgafx3aJsH5BXaKzPvy04OQfAF8GjN/eq
 5zQlFB8mBBQN++QLxPbqsLiSWxYlbOnGmFCqh55p/HciyovLXhUf0UvPGHeQ1/MH374U
 AmiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JsPThROO8tPj8vyKkL0m5kULOWCxjGoxcqBvDfRP8rI=;
 b=tnt8NtPrE2f0NtrSnYQr2W2o05YrwduLsPro7JlJvEj5RmETmjgRgyer8Amx/nhGxD
 usbF3EFaEbsFeF2Lx1Hei3R6aZm9WEYOAS0CG6aMRgzbkRSuDd1fehHHbJSgVIEjS9Uj
 PMtI6bmxJ9+DeSOYqhrfHhh9L7H+v1qKOCZZgxhtwZkvSKdGBeyBaX7HzER1Dae4fk14
 XXGMwfM1ZPTcGnm9FqTSTNVELd6cpowUKTUdjM0OZ2GN38kJ0pVHpKcUq3HqFcDUeHyT
 SBw7PVFbBjPXvwSRHbfQZyr5Y/qyFnr4TiQ/55SloFJmakKD5LCKS3v/Vu+7GC1Ir8Tq
 uoug==
X-Gm-Message-State: AOAM531b6OnD7mLRtVwysHm1+zxFzXeCPjKv2t/hqluGjjsnnhM2X5Dk
 yk8XmDZQkQyY9oG2xKlhUjg7XOS33n0rYA==
X-Google-Smtp-Source: ABdhPJyHoRQp+WXbmGx4qUpoOSxgYdf7cSA18juBp6bYxO7LExD91yjGp/VebmGdhhyg34DnmitX/w==
X-Received: by 2002:a17:902:8e8b:b029:d2:4276:1df0 with SMTP id
 bg11-20020a1709028e8bb02900d242761df0mr4612770plb.62.1601044219628; 
 Fri, 25 Sep 2020 07:30:19 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id a27sm3117144pfk.52.2020.09.25.07.30.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2020 07:30:18 -0700 (PDT)
Subject: Re: [PULL 00/11] capstone + disassembler patch queue
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200922174741.475876-1-richard.henderson@linaro.org>
 <CAFEAcA9u_hj3uAn8qSYPovkH3vcwxxYxcm0cbqUJkDhpP=8VFw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <94212458-fb4f-6d99-12e6-433670930627@linaro.org>
Date: Fri, 25 Sep 2020 07:30:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9u_hj3uAn8qSYPovkH3vcwxxYxcm0cbqUJkDhpP=8VFw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.238,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/25/20 3:03 AM, Peter Maydell wrote:
> make: Entering directory '/home/ubuntu/qemu/build/all'
> config-host.mak is out-of-date, running configure
> make: *** No rule to make target 'capstone/all', needed by 'Makefile'.  Stop.
> make: *** Waiting for unfinished jobs....

Incremental build fails the first time, yes.
Running make a second time succeeds.


r~

