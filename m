Return-Path: <SRS0=NumX=A5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B016AC433E4
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2020 06:39:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E2F220809
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2020 06:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I3btEYvK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E2F220809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwgV5-0005HY-PB
	for qemu-devel@archiver.kernel.org; Sat, 18 Jul 2020 02:39:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46768)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jwgUQ-0004jO-9T; Sat, 18 Jul 2020 02:38:30 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:40783)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jwgUO-0000Ok-Ht; Sat, 18 Jul 2020 02:38:30 -0400
Received: by mail-wm1-x344.google.com with SMTP id f139so20479052wmf.5;
 Fri, 17 Jul 2020 23:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=EsOlMnTrArh+/EAAhuxVogTlQuhGTL9qidrSIGAMKDc=;
 b=I3btEYvKCvS/lTXc1G0i71g5A1UpHb0U6AqRZCA1pLOlj/HjCxfMtI0/3wutfrA0nY
 DzvdzYcwFbcpFGgh5YEAsNfeYLeDL7ZNerGRRiD04leuQSD8we2++boU4uy8RdoK942W
 CVD1IG0yCt/Pu8pzeUfjibHD70eLIZseypHuEpwSiNLUyRQWgnw7JusTcOyZoqPmNnSo
 xdl3O/CbHX44ssbSGhSQInsG5AGosF2maR7xMfhYkwz7Ynfw/W+kYgecEQEXCNzdT+PX
 CThJZuNpJTOVUUx2kBQ1mDsbktAVQpMPMzcP/mjSe7G6IjKC/0uX15/eRlHYntpRvY4h
 ULGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EsOlMnTrArh+/EAAhuxVogTlQuhGTL9qidrSIGAMKDc=;
 b=J25epOH2q/0oxA1uuS26EAbqOKVYc+ze4gMTZneOseJP/mBl3k3mAIdUf3JQ2/6bTc
 8CyH4cnbb/frL1tYGr9KfI6aYAzzqKr06wwwwt1IGCUrvfasixlhP7yGO8GnW+NGBORL
 wXifs+ON/rPBfP2HHcvSjlElzMJ2auxiQsZp9RycFBoqufpnFSgemfF0GmeoJD8vIKyG
 6ijQ0tUNVur78u0y0dsY3tJsiMGwYL5SZ4d7D1WSA1u8PMVzx8fD4arKh7jrx5KF3pT7
 E7+n+b0xl4/CXxm/zeFp+zLw/ZZ96nWPTA03FaLTR+jO1LzLKk7UdWbcx6C5GDJqGDFp
 lsWA==
X-Gm-Message-State: AOAM5334y/CCee89olG/eAN/Y39XQ6JyUsirK9tzZoyS1OYftqD43wLd
 /L2INKnoSq/MjeB6HwHBRpQ=
X-Google-Smtp-Source: ABdhPJwvUfUWjoqYCdIY/e5wvqrveypJkMUnrSRwuUASwy5dadxg6G8TkIkrvq9mKoBUxzI5JjPZCQ==
X-Received: by 2002:a1c:c90d:: with SMTP id f13mr13232302wmb.185.1595054306360; 
 Fri, 17 Jul 2020 23:38:26 -0700 (PDT)
Received: from [192.168.1.43] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id j14sm18278959wrs.75.2020.07.17.23.38.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jul 2020 23:38:25 -0700 (PDT)
Subject: Re: [PATCH v6 04/13] hw/arm: Add NPCM730 and NPCM750 SoC models
To: Havard Skinnemoen <hskinnemoen@google.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20200717060258.1602319-1-hskinnemoen@google.com>
 <20200717060258.1602319-5-hskinnemoen@google.com>
 <99db91b7-60e2-7212-abd2-a6505aee5d3d@kaod.org>
 <CAFQmdRZsGGc27-M_xfExsFD_M1dT4gVjvLewVoGCELJFbZ7hew@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <db1f8432-f8d4-1382-0cc1-4fbb13a1b3d6@amsat.org>
Date: Sat, 18 Jul 2020 08:38:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFQmdRZsGGc27-M_xfExsFD_M1dT4gVjvLewVoGCELJFbZ7hew@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: CS20 KFTing <kfting@nuvoton.com>, qemu-arm <qemu-arm@nongnu.org>,
 Joel Stanley <joel@jms.id.au>, QEMU Developers <qemu-devel@nongnu.org>,
 IS20 Avi Fishman <Avi.Fishman@nuvoton.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/17/20 6:59 PM, Havard Skinnemoen wrote:
> +Markus Armbruster
> 
> On Fri, Jul 17, 2020 at 5:20 AM Cédric Le Goater <clg@kaod.org> wrote:
>>
>> On 7/17/20 8:02 AM, Havard Skinnemoen wrote:
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
>>> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>> Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
>>> ---
>>>  include/hw/arm/npcm7xx.h |  85 ++++++++
>>>  hw/arm/npcm7xx.c         | 407 +++++++++++++++++++++++++++++++++++++++
>>>  hw/arm/Kconfig           |   5 +
>>>  hw/arm/Makefile.objs     |   1 +
>>>  4 files changed, 498 insertions(+)
>>>  create mode 100644 include/hw/arm/npcm7xx.h
>>>  create mode 100644 hw/arm/npcm7xx.c
...

>>> +static void npcm7xx_realize(DeviceState *dev, Error **errp)
>>> +{
>>> +    NPCM7xxState *s = NPCM7XX(dev);
>>> +    NPCM7xxClass *nc = NPCM7XX_GET_CLASS(s);
>>> +    int i;
>>> +
>>> +    if (memory_region_size(s->dram) > NPCM7XX_DRAM_SZ) {
>>> +        error_setg(errp, "%s: NPCM7xx cannot address more than %" PRIu64
>>> +                   " MiB of DRAM", __func__, NPCM7XX_DRAM_SZ / MiB);
>>> +        return;
>>> +    }
>>> +
>>> +    /* CPUs */
>>> +    for (i = 0; i < nc->num_cpus; i++) {
>>> +        object_property_set_int(OBJECT(&s->cpu[i]), "mp-affinity",
>>> +                                arm_cpu_mp_affinity(i, NPCM7XX_MAX_NUM_CPUS),
>>> +                                &error_abort);
>>> +        object_property_set_int(OBJECT(&s->cpu[i]), "reset-cbar",
>>> +                                NPCM7XX_GIC_CPU_IF_ADDR, &error_abort);
>>> +        object_property_set_bool(OBJECT(&s->cpu[i]), "reset-hivecs", true,
>>> +                                 &error_abort);
>>> +
>>> +        /* Disable security extensions. */
>>> +        object_property_set_bool(OBJECT(&s->cpu[i]), "has_el3", false,
>>> +                                 &error_abort);
>>> +
>>> +        if (!qdev_realize(DEVICE(&s->cpu[i]), NULL, errp)) {
>>> +            return;
>>> +        }
>>> +    }
>>> +
>>> +    /* A9MPCORE peripherals. Can only fail if we pass bad parameters here. */
>>> +    object_property_set_int(OBJECT(&s->a9mpcore), "num-cpu", nc->num_cpus,
>>> +                            &error_abort);
>>> +    object_property_set_int(OBJECT(&s->a9mpcore), "num-irq", NPCM7XX_NUM_IRQ,
>>> +                            &error_abort);

[1]

>>> +    sysbus_realize(SYS_BUS_DEVICE(&s->a9mpcore), &error_abort);

[2]

>>
>> shouldn't we test the return value and use errp ? I don't know what
>> was agreed upon.

Per https://www.mail-archive.com/qemu-devel@nongnu.org/msg723217.html:

>> 1. Internal code failing to set simple properties to predefined
>> values is a programming error, so error_abort is appropriate.
>
> That would be my advice.
>
>> 2. qdev_realize() may fail due to user input, so errors should be
>> propagated.
>
> In general, yes.  For a specific device, you may know it can't fail,
> and then &error_abort may be okay.

So it looks correct.

> 
> I'm not sure if I got it 100% right, but what I tried to do was to see
> which submodules could possibly fail due to user input, and propagate
> errors from those modules only.
> 
> For example, the GCR can fail if the user-provided memory size can't
> be encoded into registers, so that one clearly needs to be propagated.
> 
> Other modules don't take any parameters at all, so they can only fail
> due to programming errors, hence error_abort.
> 
> I wasn't able to find any way command line options could cause the
> a9mpcore module to fail, but that's one of the cases I'm very unsure
> about, so I'll be happy to propagate errors from that if you (or
> anyone else) think it's needed.
> 
> I'm also not sure about the CPUs, but ended up going the other way
> since there's a -cpu option, and it's plausible that the user could
> cause it to fail even though I couldn't find any specific options to
> trigger an error.

