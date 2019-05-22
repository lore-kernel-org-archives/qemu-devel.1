Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E480C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 12:13:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6734C217F9
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 12:13:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6734C217F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42253 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTQ7L-0007pm-HD
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 08:13:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hTQ5Q-0006xj-Ke
	for qemu-devel@nongnu.org; Wed, 22 May 2019 08:11:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hTQ5P-0005ve-Hz
	for qemu-devel@nongnu.org; Wed, 22 May 2019 08:11:12 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:40979)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hTQ5P-0005uj-7L; Wed, 22 May 2019 08:11:11 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
	1MAORp-1hN3V4284Z-00BvoC; Wed, 22 May 2019 14:10:41 +0200
To: Cornelia Huck <cohuck@redhat.com>,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20190521152810.21353-1-cohuck@redhat.com>
	<20190521152810.21353-3-cohuck@redhat.com>
	<6e216877-60be-ddcd-3f15-604e870ca8ba@redhat.com>
	<20190522140729.25970e17.cohuck@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <6b101b85-4985-4736-acad-59389b00de55@vivier.eu>
Date: Wed, 22 May 2019 14:10:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20190522140729.25970e17.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:4iRzIm9FJtifPnAQFA9cizCiqjm24QP03EMKe79iEs9b/2Srb/X
	sfQmy2nph75b3pTvcp+QiFWBmA/ri9SBcFv5yQIsFuOSBqB7BPMBoOEHX0ooKjLJyv6lwV/
	iKeZMPDB5M1CXgskWRuor5+cgP19W8QImjR+CXgcsUo+1WFlTkar1tuDwq0zCTOteyKBfuC
	lHkkonPfYk7VxLH5uef0g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OTkK9uWG44Y=:rfIkUrO+w7LIStlM4ciEIi
	H+E7dtDRwhzxv+54PiaZoLfpubIHrlGdwwle+CmAcMhTTSsqFUZZQ/6w+2HRNZ+pvmEwcJhEG
	XkQmIt3DIS/3BPL536/E5p/zOFlaufYRm94HgiWYPcv+82tkVtExtpjvc3sUCoRKca1nCKMKF
	ZOCRetKol7R+EX2B9diEkPbhewHPfqpfZyC3345yvvrp6GhwuHOnB2L77tNEKlDZT35zU5JgZ
	eWhU1U62FNmVGCpMEjSZvzhWNoueCh0rcUHuN6bLDh43uIUadm64gXjG6UvXkLnGyC5Y+7zQY
	vE6bO98j99s74yroNBr/ZKkiaAcm3btuA6Is4REw5Rs+ZaQZJaQiIjW4K1qNpQF2BG04J5jvc
	pKx0usbDThKd5uzGx5gJPZsCDsFrOpUemwRKN8sEOc2FPVIZ8WSfyur0QqafO3mUKaFpotxuR
	aNeMfLdHBxjadFWhos2FnHeBnSkxLK2iG/PSN18jfAGrqV1zY8ZsfzAtH1FN+zF5y5OmA2154
	WLc2ab0CL0HK/x5fpBe0Pg9HtNdlfk0lR7rnHcR5sBjC8o7MmvwQEknE5D7ZHg3tycc9VukAY
	WKhI4arGUt3lCGEhwoocADlCUxQUZqB0iEMvji3QXmeyJoAQH70kEVfVZKDk+CcHLM1wW3fTX
	JaHCXwwznthmpMEBGB8AcakInL7y+MV2TCcOmOaTzPe+DtGymoZCQgCgZN0JvcCgvPpYP/Bhq
	aspSySF4C+i4pxWabfVwZIzGFJ00+LPoVQUIJ/FHs7fAGcXgdsaPKASM/LE=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.74
Subject: Re: [Qemu-devel] [PULL v3 47/55] linux headers: update against
 Linux 5.2-rc1
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-s390x@nongnu.org,
	=?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/05/2019 14:07, Cornelia Huck wrote:
> On Wed, 22 May 2019 13:47:25 +0200
> Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
> 
>> On 5/21/19 5:28 PM, Cornelia Huck wrote:
>>> commit a188339ca5a396acc588e5851ed7e19f66b0ebd9
>>>
>>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>>> ---
>> [...]
>>>   #define __NR_mq_notify 184
>>>   __SC_COMP(__NR_mq_notify, sys_mq_notify, compat_sys_mq_notify)
>>>   #define __NR_mq_getsetattr 185
>>> @@ -536,8 +567,10 @@ __SC_COMP(__NR_msgsnd, sys_msgsnd, compat_sys_msgsnd)
>>>   __SYSCALL(__NR_semget, sys_semget)
>>>   #define __NR_semctl 191
>>>   __SC_COMP(__NR_semctl, sys_semctl, compat_sys_semctl)
>>> +#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
> 
> Eww. It seems only aarch64 sets __ARCH_WANT_TIME32_SYSCALLS, and the
> second condition probably catches others but not mipsel.
> 
>>>   #define __NR_semtimedop 192
>>> -__SC_COMP(__NR_semtimedop, sys_semtimedop, compat_sys_semtimedop)
>>> +__SC_COMP(__NR_semtimedop, sys_semtimedop, sys_semtimedop_time32)
>>> +#endif
>>>   #define __NR_semop 193
>>>   __SYSCALL(__NR_semop, sys_semop)
>> [...]
>>
>> https://app.shippable.com/github/qemu/qemu/runs/1703/summary/console
>>
>> It seems this commit introduce a regression on mips32:
>>
>>    CC      mipsel-linux-user/linux-user/syscall.o
>> ./linux-user/syscall.c: In function 'safe_semtimedop':
>> ./linux-user/syscall.c:697:25: error: '__NR_semtimedop' undeclared
>> (first use in this function)
>>       return safe_syscall(__NR_##name, arg1, arg2, arg3, arg4); \
> 
> So, we unconditionally deal with this syscall, i.e. we assume it is
> always present? (I'm not sure of the logic in linux-user code.)
>

linux-user assumes it is present if __NR_msgsnd is present.

Thanks,
Laurent

