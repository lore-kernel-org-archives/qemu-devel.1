Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B4EDC282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 13:36:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 453B020879
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 13:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HQLrzORn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 453B020879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43427 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTRQH-0008BZ-HI
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 09:36:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hTRNC-0006DU-A3
	for qemu-devel@nongnu.org; Wed, 22 May 2019 09:33:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hTRNA-0003B7-Vn
	for qemu-devel@nongnu.org; Wed, 22 May 2019 09:33:38 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:50216)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hTRNA-0003A9-Ms
	for qemu-devel@nongnu.org; Wed, 22 May 2019 09:33:36 -0400
Received: by mail-wm1-x344.google.com with SMTP id f204so2273256wme.0
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 06:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=YrPGmKxZA4m1RpvzZKEMR5NEJ4PT96bU1P5C+IYFgq0=;
	b=HQLrzORnTeffncrOq+nY+qwXQFYDFgrWO3pQo0qkCBBB7ysNWLJjbXP86pwMzFhdoo
	3GZ4+Obo0PwHkxGNXeKYOCrhPCXU0codW8OC91+3jIBVYdrHgdgj54Uwm6qF6P1CeFRO
	ARaB4ddMcWP9urOeoysn4J6A5OXxqBGok6CZGkuZwBkmIrDEUaHt/n3SKoRPlL1vBA5c
	kKui6VBR2hqz0kRLyHfuBddgZxtyiSUA8YW/e/t4zheIb/Y+VWhiE71nAL+vAjhDLJJq
	f276lJbwhPqQzhMibUScawGf0M+LubWdOYVSObJgow0NgeZL00ca/lOfZWVaQ2JJU6vX
	I8PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=YrPGmKxZA4m1RpvzZKEMR5NEJ4PT96bU1P5C+IYFgq0=;
	b=CTS5LTWlB/ONLZxP2cGLL+8eTQj5Y/5/2fSDbr83jwJpqSlLcrGL9zvZCIM+Nl3lBk
	E6EZvOpnN4EEKhlgcKkMNvPSTqL38Cz3yqzpvSwasM00JdyFeLttUlj4qlEMVCMiiBkp
	evA3Ki++8o+EYxLv3WEI9vVYdcv6HxnHL4QoDk4F1LvJdLAxa83Rja9sNFK/xvAUeyIO
	vcVjZ67Ha+nTBXkZV9vMoRjbWvwJM7cIxBHuYvns7+R7hxpHlLu9CvJqtZKaiN1UpcTy
	9KIlyPeKKOkf/R2TbCBoSDT5hruBD+hjEbAlweVUd97GnElWKy1C1fz/TEnZAZY3H/vu
	dHog==
X-Gm-Message-State: APjAAAV/bqacSSYn0z4aNcqmgSG8qqmur/qCsgquhrHUcMBIYtrGpjh9
	nNTZIDMd1Z59X+LWswkb+AyoXw==
X-Google-Smtp-Source: APXvYqyhc4JuEw3V29EPtHkC85rbAket5SL2QXEvdgUDcH+e6Mms9TPJJMNo6KtiqwAuctNN2Tch3w==
X-Received: by 2002:a1c:3cc2:: with SMTP id j185mr7362555wma.26.1558532014533; 
	Wed, 22 May 2019 06:33:34 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id d6sm23014655wrp.9.2019.05.22.06.33.33
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Wed, 22 May 2019 06:33:33 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 5FF721FF87;
	Wed, 22 May 2019 14:33:33 +0100 (BST)
References: <20190521152810.21353-1-cohuck@redhat.com>
	<20190521152810.21353-3-cohuck@redhat.com>
	<6e216877-60be-ddcd-3f15-604e870ca8ba@redhat.com>
	<20190522140729.25970e17.cohuck@redhat.com>
	<6b101b85-4985-4736-acad-59389b00de55@vivier.eu>
	<20190522142421.746f7495.cohuck@redhat.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Cornelia Huck <cohuck@redhat.com>
In-reply-to: <20190522142421.746f7495.cohuck@redhat.com>
Date: Wed, 22 May 2019 14:33:33 +0100
Message-ID: <87blzuhavm.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: Peter
	Maydell <peter.maydell@linaro.org>, Laurent Vivier <laurent@vivier.eu>,
	qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Philippe =?utf-8?Q?Mathieu-Daud?= =?utf-8?Q?=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Cornelia Huck <cohuck@redhat.com> writes:

> On Wed, 22 May 2019 14:10:39 +0200
> Laurent Vivier <laurent@vivier.eu> wrote:
>
>> On 22/05/2019 14:07, Cornelia Huck wrote:
>> > On Wed, 22 May 2019 13:47:25 +0200
>> > Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
>> >
>> >> On 5/21/19 5:28 PM, Cornelia Huck wrote:
>> >>> commit a188339ca5a396acc588e5851ed7e19f66b0ebd9
>> >>>
>> >>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>> >>> ---
>> >> [...]
>> >>>   #define __NR_mq_notify 184
>> >>>   __SC_COMP(__NR_mq_notify, sys_mq_notify, compat_sys_mq_notify)
>> >>>   #define __NR_mq_getsetattr 185
>> >>> @@ -536,8 +567,10 @@ __SC_COMP(__NR_msgsnd, sys_msgsnd, compat_sys_m=
sgsnd)
>> >>>   __SYSCALL(__NR_semget, sys_semget)
>> >>>   #define __NR_semctl 191
>> >>>   __SC_COMP(__NR_semctl, sys_semctl, compat_sys_semctl)
>> >>> +#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG !=3D 32
>> >
>> > Eww. It seems only aarch64 sets __ARCH_WANT_TIME32_SYSCALLS, and the
>> > second condition probably catches others but not mipsel.
>> >
>> >>>   #define __NR_semtimedop 192
>> >>> -__SC_COMP(__NR_semtimedop, sys_semtimedop, compat_sys_semtimedop)
>> >>> +__SC_COMP(__NR_semtimedop, sys_semtimedop, sys_semtimedop_time32)
>> >>> +#endif
>> >>>   #define __NR_semop 193
>> >>>   __SYSCALL(__NR_semop, sys_semop)
>> >> [...]
>> >>
>> >> https://app.shippable.com/github/qemu/qemu/runs/1703/summary/console
>> >>
>> >> It seems this commit introduce a regression on mips32:
>> >>
>> >>    CC      mipsel-linux-user/linux-user/syscall.o
>> >> ./linux-user/syscall.c: In function 'safe_semtimedop':
>> >> ./linux-user/syscall.c:697:25: error: '__NR_semtimedop' undeclared
>> >> (first use in this function)
>> >>       return safe_syscall(__NR_##name, arg1, arg2, arg3, arg4); \
>> >
>> > So, we unconditionally deal with this syscall, i.e. we assume it is
>> > always present? (I'm not sure of the logic in linux-user code.)
>> >
>>
>> linux-user assumes it is present if __NR_msgsnd is present.
>
> Hm. The kernel change seems to break that assumption. Does anyone with
> mips knowledge have an idea whether that was intentional (and the
> linux-user code needs to be changed), or whether that's an issue on the
> kernel side?

Well as far as I understand it the kernel has been introducing new
individual syscalls across the board for all architectures (and may
eventually allow kernels to be built without the legacy stuff).
Meanwhile on the backend some architectures have never had a IPC syscall
to multiplex these things.

We could do:

modified   linux-user/syscall.c
@@ -761,7 +761,7 @@ safe_syscall2(int, nanosleep, const struct timespec *, =
req,
 safe_syscall4(int, clock_nanosleep, const clockid_t, clock, int, flags,
               const struct timespec *, req, struct timespec *, rem)
 #endif
-#ifdef __NR_msgsnd
+#ifndef __NR_ipc
 safe_syscall4(int, msgsnd, int, msgid, const void *, msgp, size_t, sz,
               int, flags)

which would revert to the old behaviour for systems that had the ipc
multiplexer while still using individual system calls for the systems
that never had it. Chatting to the kernel devs on IRC also makes me
wonder if our mapping between the single syscalls and the multiplexer
might be a bit naive. The IPC_64 flags was mentioned as behaving
differently on the new individual syscalls but I haven't been able to
track down exactly what that difference is yet.

--
Alex Benn=C3=A9e

