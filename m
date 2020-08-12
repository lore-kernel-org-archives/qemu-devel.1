Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B5DC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 17:47:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1526B20866
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 17:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NfEOKq5A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1526B20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5uqV-0005Pk-D6
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 13:47:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34980)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k5ups-0004ye-6w
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 13:46:48 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c]:37698)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k5upq-0004W5-Nj
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 13:46:47 -0400
Received: by mail-pl1-x62c.google.com with SMTP id p1so1443050pls.4
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 10:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=5FLqh3yUZtCQCxByavexOtC1iNuH3VbnKJ+7ynuaGLU=;
 b=NfEOKq5A1rF2VKEKi+71qc4IEMevh9otsRzpbN0kme8HlT1XO5axL5XLGgBYMyfINm
 zNlmSNqnBWxWYicfL318Gm7eN4Q0SgMShG5dwWFuyz9mQNlPKDDk6KnLeKyLF3K+e86z
 HscXJp2GUS9EpAiJ0VCf2zeeAtYvEo4kDfZ410caDhwndJgh3JIc8vQME+TqPBfXtCsv
 0l2NGELN4SH7eoGvSbyPrPrxrnK6WThGkSR6B6ImydAsiJQflzFl8BC5yq9/6pflkdot
 CuC3O42bjOHnDZmL+u/Gw8X8Egu+SgYcmHsNk/wvaGaJiCjfPr+wV9X+B1hz7zi458zD
 6o5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5FLqh3yUZtCQCxByavexOtC1iNuH3VbnKJ+7ynuaGLU=;
 b=ElImA6+EDDL0KUqEoRODKXXV1JJxFqbng7LondbM3OA2XT31RIqk0UcWXfFi9kTQQr
 1RhnVFvq3v4IbOJlIGnNJxOdqcAxIK0vFqtwbeE/Qm9nX84ts6VREjCyCaOjQoSvj+St
 EmGckmKDMJczgnLRFvg4fU9rhk3Op0zqGRGGNNYO5kIZ3HidNf+tuiXir5zJ8GRLY3Ch
 pi7nLSow6Kw+j9whQk2rt0xe6BKTcACE4zkzjN0A0CGUCjTadpoB4ltACTRdFdnAXvhF
 mdKcOP2ShnRZgiBkXmK9Ut9E75IpF92/7i74zRwt59Gy5g9GpucXZJnNZSu5R5ZSKAar
 Br1w==
X-Gm-Message-State: AOAM530bnFmtGVQyY4baSY4DcqNNG5qWf/ftRxFtvvYzTHn2Z6WKDyg+
 Vj7dPM7/NMMNRmtA5/k3us5ByQ==
X-Google-Smtp-Source: ABdhPJySXslTn/Kt1A86h8Eg+Q+bjyHQH+1XKqKaUk2b+yY+S6hio/7lK8j1eEryLbs1tSSystknNg==
X-Received: by 2002:a17:90a:fd82:: with SMTP id
 cx2mr1203988pjb.67.1597254405303; 
 Wed, 12 Aug 2020 10:46:45 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id h5sm3167973pfk.0.2020.08.12.10.46.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Aug 2020 10:46:44 -0700 (PDT)
Subject: Re: [PATCH-for-5.2 4/4] hw/char/serial: Use the Clock API to feed the
 UART reference clock
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200806130340.17316-1-f4bug@amsat.org>
 <20200806130340.17316-5-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2c086f30-ee19-0efd-0b45-efa4688a3c67@linaro.org>
Date: Wed, 12 Aug 2020 10:46:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200806130340.17316-5-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/6/20 6:03 AM, Philippe Mathieu-Daudé wrote:
> In the same chipset, UARTs can be clocked at different rate, or the
> input clock can be changed at runtime. The Clock API allow us to
> propagate such clock rate change to the device.
> Let the SerialState have its reference input clock (called 'rclk')
> and if not clock is connected to the device, use the currently provided

s/not/no/

> frequency, to not modify the current code behavior.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  include/hw/char/serial.h |  3 +++
>  hw/char/serial.c         | 35 ++++++++++++++++++++++++++++-------
>  2 files changed, 31 insertions(+), 7 deletions(-)


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

