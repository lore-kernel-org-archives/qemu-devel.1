Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE337C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 18:08:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F21DA20757
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 18:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZs8ZWAv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F21DA20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka0je-0002A5-S1
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 13:08:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41326)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ka0iy-0001jy-4c; Tue, 03 Nov 2020 13:08:04 -0500
Received: from mail-io1-xd2a.google.com ([2607:f8b0:4864:20::d2a]:38185)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ka0iw-0004MG-1d; Tue, 03 Nov 2020 13:08:03 -0500
Received: by mail-io1-xd2a.google.com with SMTP id n129so102862iod.5;
 Tue, 03 Nov 2020 10:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pf+pqWIBLCXzYgo9aCietmBzD9lDDQf+1693aI/5x+g=;
 b=OZs8ZWAvIwMz3wkCn+lqdILHHcG+3OQ2CEiEXulriaUDSRH8UoOcwb3a2iy/qsewOx
 Oco2iBPTMv3LF1pggCwcyY6urnbpYxdCXbyj4yTl5N8twqZcUiwl79Yfdnp6thAJMQGv
 VsDV6mb6yaRgGN8HJqbkhjEK1lVMWRVXsV/b7F7LMzoLIzu1zB0xCJigsQR8KgodmFm2
 5MAjVnQQAnH4kog6u6lCkk/Y+KgxPiu1B1mHOCqWCi13EV3YzCQODxrrFLQAEzp06T/b
 /r4eUQyJEs08+xvvQLDwmQSfy6jva/Q/bh3VUNibRa5wTWjBCl17y9XCyUh0FT4CSK54
 ToQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pf+pqWIBLCXzYgo9aCietmBzD9lDDQf+1693aI/5x+g=;
 b=iBMnBUOdDMYntyJz7etVD1HgL4/UkHmj6FFhpuYc4E32cwRGNiPsdZKXGtuE7lCbOW
 26cDh++8WKYR3Eat4bqaKOlrsou8CL2z3pQDyUiBAx559i1zk8cVqH9jOIGmUNlGGPNk
 4jVwrIsExaepOozZrhMNDtOFfodbLk3UxmBMSO6U+ME1Rorbt63vbHkYDZKck+Yu3vwK
 NUxEYdoyXfzIbN2M5Uj5CLTAE1DcQqiTYoJaaxvpl/WNtQ4bGphqzI79GhrLw/Mfsl4r
 YmKtOo6AyihKvnnTUb9NxFoqvFFiFWWIXQgVXhmuUskBaX4yNSk5r+MeBFVEKbJX5H2L
 3rHw==
X-Gm-Message-State: AOAM532bxqbdn2cRsVSVediiNjEkq5DZ25PnmJ6lLYvGMV2hbhknH5PZ
 BCpC51yJjUYITgexl/2OE/RFJR7XmC+TVLmYfco=
X-Google-Smtp-Source: ABdhPJwEIEHEz+FmJlTxDYIvLd2rKDeXMCo1STfUAsz3BPlleBaWWsHY/n3gvwO/GbI2X5eAx54V7KHwWnPLX2siq/o=
X-Received: by 2002:a5d:9a8d:: with SMTP id c13mr14661093iom.176.1604426879610; 
 Tue, 03 Nov 2020 10:07:59 -0800 (PST)
MIME-Version: 1.0
References: <20201103120027.6fdc868c@jawa>
 <CAKmqyKOFxO+NoyA0N2HbNDujKdDg4vFyMvpq=6+TPPxx4-VMFw@mail.gmail.com>
 <20201103175532.796074fb@jawa>
In-Reply-To: <20201103175532.796074fb@jawa>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 3 Nov 2020 09:56:03 -0800
Message-ID: <CAKmqyKNRU8EqcyVv4gduNsKcMOUWSmW2oWTvfWMNS3C70Nx9PQ@mail.gmail.com>
Subject: Re: [QEMU] Question regarding user mode support for ARM syscalls
To: Lukasz Majewski <lukma@denx.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2a;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd2a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-discuss <qemu-discuss@nongnu.org>,
 GNU C Library <libc-alpha@sourceware.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Nov 3, 2020 at 8:55 AM Lukasz Majewski <lukma@denx.de> wrote:
>
> Hi Alistair,
>
> > On Tue, Nov 3, 2020 at 3:03 AM Lukasz Majewski <lukma@denx.de> wrote:
> > >
> > > Dear Qemu Community,
> >
> > Hey Lukasz,
> >
> > + QEMU Dev Mailing list
> > + Laurent
> >
>
> Thanks for reaching more people.
>
> > >
> > > I would like to ask you for some advice regarding the usage of
> > > arm-linux-user/qemu-arm user space program simulation.
> > >
> > > Background:
> > > -----------
> > >
> > > I'm looking for a way to efficiently test y2038 in-glibc solution
> > > for 32 bit architectures (e.g. ARM).
> > >
> > > For now I do use qemu-system-arm (part of Yocto/OE), which I'm
> > > using to run Linux kernel 5.1, glibc under test and Y2038 tests. It
> > > works [1].
> > >
> > > Problem:
> > > --------
> > >
> > > I would like to test cross-compiled tests (which are built from
> > > glibc sources) without the need to run the emulated system with
> > > qemu-system-arm.
> > >
> > > I've come across the "QEMU user mode", which would execute the
> > > cross-compiled test (with already cross-compiled glibc via -L
> > > switch) and just return exit status code. This sounds appealing.
> >
> > As another advantage it is much, much faster at running the glibc
> > tests.
> >
>
> +1
>
> > >
> > > As fair as I've read - QEMU user mode emulates ARM syscalls.
> > >
> > > During test execution (single qemu user mode process) I would need
> > > to adjust date with clock_settime64 syscall and then execute other
> > > syscalls if needed.
> > >
> > >
> > > Please correct me if I'm wrong:
> > > - It looks like qemu-arm doesn't have switch which would allow it to
> > >   set time offset (to e.g. year 2039 - something similar to
> > >   qemu-system-arm -rtc=).
> > >
> > > - As of 5.1 qemu version there is no support for syscalls
> > > supporting 64 bit time on 32 bit architectures (e.g.
> > > clock_settime64 and friends from [2]).
> >
> > There is some support in the current master, for example
> > __NR_futex_time64 is supported.
>
> I've just looked into v5.1.0 stable release. I will double check this
> with -master branch.
>
> >
> > I started to add some support for RV32 once it was merged into glibc.
>
> Ok.
>
> >
> > >
> > > For my example program [3] statically build for testing (it works
> > > with qemu-system-arm):
> > >
> > > ~/work/qemu-arm-tests-program$
> > > ../qemu-5.1.0-arm/arm-linux-user/qemu-arm -L
> > > ~/work/yocto/y2038/build/tmp/armv7at2hf-neon-poky-linux-gnueabi/y2038-glibc/2.30+git999-r0/image/opt
> > > -strace ./cst
> > >
> > > 17746 brk(NULL) = 0x00074000
> > > 17746 brk(0x000748a8) = 0x000748a8
> > > 17746 uname(0x40800370) = 0
> > > 17746 readlink("/proc/self/exe",0x407ff488,4096) = 43
> > > 17746 brk(0x000958a8) = 0x000958a8
> > > 17746 brk(0x00096000) = 0x00096000
> > > 17746 mprotect(0x00070000,8192,PROT_READ) = 0
> > > 17746statx(1,"",AT_EMPTY_PATH|AT_NO_AUTOMOUNT,STATX_BASIC_STATS,0x407ffd70)
> > > = 0
> > > 17746 Unknown syscall 404 --> is the syscall number of
> > > clock_settime64
> >
> > clock_settime64 is supported in master QEMU.
>
> I will double check it - thanks for pointing this out.
>
> >
> > >
> > > 17746 dup(2) = 3
> > > 17746 fcntl64(3,F_GETFL) = 2
> > > 17746statx(3,"",AT_EMPTY_PATH|AT_NO_AUTOMOUNT,STATX_BASIC_STATS,0x407ff8e8)
> > > = 0 ERR
> > >
> > > Questions:
> > > ----------
> > >
> > > 1. Is there any plan to add support for emulating syscalls
> > > supporting 64 bit time on 32 bit architectures [2]?
> >
> > I would like to have RV32 supported, but it's a low priority for me.
>
> Having syscalls supporting 64 bit time on 32 bit machines indicated in
> [2] would be a very welcome for glibc testing.
>
> > I
> > expect it's something that will eventually happen though.
>
> Ok.
>
> >
> > >
> > > 2. Provide QEMU user space switch to adjust its time (i.e. add some
> > > offset to in-fly emulated time syscalls - like clock_settime64)
> > > when it is started?
> >
> > That I'm not sure about.
>
> For me it would be enough to have:
>
> qemu-arm -rtc="2039-01-01" -L... ./ctx
> So the emulated "time" would be after 32 bit time_t overflow when
> QEMU user space emulation process starts (as long as it doesn't touch
> the host machine time).
>
>
> Another option (workaround) would be to run clock_settime64() with time
> set to year 2038+ on the beginning of each glibc test. It shall work as
> long as we don't change host time (and all time changes would stay in
> the qemu user mode process).
>
> > I assume just running date/clock_settime64
> > from a script wouldn't work with the glibc test framework?
>
> Could you elaborate on this use case/scenario? Do you have some
> examples to share?

Whoops, I got confused here. The clock_gettime syscall goes to the
host, so we just report host time. I was thinking about softMMU where
we maintain our own time.

So your proposed `-rtc` command would add an offset to the host time?
Something like:

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 3160a9ba06..240bd59bb2 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -12074,6 +12074,7 @@ static abi_long do_syscall1(void *cpu_env, int
num, abi_long arg1,

         ret = target_to_host_timespec64(&ts, arg2);
         if (!is_error(ret)) {
+            ts.tv_sec -= 567993505;
             ret = get_errno(clock_settime(arg1, &ts));
         }
         return ret;
@@ -12096,6 +12097,8 @@ static abi_long do_syscall1(void *cpu_env, int
num, abi_long arg1,
         struct timespec ts;
         ret = get_errno(clock_gettime(arg1, &ts));
         if (!is_error(ret)) {
+            // Calculate different to same time in 2038
+            ts.tv_sec += 567993505;
             ret = host_to_target_timespec64(arg2, &ts);
         }
         return ret;

That might end up working if you can intercept all of the absolute
time syscalls.

Without any mainline support that would be easy to do in your local
tree, which would at least allow you to test. You could also change
your host time to 2038, but that would break things for your host.

Alistair

>
> >
> > Alistair
> >
> > >
> > >
> > > Thanks in advance for your help and reply.
> > >
> > >
> > > Links:
> > > [1] - https://github.com/lmajewski/meta-y2038/
> > > [2] -
> > > https://elixir.bootlin.com/linux/latest/source/arch/arm/tools/syscall.tbl#L419
> > >
> > > [3]:
> > > Example program:
> > > cat <<- EOF >> clock_settime_test.c
> > > #include <stdio.h>
> > > #include <time.h>
> > >
> > > int main (int argc, char **argv)
> > > {
> > >         struct timespec tv;
> > >         int ret;
> > >
> > >         tv.tv_sec = 0x7FFFFFFF;
> > >         tv.tv_sec += 61;
> > >         tv.tv_nsec = 0;
> > >
> > >         printf("clock_settime test program: ");
> > >         ret = clock_settime(CLOCK_REALTIME, &tv);
> > >         if (!ret)
> > >                 printf("OK\n");
> > >         else
> > >                 perror("ERR\n");
> > >
> > >         return 0;
> > > }
> > > EOF
> > >
> > > Build the test program:
> > > gcc -Wall -ggdb -D_TIME_BITS=64 -D_FILE_OFFSET_BITS=64
> > > -I/opt/include -I/opt/usr/include -L/opt/usr/lib \
> > > -Wl,-rpath=/opt/lib -Wl,--dynamic-linker=/opt/lib/ld-linux.so.2
> > > clock_settime_test.c -o cst -static
> > >
> > >
> > >
> > > Best regards,
> > >
> > > Lukasz Majewski
> > >
> > > --
> > >
> > > DENX Software Engineering GmbH,      Managing Director: Wolfgang
> > > Denk HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell,
> > > Germany Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email:
> > > lukma@denx.de
>
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

