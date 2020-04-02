Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C9CC43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 09:33:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE3D92073B
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 09:33:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE3D92073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJwER-0005kv-1J
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 05:33:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55279)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fangying1@huawei.com>) id 1jJwDT-0004YZ-Lt
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 05:32:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fangying1@huawei.com>) id 1jJwDS-0007kC-Nz
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 05:32:51 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:39780 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <fangying1@huawei.com>)
 id 1jJwDQ-0007f8-8S; Thu, 02 Apr 2020 05:32:48 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id CD7A650762B37136DBA8;
 Thu,  2 Apr 2020 17:32:42 +0800 (CST)
Received: from [127.0.0.1] (10.133.205.53) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Thu, 2 Apr 2020
 17:32:32 +0800
Subject: Re: [PATCH v2] util/async: Add memory barrier to aio_ctx_prepare
To: Paolo Bonzini <pbonzini@redhat.com>, <qemu-devel@nongnu.org>,
 <qemu-arm@nongnu.org>
References: <20200402024431.1629-1-fangying1@huawei.com>
 <2f8406fa-ae18-856b-938f-a804ff1b11c7@redhat.com>
From: Ying Fang <fangying1@huawei.com>
Message-ID: <f7744148-2c91-ca3d-b8d6-99d5efc19a57@huawei.com>
Date: Thu, 2 Apr 2020 17:32:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <2f8406fa-ae18-856b-938f-a804ff1b11c7@redhat.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.205.53]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.32
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
Cc: fam@euphon.net, wu.wubin@huawei.com, qemu-stable@nongnu.org,
 stefanha@redhat.com, zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2020/4/2 16:47, Paolo Bonzini wrote:
> On 02/04/20 04:44, Ying Fang wrote:
>> Normal VM runtime is not affected by this hang since there is always some
>> timer timeout or subsequent io worker come and notify the main thead.
>> To fix this problem, a memory barrier is added to aio_ctx_prepare and
>> it is proved to have the hang fixed in our test.
> 
> Hi Ying Fang,
> 
> this part of the patch is correct, but I am not sure if a memory barrier
> is needed in aio_poll too.
> 
> In addition, the memory barrier is quite slow on x86 and not needed there.
Yes, memory barrier has impact on performance here.

> 
> I am sorry for dropping the ball on this bug; I had a patch using
> relaxed atomics (atomic_set/atomic_read) but I never submitted it
> because I had placed it in a larger series.  Let me post it now.
Thanks for your job, we'd like to do some tests if you post it.

Thanks,

Ying
> 
> Thanks,
> 
> Paolo
> 
>>
>> diff --git a/util/async.c b/util/async.c
>> index b94518b..89a4f3e 100644
>> --- a/util/async.c
>> +++ b/util/async.c
>> @@ -250,7 +250,8 @@ aio_ctx_prepare(GSource *source, gint    *timeout)
>>       AioContext *ctx = (AioContext *) source;
>>   
>>       atomic_or(&ctx->notify_me, 1);
>> -
>> +    /* Make sure notify_me is set before aio_compute_timeout */
>> +    smp_mb();
>>       /* We assume there is no timeout already supplied */
>>       *timeout = qemu_timeout_ns_to_ms(aio_compute_timeout(ctx));
>>   
>>
> 
> 
> 


