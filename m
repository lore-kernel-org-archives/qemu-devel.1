Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47CD5C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 09:35:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04EFD207F7
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 09:35:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04EFD207F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBEJf-0000Cr-2V
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 05:35:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59592)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kBEIg-00071o-Jp
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 05:34:30 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4276 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kBEIc-0004i2-MH
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 05:34:30 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 8F0B695C92B2FF4CD25E;
 Thu, 27 Aug 2020 17:34:20 +0800 (CST)
Received: from [127.0.0.1] (10.174.186.4) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Thu, 27 Aug 2020
 17:34:14 +0800
Subject: Re: [PATCH v5 11/12] migration/dirtyrate: Implement
 qmp_cal_dirty_rate()/qmp_get_dirty_rate() function
To: David Edmondson <dme@dme.org>, <quintela@redhat.com>, <eblake@redhat.com>, 
 <dgilbert@redhat.com>, <berrange@redhat.com>
References: <1598260480-64862-1-git-send-email-zhengchuan@huawei.com>
 <1598260480-64862-12-git-send-email-zhengchuan@huawei.com>
 <m2wo1lk8j9.fsf@dme.org>
From: Zheng Chuan <zhengchuan@huawei.com>
Message-ID: <1a23d60c-186b-d5b5-c43a-a8512826409b@huawei.com>
Date: Thu, 27 Aug 2020 17:34:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <m2wo1lk8j9.fsf@dme.org>
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
Cc: zhang.zhanghailiang@huawei.com, qemu-devel@nongnu.org,
 xiexiangyou@huawei.com, alex.chen@huawei.com, ann.zhuangyanying@huawei.com,
 fangying1@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2020/8/26 18:26, David Edmondson wrote:
> On Monday, 2020-08-24 at 17:14:39 +08, Chuan Zheng wrote:
> 
>> Implement qmp_cal_dirty_rate()/qmp_get_dirty_rate() function which could be called
>>
>> Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
>> ---
>>  migration/dirtyrate.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
>>  qapi/migration.json   | 44 ++++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 89 insertions(+)
>>
>> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
>> index 9f52f5f..08c46d3 100644
>> --- a/migration/dirtyrate.c
>> +++ b/migration/dirtyrate.c
>> @@ -62,6 +62,28 @@ static int dirtyrate_set_state(int *state, int old_state, int new_state)
>>      }
>>  }
>>  
>> +static struct DirtyRateInfo *query_dirty_rate_info(void)
>> +{
>> +    int64_t dirty_rate = DirtyStat.dirty_rate;
>> +    struct DirtyRateInfo *info = g_malloc0(sizeof(DirtyRateInfo));
>> +
>> +    if (CalculatingState == DIRTY_RATE_STATUS_MEASURED) {
>> +        info->dirty_rate = dirty_rate;
>> +    } else {
>> +        info->dirty_rate = -1;
>> +    }
>> +
>> +    info->status = CalculatingState;
>> +    /*
>> +     * Only support query once for each calculation,
>> +     * reset as DIRTY_RATE_STATUS_UNSTARTED after query
>> +     */
>> +    (void)dirtyrate_set_state(&CalculatingState, CalculatingState,
>> +                              DIRTY_RATE_STATUS_UNSTARTED);
> 
> Is there a reason for this restriction? Removing it would require
> clarifying the state model, I suppose.
> 
We only support query once for each calculation.
Otherwise, it could always query dirtyrate, but maybe the dirtyrate is calculated
long time ago.

>> +
>> +    return info;
>> +}
>> +
>>  static void reset_dirtyrate_stat(void)
>>  {
>>      DirtyStat.total_dirty_samples = 0;
>> @@ -378,3 +400,26 @@ void *get_dirtyrate_thread(void *arg)
>>                                DIRTY_RATE_STATUS_MEASURED);
>>      return NULL;
>>  }
>> +
>> +void qmp_calc_dirty_rate(int64_t calc_time, Error **errp)
>> +{
>> +    static struct DirtyRateConfig config;
>> +    QemuThread thread;
>> +
>> +    /*
>> +     * We don't begin calculating thread only when it's in calculating status.
> 
> "If the dirty rate is already being measured, don't attempt to start."
> 
>> +     */
>> +    if (CalculatingState == DIRTY_RATE_STATUS_MEASURING) {
> 
> Should this return an error to the caller?
> 
>> +        return;
>> +    }
>> +
>> +    config.sample_period_seconds = get_sample_page_period(calc_time);
> 
> If the specified sample period is outside the min/max, should an error
> be returned to the caller?
> 
>> +    config.sample_pages_per_gigabytes = DIRTYRATE_DEFAULT_SAMPLE_PAGES;
>> +    qemu_thread_create(&thread, "get_dirtyrate", get_dirtyrate_thread,
>> +                       (void *)&config, QEMU_THREAD_DETACHED);
>> +}
>> +
>> +struct DirtyRateInfo *qmp_query_dirty_rate(Error **errp)
>> +{
>> +    return query_dirty_rate_info();
>> +}
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index d640165..826bfd7 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -1737,3 +1737,47 @@
>>  ##
>>  { 'enum': 'DirtyRateStatus',
>>    'data': [ 'unstarted', 'measuring', 'measured'] }
>> +
>> +##
>> +# @DirtyRateInfo:
>> +#
>> +# Information about current dirty page rate of vm.
>> +#
>> +# @dirty-rate: @dirtyrate describing the dirty page rate of vm
>> +#          in units of MB/s.
>> +#          If this field return '-1', it means querying is not
>> +#          start or not complete.
>> +#
>> +# @status: status containing dirtyrate query status includes
>> +#          'unstarted' or 'measuring' or 'measured'
>> +#
>> +# Since: 5.2
>> +#
>> +##
>> +{ 'struct': 'DirtyRateInfo',
>> +  'data': {'dirty-rate': 'int64',
>> +           'status': 'DirtyRateStatus'} }
>> +
>> +##
>> +# @calc-dirty-rate:
>> +#
>> +# start calculating dirty page rate for vm
>> +#
>> +# @calc-time: time in units of second for sample dirty pages
>> +#
>> +# Since: 5.2
>> +#
>> +# Example:
>> +#   {"command": "cal-dirty-rate", "data": {"calc-time": 1} }
> 
> "cal-dirty-rate" -> "calc-dirty-rate".
> 
>> +#
>> +##
>> +{ 'command': 'calc-dirty-rate', 'data': {'calc-time': 'int64'} }
>> +
>> +##
>> +# @query-dirty-rate:
>> +#
>> +# query dirty page rate in units of MB/s for vm
>> +#
>> +# Since: 5.2
>> +##
>> +{ 'command': 'query-dirty-rate', 'returns': 'DirtyRateInfo' }
>> -- 
>> 1.8.3.1
> 
> dme.
> 


