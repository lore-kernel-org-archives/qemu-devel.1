Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42206C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:56:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AFC1205CB
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQivoLTJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AFC1205CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZFHV-00020v-2g
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 10:56:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41220)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jZEtq-0005bO-UU; Thu, 14 May 2020 10:31:51 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36178)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jZEtq-0000R9-0n; Thu, 14 May 2020 10:31:50 -0400
Received: by mail-wr1-x444.google.com with SMTP id y16so4440760wrs.3;
 Thu, 14 May 2020 07:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=6dEkqGwX3ANiGV0kFl51uDv7FKXAb9zRqWwSMJvEoTc=;
 b=dQivoLTJThr14z4DFgsJBFZDylXDppKgeeQKPqE1myU5UyFFXYJbdX9SC7XGswhPNF
 0uSdSTxFnrY8rO5SBFbKbaNPGJ2XK+qMVNlEK8Rk2gSl3JIRIgW5Wn6RoFUboltsarqY
 K7X5ZPGdkqL89nrPOHWdDCN+3FoFu73xCvPgutzv+lFgxtC0AlETPhCzLuGhYf9TNkf1
 25zMqxNaUMkPz1RWqYuMQJSVE+vvXUQaepiBeGnD5F/o66IwUAXcDktSPIXV0SZXyJww
 5FLqvwF+YhR1hi7u1Z6YTwoxjyXXnWQja/FEWpxyp0mPFBdo6tO2Az1pXS1HLnQLVM3l
 jU/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6dEkqGwX3ANiGV0kFl51uDv7FKXAb9zRqWwSMJvEoTc=;
 b=eDd+Opc+s8MrPGU+YPjz3b3KkIScH2W2k+k10GlFnnckCDwI7ne4T59l8HAWazlBow
 7WvhuOnTUPxfMTHk0m5UwgK64VMVn7Rk2aZNHc/mOFbh/efmHkXtUXI1hScTFdPLt+5h
 WOKrcryvnEW99YYU1YnFNVHkYXoD8aL3COuyV24sNZIlx6E24bAMo0DWRkN0wF5ZBgLG
 qc8cuUbDK1S/pgCBvUqM/VY6w+Nh69zn1dwRVrZijOiV3eaTeGlVTJltWIAdMx5EPlkI
 sjKvpetIz6AvAK+5ukpefvkoJvCp5j1IFJvyXqdUgHc++Fe81iMdRTn5/eTReNKXvwN2
 G5uw==
X-Gm-Message-State: AOAM532atCycFKq5vA8Pyi84Q4ZwCbwp21dZ/KE2nQmJEoEkzZFIgcSB
 fmEMniKfvmiesdzJqvKCfQs=
X-Google-Smtp-Source: ABdhPJxJavPDYtGhOEhciVB1KQYpDWlf49rUYRHKn0BsDyGa0j0f3eTwj/1EsJf2hcpSZj73zxWnsQ==
X-Received: by 2002:a5d:61c5:: with SMTP id q5mr5976974wrv.398.1589466708076; 
 Thu, 14 May 2020 07:31:48 -0700 (PDT)
Received: from [192.168.1.39] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id v126sm11915814wmb.4.2020.05.14.07.31.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 May 2020 07:31:47 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] hw/mips/mips_int: Use qdev gpio rather than
 qemu_allocate_irqs()
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200512074813.29992-1-f4bug@amsat.org>
 <20200512074813.29992-3-f4bug@amsat.org>
 <CAFEAcA9=OkWR5mo=6K_YhraSUhQhzV3_G7cKQ9S5mPWhFZVfdw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d5e3b0a0-83f7-06ff-04be-a5dae669e654@amsat.org>
Date: Thu, 14 May 2020 16:31:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9=OkWR5mo=6K_YhraSUhQhzV3_G7cKQ9S5mPWhFZVfdw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Stafford Horne <shorne@gmail.com>, John Snow <jsnow@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/14/20 3:24 PM, Peter Maydell wrote:
> On Tue, 12 May 2020 at 08:48, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>
>> Switch to using the qdev gpio API which is preferred over
>> qemu_allocate_irqs(). One step to eventually deprecate and
>> remove qemu_allocate_irqs() one day.
> 
>> diff --git a/hw/mips/mips_int.c b/hw/mips/mips_int.c
>> index 796730b11d..91788c51a9 100644
>> --- a/hw/mips/mips_int.c
>> +++ b/hw/mips/mips_int.c
>> @@ -74,14 +74,12 @@ static void cpu_mips_irq_request(void *opaque, int irq, int level)
>>   void cpu_mips_irq_init_cpu(MIPSCPU *cpu)
>>   {
>>       CPUMIPSState *env = &cpu->env;
>> -    qemu_irq *qi;
>>       int i;
>>
>> -    qi = qemu_allocate_irqs(cpu_mips_irq_request, cpu, 8);
>> +    qdev_init_gpio_in(DEVICE(cpu), cpu_mips_irq_request, 8);
>>       for (i = 0; i < 8; i++) {
>> -        env->irq[i] = qi[i];
>> +        env->irq[i] = qdev_get_gpio_in(DEVICE(cpu), i);
>>       }
>> -    g_free(qi);
>>   }
> 
> Similar comments as with the openrisc patch apply here:
>   * ideally this code should be in target/mips/, not in hw/mips
>   * board code should call qdev_get_gpio_in() to get the IRQ
>     line, rather than fishing env->irq[] out of the CPU object
>     directly
> This is a bit more complicated than with openrisc, because there's
> more than just a single board model, and not all MIPS boards call
> cpu_mips_irq_init_cpu() so figuring out whether MIPS CPUs should
> always provide inbound CPU lines, or only those with some
> particular feature, or something else, would need some
> investigation or MIPS knowledge.

Yes, I'm aware of at least 3 different to map interrupts to a MIPS core.
QEMU models at least 2.

As X86, MIPS code use old QEMU API, I don't see the codebase being 
upgraded anytime soon.

This is another borderline case between architecture and hardware, as 
the cache units, or the ARM NVIC. Ideally we should keep target/* free 
of references to hw/* code. In my experience it often give troubles.

> But this is an OK first
> step anyway, so
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Thanks. The idea to keep qemu_allocate_irqs() as internal as possible, 
and have devices use the qdev GPIO API.

> 
> thanks
> -- PMM
> 

