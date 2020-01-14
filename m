Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA76C33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 12:49:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C81B2072B
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 12:49:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C81B2072B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irLd7-0006Fr-DI
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 07:49:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39379)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1irLc8-0005Nf-9R
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 07:48:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1irLc6-0008CC-Ry
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 07:48:08 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:35681)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1irLc6-0008C8-Io
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 07:48:06 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MXY2Z-1jAKxM2Tjr-00Z3AH; Tue, 14 Jan 2020 13:47:43 +0100
Subject: Re: [PATCH 00/12] linux-user: Add support for real time clock and
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Filip Bozuta <Filip.Bozuta@rt-rk.com>, qemu-devel@nongnu.org
References: <1578574763-8327-1-git-send-email-Filip.Bozuta@rt-rk.com>
 <399810c6-e1a8-463b-b762-afc8837517d4@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <92c7e27d-afb7-182d-e7ca-d20c8ff687b6@vivier.eu>
Date: Tue, 14 Jan 2020 13:47:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <399810c6-e1a8-463b-b762-afc8837517d4@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:HAYpY24Ry5TrDcHPBDzeN9UTjJ/z9SCue/Hd6qYOlhS527nLMjl
 NW27VqzYCSJGrePmBDoJfNTasKYdWtwOC6ZdEsssJ6psPmxMf7Hj4UtJkgwaSg/izAcgBok
 tIqxpNbWDK2ZvfXS6PINtxvYiKG3EYIwGPO+rjCyGtMvEccp7OYXgeFax5qhmsT7NG1I0gN
 AxmYLasXi0X7Sa7XC3tqQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zPZJJAAzREM=:MAwqGbGeFpV7fSw8FwnBr3
 OW0FGli82dz5D/5EkLIwJzSGpfXW9NvB1HTRK1IxFbMFX+AJmSex1QXvwYmwgiu2WuLPayoE4
 DNMKIP+UIj0yZs4WGwWlxhviGnigB1nIRYBokYxlvsS3y0b14aovuS+kCFQZZqKddCtAt8sMT
 39b5LbUkVbzoipKck7riiim/Hfndol5+DaVriITOMxNDMwTtqugWnEEo+w6XXAANWwq6FdSSo
 8Dy1gvGh+THdsDsZrv7xHvRj+E+XjJP2+U/YcwTsMWYmTsyesHhQOgc/KfzdbqUD7RVA13xkt
 jRD+FnwSoOooqxwOYhnKpQsqAbQKTu8JDv5ytYmaH5EWlV1U5DQeUcbp8lOKtXQUyYNVDMmmh
 1YwdM1FgreGlwUf2h4oScElhs8MnatmVPxS7xaBon0prQ8Ij1hrgHTRAtrzYZiuEADimc5kR4
 ZOvR7NHnQa8bPFg0jKKQKyO7RWpPiw5A7iz9KX8Q+D5Jki3Tfejv5Skn3Nt9rtLFxSugLU8VL
 5NDyd5cyAcoE3JSMZOteO86/3mYs4BD6Y2B74KWR8QHPofdGGsozKqIVzAiTAwkUVRwFXXbnL
 m7/j8cWoLtP5MEC0h9euP7FXJ/3GNp5dau82sRskj7nyag9Kzwctinu09HLTVlM5U7a98/A++
 9j27vEmRANSSTfuR4TJqa/fq18Cy3B+knym9rttABqE59tFdBwriymM1a07dmxyf4moI9a294
 HixvhsAwTO/4TOJ5lPps04OUh8/IVhm5Sgpjx738gDFKNsYTbvMyw0vtCubT6+kt9OXs3KA26
 R/mXRthM4hNwBpriV02v9NxY77BfYbnYo3UidJ81/IXA8t8n7kUtFqdajsFh722lTMfgQwAgT
 sgT7OYaFesMwvhqVsXs9ERyTFLe2Gz4kZMo4sC8VE=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.131
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
Cc: riku.voipio@iki.fi
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 14/01/2020 à 13:39, Philippe Mathieu-Daudé a écrit :
> Hi Filip,
> 
> This is v5.
> 
> On 1/9/20 1:59 PM, Filip Bozuta wrote:
>> MIME-Version: 1.0
>> Content-Type: text/plain; charset=UTF-8
>> Content-Transfer-Encoding: 8bit
>>
>> This series covers following RTC and sound timer ioctls:
>>
>>    RTC ioctls(22):
>>
>>      * RTC_AIE_ON          * RTC_ALM_SET         * RTC_WKALM_SET
>>      * RTC_AIE_OFF         * RTC_ALM_READ        * RTC_WKALM_RD
>>      * RTC_UIE_ON          * RTC_RD_TIME         * RTC_PLL_GET
>>      * RTC_UIE_OFF         * RTC_SET_TIME        * RTC_PLL_SET
>>      * RTC_PIE_ON          * RTC_IRQP_READ       * RTC_VL_READ
>>      * RTC_PIE_OFF         * RTC_IRQP_SET        * RTC_VL_CLR
>>      * RTC_WIE_ON          * RTC_EPOCH_READ
>>      * RTC_WIE_OFF         * RTC_EPOCH_SET
>>
>>    Sound timer ioctls(14):
>>
>>      * SNDRV_TIMER_IOCTL_PVERSION          * SNDRV_TIMER_IOCTL_INFO
>>      * SNDRV_TIMER_IOCTL_NEXT_DEVICE       * SNDRV_TIMER_IOCTL_PARAMS
>>      * SNDRV_TIMER_IOCTL_TREAD             * SNDRV_TIMER_IOCTL_STATUS
>>      * SNDRV_TIMER_IOCTL_GINFO             * SNDRV_TIMER_IOCTL_START
>>      * SNDRV_TIMER_IOCTL_GPARAMS           * SNDRV_TIMER_IOCTL_STOP
>>      * SNDRV_TIMER_IOCTL_GSTATUS           * SNDRV_TIMER_IOCTL_CONTINUE
>>      * SNDRV_TIMER_IOCTL_SELECT            * SNDRV_TIMER_IOCTL_PAUSE
>>
>> The functionalities of individual ioctls were described in this series
>> patch commit messages.
>>
>> Testing method for RTC ioctls:
>>
>>      Mini test programs were written for each ioctl. Those programs were
>>      compiled (sometimes using cross-compilers) for the following
>>      architectures:
>>
>>          * Intel 64-bit (little endian)
>>          * Power pc 32-bit (big endian)
>>          * Power pc 64-bit (big endian)
>>
>>      The corresponding native programs were executed without using
>>      QEMU on following hosts:
>>
>>          * Intel Core i7-4790K (x86_64 host)
>>          * Power 7447A (ppc32 host)
>>
>>      All applicable compiled programs were in turn executed through QEMU
>>      and the results obtained were the same ones gotten for native
>>      execution.
>>
>>      Example of a test program:
>>
>>          For ioctl RTC_RD_TIME the following test program was used:
>>
>>          #include <stdio.h>
>>          #include <stdlib.h>
>>          #include <linux/rtc.h>
>>          #include <fcntl.h>
>>          #include <linux/input.h>
>>          #include <sys/types.h>
>>          #include <unistd.h>
>>
>>          #define ERROR -1
>>
>>          int main()
>>          {
>>
>>              int fd = open("/dev/rtc", O_RDWR | O_NONBLOCK);
>>
>>              if(fd == ERROR)
>>              {
>>                  perror("open");
>>                  return -1;
>>              }
>>
>>              struct rtc_time cur_time;
>>
>>              if(ioctl(fd, RTC_RD_TIME, &cur_time) < 0)
>>              {
>>                  perror("ioctl");
>>                  return -1;
>>              }
>>
>>              printf("Second: %d, Minute: %d, Hour: %d, Day: %d, Month:
>> %d, Year: %d,",
>>                  cur_time.tm_sec, cur_time.tm_min, cur_time.tm_hour,
>>                  cur_time.tm_mday, cur_time.tm_mon, cur_time.tm_year);
>>
>>              return 0;
>>          }
>>
>>      Limitations of testing:
>>
>>          The test host pc that was used for testing (intel pc) has RTC
>>          that doesn't support all RTC features that are accessible
>>          through ioctls. This means that testing can't discover
>>          functionality errors related to the third argument of ioctls
>>          that are used for features which are not supported. For example,
>>          running the test program for ioctl RTC_EPOCH_READ gives
>>          the error output: inappropriate ioctl for device. As expected,
>>          the same output was obtained through QEMU which means that this
>>          ioctl is recognized in QEMU but doesn't really do anything
>>          because it is not supported in the host computer's RTC.
>>
>>          Conclusion: Some RTC ioctls need to be tested on computers
>>          that support their functionalities so that it can be inferred
>>          that they are really supported in QEMU. In absence of such
>>          test hosts, the specifications of those ioctls need to be
>>          carefully checked manually and the implementations should be
>>          updated accordingly.
> 
> We should be able to check if the host supports these features and run
> your different tests.
> Can you add them in the repository? Maybe under tests/tcg/multiarch/.
> 

I agree with Philippe. If you provide the test we will also be able to
run non-regression tests. You can add them in a separate patch if it's
easier for you.

Thanks,
Laurent


