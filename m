Return-Path: <SRS0=Dt9u=7G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 368E3C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 20:22:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF2092076C
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 20:22:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B8PyLvDt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF2092076C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcx8g-0001Ew-5K
	for qemu-devel@archiver.kernel.org; Sun, 24 May 2020 16:22:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41902)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jcx87-0000oa-T6
 for qemu-devel@nongnu.org; Sun, 24 May 2020 16:21:55 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:44844)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jcx86-0008OM-Gg
 for qemu-devel@nongnu.org; Sun, 24 May 2020 16:21:55 -0400
Received: by mail-wr1-x441.google.com with SMTP id y17so6945842wrn.11
 for <qemu-devel@nongnu.org>; Sun, 24 May 2020 13:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=GOUPImajdqNIRuS0B7tP+AcEbSwX7Hzj3sgFwj594JU=;
 b=B8PyLvDtRUyIeB4umyYOSznSH6hgEVA364CIEhz/WDzFpYl2aP5UAVPWlm3ityM9J1
 TTpzFtuep/+KiLK1I77ex4J6vVWtC1ckUZJ3upynXsnZlS/1pIhskXU8RT0JXYq7kh1p
 smC6aWX3+Obhr5VL3FTz/8vvE7w2ZzjcmFNBgbL1b2LrHoolrnZJYy5LG+EAr/5Gb5/o
 +aHCi8iTHLiZ8O6OVSHDrq0Wfp0o7dNQS+GYdLj80EXgrFj1OUjm7i5tRXA66HJRsDMd
 4ja7EmkzEybwZkvaJl4omexwmEtyvIaayqHug48FDYtDqYDO5NOLZ9gAldRl+np91avh
 d0sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GOUPImajdqNIRuS0B7tP+AcEbSwX7Hzj3sgFwj594JU=;
 b=VCGglc8h/M0jk1q34j991YCaUtTPwe0/h49wcz3O/wVYDjklMuGH6Lo5GtC/LJWp+C
 qLu3n6NMqLX7pb4S4goHy4aleVWaGPWGM1tvtbb9t4etYRRkepAlzBa/1DodRAuFs53B
 iQfsEalwJ2eW1uV3MazpNXH/mamhLVCchtYCx5YhZ7RH7v36gW5z50MrySNt5gmFDO+i
 BuM+gGQGB25OwjZI0jlEY8AQuU1+fh8LCHZE1S8OcTa6j/qG8RsEg2/2FEsNjamz9IUv
 wcSTrDygOJjTinTaWg/pUNrEfentUkU9NNtL+hacgEgFoUiwhBjlT9ldVT1AtghBOaB8
 1Gfg==
X-Gm-Message-State: AOAM5304WSMk+M7LACPhPbcpQPN6ZqxP0FRhC+Vlj/dknls7uuz7D4b0
 ESqFW1TMJd93Ctw95LzWN8M=
X-Google-Smtp-Source: ABdhPJxCSTevDBefaySczmPCJqlGgfYxPKOXJQEV63QOWg31RddIUhe1vO9Z18EvIT4cmn11SpooYA==
X-Received: by 2002:a5d:4b88:: with SMTP id b8mr12321495wrt.341.1590351712761; 
 Sun, 24 May 2020 13:21:52 -0700 (PDT)
Received: from [192.168.1.36] (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id p23sm15910234wma.17.2020.05.24.13.21.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 24 May 2020 13:21:51 -0700 (PDT)
Subject: Re: [PATCH 0/7] hw/misc/empty_slot: Spring cleaning
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
References: <20200510152840.13558-1-f4bug@amsat.org>
 <2906ea36-d6c4-f05b-3242-d9380986d48c@redhat.com>
 <CAHiYmc7Jwbvhapj9tXv=2=6ydD9mB=tm6O4SOUameWkRQGE1Qg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <78738412-c682-6079-5238-88d96339235c@amsat.org>
Date: Sun, 24 May 2020 22:21:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAHiYmc7Jwbvhapj9tXv=2=6ydD9mB=tm6O4SOUameWkRQGE1Qg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/24/20 9:37 PM, Aleksandar Markovic wrote:
> нед, 24. мај 2020. у 18:58 Philippe Mathieu-Daudé <philmd@redhat.com>
> је написао/ла:
>>
>> ping?
>>
> 
> I agree with all of your patches, they absolutely make sense to me,
> but I would like to know Peter's opinion on such treatment of empty
> slots.
> 
> I am going to give r-bs and integrate mips patches as soon as Peter
> OKs the general approach. So, Peter, is Philippe's approach to empty
> slots fine?

Thanks Aleksandar for looking at this series.

I expect a neutral opinion from Peter.

What would be helpful is feedback from Artyom, since it authored this
device.

Artyom, do you mind Acking the series?

Thanks,

Phil.

> 
> Aleksandar
> 
>> On 5/10/20 5:28 PM, Philippe Mathieu-Daudé wrote:
>>> New Spring, new opportunity to clean this device :)
>>> (v1 was in 2018, v2 in 2019).
>>>
>>> - lower device priority
>>> - follow qdev model and use properties
>>> - convert to trace events
>>> - describe with slot name
>>> - move under hw/misc/ and cover in MAINTAINERS
>>>
>>> Peter, I hope you are OK adding it wit UNIMP device,
>>> as both are very similar, and don't have much activity.
>>>
>>> Only MIPS/SPARC32 targets use this device.
>>>
>>> v2: https://www.mail-archive.com/qemu-devel@nongnu.org/msg626498.html
>>> v1: https://www.mail-archive.com/qemu-devel@nongnu.org/msg564060.html
>>>
>>> Philippe Mathieu-Daudé (7):
>>>   hw/sparc/sun4m: Use UnimplementedDevice for I/O devices
>>>   hw/misc/empty_slot: Lower address space priority
>>>   hw/misc/empty_slot: Convert 'size' field as qdev property
>>>   hw/misc/empty_slot: Add a 'name' qdev property
>>>   hw/misc/empty_slot: Convert debug printf() to trace event
>>>   hw/misc/empty_slot: Move the 'hw/misc' and cover in MAINTAINERS
>>>   hw/misc/empty_slot: Name the slots when created
>>>
>>>  include/hw/empty_slot.h        |  9 -------
>>>  include/hw/misc/empty_slot.h   | 19 ++++++++++++++
>>>  hw/mips/mips_malta.c           |  4 +--
>>>  hw/{core => misc}/empty_slot.c | 47 +++++++++++++++++++---------------
>>>  hw/sparc/sun4m.c               | 23 +++++++++++------
>>>  MAINTAINERS                    |  4 ++-
>>>  hw/core/Makefile.objs          |  1 -
>>>  hw/misc/Makefile.objs          |  1 +
>>>  hw/misc/trace-events           |  4 +++
>>>  9 files changed, 70 insertions(+), 42 deletions(-)
>>>  delete mode 100644 include/hw/empty_slot.h
>>>  create mode 100644 include/hw/misc/empty_slot.h
>>>  rename hw/{core => misc}/empty_slot.c (66%)
>>>
>>
> 


