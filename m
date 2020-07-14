Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66991C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 17:12:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F27B22596
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 17:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cjGGb9D9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F27B22596
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvOTL-00085C-Ej
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 13:12:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57464)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jvOSV-0007QL-1m; Tue, 14 Jul 2020 13:11:11 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:37997)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jvOSS-0003Oj-Od; Tue, 14 Jul 2020 13:11:10 -0400
Received: by mail-wr1-x443.google.com with SMTP id z13so23208197wrw.5;
 Tue, 14 Jul 2020 10:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=SGh41sP+ng8YW5CRVmuH9/ipR/ed1r8PqiQRoixxRg0=;
 b=cjGGb9D9EItNuycmzLU5xt0SYz1gBg4HvmVkh7BenKJwNLSh/9YjbbJPusLzivZd+3
 yEQj13fHMYC4d6oDWs/k0WEvPhYsQpn8p1rpN2O1kPfds6zCYTB7m9lqL/utWArPlyg+
 HSPGtsu9Hfv+CLc0vMMMeInofuc+TYmmord7ZkGV0EWtLVidFEO88EUAnUUpt0wxcOuM
 x6J9dOr/CbuG/XhEfI2NZ8/awooLha/F6YNji/xltAiK/l2fbf3an2xC+g6xxzCQwk36
 rQoHQymdFF0/w4eC4qqRgzWSijo0uxkD9CWWLf4KBHuYbTNgXgTLa3jCPg+TrTKB8r/+
 wgHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SGh41sP+ng8YW5CRVmuH9/ipR/ed1r8PqiQRoixxRg0=;
 b=eldnpNU4nbvKqeu1QYsh8/DZQ2KxDvYETOfz6c9X8mb1fV7jhGd1GTinzxuvL8iYWz
 5/XYzJfdyV5lx/alZKVi8fzbe5SDDcMNk/Zcl4eGRvTqZQlLfDU1qx58zpBOC0oCj8mP
 YUDGuZhbq094qtz+FXEPI3t8n+NQGbvDzHy+vfuURtjLNxawTW7EVJxfHeTcaRDFpKdE
 6JxxMu+ikFK9mv/8VB3G0pO1oct1wPOLChDJi53erbtQ0TrncwQuZAZOZcZxz3DoJqYH
 dbIS8oCwjy33BrIB7RdX6s1ePow2Oyk14kUgsh2yIev0MTTu3pXZrk+RqGE4fLyeIcbk
 /lyA==
X-Gm-Message-State: AOAM533aXZnnHvdZBTRI7le5zUsTl0BhgSNVUwbLQELWNPUyJG3EuFfr
 nMolFZKetvYZgvED2Ci6KJI=
X-Google-Smtp-Source: ABdhPJym6D9lXW98iv65vCads7SK5YXE1VJslIh7RiLNjAtLd2O8bfAJ5gFg1xqofgNjs/3teDmwVw==
X-Received: by 2002:adf:a3d0:: with SMTP id m16mr6684856wrb.232.1594746666528; 
 Tue, 14 Jul 2020 10:11:06 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id j6sm30661417wro.25.2020.07.14.10.11.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2020 10:11:05 -0700 (PDT)
Subject: Re: [PATCH v5 04/11] hw/arm: Add NPCM730 and NPCM750 SoC models
To: Markus Armbruster <armbru@redhat.com>
References: <20200709003608.3834629-1-hskinnemoen@google.com>
 <20200709003608.3834629-5-hskinnemoen@google.com>
 <3ec30463-03f8-98e9-9a14-01b0bb698c9b@kaod.org>
 <CAFQmdRYQxMz_qSr4i_cyqRPEGuq7At=VEOGvsupR3=W7pE3q=g@mail.gmail.com>
 <7c978e82-8890-9ba4-096a-92d7cff60b0a@amsat.org>
 <877dv63x2e.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <11c410d4-b310-faf1-5116-2ab62270c3cb@amsat.org>
Date: Tue, 14 Jul 2020 19:11:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <877dv63x2e.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>,
 Havard Skinnemoen <hskinnemoen@google.com>,
 QEMU Developers <qemu-devel@nongnu.org>, CS20 KFTing <kfting@nuvoton.com>,
 qemu-arm <qemu-arm@nongnu.org>, IS20 Avi Fishman <Avi.Fishman@nuvoton.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/14/20 6:01 PM, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
> 
>> +Markus
>>
>> On 7/14/20 2:44 AM, Havard Skinnemoen wrote:
>>> On Mon, Jul 13, 2020 at 8:02 AM Cédric Le Goater <clg@kaod.org> wrote:
>>>>
>>>> On 7/9/20 2:36 AM, Havard Skinnemoen wrote:
>>>>> The Nuvoton NPCM7xx SoC family are used to implement Baseboard
>>>>> Management Controllers in servers. While the family includes four SoCs,
>>>>> this patch implements limited support for two of them: NPCM730 (targeted
>>>>> for Data Center applications) and NPCM750 (targeted for Enterprise
>>>>> applications).
>>>>>
>>>>> This patch includes little more than the bare minimum needed to boot a
>>>>> Linux kernel built with NPCM7xx support in direct-kernel mode:
>>>>>
>>>>>   - Two Cortex-A9 CPU cores with built-in periperhals.
>>>>>   - Global Configuration Registers.
>>>>>   - Clock Management.
>>>>>   - 3 Timer Modules with 5 timers each.
>>>>>   - 4 serial ports.
>>>>>
>>>>> The chips themselves have a lot more features, some of which will be
>>>>> added to the model at a later stage.
>>>>>
>>>>> Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
>>>>> Reviewed-by: Joel Stanley <joel@jms.id.au>
>>>>> Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
>>>>> ---
>> ...
>>
>>>>> +static void npcm7xx_realize(DeviceState *dev, Error **errp)
>>>>> +{
>>>>> +    NPCM7xxState *s = NPCM7XX(dev);
>>>>> +    NPCM7xxClass *nc = NPCM7XX_GET_CLASS(s);
>>>>> +    int i;
>>>>> +
>>>>> +    /* CPUs */
>>>>> +    for (i = 0; i < nc->num_cpus; i++) {
>>>>> +        object_property_set_int(OBJECT(&s->cpu[i]),
>>>>> +                                arm_cpu_mp_affinity(i, NPCM7XX_MAX_NUM_CPUS),
>>>>> +                                "mp-affinity", &error_abort);
>>>>> +        object_property_set_int(OBJECT(&s->cpu[i]), NPCM7XX_GIC_CPU_IF_ADDR,
>>>>> +                                "reset-cbar", &error_abort);
>>>>> +        object_property_set_bool(OBJECT(&s->cpu[i]), true,
>>>>> +                                 "reset-hivecs", &error_abort);
>>>>> +
>>>>> +        /* Disable security extensions. */
>>>>> +        object_property_set_bool(OBJECT(&s->cpu[i]), false, "has_el3",
>>>>> +                                 &error_abort);
>>>>> +
>>>>> +        qdev_realize(DEVICE(&s->cpu[i]), NULL, &error_abort);
>>>>
>>>> I would check the error:
>>>>
>>>>         if (!qdev_realize(DEVICE(&s->cpu[i]), NULL, errp)) {
>>>>             return;
>>>>         }
>>>>
>>>> same for the sysbus_realize() below.
>>>
>>> Hmm, I used to propagate these errors until Philippe told me not to
>>> (or at least that's how I understood it).
>>
>> It was before Markus simplification API were merged, you had to
>> propagate after each call, since this is a non hot-pluggable SoC
>> I suggested to use &error_abort to simplify.
>>
>>> I'll be happy to do it
>>> either way (and the new API makes it really easy to propagate errors),
>>> but I worry that I don't fully understand when to propagate errors and
>>> when not to.
>>
>> Markus explained it on the mailing list recently (as I found the doc
>> not obvious). I can't find the thread. I suppose once the work result
>> after the "Questionable aspects of QEMU Error's design" discussion is
>> merged, the documentation will be clarified.
> 
> The Error API evolved recently.  Please peruse the big comment in
> include/qapi/error.h.  If still unsure, don't hesitate to ask here.
> 
>> My rule of thumb so far is:
>> - programming error (can't happen) -> &error_abort
> 
> Correct.  Quote the big comment:
> 
>  * Call a function aborting on errors:
>  *     foo(arg, &error_abort);
>  * This is more concise and fails more nicely than
>  *     Error *err = NULL;
>  *     foo(arg, &err);
>  *     assert(!err); // don't do this
> 
>> - everything triggerable by user or management layer (via QMP command)
>>   -> &error_fatal, as we can't risk loose the user data, we need to
>>   shutdown gracefully.
> 
> Quote the big comment:
> 
>  * Call a function treating errors as fatal:
>  *     foo(arg, &error_fatal);
>  * This is more concise than
>  *     Error *err = NULL;
>  *     foo(arg, &err);
>  *     if (err) { // don't do this
>  *         error_report_err(err);
>  *         exit(1);
>  *     }
> 
> Terminating the process is generally fine during initial startup,
> i.e. before the guest runs.
> 
> It's generally not fine once the guest runs.  Errors need to be handled
> more gracefully then.  A QMP command, for instance, should fail cleanly,
> propagating the error to the monitor core, which then sends it to the
> QMP client, and loops to process the next command.
> 
>>> It makes sense to me to propagate errors from *_realize() and
>>> error_abort on failure to set simple properties, but I'd like to know
>>> if Philippe is on board with that.
> 
> Realize methods must not use &error_fatal.  Instead, they should clean
> up and fail.
> 
> "Clean up" is the part we often neglect.  The big advantage of
> &error_fatal is that you don't have to bother :)
> 
> Questions?

One on my side. So in this realize(), all &error_abort uses has
to be replaced by local_err + propagate ...:

static void npcm7xx_realize(DeviceState *dev, Error **errp)
{
    NPCM7xxState *s = NPCM7XX(dev);
    NPCM7xxClass *nc = NPCM7XX_GET_CLASS(s);
    int i;

    /* CPUs */
    for (i = 0; i < nc->num_cpus; i++) {
        object_property_set_int(OBJECT(&s->cpu[i]),
                                arm_cpu_mp_affinity(i,
NPCM7XX_MAX_NUM_CPUS),
                                "mp-affinity", &error_abort);
        object_property_set_int(OBJECT(&s->cpu[i]), NPCM7XX_GIC_CPU_IF_ADDR,
                                "reset-cbar", &error_abort);
        object_property_set_bool(OBJECT(&s->cpu[i]), true,
                                 "reset-hivecs", &error_abort);

        /* Disable security extensions. */
        object_property_set_bool(OBJECT(&s->cpu[i]), false, "has_el3",
                                 &error_abort);

        qdev_realize(DEVICE(&s->cpu[i]), NULL, &error_abort);
    }
    [...]

... but the caller does:

static void quanta_gsj_init(MachineState *machine)
{
    NPCM7xxState *soc;

    soc = npcm7xx_create_soc(machine, QUANTA_GSJ_POWER_ON_STRAPS);
    npcm7xx_connect_dram(soc, machine->ram);
    qdev_realize(DEVICE(soc), NULL, &error_abort);
                                    ^^^^^^^^^^^^
    npcm7xx_load_kernel(machine, soc);
}

So we overload the code...

My question: Do you confirm this is worth it to propagate?

