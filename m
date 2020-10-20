Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F885C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 16:42:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3B87206CA
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 16:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IKOi/Juk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3B87206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUuiq-0005Sz-Gw
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 12:42:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40528)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kUuA9-0000Rh-Vd
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 12:07:03 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:45288)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kUuA8-0005AL-7V
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 12:07:01 -0400
Received: by mail-wr1-x433.google.com with SMTP id e17so2817498wru.12
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 09:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=i8dOoW67H69larNHu7+gQloV30DLXkwHYbS9MoVC/eY=;
 b=IKOi/Juk3+bA3deXidkevKriZx8NoTYzXH/v+h003uw2GCxv+7XRSypWO8ceQggtXh
 BgbUhF6bPvcvSffwVb/Ee5Zx8+Tr4wsBDVGDPhyaWSB3PPLdGoObNYugqMbhJDjbKW8j
 I2Rjy5+Oi35/P42Em3rhvo5Ykw7g8TPED4/IcDmf7nvK2InU2I6/ax65fqM9r8Dx6dvU
 BgZjPJOsQOSRbJUtHjSpWzG4bWgRtO7/eAyNaK6OKhreuD7dImI32RvZ4E1qvW6o92Bz
 s8yBwIIY7f4aws3tpStU4iZQ3YrYzWLu/s5RbvqCD+4uvcyIMeIDwYiyzjsc1N5RssZp
 OYXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:from:to:cc:references:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=i8dOoW67H69larNHu7+gQloV30DLXkwHYbS9MoVC/eY=;
 b=PSGeXMu3X9BN+hb4HbYp3Bnx6ssWvKSCMkDIrK8urU9ewUjHGllAYaWu4XDigMYhJp
 vB4FdJFZMw5/+DZ+bEzeEw9DnjbtIt8kHatihgoEMLbQckeSu5/mGktiEIKPqeQswwMq
 g6qtF5lmaWzkBuR6TtVzOcOyQhZd6wU31auEAgERBdeX7f6DpDW2blX9ypZ3ZORKb9RQ
 Qts3bo1qbfrs7GlWv2ezVEA5rQ94VZTcuvRh77jZE5nkYOT8hgPNNiyrVk63shcha8eG
 NO4ECmQNhouPNkcL2siVSh+1lDAfhNOoF5dgxAPpgLU7/gimbXy61FKWFquh/kJL15Xv
 rWOQ==
X-Gm-Message-State: AOAM532TYB2E0rkWQLL3d0o5+M4XT71tTGB/yI+vvmr/ZcIzoJ/bwGOF
 QbUhIaG+VaUX1nNGHE+vEwE=
X-Google-Smtp-Source: ABdhPJxsfu1G4NvbdN0MIVRq4zfdFQvrhsSJiwcSCaLy8rYuRjUj3YMnlVs6YkABjAR7HWP655oYGg==
X-Received: by 2002:a5d:44cb:: with SMTP id z11mr4240135wrr.290.1603210017844; 
 Tue, 20 Oct 2020 09:06:57 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id j9sm3682910wrp.59.2020.10.20.09.06.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2020 09:06:57 -0700 (PDT)
Subject: Re: [PULL 09/31] hw/core/clock: introduce clock object
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Damien Hedde <damien.hedde@greensocs.com>
References: <20200430115142.13430-1-peter.maydell@linaro.org>
 <20200430115142.13430-10-peter.maydell@linaro.org>
 <f295c99f-0405-1c26-6f58-12abdec8bd3d@amsat.org>
Message-ID: <9fc9b0cf-4919-40b5-0430-cfac6fd7bbef@amsat.org>
Date: Tue, 20 Oct 2020 18:06:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <f295c99f-0405-1c26-6f58-12abdec8bd3d@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x433.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/17/20 1:47 PM, Philippe Mathieu-Daudé wrote:
> Hi Damien, Peter,
> 
> On 4/30/20 1:51 PM, Peter Maydell wrote:
>> This object may be used to represent a clock inside a clock tree.
>>
>> A clock may be connected to another clock so that it receives update,
>> through a callback, whenever the source/parent clock is updated.
>>
>> Although only the root clock of a clock tree controls the values
>> (represented as periods) of all clocks in tree, each clock holds
>> a local state containing the current value so that it can be fetched
>> independently. It will allows us to fullfill migration requirements
>> by migrating each clock independently of others.
>>
>> This is based on the original work of Frederic Konrad.
>>
>> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
>> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>> Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
>> Message-id: 20200406135251.157596-2-damien.hedde@greensocs.com
>> [PMM: Use uint64_t rather than unsigned long long in trace events;
>>   the dtrace backend can't handle the latter]
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>   hw/core/Makefile.objs |   1 +
>>   include/hw/clock.h    | 216 ++++++++++++++++++++++++++++++++++++++++++
>>   hw/core/clock.c       | 130 +++++++++++++++++++++++++
>>   hw/core/trace-events  |   7 ++
>>   4 files changed, 354 insertions(+)
>>   create mode 100644 include/hw/clock.h
>>   create mode 100644 hw/core/clock.c
>>
>> diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
>> index 6215e7c2085..1d9b0aa2057 100644
>> --- a/hw/core/Makefile.objs
>> +++ b/hw/core/Makefile.objs
>> @@ -7,6 +7,7 @@ common-obj-y += hotplug.o
>>   common-obj-y += vmstate-if.o
>>   # irq.o needed for qdev GPIO handling:
>>   common-obj-y += irq.o
>> +common-obj-y += clock.o
>>   common-obj-$(CONFIG_SOFTMMU) += reset.o
>>   common-obj-$(CONFIG_SOFTMMU) += qdev-fw.o
>> diff --git a/include/hw/clock.h b/include/hw/clock.h
>> new file mode 100644
>> index 00000000000..82a7f3c6982
>> --- /dev/null
>> +++ b/include/hw/clock.h
>> @@ -0,0 +1,216 @@
>> +/*
>> + * Hardware Clocks
>> + *
>> + * Copyright GreenSocs 2016-2020
>> + *
>> + * Authors:
>> + *  Frederic Konrad
>> + *  Damien Hedde
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or 
>> later.
>> + * See the COPYING file in the top-level directory.
>> + */
>> +
>> +#ifndef QEMU_HW_CLOCK_H
>> +#define QEMU_HW_CLOCK_H
>> +
>> +#include "qom/object.h"
>> +#include "qemu/queue.h"
>> +
>> +#define TYPE_CLOCK "clock"
>> +#define CLOCK(obj) OBJECT_CHECK(Clock, (obj), TYPE_CLOCK)
>> +
>> +typedef void ClockCallback(void *opaque);
>> +
>> +/*
>> + * clock store a value representing the clock's period in 2^-32ns unit.
>> + * It can represent:
>> + *  + periods from 2^-32ns up to 4seconds
>> + *  + frequency from ~0.25Hz 2e10Ghz
>> + * Resolution of frequency representation decreases with frequency:
>> + * + at 100MHz, resolution is ~2mHz
>> + * + at 1Ghz,   resolution is ~0.2Hz
>> + * + at 10Ghz,  resolution is ~20Hz
>> + */
>> +#define CLOCK_SECOND (1000000000llu << 32)
>> +
>> +/*
>> + * macro helpers to convert to hertz / nanosecond
>> + */
>> +#define CLOCK_PERIOD_FROM_NS(ns) ((ns) * (CLOCK_SECOND / 1000000000llu))
>> +#define CLOCK_PERIOD_TO_NS(per) ((per) / (CLOCK_SECOND / 1000000000llu))
>> +#define CLOCK_PERIOD_FROM_HZ(hz) (((hz) != 0) ? CLOCK_SECOND / (hz) : 
>> 0u)
> 
> I'm having Floating Point Exception using a frequency of 1GHz.
> 
> Using frequency >=1GHz we have CLOCK_PERIOD_FROM_HZ(hz) > 0x100000000.
> 
> Then CLOCK_PERIOD_TO_NS(0x100000000) = 0.
> 
> So for frequency >=1GHz clock_get_ns() returns 0.

So Peter suggested on IRC to rewrite the code consuming this API
to avoid reaching this limit :)

Still some assert would help other developers triggering the same
issue to quicker figure how to bypass the problem.

> 
>> +#define CLOCK_PERIOD_TO_HZ(per) (((per) != 0) ? CLOCK_SECOND / (per) 
>> : 0u)
>> +
> [...]
> 

