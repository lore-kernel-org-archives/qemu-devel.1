Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F09EC0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 18:53:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DA622080C
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 18:53:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DA622080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hikNi-00057R-Hg
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 14:53:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57426)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hijj4-0000cq-Sx
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 14:11:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hijj3-0002Ww-Kq
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 14:11:26 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:35925)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1hijj0-0002Us-Jt; Wed, 03 Jul 2019 14:11:22 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1Mr8zO-1iLcem42Fi-00oEjU; Wed, 03 Jul 2019 20:11:19 +0200
To: Justin Hibbits <chmeeedalf@gmail.com>
References: <20190702123713.14396-1-laurent@vivier.eu>
 <CAFEAcA_Zu0X1zLfKtBkQdi25KCkjf_PNu8zKWE5Dx7uzzLEzBA@mail.gmail.com>
 <5d7fa8ef-c56c-1f90-d5d6-b230d1e3f363@vivier.eu>
 <EBA933C4-69B4-43BF-9049-FF1E6A327429@vivier.eu>
 <20190703120906.00a6976e@titan.knownspace>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <cb82ac63-d806-3ce4-137b-640558da5e4a@vivier.eu>
Date: Wed, 3 Jul 2019 20:11:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190703120906.00a6976e@titan.knownspace>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:9VnjaZ9WpQrCKxPdXBEQiwpV8FzLzRXipr0OdxR4ZagLaPAecIl
 X2PlYwxrrwmatUWILuSe+nv0RSwgc54XKyUnDwpWp865IMwrwtqp1aZj+Kmi98lY4vQfuRT
 vkKmldU7Wi5fur0BmTYZox+UAcI/YjXrfsvhoYcwfhbfL3NNf40smMYfVg7KowBtxSQUjAJ
 mkZzy0M+EMTuSnH7tYfFg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WLMIoT8etMY=:Bq/gJZfY/JrokxTpOM/i3I
 UjVS6CMFaoxlN6ndKsKnlnoBIPSLbtS37Dq/SJ1TNhRsYgDww1weog4wHj77mWrpNHdqbVJp7
 fcg7XvYhNAPk2qgbDPLtnI9P0D3HjiikS0Ejs1yu1Go7kbY8f0qPY+iSNvtmpoYk6irF5ps5b
 rmZhyqka3r8nz+448koe+ttYv0ojMoowxMLFC280A2A5pPjMgmq6IdSQ1nZZxlPbyCqKzknjZ
 O8uzWN8cqJSI3CT3QI/AhzZuEbux2TNNlN6CyaeC+Jf76nWfRLHejtfTFRnIlKtH+ah1AzVsu
 2Myp5mcC33rwZHTxBiOUGiPt3FHs7/kB2+n2Ta6fBaw85Ebm4WRe15Ox4tFFg7567uoHCHS55
 tOJUaAHk82j1k8c7vFB/P8Ci53wjdm0a6LGKQXrgyikUELDi3mBh7/MItLzUcLoTlchXMRfPi
 sZwAa0J2VxBzUZUMWXmHf55d9iiJKrYZAWFNYvFB1jHIunI4rycqoVsmeSsnHUcQ4a8vfgDap
 8QpDsgEawS5Zn8Yg4OFrKUnU+PMaJQN7A8+SRQS1cv5mq/yfEwTwTbGRXyJjLTZkNRlDoghxo
 3uYC/tK8+Cs0o8eI+gtQual9l1jQ15WVUyOVNxIAumtfzSxLKGM0Ml5teaU6UWD4OT0i2nFOE
 xDpy7TqetV4SKrRb/Htlu0MKHoiFi1isk8giUOPI9CXwGQXf3I1BN7Bit2/zQunEAnfx9AHWb
 F35wvL2OarksfnfgILa4biDkIv0+miG7+impwETZoMY0ShcC/DJmcGoBFgs=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.135
Subject: Re: [Qemu-devel] [PULL 0/3] Trivial branch patches
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 03/07/2019 à 19:09, Justin Hibbits a écrit :
> On Wed, 3 Jul 2019 18:12:51 +0200
> Laurent Vivier <laurent@vivier.eu> wrote:
> 
>>> Le 3 juil. 2019 à 17:22, Laurent Vivier <laurent@vivier.eu> a
>>> écrit :
>>>
>>> Le 03/07/2019 à 16:45, Peter Maydell a écrit :  
>>>> On Tue, 2 Jul 2019 at 13:39, Laurent Vivier <laurent@vivier.eu>
>>>> wrote:  
>>>>>
>>>>> The following changes since commit
>>>>> 7d0e02405fc02a181319b1ab8681d2f72246b7c6:
>>>>>
>>>>>  Merge remote-tracking branch
>>>>> 'remotes/vivier2/tags/trivial-patches-pull-request' into staging
>>>>> (2019-07-01 17:40:32 +0100)
>>>>>
>>>>> are available in the Git repository at:
>>>>>
>>>>>  git://github.com/vivier/qemu.git tags/trivial-branch-pull-request
>>>>>
>>>>> for you to fetch changes up to
>>>>> 7c955080d40ccc7952a0479bc160f2b048c0af53:
>>>>>
>>>>>  docs/devel/testing: Fix typo in dockerfile path (2019-07-02
>>>>> 10:12:32 +0200)
>>>>>
>>>>> ----------------------------------------------------------------
>>>>> Fix typo, fix sys_cache_info() on FreeBSD/powerpc,
>>>>> change virtio-rng default to urandom
>>>>>
>>>>> ----------------------------------------------------------------  
>>>>
>>>> Hi; this makes 'make check' fail on OSX:
>>>>
>>>> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
>>>> tests/test-char -m=quick -k --tap < /dev/null |
>>>> ./scripts/tap-driver.pl --test-name="test-char"
>>>> Assertion failed: ((isize & (isize - 1)) == 0), function
>>>> init_cache_info, file
>>>> /Users/pm215/src/qemu-for-merges/util/cacheinfo.c, line 179.
>>>>
>>>> I guess this is the sys_cache_info change.  
>>>
>>> OK, I will try to reproduce the problem.
>>>
>>> I think before this patch (regarding the kind of change we have
>>> introduced) isize and dsize were always set to 0 and then changed
>>> to 16 in fallback_cache_info()... or perhaps MacOS X sysctlbyname()
>>> needs a long.  
>>
>> It seems MacOS X (x86_64) needs a long:
>>
>> #include <stdio.h>
>> #include <sys/types.h>
>> #include <sys/sysctl.h>
>>
>> int main(void)
>> {
>>         long size;
>>         int ret;
>>         size_t len = sizeof(size);
>>         ret = sysctlbyname("hw.cachelinesize", &size, &len, NULL, 0);
>>         printf("ret %d size 0x%lx\n", ret, size);
>>         return 0;
>> }
>> $ cc -o cachesize cachesize.c
>> $ ./cachesize 
>> ret 0 size 0x40
>>
>> #include <stdio.h>
>> #include <sys/types.h>
>> #include <sys/sysctl.h>
>>
>> int main(void)
>> {
>>         int size;
>>         int ret;
>>         size_t len = sizeof(size);
>>         ret = sysctlbyname("hw.cachelinesize", &size, &len, NULL, 0);
>>         printf("ret %d size 0x%x\n", ret, size);
>>         return 0;
>> }
>> $ cc -o cachesize cachesize.c
>> $ ./cachesize 
>> ret 0 size 0x1737b1d2
>> $ sysctl hw.cachelinesize
>> hw.cachelinesize: 64
>>
>> But man page is not up-to-date:
>>
>> $ uname -r
>> 17.7.0
>> $ man sysctl
>> SYSCTL(8)                 BSD System Manager's Manual
>> SYSCTL(8) …
>>      The string and integer information is summarized below.  For a
>> detailed description of these variable see sysctl(3).
>>
>>      The changeable column indicates whether a process with
>> appropriate privi- lege can change the value.  String and integer
>> values can be set using sysctl.
>>
>>      Name                                        Type
>> Changeable …
>>      hw.cachelinesize                            integer       no
>> …
>>
>> In fact, it is in sysctl(3):
>>
>> SYSCTL(3)                BSD Library Functions Manual
>> SYSCTL(3) …
>>    CTL_HW
>>      The string and integer information available for the CTL_HW
>> level is detailed below.  The changeable column shows whether a
>> process with appropriate privilege may change the value.
>>
>>            Name                         Type          Changeable
>> ...
>>            hw.cachelinesize             int64_t       no
>>
>> I will try to check on MacOS/X ppc and ppc64.
>>
>> Thanks,
>> Laurent
>>
> 
> It's not listed in the man page for ppc(64), but examining the XNU
> source for the version that matches 10.5.8 (last ppc-supporting kernel)
> it's a CTLTYPE_INT.  So, it may be different depending on arch and/or
> OS X version.  Does QEmu even support 10.5.x or Mac OS/ppc* anymore?  I
> had read somewhere that it was unsupported now (2.4.x is the latest one
> in Tigerbrew).

in bsd/sys/sysctl.h, for latest xnu (xnu-4903.221.2, 10.14.1), I have also CTLTYPE_INT.

I think the thing to do is change the type only for FreeBSD and keep "long" for APPLE.

Thanks,
Laurent

