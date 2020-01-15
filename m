Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC88AC32771
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 21:53:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B7512081E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 21:53:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B7512081E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irqbs-0007Tq-MO
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 16:53:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58574)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1irqbE-00074v-GR
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 16:53:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1irqbA-0004DH-Ce
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 16:53:16 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:40009)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1irqbA-0004C4-3k
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 16:53:12 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1N5G1T-1jq2Le01rB-011ATi; Wed, 15 Jan 2020 22:52:51 +0100
To: Filip Bozuta <Filip.Bozuta@rt-rk.com>, Arnd Bergmann <arnd@arndb.de>
References: <1579103618-20217-1-git-send-email-Filip.Bozuta@rt-rk.com>
 <1579103618-20217-9-git-send-email-Filip.Bozuta@rt-rk.com>
 <CAK8P3a187rPhma7Q6o+hCF3h0=5MLZwh49+JqKt6BvVsAB1efQ@mail.gmail.com>
 <ceaf44c0-fd6c-c280-7f95-7bc133553089@vivier.eu>
 <CAK8P3a36KqWD4fKBLDpFhJg079bNdJDSDUAP2Zu_i1+H62Q6ZQ@mail.gmail.com>
 <518d717d-9f1e-e00e-f2a9-df8861241d1c@rt-rk.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH 08/12] linux-user: Add support for setting alsa timer
 enhanced read using ioctl
Message-ID: <cdcce2a3-00f5-f6d1-3083-dc36892ac5b4@vivier.eu>
Date: Wed, 15 Jan 2020 22:52:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <518d717d-9f1e-e00e-f2a9-df8861241d1c@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:pLm9EpvBSCnJLYRrIMOLmDcJ9pij9s5pKIry60sWllHfLzxkRj0
 MOPV7rTq5n0ZlW8zQZ6rofMy5EPrUB+SsUjMBsj+Hv+0vuXIn4bnRdaoylb9XoFTgr699W4
 7GVJcqARb7liQu+C29Q/N2sfPjs2FML5uSGHvgBju/HXY6cZQu7U1FdJfOzsk7VHAExpVoQ
 tEyTHS0fqbXY0X/19Ec6Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oxgUgGPmG+8=:4pCg4KtfECrUuxQlI4D7VE
 n7yP2o13HeQCexTmKPu7m+82hFhtK8CK64I3fEA5fkh0mmUgTC8VSIFX5HiTpm8fIotqA2+89
 M50HM9z/t96RjD69EgzPxh3cIkx46RfH5txo7kVR8P6/2S3RJdO3f439CZhFE8XMxbDovLjtl
 bXA/yxMzlBR5RAspc9FR1ye6Ael/IqRlc8ohIKpXyty57tKvjpxWI9LlpKdimybUuNi9hPLXU
 jm+swJ77lV4NWu9UCMmlfn0xu++5ouuILnbuc2xddnHIKd0fGEMh5yqiqHXZs6deJeXlc1xY1
 0nH8rM4iLzAls9ruX+rWEwwlOvk2MtlNBfepPhffJOSs4nExPI7jYu3QLgcya3jhjrEQewfDx
 PkxJo453o8TLFdt5cea2DYQMgkW9uEnv2VTnQ5Wr7qZoIYYiPWLi88TCMtY9vz2gPFgMrEYaC
 SfyXgUejanYJdLFAnJbL9z+mXb71MpZX2aGl9IpLgsWc9wBm9S0OzVfkaATUlKUKb6FHxxpeO
 5jM8+Z/LoNzSEjNGyMhpDSy6lqC1Uj6Ph9pRiYJtXeDfLipClCeAKOodwcGyuQc8czMDy/88T
 m93mMHOqTVMYjNKKrin1CHBwhCSAfKFqrUxf/tID7zLTex2SSbpTxwFMQb8His1q+DTD74mW2
 gT1RjORH6TuqkFy4zF6lqXc/3sZJmv3Oj1oQub6a2wmql4/Fu1+ullEC/+4InGexEaCp4PZGe
 JIw8dDqV2xTLoc/GNy1UVO8Zp97Uz+UJ3cIe2w1gjwGY3GefJ+hxZbvY+XrNdDtq+e69SH354
 brdeQmDlH/GQo2fZQAev7WHZeW+5m2eM5+APQ3z21Jy1JSxCHw2p9qcv9AkpnjhbWC1jXCzxZ
 GI1QFeYPoIWmJXN/VHmhus3jU+MzZR2enVIFCcx/Q=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 217.72.192.75
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

Le 15/01/2020 à 20:17, Filip Bozuta a écrit :
> 
> On 15.1.20. 17:37, Arnd Bergmann wrote:
>> On Wed, Jan 15, 2020 at 5:32 PM Laurent Vivier <laurent@vivier.eu> wrote:
>>> Le 15/01/2020 à 17:18, Arnd Bergmann a écrit :
>>>> On Wed, Jan 15, 2020 at 4:53 PM Filip Bozuta
>>>> <Filip.Bozuta@rt-rk.com> wrote:
>>>>> This patch implements functionality of following ioctl:
>>>>>
>>>>> SNDRV_TIMER_IOCTL_TREAD - Setting enhanced time read
>>>>>
>>>>>      Sets enhanced time read which is used for reading time with
>>>>> timestamps
>>>>>      and events. The third ioctl's argument is a pointer to an
>>>>> 'int'. Enhanced
>>>>>      reading is set if the third argument is different than 0,
>>>>> otherwise normal
>>>>>      time reading is set.
>>>>>
>>>>> Implementation notes:
>>>>>
>>>>>      Because the implemented ioctl has 'int' as its third argument,
>>>>> the
>>>>>      implementation was straightforward.
>>>>>
>>>>> Signed-off-by: Filip Bozuta <Filip.Bozuta@rt-rk.com>
>>>> I think this one is wrong when you go between 32-bit and 64-bit
>>> kernel uses an "int" and "int" is always 32bit.
>>> The problem is most likely with timespec I think.
>>>
>>>> targets, and it gets worse with the kernel patches that just got
>>>> merged for linux-5.5, which extends the behavior to deal with
>>>> 64-bit time_t on 32-bit architectures.
>>>>
>>>> Please have a look at
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/?h=80fe7430c70859
>>>>
>>> Yes, we already had the same kind of problem with SIOCGSTAMP and
>>> SIOCGSTAMPNS.
>>>
>>> Do the kernel patches add new ioctl numbers to differentiate 32bit and
>>> 64bit time_t?
>> Yes, though SNDRV_TIMER_IOCTL_TREAD is worse: the ioctl argument
>> is a pure 'int' that decides what format you get when you 'read' from the
>> same file descriptor.
>>
>> For emulating 64-bit on 32-bit kernels, you have to use the new
>> SNDRV_TIMER_IOCTL_TREAD64, and for emulating 32-bit on
>> 64-bit kernels, you probably have to return -ENOTTY to
>> SNDRV_TIMER_IOCTL_TREAD_OLD unless you also want to
>> emulate the read() behavior.
>> When a 32-bit process calls SNDRV_TIMER_IOCTL_TREAD64,
>> you can translate that into the 64-bit
>> SNDRV_TIMER_IOCTL_TREAD_OLD.
>>
>>       Arnd
> 
> 
> Thank you for bringing this up to my attention. Unfortunately i have
> some duties of academic nature in next month so i won't have much time
> fix this bug. I will try to fix this as soon as possible.

Could you at least to try to have a mergeable series before you have to
stop to work on this?

You can only manage the case before the change reported by Arnd (I will
manage the new case myself later).

Thanks,
Laurent


