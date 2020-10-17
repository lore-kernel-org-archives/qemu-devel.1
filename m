Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7859BC433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 11:54:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D36C820709
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 11:54:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D36C820709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTkn1-0001oG-Ub
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 07:54:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45074)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kTkmC-0001BO-Pm; Sat, 17 Oct 2020 07:53:32 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:58626
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kTkmA-00060f-J5; Sat, 17 Oct 2020 07:53:32 -0400
Received: from host86-148-246-80.range86-148.btcentralplus.com
 ([86.148.246.80] helo=[192.168.1.65])
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kTkm0-0004Gf-3C; Sat, 17 Oct 2020 12:53:26 +0100
To: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20201016182739.22875-1-mark.cave-ayland@ilande.co.uk>
 <20201016182739.22875-5-mark.cave-ayland@ilande.co.uk>
 <653bf315-d1e4-4dc9-dac8-1e859a2ad4d1@eik.bme.hu>
 <8efee931-3314-7f3a-395b-3b840acdab90@amsat.org>
 <75bb5535-62b9-12e1-b6bb-ce15265ca7eb@eik.bme.hu>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <9c3a17fd-0b57-4008-2088-4578a2097454@ilande.co.uk>
Date: Sat, 17 Oct 2020 12:53:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <75bb5535-62b9-12e1-b6bb-ce15265ca7eb@eik.bme.hu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.148.246.80
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 4/5] ppc405_boards: use qdev properties instead of legacy
 m48t59_init() function
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk;
 helo=mail.default.ilande.uk0.bigv.io
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.247,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 hpoussin@reactos.org, atar4qemu@gmail.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/10/2020 11:44, BALATON Zoltan via wrote:

> On Sat, 17 Oct 2020, Philippe Mathieu-Daudé wrote:
>> On 10/16/20 10:38 PM, BALATON Zoltan via wrote:
>>> On Fri, 16 Oct 2020, Mark Cave-Ayland wrote:
>>>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>>> ---
>>>> hw/ppc/ppc405_boards.c | 10 +++++++++-
>>>> 1 file changed, 9 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/hw/ppc/ppc405_boards.c b/hw/ppc/ppc405_boards.c
>>>> index 6198ec1035..4687715b15 100644
>>>> --- a/hw/ppc/ppc405_boards.c
>>>> +++ b/hw/ppc/ppc405_boards.c
>>>> @@ -28,6 +28,8 @@
>>>> #include "qemu-common.h"
>>>> #include "cpu.h"
>>>> #include "hw/ppc/ppc.h"
>>>> +#include "hw/qdev-properties.h"
>>>> +#include "hw/sysbus.h"
>>>> #include "ppc405.h"
>>>> #include "hw/rtc/m48t59.h"
>>>> #include "hw/block/flash.h"
>>>> @@ -145,6 +147,8 @@ static void ref405ep_init(MachineState *machine)
>>>>     char *filename;
>>>>     ppc4xx_bd_info_t bd;
>>>>     CPUPPCState *env;
>>>> +    DeviceState *dev;
>>>> +    SysBusDevice *s;
>>>>     qemu_irq *pic;
>>>>     MemoryRegion *bios;
>>>>     MemoryRegion *sram = g_new(MemoryRegion, 1);
>>>> @@ -227,7 +231,11 @@ static void ref405ep_init(MachineState *machine)
>>>>     /* Register FPGA */
>>>>     ref405ep_fpga_init(sysmem, 0xF0300000);
>>>>     /* Register NVRAM */
>>>> -    m48t59_init(NULL, 0xF0000000, 0, 8192, 1968, 8);
>>>> +    dev = qdev_new("sysbus-m48t08");
>>>> +    qdev_prop_set_int32(dev, "base-year", 1968);
>>>
>>> Is there anything that uses other than 1968 as base year? If not this could be the 
>>> default in the device so you don't need these set prop calls here and in sun 
>>> machines.
>>>
>>> The only other place this device is used seems to be ppc/prep machine that uses 
>>> the isa version but does not set a base year. Is that a bug? The original prep 
>>> machine removed in b2ce76a0730 used 2000 but that's unlikely as well as these 
>>> machines predate that.
>>
>> =)
>>
>>> Anyway, the sysbus and isa versions are different
>>
>> They shouldn't, it is the same chipset, wired differently.
> 
> I mean in QEMU the sysbus and isa devices are different object types so their default 
> is settable independently. So setting the sysbus device base-year does not change the 
> isa device which can be sorted out in another patch independently from this series 
> later when the behaviour on 40p is confirmed.

Right, there are certainly some questions around exactly how this behaviour works but 
in general people seem happy with this series. I'm going to apply this to my 
qemu-macppc branch with the NVRAM cast suggested by Philippe so the basic conversion 
is done, and then other improvements/tidy-ups can follow up later as time allows.


ATB,

Mark.

