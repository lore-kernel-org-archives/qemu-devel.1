Return-Path: <SRS0=OYoK=CH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21786C433E6
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 23:51:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D95F620774
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 23:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YZnLobdq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D95F620774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCAct-0004qr-2d
	for qemu-devel@archiver.kernel.org; Sat, 29 Aug 2020 19:51:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35402)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCAbp-00045e-SP
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 19:50:09 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629]:40760)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCAbm-0003Zq-Sz
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 19:50:09 -0400
Received: by mail-pl1-x629.google.com with SMTP id z15so1333447plo.7
 for <qemu-devel@nongnu.org>; Sat, 29 Aug 2020 16:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=pEQ3yQMM+Hpe+4Vkqh2p8O9EAykOnajxJUueinR52p8=;
 b=YZnLobdquO/1b0kcNythHwq5muJJ3Dm6AZLBru3kp96B+HLEoox+7Bg/frFwabflpv
 2g0LXbwn5aN1BgQ6pA2o+dmeOscmSMg6edcDq+d/68zuecvZw1s+MnRD0biGdsISlepv
 ptFQFYRa5yy//QsWkd5xisbovrsbHJlHK72x+uiNvbwidBJJ0z9OadssDO8Hxl0FY+JB
 i9o9WTaccDGm6FOn7b6NISdbVbeBNyWTWke6C5xA2AEhgyI1O6orSq+3QR67LVWzKrHc
 IqkIUIDL9wHLrcpPNzDQJFXYgadTY11dlbDP0X/3qJDVaUVn35cTOoIXrpB5RT2MS0t8
 Kc8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pEQ3yQMM+Hpe+4Vkqh2p8O9EAykOnajxJUueinR52p8=;
 b=AugxK1ureE9Do1x9j0KsIf/Iw1Qv24NlEj8P6imDiUxT/TrJOF3AyUtelYG2sb0V9b
 mmgushCMgRSjj6lZjUKFXu7201+FgM2Zof9Igxm0kPIu3Jxuw2XMpJjnwpw77qGbJVYd
 PUIzjWjVJKFP5Ye6i0G8sJSK5rrb/HbTuOJfT8Ingb4+sVuKd0w1nXuf9KQ2GD2ycpC8
 M1yMtsoJ+7OJwWTqGNtkGfJ62/decBAuWTlBYL/zz6eJdqo62kky1wQXjqUS3/02u3LA
 06JvW6UcPJG6IRC7qAroBf5Zcg/dL+XsUw5tfz8REjT7X5VwEzg/aehDKWBlFO0MaxIv
 Ufyw==
X-Gm-Message-State: AOAM531R0NkBwMA2BgLOz12lMWX5qaYsK6orB5qwPNcSddsyTc2MTr2P
 vvhsVxjwSCK1M9oi21opJr51ug==
X-Google-Smtp-Source: ABdhPJxbkOG8oT9t3H3HQbsIun0WJJNob12Rj/i18DuybgNuhu0MUvbX75otcMa2PQ3H/KdNro15eA==
X-Received: by 2002:a17:902:eb0b:: with SMTP id
 l11mr4041574plb.57.1598745004758; 
 Sat, 29 Aug 2020 16:50:04 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id t25sm3413083pgn.13.2020.08.29.16.50.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 29 Aug 2020 16:50:04 -0700 (PDT)
Subject: Re: [RFC v4 55/70] target/riscv: rvv-1.0: single-width floating-point
 reduction
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20200817084955.28793-1-frank.chang@sifive.com>
 <20200817084955.28793-56-frank.chang@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d94182cc-8846-9eb6-6a93-87968d0d32c1@linaro.org>
Date: Sat, 29 Aug 2020 16:50:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200817084955.28793-56-frank.chang@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/17/20 1:49 AM, frank.chang@sifive.com wrote:
> From: Frank Chang <frank.chang@sifive.com>
> 
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> ---
>  target/riscv/vector_helper.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

The one sentence in the manual is quite poor for this, and needs improvement:

> Floating-point max and min reductions should return the same final> value and raise the same exception flags regardless of operation
> order.

It doesn't actually say anything about the way in which we've implemented the
*_noprop functions.

Anyway,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

