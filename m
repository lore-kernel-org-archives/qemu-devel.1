Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0542C433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 12:15:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4F4B20651
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 12:15:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4F4B20651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hx9EW-0001yF-2S
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 08:15:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40754)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hx9DM-0000GG-0M
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 08:14:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hx9DL-0000zf-1E
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 08:14:15 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51605)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hx9DK-0000zQ-RS
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 08:14:14 -0400
Received: by mail-wm1-f65.google.com with SMTP id 207so11951876wma.1
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2019 05:14:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IBLr+u7Omhe4cYbWFp9NEZ+Iwp7fVpbeVHlbGLeo4+Y=;
 b=SFrfXrZR6UIBldAXiqg922jamiwFn2PAYPqfgEWETtiFM5alVQP/wUSSRXb5e6XgzI
 dNPg6guj/dz8+demBgrOlm876bxPRIj9EEbSeNKIU2+K8dKjvOZ2SPYzyygctU1B79+7
 JveSpQMZ7onFy81VQv3RjORMXyPa1Qx+uXVVi13iYoQnuMcm7Yldmafc0nIPFYA+lZtw
 J3y17lUcBYsujZD+IOlDx1f+gqcSvWZLaBwMQTl5elfD7s+bTtR4goRQTBk69s3fQYMu
 B5sQ5etOaB6W2Zkwe5cdSS5MGSlVotXrhw0syBbC2atvHs6rbg2z7MZUiGVlK9GAko4h
 claQ==
X-Gm-Message-State: APjAAAUSxtATTiyzb2JuIJieFD0r4yzc8Ymrbj7Lt45Oej2nOILQP4wc
 iAyEoS8OzMKaL6puuZjiFhM+Yg==
X-Google-Smtp-Source: APXvYqyr9jzIu7DyUbQgpS66itT5u2EGncDwNJ6uUgp1SDnDV2h5xDvn/nzVt84XpS8zAuOwZd7cdw==
X-Received: by 2002:a1c:2582:: with SMTP id
 l124mr29082968wml.153.1565612053827; 
 Mon, 12 Aug 2019 05:14:13 -0700 (PDT)
Received: from [192.168.1.37] (225.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.225])
 by smtp.gmail.com with ESMTPSA id j16sm60733178wrp.62.2019.08.12.05.14.12
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 12 Aug 2019 05:14:12 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190701123108.12493-1-philmd@redhat.com>
 <20190701123108.12493-4-philmd@redhat.com>
 <CAFEAcA_m3LiLQqL8y6rT=HGeoa7B5XAQH9Wuo=Hg-94PaV3Zsg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <b2a83b98-3e20-4f62-d442-6ab6e26ab60b@redhat.com>
Date: Mon, 12 Aug 2019 14:14:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_m3LiLQqL8y6rT=HGeoa7B5XAQH9Wuo=Hg-94PaV3Zsg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH 3/6] hw/arm: Use sysbus_init_child_obj for
 correct reference counting
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
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, Jason Wang <jasowang@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Peter Chubb <peter.chubb@nicta.com.au>,
 Antony Pavlov <antonynpavlov@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/29/19 3:03 PM, Peter Maydell wrote:
> On Mon, 1 Jul 2019 at 13:31, Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
>>
>> As explained in commit aff39be0ed97:
>>
>>   Both functions, object_initialize() and object_property_add_child()
>>   increase the reference counter of the new object, so one of the
>>   references has to be dropped afterwards to get the reference
>>   counting right. Otherwise the child object will not be properly
>>   cleaned up when the parent gets destroyed.
>>   Thus let's use now object_initialize_child() instead to get the
>>   reference counting here right.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  hw/arm/exynos4_boards.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/arm/exynos4_boards.c b/hw/arm/exynos4_boards.c
>> index ac0b0dc2a9..5dd53d2a23 100644
>> --- a/hw/arm/exynos4_boards.c
>> +++ b/hw/arm/exynos4_boards.c
>> @@ -129,8 +129,8 @@ exynos4_boards_init_common(MachineState *machine,
>>      exynos4_boards_init_ram(s, get_system_memory(),
>>                              exynos4_board_ram_size[board_type]);
>>
>> -    object_initialize(&s->soc, sizeof(s->soc), TYPE_EXYNOS4210_SOC);
>> -    qdev_set_parent_bus(DEVICE(&s->soc), sysbus_get_default());
>> +    sysbus_init_child_obj(OBJECT(machine), "soc",
>> +                          &s->soc, sizeof(s->soc), TYPE_EXYNOS4210_SOC);
>>      object_property_set_bool(OBJECT(&s->soc), true, "realized",
>>                               &error_fatal);
> 
> I suspect the code change here is correct but it doesn't seem
> to match the commit message -- the old code is not calling
> object_property_add_child() at all, and the new code does not
> call object_initialize_child()...

OK, will improve, thanks!

