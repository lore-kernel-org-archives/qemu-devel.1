Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF368C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 23:41:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8772720720
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 23:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lb7+FHUo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8772720720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtJhH-0002PY-SF
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 19:41:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38086)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jtJgZ-0001pM-Db
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 19:41:07 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:42611)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jtJgW-0002q5-33
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 19:41:07 -0400
Received: by mail-pf1-x442.google.com with SMTP id 1so165081pfn.9
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 16:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=1UkOWbeQctjkd0+Ogbpvj1L/TqjRumxU2EBvZJQeXG8=;
 b=lb7+FHUobW5Qq1NHHtLjA7ApGrLtrv1NcfGvuz5vU5bYN8X0vVpr3c/e4fhBXSOIpt
 2LxZPTqSIp0UXbRM3EisPeeiZriowVWNMaai+PDH1F044Z7eFKTco6hEmPUspARhgdT3
 LpHQvfPRLD6HDW+oQLDkYrqAOQNyMLxCly5Tm/MrOb2lop6W6g3In1HqTGjXNk8DAJvH
 9zj3OOD1FqUVkBOrmgcK1kBinbADFkuRYbn/ISEDi6iJ7lfHcUy0XK6WMtzFKmWG3qml
 vX+39Vi7bpxQ9fGb261Tbt5W4NZ9nRYS5UO82lqTQ0vxYE6ukRVsTM/6Z9Ci2acOGaQ9
 NyqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1UkOWbeQctjkd0+Ogbpvj1L/TqjRumxU2EBvZJQeXG8=;
 b=AcsIVMWHcx99fVncLhyQBYdXC+dmYwnx4OwsHbp2uzkHdBr1X0iHAZ/S9NaNn6Gcyj
 n2T6/d8/bcxcVCFm53PwaHzd0KaAOHSY8lRnraIyl9nciGKdcjfypOEooErXQkxHJI2h
 3ZmGbwln2p4iISKZdilk26DsjqCk/QO7NCjA+f+HUnN6+AqhYzaFoui1LVcaHwMErc2e
 gIzwkmykbbb50WIxu8yu/OgXWhGrM55vpF9EGaeHIqhMox3R/3eWMJ8TL/3XnwxzMn7I
 LgXDWiFF9RCTyimez414YFbVgpe8N5DNrLgb9X9oZhCJfNQkMeJxWkSS84qd73LVy0pL
 PeDA==
X-Gm-Message-State: AOAM532GADTtCUk8Jad/uuuQoBm6fBxL2+5NlAYO3q+/+QhSprcEjufD
 slJzn2zn41B3r1RtOHqV8VrwHw==
X-Google-Smtp-Source: ABdhPJyT6WV2j8t4QJIFL7zC60t7dV21LOuVF3hy4Rh+au7xYoasDhNuHeFGWcREqVZPI7t4+p3M4g==
X-Received: by 2002:a63:7c4d:: with SMTP id l13mr51986513pgn.12.1594251662283; 
 Wed, 08 Jul 2020 16:41:02 -0700 (PDT)
Received: from [192.168.7.121] (24-113-145-216.wavecable.com. [24.113.145.216])
 by smtp.gmail.com with ESMTPSA id k189sm762822pfd.175.2020.07.08.16.41.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2020 16:41:01 -0700 (PDT)
Subject: Re: [PATCH 7/7] hw/watchdog/wdt_aspeed: Reduce timer precision to
 micro-second
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200616075121.12837-1-f4bug@amsat.org>
 <20200616075121.12837-8-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9a5a9f82-8646-6a11-6633-ca714b76a482@linaro.org>
Date: Wed, 8 Jul 2020 16:40:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200616075121.12837-8-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x442.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, Corey Minyard <minyard@acm.org>,
 David Hildenbrand <david@redhat.com>, Andrew Jeffery <andrew@aj.id.au>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Max Reitz <mreitz@redhat.com>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/16/20 12:51 AM, Philippe Mathieu-Daudé wrote:
> -        reload = muldiv64(s->regs[WDT_RELOAD_VALUE], NANOSECONDS_PER_SECOND,
> +        reload = muldiv64(s->regs[WDT_RELOAD_VALUE],
> +                          NANOSECONDS_PER_SECOND / SCALE_US,
>                            s->pclk_freq);

Similarly, I would prefer MICROSECONDS_PER_SECOND.  Though again, I don't see
what we gain from changing units.


r~

