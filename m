Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2FC6C433E6
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 11:38:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A6AD2220C
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 11:38:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qAIdbv3f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A6AD2220C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvJGZ-0002gz-Of
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 07:38:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56008)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jvJFy-00029L-5Z; Tue, 14 Jul 2020 07:37:54 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:40215)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jvJFw-0001Bu-HS; Tue, 14 Jul 2020 07:37:53 -0400
Received: by mail-wr1-x442.google.com with SMTP id f2so20940660wrp.7;
 Tue, 14 Jul 2020 04:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=F3IIMSIc9WWISIBv2z+SaeMUuP7HL6DeAAbk+nvM3ys=;
 b=qAIdbv3fVH7IFjNgFqk0pyq5St1vTg7SySsKtMt58NsZDwUY3dfVykFEwX3ELOYo9Q
 JwyBaoxhJXtIlpabrNSkO/ZoSjRW4duocMsbPwq/V7Jy62sI6iZUWmEyk1RDm/50qVVb
 ft5HJY2m4f+Fsp1IYbq3fEKQyA7HMIVJ+FjDo2LezaZ1LFhLMCHPaLfyk6qG2uSFU8S0
 pIytMXSuYj4qvcP4Fm33f2qSM4bAcKqjhAQj2wAbfeCOC+BivUOEsHiWHm1oxI+09Q5w
 R8MSX19z1V/MAOLwUABO4K98XswRS6tb9/Zxa0Z9BRxsVyBqaDn9Aq2TC/urprdv/2iJ
 G5ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=F3IIMSIc9WWISIBv2z+SaeMUuP7HL6DeAAbk+nvM3ys=;
 b=hePsmQuzDcoSbRv4nA1N3+G5xiyP058z1lcBxFE5e2N3BHvieZ7R6atR02eJ7E6aN8
 fIEyHtM8xkDvqH7gF/CReTP+idYVtjIalq0pAoZdJPICDlKUzB0Q2C7a//peTZQ+tTNx
 PtB52gNFlbG1+ykjwq1tiNuA5AC7+rQTxurNBA+2+QxQyljC24Tdnc1aVN5F4TqsX4nJ
 C226PjjuqxEWYVryxencdpUAWVkYVJK3TjZrDksaUcZZz2n8A4yZv05BHVAGJc+l4niR
 Oo+IayATv0Sdii7wrBb/zagdgDJmLEbymgK2D0pY0U4dKbXcwNHr+2iGYndXcq/DIGKS
 iBkg==
X-Gm-Message-State: AOAM531VOiJgnCO9rxZ3PkfmHhvuIceFY3ko1Kyodiei2IAEngjbAp/5
 r8WkqXCl/KnpfPFK9v1rTBE=
X-Google-Smtp-Source: ABdhPJwA3AFDcmLeKtYXg7BO/p2fbBNP9cRYAQI6UbslVIK+GpOnYk+ld53JrsZGKiW2Is25gCN16Q==
X-Received: by 2002:adf:92c4:: with SMTP id 62mr4648045wrn.290.1594726670460; 
 Tue, 14 Jul 2020 04:37:50 -0700 (PDT)
Received: from [192.168.1.43] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id o29sm30961169wra.5.2020.07.14.04.37.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2020 04:37:49 -0700 (PDT)
Subject: Re: [PATCH v5 04/11] hw/arm: Add NPCM730 and NPCM750 SoC models
To: Havard Skinnemoen <hskinnemoen@google.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
References: <20200709003608.3834629-1-hskinnemoen@google.com>
 <20200709003608.3834629-5-hskinnemoen@google.com>
 <3ec30463-03f8-98e9-9a14-01b0bb698c9b@kaod.org>
 <CAFQmdRYQxMz_qSr4i_cyqRPEGuq7At=VEOGvsupR3=W7pE3q=g@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <7c978e82-8890-9ba4-096a-92d7cff60b0a@amsat.org>
Date: Tue, 14 Jul 2020 13:37:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFQmdRYQxMz_qSr4i_cyqRPEGuq7At=VEOGvsupR3=W7pE3q=g@mail.gmail.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 CS20 KFTing <kfting@nuvoton.com>, qemu-arm <qemu-arm@nongnu.org>,
 Joel Stanley <joel@jms.id.au>, IS20 Avi Fishman <Avi.Fishman@nuvoton.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+Markus

On 7/14/20 2:44 AM, Havard Skinnemoen wrote:
> On Mon, Jul 13, 2020 at 8:02 AM Cédric Le Goater <clg@kaod.org> wrote:
>>
>> On 7/9/20 2:36 AM, Havard Skinnemoen wrote:
>>> The Nuvoton NPCM7xx SoC family are used to implement Baseboard
>>> Management Controllers in servers. While the family includes four SoCs,
>>> this patch implements limited support for two of them: NPCM730 (targeted
>>> for Data Center applications) and NPCM750 (targeted for Enterprise
>>> applications).
>>>
>>> This patch includes little more than the bare minimum needed to boot a
>>> Linux kernel built with NPCM7xx support in direct-kernel mode:
>>>
>>>   - Two Cortex-A9 CPU cores with built-in periperhals.
>>>   - Global Configuration Registers.
>>>   - Clock Management.
>>>   - 3 Timer Modules with 5 timers each.
>>>   - 4 serial ports.
>>>
>>> The chips themselves have a lot more features, some of which will be
>>> added to the model at a later stage.
>>>
>>> Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
>>> Reviewed-by: Joel Stanley <joel@jms.id.au>
>>> Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
>>> ---
...

>>> +static void npcm7xx_realize(DeviceState *dev, Error **errp)
>>> +{
>>> +    NPCM7xxState *s = NPCM7XX(dev);
>>> +    NPCM7xxClass *nc = NPCM7XX_GET_CLASS(s);
>>> +    int i;
>>> +
>>> +    /* CPUs */
>>> +    for (i = 0; i < nc->num_cpus; i++) {
>>> +        object_property_set_int(OBJECT(&s->cpu[i]),
>>> +                                arm_cpu_mp_affinity(i, NPCM7XX_MAX_NUM_CPUS),
>>> +                                "mp-affinity", &error_abort);
>>> +        object_property_set_int(OBJECT(&s->cpu[i]), NPCM7XX_GIC_CPU_IF_ADDR,
>>> +                                "reset-cbar", &error_abort);
>>> +        object_property_set_bool(OBJECT(&s->cpu[i]), true,
>>> +                                 "reset-hivecs", &error_abort);
>>> +
>>> +        /* Disable security extensions. */
>>> +        object_property_set_bool(OBJECT(&s->cpu[i]), false, "has_el3",
>>> +                                 &error_abort);
>>> +
>>> +        qdev_realize(DEVICE(&s->cpu[i]), NULL, &error_abort);
>>
>> I would check the error:
>>
>>         if (!qdev_realize(DEVICE(&s->cpu[i]), NULL, errp)) {
>>             return;
>>         }
>>
>> same for the sysbus_realize() below.
> 
> Hmm, I used to propagate these errors until Philippe told me not to
> (or at least that's how I understood it).

It was before Markus simplification API were merged, you had to
propagate after each call, since this is a non hot-pluggable SoC
I suggested to use &error_abort to simplify.

> I'll be happy to do it
> either way (and the new API makes it really easy to propagate errors),
> but I worry that I don't fully understand when to propagate errors and
> when not to.

Markus explained it on the mailing list recently (as I found the doc
not obvious). I can't find the thread. I suppose once the work result
after the "Questionable aspects of QEMU Error's design" discussion is
merged, the documentation will be clarified.

My rule of thumb so far is:
- programming error (can't happen) -> &error_abort
- everything triggerable by user or management layer (via QMP command)
  -> &error_fatal, as we can't risk loose the user data, we need to
  shutdown gracefully.

> 
> It makes sense to me to propagate errors from *_realize() and
> error_abort on failure to set simple properties, but I'd like to know
> if Philippe is on board with that.
> 
>>> +    }
>>> +
>>> +    /* A9MPCORE peripherals */
>>> +    object_property_set_int(OBJECT(&s->a9mpcore), nc->num_cpus, "num-cpu",
>>> +                            &error_abort);
>>> +    object_property_set_int(OBJECT(&s->a9mpcore), NPCM7XX_NUM_IRQ, "num-irq",
>>> +                            &error_abort);
>>> +    sysbus_realize(SYS_BUS_DEVICE(&s->a9mpcore), &error_abort);
>>> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->a9mpcore), 0, NPCM7XX_CPUP_BA);
>>> +
>>> +    for (i = 0; i < nc->num_cpus; i++) {
>>> +        sysbus_connect_irq(SYS_BUS_DEVICE(&s->a9mpcore), i,
>>> +                           qdev_get_gpio_in(DEVICE(&s->cpu[i]), ARM_CPU_IRQ));
>>> +        sysbus_connect_irq(SYS_BUS_DEVICE(&s->a9mpcore), i + nc->num_cpus,
>>> +                           qdev_get_gpio_in(DEVICE(&s->cpu[i]), ARM_CPU_FIQ));
>>> +    }
...

