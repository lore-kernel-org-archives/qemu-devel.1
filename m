Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04933C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 23:36:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2B9A20739
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 23:36:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2B9A20739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaSKS-0005eJ-TN
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 18:36:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51700)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kaSJ9-0004eZ-QP; Wed, 04 Nov 2020 18:35:15 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:41145)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kaSJ7-0004RC-FH; Wed, 04 Nov 2020 18:35:15 -0500
Received: from [192.168.100.1] ([82.252.154.198]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MxVfj-1kPMXc1OZ7-00xs4P; Thu, 05 Nov 2020 00:35:09 +0100
Subject: Re: [QEMU] Question regarding user mode support for ARM syscalls
To: Lukasz Majewski <lukma@denx.de>, Alistair Francis <alistair23@gmail.com>
References: <20201103120027.6fdc868c@jawa>
 <CAKmqyKOFxO+NoyA0N2HbNDujKdDg4vFyMvpq=6+TPPxx4-VMFw@mail.gmail.com>
 <20201103175532.796074fb@jawa>
 <CAKmqyKNRU8EqcyVv4gduNsKcMOUWSmW2oWTvfWMNS3C70Nx9PQ@mail.gmail.com>
 <20201104115706.154e76a4@jawa>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <bd34a46a-545b-49d4-7696-e62599947b83@vivier.eu>
Date: Thu, 5 Nov 2020 00:35:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201104115706.154e76a4@jawa>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:gGRlV9IQoAwrkt6pJYnT78Pz5DTtJDlPivsJrH/H3q3k+JHY3ex
 kqG9hDk5qSToFNNgJFYAiqj0KUUGgS2SieIhRQF9UoD4rStPVoar3RUE1jOFF+C8EKyNbCY
 zj018IXFmAvQ5Sl77TlKerv4UeLquFyEYp/SH7O/i4HQBOU25d2OByxWWiX638Tr+ErV979
 mIyCbpW222L/cCdj5E8VA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:e6Y42seEdj0=:6qmCcAtf9Ugnmp7mxl5BJz
 i6R01asNnRpWHRmACkZBiqDFLgaJozW84iUQKRxlVZYbboTOb3edTssjlxBSPyHls/w0WIzTX
 XiFidVzrAfSvYmBKaW4ukh1pGNIeseC2vZg59YEk/UrVS9awRtF9K8Cx3NjrgNsUfNnAMCdyo
 GIY5Rc8GUOE6G5RgH7C/Y7OUV4/kagpVRGoKManEkz3sBk3MxG1nWklfZSi5FqGN4nh+zmfiF
 Y6YC2a5dKxNaG5ACCQwzxD34ft3xhhZjwwMo2nDvpvm9mRN+Yf7YhJiQOEImtkeQQJS65akT6
 /YaLxZYD81rN58YlIduvb4wV7mfOjlSESs70bk+ymhorCCrLQzE4njFAR7O7/ig3yvtSJpVyz
 /6PIvfnb6JDy8Zz6fjUEKb04uwOu9vBm+6B2p1UVjMgY6JsloR28a+PAyi3d0
Received-SPF: none client-ip=217.72.192.73; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 18:35:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: GNU C Library <libc-alpha@sourceware.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 qemu-discuss <qemu-discuss@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 04/11/2020 à 11:57, Lukasz Majewski a écrit :
> Hi Alistair,
> 
>> On Tue, Nov 3, 2020 at 8:55 AM Lukasz Majewski <lukma@denx.de> wrote:
>>>
>>> Hi Alistair,
>>>  
>>>> On Tue, Nov 3, 2020 at 3:03 AM Lukasz Majewski <lukma@denx.de>
>>>> wrote:  
>>>>>
>>>>> Dear Qemu Community,  
>>>>
>>>> Hey Lukasz,
>>>>
>>>> + QEMU Dev Mailing list
>>>> + Laurent
>>>>  
>>>
>>> Thanks for reaching more people.
>>>  
>>>>>
>>>>> I would like to ask you for some advice regarding the usage of
>>>>> arm-linux-user/qemu-arm user space program simulation.
>>>>>
>>>>> Background:
>>>>> -----------
>>>>>
>>>>> I'm looking for a way to efficiently test y2038 in-glibc
>>>>> solution for 32 bit architectures (e.g. ARM).
>>>>>
>>>>> For now I do use qemu-system-arm (part of Yocto/OE), which I'm
>>>>> using to run Linux kernel 5.1, glibc under test and Y2038
>>>>> tests. It works [1].
>>>>>
>>>>> Problem:
>>>>> --------
>>>>>
>>>>> I would like to test cross-compiled tests (which are built from
>>>>> glibc sources) without the need to run the emulated system with
>>>>> qemu-system-arm.
>>>>>
>>>>> I've come across the "QEMU user mode", which would execute the
>>>>> cross-compiled test (with already cross-compiled glibc via -L
>>>>> switch) and just return exit status code. This sounds
>>>>> appealing.  
>>>>
>>>> As another advantage it is much, much faster at running the glibc
>>>> tests.
>>>>  
>>>
>>> +1
>>>  
>>>>>
>>>>> As fair as I've read - QEMU user mode emulates ARM syscalls.
>>>>>
>>>>> During test execution (single qemu user mode process) I would
>>>>> need to adjust date with clock_settime64 syscall and then
>>>>> execute other syscalls if needed.
>>>>>
>>>>>
>>>>> Please correct me if I'm wrong:
>>>>> - It looks like qemu-arm doesn't have switch which would allow
>>>>> it to set time offset (to e.g. year 2039 - something similar to
>>>>>   qemu-system-arm -rtc=).
>>>>>
>>>>> - As of 5.1 qemu version there is no support for syscalls
>>>>> supporting 64 bit time on 32 bit architectures (e.g.
>>>>> clock_settime64 and friends from [2]).  
>>>>
>>>> There is some support in the current master, for example
>>>> __NR_futex_time64 is supported.  
>>>
>>> I've just looked into v5.1.0 stable release. I will double check
>>> this with -master branch.
>>>  
>>>>
>>>> I started to add some support for RV32 once it was merged into
>>>> glibc.  
>>>
>>> Ok.
>>>  
>>>>  
>>>>>
>>>>> For my example program [3] statically build for testing (it
>>>>> works with qemu-system-arm):
>>>>>
>>>>> ~/work/qemu-arm-tests-program$
>>>>> ../qemu-5.1.0-arm/arm-linux-user/qemu-arm -L
>>>>> ~/work/yocto/y2038/build/tmp/armv7at2hf-neon-poky-linux-gnueabi/y2038-glibc/2.30+git999-r0/image/opt
>>>>> -strace ./cst
>>>>>
>>>>> 17746 brk(NULL) = 0x00074000
>>>>> 17746 brk(0x000748a8) = 0x000748a8
>>>>> 17746 uname(0x40800370) = 0
>>>>> 17746 readlink("/proc/self/exe",0x407ff488,4096) = 43
>>>>> 17746 brk(0x000958a8) = 0x000958a8
>>>>> 17746 brk(0x00096000) = 0x00096000
>>>>> 17746 mprotect(0x00070000,8192,PROT_READ) = 0
>>>>> 17746statx(1,"",AT_EMPTY_PATH|AT_NO_AUTOMOUNT,STATX_BASIC_STATS,0x407ffd70)
>>>>> = 0
>>>>> 17746 Unknown syscall 404 --> is the syscall number of
>>>>> clock_settime64  
>>>>
>>>> clock_settime64 is supported in master QEMU.  
>>>
>>> I will double check it - thanks for pointing this out.
>>>  
>>>>  
>>>>>
>>>>> 17746 dup(2) = 3
>>>>> 17746 fcntl64(3,F_GETFL) = 2
>>>>> 17746statx(3,"",AT_EMPTY_PATH|AT_NO_AUTOMOUNT,STATX_BASIC_STATS,0x407ff8e8)
>>>>> = 0 ERR
>>>>>
>>>>> Questions:
>>>>> ----------
>>>>>
>>>>> 1. Is there any plan to add support for emulating syscalls
>>>>> supporting 64 bit time on 32 bit architectures [2]?  
>>>>
>>>> I would like to have RV32 supported, but it's a low priority for
>>>> me.  
>>>
>>> Having syscalls supporting 64 bit time on 32 bit machines indicated
>>> in [2] would be a very welcome for glibc testing.
>>>  
>>>> I
>>>> expect it's something that will eventually happen though.  
>>>
>>> Ok.
>>>  
>>>>  
>>>>>
>>>>> 2. Provide QEMU user space switch to adjust its time (i.e. add
>>>>> some offset to in-fly emulated time syscalls - like
>>>>> clock_settime64) when it is started?  
>>>>
>>>> That I'm not sure about.  
>>>
>>> For me it would be enough to have:
>>>
>>> qemu-arm -rtc="2039-01-01" -L... ./ctx
>>> So the emulated "time" would be after 32 bit time_t overflow when
>>> QEMU user space emulation process starts (as long as it doesn't
>>> touch the host machine time).
>>>
>>>
>>> Another option (workaround) would be to run clock_settime64() with
>>> time set to year 2038+ on the beginning of each glibc test. It
>>> shall work as long as we don't change host time (and all time
>>> changes would stay in the qemu user mode process).
>>>  
>>>> I assume just running date/clock_settime64
>>>> from a script wouldn't work with the glibc test framework?  
>>>
>>> Could you elaborate on this use case/scenario? Do you have some
>>> examples to share?  
>>
>> Whoops, I got confused here. The clock_gettime syscall goes to the
>> host, so we just report host time. I was thinking about softMMU where
>> we maintain our own time.
>>
>> So your proposed `-rtc` command would add an offset to the host time?
>> Something like:
>>
>> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
>> index 3160a9ba06..240bd59bb2 100644
>> --- a/linux-user/syscall.c
>> +++ b/linux-user/syscall.c
>> @@ -12074,6 +12074,7 @@ static abi_long do_syscall1(void *cpu_env, int
>> num, abi_long arg1,
>>
>>          ret = target_to_host_timespec64(&ts, arg2);
>>          if (!is_error(ret)) {
>> +            ts.tv_sec -= 567993505;
>>              ret = get_errno(clock_settime(arg1, &ts));
>>          }
>>          return ret;
>> @@ -12096,6 +12097,8 @@ static abi_long do_syscall1(void *cpu_env, int
>> num, abi_long arg1,
>>          struct timespec ts;
>>          ret = get_errno(clock_gettime(arg1, &ts));
>>          if (!is_error(ret)) {
>> +            // Calculate different to same time in 2038
>> +            ts.tv_sec += 567993505;
>>              ret = host_to_target_timespec64(arg2, &ts);
>>          }
>>          return ret;
>>
>> That might end up working if you can intercept all of the absolute
>> time syscalls.
> 
> It looks to me that intercepting _all_ time related syscalls seems to
> be a time consuming task.
> 
>>
>> Without any mainline support that would be easy to do in your local
>> tree,
> 
> The "local tree" solution is not an acceptable solution for me.
> 
>> which would at least allow you to test. You could also change
>> your host time to 2038, but that would break things for your host.
> 
> Yes, I would like to avoid changing the host time.
> 
>

I didn't read all the mail history but I think you should play with the
time namespace, see "unshare" and "--time" parameter.

https://man7.org/linux/man-pages/man1/unshare.1.html
https://man7.org/linux/man-pages/man7/time_namespaces.7.html

Thanks,
Laurent

