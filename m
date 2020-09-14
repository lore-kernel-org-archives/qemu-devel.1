Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43CCEC43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 09:37:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CD4C21D1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 09:37:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CD4C21D1A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHkvo-0003wZ-EM
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 05:37:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52202)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kHkuw-00039k-Vs
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 05:36:58 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4693 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kHkuu-0002tq-H3
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 05:36:58 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id BFCAA3DAEEAF744F5D5B;
 Mon, 14 Sep 2020 17:36:51 +0800 (CST)
Received: from [10.174.186.4] (10.174.186.4) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0;
 Mon, 14 Sep 2020 17:36:39 +0800
Subject: Re: [PATCH v3 3/6] migration/tls: add MigrationState and tls_hostname
 into MultiFDSendParams
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <1599965256-72150-1-git-send-email-zhengchuan@huawei.com>
 <1599965256-72150-4-git-send-email-zhengchuan@huawei.com>
 <20200914090209.GD1252186@redhat.com>
 <c3db0348-8d59-74b3-6931-d3dc8787810b@huawei.com>
 <20200914092659.GF1252186@redhat.com>
From: Zheng Chuan <zhengchuan@huawei.com>
Message-ID: <2abf6fb4-d4f9-88af-b540-d18db22e46ca@huawei.com>
Date: Mon, 14 Sep 2020 17:36:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200914092659.GF1252186@redhat.com>
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
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
 qemu-devel@nongnu.org, xiexiangyou@huawei.com, dgilbert@redhat.com,
 alex.chen@huawei.com, jinyan12@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2020/9/14 17:26, Daniel P. Berrangé wrote:
> On Mon, Sep 14, 2020 at 05:20:14PM +0800, Zheng Chuan wrote:
>>
>>
>> On 2020/9/14 17:02, Daniel P. Berrangé wrote:
>>> On Sun, Sep 13, 2020 at 10:47:33AM +0800, Chuan Zheng wrote:
>>>> MigrationState is need for tls session build and tls hostname is need
>>>> for tls handshake, add both MigrationState and tls_hostname
>>>> into MultiFDSendParams.
>>>>
>>>> Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
>>>> Signed-off-by: Yan Jin <jinyan12@huawei.com>
>>>> ---
>>>>  migration/multifd.c | 5 +++++
>>>>  migration/multifd.h | 4 ++++
>>>>  2 files changed, 9 insertions(+)
>>>>
>>>> diff --git a/migration/multifd.c b/migration/multifd.c
>>>> index d044120..3e41d9e 100644
>>>> --- a/migration/multifd.c
>>>> +++ b/migration/multifd.c
>>>> @@ -543,11 +543,14 @@ void multifd_save_cleanup(void)
>>>>  
>>>>          socket_send_channel_destroy(p->c);
>>>>          p->c = NULL;
>>>> +        p->s = NULL;
>>>>          qemu_mutex_destroy(&p->mutex);
>>>>          qemu_sem_destroy(&p->sem);
>>>>          qemu_sem_destroy(&p->sem_sync);
>>>>          g_free(p->name);
>>>>          p->name = NULL;
>>>> +        g_free(p->tls_hostname);
>>>> +        p->tls_hostname = NULL;
>>>>          multifd_pages_clear(p->pages);
>>>>          p->pages = NULL;
>>>>          p->packet_len = 0;
>>>> @@ -779,6 +782,8 @@ int multifd_save_setup(Error **errp)
>>>>          p->packet->magic = cpu_to_be32(MULTIFD_MAGIC);
>>>>          p->packet->version = cpu_to_be32(MULTIFD_VERSION);
>>>>          p->name = g_strdup_printf("multifdsend_%d", i);
>>>> +        p->s = migrate_get_current();
>>>> +        p->tls_hostname = g_strdup(p->s->hostname);
>>>>          socket_send_channel_create(multifd_new_send_channel_async, p);
>>>>      }
>>>>  
>>>> diff --git a/migration/multifd.h b/migration/multifd.h
>>>> index 448a03d..2b400e7 100644
>>>> --- a/migration/multifd.h
>>>> +++ b/migration/multifd.h
>>>> @@ -66,11 +66,15 @@ typedef struct {
>>>>  } MultiFDPages_t;
>>>>  
>>>>  typedef struct {
>>>> +    /* Migration State */
>>>> +    MigrationState *s;
>>>>      /* this fields are not changed once the thread is created */
>>>>      /* channel number */
>>>>      uint8_t id;
>>>>      /* channel thread name */
>>>>      char *name;
>>>> +    /* tls hostname */
>>>> +    char *tls_hostname;
>>>
>>> Why do we need this, when it is already accessible from the
>>> MigrationState field you're adding
>>>
>>>
>>> Regards,
>>> Daniel
>>>
>> Hi，Daniel. Thank you for your review.
>>
>> This is because i have free hostname in MigrationState field after migrate_fd_connect(s, error).
>> Since multifd thread creation is async by socket_send_channel_create(), we must record it in MultiFDSendParams
>> in case of concurrency issues.
>>
>> migration_channel_connect
>>        migrate_fd_connect
>>            multifd_save_setup
>>               socket_send_channel_create(multifd_new_send_channel_async, p); / async, do not wait for multifd creation
>>                 g_free(s->hostname);
>>                                                           multifd_new_send_channel_async
>>                                                                   multifd_channel_connect
>>                                                                          multifd_tls_channel_connect
>>                                                                                 migration_tls_client_create  /* UAF happen */
>>
>> As you mentioned in Patch001, i am not sure if it will cause the same concurrency issues if i put hostname in MigrationState field
>> freed in migrate_fd_cancel.
> 
> If MigrationState isn't safe to access from the multifd threads, then
> don't addd it to the struct, as I think that will mislead people into
> thinking it is ok to use. Only add the hostname.
> 
> 
> Regards,
> Daniel
> 
Sure, I'll fix that in V4.

In addition, is that OK I pass hostname to MultiFDSendParams through MigrationState field as Patch001 do?

