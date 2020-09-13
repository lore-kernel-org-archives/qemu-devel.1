Return-Path: <SRS0=H3r+=CW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A92C43461
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 03:01:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CD6A206C3
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 03:01:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CD6A206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHIGx-0000NA-OD
	for qemu-devel@archiver.kernel.org; Sat, 12 Sep 2020 23:01:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41684)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kHIGD-00080p-7M
 for qemu-devel@nongnu.org; Sat, 12 Sep 2020 23:01:01 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:44770 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kHIGB-0002W2-AT
 for qemu-devel@nongnu.org; Sat, 12 Sep 2020 23:01:00 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 261352DE9130A57CBEAF;
 Sun, 13 Sep 2020 11:00:57 +0800 (CST)
Received: from [10.174.186.4] (10.174.186.4) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0;
 Sun, 13 Sep 2020 11:00:48 +0800
Subject: Re: [PATCH v7 11/12] migration/dirtyrate: Implement
 qmp_cal_dirty_rate()/qmp_get_dirty_rate() function
To: Li Qiang <liq3ea@gmail.com>
References: <1599661096-127913-1-git-send-email-zhengchuan@huawei.com>
 <1599661096-127913-12-git-send-email-zhengchuan@huawei.com>
 <CAKXe6SLGySEt+S_c8311nXkeUjkBnKcwzCyXrovoR2xmk=nQ3g@mail.gmail.com>
From: Zheng Chuan <zhengchuan@huawei.com>
Message-ID: <af5562ef-8bb3-c37a-d64a-0e882044ff08@huawei.com>
Date: Sun, 13 Sep 2020 11:00:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAKXe6SLGySEt+S_c8311nXkeUjkBnKcwzCyXrovoR2xmk=nQ3g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.186.4]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.32; envelope-from=zhengchuan@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/12 22:59:09
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.543,
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>, dme@dme.org,
 Juan Quintela <quintela@redhat.com>, "Dr.
 David Alan Gilbert" <dgilbert@redhat.com>, xiexiangyou@huawei.com,
 Qemu Developers <qemu-devel@nongnu.org>, AlexChen <alex.chen@huawei.com>,
 ann.zhuangyanying@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2020/9/10 22:27, Li Qiang wrote:
> Chuan Zheng <zhengchuan@huawei.com> 于2020年9月9日周三 下午10:14写道：
>>
>> Implement qmp_cal_dirty_rate()/qmp_get_dirty_rate() function which could be called
>>
>> Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
>> ---
>>  migration/dirtyrate.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>  qapi/migration.json   | 50 +++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 112 insertions(+)
>>
>> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
>> index 2f9ac34..e9e9e35 100644
>> --- a/migration/dirtyrate.c
>> +++ b/migration/dirtyrate.c
>> @@ -61,6 +61,24 @@ static int dirtyrate_set_state(int *state, int old_state, int new_state)
>>      }
>>  }
>>
>> +static struct DirtyRateInfo *query_dirty_rate_info(void)
>> +{
>> +    int64_t dirty_rate = DirtyStat.dirty_rate;
>> +    struct DirtyRateInfo *info = g_malloc0(sizeof(DirtyRateInfo));
>> +
>> +    if (CalculatingState == DIRTY_RATE_STATUS_MEASURED) {
> 
> Should we use atomic read 'CalculatingState'? The qmp thread maybe run
> with the sampled thread.
> 
OK, will optimize it in V8
>> +        info->dirty_rate = dirty_rate;
>> +    } else {
>> +        info->dirty_rate = -1;
>> +    }
>> +
>> +    info->status = CalculatingState;
>> +    info->start_time = DirtyStat.start_time;
>> +    info->calc_time = DirtyStat.calc_time;
>> +
>> +    return info;
>> +}
>> +
> 
> 
>>  static void reset_dirtyrate_stat(void)
>>  {
>>      DirtyStat.total_dirty_samples = 0;
>> @@ -331,6 +349,8 @@ static void calculate_dirtyrate(struct DirtyRateConfig config)
>>
>>      msec = config.sample_period_seconds * 1000;
>>      msec = set_sample_page_period(msec, initial_time);
>> +    DirtyStat.start_time = initial_time / 1000;
>> +    DirtyStat.calc_time = msec / 1000;
>>
>>      rcu_read_lock();
>>      if (compare_page_hash_info(block_dinfo, block_index) < 0) {
>> @@ -362,3 +382,45 @@ void *get_dirtyrate_thread(void *arg)
>>                                DIRTY_RATE_STATUS_MEASURED);
>>      return NULL;
>>  }
>> +
>> +void qmp_calc_dirty_rate(int64_t calc_time, Error **errp)
>> +{
>> +    static struct DirtyRateConfig config;
>> +    QemuThread thread;
>> +    int ret;
>> +
>> +    /*
>> +     * If the dirty rate is already being measured, don't attempt to start.
>> +     */
>> +    if (CalculatingState == DIRTY_RATE_STATUS_MEASURING) {
> 
> atomic read?
> 
>> +        error_setg(errp, "the dirty rate is already being measured.");
>> +        return;
>> +    }
>> +
>> +    if (!get_sample_page_period(calc_time)) {
>> +        error_setg(errp, "calc-time is out of range[%d, %d].",
>> +                         MIN_FETCH_DIRTYRATE_TIME_SEC,
>> +                         MAX_FETCH_DIRTYRATE_TIME_SEC);
>> +        return;
>> +    }
>> +
>> +    /*
>> +     * Init calculation state as unstarted.
>> +     */
>> +    ret = dirtyrate_set_state(&CalculatingState, CalculatingState,
>> +                              DIRTY_RATE_STATUS_UNSTARTED);
>> +    if (ret == -1) {
>> +        error_setg(errp, "init dirty rate calculation state failed.");
>> +        return;
>> +    }
>> +
>> +    config.sample_period_seconds = calc_time;
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
>> index 061ff25..4b980a0 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -1737,3 +1737,53 @@
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
>> +# @start-time: start time in units of second for calculation
>> +#
>> +# @calc-time: time in units of second for sample dirty pages
>> +#
>> +# Since: 5.2
>> +#
>> +##
>> +{ 'struct': 'DirtyRateInfo',
>> +  'data': {'dirty-rate': 'int64',
>> +           'status': 'DirtyRateStatus',
>> +           'start-time': 'int64',
>> +           'calc-time': 'int64'} }
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
>> +#   {"command": "calc-dirty-rate", "data": {"calc-time": 1} }
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
>>
>>
> 
> .
> 

