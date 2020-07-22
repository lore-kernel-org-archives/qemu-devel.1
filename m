Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23716C433E5
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 12:09:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBC1120771
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 12:09:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBC1120771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyDYl-00058p-8T
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 08:09:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43782)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jyDTy-0000uO-8B
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 08:04:23 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:60959)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jyDTv-0005kC-T8
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 08:04:21 -0400
Received: from [192.168.100.1] ([82.252.135.186]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MrQR7-1kdrPx1DdP-00oViz; Wed, 22 Jul 2020 14:03:30 +0200
Subject: Re: [PATCH v2 12/12] linux-user: fix clock_nanosleep()
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200722062902.24509-1-alex.bennee@linaro.org>
 <20200722062902.24509-13-alex.bennee@linaro.org>
 <2c1c17a6-9bae-322b-9e28-722d11074405@vivier.eu> <87365kudwv.fsf@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <844fdfc7-1c2e-87c7-3889-7ed6cdc65dee@vivier.eu>
Date: Wed, 22 Jul 2020 14:03:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <87365kudwv.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:TdaHZ4ZJreaIxUuVZvgXfR0kEwIMV78YVayRDgaMXnbCIxDWVP4
 2Y/80l5sYDMThY04enAJAa5HRMsKy38NH7/K5Z7MWfLBv7nnCLbS4iAKPHnWsrilZS3SOdz
 r0GAqaBUgM6JS1UYsbyi58HlfHeYF1aKaC8w1WDpX0fMWDxL++f+DjuyCp9PiU8grk7Jl+N
 WT0sDKj4sAHrTh4feQUHA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vLnNIGyvJSI=:3PUi5wm0+SCe5SbJv39t6g
 lfYaULJzC6lMHTJ0tM51aicyYRV4ivUi+rPeA+zkVVBeqUMJHPM9llrjJfDwcv/euZVNoACeQ
 3VZDsDceAAM76XlWeqy5olIyO0loyVFyTrCZM7E8q0B94vpzpg2liJ3r8Ytz2vzwy6Y9srr+8
 n4ekN1b1iD8v65Dv410tMMp1bom2cJucw8TF2MNX6baVaRvb+1QemhifP/UafGEQVPIKMDoWf
 uQC1ewgMalF+bn1EQ3bwRondxtmmwZsosxipteUEpoqSBE8XlnR+yzYxeStIzlUi5Wm5+PHO8
 7itEpLZdxPe3iF7YrO1DS33vsx5Hwd59nZRuG4L33nJxvjNiv6bukHiL14kCzEpfOU4MTZJam
 XD93ktkEU7/fGQ02us0NgZKUlvwEB5JqRUAj5zZGtC4PnrrKsTm6Y5bhhwSqcKfmmoMHu69yb
 gNvl53ClGua5npuStz6tVB99yb8MtnkxN+AbPbmolxMnGNpCdNEnqR9TP/ebZjGb5O0DiYqoh
 qkWkTVWlgwaJObgTvsn3POIp6YlsjP6IFXfneeUNToPlZMrwyTCxG4/E77VS4npvDaL0XtXeh
 VlfM6E3MMifCsqMdPYv5Zvt8Olz78AZGEIu/qqFF5mU/SAA80yX4UWbbdibkQela3IuTJwUOU
 OqerhhBYoPk9Dtqw+HD3/0fJhXWi1TNFchYV/S6n6RTxOAfMKQNmRdDrU+wh3UfVi5fpjzskj
 pfNxcggBTorJOk4NEGo6aaMugLEoeuU4Rjzy3m1Wq/eVG5dWrkdNX5O9qFj9DlMRIGxusreUs
 aJB6gRyDMM+G6ZRmKLMEun+XdLInebvz+35ge/S8djkyNXZPMEWCSFZDM1n8/hMOAYPR2Dw
Received-SPF: none client-ip=212.227.17.10; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 08:04:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: fam@euphon.net, berrange@redhat.com, richard.henderson@linaro.org,
 qemu-devel@nongnu.org, f4bug@amsat.org, cota@braap.org, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 22/07/2020 à 10:55, Alex Bennée a écrit :
> 
> Laurent Vivier <laurent@vivier.eu> writes:
> 
>> Le 22/07/2020 à 08:29, Alex Bennée a écrit :
>>> From: Laurent Vivier <laurent@vivier.eu>
>>>
>>> If clock_nanosleep() encounters an error, it returns one of the positive
>>> error number.
>>>
>>> If the call is interrupted by a signal handler, it fails with error EINTR
>>> and if "remain" is not NULL and "flags" is not TIMER_ABSTIME, it returns
>>> the remaining unslept time in "remain".
>>>
>>> Update linux-user to not overwrite the "remain" structure if there is no
>>> error.
>>>
>>> Found with "make check-tcg", linux-test fails on nanosleep test:
>>>
>>>   TEST    linux-test on x86_64
>>> .../tests/tcg/multiarch/linux-test.c:242: nanosleep
>>> make[2]: *** [../Makefile.target:153: run-linux-test] Error 1
>>> make[1]: *** [.../tests/tcg/Makefile.qemu:76: run-guest-tests] Error 2
>>> make: *** [.../tests/Makefile.include:857: run-tcg-tests-x86_64-linux-user] Error 2
>>>
>>> Reported-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
>>> Message-Id: <20200721201754.2731479-1-laurent@vivier.eu>
>>> ---
>>>  linux-user/syscall.c | 15 ++++++++++++---
>>>  1 file changed, 12 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
>>> index 1211e759c26..caa7cd3cab9 100644
>>> --- a/linux-user/syscall.c
>>> +++ b/linux-user/syscall.c
>>> @@ -11829,10 +11829,19 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>>>      {
>>>          struct timespec ts;
>>>          target_to_host_timespec(&ts, arg3);
>>> -        ret = get_errno(safe_clock_nanosleep(arg1, arg2,
>>> -                                             &ts, arg4 ? &ts : NULL));
>>> -        if (arg4)
>>> +        /*
>>> +         * clock_nanosleep() returns 0 or one of the *positive* error number.
>>> +         */
>>> +        ret = host_to_target_errno(safe_clock_nanosleep(arg1, arg2, &ts,
>>> +                                                        arg4 ? &ts : NULL));
>>> +        /*
>>> +         * if the call is interrupted by a signal handler, it fails
>>> +         * with error TARGET_EINTR and if arg4 is not NULL and arg2 is not
>>> +         * TIMER_ABSTIME, it returns the remaining unslept time in arg4.
>>> +         */
>>> +        if (ret == TARGET_EINTR && arg4 && arg2 != TIMER_ABSTIME) {
>>>              host_to_target_timespec(arg4, &ts);
>>> +        }
>>>  
>>>  #if defined(TARGET_PPC)
>>>          /* clock_nanosleep is odd in that it returns positive errno values.
>>>
>>
>> Wait a little before pushing that: I've made more tests and it seems to
>> break something in LTP. I have to analyze.
> 
> OK - which LTP test does it break?

clock_nanosleep01

> 
> I can drop from the PR if we don't have a clean-up by then (Fri?).

I have a fix. I'm testing it. I will send the v2 today.

https://github.com/vivier/qemu/commit/25060f425e71c57112a334d9930f234011d079a1

Thanks,
Laurent

