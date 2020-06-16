Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB99AC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 18:07:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88DB42080D
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 18:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p5JOSr31"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88DB42080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlFzJ-00043H-Nj
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 14:07:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33104)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jlFyA-0003UU-Pj; Tue, 16 Jun 2020 14:05:58 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43423)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jlFy9-0001OL-5O; Tue, 16 Jun 2020 14:05:58 -0400
Received: by mail-wr1-x441.google.com with SMTP id l10so21706894wrr.10;
 Tue, 16 Jun 2020 11:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=eFv/74GIC90zXDmx/pN7hXJcT2/FHGZ6zxZ2uMPgNsA=;
 b=p5JOSr31AD56J4MUIf4IQXDggj2Z/JF7EBkCO07B8u6pulrrJ+dVE0htkhUrY21ZzM
 IrEaXfp7Pb/vmvD60L6wueyFoXSQjLEoSVlZVn2Hf/vjthzgkrwqwCB0bKUYAwb47Uf5
 x3dsxoSpzpYhB/gB8y9ZiEmH1gJAJGXNoUoewM1LcVAE4SkdbiKpYTznDneYZnREc7vE
 mnOo6yYINtegawDemT3r1StA9cGHH5aoSariNV72FoFbaOBpw5ByzRLsd7BHfetor3zV
 ydX4O2NZPoNkdRCw1F5y45auCqg2Y89Qa4rOmeeUuT1x/bu1lGXGa87F51PAXQ3tAULC
 vDrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=eFv/74GIC90zXDmx/pN7hXJcT2/FHGZ6zxZ2uMPgNsA=;
 b=sJbFvJ87Ne1dyl8jbOME2/zfFmfH/HD1b0m1n81AWDqTMV4efOhJ2nqnik2RuGAc/s
 tmxR84sSdLap0dh4GtRAOgm84hefWJJdegj5kWWxcqrLl1brWC74aWLub//GUT4lPzoW
 cr9ufcNAB+llvF++Gnuk1T2hQh82fuIpzWcrchIRRzideXApHusN0FXYi/UURgivq1lh
 vhGgCZ9Zl7WWvD4uynF0e4DZecIF4+/ocQXJ6EWT01lMRJbE/aCdq/SZNcB9j4Xp287e
 zqu7ixSj0hOGNiVs0gBCB15R2Oxj3d7ZEh7RcBuFDUe6R002j7dM3X2+mDVYFSdeibfk
 OeLQ==
X-Gm-Message-State: AOAM531qvzB2k8DAh/JigVIiQSz/2WxaFXyVz/7zbxDbo3wtRY12HqDQ
 NIGEWW2QR1IaWJWrnzvMYvY=
X-Google-Smtp-Source: ABdhPJztlPdit+wPQ9nMlJfxvof3DSm4cYoFGlf4LUbGZFbSqkohY3L1vACKvciWk72GZAmgp4gkOg==
X-Received: by 2002:adf:eacc:: with SMTP id o12mr4460351wrn.139.1592330755090; 
 Tue, 16 Jun 2020 11:05:55 -0700 (PDT)
Received: from [192.168.1.37] (93.red-83-59-160.dynamicip.rima-tde.net.
 [83.59.160.93])
 by smtp.gmail.com with ESMTPSA id d16sm5021110wmd.42.2020.06.16.11.05.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jun 2020 11:05:54 -0700 (PDT)
Subject: Re: [PATCH 1/2] hw/misc/pca9552: Trace LED On/Off events
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org
References: <20200616094542.25415-1-f4bug@amsat.org>
 <20200616094542.25415-2-f4bug@amsat.org>
 <ce02c953-073a-3843-5830-930cc194117c@kaod.org>
 <3181da82-6dcf-9826-5747-7601204faa9f@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <55785519-20e6-9637-1bc8-d396879f4595@amsat.org>
Date: Tue, 16 Jun 2020 20:05:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <3181da82-6dcf-9826-5747-7601204faa9f@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Joel Stanley <joel@jms.id.au>, Guenter Roeck <linux@roeck-us.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/16/20 7:15 PM, Cédric Le Goater wrote:
> After a closer look,
> 
>>> @@ -45,9 +46,15 @@ static void pca9552_update_pin_input(PCA9552State *s)
>>>          switch (config) {
>>>          case PCA9552_LED_ON:
>>>              s->regs[input_reg] |= 1 << input_shift;
>>> +            if (input_shift < s->nr_leds) {
> This seems like a superfluous test.

Indeed.

> 
>>> +                trace_pca9552_led_set(input_shift, true);
> 
> This should be using 'i' and the output is not very concise : 
> 
> 564609@1592326881.815616:pca9552_led_set LED#0 state:1
> 564609@1592326881.815660:pca9552_led_set LED#1 state:1
> 564609@1592326881.815669:pca9552_led_set LED#2 state:1
> 564609@1592326881.815677:pca9552_led_set LED#3 state:1
> 564609@1592326881.815706:pca9552_led_set LED#4 state:0
> 564609@1592326881.815715:pca9552_led_set LED#5 state:0
> 564609@1592326881.815727:pca9552_led_set LED#6 state:0
> 564609@1592326881.815740:pca9552_led_set LED#7 state:0
> 564609@1592326881.815748:pca9552_led_set LED#8 state:0
> 564609@1592326881.815759:pca9552_led_set LED#9 state:0
> 564609@1592326881.815767:pca9552_led_set LED#10 state:0
> 564609@1592326881.815779:pca9552_led_set LED#11 state:0
> 564609@1592326881.815790:pca9552_led_set LED#12 state:0
> 564609@1592326881.815802:pca9552_led_set LED#13 state:1
> 564609@1592326881.815813:pca9552_led_set LED#14 state:1
> 564609@1592326881.815826:pca9552_led_set LED#15 state:1
> 
> I would instead simply dump the contents of the PCA9552_INPUT registers : 
> 
> LEDS = 1111000000000101
> LEDS = 1111000000000111
> ....

Good idea, thanks!

> 
> C.
> 
> 
>>> +            }
>>>              break;
>>>          case PCA9552_LED_OFF:
>>>              s->regs[input_reg] &= ~(1 << input_shift);
>>> +            if (input_shift < s->nr_leds) {
>>> +                trace_pca9552_led_set(input_shift, false);
>>> +            }
>>>              break;
>>>          case PCA9552_LED_PWM0:
>>>          case PCA9552_LED_PWM1:
>>> diff --git a/hw/misc/trace-events b/hw/misc/trace-events
>>> index 5561746866..ed80d0d1be 100644
>>> --- a/hw/misc/trace-events
>>> +++ b/hw/misc/trace-events
>>> @@ -206,3 +206,6 @@ via1_rtc_cmd_pram_sect_write(int sector, int offset, int addr, int value) "secto
>>>  # grlib_ahb_apb_pnp.c
>>>  grlib_ahb_pnp_read(uint64_t addr, uint32_t value) "AHB PnP read addr:0x%03"PRIx64" data:0x%08x"
>>>  grlib_apb_pnp_read(uint64_t addr, uint32_t value) "APB PnP read addr:0x%03"PRIx64" data:0x%08x"
>>> +
>>> +# pca9552.c
>>> +pca9552_led_set(unsigned id, bool state) "LED#%d state:%u"
>>>
>>
> 
> 

