Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1137BC43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 13:59:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B46E2087C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 13:59:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B46E2087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGN6R-0001Bk-ME
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 09:59:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45000)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kGN59-00089Y-MB
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 09:57:47 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4737 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kGN57-0003hk-Fu
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 09:57:47 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 192832DE1EF81438F90;
 Thu, 10 Sep 2020 21:57:42 +0800 (CST)
Received: from [127.0.0.1] (10.174.186.4) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Thu, 10 Sep 2020
 21:57:31 +0800
Subject: Re: [PATCH v1 7/7] migration/tls: add trace points for multifd-tls
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <1599663177-53993-1-git-send-email-zhengchuan@huawei.com>
 <1599663177-53993-8-git-send-email-zhengchuan@huawei.com>
 <20200910133732.GZ1083348@redhat.com>
From: Zheng Chuan <zhengchuan@huawei.com>
Message-ID: <d2d85491-b1c8-e83d-6cae-a1ad24f9a789@huawei.com>
Date: Thu, 10 Sep 2020 21:57:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200910133732.GZ1083348@redhat.com>
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



On 2020/9/10 21:37, Daniel P. Berrangé wrote:
> On Wed, Sep 09, 2020 at 10:52:57PM +0800, Chuan Zheng wrote:
>> add trace points for multifd-tls for debug.
>>
>> Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
>> Signed-off-by: Yan Jin <jinyan12@huawei.com>
>> ---
>>  migration/multifd.c    | 10 +++++++++-
>>  migration/trace-events |  5 +++++
>>  2 files changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/migration/multifd.c b/migration/multifd.c
>> index 2509187..26935b6 100644
>> --- a/migration/multifd.c
>> +++ b/migration/multifd.c
>> @@ -730,7 +730,11 @@ static void multifd_tls_outgoing_handshake(QIOTask *task,
>>      QIOChannel *ioc = QIO_CHANNEL(qio_task_get_source(task));
>>      Error *err = NULL;
>>  
>> -    qio_task_propagate_error(task, &err);
>> +    if (qio_task_propagate_error(task, &err)) {
>> +        trace_multifd_tls_outgoing_handshake_error(error_get_pretty(err));
>> +    } else {
>> +        trace_multifd_tls_outgoing_handshake_complete();
>> +    }
>>      multifd_channel_connect(p, ioc, err);
>>  }
>>  
>> @@ -747,6 +751,7 @@ static void multifd_tls_channel_connect(MultiFDSendParams *p,
>>          return;
>>      }
>>  
>> +    trace_multifd_tls_outgoing_handshake_start(hostname);
>>      qio_channel_set_name(QIO_CHANNEL(tioc), "multifd-tls-outgoing");
>>      qio_channel_tls_handshake(tioc,
>>                                multifd_tls_outgoing_handshake,
>> @@ -762,6 +767,9 @@ static bool multifd_channel_connect(MultiFDSendParams *p,
>>  {
>>      MigrationState *s = p->s;
>>  
>> +    trace_multifd_set_outgoing_channel(
>> +        ioc, object_get_typename(OBJECT(ioc)), s->hostname, error);
>> +
>>      if (!error) {
>>          if (s->parameters.tls_creds &&
>>              *s->parameters.tls_creds &&
>> diff --git a/migration/trace-events b/migration/trace-events
>> index 4ab0a50..860d2c4 100644
>> --- a/migration/trace-events
>> +++ b/migration/trace-events
>> @@ -109,6 +109,11 @@ multifd_send_sync_main_wait(uint8_t id) "channel %d"
>>  multifd_send_terminate_threads(bool error) "error %d"
>>  multifd_send_thread_end(uint8_t id, uint64_t packets, uint64_t pages) "channel %d packets %" PRIu64 " pages %"  PRIu64
>>  multifd_send_thread_start(uint8_t id) "%d"
>> +multifd_tls_outgoing_handshake_start(const char *hostname) "hostname=%s"
>> +multifd_tls_outgoing_handshake_error(const char *err) "err=%s"
>> +multifd_tls_outgoing_handshake_complete(void) ""
> 
> I'd suggest adding 'void *ioc' for all of these to make it clearer to
> correlate the traces.
> 
OK, will add it in v2

>> +multifd_set_outgoing_channel(void *ioc, const char *ioctype, const char *hostname, void *err)  "ioc=%p ioctype=%s hostname=%s err=%p"
>> +
>>  ram_discard_range(const char *rbname, uint64_t start, size_t len) "%s: start: %" PRIx64 " %zx"
>>  ram_load_loop(const char *rbname, uint64_t addr, int flags, void *host) "%s: addr: 0x%" PRIx64 " flags: 0x%x host: %p"
>>  ram_load_postcopy_loop(uint64_t addr, int flags) "@%" PRIx64 " %x"
>> -- 
>> 1.8.3.1
>>
> 
> Regards,
> Daniel
> 


