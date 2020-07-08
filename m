Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A478C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 08:38:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41D4C21D6C
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 08:38:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="it852fZb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41D4C21D6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jt5af-0003b5-GD
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 04:38:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53636)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <susiting@bytedance.com>)
 id 1jt1NC-0005fO-6y
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 00:07:54 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:45351)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <susiting@bytedance.com>)
 id 1jt1N4-0003CL-CZ
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 00:07:49 -0400
Received: by mail-pg1-x542.google.com with SMTP id l63so21003968pge.12
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 21:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:mime-version:subject:message-id:date:cc:to;
 bh=pkwsKfhwDmrpiyDAEDGHaOYsOVDUjSaeyenfsXf1fA4=;
 b=it852fZbp25aUNuVuere2rFWym0MNMyCXSMmvJbxFrNmyoi9acF8iyysKRVrU9+GlC
 fQ1muYZ3IvL6X0T+saVFVj/YcFpzqqN6On4ZVTlf+81K2FA+xMAQ8JB6m2o2E5b0+g9s
 MVDP/E2mqVr0bMMaadPxwqpEQ5JNz9Ob0aJsNmomwM4X4jXROUkYJtOFc7FHs/9CwycA
 tbEOFnoukapBhhZRWXa6oiPcLpfPFYuF1E9MRDYD5RBy//sE06QnDNspL+9MO9ix1q5Y
 2uyv+f8Y+WUMl9ZtXTmnPFS/0YsE1FnRRMOd+N3Mzlmy6eCKUP3jjwA7WkhiZtv5CBKv
 NOgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:mime-version:subject:message-id:date:cc:to;
 bh=pkwsKfhwDmrpiyDAEDGHaOYsOVDUjSaeyenfsXf1fA4=;
 b=R3UXfbyCHW7k71x9E7Vs04yE9FbTxvWXN6yU8VKgpEYv6l37tcezHengKR9HamU0tk
 /jwrvmQ9ZMykupWLXbHVn1TIw6BeKk1ez7weP0+JPks5XxjJEpOlAoxPJhWnLW02Y1KI
 2tPHjgpZZBGmDsj87JvOZTV26jXFwgUiO0x9UfTfZjAnV0OyKai0uTO1lIbnEev2Cwdl
 8AMyFL97JmB4NmtcVmwqPFsCcuNBacUgxdNS5d/lwsdYPX6lUaWfA59xtmWesmptb2EI
 FwfnriOJbZxeBZbM+jTZ5f9jO/OcoNDZRvYZ6Aa/2YBn+DYDZ4xV4mgGgtmQGqLeAJqA
 e1Jg==
X-Gm-Message-State: AOAM531Tk8+3f3QUM4ZAsZ0C6fyCZSUH/MA7DEkSsuitkjdeowQiD9s9
 KWXQUXBR2OUjVsZZwoPSZOEmBg==
X-Google-Smtp-Source: ABdhPJzrqICj6qOWPPrQntCdKYH5Hl0YxMBR0ChAb83AvtBQn54Ig6kUTgaAGwb1gGaWeKVo0aCRag==
X-Received: by 2002:a63:b511:: with SMTP id y17mr46959468pge.425.1594181263701; 
 Tue, 07 Jul 2020 21:07:43 -0700 (PDT)
Received: from [10.94.81.213] ([103.136.220.68])
 by smtp.gmail.com with ESMTPSA id f132sm23629480pfa.122.2020.07.07.21.07.39
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 07 Jul 2020 21:07:43 -0700 (PDT)
From: =?gb2312?B?y9XLvObD?= <susiting@bytedance.com>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_110C1946-0FD0-4609-A383-653CC8A7192A"
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Qemu core dump when stop guest with virtio-blk(remote storage) and
 iothread
Message-Id: <26A897E7-7AAC-4A5B-B004-681602F298C0@bytedance.com>
Date: Wed, 8 Jul 2020 12:07:29 +0800
To: famz@redhat.com, mreitz@redhat.com, kwolf@redhat.com, mst@redhat.com,
 stefanha@redhat.com
X-Mailer: Apple Mail (2.3445.104.11)
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=susiting@bytedance.com; helo=mail-pg1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 23
X-Spam_score: 2.3
X-Spam_bar: ++
X-Spam_report: (2.3 / 5.0 requ) BAYES_00=-1.9, CHARSET_FARAWAY_HEADER=3.2,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, HTML_MESSAGE=0.001, MANY_SPAN_IN_TEXT=1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 08 Jul 2020 04:37:11 -0400
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Apple-Mail=_110C1946-0FD0-4609-A383-653CC8A7192A
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Description of problem:
	Qemu core dump when stop guest with virtio-blk(remote storage) =
and iothread

Version-Release number pf selected component (if applicable):
	kernel version:4.19.36.bsk.9-amd64
	qemu-kvm version:QEMU emulator version 2.12.1

How reproducible:
	100%

Steps to Reproduce:
1. Start guest, one virtio-blk(remote storage) and iothread parameter
	/data00/qemu/x86_64-softmmu/qemu-system-x86_64
	-name guest=3Dinstance-03,debug-threads=3Don
	-kvm /dev/kvm=20
	-S
	-object =
secret,id=3DmasterKey0,format=3Draw,file=3D/var/lib/libvirt/qemu/domain-21=
-instance-03/master-key.aes=20
	-machine pc-i440fx-2.12,accel=3Dkvm,usb=3Doff,dump-guest-core=3Dof=
f=20
	-cpu qemu64,+kvm_pv_eoi=20
	-m 7630=20
	-mem-prealloc -mem-path =
/dev/hugepages/libvirt/qemu/21-instance-03 -smp =
4,sockets=3D4,cores=3D1,threads=3D1=20
	-object iothread,id=3Diothread1 -object iothread,id=3Diothread2 =
-object iothread,id=3Diothread3 -object iothread,id=3Diothread4
	-no-user-config=20
	-nodefaults=20
	-chardev socket,id=3Dcharmonitor,fd=3D21,server,nowait=20
	-mon chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol=20
	-rtc base=3Dutc,driftfix=3Dslew=20
	-global kvm-pit.lost_tick_policy=3Ddelay -no-hpet -no-shutdown=20=

	-boot strict=3Don -device =
piix3-usb-uhci,id=3Dusb,bus=3Dpci.0,addr=3D0x1.0x2=20
	-device virtio-serial-pci,id=3Dvirtio-serial0,bus=3Dpci.0,addr=3D0=
x7=20
	-drive file=3Dremote drive =
path,format=3Draw,if=3Dnone,id=3Ddrive-virtio-disk0,cache=3Dnone,aio=3Dnat=
ive,throttling.bps-read=3D30000000,throttling.bps-write=3D80000000,throttl=
ing.iops-read=3D800,throttling.iops-write=3D400=20
	-device =
virtio-blk-pci,iothread=3Diothread1,scsi=3Doff,bus=3Dpci.0,addr=3D0x3,driv=
e=3Ddrive-virtio-disk0,id=3Dvirtio-disk0,bootindex=3D1,write-cache=3Don
	-chardev pty,id=3Dcharserial0 -device =
isa-serial,chardev=3Dcharserial0,id=3Dserial0=20
	-device usb-tablet,id=3Dinput0,bus=3Dusb.0,port=3D1 -vnc =
0.0.0.0:0 -k en-us -device cirrus-vga,id=3Dvideo0,bus=3Dpci.0,addr=3D0x2=20=

	-device virtio-balloon-pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x8 =
-sandbox =
on,obsolete=3Ddeny,elevateprivileges=3Ddeny,spawn=3Ddeny,resourcecontrol=3D=
deny=20
	-device pvpanic,ioport=3D1285 -msg timestamp=3Don -d =
int,unimp,guest_errors
2.stop guest and start guest repeatedly=20
	virsh qemu-monitor-command --domain instance-03 =
'{"execute":"stop", "arguments":{}}'
	virsh qemu-monitor-command --domain instance-03 =
'{"execute":"cont", "arguments":{}}'

3.Actual results:
   Qemu core dump with error msg:
   	(qemu) qemu: qemu_mutex_unlock_impl: Operation not permitted
   Expected results:
   Guest can stop and start successfully

Additional info:
[Current thread is 1 (Thread 0x7ff188abb700 (LWP 2229116))]
(gdb) bt
#0  __GI_raise (sig=3Dsig@entry=3D6) at =
../sysdeps/unix/sysv/linux/raise.c:51
#1  0x00007ff19d73542a in __GI_abort () at abort.c:89
#2  0x0000560d55a3ca65 in error_exit (err=3Derr@entry=3D1, =
msg=3Dmsg@entry=3D0x560d566e9650 <__func__.18241> =
"qemu_mutex_unlock_impl") at util/qemu-thread-posix.c:37
#3  0x0000560d55e76dc8 in qemu_mutex_unlock_impl =
(mutex=3Dmutex@entry=3D0x560d58456e30, file=3Dfile@entry=3D0x560d566e87df =
"util/async.c", line=3Dline@entry=3D509) at util/qemu-thread-posix.c:99
#4  0x0000560d55e71580 in aio_context_release (ctx=3D0x560d58456dd0) at =
util/async.c:509
#5  0x0000560d55acf344 in virtio_blk_rw_complete (opaque=3D<optimized =
out>, ret=3D0) at /data00/susieqemu/hw/block/virtio-blk.c:126
#6  0x0000560d55dcabc9 in blk_aio_complete (acb=3D0x7ff17c001bf0) at =
block/block-backend.c:1345
#7  0x0000560d55e8a25b in coroutine_trampoline (i0=3D<optimized out>, =
i1=3D<optimized out>) at util/coroutine-ucontext.c:116
#8  0x00007ff19d745000 in ?? () from /lib/x86_64-linux-gnu/libc.so.6
#9  0x00007ffd3691e190 in ?? ()
#10 0x0000000000000000 in ?? ()
Backtrace stopped: Cannot access memory at address 0x7fef29cdd000

Thread 3 (Thread 0x7ff1a38f23c0 (LWP 2229113)):
#0  memory_region_ioeventfd_before (a=3D..., b=3D...) at =
/data00/susieqemu/memory.c:185
#1  address_space_add_del_ioeventfds (fds_old_nb=3D65, =
fds_old=3D0x560d59733960, fds_new_nb=3D64, fds_new=3D0x560d59ba6d10, =
as=3D0x560d598728b0) at /data00/susieqemu/memory.c:794
#2  address_space_update_ioeventfds (as=3Das@entry=3D0x560d598728b0) at =
/data00/susieqemu/memory.c:877
#3  0x0000560d55aabd98 in memory_region_transaction_commit () at =
/data00/susieqemu/memory.c:1080
#4  0x0000560d55aae260 in memory_region_del_eventfd =
(mr=3Dmr@entry=3D0x560d599a2b40, addr=3D<optimized out>, =
size=3Dsize@entry=3D0, match_data=3D<optimized out>, data=3D<optimized =
out>, e=3D<optimized out>) at /data00/susieqemu/memory.c:2274
#5  0x0000560d55d113da in virtio_pci_ioeventfd_assign (d=3D0x560d599a1e70,=
 notifier=3D0x560d599db8d8, n=3D0, assign=3D<optimized out>) at =
hw/virtio/virtio-pci.c:268
#6  0x0000560d55d14fef in virtio_bus_set_host_notifier =
(bus=3D0x560d599a9f68, n=3Dn@entry=3D0, assign=3Dassign@entry=3Dfalse) =
at hw/virtio/virtio-bus.c:289
#7  0x0000560d55ad2886 in virtio_blk_data_plane_stop (vdev=3D<optimized =
out>) at /data00/susieqemu/hw/block/dataplane/virtio-blk.c:295
#8  0x0000560d55d1459e in virtio_bus_stop_ioeventfd (bus=3D0x560d599a9f68)=
 at hw/virtio/virtio-bus.c:246
#9  0x0000560d55b02c4f in virtio_vmstate_change (opaque=3D0x560d599a9fe0, =
running=3D0, state=3DRUN_STATE_PAUSED) at =
/data00/susieqemu/hw/virtio/virtio.c:2236
#10 0x0000560d55ba2517 in vm_state_notify (running=3Drunning@entry=3D0, =
state=3Dstate@entry=3DRUN_STATE_PAUSED) at vl.c:1649
#11 0x0000560d55a95c3a in do_vm_stop =
(state=3Dstate@entry=3DRUN_STATE_PAUSED, send_stop=3Dsend_stop@entry=3Dtru=
e) at /data00/susieqemu/cpus.c:1013
#12 0x0000560d55a96132 in vm_stop (state=3Dstate@entry=3DRUN_STATE_PAUSED)=
 at /data00/susieqemu/cpus.c:2036
#13 0x0000560d55bb652b in qmp_stop (errp=3Derrp@entry=3D0x7ffd3691e9b0) =
at qmp.c:106
#14 0x0000560d55bae9aa in qmp_marshal_stop (args=3D<optimized out>, =
ret=3D<optimized out>, errp=3D0x7ffd3691e9f8) at =
qapi/qapi-commands-misc.c:784
#15 0x0000560d55e65f89 in do_qmp_dispatch (errp=3D0x7ffd3691e9f0, =
request=3D0x7ffd3691e9f0, cmds=3D<optimized out>) at =
qapi/qmp-dispatch.c:111
#16 qmp_dispatch (cmds=3D<optimized out>, =
request=3Drequest@entry=3D0x560d58467e60) at qapi/qmp-dispatch.c:164
#17 0x0000560d55a9e95d in monitor_qmp_dispatch_one =
(req_obj=3Dreq_obj@entry=3D0x560d587b5a20) at =
/data00/susieqemu/monitor.c:4084
#18 0x0000560d55a9ec99 in monitor_qmp_bh_dispatcher (data=3D<optimized =
out>) at /data00/susieqemu/monitor.c:4142
#19 0x0000560d55e70e2e in aio_bh_call (bh=3D0x560d58472a20) at =
util/async.c:91
#20 aio_bh_poll (ctx=3Dctx@entry=3D0x560d584569e0) at util/async.c:119
#21 0x0000560d55e7470f in aio_dispatch (ctx=3D0x560d584569e0) at =
util/aio-posix.c:456
#22 0x0000560d55e70ced in aio_ctx_dispatch (source=3D<optimized out>, =
callback=3D<optimized out>, user_data=3D<optimized out>) at =
util/async.c:262
#23 0x00007ff1a0d087f7 in g_main_context_dispatch () from =
/lib/x86_64-linux-gnu/libglib-2.0.so.0
#24 0x0000560d55e737d8 in glib_pollfds_poll () at util/main-loop.c:217
#25 os_host_main_loop_wait (timeout=3D<optimized out>) at =
util/main-loop.c:265
#26 main_loop_wait (nonblocking=3D<optimized out>) at =
util/main-loop.c:524
#27 0x0000560d55a41ff7 in main_loop () at vl.c:1980
#28 main (argc=3D<optimized out>, argv=3D<optimized out>, =
envp=3D<optimized out>) at vl.c:4845

This is because in the virtio_blk_dataplane_stop() function, the context =
of the iothread will be set to the maincontext in blk_set_aio_context(). =
In the middle of this context change, the iothread will acquire the =
original iothread context which is held by the main thread. After the =
mainthread change the context of the iothread and then release the =
original iothread context, the iothread will get the old iothread =
context which is not supposed to happen because the context has been =
changed to the main thread context. So when the iothread finish =
virtio_blk_rw_complete() and try to release the main thread context, =
qemu will crash.

This patch can solve this problem for me, but I am not sure whether this =
is right, please give me a hand.

diff --git a/block/.block-backend.c.swp b/block/.block-backend.c.swp
deleted file mode 100644
index 0bf897dd..00000000
Binary files a/block/.block-backend.c.swp and /dev/null differ
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index b9c1b3ba..d8ac782d 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -91,7 +91,12 @@ static void virtio_blk_rw_complete(void *opaque, int =
ret)
     VirtIOBlock *s =3D next->dev;
     VirtIODevice *vdev =3D VIRTIO_DEVICE(s);
     QEMU_LOG(LOG_INFO, "virtio_blk_rw_complete before context_acquire: =
%p\n", (blk_get_aio_context(s->conf.conf.blk)));
-    aio_context_acquire(blk_get_aio_context(s->conf.conf.blk));
+    static struct timespec ts_sleep;
+    ts_sleep.tv_sec =3D 0;
+    ts_sleep.tv_nsec =3D 50 * 1000 * 1000ull;
+    while =
(aio_context_tryacquire(blk_get_aio_context(s->conf.conf.blk))) {
+        nanosleep(&ts_sleep, NULL);
+    }
     while (next) {
         VirtIOBlockReq *req =3D next;
         next =3D req->mr_next;
diff --git a/include/block/aio.h b/include/block/aio.h
index a1d6b9e2..59be498f 100644
--- a/include/block/aio.h
+++ b/include/block/aio.h
@@ -174,6 +174,8 @@ void aio_context_ref(AioContext *ctx);
  */
 void aio_context_unref(AioContext *ctx);
=20
+int aio_context_tryacquire(AioContext *ctx);
+
 /* Take ownership of the AioContext.  If the AioContext will be shared =
between
  * threads, and a thread does not want to be interrupted, it will have =
to
  * take ownership around calls to aio_poll().  Otherwise, aio_poll()
diff --git a/util/async.c b/util/async.c
index 27fb4901..009f6c5f 100644
--- a/util/async.c
+++ b/util/async.c
@@ -498,6 +498,10 @@ void aio_context_unref(AioContext *ctx)
     g_source_unref(&ctx->source);
 }
=20
+int aio_context_acquire(AioContext *ctx) {
+    return qemu_rec_mutex_trylock(&ctx->lock);
+}
+
 void aio_context_acquire(AioContext *ctx)
 {
     qemu_rec_mutex_lock(&ctx->lock);



--Apple-Mail=_110C1946-0FD0-4609-A383-653CC8A7192A
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=us-ascii

<html><body style=3D"word-wrap: break-word; -webkit-nbsp-mode: space; =
-webkit-line-break: after-white-space;" class=3D""><div style=3D"margin: =
0px; font-stretch: normal; line-height: normal; font-family: =
&quot;Helvetica Neue&quot;;" class=3D"">Description of =
problem:</div><div style=3D"margin: 0px; font-stretch: normal; =
line-height: normal; font-family: &quot;Helvetica Neue&quot;;" =
class=3D""><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>Qemu core dump when stop guest with virtio-blk<span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">(</span>remote storage<span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">)</span> and iothread</div><div =
style=3D"margin: 0px; font-stretch: normal; line-height: normal; =
font-family: &quot;Helvetica Neue&quot;; min-height: 14px;" class=3D""><br=
 class=3D""></div><div style=3D"margin: 0px; font-stretch: normal; =
line-height: normal; font-family: &quot;Helvetica Neue&quot;;" =
class=3D"">Version-Release number pf selected component <span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">(</span>if applicable<span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">)</span>:</div><div style=3D"margin:=
 0px; font-stretch: normal; line-height: normal; font-family: =
&quot;Helvetica Neue&quot;;" class=3D""><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>kernel =
version:4.19.36.bsk.9-amd64</div><div style=3D"margin: 0px; =
font-stretch: normal; line-height: normal; font-family: &quot;Helvetica =
Neue&quot;;" class=3D""><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>qemu-kvm version:QEMU emulator =
version 2.12.1</div><div style=3D"margin: 0px; font-stretch: normal; =
line-height: normal; font-family: &quot;Helvetica Neue&quot;; =
min-height: 14px;" class=3D""><br class=3D""></div><div style=3D"margin: =
0px; font-stretch: normal; line-height: normal; font-family: =
&quot;Helvetica Neue&quot;;" class=3D"">How reproducible:</div><div =
style=3D"margin: 0px; font-stretch: normal; line-height: normal; =
font-family: &quot;Helvetica Neue&quot;;" class=3D""><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>100%</div><div style=3D"margin: 0px; font-stretch: normal; =
line-height: normal; font-family: &quot;Helvetica Neue&quot;; =
min-height: 14px;" class=3D""><br class=3D""></div><div style=3D"margin: =
0px; font-stretch: normal; line-height: normal; font-family: =
&quot;Helvetica Neue&quot;;" class=3D"">Steps to Reproduce:</div><div =
style=3D"margin: 0px; font-stretch: normal; line-height: normal; =
font-family: &quot;Helvetica Neue&quot;;" class=3D"">1. Start guest<span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">,</span> one virtio-blk<span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">(</span>remote storage<span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">)</span> and iothread =
parameter</div><div style=3D"margin: 0px; font-stretch: normal; =
line-height: normal; font-family: &quot;Helvetica Neue&quot;;" =
class=3D""><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>/data00/qemu/x86_64-softmmu/qemu-system-x86_64</div><div =
style=3D"margin: 0px; font-stretch: normal; line-height: normal; =
font-family: &quot;Helvetica Neue&quot;;" class=3D""><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>-name =
guest=3Dinstance-03<span style=3D"font-stretch: normal; line-height: =
normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">,</span>debug-threads=3Don</div><div style=3D"margin: 0px; =
font-stretch: normal; line-height: normal; font-family: &quot;Helvetica =
Neue&quot;;" class=3D""><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>-kvm /dev/kvm&nbsp;</div><div =
style=3D"margin: 0px; font-stretch: normal; line-height: normal; =
font-family: &quot;Helvetica Neue&quot;;" class=3D""><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>-S</div><div style=3D"margin: 0px; font-stretch: normal; =
line-height: normal; font-family: &quot;Helvetica Neue&quot;;" =
class=3D""><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>-object secret<span style=3D"font-stretch: normal; line-height: =
normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">,</span>id=3DmasterKey0<span style=3D"font-stretch: normal; =
line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">,</span>format=3Draw<span style=3D"font-stretch: normal; =
line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">,</span>file=3D/var/lib/libvirt/qemu/domain-21-instance-03/mast=
er-key.aes&nbsp;</div><div style=3D"margin: 0px; font-stretch: normal; =
line-height: normal; font-family: &quot;Helvetica Neue&quot;;" =
class=3D""><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>-machine pc-i440fx-2.12<span style=3D"font-stretch: normal; =
line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">,</span>accel=3Dkvm<span style=3D"font-stretch: normal; =
line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">,</span>usb=3Doff<span style=3D"font-stretch: normal; =
line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">,</span>dump-guest-core=3Doff&nbsp;</div><div style=3D"margin: =
0px; font-stretch: normal; line-height: normal; font-family: =
&quot;Helvetica Neue&quot;;" class=3D""><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>-cpu qemu64<span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">,</span>+kvm_pv_eoi&nbsp;</div><div =
style=3D"margin: 0px; font-stretch: normal; line-height: normal; =
font-family: &quot;Helvetica Neue&quot;;" class=3D""><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>-m =
7630&nbsp;</div><div style=3D"margin: 0px; font-stretch: normal; =
line-height: normal; font-family: &quot;Helvetica Neue&quot;;" =
class=3D""><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>-mem-prealloc -mem-path =
/dev/hugepages/libvirt/qemu/21-instance-03 -smp 4<span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">,</span>sockets=3D4<span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">,</span>cores=3D1<span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">,</span>threads=3D1&nbsp;</div><div =
style=3D"margin: 0px; font-stretch: normal; line-height: normal; =
font-family: &quot;Helvetica Neue&quot;;" class=3D""><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>-object =
iothread<span style=3D"font-stretch: normal; line-height: normal; =
font-family: &quot;.PingFang SC&quot;;" class=3D"">,</span>id=3Diothread1 =
-object iothread<span style=3D"font-stretch: normal; line-height: =
normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">,</span>id=3Diothread2 -object iothread<span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">,</span>id=3Diothread3 -object =
iothread<span style=3D"font-stretch: normal; line-height: normal; =
font-family: &quot;.PingFang SC&quot;;" =
class=3D"">,</span>id=3Diothread4</div><div style=3D"margin: 0px; =
font-stretch: normal; line-height: normal; font-family: &quot;Helvetica =
Neue&quot;;" class=3D""><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>-no-user-config&nbsp;</div><div =
style=3D"margin: 0px; font-stretch: normal; line-height: normal; =
font-family: &quot;Helvetica Neue&quot;;" class=3D""><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>-nodefaults&nbsp;</div><div style=3D"margin: 0px; font-stretch: =
normal; line-height: normal; font-family: &quot;Helvetica Neue&quot;;" =
class=3D""><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>-chardev socket<span style=3D"font-stretch: normal; line-height: =
normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">,</span>id=3Dcharmonitor<span style=3D"font-stretch: normal; =
line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">,</span>fd=3D21<span style=3D"font-stretch: normal; =
line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">,</span>server<span style=3D"font-stretch: normal; =
line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">,</span>nowait&nbsp;</div><div style=3D"margin: 0px; =
font-stretch: normal; line-height: normal; font-family: &quot;Helvetica =
Neue&quot;;" class=3D""><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>-mon chardev=3Dcharmonitor<span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">,</span>id=3Dmonitor<span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">,</span>mode=3Dcontrol&nbsp;</div><d=
iv style=3D"margin: 0px; font-stretch: normal; line-height: normal; =
font-family: &quot;Helvetica Neue&quot;;" class=3D""><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>-rtc =
base=3Dutc<span style=3D"font-stretch: normal; line-height: normal; =
font-family: &quot;.PingFang SC&quot;;" =
class=3D"">,</span>driftfix=3Dslew&nbsp;</div><div style=3D"margin: 0px; =
font-stretch: normal; line-height: normal; font-family: &quot;Helvetica =
Neue&quot;;" class=3D""><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>-global =
kvm-pit.lost_tick_policy=3Ddelay -no-hpet -no-shutdown&nbsp;</div><div =
style=3D"margin: 0px; font-stretch: normal; line-height: normal; =
font-family: &quot;Helvetica Neue&quot;;" class=3D""><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>-boot =
strict=3Don -device piix3-usb-uhci<span style=3D"font-stretch: normal; =
line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">,</span>id=3Dusb<span style=3D"font-stretch: normal; =
line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">,</span>bus=3Dpci.0<span style=3D"font-stretch: normal; =
line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">,</span>addr=3D0x1.0x2&nbsp;</div><div style=3D"margin: 0px; =
font-stretch: normal; line-height: normal; font-family: &quot;Helvetica =
Neue&quot;;" class=3D""><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>-device virtio-serial-pci<span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">,</span>id=3Dvirtio-serial0<span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">,</span>bus=3Dpci.0<span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">,</span>addr=3D0x7&nbsp;</div><div =
style=3D"margin: 0px; font-stretch: normal; line-height: normal; =
font-family: &quot;Helvetica Neue&quot;;" class=3D""><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>-drive =
file=3Dremote drive path<span style=3D"font-stretch: normal; =
line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">,</span>format=3Draw<span style=3D"font-stretch: normal; =
line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">,</span>if=3Dnone<span style=3D"font-stretch: normal; =
line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">,</span>id=3Ddrive-virtio-disk0<span style=3D"font-stretch: =
normal; line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">,</span>cache=3Dnone<span style=3D"font-stretch: normal; =
line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">,</span>aio=3Dnative<span style=3D"font-stretch: normal; =
line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">,</span>throttling.bps-read=3D30000000<span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" =
class=3D"">,</span>throttling.bps-write=3D80000000<span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" =
class=3D"">,</span>throttling.iops-read=3D800<span style=3D"font-stretch: =
normal; line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">,</span>throttling.iops-write=3D400&nbsp;</div><div =
style=3D"margin: 0px; font-stretch: normal; line-height: normal; =
font-family: &quot;Helvetica Neue&quot;;" class=3D""><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>-device =
virtio-blk-pci<span style=3D"font-stretch: normal; line-height: normal; =
font-family: &quot;.PingFang SC&quot;;" =
class=3D"">,</span>iothread=3Diothread1<span style=3D"font-stretch: =
normal; line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">,</span>scsi=3Doff<span style=3D"font-stretch: normal; =
line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">,</span>bus=3Dpci.0<span style=3D"font-stretch: normal; =
line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">,</span>addr=3D0x3<span style=3D"font-stretch: normal; =
line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">,</span>drive=3Ddrive-virtio-disk0<span style=3D"font-stretch: =
normal; line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">,</span>id=3Dvirtio-disk0<span style=3D"font-stretch: normal; =
line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">,</span>bootindex=3D1<span style=3D"font-stretch: normal; =
line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">,</span>write-cache=3Don</div><div style=3D"margin: 0px; =
font-stretch: normal; line-height: normal; font-family: &quot;Helvetica =
Neue&quot;;" class=3D""><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>-chardev pty<span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">,</span>id=3Dcharserial0 -device =
isa-serial<span style=3D"font-stretch: normal; line-height: normal; =
font-family: &quot;.PingFang SC&quot;;" =
class=3D"">,</span>chardev=3Dcharserial0<span style=3D"font-stretch: =
normal; line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">,</span>id=3Dserial0&nbsp;</div><div style=3D"margin: 0px; =
font-stretch: normal; line-height: normal; font-family: &quot;Helvetica =
Neue&quot;;" class=3D""><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>-device usb-tablet<span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">,</span>id=3Dinput0<span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">,</span>bus=3Dusb.0<span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">,</span>port=3D1 -vnc 0.0.0.0:0 -k =
en-us -device cirrus-vga<span style=3D"font-stretch: normal; =
line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">,</span>id=3Dvideo0<span style=3D"font-stretch: normal; =
line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">,</span>bus=3Dpci.0<span style=3D"font-stretch: normal; =
line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">,</span>addr=3D0x2&nbsp;</div><div style=3D"margin: 0px; =
font-stretch: normal; line-height: normal; font-family: &quot;Helvetica =
Neue&quot;;" class=3D""><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>-device virtio-balloon-pci<span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">,</span>id=3Dballoon0<span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">,</span>bus=3Dpci.0<span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">,</span>addr=3D0x8 -sandbox =
on<span style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">,</span>obsolete=3Ddeny<span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">,</span>elevateprivileges=3Ddeny<spa=
n style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">,</span>spawn=3Ddeny<span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" =
class=3D"">,</span>resourcecontrol=3Ddeny&nbsp;</div><div style=3D"margin:=
 0px; font-stretch: normal; line-height: normal; font-family: =
&quot;Helvetica Neue&quot;;" class=3D""><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>-device pvpanic<span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">,</span>ioport=3D1285 -msg =
timestamp=3Don -d int<span style=3D"font-stretch: normal; line-height: =
normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">,</span>unimp<span style=3D"font-stretch: normal; =
line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">,</span>guest_errors</div><div style=3D"margin: 0px; =
font-stretch: normal; line-height: normal; font-family: &quot;Helvetica =
Neue&quot;;" class=3D"">2.stop guest and start guest =
repeatedly&nbsp;</div><div style=3D"margin: 0px; font-stretch: normal; =
line-height: normal; font-family: &quot;Helvetica Neue&quot;;" =
class=3D""><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>virsh qemu-monitor-command --domain instance-03 =
'{"execute":"stop"<span style=3D"font-stretch: normal; line-height: =
normal; font-family: &quot;.PingFang SC&quot;;" class=3D"">,</span> =
"arguments":{}}'</div><div style=3D"margin: 0px; font-stretch: normal; =
line-height: normal; font-family: &quot;Helvetica Neue&quot;;" =
class=3D""><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>virsh qemu-monitor-command --domain instance-03 =
'{"execute":"cont"<span style=3D"font-stretch: normal; line-height: =
normal; font-family: &quot;.PingFang SC&quot;;" class=3D"">,</span> =
"arguments":{}}'</div><div style=3D"margin: 0px; font-stretch: normal; =
line-height: normal; font-family: &quot;Helvetica Neue&quot;; =
min-height: 14px;" class=3D""><br class=3D""></div><div style=3D"margin: =
0px; font-stretch: normal; line-height: normal; font-family: =
&quot;Helvetica Neue&quot;;" class=3D"">3.Actual results:</div><div =
style=3D"margin: 0px; font-stretch: normal; line-height: normal; =
font-family: &quot;Helvetica Neue&quot;;" class=3D"">&nbsp;&nbsp; Qemu =
core dump with error msg:</div><div style=3D"margin: 0px; font-stretch: =
normal; line-height: normal; font-family: &quot;Helvetica Neue&quot;;" =
class=3D"">&nbsp;&nbsp; <span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span style=3D"font-stretch: =
normal; line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">(</span>qemu<span style=3D"font-stretch: normal; line-height: =
normal; font-family: &quot;.PingFang SC&quot;;" class=3D"">)</span> =
qemu: qemu_mutex_unlock_impl: Operation not permitted</div><div =
style=3D"margin: 0px; font-stretch: normal; line-height: normal; =
font-family: &quot;Helvetica Neue&quot;;" class=3D"">&nbsp;&nbsp; =
Expected results:</div><div style=3D"margin: 0px; font-stretch: normal; =
line-height: normal; font-family: &quot;Helvetica Neue&quot;;" =
class=3D"">&nbsp;&nbsp; Guest can stop and start successfully</div><div =
style=3D"margin: 0px; font-stretch: normal; line-height: normal; =
font-family: &quot;Helvetica Neue&quot;; min-height: 14px;" class=3D""><br=
 class=3D""></div><div style=3D"margin: 0px; font-stretch: normal; =
line-height: normal; font-family: &quot;Helvetica Neue&quot;;" =
class=3D"">Additional info:</div><div style=3D"margin: 0px; =
font-stretch: normal; line-height: normal; font-family: &quot;Helvetica =
Neue&quot;;" class=3D""><span style=3D"font-stretch: normal; =
line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">[</span>Current thread is 1 <span style=3D"font-stretch: =
normal; line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">(</span>Thread 0x7ff188abb700 <span style=3D"font-stretch: =
normal; line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">(</span>LWP 2229116<span style=3D"font-stretch: normal; =
line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">))]</span></div><div style=3D"margin: 0px; font-stretch: =
normal; line-height: normal; font-family: &quot;Helvetica Neue&quot;;" =
class=3D""><span style=3D"font-stretch: normal; line-height: normal; =
font-family: &quot;.PingFang SC&quot;;" class=3D"">(</span>gdb<span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">)</span> bt</div><div =
style=3D"margin: 0px; font-stretch: normal; line-height: normal; =
font-family: &quot;Helvetica Neue&quot;;" class=3D"">#0&nbsp; __GI_raise =
<span style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">(</span>sig=3Dsig@entry=3D6<span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">)</span> at =
../sysdeps/unix/sysv/linux/raise.c:51</div><div style=3D"margin: 0px; =
font-stretch: normal; line-height: normal; font-family: &quot;Helvetica =
Neue&quot;;" class=3D"">#1&nbsp; 0x00007ff19d73542a in __GI_abort <span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">()</span> at abort.c:89</div><div =
style=3D"margin: 0px; font-stretch: normal; line-height: normal; =
font-family: &quot;Helvetica Neue&quot;;" class=3D"">#2&nbsp; =
0x0000560d55a3ca65 in error_exit <span style=3D"font-stretch: normal; =
line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">(</span>err=3Derr@entry=3D1<span style=3D"font-stretch: =
normal; line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">,</span> msg=3Dmsg@entry=3D0x560d566e9650 =
&lt;__func__.18241&gt; "qemu_mutex_unlock_impl"<span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">)</span> at =
util/qemu-thread-posix.c:37</div><div style=3D"margin: 0px; =
font-stretch: normal; line-height: normal; font-family: &quot;Helvetica =
Neue&quot;;" class=3D"">#3&nbsp; 0x0000560d55e76dc8 in =
qemu_mutex_unlock_impl <span style=3D"font-stretch: normal; line-height: =
normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">(</span>mutex=3Dmutex@entry=3D0x560d58456e30<span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">,</span> =
file=3Dfile@entry=3D0x560d566e87df "util/async.c"<span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">,</span> line=3Dline@entry=3D509<spa=
n style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">)</span> at =
util/qemu-thread-posix.c:99</div><div style=3D"margin: 0px; =
font-stretch: normal; line-height: normal; font-family: &quot;Helvetica =
Neue&quot;;" class=3D"">#4&nbsp; 0x0000560d55e71580 in =
aio_context_release <span style=3D"font-stretch: normal; line-height: =
normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">(</span>ctx=3D0x560d58456dd0<span style=3D"font-stretch: =
normal; line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">)</span> at util/async.c:509</div><div style=3D"margin: 0px; =
font-stretch: normal; line-height: normal; font-family: &quot;Helvetica =
Neue&quot;;" class=3D"">#5&nbsp; 0x0000560d55acf344 in =
virtio_blk_rw_complete <span style=3D"font-stretch: normal; line-height: =
normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">(</span>opaque=3D&lt;optimized out&gt;<span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">,</span> ret=3D0<span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">)</span> at =
/data00/susieqemu/hw/block/virtio-blk.c:126</div><div style=3D"margin: =
0px; font-stretch: normal; line-height: normal; font-family: =
&quot;Helvetica Neue&quot;;" class=3D"">#6&nbsp; 0x0000560d55dcabc9 in =
blk_aio_complete <span style=3D"font-stretch: normal; line-height: =
normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">(</span>acb=3D0x7ff17c001bf0<span style=3D"font-stretch: =
normal; line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">)</span> at block/block-backend.c:1345</div><div =
style=3D"margin: 0px; font-stretch: normal; line-height: normal; =
font-family: &quot;Helvetica Neue&quot;;" class=3D"">#7&nbsp; =
0x0000560d55e8a25b in coroutine_trampoline <span style=3D"font-stretch: =
normal; line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">(</span>i0=3D&lt;optimized out&gt;<span style=3D"font-stretch: =
normal; line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">,</span> i1=3D&lt;optimized out&gt;<span style=3D"font-stretch:=
 normal; line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">)</span> at util/coroutine-ucontext.c:116</div><div =
style=3D"margin: 0px; font-stretch: normal; line-height: normal; =
font-family: &quot;Helvetica Neue&quot;;" class=3D"">#8&nbsp; =
0x00007ff19d745000 in ?? <span style=3D"font-stretch: normal; =
line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">()</span> from /lib/x86_64-linux-gnu/libc.so.6</div><div =
style=3D"margin: 0px; font-stretch: normal; line-height: normal; =
font-family: &quot;Helvetica Neue&quot;;" class=3D"">#9&nbsp; =
0x00007ffd3691e190 in ?? <span style=3D"font-stretch: normal; =
line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">()</span></div><div style=3D"margin: 0px; font-stretch: =
normal; line-height: normal; font-family: &quot;Helvetica Neue&quot;;" =
class=3D"">#10 0x0000000000000000 in ?? <span style=3D"font-stretch: =
normal; line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">()</span></div><div style=3D"margin: 0px; font-stretch: =
normal; line-height: normal; font-family: &quot;Helvetica Neue&quot;;" =
class=3D"">Backtrace stopped: Cannot access memory at address =
0x7fef29cdd000</div><div style=3D"margin: 0px; font-stretch: normal; =
line-height: normal; font-family: &quot;Helvetica Neue&quot;; =
min-height: 14px;" class=3D""><br class=3D""></div><div style=3D"margin: =
0px; font-stretch: normal; line-height: normal; font-family: =
&quot;Helvetica Neue&quot;;" class=3D"">Thread 3 <span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">(</span>Thread 0x7ff1a38f23c0 =
<span style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">(</span>LWP 2229113<span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">))</span>:</div><div =
style=3D"margin: 0px; font-stretch: normal; line-height: normal; =
font-family: &quot;Helvetica Neue&quot;;" class=3D"">#0&nbsp; =
memory_region_ioeventfd_before <span style=3D"font-stretch: normal; =
line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">(</span>a=3D...<span style=3D"font-stretch: normal; =
line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">,</span> b=3D...<span style=3D"font-stretch: normal; =
line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">)</span> at /data00/susieqemu/memory.c:185</div><div =
style=3D"margin: 0px; font-stretch: normal; line-height: normal; =
font-family: &quot;Helvetica Neue&quot;;" class=3D"">#1&nbsp; =
address_space_add_del_ioeventfds <span style=3D"font-stretch: normal; =
line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">(</span>fds_old_nb=3D65<span style=3D"font-stretch: normal; =
line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">,</span> fds_old=3D0x560d59733960<span style=3D"font-stretch: =
normal; line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">,</span> fds_new_nb=3D64<span style=3D"font-stretch: normal; =
line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">,</span> fds_new=3D0x560d59ba6d10<span style=3D"font-stretch: =
normal; line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">,</span> as=3D0x560d598728b0<span style=3D"font-stretch: =
normal; line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">)</span> at /data00/susieqemu/memory.c:794</div><div =
style=3D"margin: 0px; font-stretch: normal; line-height: normal; =
font-family: &quot;Helvetica Neue&quot;;" class=3D"">#2&nbsp; =
address_space_update_ioeventfds <span style=3D"font-stretch: normal; =
line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">(</span>as=3Das@entry=3D0x560d598728b0<span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">)</span> at =
/data00/susieqemu/memory.c:877</div><div style=3D"margin: 0px; =
font-stretch: normal; line-height: normal; font-family: &quot;Helvetica =
Neue&quot;;" class=3D"">#3&nbsp; 0x0000560d55aabd98 in =
memory_region_transaction_commit <span style=3D"font-stretch: normal; =
line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">()</span> at /data00/susieqemu/memory.c:1080</div><div =
style=3D"margin: 0px; font-stretch: normal; line-height: normal; =
font-family: &quot;Helvetica Neue&quot;;" class=3D"">#4&nbsp; =
0x0000560d55aae260 in memory_region_del_eventfd <span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" =
class=3D"">(</span>mr=3Dmr@entry=3D0x560d599a2b40<span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">,</span> addr=3D&lt;optimized =
out&gt;<span style=3D"font-stretch: normal; line-height: normal; =
font-family: &quot;.PingFang SC&quot;;" class=3D"">,</span> =
size=3Dsize@entry=3D0<span style=3D"font-stretch: normal; line-height: =
normal; font-family: &quot;.PingFang SC&quot;;" class=3D"">,</span> =
match_data=3D&lt;optimized out&gt;<span style=3D"font-stretch: normal; =
line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">,</span> data=3D&lt;optimized out&gt;<span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">,</span> e=3D&lt;optimized =
out&gt;<span style=3D"font-stretch: normal; line-height: normal; =
font-family: &quot;.PingFang SC&quot;;" class=3D"">)</span> at =
/data00/susieqemu/memory.c:2274</div><div style=3D"margin: 0px; =
font-stretch: normal; line-height: normal; font-family: &quot;Helvetica =
Neue&quot;;" class=3D"">#5&nbsp; 0x0000560d55d113da in =
virtio_pci_ioeventfd_assign <span style=3D"font-stretch: normal; =
line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">(</span>d=3D0x560d599a1e70<span style=3D"font-stretch: =
normal; line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">,</span> notifier=3D0x560d599db8d8<span style=3D"font-stretch: =
normal; line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">,</span> n=3D0<span style=3D"font-stretch: normal; =
line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">,</span> assign=3D&lt;optimized out&gt;<span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">)</span> at =
hw/virtio/virtio-pci.c:268</div><div style=3D"margin: 0px; font-stretch: =
normal; line-height: normal; font-family: &quot;Helvetica Neue&quot;;" =
class=3D"">#6&nbsp; 0x0000560d55d14fef in virtio_bus_set_host_notifier =
<span style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">(</span>bus=3D0x560d599a9f68<span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">,</span> n=3Dn@entry=3D0<span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">,</span> =
assign=3Dassign@entry=3Dfalse<span style=3D"font-stretch: normal; =
line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">)</span> at hw/virtio/virtio-bus.c:289</div><div =
style=3D"margin: 0px; font-stretch: normal; line-height: normal; =
font-family: &quot;Helvetica Neue&quot;;" class=3D"">#7&nbsp; =
0x0000560d55ad2886 in virtio_blk_data_plane_stop <span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">(</span>vdev=3D&lt;optimized =
out&gt;<span style=3D"font-stretch: normal; line-height: normal; =
font-family: &quot;.PingFang SC&quot;;" class=3D"">)</span> at =
/data00/susieqemu/hw/block/dataplane/virtio-blk.c:295</div><div =
style=3D"margin: 0px; font-stretch: normal; line-height: normal; =
font-family: &quot;Helvetica Neue&quot;;" class=3D"">#8&nbsp; =
0x0000560d55d1459e in virtio_bus_stop_ioeventfd <span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">(</span>bus=3D0x560d599a9f68<span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">)</span> at =
hw/virtio/virtio-bus.c:246</div><div style=3D"margin: 0px; font-stretch: =
normal; line-height: normal; font-family: &quot;Helvetica Neue&quot;;" =
class=3D"">#9&nbsp; 0x0000560d55b02c4f in virtio_vmstate_change <span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">(</span>opaque=3D0x560d599a9fe0<span=
 style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">,</span> running=3D0<span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">,</span> =
state=3DRUN_STATE_PAUSED<span style=3D"font-stretch: normal; =
line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">)</span> at =
/data00/susieqemu/hw/virtio/virtio.c:2236</div><div style=3D"margin: =
0px; font-stretch: normal; line-height: normal; font-family: =
&quot;Helvetica Neue&quot;;" class=3D"">#10 0x0000560d55ba2517 in =
vm_state_notify <span style=3D"font-stretch: normal; line-height: =
normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">(</span>running=3Drunning@entry=3D0<span style=3D"font-stretch:=
 normal; line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">,</span> state=3Dstate@entry=3DRUN_STATE_PAUSED<span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">)</span> at vl.c:1649</div><div =
style=3D"margin: 0px; font-stretch: normal; line-height: normal; =
font-family: &quot;Helvetica Neue&quot;;" class=3D"">#11 =
0x0000560d55a95c3a in do_vm_stop <span style=3D"font-stretch: normal; =
line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">(</span>state=3Dstate@entry=3DRUN_STATE_PAUSED<span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">,</span> =
send_stop=3Dsend_stop@entry=3Dtrue<span style=3D"font-stretch: normal; =
line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">)</span> at /data00/susieqemu/cpus.c:1013</div><div =
style=3D"margin: 0px; font-stretch: normal; line-height: normal; =
font-family: &quot;Helvetica Neue&quot;;" class=3D"">#12 =
0x0000560d55a96132 in vm_stop <span style=3D"font-stretch: normal; =
line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">(</span>state=3Dstate@entry=3DRUN_STATE_PAUSED<span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">)</span> at =
/data00/susieqemu/cpus.c:2036</div><div style=3D"margin: 0px; =
font-stretch: normal; line-height: normal; font-family: &quot;Helvetica =
Neue&quot;;" class=3D"">#13 0x0000560d55bb652b in qmp_stop <span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" =
class=3D"">(</span>errp=3Derrp@entry=3D0x7ffd3691e9b0<span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">)</span> at qmp.c:106</div><div =
style=3D"margin: 0px; font-stretch: normal; line-height: normal; =
font-family: &quot;Helvetica Neue&quot;;" class=3D"">#14 =
0x0000560d55bae9aa in qmp_marshal_stop <span style=3D"font-stretch: =
normal; line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">(</span>args=3D&lt;optimized out&gt;<span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">,</span> ret=3D&lt;optimized =
out&gt;<span style=3D"font-stretch: normal; line-height: normal; =
font-family: &quot;.PingFang SC&quot;;" class=3D"">,</span> =
errp=3D0x7ffd3691e9f8<span style=3D"font-stretch: normal; line-height: =
normal; font-family: &quot;.PingFang SC&quot;;" class=3D"">)</span> at =
qapi/qapi-commands-misc.c:784</div><div style=3D"margin: 0px; =
font-stretch: normal; line-height: normal; font-family: &quot;Helvetica =
Neue&quot;;" class=3D"">#15 0x0000560d55e65f89 in do_qmp_dispatch <span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">(</span>errp=3D0x7ffd3691e9f0<span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">,</span> =
request=3D0x7ffd3691e9f0<span style=3D"font-stretch: normal; =
line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">,</span> cmds=3D&lt;optimized out&gt;<span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">)</span> at =
qapi/qmp-dispatch.c:111</div><div style=3D"margin: 0px; font-stretch: =
normal; line-height: normal; font-family: &quot;Helvetica Neue&quot;;" =
class=3D"">#16 qmp_dispatch <span style=3D"font-stretch: normal; =
line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">(</span>cmds=3D&lt;optimized out&gt;<span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">,</span> =
request=3Drequest@entry=3D0x560d58467e60<span style=3D"font-stretch: =
normal; line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">)</span> at qapi/qmp-dispatch.c:164</div><div style=3D"margin: =
0px; font-stretch: normal; line-height: normal; font-family: =
&quot;Helvetica Neue&quot;;" class=3D"">#17 0x0000560d55a9e95d in =
monitor_qmp_dispatch_one <span style=3D"font-stretch: normal; =
line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">(</span>req_obj=3Dreq_obj@entry=3D0x560d587b5a20<span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">)</span> at =
/data00/susieqemu/monitor.c:4084</div><div style=3D"margin: 0px; =
font-stretch: normal; line-height: normal; font-family: &quot;Helvetica =
Neue&quot;;" class=3D"">#18 0x0000560d55a9ec99 in =
monitor_qmp_bh_dispatcher <span style=3D"font-stretch: normal; =
line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">(</span>data=3D&lt;optimized out&gt;<span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">)</span> at =
/data00/susieqemu/monitor.c:4142</div><div style=3D"margin: 0px; =
font-stretch: normal; line-height: normal; font-family: &quot;Helvetica =
Neue&quot;;" class=3D"">#19 0x0000560d55e70e2e in aio_bh_call <span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">(</span>bh=3D0x560d58472a20<span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">)</span> at =
util/async.c:91</div><div style=3D"margin: 0px; font-stretch: normal; =
line-height: normal; font-family: &quot;Helvetica Neue&quot;;" =
class=3D"">#20 aio_bh_poll <span style=3D"font-stretch: normal; =
line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">(</span>ctx=3Dctx@entry=3D0x560d584569e0<span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">)</span> at =
util/async.c:119</div><div style=3D"margin: 0px; font-stretch: normal; =
line-height: normal; font-family: &quot;Helvetica Neue&quot;;" =
class=3D"">#21 0x0000560d55e7470f in aio_dispatch <span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">(</span>ctx=3D0x560d584569e0<span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">)</span> at =
util/aio-posix.c:456</div><div style=3D"margin: 0px; font-stretch: =
normal; line-height: normal; font-family: &quot;Helvetica Neue&quot;;" =
class=3D"">#22 0x0000560d55e70ced in aio_ctx_dispatch <span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">(</span>source=3D&lt;optimized =
out&gt;<span style=3D"font-stretch: normal; line-height: normal; =
font-family: &quot;.PingFang SC&quot;;" class=3D"">,</span> =
callback=3D&lt;optimized out&gt;<span style=3D"font-stretch: normal; =
line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">,</span> user_data=3D&lt;optimized out&gt;<span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">)</span> at =
util/async.c:262</div><div style=3D"margin: 0px; font-stretch: normal; =
line-height: normal; font-family: &quot;Helvetica Neue&quot;;" =
class=3D"">#23 0x00007ff1a0d087f7 in g_main_context_dispatch <span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">()</span> from =
/lib/x86_64-linux-gnu/libglib-2.0.so.0</div><div style=3D"margin: 0px; =
font-stretch: normal; line-height: normal; font-family: &quot;Helvetica =
Neue&quot;;" class=3D"">#24 0x0000560d55e737d8 in glib_pollfds_poll =
<span style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">()</span> at =
util/main-loop.c:217</div><div style=3D"margin: 0px; font-stretch: =
normal; line-height: normal; font-family: &quot;Helvetica Neue&quot;;" =
class=3D"">#25 os_host_main_loop_wait <span style=3D"font-stretch: =
normal; line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">(</span>timeout=3D&lt;optimized out&gt;<span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">)</span> at =
util/main-loop.c:265</div><div style=3D"margin: 0px; font-stretch: =
normal; line-height: normal; font-family: &quot;Helvetica Neue&quot;;" =
class=3D"">#26 main_loop_wait <span style=3D"font-stretch: normal; =
line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">(</span>nonblocking=3D&lt;optimized out&gt;<span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">)</span> at =
util/main-loop.c:524</div><div style=3D"margin: 0px; font-stretch: =
normal; line-height: normal; font-family: &quot;Helvetica Neue&quot;;" =
class=3D"">#27 0x0000560d55a41ff7 in main_loop <span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">()</span> at vl.c:1980</div><div =
style=3D"margin: 0px; font-stretch: normal; line-height: normal; =
font-family: &quot;Helvetica Neue&quot;;" class=3D"">#28 main <span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">(</span>argc=3D&lt;optimized =
out&gt;<span style=3D"font-stretch: normal; line-height: normal; =
font-family: &quot;.PingFang SC&quot;;" class=3D"">,</span> =
argv=3D&lt;optimized out&gt;<span style=3D"font-stretch: normal; =
line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">,</span> envp=3D&lt;optimized out&gt;<span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">)</span> at vl.c:4845</div><div =
style=3D"margin: 0px; font-stretch: normal; line-height: normal; =
font-family: &quot;Helvetica Neue&quot;; min-height: 14px;" class=3D""><br=
 class=3D""></div><div style=3D"margin: 0px; font-stretch: normal; =
line-height: normal; font-family: &quot;Helvetica Neue&quot;;" =
class=3D"">This is because in the virtio_blk_dataplane_stop<span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">()</span> function<span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">,</span> the context of the =
iothread will be set to the maincontext in blk_set_aio_context<span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">()</span>. In the middle of this =
context change<span style=3D"font-stretch: normal; line-height: normal; =
font-family: &quot;.PingFang SC&quot;;" class=3D"">,</span> the iothread =
will acquire the original iothread context which is held by the main =
thread. After the mainthread change the context of the iothread and then =
release the original iothread context<span style=3D"font-stretch: =
normal; line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">,</span> the iothread will get the old iothread context which =
is not supposed to happen because the context has been changed to the =
main thread context. So when the iothread finish =
virtio_blk_rw_complete<span style=3D"font-stretch: normal; line-height: =
normal; font-family: &quot;.PingFang SC&quot;;" class=3D"">()</span> and =
try to release the main thread context<span style=3D"font-stretch: =
normal; line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">,</span> qemu will crash.</div><div style=3D"margin: 0px; =
font-stretch: normal; line-height: normal; font-family: &quot;Helvetica =
Neue&quot;; min-height: 14px;" class=3D""><br class=3D""></div><div =
style=3D"margin: 0px; font-stretch: normal; line-height: normal; =
font-family: &quot;Helvetica Neue&quot;;" class=3D"">This patch can =
solve this problem for me<span style=3D"font-stretch: normal; =
line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">,</span> but I am not sure whether this is right<span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">,</span> please give me a =
hand.</div><div style=3D"margin: 0px; font-stretch: normal; line-height: =
normal; font-family: &quot;Helvetica Neue&quot;; min-height: 14px;" =
class=3D""><br class=3D""></div><div style=3D"margin: 0px; font-stretch: =
normal; line-height: normal; font-family: &quot;Helvetica Neue&quot;;" =
class=3D"">diff --git a/block/.block-backend.c.swp =
b/block/.block-backend.c.swp</div><div style=3D"margin: 0px; =
font-stretch: normal; line-height: normal; font-family: &quot;Helvetica =
Neue&quot;;" class=3D"">deleted file mode 100644</div><div =
style=3D"margin: 0px; font-stretch: normal; line-height: normal; =
font-family: &quot;Helvetica Neue&quot;;" class=3D"">index =
0bf897dd..00000000</div><div style=3D"margin: 0px; font-stretch: normal; =
line-height: normal; font-family: &quot;Helvetica Neue&quot;;" =
class=3D"">Binary files a/block/.block-backend.c.swp and /dev/null =
differ</div><div style=3D"margin: 0px; font-stretch: normal; =
line-height: normal; font-family: &quot;Helvetica Neue&quot;;" =
class=3D"">diff --git a/hw/block/virtio-blk.c =
b/hw/block/virtio-blk.c</div><div style=3D"margin: 0px; font-stretch: =
normal; line-height: normal; font-family: &quot;Helvetica Neue&quot;;" =
class=3D"">index b9c1b3ba..d8ac782d 100644</div><div style=3D"margin: =
0px; font-stretch: normal; line-height: normal; font-family: =
&quot;Helvetica Neue&quot;;" class=3D"">--- =
a/hw/block/virtio-blk.c</div><div style=3D"margin: 0px; font-stretch: =
normal; line-height: normal; font-family: &quot;Helvetica Neue&quot;;" =
class=3D"">+++ b/hw/block/virtio-blk.c</div><div style=3D"margin: 0px; =
font-stretch: normal; line-height: normal; font-family: &quot;Helvetica =
Neue&quot;;" class=3D"">@@ -91<span style=3D"font-stretch: normal; =
line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">,</span>7 +91<span style=3D"font-stretch: normal; =
line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">,</span>12 @@ static void virtio_blk_rw_complete<span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">(</span>void *opaque<span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">,</span> int ret<span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">)</span></div><div style=3D"margin: =
0px; font-stretch: normal; line-height: normal; font-family: =
&quot;Helvetica Neue&quot;;" class=3D"">&nbsp;&nbsp; &nbsp; VirtIOBlock =
*s =3D next-&gt;dev<span style=3D"font-stretch: normal; line-height: =
normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">;</span></div><div style=3D"margin: 0px; font-stretch: =
normal; line-height: normal; font-family: &quot;Helvetica Neue&quot;;" =
class=3D"">&nbsp;&nbsp; &nbsp; VirtIODevice *vdev =3D VIRTIO_DEVICE<span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">(</span>s<span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">);</span></div><div style=3D"margin:=
 0px; font-stretch: normal; line-height: normal; font-family: =
&quot;Helvetica Neue&quot;;" class=3D"">&nbsp;&nbsp; &nbsp; =
QEMU_LOG<span style=3D"font-stretch: normal; line-height: normal; =
font-family: &quot;.PingFang SC&quot;;" class=3D"">(</span>LOG_INFO<span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">,</span> "virtio_blk_rw_complete =
before context_acquire: %p\n"<span style=3D"font-stretch: normal; =
line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">,</span> <span style=3D"font-stretch: normal; line-height: =
normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">(</span>blk_get_aio_context<span style=3D"font-stretch: =
normal; line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">(</span>s-&gt;conf.conf.blk<span style=3D"font-stretch: =
normal; line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">)));</span></div><div style=3D"margin: 0px; font-stretch: =
normal; line-height: normal; font-family: &quot;Helvetica Neue&quot;;" =
class=3D"">-&nbsp; &nbsp; aio_context_acquire<span style=3D"font-stretch: =
normal; line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">(</span>blk_get_aio_context<span style=3D"font-stretch: =
normal; line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">(</span>s-&gt;conf.conf.blk<span style=3D"font-stretch: =
normal; line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">));</span></div><div style=3D"margin: 0px; font-stretch: =
normal; line-height: normal; font-family: &quot;Helvetica Neue&quot;;" =
class=3D"">+&nbsp; &nbsp; static struct timespec ts_sleep<span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">;</span></div><div style=3D"margin: =
0px; font-stretch: normal; line-height: normal; font-family: =
&quot;Helvetica Neue&quot;;" class=3D"">+&nbsp; &nbsp; ts_sleep.tv_sec =3D=
 0<span style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">;</span></div><div style=3D"margin: =
0px; font-stretch: normal; line-height: normal; font-family: =
&quot;Helvetica Neue&quot;;" class=3D"">+&nbsp; &nbsp; ts_sleep.tv_nsec =
=3D 50 * 1000 * 1000ull<span style=3D"font-stretch: normal; line-height: =
normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">;</span></div><div style=3D"margin: 0px; font-stretch: =
normal; line-height: normal; font-family: &quot;Helvetica Neue&quot;;" =
class=3D"">+&nbsp; &nbsp; while <span style=3D"font-stretch: normal; =
line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">(</span>aio_context_tryacquire<span style=3D"font-stretch: =
normal; line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">(</span>blk_get_aio_context<span style=3D"font-stretch: =
normal; line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">(</span>s-&gt;conf.conf.blk<span style=3D"font-stretch: =
normal; line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">)))</span> {</div><div style=3D"margin: 0px; font-stretch: =
normal; line-height: normal; font-family: &quot;Helvetica Neue&quot;;" =
class=3D"">+&nbsp; &nbsp; &nbsp; &nbsp; nanosleep<span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">(</span>&amp;ts_sleep<span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">,</span> NULL<span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">);</span></div><div style=3D"margin:=
 0px; font-stretch: normal; line-height: normal; font-family: =
&quot;Helvetica Neue&quot;;" class=3D"">+&nbsp; &nbsp; }</div><div =
style=3D"margin: 0px; font-stretch: normal; line-height: normal; =
font-family: &quot;Helvetica Neue&quot;;" class=3D"">&nbsp;&nbsp; &nbsp; =
while <span style=3D"font-stretch: normal; line-height: normal; =
font-family: &quot;.PingFang SC&quot;;" class=3D"">(</span>next<span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">)</span> {</div><div =
style=3D"margin: 0px; font-stretch: normal; line-height: normal; =
font-family: &quot;Helvetica Neue&quot;;" class=3D"">&nbsp;&nbsp; &nbsp; =
&nbsp; &nbsp; VirtIOBlockReq *req =3D next<span style=3D"font-stretch: =
normal; line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">;</span></div><div style=3D"margin: 0px; font-stretch: =
normal; line-height: normal; font-family: &quot;Helvetica Neue&quot;;" =
class=3D"">&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; next =3D =
req-&gt;mr_next<span style=3D"font-stretch: normal; line-height: normal; =
font-family: &quot;.PingFang SC&quot;;" class=3D"">;</span></div><div =
style=3D"margin: 0px; font-stretch: normal; line-height: normal; =
font-family: &quot;Helvetica Neue&quot;;" class=3D"">diff --git =
a/include/block/aio.h b/include/block/aio.h</div><div style=3D"margin: =
0px; font-stretch: normal; line-height: normal; font-family: =
&quot;Helvetica Neue&quot;;" class=3D"">index a1d6b9e2..59be498f =
100644</div><div style=3D"margin: 0px; font-stretch: normal; =
line-height: normal; font-family: &quot;Helvetica Neue&quot;;" =
class=3D"">--- a/include/block/aio.h</div><div style=3D"margin: 0px; =
font-stretch: normal; line-height: normal; font-family: &quot;Helvetica =
Neue&quot;;" class=3D"">+++ b/include/block/aio.h</div><div =
style=3D"margin: 0px; font-stretch: normal; line-height: normal; =
font-family: &quot;Helvetica Neue&quot;;" class=3D"">@@ -174<span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">,</span>6 +174<span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">,</span>8 @@ void =
aio_context_ref<span style=3D"font-stretch: normal; line-height: normal; =
font-family: &quot;.PingFang SC&quot;;" class=3D"">(</span>AioContext =
*ctx<span style=3D"font-stretch: normal; line-height: normal; =
font-family: &quot;.PingFang SC&quot;;" class=3D"">);</span></div><div =
style=3D"margin: 0px; font-stretch: normal; line-height: normal; =
font-family: &quot;Helvetica Neue&quot;;" class=3D"">&nbsp; */</div><div =
style=3D"margin: 0px; font-stretch: normal; line-height: normal; =
font-family: &quot;Helvetica Neue&quot;;" class=3D"">&nbsp;void =
aio_context_unref<span style=3D"font-stretch: normal; line-height: =
normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">(</span>AioContext *ctx<span style=3D"font-stretch: normal; =
line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">);</span></div><p style=3D"margin: 0px; font-stretch: normal; =
line-height: normal; font-family: &quot;Helvetica Neue&quot;; =
min-height: 14px;" class=3D"">&nbsp;<br =
class=3D"webkit-block-placeholder"></p><div style=3D"margin: 0px; =
font-stretch: normal; line-height: normal; font-family: &quot;Helvetica =
Neue&quot;;" class=3D"">+int aio_context_tryacquire<span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">(</span>AioContext *ctx<span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">);</span></div><div style=3D"margin:=
 0px; font-stretch: normal; line-height: normal; font-family: =
&quot;Helvetica Neue&quot;;" class=3D"">+</div><div style=3D"margin: =
0px; font-stretch: normal; line-height: normal; font-family: =
&quot;Helvetica Neue&quot;;" class=3D"">&nbsp;/* Take ownership of the =
AioContext.&nbsp; If the AioContext will be shared between</div><div =
style=3D"margin: 0px; font-stretch: normal; line-height: normal; =
font-family: &quot;Helvetica Neue&quot;;" class=3D"">&nbsp; * =
threads<span style=3D"font-stretch: normal; line-height: normal; =
font-family: &quot;.PingFang SC&quot;;" class=3D"">,</span> and a thread =
does not want to be interrupted<span style=3D"font-stretch: normal; =
line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">,</span> it will have to</div><div style=3D"margin: 0px; =
font-stretch: normal; line-height: normal; font-family: &quot;Helvetica =
Neue&quot;;" class=3D"">&nbsp; * take ownership around calls to =
aio_poll<span style=3D"font-stretch: normal; line-height: normal; =
font-family: &quot;.PingFang SC&quot;;" class=3D"">()</span>.&nbsp; =
Otherwise<span style=3D"font-stretch: normal; line-height: normal; =
font-family: &quot;.PingFang SC&quot;;" class=3D"">,</span> =
aio_poll<span style=3D"font-stretch: normal; line-height: normal; =
font-family: &quot;.PingFang SC&quot;;" class=3D"">()</span></div><div =
style=3D"margin: 0px; font-stretch: normal; line-height: normal; =
font-family: &quot;Helvetica Neue&quot;;" class=3D"">diff --git =
a/util/async.c b/util/async.c</div><div style=3D"margin: 0px; =
font-stretch: normal; line-height: normal; font-family: &quot;Helvetica =
Neue&quot;;" class=3D"">index 27fb4901..009f6c5f 100644</div><div =
style=3D"margin: 0px; font-stretch: normal; line-height: normal; =
font-family: &quot;Helvetica Neue&quot;;" class=3D"">--- =
a/util/async.c</div><div style=3D"margin: 0px; font-stretch: normal; =
line-height: normal; font-family: &quot;Helvetica Neue&quot;;" =
class=3D"">+++ b/util/async.c</div><div style=3D"margin: 0px; =
font-stretch: normal; line-height: normal; font-family: &quot;Helvetica =
Neue&quot;;" class=3D"">@@ -498<span style=3D"font-stretch: normal; =
line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">,</span>6 +498<span style=3D"font-stretch: normal; =
line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">,</span>10 @@ void aio_context_unref<span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">(</span>AioContext *ctx<span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">)</span></div><div style=3D"margin: =
0px; font-stretch: normal; line-height: normal; font-family: =
&quot;Helvetica Neue&quot;;" class=3D"">&nbsp;&nbsp; &nbsp; =
g_source_unref<span style=3D"font-stretch: normal; line-height: normal; =
font-family: &quot;.PingFang SC&quot;;" =
class=3D"">(</span>&amp;ctx-&gt;source<span style=3D"font-stretch: =
normal; line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">);</span></div><div style=3D"margin: 0px; font-stretch: =
normal; line-height: normal; font-family: &quot;Helvetica Neue&quot;;" =
class=3D"">&nbsp;}</div><p style=3D"margin: 0px; font-stretch: normal; =
line-height: normal; font-family: &quot;Helvetica Neue&quot;; =
min-height: 14px;" class=3D"">&nbsp;<br =
class=3D"webkit-block-placeholder"></p><div style=3D"margin: 0px; =
font-stretch: normal; line-height: normal; font-family: &quot;Helvetica =
Neue&quot;;" class=3D"">+int aio_context_acquire<span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">(</span>AioContext *ctx<span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">)</span> {</div><div =
style=3D"margin: 0px; font-stretch: normal; line-height: normal; =
font-family: &quot;Helvetica Neue&quot;;" class=3D"">+&nbsp; &nbsp; =
return qemu_rec_mutex_trylock<span style=3D"font-stretch: normal; =
line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">(</span>&amp;ctx-&gt;lock<span style=3D"font-stretch: normal; =
line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">);</span></div><div style=3D"margin: 0px; font-stretch: =
normal; line-height: normal; font-family: &quot;Helvetica Neue&quot;;" =
class=3D"">+}</div><div style=3D"margin: 0px; font-stretch: normal; =
line-height: normal; font-family: &quot;Helvetica Neue&quot;;" =
class=3D"">+</div><div style=3D"margin: 0px; font-stretch: normal; =
line-height: normal; font-family: &quot;Helvetica Neue&quot;;" =
class=3D"">&nbsp;void aio_context_acquire<span style=3D"font-stretch: =
normal; line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">(</span>AioContext *ctx<span style=3D"font-stretch: normal; =
line-height: normal; font-family: &quot;.PingFang SC&quot;;" =
class=3D"">)</span></div><div style=3D"margin: 0px; font-stretch: =
normal; line-height: normal; font-family: &quot;Helvetica Neue&quot;;" =
class=3D"">&nbsp;{</div><div style=3D"margin: 0px; font-stretch: normal; =
line-height: normal; font-family: &quot;Helvetica Neue&quot;;" =
class=3D"">&nbsp;&nbsp; &nbsp; qemu_rec_mutex_lock<span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">(</span>&amp;ctx-&gt;lock<span =
style=3D"font-stretch: normal; line-height: normal; font-family: =
&quot;.PingFang SC&quot;;" class=3D"">);</span></div><div style=3D"margin:=
 0px; font-stretch: normal; line-height: normal; font-family: =
&quot;Helvetica Neue&quot;; min-height: 14px;" class=3D""><br =
class=3D""></div><div style=3D"margin: 0px; font-stretch: normal; =
line-height: normal; font-family: &quot;Helvetica Neue&quot;; =
min-height: 14px;" class=3D""><br class=3D""></div></body></html>=

--Apple-Mail=_110C1946-0FD0-4609-A383-653CC8A7192A--

