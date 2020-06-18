Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E910C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 17:05:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB80820706
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 17:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x/ZisXDB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB80820706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlxyF-0001J2-6j
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 13:04:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59640)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlxxM-0000bu-6S
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 13:04:04 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:36321)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlxxK-0008DQ-Eo
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 13:04:03 -0400
Received: by mail-pl1-x643.google.com with SMTP id j4so2685419plk.3
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 10:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=XMwdTeh6Ca2SHw0HFj2nt4XoTAl1LE263sOkbWy1azE=;
 b=x/ZisXDBJavy12M4vBEODGyAJHgUlspLDt3cNcntguwY96iyS+i9V3uMXc8P0Ej1j9
 79raFaq0FXxJZ7vF9INl5IUhjjTa4PDKQtt9YPWbMGKUiWN9PqOaAXbF5LQ4OrajqbZv
 EoRWMCvZS4X0Dnr1S4N+SxJGtYIi/hT1weQv/cXBl2dzSdEItk4pajKMJWjQusgAeaz4
 z9dUufTVCNszUsQgYwiJjygKc0OKm/3BuRv6exV8fkwbIVBlIXdjV5J7v0+N40htQA3/
 eSirH9s/oWrZTf9iz8EryZOXls9k/mnH9gSpH4ARMvFAuXU5VGipPzYzfPW33kzEYO0c
 Z/Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XMwdTeh6Ca2SHw0HFj2nt4XoTAl1LE263sOkbWy1azE=;
 b=YS5Fk3vl1WpocOgFKfB+GbV3PTPnS0h1asOoMYrnSPRjeZq4jid9ILpVPJH1l9aYuW
 Erm+sW1wAi3HYIdM81m8BsB6jt1/Xv9qsVWPpdOR8hmbvwMLwC2nWrFcFo1ugk1x0dCC
 /jRgRa74d3WpJMP2NW4kZqpRCd0TU1O3a8CNuq6/8HTVCrCLSctGq1YDu5dSjY2j4qiM
 lexlJv/HubWl6sNHgbqVPe9QmCE1hUW2FA6lB8ARIYaUarUaQtOUqS1NJtsNUs2FQe1W
 QZf5qp5SmHwyEv11TYBMnc66pwAFl4zsEdV2SD2pWa/lEXE9/hcIDVJywhacEpr/Aunu
 ObHQ==
X-Gm-Message-State: AOAM531d3MPBA3A10/KQS9hSW5yeiPZOnMO5XmCitI/We7h+KwR+PYPl
 3FVIaJ1fxgbK8suqm//nWJWr3Q==
X-Google-Smtp-Source: ABdhPJxE7VaJcfwn09oy7V2FefoTKN74omJmyggH6dtvXvSFc/T6rVx3b/kpV0olunvPaHu83ae5Ig==
X-Received: by 2002:a17:90a:1546:: with SMTP id
 y6mr5443925pja.92.1592499839719; 
 Thu, 18 Jun 2020 10:03:59 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id n7sm3040802pjq.22.2020.06.18.10.03.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jun 2020 10:03:58 -0700 (PDT)
Subject: Re: [PATCH v7 13/42] target/arm: Define arm_cpu_do_unaligned_access
 for user-only
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200603011317.473934-1-richard.henderson@linaro.org>
 <20200603011317.473934-14-richard.henderson@linaro.org>
 <CAFEAcA86dH_utZzXdbvwhB_67OgVGc249tO6TOBtfw+nWi2-7g@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <bc120bc8-a08a-3b8e-cc31-e7c09e06a3a0@linaro.org>
Date: Thu, 18 Jun 2020 10:03:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA86dH_utZzXdbvwhB_67OgVGc249tO6TOBtfw+nWi2-7g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x643.google.com
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Stephen Long <steplong@quicinc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/18/20 6:31 AM, Peter Maydell wrote:
> On Wed, 3 Jun 2020 at 02:13, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> We need this to raise unaligned exceptions from user mode.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>> v6: Use EXCP_UNALIGNED for user-only and update cpu_loop.c.
> 
> Could you update the comment in cpu.h, maybe something like:
> #define EXCP_UNALIGNED      22   /* v7M UNALIGNED UsageFault; also linux-user */
> 
> and also update the string printed by arm_log_exception():
> #ifdef CONFIG_USER_ONLY
>             [EXCP_UNALIGNED] = "linux-user unaligned access fault",
> #else
>             [EXCP_UNALIGNED] = "v7M UNALIGNED UsageFault",
> #endif
> 
> Otherwise
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

First, this could definitely be delayed to the follow-on linux-user patch set.

Second, in the linux-user patch set, I decode the syndrome data to determine
what kind of segv to deliver for MTE synchronous faults.  It would be easy to
extend that just a little to notice the usual syndrome for unaligned accesses.
 Which may be less confusing than abusing the v7m exception code?


r~

