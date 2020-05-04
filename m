Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C47C47257
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 17:17:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2AA62068E
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 17:17:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="esu2XEHm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2AA62068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVeiZ-0000EI-Tt
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 13:17:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53982)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jVehA-0006zp-0i
 for qemu-devel@nongnu.org; Mon, 04 May 2020 13:15:56 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:38993)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jVeh9-0002XL-4t
 for qemu-devel@nongnu.org; Mon, 04 May 2020 13:15:55 -0400
Received: by mail-pj1-x1041.google.com with SMTP id e6so136917pjt.4
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 10:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=sBLCI6nEW0dUNcKWczodpz/DiWKJZFV/uwknmjUsMqY=;
 b=esu2XEHmC9aZtS6iqfRY77bVexSUArPurl4OGpJWWCyljRcdodDr+ya/P4rtbDQC+g
 ewgwd2VNCPsEApX/X/g7Fr0COqkJaXKgJTKOKrzADOSDGCIg5/YncOUxgSUGtbRzLtvI
 YyRRvjDjhlLcnGiQImtm6hiq+EJwDpoASk/cyFbY0d1L+yxJDLMrAb1AgQiqjOiSVA80
 Z+mPlsXs0rpXtpDVb6DAQXj++SY164IFT4SU4kXU+yA8E0ooCHpol/i8CCjvh7ExA1S0
 WXym/6hEMIsIJsN8docs+VNsal/J6Dxu2iUKgmxGjBfmWEvrOZJWqqqlDOvY+rDnfWpD
 W/uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sBLCI6nEW0dUNcKWczodpz/DiWKJZFV/uwknmjUsMqY=;
 b=PnwqqbT+0q9eihvDwPrcxvbOK4mBsOsvBqLYMDIQLOXBHmV8XgYOj7TLvZDE5Ld6bq
 VM3It8LE88w0Xcp/cmR2zwdMloHNU7ldS7gD+x/bl98yJ9UbyunRk+r5issettrSQ5IR
 epNIFFKIFu4olMrmcRD2SwdXMG/WYoeYYtNINzlAQsAPPjwDEdw/ad5QbfefjX4JpKUk
 8c/bzWwfucZEcvbx8rhQkuytfQkqEVnTZj170pZKaOfs+V6hDpik0te6xFGDFpjanCqE
 dZiQsmPdMWu98U9P5eEP6n48mSC8Fh2aehi2O9sA+d7V3aJfPwmot95ysW5A7WMD5RW3
 Iyyw==
X-Gm-Message-State: AGi0PubVotAIwX8H/l7EuoCTe7h0GnUaFDwUseOhhQX7GV1YS2VZqAHk
 Hy6kUqzDvqZkMyGdznzyO3P25A==
X-Google-Smtp-Source: APiQypKZ2Wl9FLukF/eIoLG0Y6D/gUWVpR74aBWdlZtjHh0ZGQQHtLrvbAdoThWzvaBvPfvnmX62Gg==
X-Received: by 2002:a17:90a:930c:: with SMTP id p12mr16306pjo.64.1588612553565; 
 Mon, 04 May 2020 10:15:53 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id i15sm9233452pfo.195.2020.05.04.10.15.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2020 10:15:52 -0700 (PDT)
Subject: Re: [PATCH 3/4] hw/timer/nrf51_timer: Display timer ID in trace events
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200504072822.18799-1-f4bug@amsat.org>
 <20200504072822.18799-4-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <26cda513-a17d-3c1d-e8c0-99c1f3b0583f@linaro.org>
Date: Mon, 4 May 2020 10:15:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200504072822.18799-4-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Steffen_G=c3=b6rtz?= <contrib@steffen-goertz.de>,
 qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/4/20 12:28 AM, Philippe Mathieu-Daudé wrote:
> The NRF51 series SoC have 3 timer peripherals, each having
> 4 counters. To help differentiate which peripheral is accessed,
> display the timer ID in the trace events.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  include/hw/timer/nrf51_timer.h |  1 +
>  hw/arm/nrf51_soc.c             |  5 +++++
>  hw/timer/nrf51_timer.c         | 11 +++++++++--
>  hw/timer/trace-events          |  4 ++--
>  4 files changed, 17 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


