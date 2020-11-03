Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5195C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 15:52:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2443520786
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 15:52:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2pUjBqI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2443520786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZybl-0002N5-8V
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 10:52:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57666)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kZyaa-0000z1-KY; Tue, 03 Nov 2020 10:51:16 -0500
Received: from mail-io1-xd2f.google.com ([2607:f8b0:4864:20::d2f]:36062)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kZyaP-0007eF-1T; Tue, 03 Nov 2020 10:51:16 -0500
Received: by mail-io1-xd2f.google.com with SMTP id u19so18960556ion.3;
 Tue, 03 Nov 2020 07:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JpuMnPam8QsjApwv3rjjXrzbutYLwId6Wz0h16Iy8LA=;
 b=Y2pUjBqI3Hb6jF8ptiE4HFGpuXLADaX2N6th7VL5BIGtG+jcPbHQtIKRftddcSu7ew
 V7F40N110DEe5rD6XFOYjLnmB25rVR7/W63cinZLJ0ELxLCzKvMTJAL7qMwPrR7D4e9H
 6ZqAjscbET1SMRR6c4hkxmsFQjJ1da9GVPoTrFoF4RbhIGGCe5ZEENt+jTaS1uE4cfk8
 N+RmsHMnn9cjfRJU9zvyizerTdzcE4VpwL1GhNLLFQdTI2IqlwMrmow/Y4R5xWE0tGMM
 uKZ3+SB0zh9onEwPcdHInkhd/m46eQHTap78p9e9DTjR5fpplOZQnIRa9a/aX/g4VQ3n
 V14Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JpuMnPam8QsjApwv3rjjXrzbutYLwId6Wz0h16Iy8LA=;
 b=JX09g+zxtplXU+krIwNc8St4w3stw59QpHw1g5huf8n6DdKf4EtX6Hi9ZC6npt/ahJ
 O5AtJI2nDSEYEgifXvX3Cc8rNSGiG6pFj4ecLwibtqt+EX2Ziyn9B7YeXF+nvMkqWFrY
 ZMqwHMZCtvAcxdtp5BD98DTu8JpXCdwg05xeA9m7KTgTKi9uLbEsOR9oLTvXSJvZroSp
 O1piWYnxNzAX6iOpghck7JOAt7v1ALXcFmy3zVBbtjkSpwtSamSYW5zst+EvQuk/i264
 Gg+M/FPpYzrqQ02K4+uFhw8UpYkuk5XJn5BlMCa41xcdIoaldyaOtnsHTCn+PcoLtcx+
 1GRw==
X-Gm-Message-State: AOAM532pW2JibF0BLSsvL86Zl88DWu4FfoDnhrQHSWzFikZnsX1iGmDN
 KCVu85vR28wynr5ZHep4EiYl1LmRQV9YIt9ryiU=
X-Google-Smtp-Source: ABdhPJw6GtLasKjFGqwMV5/OJTnVmDT+npY37V4JVlhWxZv+ajG2sKL6DcU/O9S+Kh3aVAfifrXQSR1mz9yq6xh+RiA=
X-Received: by 2002:a6b:b30b:: with SMTP id c11mr7373888iof.175.1604418663272; 
 Tue, 03 Nov 2020 07:51:03 -0800 (PST)
MIME-Version: 1.0
References: <20201103120027.6fdc868c@jawa>
In-Reply-To: <20201103120027.6fdc868c@jawa>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 3 Nov 2020 07:39:07 -0800
Message-ID: <CAKmqyKOFxO+NoyA0N2HbNDujKdDg4vFyMvpq=6+TPPxx4-VMFw@mail.gmail.com>
Subject: Re: [QEMU] Question regarding user mode support for ARM syscalls
To: Lukasz Majewski <lukma@denx.de>, 
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2f;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd2f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: GNU C Library <libc-alpha@sourceware.org>,
 qemu-discuss <qemu-discuss@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Nov 3, 2020 at 3:03 AM Lukasz Majewski <lukma@denx.de> wrote:
>
> Dear Qemu Community,

Hey Lukasz,

+ QEMU Dev Mailing list
+ Laurent

>
> I would like to ask you for some advice regarding the usage of
> arm-linux-user/qemu-arm user space program simulation.
>
> Background:
> -----------
>
> I'm looking for a way to efficiently test y2038 in-glibc solution for
> 32 bit architectures (e.g. ARM).
>
> For now I do use qemu-system-arm (part of Yocto/OE), which I'm using to
> run Linux kernel 5.1, glibc under test and Y2038 tests. It works [1].
>
> Problem:
> --------
>
> I would like to test cross-compiled tests (which are built from glibc
> sources) without the need to run the emulated system with
> qemu-system-arm.
>
> I've come across the "QEMU user mode", which would execute the
> cross-compiled test (with already cross-compiled glibc via -L switch)
> and just return exit status code. This sounds appealing.

As another advantage it is much, much faster at running the glibc tests.

>
> As fair as I've read - QEMU user mode emulates ARM syscalls.
>
> During test execution (single qemu user mode process) I would need to
> adjust date with clock_settime64 syscall and then execute other
> syscalls if needed.
>
>
> Please correct me if I'm wrong:
> - It looks like qemu-arm doesn't have switch which would allow it to
>   set time offset (to e.g. year 2039 - something similar to
>   qemu-system-arm -rtc=).
>
> - As of 5.1 qemu version there is no support for syscalls supporting 64
>   bit time on 32 bit architectures (e.g. clock_settime64 and friends
>   from [2]).

There is some support in the current master, for example
__NR_futex_time64 is supported.

I started to add some support for RV32 once it was merged into glibc.

>
> For my example program [3] statically build for testing (it works with
> qemu-system-arm):
>
> ~/work/qemu-arm-tests-program$
> ../qemu-5.1.0-arm/arm-linux-user/qemu-arm -L
> ~/work/yocto/y2038/build/tmp/armv7at2hf-neon-poky-linux-gnueabi/y2038-glibc/2.30+git999-r0/image/opt
> -strace ./cst
>
> 17746 brk(NULL) = 0x00074000
> 17746 brk(0x000748a8) = 0x000748a8
> 17746 uname(0x40800370) = 0
> 17746 readlink("/proc/self/exe",0x407ff488,4096) = 43
> 17746 brk(0x000958a8) = 0x000958a8
> 17746 brk(0x00096000) = 0x00096000
> 17746 mprotect(0x00070000,8192,PROT_READ) = 0
> 17746statx(1,"",AT_EMPTY_PATH|AT_NO_AUTOMOUNT,STATX_BASIC_STATS,0x407ffd70)
> = 0
> 17746 Unknown syscall 404 --> is the syscall number of clock_settime64

clock_settime64 is supported in master QEMU.

>
> 17746 dup(2) = 3
> 17746 fcntl64(3,F_GETFL) = 2
> 17746statx(3,"",AT_EMPTY_PATH|AT_NO_AUTOMOUNT,STATX_BASIC_STATS,0x407ff8e8)
> = 0 ERR
>
> Questions:
> ----------
>
> 1. Is there any plan to add support for emulating syscalls supporting
> 64 bit time on 32 bit architectures [2]?

I would like to have RV32 supported, but it's a low priority for me. I
expect it's something that will eventually happen though.

>
> 2. Provide QEMU user space switch to adjust its time (i.e. add some
> offset to in-fly emulated time syscalls - like clock_settime64) when it
> is started?

That I'm not sure about. I assume just running date/clock_settime64
from a script wouldn't work with the glibc test framework?

Alistair

>
>
> Thanks in advance for your help and reply.
>
>
> Links:
> [1] - https://github.com/lmajewski/meta-y2038/
> [2] -
> https://elixir.bootlin.com/linux/latest/source/arch/arm/tools/syscall.tbl#L419
>
> [3]:
> Example program:
> cat <<- EOF >> clock_settime_test.c
> #include <stdio.h>
> #include <time.h>
>
> int main (int argc, char **argv)
> {
>         struct timespec tv;
>         int ret;
>
>         tv.tv_sec = 0x7FFFFFFF;
>         tv.tv_sec += 61;
>         tv.tv_nsec = 0;
>
>         printf("clock_settime test program: ");
>         ret = clock_settime(CLOCK_REALTIME, &tv);
>         if (!ret)
>                 printf("OK\n");
>         else
>                 perror("ERR\n");
>
>         return 0;
> }
> EOF
>
> Build the test program:
> gcc -Wall -ggdb -D_TIME_BITS=64 -D_FILE_OFFSET_BITS=64 -I/opt/include
> -I/opt/usr/include -L/opt/usr/lib \ -Wl,-rpath=/opt/lib
> -Wl,--dynamic-linker=/opt/lib/ld-linux.so.2 clock_settime_test.c -o cst
> -static
>
>
>
> Best regards,
>
> Lukasz Majewski
>
> --
>
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

