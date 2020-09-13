Return-Path: <SRS0=H3r+=CW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D20E7C43461
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 03:01:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32A3D206C3
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 03:01:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32A3D206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHIGG-0007vQ-CZ
	for qemu-devel@archiver.kernel.org; Sat, 12 Sep 2020 23:01:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41588)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kHIFc-0007K8-2o
 for qemu-devel@nongnu.org; Sat, 12 Sep 2020 23:00:24 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4743 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kHIFZ-0002Jz-7z
 for qemu-devel@nongnu.org; Sat, 12 Sep 2020 23:00:22 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 5E3E510B47B71E604AA7;
 Sun, 13 Sep 2020 11:00:14 +0800 (CST)
Received: from [10.174.186.4] (10.174.186.4) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0;
 Sun, 13 Sep 2020 11:00:08 +0800
Subject: Re: [PATCH v7 09/12] migration/dirtyrate: Implement
 set_sample_page_period() and get_sample_page_period()
To: Li Qiang <liq3ea@gmail.com>
References: <1599661096-127913-1-git-send-email-zhengchuan@huawei.com>
 <1599661096-127913-10-git-send-email-zhengchuan@huawei.com>
 <CAKXe6S+D+15MW2=Bq2o1NGmCgke0EErbPu_-KGbT0PSPhpAASA@mail.gmail.com>
From: Zheng Chuan <zhengchuan@huawei.com>
Message-ID: <91da6948-a8a3-6aa7-ed55-75f8ea77badf@huawei.com>
Date: Sun, 13 Sep 2020 11:00:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAKXe6S+D+15MW2=Bq2o1NGmCgke0EErbPu_-KGbT0PSPhpAASA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.186.4]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.191;
 envelope-from=zhengchuan@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/12 23:00:15
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



On 2020/9/10 21:59, Li Qiang wrote:
> Chuan Zheng <zhengchuan@huawei.com> 于2020年9月9日周三 下午10:15写道：
>>
>> Implement set_sample_page_period()/get_sample_page_period() to sleep
>> specific time between sample actions.
>>
>> Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
>> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> Reviewed-by: David Edmondson <david.edmondson@oracle.com>
>> ---
>>  migration/dirtyrate.c | 24 ++++++++++++++++++++++++
>>  migration/dirtyrate.h |  6 ++++++
>>  2 files changed, 30 insertions(+)
>>
>> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
>> index ae1959b..8a30261 100644
>> --- a/migration/dirtyrate.c
>> +++ b/migration/dirtyrate.c
>> @@ -27,6 +27,30 @@
>>  static int CalculatingState = DIRTY_RATE_STATUS_UNSTARTED;
>>  static struct DirtyRateStat DirtyStat;
>>
>> +static int64_t set_sample_page_period(int64_t msec, int64_t initial_time)
>> +{
>> +    int64_t current_time;
>> +
>> +    current_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
>> +    if ((current_time - initial_time) >= msec) {
>> +        msec = current_time - initial_time;
>> +    } else {
>> +        g_usleep((msec + initial_time - current_time) * 1000);
>> +    }
>> +
>> +    return msec;
>> +}
>> +
>> +static bool get_sample_page_period(int64_t sec)
> 
> 
> This function name may confuse people the this will get the period.
> But in fact you just check whether the 'period' is valid.
> I think it is better to name it to be 'is_sample_period_valid' or
> something meaningful.
> 
> Thanks,
> Li Qiang
> 
Sure, will optimize it in later patch update.

>> +{
>> +    if (sec < MIN_FETCH_DIRTYRATE_TIME_SEC ||
>> +        sec > MAX_FETCH_DIRTYRATE_TIME_SEC) {
>> +        return false;
>> +    }
>> +
>> +    return true;
>> +}
>> +
>>  static int dirtyrate_set_state(int *state, int old_state, int new_state)
>>  {
>>      assert(new_state < DIRTY_RATE_STATUS__MAX);
>> diff --git a/migration/dirtyrate.h b/migration/dirtyrate.h
>> index faaf9da..8f9bc80 100644
>> --- a/migration/dirtyrate.h
>> +++ b/migration/dirtyrate.h
>> @@ -29,6 +29,12 @@
>>   */
>>  #define MIN_RAMBLOCK_SIZE                         128
>>
>> +/*
>> + * Take 1s as minimum time for calculation duration
>> + */
>> +#define MIN_FETCH_DIRTYRATE_TIME_SEC              1
>> +#define MAX_FETCH_DIRTYRATE_TIME_SEC              60
>> +
>>  struct DirtyRateConfig {
>>      uint64_t sample_pages_per_gigabytes; /* sample pages per GB */
>>      int64_t sample_period_seconds; /* time duration between two sampling */
>> --
>> 1.8.3.1
>>
>>
> 
> .
> 

