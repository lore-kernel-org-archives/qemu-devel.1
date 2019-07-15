Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E88F6C7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 11:17:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B195E20665
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 11:17:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iXRmHb3M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B195E20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmyyz-0007gb-24
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 07:17:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47712)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hmyym-0007I9-DT
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 07:17:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hmyyk-0003Rq-Re
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 07:17:12 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:42203)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hmyyk-0003RQ-Kz
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 07:17:10 -0400
Received: by mail-ot1-x343.google.com with SMTP id l15so16522014otn.9
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2019 04:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UXa3Ixp0lyTib79hLb+eS/E3mz0+aAEKJsrTvZWNNo4=;
 b=iXRmHb3MwCS2ZFWcAnJWvTPi49kT68Ifh3vni1395E+tAwMyrCqiuRKEBwIgTC+9cn
 BXhSdlrPKPOrbzA2x6L83SU7kLNbIO6QiM745iijYlz6MvWk+0pyCRkePplcXotDrhwM
 17f5lNLmkZO6hAsPgQL2w7gi0fqkUlUotPltn8j9fHNGwRzIT4TaM+eqIhBNjc93mnfQ
 1BjxmY8lQgSgQUJq41x4QQg8GBgC2c7uWGWXpTQ8lq0+RDx7DuSzxao9MUcxTn7El8ku
 Ifhv0QjTq8Z+Sd/NPpnHNJdHd4LbgK4sRBqVeMRbEFsHPuUi8UV1HSnyRvddw5+ovris
 rhdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UXa3Ixp0lyTib79hLb+eS/E3mz0+aAEKJsrTvZWNNo4=;
 b=CX3HoRC2mB0vw0yeVwXuVrtwBtUebkwNerb2qjd5dmFOXWQxiqm0e2RCUQyrZxT8L3
 BMRh/Z/fcb0sxwTaJyrNaQk6GQQcz2LXwirxRWRHsnoWrIlvlxq1Xyxz0N5hbC3iS3ap
 PmiGU0T8Nn9IDasJzZskTs2ZP4fubAfdMA6pSR9FgbnYxN4IqPBy+HP2RumKtO6zR14P
 McTHvr0M2mYw7Y01xzq9hi0oesU5cK38w8LQ6PVPsR0aMkgR5eRweRIMhZ9cgQhO8+ux
 nRDQr3JllWlooa20RSP9QPxMgf7HZ3rxUWYDRaXtClCbXf0IkLzpffyWXiV1UjXab/4c
 2srg==
X-Gm-Message-State: APjAAAVNrs6xdi6U8qGDTR/Rc5H1ih3R2IxWHfdaP+AJWQiBSHaoeA2r
 mrpEVoX5JA6RZjQUM4cQY8TKgMJd2yfU2LmnL1C/gw==
X-Google-Smtp-Source: APXvYqzF+cB18RQlYSXomt3XydDlXqWrsBDR6vQi7C2WcgOZsPLJ4fs1ZOWBxk9XwY5TTyVke0mjPmby1iFNUOv3W6Q=
X-Received: by 2002:a9d:6a0f:: with SMTP id g15mr14607701otn.135.1563189429057; 
 Mon, 15 Jul 2019 04:17:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190712143207.4214-1-quintela@redhat.com>
 <CAFEAcA-ydNS072OH7CyGNq2+sESgonW-8QSJdNYJq6zW-rYjUQ@mail.gmail.com>
In-Reply-To: <CAFEAcA-ydNS072OH7CyGNq2+sESgonW-8QSJdNYJq6zW-rYjUQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jul 2019 12:16:57 +0100
Message-ID: <CAFEAcA9ncjtGdc8CZOJBDBRtzEU8oL7YicVg5PtyiiO2O4z51w@mail.gmail.com>
To: Juan Quintela <quintela@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PULL 00/19] Migration patches
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 kvm-devel <kvm@vger.kernel.org>, QEMU Developers <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 12 Jul 2019 at 17:33, Peter Maydell <peter.maydell@linaro.org> wrote:
> Still fails on aarch32 host, I'm afraid:
>
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> QTEST_QEMU_BINARY=aarch64-softmmu/qemu-system-aarch64
> QTEST_QEMU_IMG=qemu-img tests/migration-test -m=quick -k --tap <
> /dev/null | ./scripts/tap-driver.pl --test-name="migration-test"
> PASS 1 migration-test /aarch64/migration/deprecated
> PASS 2 migration-test /aarch64/migration/bad_dest
> PASS 3 migration-test /aarch64/migration/fd_proto
> PASS 4 migration-test /aarch64/migration/postcopy/unix
> PASS 5 migration-test /aarch64/migration/postcopy/recovery
> PASS 6 migration-test /aarch64/migration/precopy/unix
> PASS 7 migration-test /aarch64/migration/precopy/tcp
> PASS 8 migration-test /aarch64/migration/xbzrle/unix
> malloc(): memory corruption
> Broken pipe
> qemu-system-aarch64: load of migration failed: Invalid argument
> /home/peter.maydell/qemu/tests/libqtest.c:137: kill_qemu() tried to
> terminate QEMU process but encountered exit status 1
> Aborted
> ERROR - too few tests run (expected 9, got 8)
> /home/peter.maydell/qemu/tests/Makefile.include:899: recipe for target
> 'check-qtest-aarch64' failed

A run with valgrind:

(armhf)pmaydell@mustang-maydell:~/qemu/build/all-a32$
QTEST_QEMU_BINARY='valgrind aarch64-softmmu/qemu-system-aarch64'
tests/migration-test -v -p '/aarch64/migration/multifd/tcp'
/aarch64/migration/multifd/tcp: ==4034== Memcheck, a memory error detector
==4034== Copyright (C) 2002-2017, and GNU GPL'd, by Julian Seward et al.
==4034== Using Valgrind-3.13.0 and LibVEX; rerun with -h for copyright info
==4034== Command: aarch64-softmmu/qemu-system-aarch64 -qtest
unix:/tmp/qtest-4033.sock -qtest-log /dev/null -chardev
socket,path=/tmp/qtest-4033.qmp,id=char0 -mon
chardev=char0,mode=control -machine accel=qtest -display none -machine
virt,accel=kvm:tcg,gic-version=max -name vmsource,debug-threads=on
-cpu max -m 150M -serial file:/tmp/migration-test-mSLr4A/src_serial
-kernel /tmp/migration-test-mSLr4A/bootsect
==4034==
==4040== Memcheck, a memory error detector
==4040== Copyright (C) 2002-2017, and GNU GPL'd, by Julian Seward et al.
==4040== Using Valgrind-3.13.0 and LibVEX; rerun with -h for copyright info
==4040== Command: aarch64-softmmu/qemu-system-aarch64 -qtest
unix:/tmp/qtest-4033.sock -qtest-log /dev/null -chardev
socket,path=/tmp/qtest-4033.qmp,id=char0 -mon
chardev=char0,mode=control -machine accel=qtest -display none -machine
virt,accel=kvm:tcg,gic-version=max -name vmdest,debug-threads=on -cpu
max -m 150M -serial file:/tmp/migration-test-mSLr4A/dest_serial
-kernel /tmp/migration-test-mSLr4A/bootsect -incoming tcp:127.0.0.1:0
==4040==
==4034== Thread 5 multifdsend_0:
==4034== Syscall param sendmsg(msg.msg_iov[0]) points to uninitialised byte(s)
==4034==    at 0x5299F06: __libc_do_syscall (libc-do-syscall.S:47)
==4034==    by 0x5298FCB: sendmsg (sendmsg.c:28)
==4034==    by 0x60135D: qio_channel_socket_writev (channel-socket.c:544)
==4034==    by 0x5FF995: qio_channel_writev (channel.c:207)
==4034==    by 0x5FF995: qio_channel_writev_all (channel.c:171)
==4034==    by 0x5FFA0F: qio_channel_write_all (channel.c:257)
==4034==    by 0x26BA73: multifd_send_initial_packet (ram.c:711)
==4034==    by 0x26BA73: multifd_send_thread (ram.c:1085)
==4034==    by 0x63C0B1: qemu_thread_start (qemu-thread-posix.c:502)
==4034==    by 0x5290613: start_thread (pthread_create.c:463)
==4034==    by 0x53487FB: ??? (clone.S:73)
==4034==  Address 0x2320048d is on thread 5's stack
==4034==  in frame #5, created by multifd_send_thread (ram.c:1077)
==4034==
==4034== Thread 6 multifdsend_1:
==4034== Invalid write of size 4
==4034==    at 0x26BB7C: multifd_send_fill_packet (ram.c:806)
==4034==    by 0x26BB7C: multifd_send_thread (ram.c:1101)
==4034==    by 0x63C0B1: qemu_thread_start (qemu-thread-posix.c:502)
==4034==    by 0x5290613: start_thread (pthread_create.c:463)
==4034==    by 0x53487FB: ??? (clone.S:73)
==4034==  Address 0x224ed668 is 0 bytes after a block of size 832 alloc'd
==4034==    at 0x4841BC4: calloc (vg_replace_malloc.c:711)
==4034==    by 0x5018269: g_malloc0 (in
/usr/lib/arm-linux-gnueabihf/libglib-2.0.so.0.5600.4)
==4034==
==4034== Invalid write of size 4
==4034==    at 0x26BB82: multifd_send_fill_packet (ram.c:806)
==4034==    by 0x26BB82: multifd_send_thread (ram.c:1101)
==4034==    by 0x63C0B1: qemu_thread_start (qemu-thread-posix.c:502)
==4034==    by 0x5290613: start_thread (pthread_create.c:463)
==4034==    by 0x53487FB: ??? (clone.S:73)
==4034==  Address 0x224ed66c is 4 bytes after a block of size 832 alloc'd
==4034==    at 0x4841BC4: calloc (vg_replace_malloc.c:711)
==4034==    by 0x5018269: g_malloc0 (in
/usr/lib/arm-linux-gnueabihf/libglib-2.0.so.0.5600.4)
==4034==
==4034== Invalid read of size 4
==4034==    at 0x5FF1DA: qio_channel_writev_full (channel.c:86)
==4034==    by 0x5FF995: qio_channel_writev (channel.c:207)
==4034==    by 0x5FF995: qio_channel_writev_all (channel.c:171)
==4034==    by 0x5FFA0F: qio_channel_write_all (channel.c:257)
==4034==    by 0x26BBD9: multifd_send_thread (ram.c:1111)
==4034==    by 0x63C0B1: qemu_thread_start (qemu-thread-posix.c:502)
==4034==    by 0x5290613: start_thread (pthread_create.c:463)
==4034==    by 0x53487FB: ??? (clone.S:73)
==4034==  Address 0x30 is not stack'd, malloc'd or (recently) free'd
==4034==
==4034==
==4034== Process terminating with default action of signal 11 (SIGSEGV)
==4034==  Access not within mapped region at address 0x30
==4034==    at 0x5FF1DA: qio_channel_writev_full (channel.c:86)
==4034==    by 0x5FF995: qio_channel_writev (channel.c:207)
==4034==    by 0x5FF995: qio_channel_writev_all (channel.c:171)
==4034==    by 0x5FFA0F: qio_channel_write_all (channel.c:257)
==4034==    by 0x26BBD9: multifd_send_thread (ram.c:1111)
==4034==    by 0x63C0B1: qemu_thread_start (qemu-thread-posix.c:502)
==4034==    by 0x5290613: start_thread (pthread_create.c:463)
==4034==    by 0x53487FB: ??? (clone.S:73)
==4034==  If you believe this happened as a result of a stack
==4034==  overflow in your program's main thread (unlikely but
==4034==  possible), you can try to increase the size of the
==4034==  main thread stack using the --main-stacksize= flag.
==4034==  The main thread stack size used in this run was 8388608.
==4034==
==4034== HEAP SUMMARY:
==4034==     in use at exit: 5,994,911 bytes in 23,588 blocks
==4034==   total heap usage: 87,487 allocs, 63,899 frees, 17,732,188
bytes allocated
==4034==
==4034== LEAK SUMMARY:
==4034==    definitely lost: 56 bytes in 1 blocks
==4034==    indirectly lost: 64 bytes in 2 blocks
==4034==      possibly lost: 1,620 bytes in 26 blocks
==4034==    still reachable: 5,993,171 bytes in 23,559 blocks
==4034==         suppressed: 0 bytes in 0 blocks
==4034== Rerun with --leak-check=full to see details of leaked memory
==4034==
==4034== For counts of detected and suppressed errors, rerun with: -v
==4034== Use --track-origins=yes to see where uninitialised values come from
==4034== ERROR SUMMARY: 66 errors from 4 contexts (suppressed: 6 from 3)
Broken pipe
qemu-system-aarch64: load of migration failed: Input/output error
==4040==
==4040== HEAP SUMMARY:
==4040==     in use at exit: 4,893,269 bytes in 19,702 blocks
==4040==   total heap usage: 86,196 allocs, 66,494 frees, 17,438,183
bytes allocated
==4040==
==4040== LEAK SUMMARY:
==4040==    definitely lost: 0 bytes in 0 blocks
==4040==    indirectly lost: 0 bytes in 0 blocks
==4040==      possibly lost: 1,160 bytes in 5 blocks
==4040==    still reachable: 4,892,109 bytes in 19,697 blocks
==4040==         suppressed: 0 bytes in 0 blocks
==4040== Rerun with --leak-check=full to see details of leaked memory
==4040==
==4040== For counts of detected and suppressed errors, rerun with: -v
==4040== ERROR SUMMARY: 0 errors from 0 contexts (suppressed: 6 from 3)
/home/peter.maydell/qemu/tests/libqtest.c:137: kill_qemu() tried to
terminate QEMU process but encountered exit status 1
Aborted

thanks
-- PMM

