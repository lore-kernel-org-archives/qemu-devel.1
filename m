Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E52FEC10F13
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 11:37:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9086C2070D
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 11:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="vCqMeEZF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9086C2070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51481 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDSai-0000SQ-O2
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 07:37:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hDSZq-0008T0-E1
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 07:36:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hDSZo-0000lK-IO
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 07:36:38 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:39530)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hDSZo-0000kJ-24
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 07:36:36 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net
	[IPv6:2a02:6b8:0:1619::162])
	by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id B99822E1500;
	Mon,  8 Apr 2019 14:36:34 +0300 (MSK)
Received: from localhost (localhost [::1])
	by mxbackcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id
	HL8qK4DzXq-aY3q1Lf1; Mon, 08 Apr 2019 14:36:34 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; 
	t=1554723394; bh=BmUxItcpz2lEhDCVWG0+M6xL2WVW6GrEO2MtmYYu0Og=;
	h=Subject:In-Reply-To:Cc:Date:References:To:From:Message-Id;
	b=vCqMeEZF8KsT/KsRAWMxfRqbe0lnFHIaOjYj8t4Hn2SH3cOZpv5aDcQUgm7EzBEh7
	ZKitvfxcbfusC6pRaY0xk7wNLm0N0q4Ro+WJBXNw7YRzs5BW/AsAI5/F8iZ959r5Lv
	4mHctVx9lXXXKMArktGZtHH924D9qZspnfhIzmvM=
Authentication-Results: mxbackcorp1j.mail.yandex.net;
	dkim=pass header.i=@yandex-team.ru
X-Yandex-Sender-Uid: 1120000000071945
X-Yandex-Avir: 1
Received: from mxbackcorp1g.mail.yandex.net ([::1])
	by mxbackcorp1g.mail.yandex.net with LMTP id 3k1H9nkz
	for <yury-kotov@yandex-team.ru>; Mon, 8 Apr 2019 14:36:29 +0300
Received: by iva6-8a76e93b6298.qloud-c.yandex.net with HTTP;
	Mon, 08 Apr 2019 14:36:29 +0300
From: Yury Kotov <yury-kotov@yandex-team.ru>
To: Dr. David Alan Gilbert <dgilbert@redhat.com>
In-Reply-To: <20190405090706.GC2819@work-vm>
References: <20190403083841.830-1-yury-kotov@yandex-team.ru>
	<20190403190503.GI2790@work-vm>
	<48831554365540@vla1-9d3c37294942.qloud-c.yandex.net>
	<20190405090706.GC2819@work-vm>
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Mon, 08 Apr 2019 14:36:34 +0300
Message-Id: <309001554723389@iva6-8a76e93b6298.qloud-c.yandex.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 5.45.199.163
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
Cc: =?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	Evgeny Yakovlev <wrfsh@yandex-team.ru>, Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408113634.mlF4F8e3uHQHQmQZIJlqQaVDpxupEt2r1fQxKImoOxI@z>

Hi,

I've sent another patch to fix this UAF:
"migration: Fix use-after-free during process exit"

It's more simple and fixes only the regression.

Regards,
Yury

05.04.2019, 12:07, "Dr. David Alan Gilbert" <dgilbert@redhat.com>:
> * Yury Kotov (yury-kotov@yandex-team.ru) wrote:
>> =C2=A003.04.2019, 22:06, "Dr. David Alan Gilbert" <dgilbert@redhat.com=
>:
>> =C2=A0> * Yury Kotov (yury-kotov@yandex-team.ru) wrote:
>> =C2=A0>> =C2=A0It fixes heap-use-after-free which was found by clang's=
 ASAN.
>> =C2=A0>>
>> =C2=A0>> =C2=A0Control flow of this use-after-free:
>> =C2=A0>> =C2=A0main_thread:
>> =C2=A0>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* Got SIGTERM and completes mai=
n loop
>> =C2=A0>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* Calls migration_shutdown
>> =C2=A0>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0- migrate_fd_cancel=
 (so, migration_thread begins to complete)
>> =C2=A0>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0- object_unref(OBJE=
CT(current_migration));
>> =C2=A0>>
>> =C2=A0>> =C2=A0migration_thread:
>> =C2=A0>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* migration_iteration_finish ->=
 schedule cleanup bh
>> =C2=A0>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* object_unref(OBJECT(s)); (Now=
, current_migration is freed)
>> =C2=A0>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* exits
>> =C2=A0>>
>> =C2=A0>> =C2=A0main_thread:
>> =C2=A0>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* Calls vm_shutdown -> drain bd=
rvs -> main loop
>> =C2=A0>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-> cleanup_bh -> us=
e after free
>> =C2=A0>>
>> =C2=A0>> =C2=A0If you want to reproduce, these couple of sleeps will h=
elp:
>> =C2=A0>> =C2=A0vl.c:4613:
>> =C2=A0>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0migration_shutdown();
>> =C2=A0>> =C2=A0+ sleep(2);
>> =C2=A0>> =C2=A0migration.c:3269:
>> =C2=A0>> =C2=A0+ sleep(1);
>> =C2=A0>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0trace_migration_thread_af=
ter_loop();
>> =C2=A0>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0migration_iteration_finis=
h(s);
>> =C2=A0>
>> =C2=A0> Fun; I hadn't realised you could get more main loop after exit=
ing
>> =C2=A0> the main loop.
>> =C2=A0>
>> =C2=A0> Is this fallout from my 892ae715b6b or is this just another ca=
se it
>> =C2=A0> didn't catch?
>> =C2=A0> I guess it moved the shutdown early, so it probably is fallout=
, and
>> =C2=A0> so probably does need to go to 4.0 ?
>> =C2=A0>
>> =C2=A0I think this is closer to another case than fallout. Because wit=
hout
>> =C2=A0892ae715b6b, reproducing of UAF at exit was much easier.
>> =C2=A0Another way to fix it - remove unref from migration_shutdown
>> =C2=A0(but keep migrate_fd_cancel) and restore migration_object_finali=
ze.
>
> OK, so in that case I'd rather leave this to 4.1 rather than rush it in
> 4.0rc's - I'd rather only take regressions at this point.
>
> Dave
>
>> =C2=A0>> =C2=A0Original output:
>> =C2=A0>> =C2=A0qemu-system-x86_64: terminating on signal 15 from pid 3=
1980 (<unknown process>)
>> =C2=A0>> =C2=A0=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> =C2=A0>> =C2=A0=3D=3D31958=3D=3DERROR: AddressSanitizer: heap-use-afte=
r-free on address 0x61900001d210
>> =C2=A0>> =C2=A0=C2=A0=C2=A0at pc 0x555558a535ca bp 0x7fffffffb190 sp 0=
x7fffffffb188
>> =C2=A0>> =C2=A0READ of size 8 at 0x61900001d210 thread T0 (qemu-vm-0)
>> =C2=A0>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#0 0x555558a535c9 in migrate_fd=
_cleanup migration/migration.c:1502:23
>> =C2=A0>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#1 0x5555594fde0a in aio_bh_cal=
l util/async.c:90:5
>> =C2=A0>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#2 0x5555594fe522 in aio_bh_pol=
l util/async.c:118:13
>> =C2=A0>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#3 0x555559524783 in aio_poll u=
til/aio-posix.c:725:17
>> =C2=A0>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#4 0x555559504fb3 in aio_wait_b=
h_oneshot util/aio-wait.c:71:5
>> =C2=A0>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#5 0x5555573bddf6 in virtio_blk=
_data_plane_stop
>> =C2=A0>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0hw/block/dataplane/=
virtio-blk.c:282:5
>> =C2=A0>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#6 0x5555589d5c09 in virtio_bus=
_stop_ioeventfd hw/virtio/virtio-bus.c:246:9
>> =C2=A0>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#7 0x5555589e9917 in virtio_pci=
_stop_ioeventfd hw/virtio/virtio-pci.c:287:5
>> =C2=A0>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#8 0x5555589e22bf in virtio_pci=
_vmstate_change hw/virtio/virtio-pci.c:1072:9
>> =C2=A0>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#9 0x555557628931 in virtio_vms=
tate_change hw/virtio/virtio.c:2257:9
>> =C2=A0>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#10 0x555557c36713 in vm_state_=
notify vl.c:1605:9
>> =C2=A0>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#11 0x55555716ef53 in do_vm_sto=
p cpus.c:1074:9
>> =C2=A0>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#12 0x55555716eeff in vm_shutdo=
wn cpus.c:1092:12
>> =C2=A0>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#13 0x555557c4283e in main vl.c=
:4617:5
>> =C2=A0>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#14 0x7fffdfdb482f in __libc_st=
art_main
>> =C2=A0>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(/lib/x86_64-linux-=
gnu/libc.so.6+0x2082f)
>> =C2=A0>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#15 0x555556ecb118 in _start (x=
86_64-softmmu/qemu-system-x86_64+0x1977118)
>> =C2=A0>>
>> =C2=A0>> =C2=A00x61900001d210 is located 144 bytes inside of 952-byte =
region
>> =C2=A0>> =C2=A0=C2=A0=C2=A0[0x61900001d180,0x61900001d538)
>> =C2=A0>> =C2=A0freed by thread T6 (live_migration) here:
>> =C2=A0>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#0 0x555556f76782 in __intercep=
tor_free
>> =C2=A0>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/tmp/final/llvm.src=
/projects/compiler-rt/lib/asan/asan_malloc_linux.cc:124:3
>> =C2=A0>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#1 0x555558d5fa94 in object_fin=
alize qom/object.c:618:9
>> =C2=A0>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#2 0x555558d57651 in object_unr=
ef qom/object.c:1068:9
>> =C2=A0>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#3 0x555558a55588 in migration_=
thread migration/migration.c:3272:5
>> =C2=A0>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#4 0x5555595393f2 in qemu_threa=
d_start util/qemu-thread-posix.c:502:9
>> =C2=A0>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#5 0x7fffe057f6b9 in start_thre=
ad (/lib/x86_64-linux-gnu/libpthread.so.0+0x76b9)
>> =C2=A0>>
>> =C2=A0>> =C2=A0previously allocated by thread T0 (qemu-vm-0) here:
>> =C2=A0>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#0 0x555556f76b03 in __intercep=
tor_malloc
>> =C2=A0>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/tmp/final/llvm.src=
/projects/compiler-rt/lib/asan/asan_malloc_linux.cc:146:3
>> =C2=A0>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#1 0x7ffff6ee37b8 in g_malloc (=
/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x4f7b8)
>> =C2=A0>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#2 0x555558d58031 in object_new=
 qom/object.c:640:12
>> =C2=A0>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#3 0x555558a31f21 in migration_=
object_init migration/migration.c:139:25
>> =C2=A0>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#4 0x555557c41398 in main vl.c:=
4320:5
>> =C2=A0>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#5 0x7fffdfdb482f in __libc_sta=
rt_main (/lib/x86_64-linux-gnu/libc.so.6+0x2082f)
>> =C2=A0>>
>> =C2=A0>> =C2=A0Thread T6 (live_migration) created by T0 (qemu-vm-0) he=
re:
>> =C2=A0>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#0 0x555556f5f0dd in pthread_cr=
eate
>> =C2=A0>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/tmp/final/llvm.src=
/projects/compiler-rt/lib/asan/asan_interceptors.cc:210:3
>> =C2=A0>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#1 0x555559538cf9 in qemu_threa=
d_create util/qemu-thread-posix.c:539:11
>> =C2=A0>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#2 0x555558a53304 in migrate_fd=
_connect migration/migration.c:3332:5
>> =C2=A0>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#3 0x555558a72bd8 in migration_=
channel_connect migration/channel.c:92:5
>> =C2=A0>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#4 0x555558a6ef87 in exec_start=
_outgoing_migration migration/exec.c:42:5
>> =C2=A0>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#5 0x555558a4f3c2 in qmp_migrat=
e migration/migration.c:1922:9
>> =C2=A0>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#6 0x555558bb4f6a in qmp_marsha=
l_migrate qapi/qapi-commands-migration.c:607:5
>> =C2=A0>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#7 0x555559363738 in do_qmp_dis=
patch qapi/qmp-dispatch.c:131:5
>> =C2=A0>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#8 0x555559362a15 in qmp_dispat=
ch qapi/qmp-dispatch.c:174:11
>> =C2=A0>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#9 0x5555571bac15 in monitor_qm=
p_dispatch monitor.c:4124:11
>> =C2=A0>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#10 0x55555719a22d in monitor_q=
mp_bh_dispatcher monitor.c:4207:9
>> =C2=A0>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#11 0x5555594fde0a in aio_bh_ca=
ll util/async.c:90:5
>> =C2=A0>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#12 0x5555594fe522 in aio_bh_po=
ll util/async.c:118:13
>> =C2=A0>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#13 0x5555595201e0 in aio_dispa=
tch util/aio-posix.c:460:5
>> =C2=A0>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#14 0x555559503553 in aio_ctx_d=
ispatch util/async.c:261:5
>> =C2=A0>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#15 0x7ffff6ede196 in g_main_co=
ntext_dispatch
>> =C2=A0>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(/lib/x86_64-linux-=
gnu/libglib-2.0.so.0+0x4a196)
>> =C2=A0>>
>> =C2=A0>> =C2=A0SUMMARY: AddressSanitizer: heap-use-after-free migratio=
n/migration.c:1502:23
>> =C2=A0>> =C2=A0=C2=A0=C2=A0in migrate_fd_cleanup
>> =C2=A0>> =C2=A0Shadow bytes around the buggy address:
>> =C2=A0>> =C2=A0=C2=A0=C2=A00x0c327fffb9f0: fa fa fa fa fa fa fa fa fa =
fa fa fa fa fa fa fa
>> =C2=A0>> =C2=A0=C2=A0=C2=A00x0c327fffba00: fa fa fa fa fa fa fa fa fa =
fa fa fa fa fa fa fa
>> =C2=A0>> =C2=A0=C2=A0=C2=A00x0c327fffba10: fa fa fa fa fa fa fa fa fa =
fa fa fa fa fa fa fa
>> =C2=A0>> =C2=A0=C2=A0=C2=A00x0c327fffba20: fa fa fa fa fa fa fa fa fa =
fa fa fa fa fa fa fa
>> =C2=A0>> =C2=A0=C2=A0=C2=A00x0c327fffba30: fd fd fd fd fd fd fd fd fd =
fd fd fd fd fd fd fd
>> =C2=A0>> =C2=A0=3D>0x0c327fffba40: fd fd[fd]fd fd fd fd fd fd fd fd fd=
 fd fd fd fd
>> =C2=A0>> =C2=A0=C2=A0=C2=A00x0c327fffba50: fd fd fd fd fd fd fd fd fd =
fd fd fd fd fd fd fd
>> =C2=A0>> =C2=A0=C2=A0=C2=A00x0c327fffba60: fd fd fd fd fd fd fd fd fd =
fd fd fd fd fd fd fd
>> =C2=A0>> =C2=A0=C2=A0=C2=A00x0c327fffba70: fd fd fd fd fd fd fd fd fd =
fd fd fd fd fd fd fd
>> =C2=A0>> =C2=A0=C2=A0=C2=A00x0c327fffba80: fd fd fd fd fd fd fd fd fd =
fd fd fd fd fd fd fd
>> =C2=A0>> =C2=A0=C2=A0=C2=A00x0c327fffba90: fd fd fd fd fd fd fd fd fd =
fd fd fd fd fd fd fd
>> =C2=A0>> =C2=A0Shadow byte legend (one shadow byte represents 8 applic=
ation bytes):
>> =C2=A0>> =C2=A0=C2=A0=C2=A0Addressable: 00
>> =C2=A0>> =C2=A0=C2=A0=C2=A0Partially addressable: 01 02 03 04 05 06 07
>> =C2=A0>> =C2=A0=C2=A0=C2=A0Heap left redzone: fa
>> =C2=A0>> =C2=A0=C2=A0=C2=A0Freed heap region: fd
>> =C2=A0>> =C2=A0=C2=A0=C2=A0Stack left redzone: f1
>> =C2=A0>> =C2=A0=C2=A0=C2=A0Stack mid redzone: f2
>> =C2=A0>> =C2=A0=C2=A0=C2=A0Stack right redzone: f3
>> =C2=A0>> =C2=A0=C2=A0=C2=A0Stack after return: f5
>> =C2=A0>> =C2=A0=C2=A0=C2=A0Stack use after scope: f8
>> =C2=A0>> =C2=A0=C2=A0=C2=A0Global redzone: f9
>> =C2=A0>> =C2=A0=C2=A0=C2=A0Global init order: f6
>> =C2=A0>> =C2=A0=C2=A0=C2=A0Poisoned by user: f7
>> =C2=A0>> =C2=A0=C2=A0=C2=A0Container overflow: fc
>> =C2=A0>> =C2=A0=C2=A0=C2=A0Array cookie: ac
>> =C2=A0>> =C2=A0=C2=A0=C2=A0Intra object redzone: bb
>> =C2=A0>> =C2=A0=C2=A0=C2=A0ASan internal: fe
>> =C2=A0>> =C2=A0=C2=A0=C2=A0Left alloca redzone: ca
>> =C2=A0>> =C2=A0=C2=A0=C2=A0Right alloca redzone: cb
>> =C2=A0>> =C2=A0=C2=A0=C2=A0Shadow gap: cc
>> =C2=A0>> =C2=A0=3D=3D31958=3D=3DABORTING
>> =C2=A0>>
>> =C2=A0>> =C2=A0Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
>> =C2=A0>> =C2=A0---
>> =C2=A0>> =C2=A0=C2=A0migration/migration.c | 30 ++++++++++++++++++++++=
++------
>> =C2=A0>> =C2=A0=C2=A01 file changed, 24 insertions(+), 6 deletions(-)
>> =C2=A0>>
>> =C2=A0>> =C2=A0diff --git a/migration/migration.c b/migration/migratio=
n.c
>> =C2=A0>> =C2=A0index 609e0df5d0..54d82bb88b 100644
>> =C2=A0>> =C2=A0--- a/migration/migration.c
>> =C2=A0>> =C2=A0+++ b/migration/migration.c
>> =C2=A0>> =C2=A0@@ -128,6 +128,8 @@ static int migration_maybe_pause(Mi=
grationState *s,
>> =C2=A0>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0i=
nt *current_active_state,
>> =C2=A0>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0i=
nt new_state);
>> =C2=A0>> =C2=A0=C2=A0static void migrate_fd_cancel(MigrationState *s);
>> =C2=A0>> =C2=A0+static void migrate_join_thread(MigrationState *s);
>> =C2=A0>> =C2=A0+static void migrate_fd_cleanup(void *opaque);
>> =C2=A0>>
>> =C2=A0>> =C2=A0=C2=A0void migration_object_init(void)
>> =C2=A0>> =C2=A0=C2=A0{
>> =C2=A0>> =C2=A0@@ -176,6 +178,17 @@ void migration_shutdown(void)
>> =C2=A0>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* stop the migratio=
n using this structure
>> =C2=A0>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*/
>> =C2=A0>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0migrate_fd_cancel(current=
_migration);
>> =C2=A0>> =C2=A0+ /*
>> =C2=A0>> =C2=A0+ * migration_thread schedules cleanup_bh, but migratio=
n_shutdown is called
>> =C2=A0>> =C2=A0+ * from the end of main, so cleanu_up may not be calle=
d because main-loop is
>> =C2=A0>> =C2=A0+ * complete. So, wait for the complition of migration_=
thread, cancel bh and
>> =C2=A0>> =C2=A0+ * call cleanup ourselves.
>> =C2=A0>> =C2=A0+ */
>> =C2=A0>
>> =C2=A0> (Some typos)
>> =C2=A0>
>> =C2=A0Ok :)
>>
>> =C2=A0>> =C2=A0+ migrate_join_thread(current_migration);
>> =C2=A0>
>> =C2=A0> I'll admit to being a bit nervous that something in here could=
 be
>> =C2=A0> hanging and thus we could hang here rather than die as SIGTERM=
 is
>> =C2=A0> expecting us to.
>> =C2=A0>
>> =C2=A0I think it's only way to be sure we havn't other races with migr=
ation_thread.
>> =C2=A0And this joining is cheaper than vm_shutdown IMHO.
>>
>> =C2=A0>> =C2=A0+ if (current_migration->cleanup_bh) {
>> =C2=A0>> =C2=A0+ qemu_bh_cancel(current_migration->cleanup_bh);
>> =C2=A0>
>> =C2=A0> Is that needed? Doesn't migrate_fd_cleanup start with a qemu_b=
h_delete?
>> =C2=A0>
>> =C2=A0Agree, it's odd.
>>
>> =C2=A0>> =C2=A0+ migrate_fd_cleanup(current_migration);
>> =C2=A0>> =C2=A0+ }
>> =C2=A0>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0object_unref(OBJECT(curre=
nt_migration));
>> =C2=A0>> =C2=A0=C2=A0}
>> =C2=A0>>
>> =C2=A0>> =C2=A0@@ -1495,6 +1508,16 @@ static void block_cleanup_parame=
ters(MigrationState *s)
>> =C2=A0>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>> =C2=A0>> =C2=A0=C2=A0}
>> =C2=A0>>
>> =C2=A0>> =C2=A0+static void migrate_join_thread(MigrationState *s)
>> =C2=A0>> =C2=A0+{
>> =C2=A0>> =C2=A0+ qemu_mutex_unlock_iothread();
>> =C2=A0>> =C2=A0+ if (s->migration_thread_running) {
>> =C2=A0>> =C2=A0+ qemu_thread_join(&s->thread);
>> =C2=A0>> =C2=A0+ s->migration_thread_running =3D false;
>> =C2=A0>> =C2=A0+ }
>> =C2=A0>> =C2=A0+ qemu_mutex_lock_iothread();
>> =C2=A0>> =C2=A0+}
>> =C2=A0>> =C2=A0+
>> =C2=A0>> =C2=A0=C2=A0static void migrate_fd_cleanup(void *opaque)
>> =C2=A0>> =C2=A0=C2=A0{
>> =C2=A0>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0MigrationState *s =3D opa=
que;
>> =C2=A0>> =C2=A0@@ -1508,12 +1531,7 @@ static void migrate_fd_cleanup(v=
oid *opaque)
>> =C2=A0>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Q=
EMUFile *tmp;
>> =C2=A0>>
>> =C2=A0>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0t=
race_migrate_fd_cleanup();
>> =C2=A0>> =C2=A0- qemu_mutex_unlock_iothread();
>> =C2=A0>> =C2=A0- if (s->migration_thread_running) {
>> =C2=A0>> =C2=A0- qemu_thread_join(&s->thread);
>> =C2=A0>> =C2=A0- s->migration_thread_running =3D false;
>> =C2=A0>> =C2=A0- }
>> =C2=A0>> =C2=A0- qemu_mutex_lock_iothread();
>> =C2=A0>> =C2=A0+ migrate_join_thread(s);
>> =C2=A0>>
>> =C2=A0>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0m=
ultifd_save_cleanup();
>> =C2=A0>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0q=
emu_mutex_lock(&s->qemu_file_lock);
>> =C2=A0>
>> =C2=A0> Dave
>> =C2=A0>
>> =C2=A0>> =C2=A0--
>> =C2=A0>> =C2=A02.21.0
>> =C2=A0> --
>> =C2=A0> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

