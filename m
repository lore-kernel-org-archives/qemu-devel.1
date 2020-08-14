Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39DD7C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 00:32:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11890206B2
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 00:32:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11890206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6Ndq-0004ju-CD
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 20:32:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58766)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <longpeng2@huawei.com>)
 id 1k6Nd8-0004HA-Op
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 20:31:34 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4240 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <longpeng2@huawei.com>)
 id 1k6Nd6-0007NN-Md
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 20:31:34 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id F0763DE96CA8A23B7155;
 Fri, 14 Aug 2020 08:31:20 +0800 (CST)
Received: from [10.174.151.115] (10.174.151.115) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Fri, 14 Aug 2020 08:31:12 +0800
Subject: Re: [PATCH 2/2] migration: add vsock as data channel support
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <20200806074030.174-1-longpeng2@huawei.com>
 <20200806074030.174-3-longpeng2@huawei.com> <20200812095211.GB2810@work-vm>
From: "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)"
 <longpeng2@huawei.com>
Message-ID: <2bc0e226-ee71-330a-1bcd-bd9d097509bc@huawei.com>
Date: Fri, 14 Aug 2020 08:31:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200812095211.GB2810@work-vm>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.151.115]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.191; envelope-from=longpeng2@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 20:31:21
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: arei.gonglei@huawei.com, qemu-devel@nongnu.org, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



ÔÚ 2020/8/12 17:52, Dr. David Alan Gilbert Ð´µÀ:
> * Longpeng(Mike) (longpeng2@huawei.com) wrote:
>> The vsock channel is more widely use in some new features, for example,
>> the Nitro/Enclave. It can also be used as the migration channel.
>>
>> Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
> 
> OK; it might be worth adding some tests for this.
> 
OK, I'll try when I'm free.

> Can I ask what your use case is - is this migrating an L2 inside an L1
> or what?
> 
Yes, L2 migrationg is a potential use case for this. However, our use 
case is still focusing on the L1 migration.

There is no network stack in our platform ( [1] ), so we use the vsock 
channel to communicate between the QEMU (on x86/ARM) and an Agent (on a 
PCIe card), the source Agent will transport the data to the destination.

Links:
[1] 
https://kvmforum2019.sched.com/event/Tmzh/zero-next-generation-virtualization-platform-for-huawei-cloud-jinsong-liu-zhichao-huang-huawei

> 
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> 
Thanks.

>> ---
>>   migration/migration.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 3160b95..fcf7974 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -383,7 +383,8 @@ void qemu_start_incoming_migration(const char *uri, Error **errp)
>>       if (!strcmp(uri, "defer")) {
>>           deferred_incoming_migration(errp);
>>       } else if (strstart(uri, "tcp:", &p) ||
>> -               strstart(uri, "unix:", NULL)) {
>> +               strstart(uri, "unix:", NULL) ||
>> +               strstart(uri, "vsock:", NULL)) {
>>           socket_start_incoming_migration(p ? p : uri, errp);
>>   #ifdef CONFIG_RDMA
>>       } else if (strstart(uri, "rdma:", &p)) {
>> @@ -2072,7 +2073,8 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
>>       }
>>   
>>       if (strstart(uri, "tcp:", &p) ||
>> -        strstart(uri, "unix:", NULL)) {
>> +        strstart(uri, "unix:", NULL) ||
>> +        strstart(uri, "vsock:", NULL)) {
>>           socket_start_outgoing_migration(s, p ? p : uri, &local_err);
>>   #ifdef CONFIG_RDMA
>>       } else if (strstart(uri, "rdma:", &p)) {
>> -- 
>> 1.8.3.1
>>

