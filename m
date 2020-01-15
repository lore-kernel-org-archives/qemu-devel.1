Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D471EC32771
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 16:51:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 992BF214AF
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 16:51:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 992BF214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irlte-0005h1-Nz
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 11:51:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36312)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1irle0-00012X-7u
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 11:35:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1irldw-0005Or-9W
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 11:35:48 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:47341)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1irldv-0005OW-Vx
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 11:35:44 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1M5wTt-1ikJWR0tkR-007UfZ; Wed, 15 Jan 2020 17:35:24 +0100
Subject: Re: [PATCH 00/12] linux-user: Add support for real time clock and
To: Filip Bozuta <Filip.Bozuta@rt-rk.com>, qemu-devel@nongnu.org
References: <1579103618-20217-1-git-send-email-Filip.Bozuta@rt-rk.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <956c6158-803b-3196-ff92-8dfd2fc03295@vivier.eu>
Date: Wed, 15 Jan 2020 17:35:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <1579103618-20217-1-git-send-email-Filip.Bozuta@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:uWMhtREPqW/2ufp2hDy8qCiAg54IBZLC3Kq462rsqIEUdzhJ6XB
 wrvrF/BBbsu6V7WDqIPVwy2cjUoAPu1e4tc8MUpZ0hmaexSjBAZuUofQHDi0M0JVwnS0F8h
 b7rXIRpk+f8DjB7bsaTBsMEOBXle0b+3QUYyCeu6F6IowKXGjTIa09xOJXCeTBVN8zcn6St
 jZddVZveZDY2sC9tszUZw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Gf8g1C3diA4=:7pVbTsA8Qw1ZZ8xOdmmAuU
 NVa04n+Uvr4rj+pwrzjxLlnU6JckcpNGLPg62v4E9MnM3LpZzCf9ogu5FjNWw+l8Hl3lILsE0
 9eqj/TOXpj+PMBqx4VSZTg6TvgeC7YSLue8yY0QJOXAprHiaorXH6fXdyUPohubDl5sNDWDpC
 T/A4J0fiT+ClQxpLs89fENTu1mGOpS8+F71qXNsla4VbzZW7zrrNf/oDBuPIhrEFY3m31AtSq
 gA7rUfQ/TUcrgzAYI+wAqPhy854YMKCHa5qPWvyqSXN8X2ONT6NDI1Tfp5yGuuUUdfmZOY20l
 9Q7t7OuU3LIKPIlPFu7rVUfOFKAjr+1REgVn2VzYCB8u3vJL5Pia1gz9BYXPQ//PT3DXKhKKp
 YBOXKV4RrNR94w3B/QkzjP+v3tvkOOxnLHrRaT3Pl8iT7+9euB4tdty23OYEBix3pvx7UlthJ
 V+oQHPj/CIB9Zpa0JNxlzUGvaZBc0O0cnWaQcG2QcpeBMm55NSQv2tyHtMQiVfpGkCOH9ScDR
 CN1nRvMO4XpHbGhB28Ew/T9Xewwd1PC7NTj8or8ZUvpON4shphhymeQAqwzIZYztjUCt8EBMe
 1ebp3RqTm9+5bkxy5Qz21+R+PI73ttz36jZ0HRN4ow+cm+rKfKOwDf1G+j9H5miHggZQHUdk9
 3grZOy177QeJamrqsMKFkheVjLX+BDnK5EPX1VeXq0iaSzKsvbuSxZPi55x4KcSluSLDycKBw
 Q9C4ej8SY75f8WSM2oN3e4/PCDQj7PJROohPKHXzJkXiUS0irGVM1yA+dqoEi6AyrS3jpRoh4
 hxG+eCmY1bUex6EEh09p6AspUJZ+d0hfjNd58+VgyoUCEPu4XX90fAsYXsiS6NgRbPWPbPjc0
 r/fzQSXyR8zS9pxm/5QA==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.17.10
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, arnd@arndb.de,
 richard.henderson@linaro.org, jcmvbkbc@gmail.com, amarkovic@wavecomp.com,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Filip,

for the next time, please add the version number in the subject of all
the patches of the series, for instance:

  [PATCH v6 XX/12]

Thanks,
Laurent

Le 15/01/2020 à 16:53, Filip Bozuta a écrit :
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> This series covers following RTC and sound timer ioctls:
> 
>   RTC ioctls(22):
> 
>     * RTC_AIE_ON          * RTC_ALM_SET         * RTC_WKALM_SET
>     * RTC_AIE_OFF         * RTC_ALM_READ        * RTC_WKALM_RD
>     * RTC_UIE_ON          * RTC_RD_TIME         * RTC_PLL_GET
>     * RTC_UIE_OFF         * RTC_SET_TIME        * RTC_PLL_SET
>     * RTC_PIE_ON          * RTC_IRQP_READ       * RTC_VL_READ
>     * RTC_PIE_OFF         * RTC_IRQP_SET        * RTC_VL_CLR
>     * RTC_WIE_ON          * RTC_EPOCH_READ
>     * RTC_WIE_OFF         * RTC_EPOCH_SET
> 
>   Sound timer ioctls(14):
> 
>     * SNDRV_TIMER_IOCTL_PVERSION          * SNDRV_TIMER_IOCTL_INFO
>     * SNDRV_TIMER_IOCTL_NEXT_DEVICE       * SNDRV_TIMER_IOCTL_PARAMS
>     * SNDRV_TIMER_IOCTL_TREAD             * SNDRV_TIMER_IOCTL_STATUS
>     * SNDRV_TIMER_IOCTL_GINFO             * SNDRV_TIMER_IOCTL_START
>     * SNDRV_TIMER_IOCTL_GPARAMS           * SNDRV_TIMER_IOCTL_STOP
>     * SNDRV_TIMER_IOCTL_GSTATUS           * SNDRV_TIMER_IOCTL_CONTINUE
>     * SNDRV_TIMER_IOCTL_SELECT            * SNDRV_TIMER_IOCTL_PAUSE
> 
> The functionalities of individual ioctls were described in this series
> patch commit messages.
> 
> Testing method for RTC ioctls:
> 
>     Mini test programs were written for each ioctl. Those programs were
>     compiled (sometimes using cross-compilers) for the following
>     architectures:
> 
>         * Intel 64-bit (little endian)
>         * Power pc 32-bit (big endian)
>         * Power pc 64-bit (big endian)
> 
>     The corresponding native programs were executed without using
>     QEMU on following hosts:
> 
>         * Intel Core i7-4790K (x86_64 host)
>         * Power 7447A (ppc32 host)
> 
>     All applicable compiled programs were in turn executed through QEMU
>     and the results obtained were the same ones gotten for native
>     execution.
> 
>     Example of a test program:
> 
>         For ioctl RTC_RD_TIME the following test program was used:
> 
>         #include <stdio.h>
>         #include <stdlib.h>
>         #include <linux/rtc.h>
>         #include <fcntl.h>
>         #include <linux/input.h>
>         #include <sys/types.h>
>         #include <unistd.h>
> 
>         #define ERROR -1
> 
>         int main()
>         {
> 
>             int fd = open("/dev/rtc", O_RDWR | O_NONBLOCK);
> 
>             if(fd == ERROR)
>             {
>                 perror("open");
>                 return -1;
>             }
> 
>             struct rtc_time cur_time;
> 
>             if(ioctl(fd, RTC_RD_TIME, &cur_time) < 0)
>             {
>                 perror("ioctl");
>                 return -1;
>             }
> 
>             printf("Second: %d, Minute: %d, Hour: %d, Day: %d, Month: %d, Year: %d,",
>                 cur_time.tm_sec, cur_time.tm_min, cur_time.tm_hour, 
>                 cur_time.tm_mday, cur_time.tm_mon, cur_time.tm_year);
> 
>             return 0;
>         }
> 
>     Limitations of testing:
> 
>         The test host pc that was used for testing (intel pc) has RTC
>         that doesn't support all RTC features that are accessible
>         through ioctls. This means that testing can't discover
>         functionality errors related to the third argument of ioctls
>         that are used for features which are not supported. For example,
>         running the test program for ioctl RTC_EPOCH_READ gives
>         the error output: inappropriate ioctl for device. As expected,
>         the same output was obtained through QEMU which means that this
>         ioctl is recognized in QEMU but doesn't really do anything
>         because it is not supported in the host computer's RTC.
> 
>         Conclusion: Some RTC ioctls need to be tested on computers
>         that support their functionalities so that it can be inferred
>         that they are really supported in QEMU. In absence of such
>         test hosts, the specifications of those ioctls need to be
>         carefully checked manually and the implementations should be
>         updated accordingly.
> 
> Testing method for sound timer ioctls:
> 
>     The alsa ioctl test suite, that can be found on github
>     ("https://github.com/alsa-project/alsa-utils"), was used the test
>     the implemented ioctls. The file "timer.c", located in this test
>     suite, contains test functions that are used to test alsa timer
>     ioctls. This file was compiled (sometimes using cross-compilers) 
>     for the following architectures:
> 
>         * Intel 64-bit (little endian)
>         * Power pc 32-bit (big endian)
>         * Power pc 64-bit (big endian)
> 
>     The corresponding compiled test files were executed without using
>     QEMU on following hosts:
> 
>         * Intel Core i7-4790K (x86_64 host)
>         * Power 7447A (ppc32 host)
> 
>     The corresponding native compiled test files were executed without using
>     QEMU on following hosts:
> 
>         * Intel Core i7-4790K (x86_64 host)
>         * Power 7447A (ppc32 host)
> 
>     All compiled test files were in turn executed through QEMU
>     and the results obtained were the same ones gotten for native
>     execution.
> 
>     Also, mini test programs were written to test further functionalities
>     of individual ioctls. Those programs were, like the file "timer.c",
>     compiled for different architectures and were executed both natively
>     and thgrough QEMU to compare the results.
> 
>     Example of a test program:
> 
>         For ioctl SNDRV_TIMER_IOCTL_GINFO the following test program was used:
> 
>         #include <stdio.h>
>         #include <stdlib.h>
>         #include <sys/types.h>
>         #include <fcntl.h>
>         #include <sys/ioctl.h>
>         #include <sound/asound.h>
> 
>         #define ERROR -1
> 
>         int main()
>         {
>             int fd = open("/dev/snd/timer", O_RDWR);
> 
>             if(fd == ERROR)
>             {
>                 perror("open");
>                 return -1;
>             }
> 
>             struct snd_timer_id id = {SNDRV_TIMER_CLASS_GLOBAL, 
>                                       SNDRV_TIMER_SCLASS_NONE, -1, 
>                                       SNDRV_TIMER_GLOBAL_SYSTEM, 0};
> 
>             struct snd_timer_ginfo ginfo;
>             ginfo.tid = id;
> 
>             if(ioctl(fd, SNDRV_TIMER_IOCTL_GINFO, &ginfo) == ERROR)
>             {
>                 perror("ioctl");
>                 return -1;
>             }
> 
>             printf("flags: %u\n", ginfo.flags);
>             printf("card: %d\n", ginfo.card);
>             printf("id: %s\n", ginfo.id);
>             printf("name: %s\n", ginfo.name);
>             printf("reserved0: %lu\n", ginfo.reserved0);
>             printf("resolution: %lu\n", ginfo.resolution);
>             printf("resolution_min: %lu\n", ginfo.resolution_min);
>             printf("reolution_max: %lu\n", ginfo.resolution_max);
>             printf("clients: %u\n", ginfo.clients);
>             printf("reserved: %s\n", ginfo.reserved);
> 
>             return 0;
>         }
> 
> v6:
> 
>     * fixed one patch by adding a case statement for 'unsigned long'
>       to recognize two ioctls that are implemented in that patch
> 
>     * changed patch descriptions a little bit so that they are more
>       comprehensible
> 
> v5:
> 
>     * added support for alsa sound timer ioctls
> 
> v4:
> 
>     * changed patch descriptions so that they are better
>       formatted and more comprehensible
> 
> v3:
> 
>     * changed two instances of MK_PTR(TYPE_ULONG) to TYPE_ULONG
> 
> v2:
> 
>     * added description of each ioctl in patches
>     * wrote a more detailed cover letter with description of testing
>     * changed one instance of TYPE_INT to MK_PTR(TYPE_INT)
> 
> Filip Bozuta (12):
>   linux-user: Add support for enabling/disabling RTC features using
>     ioctls
>   linux-user: Add support for getting/setting RTC time and alarm using
>     ioctls
>   linux-user: Add support for getting/setting RTC periodic interrupt and
>     epoch using ioctls
>   linux-user: Add support for getting/setting RTC wakeup alarm using
>     ioctls
>   linux-user: Add support for getting/setting RTC PLL correction using
>     ioctls
>   linux-user: Add support for read/clear RTC voltage low detector using
>     ioctls
>   linux-user: Add support for getting alsa timer version and id
>   linux-user: Add support for setting alsa timer enhanced read using
>     ioctl
>   linux-user: Add support for getting/setting specified alsa timer
>     parameters using ioctls
>   linux-user: Add support for selecting alsa timer using ioctl
>   linux-user: Add support for getting/setting selected alsa timer
>     parameters using ioctls
>   linux-user: Add support for selected alsa timer instructions using
>     ioctls
> 
>  linux-user/ioctls.h        |  45 +++++++++++++++++
>  linux-user/syscall.c       |   3 ++
>  linux-user/syscall_defs.h  | 121 +++++++++++++++++++++++++++++++++++++++++++++
>  linux-user/syscall_types.h |  91 ++++++++++++++++++++++++++++++++++
>  4 files changed, 260 insertions(+)
> 


