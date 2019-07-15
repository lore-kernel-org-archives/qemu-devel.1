Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B299C7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 13:44:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 437222067C
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 13:44:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 437222067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hn1Hm-0001je-Hh
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 09:44:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52363)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <quintela@redhat.com>) id 1hn1Hb-0001LQ-UJ
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 09:44:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1hn1Ha-0008Cu-1H
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 09:44:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42306)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1hn1HZ-0008CC-6G
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 09:44:45 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2A75FC058CBA;
 Mon, 15 Jul 2019 13:44:43 +0000 (UTC)
Received: from redhat.com (ovpn-117-250.ams2.redhat.com [10.36.117.250])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 78D2060C64;
 Mon, 15 Jul 2019 13:44:42 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
In-Reply-To: <CAFEAcA9ncjtGdc8CZOJBDBRtzEU8oL7YicVg5PtyiiO2O4z51w@mail.gmail.com>
 (Peter Maydell's message of "Mon, 15 Jul 2019 12:16:57 +0100")
References: <20190712143207.4214-1-quintela@redhat.com>
 <CAFEAcA-ydNS072OH7CyGNq2+sESgonW-8QSJdNYJq6zW-rYjUQ@mail.gmail.com>
 <CAFEAcA9ncjtGdc8CZOJBDBRtzEU8oL7YicVg5PtyiiO2O4z51w@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
Date: Mon, 15 Jul 2019 15:44:39 +0200
Message-ID: <87zhlf76pk.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Mon, 15 Jul 2019 13:44:43 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Reply-To: quintela@redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 kvm-devel <kvm@vger.kernel.org>, QEMU Developers <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> wrote:
> On Fri, 12 Jul 2019 at 17:33, Peter Maydell <peter.maydell@linaro.org> wrote:
>> Still fails on aarch32 host, I'm afraid:

Hi

dropping the multifd test patch from now.  For "some" reason, having a
packed struct and 32bits is getting ugly, not sure yet _why_.

Resending the pull request.


>>
>> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
>> QTEST_QEMU_BINARY=aarch64-softmmu/qemu-system-aarch64
>> QTEST_QEMU_IMG=qemu-img tests/migration-test -m=quick -k --tap <
>> /dev/null | ./scripts/tap-driver.pl --test-name="migration-test"
>> PASS 1 migration-test /aarch64/migration/deprecated
>> PASS 2 migration-test /aarch64/migration/bad_dest
>> PASS 3 migration-test /aarch64/migration/fd_proto
>> PASS 4 migration-test /aarch64/migration/postcopy/unix
>> PASS 5 migration-test /aarch64/migration/postcopy/recovery
>> PASS 6 migration-test /aarch64/migration/precopy/unix
>> PASS 7 migration-test /aarch64/migration/precopy/tcp
>> PASS 8 migration-test /aarch64/migration/xbzrle/unix
>> malloc(): memory corruption
>> Broken pipe
>> qemu-system-aarch64: load of migration failed: Invalid argument
>> /home/peter.maydell/qemu/tests/libqtest.c:137: kill_qemu() tried to
>> terminate QEMU process but encountered exit status 1
>> Aborted
>> ERROR - too few tests run (expected 9, got 8)
>> /home/peter.maydell/qemu/tests/Makefile.include:899: recipe for target
>> 'check-qtest-aarch64' failed
>
> A run with valgrind:
>
> (armhf)pmaydell@mustang-maydell:~/qemu/build/all-a32$
> QTEST_QEMU_BINARY='valgrind aarch64-softmmu/qemu-system-aarch64'
> tests/migration-test -v -p '/aarch64/migration/multifd/tcp'
> /aarch64/migration/multifd/tcp: ==4034== Memcheck, a memory error detector
> ==4034== Copyright (C) 2002-2017, and GNU GPL'd, by Julian Seward et al.
> ==4034== Using Valgrind-3.13.0 and LibVEX; rerun with -h for copyright info
> ==4034== Command: aarch64-softmmu/qemu-system-aarch64 -qtest
> unix:/tmp/qtest-4033.sock -qtest-log /dev/null -chardev
> socket,path=/tmp/qtest-4033.qmp,id=char0 -mon
> chardev=char0,mode=control -machine accel=qtest -display none -machine
> virt,accel=kvm:tcg,gic-version=max -name vmsource,debug-threads=on
> -cpu max -m 150M -serial file:/tmp/migration-test-mSLr4A/src_serial
> -kernel /tmp/migration-test-mSLr4A/bootsect
> ==4034==
> ==4040== Memcheck, a memory error detector
> ==4040== Copyright (C) 2002-2017, and GNU GPL'd, by Julian Seward et al.
> ==4040== Using Valgrind-3.13.0 and LibVEX; rerun with -h for copyright info
> ==4040== Command: aarch64-softmmu/qemu-system-aarch64 -qtest
> unix:/tmp/qtest-4033.sock -qtest-log /dev/null -chardev
> socket,path=/tmp/qtest-4033.qmp,id=char0 -mon
> chardev=char0,mode=control -machine accel=qtest -display none -machine
> virt,accel=kvm:tcg,gic-version=max -name vmdest,debug-threads=on -cpu
> max -m 150M -serial file:/tmp/migration-test-mSLr4A/dest_serial
> -kernel /tmp/migration-test-mSLr4A/bootsect -incoming tcp:127.0.0.1:0
> ==4040==
> ==4034== Thread 5 multifdsend_0:
> ==4034== Syscall param sendmsg(msg.msg_iov[0]) points to uninitialised byte(s)
> ==4034==    at 0x5299F06: __libc_do_syscall (libc-do-syscall.S:47)
> ==4034==    by 0x5298FCB: sendmsg (sendmsg.c:28)
> ==4034==    by 0x60135D: qio_channel_socket_writev (channel-socket.c:544)
> ==4034==    by 0x5FF995: qio_channel_writev (channel.c:207)
> ==4034==    by 0x5FF995: qio_channel_writev_all (channel.c:171)
> ==4034==    by 0x5FFA0F: qio_channel_write_all (channel.c:257)
> ==4034==    by 0x26BA73: multifd_send_initial_packet (ram.c:711)
> ==4034==    by 0x26BA73: multifd_send_thread (ram.c:1085)
> ==4034==    by 0x63C0B1: qemu_thread_start (qemu-thread-posix.c:502)
> ==4034==    by 0x5290613: start_thread (pthread_create.c:463)
> ==4034==    by 0x53487FB: ??? (clone.S:73)
> ==4034==  Address 0x2320048d is on thread 5's stack
> ==4034==  in frame #5, created by multifd_send_thread (ram.c:1077)
> ==4034==
> ==4034== Thread 6 multifdsend_1:
> ==4034== Invalid write of size 4
> ==4034==    at 0x26BB7C: multifd_send_fill_packet (ram.c:806)
> ==4034==    by 0x26BB7C: multifd_send_thread (ram.c:1101)
> ==4034==    by 0x63C0B1: qemu_thread_start (qemu-thread-posix.c:502)
> ==4034==    by 0x5290613: start_thread (pthread_create.c:463)
> ==4034==    by 0x53487FB: ??? (clone.S:73)
> ==4034==  Address 0x224ed668 is 0 bytes after a block of size 832 alloc'd
> ==4034==    at 0x4841BC4: calloc (vg_replace_malloc.c:711)
> ==4034==    by 0x5018269: g_malloc0 (in
> /usr/lib/arm-linux-gnueabihf/libglib-2.0.so.0.5600.4)
> ==4034==
> ==4034== Invalid write of size 4
> ==4034==    at 0x26BB82: multifd_send_fill_packet (ram.c:806)
> ==4034==    by 0x26BB82: multifd_send_thread (ram.c:1101)
> ==4034==    by 0x63C0B1: qemu_thread_start (qemu-thread-posix.c:502)
> ==4034==    by 0x5290613: start_thread (pthread_create.c:463)
> ==4034==    by 0x53487FB: ??? (clone.S:73)
> ==4034==  Address 0x224ed66c is 4 bytes after a block of size 832 alloc'd
> ==4034==    at 0x4841BC4: calloc (vg_replace_malloc.c:711)
> ==4034==    by 0x5018269: g_malloc0 (in
> /usr/lib/arm-linux-gnueabihf/libglib-2.0.so.0.5600.4)
> ==4034==
> ==4034== Invalid read of size 4
> ==4034==    at 0x5FF1DA: qio_channel_writev_full (channel.c:86)
> ==4034==    by 0x5FF995: qio_channel_writev (channel.c:207)
> ==4034==    by 0x5FF995: qio_channel_writev_all (channel.c:171)
> ==4034==    by 0x5FFA0F: qio_channel_write_all (channel.c:257)
> ==4034==    by 0x26BBD9: multifd_send_thread (ram.c:1111)
> ==4034==    by 0x63C0B1: qemu_thread_start (qemu-thread-posix.c:502)
> ==4034==    by 0x5290613: start_thread (pthread_create.c:463)
> ==4034==    by 0x53487FB: ??? (clone.S:73)
> ==4034==  Address 0x30 is not stack'd, malloc'd or (recently) free'd
> ==4034==
> ==4034==
> ==4034== Process terminating with default action of signal 11 (SIGSEGV)
> ==4034==  Access not within mapped region at address 0x30
> ==4034==    at 0x5FF1DA: qio_channel_writev_full (channel.c:86)
> ==4034==    by 0x5FF995: qio_channel_writev (channel.c:207)
> ==4034==    by 0x5FF995: qio_channel_writev_all (channel.c:171)
> ==4034==    by 0x5FFA0F: qio_channel_write_all (channel.c:257)
> ==4034==    by 0x26BBD9: multifd_send_thread (ram.c:1111)
> ==4034==    by 0x63C0B1: qemu_thread_start (qemu-thread-posix.c:502)
> ==4034==    by 0x5290613: start_thread (pthread_create.c:463)
> ==4034==    by 0x53487FB: ??? (clone.S:73)
> ==4034==  If you believe this happened as a result of a stack
> ==4034==  overflow in your program's main thread (unlikely but
> ==4034==  possible), you can try to increase the size of the
> ==4034==  main thread stack using the --main-stacksize= flag.
> ==4034==  The main thread stack size used in this run was 8388608.
> ==4034==
> ==4034== HEAP SUMMARY:
> ==4034==     in use at exit: 5,994,911 bytes in 23,588 blocks
> ==4034==   total heap usage: 87,487 allocs, 63,899 frees, 17,732,188
> bytes allocated
> ==4034==
> ==4034== LEAK SUMMARY:
> ==4034==    definitely lost: 56 bytes in 1 blocks
> ==4034==    indirectly lost: 64 bytes in 2 blocks
> ==4034==      possibly lost: 1,620 bytes in 26 blocks
> ==4034==    still reachable: 5,993,171 bytes in 23,559 blocks
> ==4034==         suppressed: 0 bytes in 0 blocks
> ==4034== Rerun with --leak-check=full to see details of leaked memory
> ==4034==
> ==4034== For counts of detected and suppressed errors, rerun with: -v
> ==4034== Use --track-origins=yes to see where uninitialised values come from
> ==4034== ERROR SUMMARY: 66 errors from 4 contexts (suppressed: 6 from 3)
> Broken pipe
> qemu-system-aarch64: load of migration failed: Input/output error
> ==4040==
> ==4040== HEAP SUMMARY:
> ==4040==     in use at exit: 4,893,269 bytes in 19,702 blocks
> ==4040==   total heap usage: 86,196 allocs, 66,494 frees, 17,438,183
> bytes allocated
> ==4040==
> ==4040== LEAK SUMMARY:
> ==4040==    definitely lost: 0 bytes in 0 blocks
> ==4040==    indirectly lost: 0 bytes in 0 blocks
> ==4040==      possibly lost: 1,160 bytes in 5 blocks
> ==4040==    still reachable: 4,892,109 bytes in 19,697 blocks
> ==4040==         suppressed: 0 bytes in 0 blocks
> ==4040== Rerun with --leak-check=full to see details of leaked memory
> ==4040==
> ==4040== For counts of detected and suppressed errors, rerun with: -v
> ==4040== ERROR SUMMARY: 0 errors from 0 contexts (suppressed: 6 from 3)
> /home/peter.maydell/qemu/tests/libqtest.c:137: kill_qemu() tried to
> terminate QEMU process but encountered exit status 1
> Aborted
>
> thanks
> -- PMM

