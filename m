Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5513FC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 11:24:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2EFB21D7E
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 11:23:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2EFB21D7E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHmaV-00016E-36
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 07:23:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48492)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kHmZN-000063-Lc
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 07:22:49 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4694 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kHmZJ-00085A-DJ
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 07:22:49 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 24D60BCE4E455BBCADAE;
 Mon, 14 Sep 2020 19:22:39 +0800 (CST)
Received: from [10.174.186.4] (10.174.186.4) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0;
 Mon, 14 Sep 2020 19:22:31 +0800
Subject: Re: [PATCH v3 1/6] migration/tls: save hostname into MigrationState
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <1599965256-72150-1-git-send-email-zhengchuan@huawei.com>
 <1599965256-72150-2-git-send-email-zhengchuan@huawei.com>
 <20200914090043.GC1252186@redhat.com>
From: Zheng Chuan <zhengchuan@huawei.com>
Message-ID: <72c628fe-7c9b-4859-3264-811e4466d182@huawei.com>
Date: Mon, 14 Sep 2020 19:22:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200914090043.GC1252186@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.186.4]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.190;
 envelope-from=zhengchuan@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 04:52:27
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
Cc: zhang.zhanghailiang@huawei.com, quintela@redhat.com, yuxiating@huawei.com,
 dgilbert@redhat.com, xiexiangyou@huawei.com, qemu-devel@nongnu.org,
 alex.chen@huawei.com, jinyan12@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2020/9/14 17:00, Daniel P. Berrangé wrote:
> On Sun, Sep 13, 2020 at 10:47:31AM +0800, Chuan Zheng wrote:
>> hostname is need in multifd-tls, save hostname into MigrationState.
>>
>> Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
>> Signed-off-by: Yan Jin <jinyan12@huawei.com>
>> ---
>>  migration/channel.c   | 6 ++++++
>>  migration/migration.c | 1 +
>>  migration/migration.h | 5 +++++
>>  3 files changed, 12 insertions(+)
>>
>> diff --git a/migration/channel.c b/migration/channel.c
>> index 20e4c8e..0e4104a 100644
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
>> @@ -90,5 +95,6 @@ void migration_channel_connect(MigrationState *s,
>>          }
>>      }
>>      migrate_fd_connect(s, error);
>> +    g_free(s->hostname);
>>      error_free(error);
>>  }
> 
> IIUC, this means hostname is free'd once the initial connection is
> established. Don't we have to wait until all the multifd connections
> exist too ?
> 
> IOW, should we be doing this somewhere in a cleanup path. Perhaps
> migrate_fd_cancel() is the rigt place ?
> 

Well, Maybe another alternate way is define series functions to save/destroy tls_hostname in 'tls.c'
other than add hostname into MigrationState.
such as:

+static char *migration_tls_hostname = NULL;
+
+void migration_destroy_tls_hostname(void)
+{
+    if (migration_tls_hostname) {
+        g_free(migration_tls_hostname);
+        migration_tls_hostname = NULL;
+    }
+}
+
+static void migration_save_tls_hostname(const char *hostname)
+{
+     migration_destroy_tls_hostname();
+     migration_tls_hostname = g_strdup(hostname);
+}
+
+char *migration_get_tls_hostname(void)
+{
+     return migration_tls_hostname;
+}

How do you think, is that better?

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
>> index bdc7450..bc96322 100644
>> --- a/migration/migration.h
>> +++ b/migration/migration.h
>> @@ -259,6 +259,11 @@ struct MigrationState
>>       * (which is in 4M chunk).
>>       */
>>      uint8_t clear_bitmap_shift;
>> +
>> +    /*
>> +     * This save hostname when out-going migration starts
>> +     */
>> +    char *hostname;
>>  };
>>  
>>  void migrate_set_state(int *state, int old_state, int new_state);
>> -- 
>> 1.8.3.1
>>
> 
> Regards,
> Daniel
> 

