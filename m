Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_HK_NAME_DR,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D83C4360F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 09:08:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CF6221855
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 09:08:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CF6221855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38448 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCKqE-0003fn-9G
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 05:08:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hCKom-0002gn-0X
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 05:07:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hCKoh-0006Z0-K4
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 05:07:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51070)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hCKof-0006Gl-0c
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 05:07:18 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 40843308FC4D;
	Fri,  5 Apr 2019 09:07:11 +0000 (UTC)
Received: from work-vm (ovpn-117-242.ams2.redhat.com [10.36.117.242])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id AF0C95D719;
	Fri,  5 Apr 2019 09:07:09 +0000 (UTC)
Date: Fri, 5 Apr 2019 10:07:07 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Yury Kotov <yury-kotov@yandex-team.ru>
Message-ID: <20190405090706.GC2819@work-vm>
References: <20190403083841.830-1-yury-kotov@yandex-team.ru>
	<20190403190503.GI2790@work-vm>
	<48831554365540@vla1-9d3c37294942.qloud-c.yandex.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <48831554365540@vla1-9d3c37294942.qloud-c.yandex.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Fri, 05 Apr 2019 09:07:11 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] migration: fix migration shutdown
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
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	Evgeny Yakovlev <wrfsh@yandex-team.ru>, Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190405090707.R4cSV-efJMo9y9Spmu9GJVkwnb4YKS7IL5woHOSGOno@z>

* Yury Kotov (yury-kotov@yandex-team.ru) wrote:
> 03.04.2019, 22:06, "Dr. David Alan Gilbert" <dgilbert@redhat.com>:
> > * Yury Kotov (yury-kotov@yandex-team.ru) wrote:
> >> =A0It fixes heap-use-after-free which was found by clang's ASAN.
> >>
> >> =A0Control flow of this use-after-free:
> >> =A0main_thread:
> >> =A0=A0=A0=A0=A0* Got SIGTERM and completes main loop
> >> =A0=A0=A0=A0=A0* Calls migration_shutdown
> >> =A0=A0=A0=A0=A0=A0=A0- migrate_fd_cancel (so, migration_thread begin=
s to complete)
> >> =A0=A0=A0=A0=A0=A0=A0- object_unref(OBJECT(current_migration));
> >>
> >> =A0migration_thread:
> >> =A0=A0=A0=A0=A0* migration_iteration_finish -> schedule cleanup bh
> >> =A0=A0=A0=A0=A0* object_unref(OBJECT(s)); (Now, current_migration is=
 freed)
> >> =A0=A0=A0=A0=A0* exits
> >>
> >> =A0main_thread:
> >> =A0=A0=A0=A0=A0* Calls vm_shutdown -> drain bdrvs -> main loop
> >> =A0=A0=A0=A0=A0=A0=A0-> cleanup_bh -> use after free
> >>
> >> =A0If you want to reproduce, these couple of sleeps will help:
> >> =A0vl.c:4613:
> >> =A0=A0=A0=A0=A0=A0migration_shutdown();
> >> =A0+ sleep(2);
> >> =A0migration.c:3269:
> >> =A0+ sleep(1);
> >> =A0=A0=A0=A0=A0=A0trace_migration_thread_after_loop();
> >> =A0=A0=A0=A0=A0=A0migration_iteration_finish(s);
> >
> > Fun; I hadn't realised you could get more main loop after exiting
> > the main loop.
> >
> > Is this fallout from my 892ae715b6b or is this just another case it
> > didn't catch?
> > I guess it moved the shutdown early, so it probably is fallout, and
> > so probably does need to go to 4.0 ?
> >
> I think this is closer to another case than fallout. Because without
> 892ae715b6b, reproducing of UAF at exit was much easier.
> Another way to fix it - remove unref from migration_shutdown
> (but keep migrate_fd_cancel) and restore migration_object_finalize.

OK, so in that case I'd rather leave this to 4.1 rather than rush it in
4.0rc's - I'd rather only take regressions at this point.

Dave

> >> =A0Original output:
> >> =A0qemu-system-x86_64: terminating on signal 15 from pid 31980 (<unk=
nown process>)
> >> =A0=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> =A0=3D=3D31958=3D=3DERROR: AddressSanitizer: heap-use-after-free on =
address 0x61900001d210
> >> =A0=A0=A0at pc 0x555558a535ca bp 0x7fffffffb190 sp 0x7fffffffb188
> >> =A0READ of size 8 at 0x61900001d210 thread T0 (qemu-vm-0)
> >> =A0=A0=A0=A0=A0#0 0x555558a535c9 in migrate_fd_cleanup migration/mig=
ration.c:1502:23
> >> =A0=A0=A0=A0=A0#1 0x5555594fde0a in aio_bh_call util/async.c:90:5
> >> =A0=A0=A0=A0=A0#2 0x5555594fe522 in aio_bh_poll util/async.c:118:13
> >> =A0=A0=A0=A0=A0#3 0x555559524783 in aio_poll util/aio-posix.c:725:17
> >> =A0=A0=A0=A0=A0#4 0x555559504fb3 in aio_wait_bh_oneshot util/aio-wai=
t.c:71:5
> >> =A0=A0=A0=A0=A0#5 0x5555573bddf6 in virtio_blk_data_plane_stop
> >> =A0=A0=A0=A0=A0=A0=A0hw/block/dataplane/virtio-blk.c:282:5
> >> =A0=A0=A0=A0=A0#6 0x5555589d5c09 in virtio_bus_stop_ioeventfd hw/vir=
tio/virtio-bus.c:246:9
> >> =A0=A0=A0=A0=A0#7 0x5555589e9917 in virtio_pci_stop_ioeventfd hw/vir=
tio/virtio-pci.c:287:5
> >> =A0=A0=A0=A0=A0#8 0x5555589e22bf in virtio_pci_vmstate_change hw/vir=
tio/virtio-pci.c:1072:9
> >> =A0=A0=A0=A0=A0#9 0x555557628931 in virtio_vmstate_change hw/virtio/=
virtio.c:2257:9
> >> =A0=A0=A0=A0=A0#10 0x555557c36713 in vm_state_notify vl.c:1605:9
> >> =A0=A0=A0=A0=A0#11 0x55555716ef53 in do_vm_stop cpus.c:1074:9
> >> =A0=A0=A0=A0=A0#12 0x55555716eeff in vm_shutdown cpus.c:1092:12
> >> =A0=A0=A0=A0=A0#13 0x555557c4283e in main vl.c:4617:5
> >> =A0=A0=A0=A0=A0#14 0x7fffdfdb482f in __libc_start_main
> >> =A0=A0=A0=A0=A0=A0=A0(/lib/x86_64-linux-gnu/libc.so.6+0x2082f)
> >> =A0=A0=A0=A0=A0#15 0x555556ecb118 in _start (x86_64-softmmu/qemu-sys=
tem-x86_64+0x1977118)
> >>
> >> =A00x61900001d210 is located 144 bytes inside of 952-byte region
> >> =A0=A0=A0[0x61900001d180,0x61900001d538)
> >> =A0freed by thread T6 (live_migration) here:
> >> =A0=A0=A0=A0=A0#0 0x555556f76782 in __interceptor_free
> >> =A0=A0=A0=A0=A0=A0=A0/tmp/final/llvm.src/projects/compiler-rt/lib/as=
an/asan_malloc_linux.cc:124:3
> >> =A0=A0=A0=A0=A0#1 0x555558d5fa94 in object_finalize qom/object.c:618=
:9
> >> =A0=A0=A0=A0=A0#2 0x555558d57651 in object_unref qom/object.c:1068:9
> >> =A0=A0=A0=A0=A0#3 0x555558a55588 in migration_thread migration/migra=
tion.c:3272:5
> >> =A0=A0=A0=A0=A0#4 0x5555595393f2 in qemu_thread_start util/qemu-thre=
ad-posix.c:502:9
> >> =A0=A0=A0=A0=A0#5 0x7fffe057f6b9 in start_thread (/lib/x86_64-linux-=
gnu/libpthread.so.0+0x76b9)
> >>
> >> =A0previously allocated by thread T0 (qemu-vm-0) here:
> >> =A0=A0=A0=A0=A0#0 0x555556f76b03 in __interceptor_malloc
> >> =A0=A0=A0=A0=A0=A0=A0/tmp/final/llvm.src/projects/compiler-rt/lib/as=
an/asan_malloc_linux.cc:146:3
> >> =A0=A0=A0=A0=A0#1 0x7ffff6ee37b8 in g_malloc (/lib/x86_64-linux-gnu/=
libglib-2.0.so.0+0x4f7b8)
> >> =A0=A0=A0=A0=A0#2 0x555558d58031 in object_new qom/object.c:640:12
> >> =A0=A0=A0=A0=A0#3 0x555558a31f21 in migration_object_init migration/=
migration.c:139:25
> >> =A0=A0=A0=A0=A0#4 0x555557c41398 in main vl.c:4320:5
> >> =A0=A0=A0=A0=A0#5 0x7fffdfdb482f in __libc_start_main (/lib/x86_64-l=
inux-gnu/libc.so.6+0x2082f)
> >>
> >> =A0Thread T6 (live_migration) created by T0 (qemu-vm-0) here:
> >> =A0=A0=A0=A0=A0#0 0x555556f5f0dd in pthread_create
> >> =A0=A0=A0=A0=A0=A0=A0/tmp/final/llvm.src/projects/compiler-rt/lib/as=
an/asan_interceptors.cc:210:3
> >> =A0=A0=A0=A0=A0#1 0x555559538cf9 in qemu_thread_create util/qemu-thr=
ead-posix.c:539:11
> >> =A0=A0=A0=A0=A0#2 0x555558a53304 in migrate_fd_connect migration/mig=
ration.c:3332:5
> >> =A0=A0=A0=A0=A0#3 0x555558a72bd8 in migration_channel_connect migrat=
ion/channel.c:92:5
> >> =A0=A0=A0=A0=A0#4 0x555558a6ef87 in exec_start_outgoing_migration mi=
gration/exec.c:42:5
> >> =A0=A0=A0=A0=A0#5 0x555558a4f3c2 in qmp_migrate migration/migration.=
c:1922:9
> >> =A0=A0=A0=A0=A0#6 0x555558bb4f6a in qmp_marshal_migrate qapi/qapi-co=
mmands-migration.c:607:5
> >> =A0=A0=A0=A0=A0#7 0x555559363738 in do_qmp_dispatch qapi/qmp-dispatc=
h.c:131:5
> >> =A0=A0=A0=A0=A0#8 0x555559362a15 in qmp_dispatch qapi/qmp-dispatch.c=
:174:11
> >> =A0=A0=A0=A0=A0#9 0x5555571bac15 in monitor_qmp_dispatch monitor.c:4=
124:11
> >> =A0=A0=A0=A0=A0#10 0x55555719a22d in monitor_qmp_bh_dispatcher monit=
or.c:4207:9
> >> =A0=A0=A0=A0=A0#11 0x5555594fde0a in aio_bh_call util/async.c:90:5
> >> =A0=A0=A0=A0=A0#12 0x5555594fe522 in aio_bh_poll util/async.c:118:13
> >> =A0=A0=A0=A0=A0#13 0x5555595201e0 in aio_dispatch util/aio-posix.c:4=
60:5
> >> =A0=A0=A0=A0=A0#14 0x555559503553 in aio_ctx_dispatch util/async.c:2=
61:5
> >> =A0=A0=A0=A0=A0#15 0x7ffff6ede196 in g_main_context_dispatch
> >> =A0=A0=A0=A0=A0=A0=A0(/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x4a196=
)
> >>
> >> =A0SUMMARY: AddressSanitizer: heap-use-after-free migration/migratio=
n.c:1502:23
> >> =A0=A0=A0in migrate_fd_cleanup
> >> =A0Shadow bytes around the buggy address:
> >> =A0=A0=A00x0c327fffb9f0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa f=
a fa
> >> =A0=A0=A00x0c327fffba00: fa fa fa fa fa fa fa fa fa fa fa fa fa fa f=
a fa
> >> =A0=A0=A00x0c327fffba10: fa fa fa fa fa fa fa fa fa fa fa fa fa fa f=
a fa
> >> =A0=A0=A00x0c327fffba20: fa fa fa fa fa fa fa fa fa fa fa fa fa fa f=
a fa
> >> =A0=A0=A00x0c327fffba30: fd fd fd fd fd fd fd fd fd fd fd fd fd fd f=
d fd
> >> =A0=3D>0x0c327fffba40: fd fd[fd]fd fd fd fd fd fd fd fd fd fd fd fd =
fd
> >> =A0=A0=A00x0c327fffba50: fd fd fd fd fd fd fd fd fd fd fd fd fd fd f=
d fd
> >> =A0=A0=A00x0c327fffba60: fd fd fd fd fd fd fd fd fd fd fd fd fd fd f=
d fd
> >> =A0=A0=A00x0c327fffba70: fd fd fd fd fd fd fd fd fd fd fd fd fd fd f=
d fd
> >> =A0=A0=A00x0c327fffba80: fd fd fd fd fd fd fd fd fd fd fd fd fd fd f=
d fd
> >> =A0=A0=A00x0c327fffba90: fd fd fd fd fd fd fd fd fd fd fd fd fd fd f=
d fd
> >> =A0Shadow byte legend (one shadow byte represents 8 application byte=
s):
> >> =A0=A0=A0Addressable: 00
> >> =A0=A0=A0Partially addressable: 01 02 03 04 05 06 07
> >> =A0=A0=A0Heap left redzone: fa
> >> =A0=A0=A0Freed heap region: fd
> >> =A0=A0=A0Stack left redzone: f1
> >> =A0=A0=A0Stack mid redzone: f2
> >> =A0=A0=A0Stack right redzone: f3
> >> =A0=A0=A0Stack after return: f5
> >> =A0=A0=A0Stack use after scope: f8
> >> =A0=A0=A0Global redzone: f9
> >> =A0=A0=A0Global init order: f6
> >> =A0=A0=A0Poisoned by user: f7
> >> =A0=A0=A0Container overflow: fc
> >> =A0=A0=A0Array cookie: ac
> >> =A0=A0=A0Intra object redzone: bb
> >> =A0=A0=A0ASan internal: fe
> >> =A0=A0=A0Left alloca redzone: ca
> >> =A0=A0=A0Right alloca redzone: cb
> >> =A0=A0=A0Shadow gap: cc
> >> =A0=3D=3D31958=3D=3DABORTING
> >>
> >> =A0Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
> >> =A0---
> >> =A0=A0migration/migration.c | 30 ++++++++++++++++++++++++------
> >> =A0=A01 file changed, 24 insertions(+), 6 deletions(-)
> >>
> >> =A0diff --git a/migration/migration.c b/migration/migration.c
> >> =A0index 609e0df5d0..54d82bb88b 100644
> >> =A0--- a/migration/migration.c
> >> =A0+++ b/migration/migration.c
> >> =A0@@ -128,6 +128,8 @@ static int migration_maybe_pause(MigrationSta=
te *s,
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0int *current_active_state,
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0int new_state);
> >> =A0=A0static void migrate_fd_cancel(MigrationState *s);
> >> =A0+static void migrate_join_thread(MigrationState *s);
> >> =A0+static void migrate_fd_cleanup(void *opaque);
> >>
> >> =A0=A0void migration_object_init(void)
> >> =A0=A0{
> >> =A0@@ -176,6 +178,17 @@ void migration_shutdown(void)
> >> =A0=A0=A0=A0=A0=A0=A0* stop the migration using this structure
> >> =A0=A0=A0=A0=A0=A0=A0*/
> >> =A0=A0=A0=A0=A0=A0migrate_fd_cancel(current_migration);
> >> =A0+ /*
> >> =A0+ * migration_thread schedules cleanup_bh, but migration_shutdown=
 is called
> >> =A0+ * from the end of main, so cleanu_up may not be called because =
main-loop is
> >> =A0+ * complete. So, wait for the complition of migration_thread, ca=
ncel bh and
> >> =A0+ * call cleanup ourselves.
> >> =A0+ */
> >
> > (Some typos)
> >
> Ok :)
>=20
> >> =A0+ migrate_join_thread(current_migration);
> >
> > I'll admit to being a bit nervous that something in here could be
> > hanging and thus we could hang here rather than die as SIGTERM is
> > expecting us to.
> >
> I think it's only way to be sure we havn't other races with migration_t=
hread.
> And this joining is cheaper than vm_shutdown IMHO.
>=20
> >> =A0+ if (current_migration->cleanup_bh) {
> >> =A0+ qemu_bh_cancel(current_migration->cleanup_bh);
> >
> > Is that needed? Doesn't migrate_fd_cleanup start with a qemu_bh_delet=
e?
> >
> Agree, it's odd.
>=20
> >> =A0+ migrate_fd_cleanup(current_migration);
> >> =A0+ }
> >> =A0=A0=A0=A0=A0=A0object_unref(OBJECT(current_migration));
> >> =A0=A0}
> >>
> >> =A0@@ -1495,6 +1508,16 @@ static void block_cleanup_parameters(Migra=
tionState *s)
> >> =A0=A0=A0=A0=A0=A0}
> >> =A0=A0}
> >>
> >> =A0+static void migrate_join_thread(MigrationState *s)
> >> =A0+{
> >> =A0+ qemu_mutex_unlock_iothread();
> >> =A0+ if (s->migration_thread_running) {
> >> =A0+ qemu_thread_join(&s->thread);
> >> =A0+ s->migration_thread_running =3D false;
> >> =A0+ }
> >> =A0+ qemu_mutex_lock_iothread();
> >> =A0+}
> >> =A0+
> >> =A0=A0static void migrate_fd_cleanup(void *opaque)
> >> =A0=A0{
> >> =A0=A0=A0=A0=A0=A0MigrationState *s =3D opaque;
> >> =A0@@ -1508,12 +1531,7 @@ static void migrate_fd_cleanup(void *opaqu=
e)
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0QEMUFile *tmp;
> >>
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0trace_migrate_fd_cleanup();
> >> =A0- qemu_mutex_unlock_iothread();
> >> =A0- if (s->migration_thread_running) {
> >> =A0- qemu_thread_join(&s->thread);
> >> =A0- s->migration_thread_running =3D false;
> >> =A0- }
> >> =A0- qemu_mutex_lock_iothread();
> >> =A0+ migrate_join_thread(s);
> >>
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0multifd_save_cleanup();
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0qemu_mutex_lock(&s->qemu_file_lock);
> >
> > Dave
> >
> >> =A0--
> >> =A02.21.0
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

