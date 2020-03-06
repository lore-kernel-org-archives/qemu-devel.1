Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E08B8C3F2D2
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 00:51:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B57492073B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 00:51:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B57492073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jA1DU-0007DH-SF
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 19:51:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52685)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1jA1Cv-0006le-LD
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 19:51:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pannengyuan@huawei.com>) id 1jA1Cu-0003PI-0K
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 19:51:17 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:3184 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pannengyuan@huawei.com>)
 id 1jA1Ct-0003G5-LS; Thu, 05 Mar 2020 19:51:15 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 34834DF8D2AF9EF126E8;
 Fri,  6 Mar 2020 08:51:09 +0800 (CST)
Received: from [10.184.39.213] (10.184.39.213) by smtp.huawei.com
 (10.3.19.208) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 6 Mar 2020
 08:51:01 +0800
Subject: Re: [PATCH v4 3/3] hw/misc/mos6522: move timer_new from init() into
 realize() to avoid memleaks
To: David Gibson <david@gibson.dropbear.id.au>
References: <20200305065422.12707-1-pannengyuan@huawei.com>
 <20200305065422.12707-4-pannengyuan@huawei.com>
 <20200305225652.GA617846@umbus.fritz.box>
From: Pan Nengyuan <pannengyuan@huawei.com>
Message-ID: <c19858e4-5207-65a3-0037-f6fcaebdd745@huawei.com>
Date: Fri, 6 Mar 2020 08:50:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200305225652.GA617846@umbus.fritz.box>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.39.213]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.190
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
Cc: peter.maydell@linaro.org, zhang.zhanghailiang@huawei.com,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 euler.robot@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 3/6/2020 6:56 AM, David Gibson wrote:
> On Thu, Mar 05, 2020 at 02:54:22PM +0800, Pan Nengyuan wrote:
>> There are some memleaks when we call 'device_list_properties'. This patch move timer_new from init into realize to fix it.
>>
>> Reported-by: Euler Robot <euler.robot@huawei.com>
>> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
> 
> Applied to ppc-for-5.0.

Thanks.

And this patch depend to another fix (patch2/3: https://patchwork.kernel.org/patch/11421229/). Otherwise, it'll be invalid for this move.
I forgot cc it to you, but I think it should let you known.

> 
> Probably the memory region stuff should be in realize() rather than
> init() as well, but that can be fixed later.
> 
>> ---
>> Cc: Laurent Vivier <laurent@vivier.eu>
>> Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> Cc: David Gibson <david@gibson.dropbear.id.au>
>> Cc: qemu-ppc@nongnu.org
>> ---
>> v2->v1:
>> - no changes in this patch.
>> v3->v2:
>> - remove null check in reset, and add calls to mos6522_realize() in mac_via_realize to make this move to be valid.
>> v4->v3:
>> - split patch into two, this patch fix the memleaks.
>> ---
>>  hw/misc/mos6522.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/hw/misc/mos6522.c b/hw/misc/mos6522.c
>> index 19e154b870..c1cd154a84 100644
>> --- a/hw/misc/mos6522.c
>> +++ b/hw/misc/mos6522.c
>> @@ -485,6 +485,11 @@ static void mos6522_init(Object *obj)
>>      for (i = 0; i < ARRAY_SIZE(s->timers); i++) {
>>          s->timers[i].index = i;
>>      }
>> +}
>> +
>> +static void mos6522_realize(DeviceState *dev, Error **errp)
>> +{
>> +    MOS6522State *s = MOS6522(dev);
>>  
>>      s->timers[0].timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, mos6522_timer1, s);
>>      s->timers[1].timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, mos6522_timer2, s);
>> @@ -502,6 +507,7 @@ static void mos6522_class_init(ObjectClass *oc, void *data)
>>  
>>      dc->reset = mos6522_reset;
>>      dc->vmsd = &vmstate_mos6522;
>> +    dc->realize = mos6522_realize;
>>      device_class_set_props(dc, mos6522_properties);
>>      mdc->parent_reset = dc->reset;
>>      mdc->set_sr_int = mos6522_set_sr_int;
> 

