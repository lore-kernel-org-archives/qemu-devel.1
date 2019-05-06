Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF2FC04AAA
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 08:07:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E8462082F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 08:07:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E8462082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52116 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNYey-0001WC-5q
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 04:07:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNYeA-000142-Hk
	for qemu-devel@nongnu.org; Mon, 06 May 2019 04:06:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNYe9-0007eI-IF
	for qemu-devel@nongnu.org; Mon, 06 May 2019 04:06:50 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39320)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hNYe9-0007dt-C4
	for qemu-devel@nongnu.org; Mon, 06 May 2019 04:06:49 -0400
Received: by mail-wm1-f68.google.com with SMTP id n25so13940427wmk.4
	for <qemu-devel@nongnu.org>; Mon, 06 May 2019 01:06:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=kQHvt/xxDanBYyt85LcmxkRedLVpXr1l/7j3kfOCYKQ=;
	b=gVSUFKgjGKAn4za7QTxZclIZryO/kzu3M1b7f037fSCC9A5zmKGWpi9vsThRbVU5Yb
	NAxlL4QawNB7/PjmjHr0EMyRxPufVe3weu6rJpplEBhD4JocNwb5v9fS31BaLYagM+EA
	mfTeabiZeCqOYR9FnzL3/WTN0U5iII8wDPF3lthxbwL5pUEigSaukb0TUwpfjGkgQIkA
	41kjOEYAK2lAcS936a+Wd6ZRvn2xbR+JIx+Va7ogA3E8IWJJFQwnBWW3gTuQefioCUvI
	8sJy4IWyO4vfNKANYmgiglC2xQq8QUergp2mVPTcr7nF7O6pDmxQxa/I4f8YBVvIA2li
	PBqQ==
X-Gm-Message-State: APjAAAWH90Xnq0JwOuxYni1aL/Siohiigkpzn/2y3HJQeSd7E4SsTveS
	mWkfD51Hv9bFFlGPbSnVYhtl3Q==
X-Google-Smtp-Source: APXvYqxprQgTN5SSn1QBYZWiYk5hFUOyhRyMaWkyerGxTM8Vh+5bzX93vpPvcAny01stSxpQTLUbyA==
X-Received: by 2002:a05:600c:2206:: with SMTP id
	z6mr16433120wml.80.1557130008365; 
	Mon, 06 May 2019 01:06:48 -0700 (PDT)
Received: from [192.168.1.37] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193])
	by smtp.gmail.com with ESMTPSA id f1sm8671989wrc.93.2019.05.06.01.06.47
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Mon, 06 May 2019 01:06:47 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, qemu-trivial@nongnu.org,
	qemu-devel@nongnu.org
References: <20190505180719.31913-1-philmd@redhat.com>
	<02ce0766-4464-2c71-6085-7e164d4405af@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <ffaa93ed-f790-8aba-3683-d1e11e2ac59c@redhat.com>
Date: Mon, 6 May 2019 10:06:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <02ce0766-4464-2c71-6085-7e164d4405af@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH] hw/timer: Compile devices not
 target-dependent as common objects
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Aleksandar Rikalo <arikalo@wavecomp.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	Beniamino Galvani <b.galvani@gmail.com>,
	Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm@nongnu.org,
	Antony Pavlov <antonynpavlov@gmail.com>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/6/19 6:10 AM, Thomas Huth wrote:
> On 05/05/2019 20.07, Philippe Mathieu-Daudé wrote:
>> All these devices do not contain any target-specific code. While
>> most of them are arch-specific, they are shared between different
>> targets of the same arch family (ARM and AArch64, MIPS32/MIPS64,
>> multiple endianess, ...).
>> Put them into common-obj-y to compile them once for all targets.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  hw/timer/Makefile.objs | 22 +++++++++++-----------
>>  1 file changed, 11 insertions(+), 11 deletions(-)
>>
>> diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
>> index 0e9a4530f84..a92e22938cb 100644
>> --- a/hw/timer/Makefile.objs
>> +++ b/hw/timer/Makefile.objs
>> @@ -25,20 +25,20 @@ common-obj-$(CONFIG_MILKYMIST) += milkymist-sysctl.o
>>  common-obj-$(CONFIG_XLNX_ZYNQMP) += xlnx-zynqmp-rtc.o
>>  common-obj-$(CONFIG_NRF51_SOC) += nrf51_timer.o
>>  
>> -obj-$(CONFIG_ALTERA_TIMER) += altera_timer.o
>> -obj-$(CONFIG_EXYNOS4) += exynos4210_mct.o
>> -obj-$(CONFIG_EXYNOS4) += exynos4210_pwm.o
>> -obj-$(CONFIG_EXYNOS4) += exynos4210_rtc.o
>> -obj-$(CONFIG_OMAP) += omap_gptimer.o
>> -obj-$(CONFIG_OMAP) += omap_synctimer.o
>> -obj-$(CONFIG_PXA2XX) += pxa2xx_timer.o
>> -obj-$(CONFIG_SH4) += sh_timer.o
>> -obj-$(CONFIG_DIGIC) += digic-timer.o
>> -obj-$(CONFIG_MIPS_CPS) += mips_gictimer.o
>> +common-obj-$(CONFIG_ALTERA_TIMER) += altera_timer.o
>> +common-obj-$(CONFIG_EXYNOS4) += exynos4210_mct.o
>> +common-obj-$(CONFIG_EXYNOS4) += exynos4210_pwm.o
>> +common-obj-$(CONFIG_EXYNOS4) += exynos4210_rtc.o
>> +common-obj-$(CONFIG_OMAP) += omap_gptimer.o
>> +common-obj-$(CONFIG_OMAP) += omap_synctimer.o
>> +common-obj-$(CONFIG_PXA2XX) += pxa2xx_timer.o
>> +common-obj-$(CONFIG_SH4) += sh_timer.o
>> +common-obj-$(CONFIG_DIGIC) += digic-timer.o
>> +common-obj-$(CONFIG_MIPS_CPS) += mips_gictimer.o
>>  
>>  obj-$(CONFIG_MC146818RTC) += mc146818rtc.o
>>  
>> -obj-$(CONFIG_ALLWINNER_A10_PIT) += allwinner-a10-pit.o
>> +common-obj-$(CONFIG_ALLWINNER_A10_PIT) += allwinner-a10-pit.o
>>  
>>  common-obj-$(CONFIG_STM32F2XX_TIMER) += stm32f2xx_timer.o
>>  common-obj-$(CONFIG_ASPEED_SOC) += aspeed_timer.o
> 
> I've checked
> 
>  grep -r TARGET hw/timer/
> 
> and this looks good to me, so:
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 
> By the way, I was surprised to see TARGET_FMT_plx there, since I first
> thought that this would be a target-specific define, too. But apparently
> it is not. Very confusing. I'd suggest to rename that to HWADDR_FMT_plx
> instead, what do you think?

I'd rather use HWADDR_PRIx and slowly kill TARGET_FMT_plx...

