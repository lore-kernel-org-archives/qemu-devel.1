Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1ACDC433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 12:25:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9530222BEF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 12:25:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9530222BEF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxrKd-0003Gk-R7
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 08:25:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58944)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jxrK1-0002s0-47
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 08:24:37 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:38577)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jxrJy-0002Vn-My
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 08:24:36 -0400
Received: from [192.168.100.1] ([82.252.135.186]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MHoZM-1k0cSg29LC-00EsjT; Tue, 21 Jul 2020 14:24:28 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200721085757.14358-1-f4bug@amsat.org>
 <5989e383-eade-7112-7c04-336679734e49@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [RFC PATCH-for-5.1?] tests/tcg/multiarch/linux-test: Skip test if
 nanosleep missing (Travis)
Message-ID: <bb745eb2-74bc-f013-36de-4cb8d6f364f1@vivier.eu>
Date: Tue, 21 Jul 2020 14:24:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <5989e383-eade-7112-7c04-336679734e49@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:OjQS7+G4tUSlwIXla2P7wmgfnd8jLeZF17KD1fCx7Xq8txDx5x/
 EHncTBUnA9ycAl7fgEllnbPAsSWbUShTg6qgEdulrxKYTWTp4vG+rUe0LDhD1XLYEo9Gazc
 M/4xsbRhBocN+/rwaFdPiL7MjkUrk1yl/W/5O7QAa105ywDOGZupcl9350YcGmiRULqtQmf
 t0Wa2dDTGMtrtLhZV01wg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HMcJ6aSgYcY=:Q6mT5kJHqJDT0oqGgVhpTT
 6VzKs79xFO+nzLdUzgJ+HN+q4NpD7KoJKsl2n/4v+c0CkHZAL7MYHKE46UPwLDLwPDeI0bTnJ
 YVnEDmp0GO9PMfhMl3tSFOurXEyqjOIfVnwDBqzULvVdzNQ/zvKLND48KybKhiutmR9FLDASd
 63EEAF2+CwFR2vGvdvgtUhabfot63YUeoEYHmYHnrfMSdIw37MVPR52EFhDsPfxH5DN89T9xV
 AU8zqv9i0upEh8AGOxpUzKN7+r7c03GgDBgrxDOTX8eywHgN6xB7lXGxZGRuGJPgu9vYdT69B
 YTrYtve7XADKOPY+SVTw7JcT+aeKNUY6KjqFhseP5ay3iIqxm8VUMIYUk33RI4UPyqnjU7nJ0
 KmfqWuKNDIOYXUmDgaapLsFAkPm46JIA86o0CTyjVoYj3dhsCKcic9VE0vDEilNFdL/B6GTQx
 knysFW6+ERuXvlviBc2h4wKtbvcPuzU0BpdZL7WiA1Jo7C1S1Yzm3diM0DA+p8qJPnhNS1F45
 Q64xhIDfn5bQ1VqAuf92AJOXzMGqRENlU+pcE3HpyU6Q/UO5zEQ3nXVBeJwDKDR+Hnto6NzZ8
 jtSR/DjxcH8L3IkLfuj2Ax3P1fHjtEiwVc7jM8fjTaWZQiRpbvOBcVV/JGKn9bE5KUWUMt8ei
 PkllVi7hvwMmbp0VULrZCHIFRwvLDDSHrJ3bvxXaoOZ6IU0YcY6WwJfaxkjaqq01azGYa1J7R
 i54y7fvQxtwC7CVfrZ7S7Vb780hd0XGG+LHU07533iC/myy9elh71h96twtnOwryTNULAoTeo
 XwsSrwKiP4JHkXd9A+W1XQrIJDP+EwitlX+g5TohuSQuJJKWZ7hvmj2U9mu3r6p5LI/aVVj
Received-SPF: none client-ip=217.72.192.75; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 08:24:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 21/07/2020 à 13:38, Laurent Vivier a écrit :
> Le 21/07/2020 à 10:57, Philippe Mathieu-Daudé a écrit :
>> The time test sometimes fails on Travis-CI [*]:
>>
>>     TEST    linux-test on aarch64
>>   tests/tcg/multiarch/linux-test.c:237: nanosleep
>>   make[2]: *** [run-linux-test] Error 1
>>   make: *** [run-tcg-tests-aarch64-linux-user] Error 2
>>
>> As this seems due to a container limitation on Travis-CI,
>> simply skip the test there.
>>
>> [*] https://travis-ci.org/github/qemu/qemu/jobs/710005078#L3706
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>> RFC because per Laurent Vivier we are not using the correct libc
>>     while cross-linking the test (maybe change in the container
>>     packages?)
>> ---
>>  tests/tcg/multiarch/linux-test.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/tests/tcg/multiarch/linux-test.c b/tests/tcg/multiarch/linux-test.c
>> index 8a7c15cd31..c7dfdec9ec 100644
>> --- a/tests/tcg/multiarch/linux-test.c
>> +++ b/tests/tcg/multiarch/linux-test.c
>> @@ -233,8 +233,13 @@ static void test_time(void)
>>      ts.tv_sec = 0;
>>      ts.tv_nsec = 20 * 1000000;
>>      chk_error(nanosleep(&ts, &rem));
>> -    if (rem.tv_sec != 1)
>> +    if (rem.tv_sec != 1) {
>> +        if (getenv("TRAVIS_ARCH")) {
>> +            printf("nanosleep missing? skipping 'time' test\n");
>> +            return;
>> +        }
>>          error("nanosleep");
>> +    }
>>      chk_error(gettimeofday(&tv2, NULL));
>>      ti = tv2.tv_sec - tv.tv_sec;
>>      if (ti >= 2)
>>
> 
> Well, in the end I think the problem is in linux-user:
> 
> We copy the "rem" structure even if there is no error, so "1" is
> overwritten.
> 
> We don't have the problem on all architectures because some use
> nanosleep() syscall (that is correct) others use clock_nanosleep()
> syscall that is not correct.
> 
> This should fix the problem:
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 1211e759c26c..130005716ece 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -11831,7 +11831,7 @@ static abi_long do_syscall1(void *cpu_env, int
> num, abi_long arg1,
>          target_to_host_timespec(&ts, arg3);
>          ret = get_errno(safe_clock_nanosleep(arg1, arg2,
>                                               &ts, arg4 ? &ts : NULL));
> -        if (arg4)
> +        if (is_error(ret) && arg4)
>              host_to_target_timespec(arg4, &ts);
> 
>  #if defined(TARGET_PPC)

According to clock_nanosleep(2) it should be in fact:

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 1211e759c26c..63e7cd8947e5 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -11831,8 +11831,9 @@ static abi_long do_syscall1(void *cpu_env, int
num, abi_long arg1,
         target_to_host_timespec(&ts, arg3);
         ret = get_errno(safe_clock_nanosleep(arg1, arg2,
                                              &ts, arg4 ? &ts : NULL));
-        if (arg4)
+        if (ret == -TARGET_EINTR && arg4 && arg2 != TIMER_ABSTIME) {
             host_to_target_timespec(arg4, &ts);
+        }

 #if defined(TARGET_PPC)
         /* clock_nanosleep is odd in that it returns positive errno values.


