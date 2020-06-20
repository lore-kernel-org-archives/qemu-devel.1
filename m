Return-Path: <SRS0=xv8e=AB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C785C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 11:50:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA79520720
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 11:50:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BmS6nzHK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA79520720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmc0t-0006Xu-1t
	for qemu-devel@archiver.kernel.org; Sat, 20 Jun 2020 07:50:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56392)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jmc0F-0005eS-Ii; Sat, 20 Jun 2020 07:49:43 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35725)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jmc0D-0004mE-SQ; Sat, 20 Jun 2020 07:49:43 -0400
Received: by mail-wr1-x444.google.com with SMTP id g18so3024578wrm.2;
 Sat, 20 Jun 2020 04:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Ux4mfRTVWMcxBrf6xo9T8Z0qwZxSRgdeAbPuTScn+R0=;
 b=BmS6nzHK3ePBVvRzFsUNyViXVHmjo/QPozAY/3qGbTVq/34n1NSfbpBGdB0WKfG/FU
 l9fo7ciDEPuQXrdlaO0bZi/5CTZ1XGszKv9mPSNlZ/c7yD8BDkiSfTH/cRUS0h9EQlru
 YssxjTX8X94ztj7itA/xPnUSoaicy2ksCnM7sAGy3ghNvBuH7qaVqnykGtXSJmVLKXEi
 8YDEhQlGq0Z0BM1xVS3b8AM+bwygOYrh/TnfQvb8uaIklAXMrtspw7kR5E0Q5M8p6hYQ
 15Pryqbt4WAMCVBrHMq6LAE/sWWI3Pq8nfQpQP1YObxzvgB59mSF5khUiPC0oO9c8T5u
 3gEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ux4mfRTVWMcxBrf6xo9T8Z0qwZxSRgdeAbPuTScn+R0=;
 b=t3j7MHUv+DB5Iy5pqEaaEvc1jgSyUFbgG20IoX4c3boDvsFnmrnYczH1TZQyfV18/D
 8QaWdeb7buUkwXPElM+PkZsBve3sTMOW4y++0YRUTU9umQNPUGXyae1CK2KlAKKlzTgu
 Ord1FfC5TlddL+tIFRcuonWVWrmAu9vif3Qywie8DZpGxDokpjrotUBa3nbV8ZN2DtSh
 GU/qqSUqLjOuYMfWJ3Uo3Mtu60CuRR0XNmhsJTmW2+hwtuElM8B4P/3SB+IL8Z0TMrWZ
 7+wREo5sbdzUzOwEDL1xI6qH0XbjiO8/eSBGgzXDXQynu6DUFWIwEXSPzUdcBDMRhPw5
 nyQQ==
X-Gm-Message-State: AOAM531oJLBiwEQr+RD0yQYWIg2e/0v4HkaW2xglZ+lkrrkFWclOkc19
 oUlKldiaqgTbciTFb6X1HPo=
X-Google-Smtp-Source: ABdhPJyidvYt1JxwMafn9qsi0L0M6NlGToWjSdAutBu51xjJARucXcQwXQg4484ofCq8XeHJcdV6bw==
X-Received: by 2002:a5d:4987:: with SMTP id r7mr8722261wrq.316.1592653780003; 
 Sat, 20 Jun 2020 04:49:40 -0700 (PDT)
Received: from [192.168.1.37] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id 14sm1951354wmk.19.2020.06.20.04.49.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 20 Jun 2020 04:49:39 -0700 (PDT)
Subject: Re: [PATCH v3 0/4] hw/misc/pca9552: Trace LED On/Off events
To: qemu-devel@nongnu.org
References: <20200619145101.1637-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <00d75321-7245-ef59-c856-148dbbd101e3@amsat.org>
Date: Sat, 20 Jun 2020 13:49:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200619145101.1637-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 Joaquin de Andres <me@xcancerberox.com.ar>,
 Esteban Bosse <estebanbosse@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/19/20 4:50 PM, Philippe Mathieu-Daudé wrote:
> This series add trace events to better display LEDs changes.
> This helps me to work on a generic LED device, see:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg711917.html

FYI I'm going to send a v4, using the generic LED device.

> 
> Example when booting an obmc-phosphor-image, we can see the LED #14
> (front-power LED) starting to blink.
> 
> - ASCII LED bar view:
> 
>   $ qemu-system-arm -M witherspoon-bmc -trace pca9552_leds_status
>   19286@1592574170.202791:pca9552_leds_status 0x55dde47807c0 LEDs 0-15 [*...............]
>   19286@1592574170.203609:pca9552_leds_status 0x55dde47807c0 LEDs 0-15 [**..............]
>   19286@1592574170.204102:pca9552_leds_status 0x55dde47807c0 LEDs 0-15 [***.............]
>   19286@1592574170.204415:pca9552_leds_status 0x55dde47807c0 LEDs 0-15 [****............]
>   19286@1592574170.204758:pca9552_leds_status 0x55dde47807c0 LEDs 0-15 [****.........*..]
>   19286@1592574170.205070:pca9552_leds_status 0x55dde47807c0 LEDs 0-15 [****.........**.]
>   19286@1592574170.205380:pca9552_leds_status 0x55dde47807c0 LEDs 0-15 [****.........***]
>   19286@1592574235.384845:pca9552_leds_status 0x55dde47807c0 LEDs 0-15 [****.........*.*]
>   19286@1592574235.894049:pca9552_leds_status 0x55dde47807c0 LEDs 0-15 [****.........***]
>   19286@1592574236.404277:pca9552_leds_status 0x55dde47807c0 LEDs 0-15 [****.........*.*]
>   19286@1592574236.914644:pca9552_leds_status 0x55dde47807c0 LEDs 0-15 [****.........***]
>   19286@1592574237.424558:pca9552_leds_status 0x55dde47807c0 LEDs 0-15 [****.........*.*]
>   19286@1592574237.934580:pca9552_leds_status 0x55dde47807c0 LEDs 0-15 [****.........***]
>   19286@1592574238.444688:pca9552_leds_status 0x55dde47807c0 LEDs 0-15 [****.........*.*]
> 
> - Only display LEDs which status changes:
> 
>   $ qemu-system-arm -M witherspoon-bmc -trace pca9552_led_change
>   23367@1592575218.896117:pca9552_led_change 0x557cb6896d80 LED id:0 status: 0 -> 1
>   23367@1592575218.897072:pca9552_led_change 0x557cb6896d80 LED id:1 status: 0 -> 1
>   23367@1592575218.897487:pca9552_led_change 0x557cb6896d80 LED id:2 status: 0 -> 1
>   23367@1592575218.897855:pca9552_led_change 0x557cb6896d80 LED id:3 status: 0 -> 1
>   23367@1592575218.898256:pca9552_led_change 0x557cb6896d80 LED id:13 status: 0 -> 1
>   23367@1592575218.898663:pca9552_led_change 0x557cb6896d80 LED id:14 status: 0 -> 1
>   23367@1592575218.899138:pca9552_led_change 0x557cb6896d80 LED id:15 status: 0 -> 1
>   23367@1592575281.593379:pca9552_led_change 0x557cb6896d80 LED id:14 status: 1 -> 0
>   23367@1592575282.102994:pca9552_led_change 0x557cb6896d80 LED id:14 status: 0 -> 1
>   23367@1592575282.613558:pca9552_led_change 0x557cb6896d80 LED id:14 status: 1 -> 0
>   23367@1592575283.122774:pca9552_led_change 0x557cb6896d80 LED id:14 status: 0 -> 1
> 
> For information about how to test the obmc-phosphor-image, see:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg712911.html
> 
> Supersedes: <20200617064734.26956-1-f4bug@amsat.org>
> 
> Philippe Mathieu-Daudé (4):
>   hw/misc/pca9552: Replace magic value by PCA9552_LED_COUNT definition
>   hw/misc/pca9552: Add a PCA955X_LED_MAX definition
>   hw/misc/pca9552: Trace LED On/Off events
>   hw/misc/pca9552: Trace LED change events
> 
>  include/hw/misc/pca9552.h |  2 ++
>  hw/misc/pca9552.c         | 60 ++++++++++++++++++++++++++++++++++++++-
>  hw/misc/trace-events      |  4 +++
>  3 files changed, 65 insertions(+), 1 deletion(-)
> 

