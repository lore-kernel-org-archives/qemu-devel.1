Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B99C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:17:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA182204FD
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:17:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA182204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3aUL-00017j-Lq
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 03:38:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56550)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1k3aTL-0008Hy-4d
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 03:37:55 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:54288 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1k3aTJ-0002Qy-6l
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 03:37:54 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 6A89CB99EB3660DD4481;
 Thu,  6 Aug 2020 15:37:49 +0800 (CST)
Received: from [127.0.0.1] (10.174.186.4) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Thu, 6 Aug 2020
 15:37:36 +0800
From: Zheng Chuan <zhengchuan@huawei.com>
Subject: Re: [RFC PATCH 8/8] migration/dirtyrate: Implement
 qmp_cal_dirty_rate()/qmp_get_dirty_rate() function
To: Eric Blake <eblake@redhat.com>, <quintela@redhat.com>,
 <dgilbert@redhat.com>
References: <1595646669-109310-1-git-send-email-zhengchuan@huawei.com>
 <1595646669-109310-9-git-send-email-zhengchuan@huawei.com>
 <b413e8ac-fc4f-aa76-c1d4-332343122302@redhat.com>
Message-ID: <1da4a1ca-99e1-d8f9-b6d4-5419d3f57cae@huawei.com>
Date: Thu, 6 Aug 2020 15:37:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <b413e8ac-fc4f-aa76-c1d4-332343122302@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.186.4]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.32; envelope-from=zhengchuan@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 03:37:49
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: zhang.zhanghailiang@huawei.com, linyilu@huawei.com, qemu-devel@nongnu.org,
 alex.chen@huawei.com, ann.zhuangyanying@huawei.com, fangying1@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2020/8/5 0:28, Eric Blake wrote:
> On 7/24/20 10:11 PM, Chuan Zheng wrote:
>> From: Zheng Chuan <zhengchuan@huawei.com>
>>
>> Implement qmp_cal_dirty_rate()/qmp_get_dirty_rate() function which could be called
>> by libvirt api.
>>
>> Signed-off-by: Zheng Chuan <zhengchuan@huawei.com>
>> Signed-off-by: YanYing Zhang <ann.zhuangyanying@huawei.com>
>> ---
> 
>> +++ b/qapi/migration.json
>> @@ -1621,3 +1621,27 @@
>>   ##
>>   { 'event': 'UNPLUG_PRIMARY',
>>     'data': { 'device-id': 'str' } }
>> +
>> +##
>> +# @cal_dirty_rate:
> 
> New QMP commands should be named favoring '-' over '_'; also, it doesn't hurt to spell it out:
> 
> calculate-dirty-rate
> 
Hi, Eric.
Thank you for your review.
I'll fix that in V2.

>> +#
>> +# start calculating dirty rate for vm
>> +#
>> +# @value: time for sample dirty pages
> 
> In what unit?
> 
The unit is second, i'll make comments in V2:)

>> +#
>> +# Since: 5.1
> 
> We've missed 5.1; this will need to be updated to 5.2.
> 
>> +#
>> +# Example:
>> +#   {"command": "cal_dirty_rate", "data": {"value": 1} }
>> +#
>> +##
>> +{ 'command': 'cal_dirty_rate', 'data': {'value': 'int64'} }
>> +
>> +##
>> +# @get_dirty_rate:
> 
> get-dirty-rate, except that we tend to use 'query-' as the prefix for commands that read values.
> 
>> +#
>> +# get dirty rate for vm
>> +#
>> +# Since: 5.1
> 
> 5.2
> 
> What units is the rate expressed in?
> 
The unit is MB/s, i'll make comments in V2:)
> 
>> +##
>> +{ 'command': 'get_dirty_rate', 'returns': 'int64' }
>> diff --git a/qapi/pragma.json b/qapi/pragma.json
>> index cffae27..ecd294b 100644
>> --- a/qapi/pragma.json
>> +++ b/qapi/pragma.json
>> @@ -10,7 +10,8 @@
>>           'query-migrate-cache-size',
>>           'query-tpm-models',
>>           'query-tpm-types',
>> -        'ringbuf-read' ],
>> +        'ringbuf-read',
>> +        'get_dirty_rate' ],
>>       'name-case-whitelist': [
>>           'ACPISlotType',             # DIMM, visible through query-acpi-ospm-status
>>           'CpuInfoMIPS',              # PC, visible through query-cpu
>>
> 


