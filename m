Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 542EAC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 03:20:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22E7E2230E
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 03:20:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22E7E2230E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWu3x-0007Gt-BB
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 22:20:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43397)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1iWtvw-0007EX-86
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 22:12:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pannengyuan@huawei.com>) id 1iWtvv-0000DV-4E
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 22:12:04 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2266 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pannengyuan@huawei.com>)
 id 1iWtvs-0008To-CA; Mon, 18 Nov 2019 22:12:00 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 271B4698BAD516829071;
 Tue, 19 Nov 2019 11:11:53 +0800 (CST)
Received: from [127.0.0.1] (10.120.177.99) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Tue, 19 Nov 2019
 11:11:44 +0800
Subject: Re: [Qemu-devel][PATCH] ppc/spapr_events: fix potential NULL pointer
 dereference in rtas_event_log_dequeue
To: David Gibson <david@gibson.dropbear.id.au>
References: <1574041813-35408-1-git-send-email-pannengyuan@huawei.com>
 <20191119025058.GN5582@umbus.fritz.box>
From: pannengyuan <pannengyuan@huawei.com>
Message-ID: <3e289453-cde4-cb9c-882f-88a5a2e78b36@huawei.com>
Date: Tue, 19 Nov 2019 11:11:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191119025058.GN5582@umbus.fritz.box>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.120.177.99]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.191
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
Cc: kuhn.chenqun@huawei.com, qemu-arm@nongnu.org, kenny.zhangjun@huawei.com,
 qemu-devel@nongnu.org, zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thanks for you reply.
I think you are right, I will send a new version later.

On 2019/11/19 10:50, David Gibson wrote:
> On Mon, Nov 18, 2019 at 09:50:13AM +0800, pannengyuan@huawei.com wrote:
>> From: PanNengyuan <pannengyuan@huawei.com>
>>
>> source is being dereferenced before it is null checked, hence there is a
>> potential null pointer dereference.
>>
>> This fixes:
>>         360
>>     CID 68911917: (NULL_RETURNS)
>>         361. dereference: Dereferencing "source", which is known to be
>>         "NULL".
>>         361        if (source->mask & event_mask) {
>>         362            break;
>>         363        }
>>
>> Reported-by: Euler Robot <euler.robot@huawei.com>
>> Signed-off-by: PanNengyuan <pannengyuan@huawei.com>
> 
> I don't think this is the right solution.  The only events we ever
> generated are LOG_TYPE_EPOW and LOG_TYPE_HOTPLUG, so in fact source
> should never be NULL.
> 
> I think the correct way to satisfy Coverity here is to have
> rtas_event_log_to_source() do an assert(), rather than returning NULL
> for other event types.
> 
>> ---
>>  hw/ppc/spapr_events.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
>> index 0e4c195..febd2ef 100644
>> --- a/hw/ppc/spapr_events.c
>> +++ b/hw/ppc/spapr_events.c
>> @@ -358,7 +358,7 @@ static SpaprEventLogEntry *rtas_event_log_dequeue(SpaprMachineState *spapr,
>>              rtas_event_log_to_source(spapr,
>>                                       spapr_event_log_entry_type(entry));
>>  
>> -        if (source->mask & event_mask) {
>> +        if (source && (source->mask & event_mask)) {
>>              break;
>>          }
>>      }
> 


