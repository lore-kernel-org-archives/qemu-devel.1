Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2906CC282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 21:16:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D35462175B
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 21:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ilUggGzp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D35462175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43460 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTv4n-0003Qi-5e
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 17:16:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hTv3f-000333-Ip
	for qemu-devel@nongnu.org; Thu, 23 May 2019 17:15:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hTv3c-0002pQ-P0
	for qemu-devel@nongnu.org; Thu, 23 May 2019 17:15:27 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:33395)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
	id 1hTv3b-0002mO-17; Thu, 23 May 2019 17:15:24 -0400
Received: by mail-oi1-x242.google.com with SMTP id q186so5509845oia.0;
	Thu, 23 May 2019 14:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=0Rrpgh85sRCQL7TKSp9KbTAmV4+S4ftPCXGd2B5KZ6o=;
	b=ilUggGzp1uQ1VeyGoOrOPczD1jjX7O3yxMgGM4DqxoHM5hxIt1Fb9F2grS4kAnG83H
	NJlx7jRdwATCKXoHJCbleHMx/4Aa6OSjGb/Qic5NiAyJNGAhiqRIpAs7fpLMQlvoYdqh
	m78GLSidqvccBtgxuTsoBABA4BD0BSNlwG9YhTxwBzsq5jLYEYSwyD5X1co97o8Y6x8X
	rltbJKvyaY0vuiuANpDQnVTbmk9zlwzHzRSoAEqnZs96319AM1ZrgVtSr6pi9+rRl2al
	uvdziDMKM8tjvAAWKabLmTJF6xFCJEPGdyhRg4mbxZ6o77PkyMLZTslm7lXt6DL1Bpiq
	YvuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=0Rrpgh85sRCQL7TKSp9KbTAmV4+S4ftPCXGd2B5KZ6o=;
	b=SkdjJfg0MYS6SAWYfGCjhGy4GJgVIEAltIdgbvLgBTgTTqyIuHck911GBhj3MXDDzV
	CFbwwg/i1ogVxuQZ2n1rVP6R3gCTEKRXQIhe6/kfHCicyMIIkicLkaUUT/EQYOX2pVWH
	ZpmCLFKTRGgrJNQgXmk/gU16N6wD8IaVOrg2ZF7B1m+JaGx3A64n/gic1u2XNAaf1O42
	fN411E0Vwc3bPb90G84LrIClzsn2UF/h8vsoacVluxo0BNGZ6XhEOE1cn2eU/RoUYL2z
	M/ukyaJQTFk+1VckOAHjWefiFknjxOXLS9ddywfZMOn4yBXOx5OkvRYlP+76qDp2CVI/
	fjNQ==
X-Gm-Message-State: APjAAAXBTu75w4eEiaHJJpLwM/sjqAZpK/H9vyBRoh3Z84GNhZdTjQkW
	u+dXM3LUylQTV96qGh6ZIVS+OEUnisJjVFdeBEU=
X-Google-Smtp-Source: APXvYqxIn/pDWjyc2cd3L17+J8l92RZdZ4o9jXkt5LwWbeXTL5AQABAJUxd0lvwxZCc9z3QKMMW95UKkMBa+J/IEcsU=
X-Received: by 2002:aca:b50b:: with SMTP id e11mr4123432oif.53.1558646120400; 
	Thu, 23 May 2019 14:15:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:410f:0:0:0:0:0 with HTTP; Thu, 23 May 2019 14:15:19
	-0700 (PDT)
Received: by 2002:a9d:410f:0:0:0:0:0 with HTTP; Thu, 23 May 2019 14:15:19
	-0700 (PDT)
In-Reply-To: <20190522155015.67313ae1.cohuck@redhat.com>
References: <20190521152810.21353-1-cohuck@redhat.com>
	<20190521152810.21353-3-cohuck@redhat.com>
	<6e216877-60be-ddcd-3f15-604e870ca8ba@redhat.com>
	<20190522140729.25970e17.cohuck@redhat.com>
	<6b101b85-4985-4736-acad-59389b00de55@vivier.eu>
	<20190522142421.746f7495.cohuck@redhat.com>
	<CAL1e-=j5joi3ssA-7Q2PVp841ywj41Ntz_MSKdB4w27Z9JvcEQ@mail.gmail.com>
	<20190522155015.67313ae1.cohuck@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 23 May 2019 23:15:19 +0200
Message-ID: <CAL1e-=gR3NqD9f0s_e1sCNjQXC3NP2QdxQcXK=us=-A59TPULg@mail.gmail.com>
To: Cornelia Huck <cohuck@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::242
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

On May 22, 2019 3:50 PM, "Cornelia Huck" <cohuck@redhat.com> wrote:
>
> On Wed, 22 May 2019 15:22:23 +0200
> Aleksandar Markovic <aleksandar.m.mail@gmail.com> wrote:
>
> > On May 22, 2019 2:24 PM, "Cornelia Huck" <cohuck@redhat.com> wrote:
> > >
> > > On Wed, 22 May 2019 14:10:39 +0200
> > > Laurent Vivier <laurent@vivier.eu> wrote:
> > >
> > > > On 22/05/2019 14:07, Cornelia Huck wrote:
> > > > > On Wed, 22 May 2019 13:47:25 +0200
> > > > > Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
> > > > >
> > > > >> On 5/21/19 5:28 PM, Cornelia Huck wrote:
> > > > >>> commit a188339ca5a396acc588e5851ed7e19f66b0ebd9
> > > > >>>
> > > > >>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > > > >>> ---
> > > > >> [...]
> > > > >>>   #define __NR_mq_notify 184
> > > > >>>   __SC_COMP(__NR_mq_notify, sys_mq_notify, compat_sys_mq_notify=
)
> > > > >>>   #define __NR_mq_getsetattr 185
> > > > >>> @@ -536,8 +567,10 @@ __SC_COMP(__NR_msgsnd, sys_msgsnd,
> > compat_sys_msgsnd)
> > > > >>>   __SYSCALL(__NR_semget, sys_semget)
> > > > >>>   #define __NR_semctl 191
> > > > >>>   __SC_COMP(__NR_semctl, sys_semctl, compat_sys_semctl)
> > > > >>> +#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG !=
=3D
32
> > > > >
> > > > > Eww. It seems only aarch64 sets __ARCH_WANT_TIME32_SYSCALLS, and
the
> > > > > second condition probably catches others but not mipsel.
> > > > >
> > > > >>>   #define __NR_semtimedop 192
> > > > >>> -__SC_COMP(__NR_semtimedop, sys_semtimedop,
compat_sys_semtimedop)
> > > > >>> +__SC_COMP(__NR_semtimedop, sys_semtimedop,
sys_semtimedop_time32)
> > > > >>> +#endif
> > > > >>>   #define __NR_semop 193
> > > > >>>   __SYSCALL(__NR_semop, sys_semop)
> > > > >> [...]
> > > > >>
> > > > >>
https://app.shippable.com/github/qemu/qemu/runs/1703/summary/console
> > > > >>
> > > > >> It seems this commit introduce a regression on mips32:
> > > > >>
> > > > >>    CC      mipsel-linux-user/linux-user/syscall.o
> > > > >> ./linux-user/syscall.c: In function 'safe_semtimedop':
> > > > >> ./linux-user/syscall.c:697:25: error: '__NR_semtimedop'
undeclared
> > > > >> (first use in this function)
> > > > >>       return safe_syscall(__NR_##name, arg1, arg2, arg3, arg4);
\
> > > > >
> > > > > So, we unconditionally deal with this syscall, i.e. we assume it
is
> > > > > always present? (I'm not sure of the logic in linux-user code.)
> > > > >
> > > >
> > > > linux-user assumes it is present if __NR_msgsnd is present.
> > >
> > > Hm. The kernel change seems to break that assumption. Does anyone wit=
h
> > > mips knowledge have an idea whether that was intentional (and the
> > > linux-user code needs to be changed), or whether that's an issue on
the
> > > kernel side?
> > >
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
> I don't think that's the problematic commit; that one seems to be a
> follow-up on c8ce48f06503 ("asm-generic: Make time32 syscall numbers
> optional") for tools usage (we sync from the 'normal' headers).
>
> The stated intention of the asm-generic commit is to keep 32 bit
> architectures working as before via defining
> __ARCH_WANT_TIME32_SYSCALLS, but it seems that was not done for mips
> (but it should, right?)
>
> > However, I think that QEMU nevertheless should not make the assumption
that
> > if __NR_MSGSND, than semtimedop() is present. It could be true, but it
is
> > still just self-imposed belief in QEMU, kernel never guarantied such
things.
>
> I'm not too familiar with that family of syscalls; is there a better
> way to check for syscall availability here?
>
> > The alternative way of invoking via IPCV6 (else part of =E2=80=9Cifdef
> > __NR_MSGSND=E2=80=9D) should work for MIPS in the present stage of head=
ers and
> > kernel.
>
> If my assumption above (mips skipped by accident) is correct, we need
> to fix the kernel headers instead :/ -- unless we want to add a
> temporary build fix.
>
> > As a side note, perhaps we shoul update kernel headers only off of
stable
> > kernel releases.
>
> In the past, we have even updated the kernel headers against
> non-mainline (kvm) versions :)
>
> Breakage here seems to be rare (and if this is a real kernel interface
> bug, it'd be a good thing that we caught it);

Definitely a good thing. I think it is fair to say that you found three or
even more bugs, in two separate software projects, and all of this using a
single patch only. :-o Perhaps you should do it more often. ;)

> I believe getting support
> for new features into QEMU quicker makes that a good trade-off.
