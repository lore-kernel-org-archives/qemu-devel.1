Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA58BC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 13:58:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CDBC2087C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 13:58:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CDBC2087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGN68-0000u0-AG
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 09:58:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44774)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kGN43-0006EH-P0
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 09:56:40 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4736 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kGN41-0003di-Os
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 09:56:39 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 89A6E6220C6C585D8D40;
 Thu, 10 Sep 2020 21:56:34 +0800 (CST)
Received: from [127.0.0.1] (10.174.186.4) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Thu, 10 Sep 2020
 21:56:26 +0800
Subject: Re: [PATCH v1 6/7] migration/tls: add support for multifd
 tls-handshake
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <1599663177-53993-1-git-send-email-zhengchuan@huawei.com>
 <1599663177-53993-7-git-send-email-zhengchuan@huawei.com>
 <20200910132550.GV1083348@redhat.com>
From: Zheng Chuan <zhengchuan@huawei.com>
Message-ID: <f631ddb9-27b9-7962-5f70-354d7f70f64c@huawei.com>
Date: Thu, 10 Sep 2020 21:56:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200910132550.GV1083348@redhat.com>
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



On 2020/9/10 21:25, Daniel P. Berrangé wrote:
> On Wed, Sep 09, 2020 at 10:52:56PM +0800, Chuan Zheng wrote:
>> add support for multifd tls-handshake
>>
>> Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
>> Signed-off-by: Yan Jin <jinyan12@huawei.com>
>> ---
>>  migration/multifd.c | 32 +++++++++++++++++++++++++++++++-
>>  1 file changed, 31 insertions(+), 1 deletion(-)
>>
>> diff --git a/migration/multifd.c b/migration/multifd.c
>> index b2076d7..2509187 100644
>> --- a/migration/multifd.c
>> +++ b/migration/multifd.c
>> @@ -719,11 +719,41 @@ out:
>>      return NULL;
>>  }
>>  
>> +static bool multifd_channel_connect(MultiFDSendParams *p,
>> +                                    QIOChannel *ioc,
>> +                                    Error *error);
>> +
>> +static void multifd_tls_outgoing_handshake(QIOTask *task,
>> +                                           gpointer opaque)
>> +{
>> +    MultiFDSendParams *p = opaque;
>> +    QIOChannel *ioc = QIO_CHANNEL(qio_task_get_source(task));
>> +    Error *err = NULL;
>> +
>> +    qio_task_propagate_error(task, &err);
>> +    multifd_channel_connect(p, ioc, err);
>> +}
>> +
>>  static void multifd_tls_channel_connect(MultiFDSendParams *p,
>>                                      QIOChannel *ioc,
>>                                      Error **errp)
>>  {
>> -    /* TODO */
>> +    MigrationState *s = p->s;
>> +    const char *hostname = s->hostname;
>> +    QIOChannelTLS *tioc;
>> +
>> +    tioc = migration_tls_client_create(s, ioc, hostname, errp);
>> +    if (!tioc) {
>> +        return;
>> +    }
>> +
>> +    qio_channel_set_name(QIO_CHANNEL(tioc), "multifd-tls-outgoing");
>> +    qio_channel_tls_handshake(tioc,
>> +                              multifd_tls_outgoing_handshake,
>> +                              p,
>> +                              NULL,
>> +                              NULL);
>> +
>>  }
> 
> 
> Please squash this back into the previous patch, and both are
> inter-dependant on each other, and thus don't make sense to split
> 
> Assuming it is squashed in
> 
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> 
OK, will squash it in v2
> 
> 
> Regards,
> Daniel
> 


