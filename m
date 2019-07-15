Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AAD1C7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 14:05:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E63DC2086C
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 14:05:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E63DC2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hn1bG-0003Ev-Gn
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 10:05:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56784)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berrange@redhat.com>) id 1hn1b4-0002ql-ED
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 10:04:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1hn1az-0000HX-Jt
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 10:04:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50534)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hn1az-0000HC-BE
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 10:04:49 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3FBD83082D6C;
 Mon, 15 Jul 2019 14:04:48 +0000 (UTC)
Received: from redhat.com (ovpn-112-60.ams2.redhat.com [10.36.112.60])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D2E44608CD;
 Mon, 15 Jul 2019 14:04:44 +0000 (UTC)
Date: Mon, 15 Jul 2019 15:04:41 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20190715140441.GJ30298@redhat.com>
References: <20190712143207.4214-1-quintela@redhat.com>
 <CAFEAcA-ydNS072OH7CyGNq2+sESgonW-8QSJdNYJq6zW-rYjUQ@mail.gmail.com>
 <CAFEAcA9ncjtGdc8CZOJBDBRtzEU8oL7YicVg5PtyiiO2O4z51w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA9ncjtGdc8CZOJBDBRtzEU8oL7YicVg5PtyiiO2O4z51w@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Mon, 15 Jul 2019 14:04:48 +0000 (UTC)
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 kvm-devel <kvm@vger.kernel.org>, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 15, 2019 at 12:16:57PM +0100, Peter Maydell wrote:
> On Fri, 12 Jul 2019 at 17:33, Peter Maydell <peter.maydell@linaro.org> wrote:
> > Still fails on aarch32 host, I'm afraid:
> >
> > MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> > QTEST_QEMU_BINARY=aarch64-softmmu/qemu-system-aarch64
> > QTEST_QEMU_IMG=qemu-img tests/migration-test -m=quick -k --tap <
> > /dev/null | ./scripts/tap-driver.pl --test-name="migration-test"
> > PASS 1 migration-test /aarch64/migration/deprecated
> > PASS 2 migration-test /aarch64/migration/bad_dest
> > PASS 3 migration-test /aarch64/migration/fd_proto
> > PASS 4 migration-test /aarch64/migration/postcopy/unix
> > PASS 5 migration-test /aarch64/migration/postcopy/recovery
> > PASS 6 migration-test /aarch64/migration/precopy/unix
> > PASS 7 migration-test /aarch64/migration/precopy/tcp
> > PASS 8 migration-test /aarch64/migration/xbzrle/unix
> > malloc(): memory corruption
> > Broken pipe
> > qemu-system-aarch64: load of migration failed: Invalid argument
> > /home/peter.maydell/qemu/tests/libqtest.c:137: kill_qemu() tried to
> > terminate QEMU process but encountered exit status 1
> > Aborted
> > ERROR - too few tests run (expected 9, got 8)
> > /home/peter.maydell/qemu/tests/Makefile.include:899: recipe for target
> > 'check-qtest-aarch64' failed
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

This is a simple missing initialization

multifd_send_initial_packet has a local variable:

    MultiFDInit_t msg;

the code initializes 4 fields, but does *not* initialize the 2
padding fields, so we're writing random data. Harmless as the
receiving end will ignore padding too, but we should fill with
zeros really. so

    MultiFDInit_t msg = {0};

should fix it.

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

multifd_send_fill_packet is getting the oob write in:

    for (i = 0; i < p->pages->used; i++) {
        packet->offset[i] = cpu_to_be64(p->pages->offset[i]);
    }

offset is a variable length struct field at the end of MultiFDPacket_t:

  typedef struct {
     ...snip...
    char ramblock[256];
    uint64_t offset[];
  } __attribute__((packed)) MultiFDPacket_t;

but the packet data is allocated back in multifd_save_setup using:

        p->packet_len = sizeof(MultiFDPacket_t)
                      + sizeof(ram_addr_t) * page_count;
        p->packet = g_malloc0(p->packet_len);


Notice the field in the struct is "uint64_t" but the length we're
allocating is "ram_addr_t".

Since this is a 32-bit build, I'm guessing ram_addr_t is a 32-bit
integer and thus we're under-allocating the variable length offset
field by half

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

