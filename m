Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A549C3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 07:25:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F0AB22CEA
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 07:25:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F0AB22CEA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5PfE-0005om-9k
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 03:25:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50723)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fangying1@huawei.com>) id 1i5PeY-0005Lb-LV
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 03:24:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fangying1@huawei.com>) id 1i5PeX-0004k0-21
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 03:24:30 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33504 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <fangying1@huawei.com>)
 id 1i5PeW-0004Yc-Lc
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 03:24:28 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id D56A7EB6CDB87D7C1348;
 Wed,  4 Sep 2019 15:24:21 +0800 (CST)
Received: from [127.0.0.1] (10.133.205.53) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Wed, 4 Sep 2019
 15:24:11 +0800
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <20190827080512.2417-1-fangying1@huawei.com>
 <20190903164655.GP2744@work-vm>
From: fangying <fangying1@huawei.com>
Message-ID: <555564d9-5503-f741-8503-2066a781272d@huawei.com>
Date: Wed, 4 Sep 2019 15:24:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190903164655.GP2744@work-vm>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.205.53]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.32
Subject: Re: [Qemu-devel] [PATCH] qmp: Fix memory leak in
 migrate_params_test_apply
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
Cc: lcf.lichaofeng@huawei.com, zhanghailiang <zhang.zhanghailiang@huawei.com>,
 qemu-devel@nongnu.org, zhouyibo3@huawei.com, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2019/9/4 0:46, Dr. David Alan Gilbert wrote:
> * Ying Fang (fangying1@huawei.com) wrote:
>> Address Sanitizer shows memory leak in migrate_params_test_apply
>> migration/migration.c:1253 and the stack is as bellow:
>>
>> Direct leak of 45 byte(s) in 9 object(s) allocated from:
>>      #0 0xffffbd7fc1db in __interceptor_malloc (/lib64/libasan.so.4+0xd31db)
>>      #1 0xffffbd514163 in g_malloc (/lib64/libglib-2.0.so.0+0x57163)
>>      #2 0xffffbd52f43b in g_strdup (/lib64/libglib-2.0.so.0+0x7243b)
>>      #3 0xaaaadfa4d623 in migrate_params_test_apply migration/migration.c:1253
>>      #4 0xaaaadfa4d623 in qmp_migrate_set_parameters migration/migration.c:1422
>>      #5 0xaaaadfa963f3 in hmp_migrate_set_parameter monitor/hmp-cmds.c:1867
>>      #6 0xaaaadfa8afe3 in handle_hmp_command monitor/hmp.c:1082
>>      #7 0xaaaadf479c57 in qmp_human_monitor_command monitor/misc.c:140
>>      #8 0xaaaadfadf87b in qmp_marshal_human_monitor_command qapi/qapi-commands-misc.c:1024
>>      #9 0xaaaadfc7797b in do_qmp_dispatch qapi/qmp-dispatch.c:131
>>      #10 0xaaaadfc7797b in qmp_dispatch qapi/qmp-dispatch.c:174
>>      #11 0xaaaadfa84fff in monitor_qmp_dispatch monitor/qmp.c:120
>>      #12 0xaaaadfa85bbf in monitor_qmp_bh_dispatcher monitor/qmp.c:209
>>      #13 0xaaaadfd2228f in aio_bh_call util/async.c:89
>>      #14 0xaaaadfd2228f in aio_bh_poll util/async.c:117
>>      #15 0xaaaadfd29bc3 in aio_dispatch util/aio-posix.c:459
>>      #16 0xaaaadfd21ff7 in aio_ctx_dispatch util/async.c:260
>>      #17 0xffffbd50e2f7 in g_main_context_dispatch (/lib64/libglib-2.0.so.0+0x512f7)
>>      #18 0xaaaadfd278d7 in glib_pollfds_poll util/main-loop.c:218
>>      #19 0xaaaadfd278d7 in os_host_main_loop_wait util/main-loop.c:241
>>      #20 0xaaaadfd278d7 in main_loop_wait util/main-loop.c:517
>>      #21 0xaaaadf67b5e7 in main_loop vl.c:1806
>>      #22 0xaaaadf15d453 in main vl.c:4488
>>
>> Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>
>> Signed-off-by: Ying Fang <fangying1@huawei.com>
>> ---
>>   migration/migration.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 8b9f2fe30a..05e44ff7cc 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -1250,11 +1250,17 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
>>   
>>       if (params->has_tls_creds) {
>>           assert(params->tls_creds->type == QTYPE_QSTRING);
>> +        if (dest->tls_creds) {
>> +            g_free(dest->tls_creds);
>> +        }
>>           dest->tls_creds = g_strdup(params->tls_creds->u.s);
>>       }
>>   
>>       if (params->has_tls_hostname) {
>>           assert(params->tls_hostname->type == QTYPE_QSTRING);
>> +        if (dest->tls_hostname) {
>> +            g_free(dest->tls_hostname);
>> +        }
>>           dest->tls_hostname = g_strdup(params->tls_hostname->u.s);
>>       }
> 
> Thanks for reporting the leak, but I don't think this is the right fix:
> 
> In the call chain we have, qmp_migrate_set_parameters calls:
> 
>      migrate_params_test_apply(params, &tmp);
> 
> tmp is a stack allocated variable  that becomes the 'dest'
> we see here.  Then at the top of migrate_params_test_apply
> we have:
> 
>      *dest = migrate_get_current()->parameters;
> 
> so that's probably bad; that's a shallow copy, so dest->tls_authz
> points to the same storage as the real current migration parameters.
> 
> whne the code does:
>      if (params->has_tls_creds) {
>          assert(params->tls_creds->type == QTYPE_QSTRING);
>          dest->tls_creds = g_strdup(params->tls_creds->u.s);
>      }
> 
Yes, you are right, this patch will not fix this issue.
'tmp' is just a copy of 'dest' here, it 's used to do parameter sanity check.
We should either free tmp.tls_creds/tmp.tls_hostname after migrate_params_check
or change migrate_params_test_apply .

> it's only changing the pointer in the 'tmp' not the main copy
> because of migrate_params_check fails then the parameters get entirely
> unchanged.  So if you do a free on dest->tls_hostname you end up
> freeing the real parameter that's still getting used, not the tmp.
> 
> So I think we need to:
>    a) change migrate_params_test_apply so that it returns a
> MigrationParameters *  rather than taking &tmp
>    b) Make migrate_params_test use QAPI_CLONE to clone instead of doing:
>           *dest = migrate_get_current()->parameters;
>    c) Then do a qapi_free_MigrateParameters in qmp_migrate_set_parameters
>      on both the true and false paths.
> 
> Does that make sense?
> 
> Dave
> 
> 
>>   
>> -- 
>> 2.19.1
>>
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 
> .
> 


