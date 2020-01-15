Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E33C33CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 19:22:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3DEE20728
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 19:22:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3DEE20728
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iroFV-0004TX-MQ
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 14:22:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35205)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Filip.Bozuta@rt-rk.com>) id 1iroAH-0006HJ-EA
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 14:17:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Filip.Bozuta@rt-rk.com>) id 1iroAD-00070k-Rh
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 14:17:17 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:57503 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Filip.Bozuta@rt-rk.com>)
 id 1iroAD-0006zV-Jf
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 14:17:13 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 308921A20FF;
 Wed, 15 Jan 2020 20:17:11 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from [10.10.14.93] (rtrkw493-lin.domain.local [10.10.14.93])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 14C361A1FFA;
 Wed, 15 Jan 2020 20:17:11 +0100 (CET)
Subject: Re: [PATCH 08/12] linux-user: Add support for setting alsa timer
 enhanced read using ioctl
To: Arnd Bergmann <arnd@arndb.de>, Laurent Vivier <laurent@vivier.eu>
References: <1579103618-20217-1-git-send-email-Filip.Bozuta@rt-rk.com>
 <1579103618-20217-9-git-send-email-Filip.Bozuta@rt-rk.com>
 <CAK8P3a187rPhma7Q6o+hCF3h0=5MLZwh49+JqKt6BvVsAB1efQ@mail.gmail.com>
 <ceaf44c0-fd6c-c280-7f95-7bc133553089@vivier.eu>
 <CAK8P3a36KqWD4fKBLDpFhJg079bNdJDSDUAP2Zu_i1+H62Q6ZQ@mail.gmail.com>
From: Filip Bozuta <Filip.Bozuta@rt-rk.com>
Message-ID: <518d717d-9f1e-e00e-f2a9-df8861241d1c@rt-rk.com>
Date: Wed, 15 Jan 2020 20:17:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a36KqWD4fKBLDpFhJg079bNdJDSDUAP2Zu_i1+H62Q6ZQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 89.216.37.149
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Max Filippov <jcmvbkbc@gmail.com>, amarkovic@wavecomp.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 15.1.20. 17:37, Arnd Bergmann wrote:
> On Wed, Jan 15, 2020 at 5:32 PM Laurent Vivier <laurent@vivier.eu> wrot=
e:
>> Le 15/01/2020 =C3=A0 17:18, Arnd Bergmann a =C3=A9crit :
>>> On Wed, Jan 15, 2020 at 4:53 PM Filip Bozuta <Filip.Bozuta@rt-rk.com>=
 wrote:
>>>> This patch implements functionality of following ioctl:
>>>>
>>>> SNDRV_TIMER_IOCTL_TREAD - Setting enhanced time read
>>>>
>>>>      Sets enhanced time read which is used for reading time with tim=
estamps
>>>>      and events. The third ioctl's argument is a pointer to an 'int'=
. Enhanced
>>>>      reading is set if the third argument is different than 0, other=
wise normal
>>>>      time reading is set.
>>>>
>>>> Implementation notes:
>>>>
>>>>      Because the implemented ioctl has 'int' as its third argument, =
the
>>>>      implementation was straightforward.
>>>>
>>>> Signed-off-by: Filip Bozuta <Filip.Bozuta@rt-rk.com>
>>> I think this one is wrong when you go between 32-bit and 64-bit
>> kernel uses an "int" and "int" is always 32bit.
>> The problem is most likely with timespec I think.
>>
>>> targets, and it gets worse with the kernel patches that just got
>>> merged for linux-5.5, which extends the behavior to deal with
>>> 64-bit time_t on 32-bit architectures.
>>>
>>> Please have a look at
>>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/l=
og/?h=3D80fe7430c70859
>> Yes, we already had the same kind of problem with SIOCGSTAMP and
>> SIOCGSTAMPNS.
>>
>> Do the kernel patches add new ioctl numbers to differentiate 32bit and
>> 64bit time_t?
> Yes, though SNDRV_TIMER_IOCTL_TREAD is worse: the ioctl argument
> is a pure 'int' that decides what format you get when you 'read' from t=
he
> same file descriptor.
>
> For emulating 64-bit on 32-bit kernels, you have to use the new
> SNDRV_TIMER_IOCTL_TREAD64, and for emulating 32-bit on
> 64-bit kernels, you probably have to return -ENOTTY to
> SNDRV_TIMER_IOCTL_TREAD_OLD unless you also want to
> emulate the read() behavior.
> When a 32-bit process calls SNDRV_TIMER_IOCTL_TREAD64,
> you can translate that into the 64-bit
> SNDRV_TIMER_IOCTL_TREAD_OLD.
>
>       Arnd


Thank you for bringing this up to my attention. Unfortunately i have=20
some duties of academic nature in next month so i won't have much time=20
fix this bug. I will try to fix this as soon as possible.

Best regards,

Filip Bozuta


