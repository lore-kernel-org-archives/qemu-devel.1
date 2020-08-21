Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6557AC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 12:22:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 306B320724
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 12:22:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 306B320724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k964O-0003Tx-EW
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 08:22:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58224)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1k963s-00033j-9E
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 08:22:24 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:59008 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1k963p-0008FO-UW
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 08:22:24 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 897FA2EF5505751631A7;
 Fri, 21 Aug 2020 20:22:17 +0800 (CST)
Received: from [127.0.0.1] (10.174.186.4) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Fri, 21 Aug 2020
 20:22:07 +0800
Subject: Re: [PATCH v3 05/10] migration/dirtyrate: Record hash results for
 each sampled page
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <1597634433-18809-1-git-send-email-zhengchuan@huawei.com>
 <1597634433-18809-6-git-send-email-zhengchuan@huawei.com>
 <20200820173009.GM2664@work-vm> <20200820175149.GA244434@redhat.com>
 <20200820175512.GQ2664@work-vm>
From: Zheng Chuan <zhengchuan@huawei.com>
Message-ID: <95894cf7-ba09-9862-357a-1073a192e934@huawei.com>
Date: Fri, 21 Aug 2020 20:22:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200820175512.GQ2664@work-vm>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.186.4]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.35; envelope-from=zhengchuan@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 08:01:51
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: zhang.zhanghailiang@huawei.com, quintela@redhat.com, linyilu@huawei.com,
 qemu-devel@nongnu.org, alex.chen@huawei.com, ann.zhuangyanying@huawei.com,
 fangying1@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2020/8/21 1:55, Dr. David Alan Gilbert wrote:
> * Daniel P. BerrangÃ© (berrange@redhat.com) wrote:
>> On Thu, Aug 20, 2020 at 06:30:09PM +0100, Dr. David Alan Gilbert wrote:
>>> * Chuan Zheng (zhengchuan@huawei.com) wrote:
>>>> Record hash results for each sampled page.
>>>>
>>>> Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
>>>> Signed-off-by: YanYing Zhuang <ann.zhuangyanying@huawei.com>
>>>> ---
>>>>  migration/dirtyrate.c | 144 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>>>  migration/dirtyrate.h |   7 +++
>>>>  2 files changed, 151 insertions(+)
>>>>
>>>> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
>>>> index c4304ef..62b6f69 100644
>>>> --- a/migration/dirtyrate.c
>>>> +++ b/migration/dirtyrate.c
>>>> @@ -25,6 +25,7 @@
>>>>  #include "dirtyrate.h"
>>>>  
>>>>  CalculatingDirtyRateState CalculatingState = CAL_DIRTY_RATE_INIT;
>>>> +static unsigned long int qcrypto_hash_len = QCRYPTO_HASH_LEN;
>>>
>>> Why do we need this static rather than just using the QCRYPTO_HASH_LEN ?
>>> It's never going to change is it?
>>> (and anyway it's just a MD5 len?)
>>
>> I wouldn't want to bet on that given that this is use of MD5. We might
>> claim this isn't security critical, but surprises happen, and we will
>> certainly be dinged on security audits for introducing new use of MD5
>> no matter what.
>>
>> If a cryptographic hash is required, then sha256 should be the choice
>> for any new code that doesn't have back compat requirements.
>>
>> If a cryptographic hash is not required then how about crc32 
> 
> It doesn't need to be cryptographic; is crc32 the fastest reasonable hash for use
> in large areas?
> 
> Dave
> 
>> IOW, it doesn't make a whole lot of sense to say we need a cryptographic
>> hash, but then pick the most insecure one.
>>
>> sha256 is slower than md5, but it is conceivable that in future we might
>> gain support for something like Blake2b which is similar security level
>> to SHA3, while being faster than MD5.
>>
>> Overall I'm pretty unethusiastic about use of MD5 being introduced and
>> worse, being hardcoded as the only option.
>>
>> Regards,
>> Daniel
>> -- 
>> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
>> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
>> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

Hi, Daniel, Dave.

I do compare MD5 and SHA256 with vm memory of 128G under mempress of 100G.

1. Calculation speed
1） MD5 takes about 500ms to sample and hash all pages by record_ramblock_hash_info().
2)  SHA256 takes about 750ms to sample all pages by record_ramblock_hash_info().

2. CPU Consumption
1)  MD5 may have instant rise up to 48% for dirtyrate thread
2)  SHA256 may have instant rise up to 75% for dirtyrate thread

3. Memory Consumption
SHA256 may need twice memory than MD5 due to its HASH_LEN.

I am trying to consider if crc32 is more faster and takes less memory and is more safer than MD5?
For now, i am trying to do how to implement crc32 instead of using qcrypto_hash_bytesv() to hash sampled page memory.


