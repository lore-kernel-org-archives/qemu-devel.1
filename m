Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 583CBC4346E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 08:43:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C066B23600
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 08:43:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C066B23600
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLMqr-0004jM-Us
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 04:43:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56850)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kLMpo-0004GZ-B9
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 04:42:36 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:44494 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kLMpk-0000kg-DQ
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 04:42:36 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 61783134449C1E2B627E;
 Thu, 24 Sep 2020 16:42:13 +0800 (CST)
Received: from [10.174.186.4] (10.174.186.4) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0;
 Thu, 24 Sep 2020 16:42:04 +0800
Subject: Re: [PATCH v10 11/12] migration/dirtyrate: Implement
 qmp_cal_dirty_rate()/qmp_get_dirty_rate() function
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake
 <eblake@redhat.com>
References: <1600237327-33618-1-git-send-email-zhengchuan@huawei.com>
 <1600237327-33618-12-git-send-email-zhengchuan@huawei.com>
 <1c8647f5-62d4-bda6-df12-a60c6d0fc4db@redhat.com>
 <20200923190355.GD2780@work-vm>
From: Zheng Chuan <zhengchuan@huawei.com>
Message-ID: <2135c7e9-495e-e38b-a5a9-c82f8bba42d3@huawei.com>
Date: Thu, 24 Sep 2020 16:42:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200923190355.GD2780@work-vm>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.186.4]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.32; envelope-from=zhengchuan@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 04:42:14
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: berrange@redhat.com, zhang.zhanghailiang@huawei.com, quintela@redhat.com,
 liq3ea@gmail.com, qemu-devel@nongnu.org, xiexiangyou@huawei.com,
 alex.chen@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2020/9/24 3:03, Dr. David Alan Gilbert wrote:
> * Eric Blake (eblake@redhat.com) wrote:
>> On 9/16/20 1:22 AM, Chuan Zheng wrote:
>>> Implement qmp_cal_dirty_rate()/qmp_get_dirty_rate() function which could be called
>>>
>>> Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
>>> ---
>>
>>> +++ b/qapi/migration.json
>>> @@ -1737,3 +1737,53 @@
>>>   ##
>>>   { 'enum': 'DirtyRateStatus',
>>>     'data': [ 'unstarted', 'measuring', 'measured'] }
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
>>
>> Grammar:
>>
>> it means querying has not yet started or completed.
>>
>> Should this field instead be optional, and omitted for those cases?  In
>> which case, I'd suggest:
>>
>> ...in units of MB/s, present only when querying the rate has completed.
> 
Hi, Eric.
Thanks for your review.
Yeah, it could be optional.
and should it need keep start-time and calc-time when omit dirtyrate?
like:
{"return":{"status":"measuring","start-time":3718293,"calc-time":1},"id":"libvirt-15"}
or
{"return":{"status":"unstarted","start-time":3718293,"calc-time":1},"id":"libvirt-15"}

> I've already got it queued; I'll fix up the grammar; if someone wants to
> send a change to make it optional before this version freezes that's OK.
> 
> Dave
> 
>>
>>> +#
>>> +# @status: status containing dirtyrate query status includes
>>> +#          'unstarted' or 'measuring' or 'measured'
>>> +#
>>> +# @start-time: start time in units of second for calculation
>>> +#
>>> +# @calc-time: time in units of second for sample dirty pages
>>> +#
>>> +# Since: 5.2
>>> +#
>>> +##
>>> +{ 'struct': 'DirtyRateInfo',
>>> +  'data': {'dirty-rate': 'int64',
>>> +           'status': 'DirtyRateStatus',
>>> +           'start-time': 'int64',
>>> +           'calc-time': 'int64'} }
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
>>> +#   {"command": "calc-dirty-rate", "data": {"calc-time": 1} }
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

