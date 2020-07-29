Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA5B7C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 12:50:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86B9120829
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 12:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OS/lVwd9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86B9120829
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0lWx-0004zO-R7
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 08:49:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60270)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k0lWI-0004VA-Hq
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 08:49:18 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:40504)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k0lWG-0003vz-LI
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 08:49:18 -0400
Received: by mail-ed1-x544.google.com with SMTP id a14so327761edx.7
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2020 05:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=VbihS3H34PBIietZH1WSt5CYgOFNjyNwOvkOIzDR+yY=;
 b=OS/lVwd9Qm4/IDIvigvJJyj8XJHJ3776c3Q9GvRIv38n+mO9FTa9C7MHWjbGDgKu3y
 bgKZULDK184JwD1yrU61JY4MIeLmCtI9825HiWpNKJ9BVb4kGW+6rs6JsR4b8uWBMj5p
 czoK2ruXEO1qE2UrhgMMBtCQtbtEe6qIcYR4iwOFUOx+OI/rQ0JpLIoHdpTqRbQzCblV
 hkygRLtEeZtf7d8eCoIQi1mc8PjsGUbHWlLUqzLZ/xsfyuZvovm64VO3zNNjpEIBLmzD
 g5cCXmvRTcIn2Nt4D/STDpivM32X40extAa8Hv//wUIOjgrgVfnOPGbmkVdbU4fdQV3/
 n7tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VbihS3H34PBIietZH1WSt5CYgOFNjyNwOvkOIzDR+yY=;
 b=lkPRZlfM+azP9UDA6HY8bNpfbfa3yza8EBq/ZN2QhWGoR//3AVd7HlGHH1ejfD/KIA
 nyR93lbEA2oMp9dw8oZRhddc8MOX6IdTDBFLoGXC8i2KgFhynioamMyJ0+hkmfKrKJZj
 6bzQPmVmxcBbV0gv5C5QlJJ8f6CU8NyyfYEjpjVVzFyU9yM7tHmYfifgsLRwRoyJDnjM
 JrWAOE4cfiTJaSm1jUwH7n2P5Ek+vm4N10bfmrIzRhjlSXVoRnzCRKRNcdp3I68gRcCM
 uWds4LPvkN6zE48q+YQkFdpQ9JUuLgOv4hI2NDOg/Huk1G2grN8MznUbBRflUqszi1a7
 dfKg==
X-Gm-Message-State: AOAM530KIAtGr3nke83l362k/E0f8/EuJJp5g2NQ4KbZzkk3EUxRuO2x
 I0NZUl6ch9gejhvaVB/Pujw=
X-Google-Smtp-Source: ABdhPJwu99pb9gcmRxjlMsogsOaH4Jg59+Dg/tsFd7hwdpM2PEqvu8pucZKQxOgKsw+t062Keqq94A==
X-Received: by 2002:a50:cbc3:: with SMTP id l3mr22223613edi.58.1596026955232; 
 Wed, 29 Jul 2020 05:49:15 -0700 (PDT)
Received: from [192.168.1.39] (214.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.214])
 by smtp.gmail.com with ESMTPSA id e13sm1737645eds.46.2020.07.29.05.49.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jul 2020 05:49:14 -0700 (PDT)
Subject: Re: [PATCH-for-5.2 v4] hw/core/qdev: Increase qdev_realize() kindness
To: Markus Armbruster <armbru@redhat.com>
References: <20200727175112.6820-1-f4bug@amsat.org>
 <87d04gf5i4.fsf@dusky.pond.sub.org>
 <b5cd0d50-c0a6-afee-5b63-80bb83e7e001@redhat.com>
 <87r1suahxu.fsf@dusky.pond.sub.org>
 <a73edd14-ab57-0072-36cb-91222a9a1638@amsat.org>
 <87d04e7b94.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <7c44649f-ebd3-4f99-ce4c-a085bbe20ad5@amsat.org>
Date: Wed, 29 Jul 2020 14:49:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87d04e7b94.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::544;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x544.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/29/20 2:32 PM, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
> 
>> On 7/29/20 9:39 AM, Markus Armbruster wrote:
>>> Paolo Bonzini <pbonzini@redhat.com> writes:
>>>
>>>> On 28/07/20 09:44, Markus Armbruster wrote:
>>>>>> -        assert(!DEVICE_GET_CLASS(dev)->bus_type);
>>>>>> +    } else if (DEVICE_GET_CLASS(dev)->bus_type) {
>>>>>> +        error_setg(errp, "Unexpected bus '%s' for bus-less device '%s'",
>>>>>> +                   DEVICE_GET_CLASS(dev)->bus_type,
>>>>>> +                   object_get_typename(OBJECT(dev)));
>>>>>> +        return false;
>>>>>>      }
>>>>>>  
>>>>>>      object_property_set_bool(OBJECT(dev), true, "realized", &err);
>>>>> Objection.  This turns an abort into something else unless the caller
>>>>> passes &error_abort.  The caller in your commit message's example does,
>>>>> others don't.
>>>>>
>>>>> Keep the unconditional abort, please.  Feel free to print something kind
>>>>> right before.  I doubt it's all that useful, as I believe whoever gets
>>>>> to fix the bug will have to figure out the code anyway, but I could be
>>>>> wrong.
>>>>>
>>>>
>>>> This was my request, actually.  We have an Error**, we should use it in
>>>> case this code is reached via device_add.
>>>
>>> That's not actually possible.
>>
>> I agree this condition is not possible in current mainstream.
>>
>> What I'm working on is:
>>
>> qmp command that:
>> - create a SDCard or FloppyDisk medium
>> - eventually link a block driver to it
>> - insert the medium into a slot
>>
>> then another qmp command that
>> - eject the medium
>> - unlink the block driver
>> - destroy the medium
>>
>> second step is a command that takes as argument
>> (block driver, bus endpoint) and automatically
>> creates the envelope media and insert it to the bus.
> 
> If this makes the error possible, then your code fails to establish
> qdev_realize()'s precondition, and therefore needs fixing.

Yes, because I try to create a bus-ful device without plugging it on
the bus (I want to set the block driver link before plugging it).

> 
> Could a combination of existing commands get the job done?

Maybe. I'm trying a clean design. With the current state it is hard
to figure if my design is broken or the current QEMU design [*] is
broken and unfixable.

[*] keep re-using existing media device, add blockdrv, reset media
    device internals register depending of the blockdrv properties,
    eject blockdrv/insert different one and keep adapting the device.

