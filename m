Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDEB4C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 13:43:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 738D620863
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 13:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p84yrFYa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 738D620863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43561 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTRWW-00047j-NF
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 09:43:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hTRVT-0003Vs-VE
	for qemu-devel@nongnu.org; Wed, 22 May 2019 09:42:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hTRVS-0007iq-Lq
	for qemu-devel@nongnu.org; Wed, 22 May 2019 09:42:11 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:45566)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hTRVS-0007hC-BT
	for qemu-devel@nongnu.org; Wed, 22 May 2019 09:42:10 -0400
Received: by mail-wr1-x441.google.com with SMTP id b18so2340201wrq.12
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 06:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=sj0Gq8PzFYQI+3dNDr5Hg6Lvk+TGeP7JrUsoVzQjWMw=;
	b=p84yrFYauN41ySAlrF2CGkq7oAiigvwfh7BSlSSFcJMiYpGnkVKl24pbmRe7ipdJgV
	tEPZDgt3y6wJh6sHv7nO+AoTZIcwp+/aTf4we8o+FGP8+kvZnsn76jU0SqOACVgp6gq5
	4TN5/R0GTPhgbcBl3PHR8AVwemjoSr27LUfJ4cuwCQDK1WLwkjLVqJzAmuzK1N4I20HF
	TaqwGEL+JN1noKH4tcK51OOyxIyPd1geflKU5oCvgyMbZmgBXKURh8A+iMDDdq/Fzf+1
	vTgZjOoXlN4irWRjWKw8RwWlVeFE3yG9kRvavLEx1RnJgvoljMnYoCp1rk6CzQ5xy3La
	47Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=sj0Gq8PzFYQI+3dNDr5Hg6Lvk+TGeP7JrUsoVzQjWMw=;
	b=sGQmEgCEuK85zuyssJJkUvM4XFIcGiwL0cF9JWKGaRPNZVt05aVMCT1k7HzIIk/OQ9
	MspuKOIYBwlbF8/raIdn6TY3aJWiHMVF6KS1hQo/tbwO7AXR/avHF8Q4HO+WyI6H+4Sn
	SdnsBAjoLRdazGpe/KuxfmLIfN2KbHHjZPQez8uWiwHzwQHnwyH1oBg1FajEugxgS2ZW
	E64os2JHCwBstncLnyIQGkRPgry/EhWVX8bOdEo1dOyFD7C2Z/SxLeHZDxI2mI3oM+s7
	+ONdagam/PfxQgjTmn0G6SgrI6z1pQvWp/Sy1XeOtP96rO0gIg9geOoPWFpu/zw3aSVk
	Vs0Q==
X-Gm-Message-State: APjAAAXDAQrnyyF3yMqjilJZCezIcjObGYoTqJ0+BdVCl8NTHMEhJsrr
	a31ia2Lato0m2yOg6T35cMsRbw==
X-Google-Smtp-Source: APXvYqwlm0fnwcnji4kB71tcc8SML8oDsXRThPY9IL8/q2mx3NwH6dkzMFHaIpPQpPTxSRrifyfGLQ==
X-Received: by 2002:adf:eb02:: with SMTP id s2mr49029266wrn.29.1558532528979; 
	Wed, 22 May 2019 06:42:08 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id n5sm2920636wrj.27.2019.05.22.06.42.08
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 22 May 2019 06:42:08 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 052181FF87;
	Wed, 22 May 2019 14:42:08 +0100 (BST)
References: <20190521152810.21353-1-cohuck@redhat.com>
	<20190521152810.21353-3-cohuck@redhat.com>
	<6e216877-60be-ddcd-3f15-604e870ca8ba@redhat.com>
	<20190522140729.25970e17.cohuck@redhat.com>
	<6b101b85-4985-4736-acad-59389b00de55@vivier.eu>
	<20190522142421.746f7495.cohuck@redhat.com>
	<CAL1e-=j5joi3ssA-7Q2PVp841ywj41Ntz_MSKdB4w27Z9JvcEQ@mail.gmail.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
In-reply-to: <CAL1e-=j5joi3ssA-7Q2PVp841ywj41Ntz_MSKdB4w27Z9JvcEQ@mail.gmail.com>
Date: Wed, 22 May 2019 14:42:07 +0100
Message-ID: <87a7fehahc.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
	qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
	qemu-s390x@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Aleksandar Markovic <aleksandar.m.mail@gmail.com> writes:

> On May 22, 2019 2:24 PM, "Cornelia Huck" <cohuck@redhat.com> wrote:
>>
>> On Wed, 22 May 2019 14:10:39 +0200
>> Laurent Vivier <laurent@vivier.eu> wrote:
>>
>> > On 22/05/2019 14:07, Cornelia Huck wrote:
>> > > On Wed, 22 May 2019 13:47:25 +0200
>> > > Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
>> > >
>> > >> On 5/21/19 5:28 PM, Cornelia Huck wrote:
>> > >>> commit a188339ca5a396acc588e5851ed7e19f66b0ebd9
>> > >>>
>> > >>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>> > >>> ---
>> > >> [...]
>> > >>>   #define __NR_mq_notify 184
>> > >>>   __SC_COMP(__NR_mq_notify, sys_mq_notify, compat_sys_mq_notify)
>> > >>>   #define __NR_mq_getsetattr 185
>> > >>> @@ -536,8 +567,10 @@ __SC_COMP(__NR_msgsnd, sys_msgsnd,
> compat_sys_msgsnd)
>> > >>>   __SYSCALL(__NR_semget, sys_semget)
>> > >>>   #define __NR_semctl 191
>> > >>>   __SC_COMP(__NR_semctl, sys_semctl, compat_sys_semctl)
>> > >>> +#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG !=3D =
32
>> > >
>> > > Eww. It seems only aarch64 sets __ARCH_WANT_TIME32_SYSCALLS, and the
>> > > second condition probably catches others but not mipsel.
>> > >
>> > >>>   #define __NR_semtimedop 192
>> > >>> -__SC_COMP(__NR_semtimedop, sys_semtimedop, compat_sys_semtimedop)
>> > >>> +__SC_COMP(__NR_semtimedop, sys_semtimedop, sys_semtimedop_time32)
>> > >>> +#endif
>> > >>>   #define __NR_semop 193
>> > >>>   __SYSCALL(__NR_semop, sys_semop)
>> > >> [...]
>> > >>
>> > >> https://app.shippable.com/github/qemu/qemu/runs/1703/summary/console
>> > >>
>> > >> It seems this commit introduce a regression on mips32:
>> > >>
>> > >>    CC      mipsel-linux-user/linux-user/syscall.o
>> > >> ./linux-user/syscall.c: In function 'safe_semtimedop':
>> > >> ./linux-user/syscall.c:697:25: error: '__NR_semtimedop' undeclared
>> > >> (first use in this function)
>> > >>       return safe_syscall(__NR_##name, arg1, arg2, arg3, arg4); \
>> > >
>> > > So, we unconditionally deal with this syscall, i.e. we assume it is
>> > > always present? (I'm not sure of the logic in linux-user code.)
>> > >
>> >
>> > linux-user assumes it is present if __NR_msgsnd is present.
>>
>> Hm. The kernel change seems to break that assumption. Does anyone with
>> mips knowledge have an idea whether that was intentional (and the
>> linux-user code needs to be changed), or whether that's an issue on the
>> kernel side?
>>
>
> Hi, Cornelia.
>
> Thanks for your involving into this issue!
>
> It could be that (not-originating-from-MIPS) kernel commit:
>
> https://github.com/torvalds/linux/commit/1a787fc5ba18ac767e635c58d06a0b46=
876184e3
>
> made a mess with system call availability for MIPS (I will forward this to
> MIPS kernel maintainer Paul Burton). My impression is that this was not
> intentional, and is a temporary instability of kernel interface.

I think this stems from 2038 time bomb work. Eventually they want it to
be possible to build non-legacy kernels that don't expose time32 to the
outside world. As part of that new system calls are being introduced
where needed. The IPC syscall which orignally multiplexed a bunch of
these operations on some systems would eventually be potentially phased
out.

> However, I think that QEMU nevertheless should not make the assumption th=
at
> if __NR_MSGSND, than semtimedop() is present. It could be true, but it is
> still just self-imposed belief in QEMU, kernel never guarantied such thin=
gs.
>
> The alternative way of invoking via IPCV6 (else part of =E2=80=9Cifdef
> __NR_MSGSND=E2=80=9D) should work for MIPS in the present stage of header=
s and
> kernel.

Yeah I think #ifndef __NR_ipc would work for now. It shouldn't affect
architectures that never had the IPC call.

> As a side note, perhaps we shoul update kernel headers only off of stable
> kernel releases.

I guess that's a part of the tension for supporting new kernel APIs
quickly. At least 5.2-rc1 wasn't a random tree - you would expect the
external facing ABI to be stable after the merge window closed. It would
be nice to know what new features were being exposed though.

>
> Regards,
> Aleksandar


--
Alex Benn=C3=A9e

