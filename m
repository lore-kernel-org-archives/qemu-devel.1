Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2EFBC282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 13:28:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE2EC2089E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 13:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i7mgIWYo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE2EC2089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43228 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTRIA-0002Mk-Gv
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 09:28:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hTRGd-0001KH-1F
	for qemu-devel@nongnu.org; Wed, 22 May 2019 09:26:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hTRCN-0003Ri-NZ
	for qemu-devel@nongnu.org; Wed, 22 May 2019 09:22:30 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:35374)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
	id 1hTRCM-0003Q1-0J; Wed, 22 May 2019 09:22:26 -0400
Received: by mail-ot1-x343.google.com with SMTP id n14so2043073otk.2;
	Wed, 22 May 2019 06:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=sQAZR0NPx40vPQRD3E8v3sspdsEZaKdp+x7HH3j/mnU=;
	b=i7mgIWYozqNLVnUVUtmSeo5+C7WL9YA/MpF60DXqajLv9Fz6rlZPjvJuY/ILPnHl8X
	eEh6P9rSlE39v2oEtq0suCoNKoRbkT6EEJ4qLaNoXyzyVZgAom+Ny9Bqe+b9ukfdKCcQ
	9qMpghg8GzN+KBAVa97egeyjvAIL/GK5ONsBmYfOpV/LPjVVK+nr9SDf53V1MH5q0GM4
	oBgTaKUrdv4BJMu/CMyKNWBufTSo3RakseIOva6+FgYLChwHziWMa0METfebWRvKlYWp
	fNfNstyHRVyvy0BVfxXFuQZIjOZxz2tHQU5LbeadeWHzqzL9Yhd3y355soII59d4R/Ax
	OUFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=sQAZR0NPx40vPQRD3E8v3sspdsEZaKdp+x7HH3j/mnU=;
	b=e9z2TT0cZ3shDTXDSQ0erHNE9EEzKq5oniB0kAxxrkp6C7ZsQ2fgkBrnXgN+wwIprG
	cI13yhDseO/50ElJlhsEk+ZRBC0xOPn2ZLwWPoWFoT1Ti/mpJYl/GgzzyO5BVFYsvnGj
	UuaujkhCS40UJL/4iek4Oqv5X1eGx0t1i1N8AcSp6ErxBk25MKu+gMrEq+kfnC1LCB4X
	NLpiLGB+qvpZFuBnmGJCLgi5nH2HK2Am/fD0YatuY/TPR2N9ui5g2OWe0Xzjga6JUiwA
	u3+/t7K/Tf1Gffkac1w+pyuukv31fzgnRGQr6u9TnolWRiotASAxb53uvh+PI8Fivi4g
	tlbw==
X-Gm-Message-State: APjAAAXMf5gUIVR3pspmPPU/h0RaQeJGjzBLwyAFsLCXSyKUHSe5z+7E
	rYkgSjRiYewMyMpsXNuyS8Fw44b5Bmwl+W9r7Ao=
X-Google-Smtp-Source: APXvYqxBmr26WRPRmdubptLsfhBTAJ21R6dnfFYgC8drO9/wQ+7yWwosec6rmd8BILGKAwmS9Cc9e2QqFYywvJrn/aw=
X-Received: by 2002:a05:6830:160a:: with SMTP id
	g10mr56786otr.121.1558531344555; 
	Wed, 22 May 2019 06:22:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:410f:0:0:0:0:0 with HTTP; Wed, 22 May 2019 06:22:23
	-0700 (PDT)
Received: by 2002:a9d:410f:0:0:0:0:0 with HTTP; Wed, 22 May 2019 06:22:23
	-0700 (PDT)
In-Reply-To: <20190522142421.746f7495.cohuck@redhat.com>
References: <20190521152810.21353-1-cohuck@redhat.com>
	<20190521152810.21353-3-cohuck@redhat.com>
	<6e216877-60be-ddcd-3f15-604e870ca8ba@redhat.com>
	<20190522140729.25970e17.cohuck@redhat.com>
	<6b101b85-4985-4736-acad-59389b00de55@vivier.eu>
	<20190522142421.746f7495.cohuck@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Wed, 22 May 2019 15:22:23 +0200
Message-ID: <CAL1e-=j5joi3ssA-7Q2PVp841ywj41Ntz_MSKdB4w27Z9JvcEQ@mail.gmail.com>
To: Cornelia Huck <cohuck@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
	qemu-s390x@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On May 22, 2019 2:24 PM, "Cornelia Huck" <cohuck@redhat.com> wrote:
>
> On Wed, 22 May 2019 14:10:39 +0200
> Laurent Vivier <laurent@vivier.eu> wrote:
>
> > On 22/05/2019 14:07, Cornelia Huck wrote:
> > > On Wed, 22 May 2019 13:47:25 +0200
> > > Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
> > >
> > >> On 5/21/19 5:28 PM, Cornelia Huck wrote:
> > >>> commit a188339ca5a396acc588e5851ed7e19f66b0ebd9
> > >>>
> > >>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > >>> ---
> > >> [...]
> > >>>   #define __NR_mq_notify 184
> > >>>   __SC_COMP(__NR_mq_notify, sys_mq_notify, compat_sys_mq_notify)
> > >>>   #define __NR_mq_getsetattr 185
> > >>> @@ -536,8 +567,10 @@ __SC_COMP(__NR_msgsnd, sys_msgsnd,
compat_sys_msgsnd)
> > >>>   __SYSCALL(__NR_semget, sys_semget)
> > >>>   #define __NR_semctl 191
> > >>>   __SC_COMP(__NR_semctl, sys_semctl, compat_sys_semctl)
> > >>> +#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG !=3D 3=
2
> > >
> > > Eww. It seems only aarch64 sets __ARCH_WANT_TIME32_SYSCALLS, and the
> > > second condition probably catches others but not mipsel.
> > >
> > >>>   #define __NR_semtimedop 192
> > >>> -__SC_COMP(__NR_semtimedop, sys_semtimedop, compat_sys_semtimedop)
> > >>> +__SC_COMP(__NR_semtimedop, sys_semtimedop, sys_semtimedop_time32)
> > >>> +#endif
> > >>>   #define __NR_semop 193
> > >>>   __SYSCALL(__NR_semop, sys_semop)
> > >> [...]
> > >>
> > >> https://app.shippable.com/github/qemu/qemu/runs/1703/summary/console
> > >>
> > >> It seems this commit introduce a regression on mips32:
> > >>
> > >>    CC      mipsel-linux-user/linux-user/syscall.o
> > >> ./linux-user/syscall.c: In function 'safe_semtimedop':
> > >> ./linux-user/syscall.c:697:25: error: '__NR_semtimedop' undeclared
> > >> (first use in this function)
> > >>       return safe_syscall(__NR_##name, arg1, arg2, arg3, arg4); \
> > >
> > > So, we unconditionally deal with this syscall, i.e. we assume it is
> > > always present? (I'm not sure of the logic in linux-user code.)
> > >
> >
> > linux-user assumes it is present if __NR_msgsnd is present.
>
> Hm. The kernel change seems to break that assumption. Does anyone with
> mips knowledge have an idea whether that was intentional (and the
> linux-user code needs to be changed), or whether that's an issue on the
> kernel side?
>

Hi, Cornelia.

Thanks for your involving into this issue!

It could be that (not-originating-from-MIPS) kernel commit:

https://github.com/torvalds/linux/commit/1a787fc5ba18ac767e635c58d06a0b4687=
6184e3

made a mess with system call availability for MIPS (I will forward this to
MIPS kernel maintainer Paul Burton). My impression is that this was not
intentional, and is a temporary instability of kernel interface.

However, I think that QEMU nevertheless should not make the assumption that
if __NR_MSGSND, than semtimedop() is present. It could be true, but it is
still just self-imposed belief in QEMU, kernel never guarantied such things=
.

The alternative way of invoking via IPCV6 (else part of =E2=80=9Cifdef
__NR_MSGSND=E2=80=9D) should work for MIPS in the present stage of headers =
and
kernel.

As a side note, perhaps we shoul update kernel headers only off of stable
kernel releases.

Regards,
Aleksandar
