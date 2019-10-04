Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06DCAC10F14
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 02:01:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7183207FF
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 02:01:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7183207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGCug-0000es-A2
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 22:01:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57098)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maozhongyi@cmss.chinamobile.com>) id 1iGCsX-0008Uo-Jx
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 21:59:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <maozhongyi@cmss.chinamobile.com>) id 1iGCsW-0007bC-7D
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 21:59:33 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:16174)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <maozhongyi@cmss.chinamobile.com>) id 1iGCsU-0007Yt-2n
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 21:59:32 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.1]) by
 rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee75d96a7726c8-b150a;
 Fri, 04 Oct 2019 09:59:14 +0800 (CST)
X-RM-TRANSID: 2ee75d96a7726c8-b150a
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from [192.168.5.184] (unknown[180.108.8.156])
 by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee15d96a770ec8-9bb6e;
 Fri, 04 Oct 2019 09:59:14 +0800 (CST)
X-RM-TRANSID: 2ee15d96a770ec8-9bb6e
Subject: =?UTF-8?B?UmU6IF9bUEFUQ0hfdjJfMy8zXV90ZXN0cy9taWdyYXRpb27vvJpmaXhf?=
 =?UTF-8?Q?unreachable=5fpath=5fin=5fstress=5ftest?=
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <cover.1568170994.git.maozhongyi@cmss.chinamobile.com>
 <555aac83ecd42d21e6311962e793dd4ce2a77902.1568170994.git.maozhongyi@cmss.chinamobile.com>
 <28738cd1-f32d-6d25-e23f-93d3e96271c9@vivier.eu>
 <0cac9381-6bc4-9431-5cdb-c2353857d476@cmss.chinamobile.com>
 <b39ace2c-5826-69c0-f238-7db82e901c20@vivier.eu>
From: maozy <maozhongyi@cmss.chinamobile.com>
Message-ID: <13706032-5ba3-0be0-471c-2b5845b7d7b2@cmss.chinamobile.com>
Date: Fri, 4 Oct 2019 09:59:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <b39ace2c-5826-69c0-f238-7db82e901c20@vivier.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 221.176.66.80
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
Cc: tony.nguyen@bt.com, alex.bennee@linaro.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 10/3/19 5:23 PM, Laurent Vivier wrote:
> Le 03/10/2019 à 09:17, maozy a écrit :
>> Hi,  Laurent
>>
>> On 10/1/19 11:46 PM, Laurent Vivier wrote:
>>> Le 11/09/2019 à 05:31, Mao Zhongyi a écrit :
>>>> if stress function always return 0, the path
>>>> 'if (stress(ramsizeGB, ncpus) < 0)' is nerver unreachable,
>>>> so fix it to allow the test failed.
>>>>
>>>> Cc: armbru@redhat.com
>>>> Cc: laurent@vivier.eu
>>>> Cc: tony.nguyen@bt.com
>>>>
>>>> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
>>>> ---
>>>>    tests/migration/stress.c | 5 ++---
>>>>    1 file changed, 2 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/tests/migration/stress.c b/tests/migration/stress.c
>>>> index 19a6eff5fd..35903d90c4 100644
>>>> --- a/tests/migration/stress.c
>>>> +++ b/tests/migration/stress.c
>>>> @@ -224,6 +224,7 @@ static int stressone(unsigned long long ramsizeMB)
>>>>                }
>>>>            }
>>>>        }
>>>> +    return 0;
>>>>    }
>>> before the return, we have an infinite loop "while(1) { }".
>>>
>>> So this part is dead code.
>>>
>>> In fact, if the function exits, it's because it fails, otherwise it
>>> loops infinitely, so I think we should change its type to void and
>>> stress should always return -1.
>> Yes, I think it's ok to change stressone typo to void because
>> no one cares about its return value, but if make stress always
>> return -1, main will always exited in exit_failure, like this:
>>
>> ...
>>      if (stress(ramsizeGB, ncpus) < 0)
>>          exit_failure();
>>
>>      exit_success();
>> }
>>
>> so, perhaps also change stress typo to void may be good. then:
>>
>> ...
>>      stress(ramsizeGB, ncpus);
>>
>>      exit_success();
>> }
>>
>> Anther way , make stressone return 0 when infinite loop fails to
>> exit, then main can handle both success and failure case.
>>
>> what do you think?
>>
> 
> If stressone() or stress() exits it's because of a failure because the
> test runs forever otherwise.
> 
> So I think there is no problem to use exit_failure() as the exit
> function of main(): it should never be reached if the test runs without
> error.

OK, I see, thanks a lot.

> 
> Thanks,
> Laurent
> 



