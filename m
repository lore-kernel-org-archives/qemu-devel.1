Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50451C433E4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 06:10:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23C4C20786
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 06:10:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23C4C20786
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBB7J-0004Kz-BN
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 02:10:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45538)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kBB6S-0003uU-8Y
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 02:09:41 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4270 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kBB6N-0004v8-7C
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 02:09:39 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 8414BBE5A959ADADDD88;
 Thu, 27 Aug 2020 14:09:21 +0800 (CST)
Received: from [127.0.0.1] (10.174.186.4) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Thu, 27 Aug 2020
 14:09:11 +0800
From: Zheng Chuan <zhengchuan@huawei.com>
Subject: Re: [PATCH v5 02/12] migration/dirtyrate: add DirtyRateStatus to
 denote calculation status
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <1598319650-36762-1-git-send-email-zhengchuan@huawei.com>
 <1598319650-36762-3-git-send-email-zhengchuan@huawei.com>
 <20200826114951.GD2726@work-vm>
Message-ID: <9b6c2e69-d048-e139-2974-cd25cd150c5d@huawei.com>
Date: Thu, 27 Aug 2020 14:09:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200826114951.GD2726@work-vm>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.186.4]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.191;
 envelope-from=zhengchuan@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 02:09:23
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.239,
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
 dme@dme.org, qemu-devel@nongnu.org, xiexiangyou@huawei.com,
 alex.chen@huawei.com, ann.zhuangyanying@huawei.com, fangying1@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2020/8/26 19:49, Dr. David Alan Gilbert wrote:
> * Chuan Zheng (zhengchuan@huawei.com) wrote:
>> add DirtyRateStatus to denote calculating status.
>>
>> Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
> 
> With the minor wording changes from David Edmondson:
> 
OK, will fix it in V6.
> 
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> 
>> ---
>>  migration/dirtyrate.c | 22 ++++++++++++++++++++++
>>  qapi/migration.json   | 17 +++++++++++++++++
>>  2 files changed, 39 insertions(+)
>>
>> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
>> index 366f4e9..91987c5 100644
>> --- a/migration/dirtyrate.c
>> +++ b/migration/dirtyrate.c
>> @@ -23,6 +23,19 @@
>>  #include "migration.h"
>>  #include "dirtyrate.h"
>>  
>> +static int CalculatingState = DIRTY_RATE_STATUS_UNSTARTED;
>> +
>> +static int dirtyrate_set_state(int *state, int old_state, int new_state)
>> +{
>> +    assert(new_state < DIRTY_RATE_STATUS__MAX);
>> +    if (atomic_cmpxchg(state, old_state, new_state) == old_state) {
>> +        return 0;
>> +    } else {
>> +        return -1;
>> +    }
>> +}
>> +
>> +
>>  static void calculate_dirtyrate(struct DirtyRateConfig config)
>>  {
>>      /* todo */
>> @@ -32,8 +45,17 @@ static void calculate_dirtyrate(struct DirtyRateConfig config)
>>  void *get_dirtyrate_thread(void *arg)
>>  {
>>      struct DirtyRateConfig config = *(struct DirtyRateConfig *)arg;
>> +    int ret;
>> +
>> +    ret = dirtyrate_set_state(&CalculatingState, DIRTY_RATE_STATUS_UNSTARTED,
>> +                              DIRTY_RATE_STATUS_MEASURING);
>> +    if (ret == -1) {
>> +        return NULL;
>> +    }
>>  
>>      calculate_dirtyrate(config);
>>  
>> +    ret = dirtyrate_set_state(&CalculatingState, DIRTY_RATE_STATUS_MEASURING,
>> +                              DIRTY_RATE_STATUS_MEASURED);
>>      return NULL;
>>  }
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index 5f6b061..d640165 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -1720,3 +1720,20 @@
>>  ##
>>  { 'event': 'UNPLUG_PRIMARY',
>>    'data': { 'device-id': 'str' } }
>> +
>> +##
>> +# @DirtyRateStatus:
>> +#
>> +# An enumeration of dirtyrate status.
>> +#
>> +# @unstarted: query-dirtyrate thread is not initial.
>> +#
>> +# @measuring: query-dirtyrate thread is created and start to measure.
>> +#
>> +# @measured:  query-dirtyrate thread is end, we can get result.
>> +#
>> +# Since: 5.2
>> +#
>> +##
>> +{ 'enum': 'DirtyRateStatus',
>> +  'data': [ 'unstarted', 'measuring', 'measured'] }
>> -- 
>> 1.8.3.1
>>


