Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB1E8C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 13:54:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78CD8208C3
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 13:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o6cQ2mi4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78CD8208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43759 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTRha-0004K0-K2
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 09:54:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hTRdt-0001K3-Ho
	for qemu-devel@nongnu.org; Wed, 22 May 2019 09:50:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hTRdr-0004hw-OP
	for qemu-devel@nongnu.org; Wed, 22 May 2019 09:50:53 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:37313)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
	id 1hTRdr-0004hK-Hs; Wed, 22 May 2019 09:50:51 -0400
Received: by mail-ot1-x342.google.com with SMTP id r10so2123258otd.4;
	Wed, 22 May 2019 06:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:from:date:message-id:subject:to:cc;
	bh=5BOV7QcYHQd2K/+9/a1wrSHjiCK5bObxuygjY0/Ocvw=;
	b=o6cQ2mi4Q4sjRS0yC+/55IvnTXN5hEJSUGLDqnWgT4ZFsTZc69hXmQM8JAnk4+IiZx
	xlVpaXuvNEi8p/xjGdtA8fqIQ19XderqDZXNrfjvqyYwE+WAT4w4EzuzzCpLO4G8sx0p
	vPIQqXmZ490JckEnObEz/BCXGGYyQEX5mP9fi7yCPG909TfYvotohI2l6hJGOTwKIjJt
	fTlSpttTujIzZg6w6tU73tDMj8UCLTEPfz32AZq+fGbXCJWxWwsqwV0Nr5c1jQQR4KYR
	2ak/c8ZFmS8ZXu52dMb1lzMqjxPEHmtuIKEDY/Eb1QQb0WQl7BDjhkACdFX8qlNothk5
	rD3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
	bh=5BOV7QcYHQd2K/+9/a1wrSHjiCK5bObxuygjY0/Ocvw=;
	b=VKq6N6Sae2JtWsocdp8Mh54IwyD6bFV1VTkjVSfS85PaemNnQoTaMFX82LhwABXkMR
	7vFRlpNVo/bJZ5zdydZmHPdr+HrYyrHAcokNEd7b6Ylv+VYfk7TYH82EvpX4w+Hd6/Ec
	o3YlDPyqonEDY3MinKhHIaHDFu7pPJHAuhbSpMC3fhZ3zQ4HCbe1yE0oRocsOKpjsnNv
	6W7f6Ej3F/0h/XDj6z5pIP2J55nbMkqBw6EF/8fP1kJuu2bQ4p4G5t0+2w5DfHEP3lsy
	wbtWIka8SDzg6eWIHGHL6id/6djryZoISwyiwx06dY/hjW2UVcR2q6Jveki4lU8YlHny
	ws6g==
X-Gm-Message-State: APjAAAVKlJW0HZ47759o+NL98fBrLTvWr9lMFN+UxmEdgt406+/3B+tO
	Gye3RdF/NK1w5uEm7kbrxfE/nFDAfxxwGbrSKZg=
X-Google-Smtp-Source: APXvYqxA78p6LyBcJtAYFu9R7AVkV2pv8f6jUfdwoV0zeul7yixCsx6e14Z8YQJtcdHp11IZvKnf6EMnAXOiLuj1SKI=
X-Received: by 2002:a9d:61d5:: with SMTP id h21mr21122153otk.306.1558533050520;
	Wed, 22 May 2019 06:50:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:410f:0:0:0:0:0 with HTTP; Wed, 22 May 2019 06:50:48
	-0700 (PDT)
Received: by 2002:a9d:410f:0:0:0:0:0 with HTTP; Wed, 22 May 2019 06:50:48
	-0700 (PDT)
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Wed, 22 May 2019 15:50:48 +0200
Message-ID: <CAL1e-=i4++B0iFU7k+G_pCZYg=O_sHhKvxM-aWpTZQZk44t4-A@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::342
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
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
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On May 22, 2019 3:42 PM, "Alex Benn=C3=A9e" <alex.bennee@linaro.org> wrote:
>
>
> Aleksandar Markovic <aleksandar.m.mail@gmail.com> writes:
>
> > On May 22, 2019 2:24 PM, "Cornelia Huck" <cohuck@redhat.com> wrote:
> >>
> >> On Wed, 22 May 2019 14:10:39 +0200
> >> Laurent Vivier <laurent@vivier.eu> wrote:
> >>
> >> > On 22/05/2019 14:07, Cornelia Huck wrote:
> >> > > On Wed, 22 May 2019 13:47:25 +0200
> >> > > Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
> >> > >
> >> > >> On 5/21/19 5:28 PM, Cornelia Huck wrote:
> >> > >>> commit a188339ca5a396acc588e5851ed7e19f66b0ebd9
> >> > >>>
> >> > >>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> >> > >>> ---
> >> > >> [...]
> >> > >>>   #define __NR_mq_notify 184
> >> > >>>   __SC_COMP(__NR_mq_notify, sys_mq_notify, compat_sys_mq_notify)
> >> > >>>   #define __NR_mq_getsetattr 185
> >> > >>> @@ -536,8 +567,10 @@ __SC_COMP(__NR_msgsnd, sys_msgsnd,
> > compat_sys_msgsnd)
> >> > >>>   __SYSCALL(__NR_semget, sys_semget)
> >> > >>>   #define __NR_semctl 191
> >> > >>>   __SC_COMP(__NR_semctl, sys_semctl, compat_sys_semctl)
> >> > >>> +#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG !=
=3D
32
> >> > >
> >> > > Eww. It seems only aarch64 sets __ARCH_WANT_TIME32_SYSCALLS, and
the
> >> > > second condition probably catches others but not mipsel.
> >> > >
> >> > >>>   #define __NR_semtimedop 192
> >> > >>> -__SC_COMP(__NR_semtimedop, sys_semtimedop,
compat_sys_semtimedop)
> >> > >>> +__SC_COMP(__NR_semtimedop, sys_semtimedop,
sys_semtimedop_time32)
> >> > >>> +#endif
> >> > >>>   #define __NR_semop 193
> >> > >>>   __SYSCALL(__NR_semop, sys_semop)
> >> > >> [...]
> >> > >>
> >> > >>
https://app.shippable.com/github/qemu/qemu/runs/1703/summary/console
> >> > >>
> >> > >> It seems this commit introduce a regression on mips32:
> >> > >>
> >> > >>    CC      mipsel-linux-user/linux-user/syscall.o
> >> > >> ./linux-user/syscall.c: In function 'safe_semtimedop':
> >> > >> ./linux-user/syscall.c:697:25: error: '__NR_semtimedop' undeclare=
d
> >> > >> (first use in this function)
> >> > >>       return safe_syscall(__NR_##name, arg1, arg2, arg3, arg4); \
> >> > >
> >> > > So, we unconditionally deal with this syscall, i.e. we assume it i=
s
> >> > > always present? (I'm not sure of the logic in linux-user code.)
> >> > >
> >> >
> >> > linux-user assumes it is present if __NR_msgsnd is present.
> >>
> >> Hm. The kernel change seems to break that assumption. Does anyone with
> >> mips knowledge have an idea whether that was intentional (and the
> >> linux-user code needs to be changed), or whether that's an issue on th=
e
> >> kernel side?
> >>
> >
> > Hi, Cornelia.
> >
> > Thanks for your involving into this issue!
> >
> > It could be that (not-originating-from-MIPS) kernel commit:
> >
> >
https://github.com/torvalds/linux/commit/1a787fc5ba18ac767e635c58d06a0b4687=
6184e3
> >
> > made a mess with system call availability for MIPS (I will forward this
to
> > MIPS kernel maintainer Paul Burton). My impression is that this was not
> > intentional, and is a temporary instability of kernel interface.
>
> I think this stems from 2038 time bomb work. Eventually they want it to
> be possible to build non-legacy kernels that don't expose time32 to the
> outside world. As part of that new system calls are being introduced
> where needed. The IPC syscall which orignally multiplexed a bunch of
> these operations on some systems would eventually be potentially phased
> out.
>
> > However, I think that QEMU nevertheless should not make the assumption
that
> > if __NR_MSGSND, than semtimedop() is present. It could be true, but it
is
> > still just self-imposed belief in QEMU, kernel never guarantied such
things.
> >
> > The alternative way of invoking via IPCV6 (else part of =E2=80=9Cifdef
> > __NR_MSGSND=E2=80=9D) should work for MIPS in the present stage of head=
ers and
> > kernel.
>
> Yeah I think #ifndef __NR_ipc would work for now. It shouldn't affect
> architectures that never had the IPC call.
>
> > As a side note, perhaps we shoul update kernel headers only off of
stable
> > kernel releases.
>
> I guess that's a part of the tension for supporting new kernel APIs
> quickly. At least 5.2-rc1 wasn't a random tree - you would expect the
> external facing ABI to be stable after the merge window closed. It would
> be nice to know what new features were being exposed though.
>

Yes, one would expect no intentional changes in ABI kernel headers would
happen after RC1. However, one must expect that there could certainly be
bugs in RC1 - and there is a larger risk of propagating these bugs to QEMU
with header updates from non-stable code.

Sincerely,
Aleksandar

> >
> > Regards,
> > Aleksandar
>
>
> --
> Alex Benn=C3=A9e
