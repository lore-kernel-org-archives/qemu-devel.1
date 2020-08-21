Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD636C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 10:03:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A083C207DA
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 10:03:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A083C207DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k93tb-0004Yd-Uf
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 06:03:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54434)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1k93qL-0000m7-HH
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:00:17 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:49268 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1k93qJ-000715-7w
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:00:17 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id E30201C186803CAA649A;
 Fri, 21 Aug 2020 18:00:10 +0800 (CST)
Received: from [127.0.0.1] (10.174.186.4) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Fri, 21 Aug 2020
 18:00:03 +0800
From: Zheng Chuan <zhengchuan@huawei.com>
Subject: Re: [PATCH v3 10/10] migration/dirtyrate: Implement
 qmp_cal_dirty_rate()/qmp_get_dirty_rate() function
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake
 <eblake@redhat.com>
References: <1597634433-18809-1-git-send-email-zhengchuan@huawei.com>
 <1597634433-18809-11-git-send-email-zhengchuan@huawei.com>
 <81958147-04dc-5edf-7bd4-97c3ebc3a037@redhat.com>
 <20200820180032.GS2664@work-vm>
Message-ID: <81073f7b-7a27-6332-31ee-838e6cf9737c@huawei.com>
Date: Fri, 21 Aug 2020 18:00:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200820180032.GS2664@work-vm>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.186.4]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.35; envelope-from=zhengchuan@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 05:59:57
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
Cc: zhang.zhanghailiang@huawei.com, quintela@redhat.com, linyilu@huawei.com,
 qemu-devel@nongnu.org, alex.chen@huawei.com, ann.zhuangyanying@huawei.com,
 fangying1@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2020/8/21 2:00, Dr. David Alan Gilbert wrote:
> * Eric Blake (eblake@redhat.com) wrote:
>> On 8/16/20 10:20 PM, Chuan Zheng wrote:
>>> Implement qmp_cal_dirty_rate()/qmp_get_dirty_rate() function which could be called
>>>
>>> Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
>>> ---
>>
>>> +++ b/qapi/migration.json
>>> @@ -1621,3 +1621,45 @@
>>>   ##
>>>   { 'event': 'UNPLUG_PRIMARY',
>>>     'data': { 'device-id': 'str' } }
>>> +
>>> +##
>>> +# @DirtyRateInfo:
>>> +#
>>> +# Information about current dirty page rate of vm.
>>> +#
>>> +# @dirty-rate: @dirtyrate describing the dirty page rate of vm
>>> +#          in units of MB/s.
>>> +#          If this field return '-1', it means querying is not
>>> +#          start or not complete.
>>> +#
>>> +# @status: @status containing dirtyrate query status includes
>>> +#       status with 'not start measuring' or
>>> +#       'Still measuring' or 'measured'(since 5.2)
>>
>> Missing space before (
>>
>>> +##
>>> +{ 'struct': 'DirtyRateInfo',
>>> +  'data': {'dirty-rate': 'int64',
>>> +           'status': 'str'} }
>>
>> Based on your description, this should be an enum type rather than an
>> open-coded string.  Something like:
>>
>> { 'enum': 'DirtyRateStatus', 'data': [ 'unstarted', 'measuring', 'measured'
>> ] }
>> { 'struct': 'DirtyRateInfo', 'data': { 'dirty-rate': 'int64', 'status':
>> 'DirtyRateStatus' } }
> 
> Yes, and if you do that I think you'll find qmp would automatically
> define a C enum type for you, so you don't need to define the
> CalculatingDirtyRateStage yourself;   see how MigrationStatus works.
> 
> Dave
> 
Sure, it could be better，will fix it in V4:)
> 
>>
>>> +
>>> +##
>>> +# @calc-dirty-rate:
>>> +#
>>> +# start calculating dirty page rate for vm
>>> +#
>>> +# @calc-time: time in units of second for sample dirty pages
>>> +#
>>> +# Since: 5.2
>>> +#
>>> +# Example:
>>> +#   {"command": "cal-dirty-rate", "data": {"calc-time": 1} }
>>> +#
>>> +##
>>> +{ 'command': 'calc-dirty-rate', 'data': {'calc-time': 'int64'} }
>>> +
>>> +##
>>> +# @query-dirty-rate:
>>> +#
>>> +# query dirty page rate in units of MB/s for vm
>>> +#
>>> +# Since: 5.2
>>> +##
>>> +{ 'command': 'query-dirty-rate', 'returns': 'DirtyRateInfo' }
>>>
>>
>> -- 
>> Eric Blake, Principal Software Engineer
>> Red Hat, Inc.           +1-919-301-3226
>> Virtualization:  qemu.org | libvirt.org


