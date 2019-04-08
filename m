Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD615C10F13
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 11:35:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77BBB2070D
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 11:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="LAov08h+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77BBB2070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51437 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDSYJ-0007fF-I5
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 07:35:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hDSXN-0007NR-8t
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 07:34:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hDSXL-0007qk-RJ
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 07:34:05 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:47972)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hDSXL-0007p4-3R
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 07:34:03 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net
	[IPv6:2a02:6b8:0:1619::119])
	by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id B2A542E148B;
	Mon,  8 Apr 2019 14:33:59 +0300 (MSK)
Received: from smtpcorp1o.mail.yandex.net (smtpcorp1o.mail.yandex.net
	[2a02:6b8:0:1a2d::30])
	by mxbackcorp2j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id
	ljQd0Ug6Qu-XwBeQVVs; Mon, 08 Apr 2019 14:33:59 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; 
	t=1554723239; bh=wO94228a5KtS4wP7sI7/0xYP02KNAr29a9dftGRsl7c=;
	h=Message-Id:Date:Subject:To:From:Cc;
	b=LAov08h+AFn15Osgbqd14wiskCDjrGmg3PehEVUmCE6ijdabuxiJL38W2aKaSJ2xW
	UySLoiX3BJxivTYD+78xqon6GkD7x+smkjFSiuQ2Lp1DqAulaSAnzB4WhobHKk6xbU
	gZU4DtMnenqxUULI1OLByRKZmlHMmEJE2OEeS3ao=
Authentication-Results: mxbackcorp2j.mail.yandex.net;
	dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net
	[2a02:6b8:0:40c:451f:a52:4dbf:6ea5])
	by smtpcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id
	Xl8g9oG564-XwLaBAHL; Mon, 08 Apr 2019 14:33:58 +0300
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(Client certificate not present)
From: Yury Kotov <yury-kotov@yandex-team.ru>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	Juan Quintela <quintela@redhat.com>
Date: Mon,  8 Apr 2019 14:33:43 +0300
Message-Id: <20190408113343.2370-1-yury-kotov@yandex-team.ru>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 77.88.29.217
Subject: [Qemu-devel] [PATCH] migration: Fix use-after-free during process
 exit
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org, Evgeny Yakovlev <wrfsh@yandex-team.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190408113343.BATbYT-ja1v7p2x-buWBIpaM4-o1CXLBYINQd0jFTE0@z>

It fixes heap-use-after-free which was found by clang's ASAN.

Control flow of this use-after-free:
main_thread:
    * Got SIGTERM and completes main loop
    * Calls migration_shutdown
      - migrate_fd_cancel (so, migration_thread begins to complete)
      - object_unref(OBJECT(current_migration));

migration_thread:
    * migration_iteration_finish -> schedule cleanup bh
    * object_unref(OBJECT(s)); (Now, current_migration is freed)
    * exits

main_thread:
    * Calls vm_shutdown -> drain bdrvs -> main loop
      -> cleanup_bh -> use after free

If you want to reproduce, these couple of sleeps will help:
vl.c:4613:
     migration_shutdown();
+    sleep(2);
migration.c:3269:
+    sleep(1);
     trace_migration_thread_after_loop();
     migration_iteration_finish(s);

Original output:
qemu-system-x86_64: terminating on signal 15 from pid 31980 (<unknown pro=
cess>)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D31958=3D=3DERROR: AddressSanitizer: heap-use-after-free on address =
0x61900001d210
  at pc 0x555558a535ca bp 0x7fffffffb190 sp 0x7fffffffb188
READ of size 8 at 0x61900001d210 thread T0 (qemu-vm-0)
    #0 0x555558a535c9 in migrate_fd_cleanup migration/migration.c:1502:23
    #1 0x5555594fde0a in aio_bh_call util/async.c:90:5
    #2 0x5555594fe522 in aio_bh_poll util/async.c:118:13
    #3 0x555559524783 in aio_poll util/aio-posix.c:725:17
    #4 0x555559504fb3 in aio_wait_bh_oneshot util/aio-wait.c:71:5
    #5 0x5555573bddf6 in virtio_blk_data_plane_stop
      hw/block/dataplane/virtio-blk.c:282:5
    #6 0x5555589d5c09 in virtio_bus_stop_ioeventfd hw/virtio/virtio-bus.c=
:246:9
    #7 0x5555589e9917 in virtio_pci_stop_ioeventfd hw/virtio/virtio-pci.c=
:287:5
    #8 0x5555589e22bf in virtio_pci_vmstate_change hw/virtio/virtio-pci.c=
:1072:9
    #9 0x555557628931 in virtio_vmstate_change hw/virtio/virtio.c:2257:9
    #10 0x555557c36713 in vm_state_notify vl.c:1605:9
    #11 0x55555716ef53 in do_vm_stop cpus.c:1074:9
    #12 0x55555716eeff in vm_shutdown cpus.c:1092:12
    #13 0x555557c4283e in main vl.c:4617:5
    #14 0x7fffdfdb482f in __libc_start_main
      (/lib/x86_64-linux-gnu/libc.so.6+0x2082f)
    #15 0x555556ecb118 in _start (x86_64-softmmu/qemu-system-x86_64+0x197=
7118)

0x61900001d210 is located 144 bytes inside of 952-byte region
  [0x61900001d180,0x61900001d538)
freed by thread T6 (live_migration) here:
    #0 0x555556f76782 in __interceptor_free
      /tmp/final/llvm.src/projects/compiler-rt/lib/asan/asan_malloc_linux=
.cc:124:3
    #1 0x555558d5fa94 in object_finalize qom/object.c:618:9
    #2 0x555558d57651 in object_unref qom/object.c:1068:9
    #3 0x555558a55588 in migration_thread migration/migration.c:3272:5
    #4 0x5555595393f2 in qemu_thread_start util/qemu-thread-posix.c:502:9
    #5 0x7fffe057f6b9 in start_thread (/lib/x86_64-linux-gnu/libpthread.s=
o.0+0x76b9)

previously allocated by thread T0 (qemu-vm-0) here:
    #0 0x555556f76b03 in __interceptor_malloc
      /tmp/final/llvm.src/projects/compiler-rt/lib/asan/asan_malloc_linux=
.cc:146:3
    #1 0x7ffff6ee37b8 in g_malloc (/lib/x86_64-linux-gnu/libglib-2.0.so.0=
+0x4f7b8)
    #2 0x555558d58031 in object_new qom/object.c:640:12
    #3 0x555558a31f21 in migration_object_init migration/migration.c:139:=
25
    #4 0x555557c41398 in main vl.c:4320:5
    #5 0x7fffdfdb482f in __libc_start_main (/lib/x86_64-linux-gnu/libc.so=
.6+0x2082f)

Thread T6 (live_migration) created by T0 (qemu-vm-0) here:
    #0 0x555556f5f0dd in pthread_create
      /tmp/final/llvm.src/projects/compiler-rt/lib/asan/asan_interceptors=
.cc:210:3
    #1 0x555559538cf9 in qemu_thread_create util/qemu-thread-posix.c:539:=
11
    #2 0x555558a53304 in migrate_fd_connect migration/migration.c:3332:5
    #3 0x555558a72bd8 in migration_channel_connect migration/channel.c:92=
:5
    #4 0x555558a6ef87 in exec_start_outgoing_migration migration/exec.c:4=
2:5
    #5 0x555558a4f3c2 in qmp_migrate migration/migration.c:1922:9
    #6 0x555558bb4f6a in qmp_marshal_migrate qapi/qapi-commands-migration=
.c:607:5
    #7 0x555559363738 in do_qmp_dispatch qapi/qmp-dispatch.c:131:5
    #8 0x555559362a15 in qmp_dispatch qapi/qmp-dispatch.c:174:11
    #9 0x5555571bac15 in monitor_qmp_dispatch monitor.c:4124:11
    #10 0x55555719a22d in monitor_qmp_bh_dispatcher monitor.c:4207:9
    #11 0x5555594fde0a in aio_bh_call util/async.c:90:5
    #12 0x5555594fe522 in aio_bh_poll util/async.c:118:13
    #13 0x5555595201e0 in aio_dispatch util/aio-posix.c:460:5
    #14 0x555559503553 in aio_ctx_dispatch util/async.c:261:5
    #15 0x7ffff6ede196 in g_main_context_dispatch
      (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x4a196)

SUMMARY: AddressSanitizer: heap-use-after-free migration/migration.c:1502=
:23
  in migrate_fd_cleanup
Shadow bytes around the buggy address:
  0x0c327fffb9f0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0c327fffba00: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0c327fffba10: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0c327fffba20: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0c327fffba30: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
=3D>0x0c327fffba40: fd fd[fd]fd fd fd fd fd fd fd fd fd fd fd fd fd
  0x0c327fffba50: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
  0x0c327fffba60: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
  0x0c327fffba70: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
  0x0c327fffba80: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
  0x0c327fffba90: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
Shadow byte legend (one shadow byte represents 8 application bytes):
  Addressable: 00
  Partially addressable: 01 02 03 04 05 06 07
  Heap left redzone: fa
  Freed heap region: fd
  Stack left redzone: f1
  Stack mid redzone: f2
  Stack right redzone: f3
  Stack after return: f5
  Stack use after scope: f8
  Global redzone: f9
  Global init order: f6
  Poisoned by user: f7
  Container overflow: fc
  Array cookie: ac
  Intra object redzone: bb
  ASan internal: fe
  Left alloca redzone: ca
  Right alloca redzone: cb
  Shadow gap: cc
=3D=3D31958=3D=3DABORTING

Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
---
 migration/migration.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 609e0df5d0..b9848d1030 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1495,10 +1495,8 @@ static void block_cleanup_parameters(MigrationStat=
e *s)
     }
 }
=20
-static void migrate_fd_cleanup(void *opaque)
+static void migrate_fd_cleanup(MigrationState *s)
 {
-    MigrationState *s =3D opaque;
-
     qemu_bh_delete(s->cleanup_bh);
     s->cleanup_bh =3D NULL;
=20
@@ -1543,6 +1541,21 @@ static void migrate_fd_cleanup(void *opaque)
     block_cleanup_parameters(s);
 }
=20
+static void migrate_fd_cleanup_schedule(MigrationState *s)
+{
+    /* Ref the state for bh, because it may be called when
+     * there're already no other refs */
+    object_ref(OBJECT(s));
+    qemu_bh_schedule(s->cleanup_bh);
+}
+
+static void migrate_fd_cleanup_bh(void *opaque)
+{
+    MigrationState *s =3D opaque;
+    migrate_fd_cleanup(s);
+    object_unref(OBJECT(s));
+}
+
 void migrate_set_error(MigrationState *s, const Error *error)
 {
     qemu_mutex_lock(&s->error_mutex);
@@ -3144,7 +3157,7 @@ static void migration_iteration_finish(MigrationSta=
te *s)
         error_report("%s: Unknown ending state %d", __func__, s->state);
         break;
     }
-    qemu_bh_schedule(s->cleanup_bh);
+    migrate_fd_cleanup_schedule(s);
     qemu_mutex_unlock_iothread();
 }
=20
@@ -3279,7 +3292,7 @@ void migrate_fd_connect(MigrationState *s, Error *e=
rror_in)
     bool resume =3D s->state =3D=3D MIGRATION_STATUS_POSTCOPY_PAUSED;
=20
     s->expected_downtime =3D s->parameters.downtime_limit;
-    s->cleanup_bh =3D qemu_bh_new(migrate_fd_cleanup, s);
+    s->cleanup_bh =3D qemu_bh_new(migrate_fd_cleanup_bh, s);
     if (error_in) {
         migrate_fd_error(s, error_in);
         migrate_fd_cleanup(s);
--=20
2.21.0


