Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E55EFC28CC3
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 10:46:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1D42267AD
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 10:46:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1D42267AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40830 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWf3l-0008HC-UT
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 06:46:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmathieu@redhat.com>) id 1hWf1m-0006m0-57
	for qemu-devel@nongnu.org; Fri, 31 May 2019 06:44:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmathieu@redhat.com>) id 1hWf1j-0001IT-Um
	for qemu-devel@nongnu.org; Fri, 31 May 2019 06:44:49 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:37860)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pmathieu@redhat.com>) id 1hWf1h-0000zE-Tj
	for qemu-devel@nongnu.org; Fri, 31 May 2019 06:44:47 -0400
Received: by mail-ua1-f67.google.com with SMTP id l3so3537330uad.4
	for <qemu-devel@nongnu.org>; Fri, 31 May 2019 03:44:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=EdhB9JH3Hwhf79ZfXwKSc7iAncNQo6k0AQsUx2P2i0A=;
	b=hhU6jcFSrW6dtFMAzwD9OaRoHg4tEoMW8PdzrMH0ArYw+q+XWR27lmMb2+q5I2J1lC
	GVvk0ld89mWXnjZTNflaLdoUGpAAcu/wFJovOU3R185RUBTdYSDcldOAJA/3Y7GZnPuz
	VyNexjYaqWAkxTDGu80erCfHSmzb+nhilRP8VZHDUlZf9znabaDPPYKuBPC0VYvBvNMH
	KjQ9BAOAYHRhOrFyTIqOCr51hlrc3tT0y5IKkANG568q+N4RD137rz4O9PhVSgl1f/zB
	hnGN76McALy2CTcxHj/J6Qb3VIxHU2Tb6yztVWrLZ8QLs6QKk0V6UUwYWZlGXlk7pDlf
	oWzg==
X-Gm-Message-State: APjAAAWSjVBQRWaRyJuwHSlkDHGAC0tNI8MzNdMM+cxIQtZfh18kSvp9
	60z/7QgB0t0os/OyIZHytgMgncbnrckxgcK5/rbm2w==
X-Google-Smtp-Source: APXvYqzR2Onq3HkFNqNS1n0k3XRe4xn2VvgKtnTXWnExfgb1pn8jFrluOvZyro1zqAdEkRgLFm41NsC2H/f7+IJgigM=
X-Received: by 2002:ab0:698f:: with SMTP id t15mr4914986uaq.34.1559299475418; 
	Fri, 31 May 2019 03:44:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190514155301.16123-1-alex.bennee@linaro.org>
	<20190514155301.16123-7-alex.bennee@linaro.org>
	<20190531091204.tjmq622gw457xbdr@lws.brq.redhat.com>
	<891973f7-2f2b-ad59-70bf-6069382fd977@redhat.com>
In-Reply-To: <891973f7-2f2b-ad59-70bf-6069382fd977@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Fri, 31 May 2019 12:44:24 +0200
Message-ID: <CAP+75-UfBN0SKrtcDDhp+anbbFz7u0AjmM=7robpeEPQC6fhKw@mail.gmail.com>
To: Miroslav Rezanina <mrezanin@redhat.com>,
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.222.67
Subject: Re: [Qemu-devel] [RFC PATCH 06/11] target/arm: use the common
 interface for WRITE0/WRITEC in arm-semi
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Laurent Vivier <laurent@vivier.eu>, qemu-arm <qemu-arm@nongnu.org>,
	Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 31, 2019 at 12:42 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> Hi Miroslav,
>
> On 5/31/19 11:12 AM, Miroslav Rezanina wrote:
> > On Tue, May 14, 2019 at 04:52:56PM +0100, Alex Benn=C3=A9e wrote:
> >> Now we have a common semihosting console interface use that for our
> >> string output. However ARM is currently unique in also supporting
> >> semihosting for linux-user so we need to replicate the API in
> >> linux-user. If other architectures gain this support we can move the
> >> file later.
> >>
> >> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> >> ---
> >>  linux-user/Makefile.objs  |  2 ++
> >>  linux-user/arm/semihost.c | 24 ++++++++++++++++++++++++
> >>  target/arm/arm-semi.c     | 31 ++++++-------------------------
> >>  3 files changed, 32 insertions(+), 25 deletions(-)
> >>  create mode 100644 linux-user/arm/semihost.c
> >>
> >> diff --git a/linux-user/Makefile.objs b/linux-user/Makefile.objs
> >> index 769b8d83362..285c5dfa17a 100644
> >> --- a/linux-user/Makefile.objs
> >> +++ b/linux-user/Makefile.objs
> >> @@ -6,4 +6,6 @@ obj-y =3D main.o syscall.o strace.o mmap.o signal.o \
> >>  obj-$(TARGET_HAS_BFLT) +=3D flatload.o
> >>  obj-$(TARGET_I386) +=3D vm86.o
> >>  obj-$(TARGET_ARM) +=3D arm/nwfpe/
> >> +obj-$(TARGET_ARM) +=3D arm/semihost.o
> >> +obj-$(TARGET_AARCH64) +=3D arm/semihost.o
> >>  obj-$(TARGET_M68K) +=3D m68k-sim.o
> >> diff --git a/linux-user/arm/semihost.c b/linux-user/arm/semihost.c
> >> new file mode 100644
> >> index 00000000000..9554102a855
> >> --- /dev/null
> >> +++ b/linux-user/arm/semihost.c
> >> @@ -0,0 +1,24 @@
> >> +/*
> >> + * ARM Semihosting Console Support
> >> + *
> >> + * Copyright (c) 2019 Linaro Ltd
> >> + *
> >> + * Currently ARM is unique in having support for semihosting support
> >> + * in linux-user. So for now we implement the common console API but
> >> + * just for arm linux-user.
> >> + *
> >> + * SPDX-License-Identifier: GPL-2.0-or-later
> >> + */
> >> +
> >> +#include "qemu/osdep.h"
> >> +#include "cpu.h"
> >> +#include "hw/semihosting/console.h"
> >> +#include "qemu.h"
> >> +
> >> +int qemu_semihosting_console_out(CPUArchState *env, target_ulong addr=
, int len)
> >> +{
> >> +    void *s =3D lock_user_string(addr);
> >> +    len =3D write(STDERR_FILENO, s, len ? len : strlen(s));
> >> +    unlock_user(s, addr, 0);
> >> +    return len;
> >> +}
> >> diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
> >> index 9e5a414dd89..253c66b172a 100644
> >> --- a/target/arm/arm-semi.c
> >> +++ b/target/arm/arm-semi.c
> >> @@ -27,6 +27,7 @@
> >>
> >>  #include "cpu.h"
> >>  #include "hw/semihosting/semihost.h"
> >> +#include "hw/semihosting/console.h"
> >>  #ifdef CONFIG_USER_ONLY
> >>  #include "qemu.h"
> >>
> >> @@ -314,32 +315,12 @@ target_ulong do_arm_semihosting(CPUARMState *env=
)
> >>              return set_swi_errno(ts, close(arg0));
> >>          }
> >>      case TARGET_SYS_WRITEC:
> >> -        {
> >> -          char c;
> >> -
> >> -          if (get_user_u8(c, args))
> >> -              /* FIXME - should this error code be -TARGET_EFAULT ? *=
/
> >> -              return (uint32_t)-1;
> >> -          /* Write to debug console.  stderr is near enough.  */
> >> -          if (use_gdb_syscalls()) {
> >> -                return arm_gdb_syscall(cpu, arm_semi_cb, "write,2,%x,=
1", args);
> >> -          } else {
> >> -                return write(STDERR_FILENO, &c, 1);
> >> -          }
> >> -        }
> >> +    {
> >> +        qemu_semihosting_console_out(env, args, 1);
> >> +        return 0xdeadbeef;
> >> +    }
> >>      case TARGET_SYS_WRITE0:
> >> -        if (!(s =3D lock_user_string(args)))
> >> -            /* FIXME - should this error code be -TARGET_EFAULT ? */
> >> -            return (uint32_t)-1;
> >> -        len =3D strlen(s);
> >> -        if (use_gdb_syscalls()) {
> >> -            return arm_gdb_syscall(cpu, arm_semi_cb, "write,2,%x,%x",
> >> -                                   args, len);
> >> -        } else {
> >> -            ret =3D write(STDERR_FILENO, s, len);
> >> -        }
> >> -        unlock_user(s, args, 0);
> >> -        return ret;
> >> +        return qemu_semihosting_console_out(env, args, 0);
> >>      case TARGET_SYS_WRITE:
> >>          GET_ARG(0);
> >>          GET_ARG(1);
> >> --
> >> 2.20.1
> >>
> >>
> >
> > Hi Alex,
> >
> > this patch breaks build for softmmu target when CONFIG_SEMIHOSTING is n=
ot enabled as qemu_semihosting_console_out
> > is not defined in such case - neither linux-user/arm/semihost.c nor hw/=
semihosting/console.c compiled and function
> > is not in stubs/semihost.c

linux-user/arm/semihost.c is not built on softmmu-only build.

> Kinda funny, I noticed the same issue at the same time, and was chatting
> with Alex about it.
>
> I prepared a patch expliciting we can not disable CONFIG_SEMIHOSTING on
> the MIPS arch. Would that work for you?
>
> Regards,
>
> Phil.

