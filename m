Return-Path: <SRS0=M+f9=AC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C0FC433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2020 20:52:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD48525245
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2020 20:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cbpb34el"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD48525245
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jn6xK-0005nb-4d
	for qemu-devel@archiver.kernel.org; Sun, 21 Jun 2020 16:52:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37188)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jn6wV-00051V-PU
 for qemu-devel@nongnu.org; Sun, 21 Jun 2020 16:51:55 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633]:34669)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jn6wT-0003xl-Hn
 for qemu-devel@nongnu.org; Sun, 21 Jun 2020 16:51:55 -0400
Received: by mail-pl1-x633.google.com with SMTP id d12so632128ply.1
 for <qemu-devel@nongnu.org>; Sun, 21 Jun 2020 13:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ReEdLYWtUFQwPUqiS4+Glqjc9RbhhprYJb19m5h+BrE=;
 b=Cbpb34elLV73hSWalJNra77G02OD841MPfYgsyoOXCDbjKOAeFFShEWJKsMpqrsIdP
 p5CLAPLUGCw8amDzWAC5SEBzVf7X9UudjPVTJ1Na9s2LpTrmKS+l2SLTYjGoFwO+/79W
 RlJ4BLP3ZJQEOZYpfCzpGRntCycfFOyMCjrGsqlQ0VIZbwoqWmFyBX66liflfQ4txxIw
 fdBQR71rW0y0JNCTD5xebt9zKhPPBVgsk48YbPrRLSSvW02o1E3it0DfSpCi2Ik64PNM
 Tn1bB3mG5YE219sWMuNgWwhU9qBHmvTUBn3m9U50TPbrUIlhsqZ1s2kqu4+v/ooI6Nns
 hCTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ReEdLYWtUFQwPUqiS4+Glqjc9RbhhprYJb19m5h+BrE=;
 b=iJh19MN3Gea4evjOlALd98y2dL2AH7XiAMD6JsEUgWDkRi4FKspnytgPuqCntR/s7m
 mK+DgbRnQALHk218Q8zTXyWIEnYSK2emWVDQN4U/74DupTu6f93rPkef0A78fqnHCFO9
 Dgqt1kRHr6CzINOWWnHlmurQKwO/24FpmsDfDqGRutNBhjj3jrUBSarO5RjtM8NzXqKe
 u3br7ISmMcAiS9yuQG93EzAb9/N5zh4m0S+hdjh8UZkYmNRBik/75Wlt/qJBYdqmDrgS
 5fdKgpqRrnmYziutGhbb9K0s4519/NviusoBinpz2wXxf+80lyPDXMXZzyskt16/BUHd
 iAOQ==
X-Gm-Message-State: AOAM5308upAW9QVG0nUMAwCvo5D+8SSK9njlWSvkBty3ki7PGnvTOhFU
 tZupqjT48bgsZlYMFPdfe01geA==
X-Google-Smtp-Source: ABdhPJxcFk1NI66YjVQIwvkEK+NOGyGv4JcY/FZchZUoVdV7+NiM80f4/FxZCqvfAk6Xx1wSAq4p/A==
X-Received: by 2002:a17:90a:7062:: with SMTP id
 f89mr10100704pjk.203.1592772712153; 
 Sun, 21 Jun 2020 13:51:52 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id o2sm10861512pjp.53.2020.06.21.13.51.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 21 Jun 2020 13:51:51 -0700 (PDT)
Subject: Re: [PATCH v3 4/7] hw/arm/aspeed: Add the 3 front LEDs drived by the
 PCA9552 #1
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200620230719.32139-1-f4bug@amsat.org>
 <20200620230719.32139-5-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <55cca662-73f2-4a9f-9de6-0e8d9f1d4890@linaro.org>
Date: Sun, 21 Jun 2020 13:51:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200620230719.32139-5-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/20/20 4:07 PM, Philippe Mathieu-Daudé wrote:
> The Witherspoon has 3 LEDs connected to a PCA9552. Add them.
> The names and reset values are taken from:
> https://github.com/open-power/witherspoon-xml/blob/master/witherspoon.xml
> 
> Example booting obmc-phosphor-image:
> 
>   $ qemu-system-arm -M witherspoon-bmc -trace led_change_intensity
>   1592693373.997015:led_change_intensity LED desc:'front-fault-4' color:green intensity 0x0000 -> 0xffff
>   1592693373.997632:led_change_intensity LED desc:'front-power-3' color:green intensity 0x0000 -> 0xffff
>   1592693373.998239:led_change_intensity LED desc:'front-id-5' color:green intensity 0x0000 -> 0xffff
>   1592693500.291805:led_change_intensity LED desc:'front-power-3' color:green intensity 0xffff -> 0x0000
>   1592693500.312041:led_change_intensity LED desc:'front-power-3' color:green intensity 0x0000 -> 0xffff
>   1592693500.821254:led_change_intensity LED desc:'front-power-3' color:green intensity 0xffff -> 0x0000
>   1592693501.331517:led_change_intensity LED desc:'front-power-3' color:green intensity 0x0000 -> 0xffff
>   1592693501.841367:led_change_intensity LED desc:'front-power-3' color:green intensity 0xffff -> 0x0000
>   1592693502.350839:led_change_intensity LED desc:'front-power-3' color:green intensity 0x0000 -> 0xffff
>   1592693502.861134:led_change_intensity LED desc:'front-power-3' color:green intensity 0xffff -> 0x0000
>   1592693503.371090:led_change_intensity LED desc:'front-power-3' color:green intensity 0x0000 -> 0xffff
> 
> We notice the front-power LED starts to blink.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/arm/aspeed.c | 17 +++++++++++++++++
>  hw/arm/Kconfig  |  1 +
>  2 files changed, 18 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

