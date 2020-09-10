Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5204C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 13:57:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E50DD2087C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 13:57:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E50DD2087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGN4j-0006zz-QG
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 09:57:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44358)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kGN3B-0004VP-EB
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 09:55:45 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4735 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kGN38-0003SY-6l
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 09:55:44 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 57E6BB38508C1C0C2F48;
 Thu, 10 Sep 2020 21:55:35 +0800 (CST)
Received: from [127.0.0.1] (10.174.186.4) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Thu, 10 Sep 2020
 21:55:28 +0800
Subject: Re: [PATCH v1 1/7] migration/tls: save hostname into MigrationState
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <1599663177-53993-1-git-send-email-zhengchuan@huawei.com>
 <1599663177-53993-2-git-send-email-zhengchuan@huawei.com>
 <20200910131149.GS1083348@redhat.com>
From: Zheng Chuan <zhengchuan@huawei.com>
Message-ID: <c30e2e32-d7cb-78ad-cac0-75535b70e2aa@huawei.com>
Date: Thu, 10 Sep 2020 21:55:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200910131149.GS1083348@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.186.4]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.191;
 envelope-from=zhengchuan@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 09:55:36
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -77
X-Spam_score: -7.8
X-Spam_bar: -------
X-Spam_report: (-7.8 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.576,
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
Cc: zhang.zhanghailiang@huawei.com, quintela@redhat.com, yuxiating@huawei.com,
 dgilbert@redhat.com, xiexiangyou@huawei.com, qemu-devel@nongnu.org,
 alex.chen@huawei.com, jinyan12@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2020/9/10 21:11, Daniel P. Berrangé wrote:
> On Wed, Sep 09, 2020 at 10:52:51PM +0800, Chuan Zheng wrote:
>> hostname is need in multifd-tls, save hostname into MigrationState
>>
>> Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
>> Signed-off-by: Yan Jin <jinyan12@huawei.com>
>> ---
>>  migration/channel.c   | 5 +++++
>>  migration/migration.c | 1 +
>>  migration/migration.h | 5 +++++
>>  3 files changed, 11 insertions(+)
>>
>> diff --git a/migration/channel.c b/migration/channel.c
>> index 20e4c8e..2af3069 100644
>> --- a/migration/channel.c
>> +++ b/migration/channel.c
>> @@ -66,6 +66,11 @@ void migration_channel_connect(MigrationState *s,
>>      trace_migration_set_outgoing_channel(
>>          ioc, object_get_typename(OBJECT(ioc)), hostname, error);
>>  
>> +    /* Save hostname into MigrationState for handshake */
>> +    if (hostname) {
>> +        s->hostname = g_strdup(hostname);
>> +    }
>> +
>>      if (!error) {
>>          if (s->parameters.tls_creds &&
>>              *s->parameters.tls_creds &&
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 58a5452..e20b778 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -1883,6 +1883,7 @@ void migrate_init(MigrationState *s)
>>      s->migration_thread_running = false;
>>      error_free(s->error);
>>      s->error = NULL;
>> +    s->hostname = NULL;
>>  
>>      migrate_set_state(&s->state, MIGRATION_STATUS_NONE, MIGRATION_STATUS_SETUP);
>>  
>> diff --git a/migration/migration.h b/migration/migration.h
>> index ae497bd..758f803 100644
>> --- a/migration/migration.h
>> +++ b/migration/migration.h
>> @@ -261,6 +261,11 @@ struct MigrationState
>>       * (which is in 4M chunk).
>>       */
>>      uint8_t clear_bitmap_shift;
>> +
>> +    /*
>> +     * This save hostname when out-going migration starts
>> +     */
>> +    char *hostname;
>>  };
> 
> Something needs to free(hostname) at the appropriate time, otherwise
> well have a memory leak if we run migration multiple times.
> 
Hi, Daniel
Thank you for your review.

Yes, it will have a memory leak. Maybe i could just assign incoming parameters
when it is not NULL other than g_strdup it.

However, i am doubt if it is the best idea to save hostname into current_migration:(


> 
> Regards,
> Daniel
> 


