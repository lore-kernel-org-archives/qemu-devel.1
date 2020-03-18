Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43220C10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 08:12:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09FE92076C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 08:12:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09FE92076C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jETo9-0002H7-1c
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 04:12:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55926)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhukeqian1@huawei.com>) id 1jETnN-0001rJ-F7
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 04:11:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhukeqian1@huawei.com>) id 1jETnM-0005aD-9A
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 04:11:21 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3207 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhukeqian1@huawei.com>)
 id 1jETnL-0005GA-TN
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 04:11:20 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 9F477B16EEE620E8B3E6;
 Wed, 18 Mar 2020 16:11:10 +0800 (CST)
Received: from [127.0.0.1] (10.173.221.230) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0;
 Wed, 18 Mar 2020 16:11:00 +0800
Subject: Re: [PATCH] hmp-cmd: fix a missing_break warning
To: Pan Nengyuan <pannengyuan@huawei.com>, <dgilbert@redhat.com>
References: <20200318071620.59748-1-pannengyuan@huawei.com>
 <1a0d020b-3fe6-3575-1c2f-1af4a79cf080@huawei.com>
From: zhukeqian <zhukeqian1@huawei.com>
Message-ID: <6d08edfc-53e3-26dd-d1ec-1d075a94a6ce@huawei.com>
Date: Wed, 18 Mar 2020 16:10:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <1a0d020b-3fe6-3575-1c2f-1af4a79cf080@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.221.230]
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
Cc: wuchenye@huawei.com, euler.robot@huawei.com, qemu-devel@nongnu.org,
 zhanghailiang <zhang.zhanghailiang@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Nengyuan,

On 2020/3/18 15:22, Pan Nengyuan wrote:
> Correcting zhang hailiang's email.
> 
> On 3/18/2020 3:16 PM, Pan Nengyuan wrote:
>> This fix coverity issues 94417686:
>>     1260        break;
>>     CID 94417686: (MISSING_BREAK)
>>     1261. unterminated_case: The case for value "MIGRATION_PARAMETER_THROTTLE_TRIGGER_THRESHOLD" is not terminated by a 'break' statement.
>>     1261    case MIGRATION_PARAMETER_THROTTLE_TRIGGER_THRESHOLD:
>>     1262        p->has_throttle_trigger_threshold = true;
>>     1263        visit_type_int(v, param, &p->throttle_trigger_threshold, &err);
>>     1264    case MIGRATION_PARAMETER_CPU_THROTTLE_INITIAL:
>>
>> Fixes: dc14a470763c96fd9d360e1028ce38e8c3613a77
>> Reported-by: Euler Robot <euler.robot@huawei.com>
>> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
>> ---
>> Cc: zhukeqian1@huawei.com
>> ---
>>  monitor/hmp-cmds.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
>> index 58724031ea..c882c9f3cc 100644
>> --- a/monitor/hmp-cmds.c
>> +++ b/monitor/hmp-cmds.c
>> @@ -1261,6 +1261,7 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
>>      case MIGRATION_PARAMETER_THROTTLE_TRIGGER_THRESHOLD:
>>          p->has_throttle_trigger_threshold = true;
>>          visit_type_int(v, param, &p->throttle_trigger_threshold, &err);
>> +        break;
Good fix :).
>>      case MIGRATION_PARAMETER_CPU_THROTTLE_INITIAL:
>>          p->has_cpu_throttle_initial = true;
>>          visit_type_int(v, param, &p->cpu_throttle_initial, &err);
>>
> 
> .
> 
Reviewed-by: Keqian Zhu <zhukeqian1@huawei.com>

Thanks,
Keqian


