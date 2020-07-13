Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 088F8C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 10:56:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C35EB20758
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 10:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OU1Ea2N+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C35EB20758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juw8M-0000pO-Vv
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 06:56:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60834)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1juw7N-00082f-3U; Mon, 13 Jul 2020 06:55:29 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:46964)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1juw7L-0003pV-8G; Mon, 13 Jul 2020 06:55:28 -0400
Received: by mail-ej1-x642.google.com with SMTP id p20so16384080ejd.13;
 Mon, 13 Jul 2020 03:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=nl7LZ281I4Ev2TP0zLsx5mbzjetKalsfc87KsGzkBA0=;
 b=OU1Ea2N+XmxmcYVtlumhXdUk4Kp4oY29gI6QO5mOzPqQPwZ3pAPKNJWwJTMDXX0e/N
 S7QpsofviWZ/h8BjBVXdysQ/+vsmgcdp+blqpc1WdFGUbuPH8m+Yo5lZ3H96fqo6j620
 C2WaTdjKTL7jRSfwKCrOI0KXWXzylE1uOgqKaq47Q5B29MSq5qtNTkBlaWLnDR/mHlJZ
 YCR86qa3JJ4gndD559iNy+FUnv6MusV8FcHuyHFHtu24tN58QNmQvDXLublkSuBDOPe9
 rYxGR7pjPudVW9dgdyHv/cPvYETck5Cu88aB1PMWn088IqPzsMABeZv+4t0fHWpN1fbF
 J1Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nl7LZ281I4Ev2TP0zLsx5mbzjetKalsfc87KsGzkBA0=;
 b=rfbc2nix3KUbvkumVMKhu2tIg0eGUu1YrWdNX7qeyLKLj0WRsLtw5rfSS6hcGAg5vg
 oE5pWOua3nfHhVKvtyYseHv8Pikvxq1F/v0ArrHdMmkduEI3zyPOPrHFiNI+u4SEVViO
 14HZul//cqtLw2d/w6qtw36ZXQXlJ0OlDgZnJy7Ro+E7LPI/RcujsX+qhzsCe+GpayAJ
 FKMGQM+A+F1RdNNWSbdoEoTej0UF3WNQFTSlHDEBUpMcPnv1n16s0NxdcPZ5ZbG+2TGR
 NHMeI2tVXkEPNsEL8kavVaOdhf5J5XWJa4vaZK+FfCr82up20pVG76fLgbh4W68vE+xi
 Xdgg==
X-Gm-Message-State: AOAM533d9eP9kmR84eazivfWy/AjYW3z7hLYIhDTX7+ORpA2wzmwgeIo
 Xn7KoG485Bj0SAQB7KgnI765feDVI+o=
X-Google-Smtp-Source: ABdhPJzEB9uIy5BQKttu5rN1Asc7QPrO5S2R7lGyRhVM8rTTLbRoRZpYEhRANQPiE3ZnGA+dvXfBNw==
X-Received: by 2002:a17:907:94ca:: with SMTP id
 dn10mr71334347ejc.348.1594637725148; 
 Mon, 13 Jul 2020 03:55:25 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id u60sm11697868edc.59.2020.07.13.03.55.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2020 03:55:24 -0700 (PDT)
Subject: Re: [PATCH 2/2] hw/arm/tosa: Encapsulate misc GPIO handling in a
 device
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200628203748.14250-1-peter.maydell@linaro.org>
 <20200628203748.14250-3-peter.maydell@linaro.org>
 <bdc37753-de8e-eba4-75e0-32eada401b24@amsat.org>
 <CAFEAcA-qwjBwxF61NWuDhQACkvGa3TkjWWEbnMX+Uu+J7orzZg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <0c5e649e-397f-13b5-4860-ca0659fcded2@amsat.org>
Date: Mon, 13 Jul 2020 12:55:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-qwjBwxF61NWuDhQACkvGa3TkjWWEbnMX+Uu+J7orzZg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x642.google.com
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/29/20 2:14 PM, Peter Maydell wrote:
> On Mon, 29 Jun 2020 at 10:39, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>
>> Hi Peter,
>>
>> On 6/28/20 10:37 PM, Peter Maydell wrote:
>>> Currently we have a free-floating set of IRQs and a function
>>> tosa_out_switch() which handle the GPIO lines on the tosa board which
>>> connect to LEDs, and another free-floating IRQ and tosa_reset()
>>> function to handle the GPIO line that resets the system.  Encapsulate
>>> this behaviour in a simple QOM device.
>>>
>>> This commit fixes Coverity issue CID 1421929 (which pointed out that
>>> the 'outsignals' in tosa_gpio_setup() were leaked), because it
>>> removes the use of the qemu_allocate_irqs() API from this code
>>> entirely.
>>>
>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>> ---
>>> This is simpler than the spitz changes because the new device
>>> doesn't need to refer to any of the other devices on the board.
>>> ---
> 
>>> +#define TYPE_TOSA_MISC_GPIO "tosa-misc-gpio"
>>> +#define TOSA_MISC_GPIO(obj) \
>>> +    OBJECT_CHECK(TosaMiscGPIOState, (obj), TYPE_TOSA_MISC_GPIO)
>>> +
>>> +typedef struct TosaMiscGPIOState {
>>> +    SysBusDevice parent_obj;
>>> +} TosaMiscGPIOState;
>>
>> Since we don't really use this type, can we avoid declaring it?
> 
> I prefer to be consistent. QOM's implementation allows this kind
> of shortcut where you don't provide everything that a typical
> leaf class provides if you don't need all of it, but then it
> gets confusing if later on somebody wants to add something
> to that leaf class. I think it's less confusing to have
> just two standard patterns:
>  * leaf class, no subclasses
>  * a class that will be subclassed
> and then always provide the same set of TYPE_*, cast macros,
> structs, etc for whichever of the patterns you're following,
> even if it happens that these aren't all needed.

Understood.

> (https://wiki.qemu.org/Documentation/QOMConventions
> does a reasonable job of saying what the standard pattern
> is for the subclassed-class case, but is a bit less clear
> on the leaf-class case.)
> 
> 
>>> +static void tosa_misc_gpio_init(Object *obj)
>>> +{
>>> +    DeviceState *dev = DEVICE(obj);
>>> +
>>
>> Ah, MachineClass does not inherit from DeviceClass, so we can use
>> it to create GPIOs.
>>
>> Something is bugging me here, similar with the LEDs series I sent
>> recently.
>>
>> GPIOs are not specific to a bus. I see ResettableClass takes Object
>> arguments.
>>
>> We should be able to wire GPIO lines to generic Objects like LEDs.
>> Parents don't have to be qdev.
> 
> Yes, this is awkward. You pretty much have to inherit from
> SysBusDevice assuming you want to get reset (the few cases
> we have which directly inherit from Device like CPUs then
> end up needing special handling).
> 
>> Having to create a container to wire GPIOs or hold a reference
>> to a MemoryRegion sounds wrong.
> 
> I agree that it would be nicer if MachineState inherited from
> Device (and if Device got reset properly). But that's a huge
> amount of rework. For this series I'm just trying to improve
> the setup for the spitz board, and "logic that's more than
> just wiring up devices to each other needs to live inside some
> device, and can't be in the board itself" is the system we have today.

We have a large room for improvement :)

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

