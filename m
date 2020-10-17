Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB47DC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 11:18:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FA76206DC
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 11:18:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FA76206DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTkEk-0006ch-5d
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 07:18:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40572)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kTkCp-0005j1-D2; Sat, 17 Oct 2020 07:16:59 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:58548
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kTkCn-000269-Cf; Sat, 17 Oct 2020 07:16:58 -0400
Received: from host86-148-246-80.range86-148.btcentralplus.com
 ([86.148.246.80] helo=[192.168.1.65])
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kTkCh-0003yq-TI; Sat, 17 Oct 2020 12:16:56 +0100
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 BALATON Zoltan <balaton@eik.bme.hu>
References: <20201016182739.22875-1-mark.cave-ayland@ilande.co.uk>
 <20201016182739.22875-5-mark.cave-ayland@ilande.co.uk>
 <653bf315-d1e4-4dc9-dac8-1e859a2ad4d1@eik.bme.hu>
 <8efee931-3314-7f3a-395b-3b840acdab90@amsat.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <2e5e164a-71b4-b587-4513-d3b56dd0fc49@ilande.co.uk>
Date: Sat, 17 Oct 2020 12:16:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <8efee931-3314-7f3a-395b-3b840acdab90@amsat.org>
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
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.253,
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

On 17/10/2020 10:45, Philippe Mathieu-Daudé wrote:

> On 10/16/20 10:38 PM, BALATON Zoltan via wrote:
>> On Fri, 16 Oct 2020, Mark Cave-Ayland wrote:
>>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>> ---
>>> hw/ppc/ppc405_boards.c | 10 +++++++++-
>>> 1 file changed, 9 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/ppc/ppc405_boards.c b/hw/ppc/ppc405_boards.c
>>> index 6198ec1035..4687715b15 100644
>>> --- a/hw/ppc/ppc405_boards.c
>>> +++ b/hw/ppc/ppc405_boards.c
>>> @@ -28,6 +28,8 @@
>>> #include "qemu-common.h"
>>> #include "cpu.h"
>>> #include "hw/ppc/ppc.h"
>>> +#include "hw/qdev-properties.h"
>>> +#include "hw/sysbus.h"
>>> #include "ppc405.h"
>>> #include "hw/rtc/m48t59.h"
>>> #include "hw/block/flash.h"
>>> @@ -145,6 +147,8 @@ static void ref405ep_init(MachineState *machine)
>>>     char *filename;
>>>     ppc4xx_bd_info_t bd;
>>>     CPUPPCState *env;
>>> +    DeviceState *dev;
>>> +    SysBusDevice *s;
>>>     qemu_irq *pic;
>>>     MemoryRegion *bios;
>>>     MemoryRegion *sram = g_new(MemoryRegion, 1);
>>> @@ -227,7 +231,11 @@ static void ref405ep_init(MachineState *machine)
>>>     /* Register FPGA */
>>>     ref405ep_fpga_init(sysmem, 0xF0300000);
>>>     /* Register NVRAM */
>>> -    m48t59_init(NULL, 0xF0000000, 0, 8192, 1968, 8);
>>> +    dev = qdev_new("sysbus-m48t08");
>>> +    qdev_prop_set_int32(dev, "base-year", 1968);
>>
>> Is there anything that uses other than 1968 as base year? If not this could be the 
>> default in the device so you don't need these set prop calls here and in sun machines.
>>
>> The only other place this device is used seems to be ppc/prep machine that uses the 
>> isa version but does not set a base year. Is that a bug? The original prep machine 
>> removed in b2ce76a0730 used 2000 but that's unlikely as well as these machines 
>> predate that.
> 
> =)

This is quite interesting, since if you look at prep.c you see that the machine has 
both a MC146818 RTC and a M48T59 RTC, and the NVRAM variables are stored in the 
M48T59. My guess is that a real 40p has a MC146818, but OHW only supported M48T59 and 
so it was only ever used to pass data from QEMU to OHW - the OS would use MC146818 
for the clock which has the base year set correctly.

>> Anyway, the sysbus and isa versions are different
> 
> They shouldn't, it is the same chipset, wired differently.
> 
>> so their default base-year could be set independently and then boards won't need to 
>> set this propery and may be could use qdev_create_simple instead or whatever that 
>> was renamed to.
> 
> Agreed.
> 
> Preferably following Zoltan's suggestion:
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

There is certainly some more untangling to be done here, but given my current backlog 
it is something that will need to wait until after 5.2.


ATB,

Mark.

