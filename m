Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF958C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 22:25:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86E2020772
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 22:25:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q6DsHzwB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86E2020772
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrU7L-0005lI-Me
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 18:25:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60382)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrU6j-0005IM-Pz; Fri, 03 Jul 2020 18:24:33 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:54556)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrU6i-0003SR-6F; Fri, 03 Jul 2020 18:24:33 -0400
Received: by mail-wm1-x342.google.com with SMTP id o8so33344432wmh.4;
 Fri, 03 Jul 2020 15:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=oszZoWc56c+kYMZlHZs7E7RjeVrLR+NPiJRZfpObgCg=;
 b=q6DsHzwBO7IPICp3pW4MtVZ4lJPvs1K1IRpOSkCbHIY6TQh4Kb3pdFqVoCpdSC/qOu
 ZKA9jokXPAfuSLRXGY3U5hi/Zgv1xTQEPMfp2A+NuToDCjUVIFxLljdviDXZGWAjBVup
 +tr2Ja3w8wLCD8TCYPsejfldUx02YbDP9gqa4Ew6E0vNtm0tuGcOkbpKTKwWe1Spw5ZU
 e9LeWNCNymhRby3hbNFeSZl81IJRSZC3l57awAN/Ax0HvYOMIK583aPj2+5t59iBukJ5
 pZmp6+8LOqDCNvEKjWPvvJApNz2VNEikfiG+p1m8ymbRSLAlsofz7X0+5BWRSTOiCKL5
 zlJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=oszZoWc56c+kYMZlHZs7E7RjeVrLR+NPiJRZfpObgCg=;
 b=CWHfN9thGkjL7sTt+B2EIFsznv7Jz9SY/h0ksdz1sFBJLPvQVsoQCn3avyWEQhG/sM
 2nxQNjuCaA5gq8Ppa35nrd6ySIeusMED3b8EnQYW2slVNi6Twc9wOjKQiINMka53uBli
 VZu0J91YVBiV3fEcWTX6qBVPCNYAni9alnZRNF0kM/5hhsWFET21Xd4cLzTjOOkJQZmb
 86HYMpkJwO5PC3ADKxcGFvowsu6t3CIoCqmTVygkbIXy5XZbCp/aPVm3O+zeUF1hlXVL
 5oU1S7/LiNVoodZOeitWMAesEpVXTLYExw298KO0P1+OzHBLeDy6Nlz+53VqDZE+SOhD
 yAQQ==
X-Gm-Message-State: AOAM530B3TIFK0cs5WBtKo/pjofb5HqMq4XyLC3QGCx9HbYfZAZsKLLY
 Aziuv85Pohohnflh3j2HjZY=
X-Google-Smtp-Source: ABdhPJzanFYNQguasOTNrxc3bTWL5BlHukBd9Sfork3aKL//ov1Z6af9T+4H8XieU42G7ffRP6ybdQ==
X-Received: by 2002:a1c:7c19:: with SMTP id x25mr28377459wmc.176.1593815070488; 
 Fri, 03 Jul 2020 15:24:30 -0700 (PDT)
Received: from [192.168.1.39] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id u84sm14461689wmg.7.2020.07.03.15.24.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jul 2020 15:24:29 -0700 (PDT)
Subject: Re: [PATCH v3 08/12] hw/nvram: NPCM7xx OTP device model
To: Havard Skinnemoen <hskinnemoen@google.com>
References: <20200626235519.591734-1-hskinnemoen@google.com>
 <20200626235519.591734-9-hskinnemoen@google.com>
 <abdb209d-7268-7997-2caa-95cb984269da@amsat.org>
 <CAFQmdRYZWhA-957jRHfiRHfYoOk-c2TJVtqoz6LMOhDgJwMiCg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9f8c6cb0-cac3-2afe-a98a-c627cb04bd4b@amsat.org>
Date: Sat, 4 Jul 2020 00:24:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFQmdRYZWhA-957jRHfiRHfYoOk-c2TJVtqoz6LMOhDgJwMiCg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Joel Stanley <joel@jms.id.au>,
 CS20 KFTing <kfting@nuvoton.com>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goate?= =?UTF-8?Q?r?= <clg@kaod.org>,
 IS20 Avi Fishman <Avi.Fishman@nuvoton.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/3/20 11:07 PM, Havard Skinnemoen wrote:
> On Fri, Jul 3, 2020 at 6:46 AM Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>
>> On 6/27/20 1:55 AM, Havard Skinnemoen wrote:
>>> +static void npcm7xx_otp_realize(DeviceState *dev, Error **errp)
>>> +{
>>> +    NPCM7xxOTPClass *oc = NPCM7XX_OTP_GET_CLASS(dev);
>>> +    NPCM7xxOTPState *s = NPCM7XX_OTP(dev);
>>> +    SysBusDevice *sbd = &s->parent;
>>> +
>>> +    s->array = g_malloc0(NPCM7XX_OTP_ARRAY_BYTES);
>>
>> The possibility to reuse persistent OTP seems important.
>> This can be added later of course.
> 
> Agree, it's an important part of the behavior of the module. But it's
> not essential to be able to boot a BMC firmware image, so I left it
> out initially.

This is not a problem until someone else try to use it. And OTP/NVRAM
are devices currently in hype. Meanwhile we have another technical debt.
I am just giving generic review comments.

What bugs me particularly is the OTP content zeroed at reset without
any warning. Maybe you can add something like:

  qemu_log_mask(LOG_UNIMP,
                "Persistence not supported, OTP content erased!\n");

in npcm7xx_otp_enter_reset().

> 
>> See simple example in hw/nvram/eeprom_at24c.c which use
>> a BlockBackend so the OTP content is not lost after reset
>> or migration.
> 
> I'll take a look at that, thanks!
> 
>>> +
>>> +    memory_region_init_io(&s->mmio, OBJECT(s), oc->mmio_ops, s, "regs",
>>> +                          NPCM7XX_OTP_REGS_SIZE);
>>> +    sysbus_init_mmio(sbd, &s->mmio);
>>> +}
>>> +
>>> +static void npcm7xx_otp_class_init(ObjectClass *klass, void *data)
>>> +{
>>> +    ResettableClass *rc = RESETTABLE_CLASS(klass);
>>> +    DeviceClass *dc = DEVICE_CLASS(klass);
>>> +
>>
>> Missing migration vmstate for NPCM7xxOTPState::regs[].
> 
> Ah, you're right. This is probably true for most of the peripherals in
> this series. I'll see if I can get it sorted out for the next
> iteration.

IIUC Peter is ready to queue your series on Monday if you fix the
license, but he usually doesn't accept devices without vmstate via
his tree, you got lucky ;) See:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg643089.html

Adding the vmstate is not a hard task. If you need to respin,
I strongly recommend you to consider adding them.

Excellent work btw :)

Regards,

Phil.

