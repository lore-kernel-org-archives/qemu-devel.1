Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0995C10F14
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 09:25:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9831D2133F
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 09:25:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9831D2133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFxMv-0006Id-Nf
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 05:25:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47998)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iFxL2-0004tP-O9
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 05:23:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iFxL0-0008Kq-HI
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 05:23:56 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:35055)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iFxL0-0008Iq-3y
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 05:23:54 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MSLEm-1iia2a2I0m-00Sejc; Thu, 03 Oct 2019 11:23:36 +0200
Subject: =?UTF-8?B?UmU6IF9bUEFUQ0hfdjJfMy8zXV90ZXN0cy9taWdyYXRpb27vvJpmaXhf?=
 =?UTF-8?Q?unreachable=5fpath=5fin=5fstress=5ftest?=
To: maozy <maozhongyi@cmss.chinamobile.com>, qemu-devel@nongnu.org
References: <cover.1568170994.git.maozhongyi@cmss.chinamobile.com>
 <555aac83ecd42d21e6311962e793dd4ce2a77902.1568170994.git.maozhongyi@cmss.chinamobile.com>
 <28738cd1-f32d-6d25-e23f-93d3e96271c9@vivier.eu>
 <0cac9381-6bc4-9431-5cdb-c2353857d476@cmss.chinamobile.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <b39ace2c-5826-69c0-f238-7db82e901c20@vivier.eu>
Date: Thu, 3 Oct 2019 11:23:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <0cac9381-6bc4-9431-5cdb-c2353857d476@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:fno6GBu4CHqM5EMs02PzfNxqJK5eLgYe6vxLNbubSGKeLIo1ld8
 anmMbv3nZwyNMTPBj52oBUlFiKkVMvExT7NDFWymEXJex8kVHrqeEf65ExFjNEWhiaY93ur
 4WYw3Myz8GnsBcHscA85QrGQYqJ6qV8lhXbmWh4YXVLb5Wqk1a7FpVsEylAyjv83nsePdvH
 Y2qc38+kdY1r741HTMOmg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wqfwLMMmZlA=:4n5hlaMD46AULcL9rXfAaC
 sTU3wu93hQb3JesgjnvSw7b/wD5hXXk8yOReB2DSCDwdcot4Tf8IlnMWGfxgqH9liqx+cfwfP
 Nit2bJpogGuhXsaw4+eKDgnw7JjigVaTWzADHd0eH9pCnPCP3Y6et+HaOCDwt1jCyIZnTZboY
 mbNdIvawzDzagXEfFSHx8e2ZpoRRfIkRgxvCYkPvSdUL7jjkc7xQn/MNCcOQA1mk4QnuIXL+j
 S/S3huXFABai7q0vlhYhac1a/Ahdmx3taTfulUlWm3IIIfuBMbmHeiwFxhofzcR8cNzPWeBwO
 Tinu2sr3LhskfWEVSbSzBg3tL9N2NxG2nRwMVEGeDmglefMEMR1IG+iyoxCMzl0OuWO76ATBD
 t/ov5N1ESWbNJMLmiBvcabGrXQN9ErFqX0us93wxDXKXQb79oCOSvAAss9xmn0gNx12tIZhYp
 EvMTFD6iF3EJB0kpfzlib/SpS27iaRdpE/aWXKr6Qu2Ncp23z47goFOclnkIE8JTHNjHZoBHL
 qJl3mOJN07MTWWY0YTlq3QcBKO9Hv+jU5DBbp4Je1WnXCokkmOJwh+zRSeQf8+f1zWeBxW4AI
 2SxaX8YjTJrLkdOkwvU1wIzbH/7ozAa5oaW1VgHglpAl9UwVb4oPQgHoST4DlObuD+rqSs3K8
 pchYrwLYmJ1/UJofAP9DoDa0sQF2L3ccHsvqPvhe84LL819d94L+GtVRgdkXinfV9TVCQoxiX
 rj+PFwLvWZFuGaEECy23ndS7s1bKMnxcN88UlvDACHfHXXxbqZG/y+H6cWgM0mcOsvptkTA23
 IZ/Ts9r3TuosfsNGyP70j9CGcqsW79Q08ywtEf43knona82/asfyqvQWirPCtUYusXhqJvvvg
 O3zL60JtOECAWa59oCgqCJ4nokPUZtr0kV61LEuEc=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.134
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

Le 03/10/2019 à 09:17, maozy a écrit :
> Hi,  Laurent
> 
> On 10/1/19 11:46 PM, Laurent Vivier wrote:
>> Le 11/09/2019 à 05:31, Mao Zhongyi a écrit :
>>> if stress function always return 0, the path
>>> 'if (stress(ramsizeGB, ncpus) < 0)' is nerver unreachable,
>>> so fix it to allow the test failed.
>>>
>>> Cc: armbru@redhat.com
>>> Cc: laurent@vivier.eu
>>> Cc: tony.nguyen@bt.com
>>>
>>> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
>>> ---
>>>   tests/migration/stress.c | 5 ++---
>>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/tests/migration/stress.c b/tests/migration/stress.c
>>> index 19a6eff5fd..35903d90c4 100644
>>> --- a/tests/migration/stress.c
>>> +++ b/tests/migration/stress.c
>>> @@ -224,6 +224,7 @@ static int stressone(unsigned long long ramsizeMB)
>>>               }
>>>           }
>>>       }
>>> +    return 0;
>>>   }
>> before the return, we have an infinite loop "while(1) { }".
>>
>> So this part is dead code.
>>
>> In fact, if the function exits, it's because it fails, otherwise it
>> loops infinitely, so I think we should change its type to void and
>> stress should always return -1.
> Yes, I think it's ok to change stressone typo to void because
> no one cares about its return value, but if make stress always
> return -1, main will always exited in exit_failure, like this:
> 
> ...
>     if (stress(ramsizeGB, ncpus) < 0)
>         exit_failure();
> 
>     exit_success();
> }
> 
> so, perhaps also change stress typo to void may be good. then:
> 
> ...
>     stress(ramsizeGB, ncpus);
> 
>     exit_success();
> }
> 
> Anther way , make stressone return 0 when infinite loop fails to
> exit, then main can handle both success and failure case.
> 
> what do you think?
> 

If stressone() or stress() exits it's because of a failure because the
test runs forever otherwise.

So I think there is no problem to use exit_failure() as the exit
function of main(): it should never be reached if the test runs without
error.

Thanks,
Laurent

