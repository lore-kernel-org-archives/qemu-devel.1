Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A333C32792
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 07:19:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F62E20842
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 07:19:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F62E20842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFvOE-0003hK-3y
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 03:19:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34359)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maozhongyi@cmss.chinamobile.com>) id 1iFvNT-0003Gt-VL
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 03:18:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <maozhongyi@cmss.chinamobile.com>) id 1iFvNS-0007Pb-HR
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 03:18:19 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:9575)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <maozhongyi@cmss.chinamobile.com>) id 1iFvNR-0007P0-RK
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 03:18:18 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.17]) by
 rmmx-syy-dmz-app12-12012 (RichMail) with SMTP id 2eec5d95a0a6df0-a8c32;
 Thu, 03 Oct 2019 15:17:59 +0800 (CST)
X-RM-TRANSID: 2eec5d95a0a6df0-a8c32
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from [192.168.5.184] (unknown[180.107.17.228])
 by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee95d95a0a6b8d-7295a;
 Thu, 03 Oct 2019 15:17:59 +0800 (CST)
X-RM-TRANSID: 2ee95d95a0a6b8d-7295a
Subject: =?UTF-8?B?UmU6IF9bUEFUQ0hfdjJfMy8zXV90ZXN0cy9taWdyYXRpb27vvJpmaXhf?=
 =?UTF-8?Q?unreachable=5fpath=5fin=5fstress=5ftest?=
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <cover.1568170994.git.maozhongyi@cmss.chinamobile.com>
 <555aac83ecd42d21e6311962e793dd4ce2a77902.1568170994.git.maozhongyi@cmss.chinamobile.com>
 <28738cd1-f32d-6d25-e23f-93d3e96271c9@vivier.eu>
From: maozy <maozhongyi@cmss.chinamobile.com>
Message-ID: <0cac9381-6bc4-9431-5cdb-c2353857d476@cmss.chinamobile.com>
Date: Thu, 3 Oct 2019 15:17:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <28738cd1-f32d-6d25-e23f-93d3e96271c9@vivier.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 221.176.66.81
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

Hi,  Laurent

On 10/1/19 11:46 PM, Laurent Vivier wrote:
> Le 11/09/2019 à 05:31, Mao Zhongyi a écrit :
>> if stress function always return 0, the path
>> 'if (stress(ramsizeGB, ncpus) < 0)' is nerver unreachable,
>> so fix it to allow the test failed.
>>
>> Cc: armbru@redhat.com
>> Cc: laurent@vivier.eu
>> Cc: tony.nguyen@bt.com
>>
>> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
>> ---
>>   tests/migration/stress.c | 5 ++---
>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/tests/migration/stress.c b/tests/migration/stress.c
>> index 19a6eff5fd..35903d90c4 100644
>> --- a/tests/migration/stress.c
>> +++ b/tests/migration/stress.c
>> @@ -224,6 +224,7 @@ static int stressone(unsigned long long ramsizeMB)
>>               }
>>           }
>>       }
>> +    return 0;
>>   }
> before the return, we have an infinite loop "while(1) { }".
>
> So this part is dead code.
>
> In fact, if the function exits, it's because it fails, otherwise it
> loops infinitely, so I think we should change its type to void and
> stress should always return -1.
Yes, I think it's ok to change stressone typo to void because
no one cares about its return value, but if make stress always
return -1, main will always exited in exit_failure, like this:

...
     if (stress(ramsizeGB, ncpus) < 0)
         exit_failure();

     exit_success();
}

so, perhaps also change stress typo to void may be good. then:

...
     stress(ramsizeGB, ncpus);

     exit_success();
}

Anther way , make stressone return 0 when infinite loop fails to
exit, then main can handle both success and failure case.

what do you think?

Thanks,
Mao
> Thanks,
> Laurent
>



