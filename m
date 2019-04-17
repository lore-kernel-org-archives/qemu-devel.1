Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE0DC282DA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 12:44:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98343206BA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 12:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="v70p7TEj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98343206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52023 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGjvj-0001Yh-Li
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 08:44:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hGjus-0001EM-FL
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 08:43:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hGjuq-0007qw-VC
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 08:43:54 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:46826)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hGjup-0007nB-Mx
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 08:43:52 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net
	[IPv6:2a02:6b8:0:1619::162])
	by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 9FEFF2E0908;
	Wed, 17 Apr 2019 15:43:46 +0300 (MSK)
Received: from localhost (localhost [::1])
	by mxbackcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id
	JdGXdkUeyv-hkMSqMua; Wed, 17 Apr 2019 15:43:46 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; 
	t=1555505026; bh=Awb+nGDcylr9KX5qylSrbur/omiqbBdwHVEwoUC3Y00=;
	h=Subject:In-Reply-To:Cc:Date:References:To:From:Message-Id;
	b=v70p7TEjPZuoMKL8TqYLp9Td2wELmEWeQfmRjSVsG8JgdKIppn5Y5uDQOweQHhyWo
	v5qly7DcUen7RW7D0oJh7YfoWJelqj8cQQah4133nBICw7RahaDD6vWAqSYKNEqoGc
	3uuY3V39qifNw+/Feh+dVU43P2UT+GEqdlejQPdQ=
Authentication-Results: mxbackcorp1j.mail.yandex.net;
	dkim=pass header.i=@yandex-team.ru
X-Yandex-Sender-Uid: 1120000000071945
X-Yandex-Avir: 1
Received: from mxbackcorp1o.mail.yandex.net ([::1])
	by mxbackcorp1o.mail.yandex.net with LMTP id rKOKsnij
	for <yury-kotov@yandex-team.ru>; Wed, 17 Apr 2019 15:43:41 +0300
Received: by vla1-9d3c37294942.qloud-c.yandex.net with HTTP;
	Wed, 17 Apr 2019 15:43:41 +0300
From: Yury Kotov <yury-kotov@yandex-team.ru>
To: Dr. David Alan Gilbert <dgilbert@redhat.com>,
	Juan Quintela <quintela@redhat.com>
In-Reply-To: <20190408113343.2370-1-yury-kotov@yandex-team.ru>
References: <20190408113343.2370-1-yury-kotov@yandex-team.ru>
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Wed, 17 Apr 2019 15:43:46 +0300
Message-Id: <878801555505021@vla1-9d3c37294942.qloud-c.yandex.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 5.45.199.163
Subject: Re: [Qemu-devel] [PATCH] migration: Fix use-after-free during
 process exit
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	=?utf-8?B?eWMtY29yZSAo0YDQsNGB0YHRi9C70LrQsCk=?= <yc-core@yandex-team.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190417124346._h9zxOhUQRULhfyIkMGj0QRJliDJ99DFnLXwCBz2tVc@z>

Ping

08.04.2019, 14:34, "Yury Kotov" <yury-kotov@yandex-team.ru>:
> It fixes heap-use-after-free which was found by clang's ASAN.
>
> Control flow of this use-after-free:
> main_thread:
> =C2=A0=C2=A0=C2=A0=C2=A0* Got SIGTERM and completes main loop
> =C2=A0=C2=A0=C2=A0=C2=A0* Calls migration_shutdown
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0- migrate_fd_cancel (so, migration_=
thread begins to complete)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0- object_unref(OBJECT(current_migra=
tion));
>
> migration_thread:
> =C2=A0=C2=A0=C2=A0=C2=A0* migration_iteration_finish -> schedule cleanu=
p bh
> =C2=A0=C2=A0=C2=A0=C2=A0* object_unref(OBJECT(s)); (Now, current_migrat=
ion is freed)
> =C2=A0=C2=A0=C2=A0=C2=A0* exits
>
> main_thread:
> =C2=A0=C2=A0=C2=A0=C2=A0* Calls vm_shutdown -> drain bdrvs -> main loop
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-> cleanup_bh -> use after free
>
> If you want to reproduce, these couple of sleeps will help:
> vl.c:4613:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0migration_shutdown();
> + sleep(2);
> migration.c:3269:
> + sleep(1);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0trace_migration_thread_after_loop();
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0migration_iteration_finish(s);
>
> Original output:
> qemu-system-x86_64: terminating on signal 15 from pid 31980 (<unknown p=
rocess>)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D31958=3D=3DERROR: AddressSanitizer: heap-use-after-free on addres=
s 0x61900001d210
> =C2=A0=C2=A0at pc 0x555558a535ca bp 0x7fffffffb190 sp 0x7fffffffb188
> READ of size 8 at 0x61900001d210 thread T0 (qemu-vm-0)
> =C2=A0=C2=A0=C2=A0=C2=A0#0 0x555558a535c9 in migrate_fd_cleanup migrati=
on/migration.c:1502:23
> =C2=A0=C2=A0=C2=A0=C2=A0#1 0x5555594fde0a in aio_bh_call util/async.c:9=
0:5
> =C2=A0=C2=A0=C2=A0=C2=A0#2 0x5555594fe522 in aio_bh_poll util/async.c:1=
18:13
> =C2=A0=C2=A0=C2=A0=C2=A0#3 0x555559524783 in aio_poll util/aio-posix.c:=
725:17
> =C2=A0=C2=A0=C2=A0=C2=A0#4 0x555559504fb3 in aio_wait_bh_oneshot util/a=
io-wait.c:71:5
> =C2=A0=C2=A0=C2=A0=C2=A0#5 0x5555573bddf6 in virtio_blk_data_plane_stop
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0hw/block/dataplane/virtio-blk.c:282=
:5
> =C2=A0=C2=A0=C2=A0=C2=A0#6 0x5555589d5c09 in virtio_bus_stop_ioeventfd =
hw/virtio/virtio-bus.c:246:9
> =C2=A0=C2=A0=C2=A0=C2=A0#7 0x5555589e9917 in virtio_pci_stop_ioeventfd =
hw/virtio/virtio-pci.c:287:5
> =C2=A0=C2=A0=C2=A0=C2=A0#8 0x5555589e22bf in virtio_pci_vmstate_change =
hw/virtio/virtio-pci.c:1072:9
> =C2=A0=C2=A0=C2=A0=C2=A0#9 0x555557628931 in virtio_vmstate_change hw/v=
irtio/virtio.c:2257:9
> =C2=A0=C2=A0=C2=A0=C2=A0#10 0x555557c36713 in vm_state_notify vl.c:1605=
:9
> =C2=A0=C2=A0=C2=A0=C2=A0#11 0x55555716ef53 in do_vm_stop cpus.c:1074:9
> =C2=A0=C2=A0=C2=A0=C2=A0#12 0x55555716eeff in vm_shutdown cpus.c:1092:1=
2
> =C2=A0=C2=A0=C2=A0=C2=A0#13 0x555557c4283e in main vl.c:4617:5
> =C2=A0=C2=A0=C2=A0=C2=A0#14 0x7fffdfdb482f in __libc_start_main
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(/lib/x86_64-linux-gnu/libc.so.6+0x=
2082f)
> =C2=A0=C2=A0=C2=A0=C2=A0#15 0x555556ecb118 in _start (x86_64-softmmu/qe=
mu-system-x86_64+0x1977118)
>
> 0x61900001d210 is located 144 bytes inside of 952-byte region
> =C2=A0=C2=A0[0x61900001d180,0x61900001d538)
> freed by thread T6 (live_migration) here:
> =C2=A0=C2=A0=C2=A0=C2=A0#0 0x555556f76782 in __interceptor_free
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/tmp/final/llvm.src/projects/compil=
er-rt/lib/asan/asan_malloc_linux.cc:124:3
> =C2=A0=C2=A0=C2=A0=C2=A0#1 0x555558d5fa94 in object_finalize qom/object=
.c:618:9
> =C2=A0=C2=A0=C2=A0=C2=A0#2 0x555558d57651 in object_unref qom/object.c:=
1068:9
> =C2=A0=C2=A0=C2=A0=C2=A0#3 0x555558a55588 in migration_thread migration=
/migration.c:3272:5
> =C2=A0=C2=A0=C2=A0=C2=A0#4 0x5555595393f2 in qemu_thread_start util/qem=
u-thread-posix.c:502:9
> =C2=A0=C2=A0=C2=A0=C2=A0#5 0x7fffe057f6b9 in start_thread (/lib/x86_64-=
linux-gnu/libpthread.so.0+0x76b9)
>
> previously allocated by thread T0 (qemu-vm-0) here:
> =C2=A0=C2=A0=C2=A0=C2=A0#0 0x555556f76b03 in __interceptor_malloc
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/tmp/final/llvm.src/projects/compil=
er-rt/lib/asan/asan_malloc_linux.cc:146:3
> =C2=A0=C2=A0=C2=A0=C2=A0#1 0x7ffff6ee37b8 in g_malloc (/lib/x86_64-linu=
x-gnu/libglib-2.0.so.0+0x4f7b8)
> =C2=A0=C2=A0=C2=A0=C2=A0#2 0x555558d58031 in object_new qom/object.c:64=
0:12
> =C2=A0=C2=A0=C2=A0=C2=A0#3 0x555558a31f21 in migration_object_init migr=
ation/migration.c:139:25
> =C2=A0=C2=A0=C2=A0=C2=A0#4 0x555557c41398 in main vl.c:4320:5
> =C2=A0=C2=A0=C2=A0=C2=A0#5 0x7fffdfdb482f in __libc_start_main (/lib/x8=
6_64-linux-gnu/libc.so.6+0x2082f)
>
> Thread T6 (live_migration) created by T0 (qemu-vm-0) here:
> =C2=A0=C2=A0=C2=A0=C2=A0#0 0x555556f5f0dd in pthread_create
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/tmp/final/llvm.src/projects/compil=
er-rt/lib/asan/asan_interceptors.cc:210:3
> =C2=A0=C2=A0=C2=A0=C2=A0#1 0x555559538cf9 in qemu_thread_create util/qe=
mu-thread-posix.c:539:11
> =C2=A0=C2=A0=C2=A0=C2=A0#2 0x555558a53304 in migrate_fd_connect migrati=
on/migration.c:3332:5
> =C2=A0=C2=A0=C2=A0=C2=A0#3 0x555558a72bd8 in migration_channel_connect =
migration/channel.c:92:5
> =C2=A0=C2=A0=C2=A0=C2=A0#4 0x555558a6ef87 in exec_start_outgoing_migrat=
ion migration/exec.c:42:5
> =C2=A0=C2=A0=C2=A0=C2=A0#5 0x555558a4f3c2 in qmp_migrate migration/migr=
ation.c:1922:9
> =C2=A0=C2=A0=C2=A0=C2=A0#6 0x555558bb4f6a in qmp_marshal_migrate qapi/q=
api-commands-migration.c:607:5
> =C2=A0=C2=A0=C2=A0=C2=A0#7 0x555559363738 in do_qmp_dispatch qapi/qmp-d=
ispatch.c:131:5
> =C2=A0=C2=A0=C2=A0=C2=A0#8 0x555559362a15 in qmp_dispatch qapi/qmp-disp=
atch.c:174:11
> =C2=A0=C2=A0=C2=A0=C2=A0#9 0x5555571bac15 in monitor_qmp_dispatch monit=
or.c:4124:11
> =C2=A0=C2=A0=C2=A0=C2=A0#10 0x55555719a22d in monitor_qmp_bh_dispatcher=
 monitor.c:4207:9
> =C2=A0=C2=A0=C2=A0=C2=A0#11 0x5555594fde0a in aio_bh_call util/async.c:=
90:5
> =C2=A0=C2=A0=C2=A0=C2=A0#12 0x5555594fe522 in aio_bh_poll util/async.c:=
118:13
> =C2=A0=C2=A0=C2=A0=C2=A0#13 0x5555595201e0 in aio_dispatch util/aio-pos=
ix.c:460:5
> =C2=A0=C2=A0=C2=A0=C2=A0#14 0x555559503553 in aio_ctx_dispatch util/asy=
nc.c:261:5
> =C2=A0=C2=A0=C2=A0=C2=A0#15 0x7ffff6ede196 in g_main_context_dispatch
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(/lib/x86_64-linux-gnu/libglib-2.0.=
so.0+0x4a196)
>
> SUMMARY: AddressSanitizer: heap-use-after-free migration/migration.c:15=
02:23
> =C2=A0=C2=A0in migrate_fd_cleanup
> Shadow bytes around the buggy address:
> =C2=A0=C2=A00x0c327fffb9f0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa f=
a fa
> =C2=A0=C2=A00x0c327fffba00: fa fa fa fa fa fa fa fa fa fa fa fa fa fa f=
a fa
> =C2=A0=C2=A00x0c327fffba10: fa fa fa fa fa fa fa fa fa fa fa fa fa fa f=
a fa
> =C2=A0=C2=A00x0c327fffba20: fa fa fa fa fa fa fa fa fa fa fa fa fa fa f=
a fa
> =C2=A0=C2=A00x0c327fffba30: fd fd fd fd fd fd fd fd fd fd fd fd fd fd f=
d fd
> =3D>0x0c327fffba40: fd fd[fd]fd fd fd fd fd fd fd fd fd fd fd fd fd
> =C2=A0=C2=A00x0c327fffba50: fd fd fd fd fd fd fd fd fd fd fd fd fd fd f=
d fd
> =C2=A0=C2=A00x0c327fffba60: fd fd fd fd fd fd fd fd fd fd fd fd fd fd f=
d fd
> =C2=A0=C2=A00x0c327fffba70: fd fd fd fd fd fd fd fd fd fd fd fd fd fd f=
d fd
> =C2=A0=C2=A00x0c327fffba80: fd fd fd fd fd fd fd fd fd fd fd fd fd fd f=
d fd
> =C2=A0=C2=A00x0c327fffba90: fd fd fd fd fd fd fd fd fd fd fd fd fd fd f=
d fd
> Shadow byte legend (one shadow byte represents 8 application bytes):
> =C2=A0=C2=A0Addressable: 00
> =C2=A0=C2=A0Partially addressable: 01 02 03 04 05 06 07
> =C2=A0=C2=A0Heap left redzone: fa
> =C2=A0=C2=A0Freed heap region: fd
> =C2=A0=C2=A0Stack left redzone: f1
> =C2=A0=C2=A0Stack mid redzone: f2
> =C2=A0=C2=A0Stack right redzone: f3
> =C2=A0=C2=A0Stack after return: f5
> =C2=A0=C2=A0Stack use after scope: f8
> =C2=A0=C2=A0Global redzone: f9
> =C2=A0=C2=A0Global init order: f6
> =C2=A0=C2=A0Poisoned by user: f7
> =C2=A0=C2=A0Container overflow: fc
> =C2=A0=C2=A0Array cookie: ac
> =C2=A0=C2=A0Intra object redzone: bb
> =C2=A0=C2=A0ASan internal: fe
> =C2=A0=C2=A0Left alloca redzone: ca
> =C2=A0=C2=A0Right alloca redzone: cb
> =C2=A0=C2=A0Shadow gap: cc
> =3D=3D31958=3D=3DABORTING
>
> Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
> ---
> =C2=A0migration/migration.c | 23 ++++++++++++++++++-----
> =C2=A01 file changed, 18 insertions(+), 5 deletions(-)
>
> diff --git a/migration/migration.c b/migration/migration.c
> index 609e0df5d0..b9848d1030 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1495,10 +1495,8 @@ static void block_cleanup_parameters(MigrationSt=
ate *s)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> =C2=A0}
>
> -static void migrate_fd_cleanup(void *opaque)
> +static void migrate_fd_cleanup(MigrationState *s)
> =C2=A0{
> - MigrationState *s =3D opaque;
> -
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0qemu_bh_delete(s->cleanup_bh);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0s->cleanup_bh =3D NULL;
>
> @@ -1543,6 +1541,21 @@ static void migrate_fd_cleanup(void *opaque)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0block_cleanup_parameters(s);
> =C2=A0}
>
> +static void migrate_fd_cleanup_schedule(MigrationState *s)
> +{
> + /* Ref the state for bh, because it may be called when
> + * there're already no other refs */
> + object_ref(OBJECT(s));
> + qemu_bh_schedule(s->cleanup_bh);
> +}
> +
> +static void migrate_fd_cleanup_bh(void *opaque)
> +{
> + MigrationState *s =3D opaque;
> + migrate_fd_cleanup(s);
> + object_unref(OBJECT(s));
> +}
> +
> =C2=A0void migrate_set_error(MigrationState *s, const Error *error)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0qemu_mutex_lock(&s->error_mutex);
> @@ -3144,7 +3157,7 @@ static void migration_iteration_finish(MigrationS=
tate *s)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0error_report("%s:=
 Unknown ending state %d", __func__, s->state);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0break;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> - qemu_bh_schedule(s->cleanup_bh);
> + migrate_fd_cleanup_schedule(s);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0qemu_mutex_unlock_iothread();
> =C2=A0}
>
> @@ -3279,7 +3292,7 @@ void migrate_fd_connect(MigrationState *s, Error =
*error_in)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool resume =3D s->state =3D=3D MIGRATION=
_STATUS_POSTCOPY_PAUSED;
>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0s->expected_downtime =3D s->parameters.do=
wntime_limit;
> - s->cleanup_bh =3D qemu_bh_new(migrate_fd_cleanup, s);
> + s->cleanup_bh =3D qemu_bh_new(migrate_fd_cleanup_bh, s);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (error_in) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0migrate_fd_error(=
s, error_in);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0migrate_fd_cleanu=
p(s);
> --
> 2.21.0

