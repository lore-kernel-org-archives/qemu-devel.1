Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 370D2C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 11:10:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3AA120716
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 11:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+5S/TJ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3AA120716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jngp0-0000rF-2L
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 07:10:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56596)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jngo9-0008WP-Th; Tue, 23 Jun 2020 07:09:41 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42358)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jngo8-0001mO-2w; Tue, 23 Jun 2020 07:09:41 -0400
Received: by mail-wr1-x442.google.com with SMTP id o11so12357074wrv.9;
 Tue, 23 Jun 2020 04:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=TDoajOIlS82D3/OcmN3QGNYpw1qwl/7n0rtfalMpxik=;
 b=E+5S/TJ/+4bZ7E1MRayuQ5N0N9qiEsZ4q3VENhvYYBOnmJEocxmN5Vc8DGMUa27WxV
 +s0PNcKBjXOv8NEebHtjwu2S5wM1yMgOEpRN1S2HD3LtE1tp+EhjkxKMTus9Ut4C/+/o
 vrXuLGtl17JOHodpRTqlWKmHEzIMbuTqSkyYqyThAFASWVoYV07K2enHU1ihGJJ+MCHC
 S20Pr1VyQ6bDPQVA5ujHFspuywyWixEA5qv6RBCvIb2Ba1u/vgJg0t0PAUjaLdbw12XI
 pVPm5pH8ykWZfPC3y8dm8NbAFzmKncmy/AgyolBucFbMZi0jU0zmnYSMy/NtvHK+POAf
 bgcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TDoajOIlS82D3/OcmN3QGNYpw1qwl/7n0rtfalMpxik=;
 b=brONRC7fKsgbMxjlPMEYhEg6BN0eDs3Qo/O00k4XMbZrKGrMMYigUOPk1muXiUAiMg
 Ogb37klbGyqijQV//ns8dd+eFPUnr1FjboR3zzOaooxKK3n1L7VccxXKwcVAJwCZe13+
 UvB6lw29Yt6xmeF6DjlZa0Qvb3xaxGqECB2E7JMU/RCpz72+v2TtKJaiXWNdEm4QrHId
 /GYCMqNJMeIGyE7haZvZ3EZaKdrgr46zKCzwVr7mewuAtZ/YTa9VKbgSrBK/vWDu+oZ6
 YAnF4gnPi97phM6C9ti1ayStfmCL8qJYpw5qTBb2WU69pNRTdPUXvnu9LdI8F1dbNTVk
 L3ug==
X-Gm-Message-State: AOAM533afLaPMl4AB7DG/xIXwJLSaAAW7P0JU690JDV5HWtGhsZxW4mT
 F6toIawuWBXEu3NpC6dN1RI=
X-Google-Smtp-Source: ABdhPJxt7JMmYbnXHRu+utMaulpn4NxFnulChWa7qHCvJ4SrLEAv2fup1QZ59FxJIR3WQo4DhAIp+Q==
X-Received: by 2002:adf:e948:: with SMTP id m8mr20886346wrn.398.1592910577593; 
 Tue, 23 Jun 2020 04:09:37 -0700 (PDT)
Received: from [192.168.1.41] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id s18sm24167923wra.85.2020.06.23.04.09.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2020 04:09:37 -0700 (PDT)
Subject: Re: [PATCH v6 0/9] hw/misc/pca9552: Trace GPIO change events
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org
References: <20200623072723.6324-1-f4bug@amsat.org>
 <ff9aec64-419c-330c-bbd3-3b04be70eadd@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a1013609-914c-3843-4aba-a5eaa911e59f@amsat.org>
Date: Tue, 23 Jun 2020 13:09:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <ff9aec64-419c-330c-bbd3-3b04be70eadd@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Andrew Jeffery <andrew@aj.id.au>, Corey Minyard <cminyard@mvista.com>,
 qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/23/20 10:14 AM, Cédric Le Goater wrote:
> On 6/23/20 9:27 AM, Philippe Mathieu-Daudé wrote:
>> This series add trace events to better display GPIO changes.
>> We'll continue in the following series by connecting LEDs to
>> these GPIOs.
>>
>> This helps me to work on a generic LED device, see:
>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg711917.html
> 
> 
> Tested-by: Cédric Le Goater <clg@kaod.org>

Thanks :)

Note to the maintainer, this series is now fully reviewed/tested.

>>
>> Based-on: <20200623072132.2868-1-f4bug@amsat.org>
>>
>> Philippe Mathieu-Daudé (9):
>>   hw/i2c/core: Add i2c_try_create_slave() and i2c_realize_and_unref()
>>   hw/misc/pca9552: Rename 'nr_leds' as 'pin_count'
>>   hw/misc/pca9552: Rename generic code as pca955x
>>   hw/misc/pca9552: Add generic PCA955xClass, parent of TYPE_PCA9552
>>   hw/misc/pca9552: Add a 'description' property for debugging purpose
>>   hw/misc/pca9552: Trace GPIO High/Low events
>>   hw/arm/aspeed: Describe each PCA9552 device
>>   hw/misc/pca9552: Trace GPIO change events
>>   hw/misc/pca9552: Model qdev output GPIOs
>>
>>  include/hw/i2c/i2c.h      |   2 +
>>  include/hw/misc/pca9552.h |  16 +--
>>  hw/arm/aspeed.c           |  13 ++-
>>  hw/i2c/core.c             |  18 +++-
>>  hw/misc/pca9552.c         | 216 ++++++++++++++++++++++++++++----------
>>  hw/misc/trace-events      |   4 +
>>  6 files changed, 202 insertions(+), 67 deletions(-)

