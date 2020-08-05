Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E36C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 07:51:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B836B21744
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 07:51:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B836B21744
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3ECv-0006Wm-2T
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 03:51:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39748)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k3ECF-0005or-Ms
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 03:50:47 -0400
Received: from indium.canonical.com ([91.189.90.7]:57000)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k3ECC-00020x-Ho
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 03:50:47 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1k3EC9-0006Jb-Rz
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2020 07:50:41 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id CFE552E80D2
 for <qemu-devel@nongnu.org>; Wed,  5 Aug 2020 07:50:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2020 07:38:58 -0000
From: Raphael Pour <1890395@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: hmp qemu qmp
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: raphaelpour
X-Launchpad-Bug-Reporter: Raphael Pour (raphaelpour)
X-Launchpad-Bug-Modifier: Raphael Pour (raphaelpour)
Message-Id: <159661313818.3099.8994646384897614812.malonedeb@gac.canonical.com>
Subject: [Bug 1890395] [NEW] qmp/hmp: crash if client closes socket too early
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="a24057fea7e4c6a98c0220d5f878da0f3c783699";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 0a5d80326ba2b3e48fa84d976433fe79c52b9021
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 00:25:36
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1890395 <1890395@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

Qemu crashes on qmp/hmp command if client closes connection before
reading the whole response from the socket.

Reproducer:

1. Start arbitrary vm via qemu
2. Send e.g. hmp command 'info mem'
3. Abort before whole response came back


Stack Trace:

Stack trace of thread 6493:
#0  0x0000559902fd2d30 object_get_class (qemu-system-x86_64)
#1  0x0000559903071020 qio_channel_create_watch (qemu-system-x86_64)
#2  0x000055990305f437 qemu_chr_fe_add_watch (qemu-system-x86_64)
#3  0x0000559902f7340d monitor_flush_locked (qemu-system-x86_64)
#4  0x0000559902f7360e monitor_flush_locked (qemu-system-x86_64)
#5  0x0000559902f74342 qmp_send_response (qemu-system-x86_64)
#6  0x0000559902f74409 monitor_qmp_respond (qemu-system-x86_64)
#7  0x0000559902f74bc0 monitor_qmp_bh_dispatcher (qemu-system-x86_64)
#8  0x00005599030c37be aio_bh_call (qemu-system-x86_64)
#9  0x00005599030c6dd0 aio_dispatch (qemu-system-x86_64)
#10 0x00005599030c369e aio_ctx_dispatch (qemu-system-x86_64)
#11 0x00007f5b6d37f417 g_main_context_dispatch (libglib-2.0.so.0)
#12 0x00005599030c5e0a glib_pollfds_poll (qemu-system-x86_64)
#13 0x0000559902dd75df main_loop (qemu-system-x86_64)
#14 0x0000559902c59f49 main (qemu-system-x86_64)
#15 0x00007f5b6bfeab97 __libc_start_main (libc.so.6)
#16 0x0000559902c5d38a _start (qemu-system-x86_64)

#0  0x0000559902fd2d30 in object_get_class (obj=3Dobj@entry=3D0x0) at ./qom=
/object.c:909
#1  0x0000559903071020 in qio_channel_create_watch (ioc=3D0x0, condition=3D=
(G_IO_OUT | G_IO_HUP)) at ./io/channel.c:281
        klass =3D <optimized out>
        __func__ =3D "qio_channel_create_watch"
        ret =3D <optimized out>
#2  0x000055990305f437 in qemu_chr_fe_add_watch (be=3Dbe@entry=3D0x559905a7=
f460, cond=3Dcond@entry=3D(G_IO_OUT | G_IO_HUP), func=3Dfunc@entry=3D0x5599=
02f734b0 <monitor_unblocked>, user_data=3Duser_data@entry=3D0x559905a7f460)=
 at ./chardev/char-fe.c:367
        s =3D 0x5599055782c0
        src =3D <optimized out>
        tag =3D <optimized out>
        __func__ =3D "qemu_chr_fe_add_watch"
#3  0x0000559902f7340d in monitor_flush_locked (mon=3Dmon@entry=3D0x559905a=
7f460) at ./monitor/monitor.c:140
        rc =3D 219264
        len =3D 3865832
        buf =3D 0x7f5afc00e480 "{\"return\": \"ffff9eb480000000-ffff9eb4800=
99000 ", '0' <repeats 11 times>, "99000 -rw\\r\\nffff9eb480099000-ffff9eb48=
009b000 ", '0' <repeats 12 times>, "2000 -r-\\r\\nffff9eb48009b000-ffff9eb4=
86800000 0000000006765000 -rw\\r\\nffff9eb4868000"...
#4  0x0000559902f7360e in monitor_flush_locked (mon=3D0x559905a7f460) at ./=
monitor/monitor.c:160
        i =3D 3865830
        c =3D <optimized out>
#5  0x0000559902f7360e in monitor_puts (mon=3Dmon@entry=3D0x559905a7f460, s=
tr=3D0x7f5aa1eda010 "{\"return\": \"ffff9eb480000000-ffff9eb480099000 ", '0=
' <repeats 11 times>, "99000 -rw\\r\\nffff9eb480099000-ffff9eb48009b000 ", =
'0' <repeats 12 times>, "2000 -r-\\r\\nffff9eb48009b000-ffff9eb486800000 00=
00000006765000 -rw\\r\\nffff9eb4868000"...) at ./monitor/monitor.c:167
        i =3D 3865830
        c =3D <optimized out>
#6  0x0000559902f74342 in qmp_send_response (mon=3D0x559905a7f460, rsp=3D<o=
ptimized out>) at ./monitor/qmp.c:119
        data =3D <optimized out>
        json =3D 0x559906c88380
#7  0x0000559902f74409 in monitor_qmp_respond (rsp=3D0x559905bbf740, mon=3D=
0x559905a7f460) at ./monitor/qmp.c:132
        old_mon =3D <optimized out>
        rsp =3D 0x559905bbf740
        error =3D <optimized out>
#8  0x0000559902f74409 in monitor_qmp_dispatch (mon=3D0x559905a7f460, req=
=3D<optimized out>) at ./monitor/qmp.c:161
        old_mon =3D <optimized out>
        rsp =3D 0x559905bbf740
        error =3D <optimized out>
#9  0x0000559902f74bc0 in monitor_qmp_bh_dispatcher (data=3D<optimized out>=
) at ./monitor/qmp.c:234
        id =3D <optimized out>
        rsp =3D <optimized out>
        need_resume =3D true
        mon =3D 0x559905a7f460
        __PRETTY_FUNCTION__ =3D "monitor_qmp_bh_dispatcher"
#10 0x00005599030c37be in aio_bh_call (bh=3D0x559905571b40) at ./util/async=
.c:89
        bh =3D 0x559905571b40
        bhp =3D <optimized out>
        next =3D 0x5599055718f0
        ret =3D 1
        deleted =3D false
#11 0x00005599030c37be in aio_bh_poll (ctx=3Dctx@entry=3D0x5599055706f0) at=
 ./util/async.c:117
        bh =3D 0x559905571b40
        bhp =3D <optimized out>
        next =3D 0x5599055718f0
        ret =3D 1
        deleted =3D false
#12 0x00005599030c6dd0 in aio_dispatch (ctx=3D0x5599055706f0) at ./util/aio=
-posix.c:459
#13 0x00005599030c369e in aio_ctx_dispatch (source=3D<optimized out>, callb=
ack=3D<optimized out>, user_data=3D<optimized out>) at ./util/async.c:260
        ctx =3D <optimized out>
#14 0x00007f5b6d37f417 in g_main_context_dispatch () at /usr/lib/x86_64-lin=
ux-gnu/libglib-2.0.so.0
#15 0x00005599030c5e0a in glib_pollfds_poll () at ./util/main-loop.c:219
        context =3D 0x559905652420
        pfds =3D <optimized out>
        context =3D 0x559905652420
        ret =3D 1
        mlpoll =3D {state =3D 0, timeout =3D 4294967295, pollfds =3D 0x5599=
05651800}
#16 0x00005599030c5e0a in os_host_main_loop_wait (timeout=3D14451267) at ./=
util/main-loop.c:242
        context =3D 0x559905652420
        ret =3D 1
        mlpoll =3D {state =3D 0, timeout =3D 4294967295, pollfds =3D 0x5599=
05651800}
#17 0x00005599030c5e0a in main_loop_wait (nonblocking=3D<optimized out>) at=
 ./util/main-loop.c:518
        mlpoll =3D {state =3D 0, timeout =3D 4294967295, pollfds =3D 0x5599=
05651800}
#18 0x0000559902dd75df in main_loop () at ./vl.c:1810
#19 0x0000559902c59f49 in main (argc=3D<optimized out>, argv=3D<optimized o=
ut>, envp=3D<optimized out>) at ./vl.c:4466
        i =3D <optimized out>
        snapshot =3D 0
        linux_boot =3D <optimized out>
        initrd_filename =3D 0x0
        kernel_filename =3D <optimized out>
        kernel_cmdline =3D <optimized out>
        boot_order =3D 0x55990318bc94 "cad"
        boot_once =3D <optimized out>
        ds =3D <optimized out>
        opts =3D <optimized out>
        icount_opts =3D <optimized out>
        accel_opts =3D 0x0
        olist =3D <optimized out>
        optind =3D 100
        optarg =3D 0x7ffe0ca05e74 "timestamp=3Don"
        loadvm =3D 0x0
        cpu_option =3D 0x7ffe0ca05d42 "SandyBridge-IBRS,-kvm_steal_time,+pc=
id,+ssbd,+spec-ctrl,+md-clear"
        vga_model =3D 0x0
        qtest_chrdev =3D 0x0
        qtest_log =3D 0x0
        incoming =3D 0x0
        userconfig =3D <optimized out>
        nographic =3D false
        display_remote =3D <optimized out>
        log_mask =3D <optimized out>
        log_file =3D 0x0
        trace_file =3D <optimized out>
        maxram_size =3D <optimized out>
        ram_slots =3D 0
        vmstate_dump_file =3D 0x0
        main_loop_err =3D 0x0
        err =3D 0x0
        list_data_dirs =3D false
        dirs =3D <optimized out>
        bdo_queue =3D {sqh_first =3D 0x0, sqh_last =3D 0x7ffe0ca03540}
        plugin_list =3D {tqh_first =3D 0x0, tqh_circ =3D {tql_next =3D 0x0,=
 tql_prev =3D 0x7ffe0ca03550}}
        __func__ =3D "main"

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: hmp qemu qmp

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1890395

Title:
  qmp/hmp: crash if client closes socket too early

Status in QEMU:
  New

Bug description:
  Qemu crashes on qmp/hmp command if client closes connection before
  reading the whole response from the socket.

  Reproducer:

  1. Start arbitrary vm via qemu
  2. Send e.g. hmp command 'info mem'
  3. Abort before whole response came back

  =

  Stack Trace:

  Stack trace of thread 6493:
  #0  0x0000559902fd2d30 object_get_class (qemu-system-x86_64)
  #1  0x0000559903071020 qio_channel_create_watch (qemu-system-x86_64)
  #2  0x000055990305f437 qemu_chr_fe_add_watch (qemu-system-x86_64)
  #3  0x0000559902f7340d monitor_flush_locked (qemu-system-x86_64)
  #4  0x0000559902f7360e monitor_flush_locked (qemu-system-x86_64)
  #5  0x0000559902f74342 qmp_send_response (qemu-system-x86_64)
  #6  0x0000559902f74409 monitor_qmp_respond (qemu-system-x86_64)
  #7  0x0000559902f74bc0 monitor_qmp_bh_dispatcher (qemu-system-x86_64)
  #8  0x00005599030c37be aio_bh_call (qemu-system-x86_64)
  #9  0x00005599030c6dd0 aio_dispatch (qemu-system-x86_64)
  #10 0x00005599030c369e aio_ctx_dispatch (qemu-system-x86_64)
  #11 0x00007f5b6d37f417 g_main_context_dispatch (libglib-2.0.so.0)
  #12 0x00005599030c5e0a glib_pollfds_poll (qemu-system-x86_64)
  #13 0x0000559902dd75df main_loop (qemu-system-x86_64)
  #14 0x0000559902c59f49 main (qemu-system-x86_64)
  #15 0x00007f5b6bfeab97 __libc_start_main (libc.so.6)
  #16 0x0000559902c5d38a _start (qemu-system-x86_64)

  #0  0x0000559902fd2d30 in object_get_class (obj=3Dobj@entry=3D0x0) at ./q=
om/object.c:909
  #1  0x0000559903071020 in qio_channel_create_watch (ioc=3D0x0, condition=
=3D(G_IO_OUT | G_IO_HUP)) at ./io/channel.c:281
          klass =3D <optimized out>
          __func__ =3D "qio_channel_create_watch"
          ret =3D <optimized out>
  #2  0x000055990305f437 in qemu_chr_fe_add_watch (be=3Dbe@entry=3D0x559905=
a7f460, cond=3Dcond@entry=3D(G_IO_OUT | G_IO_HUP), func=3Dfunc@entry=3D0x55=
9902f734b0 <monitor_unblocked>, user_data=3Duser_data@entry=3D0x559905a7f46=
0) at ./chardev/char-fe.c:367
          s =3D 0x5599055782c0
          src =3D <optimized out>
          tag =3D <optimized out>
          __func__ =3D "qemu_chr_fe_add_watch"
  #3  0x0000559902f7340d in monitor_flush_locked (mon=3Dmon@entry=3D0x55990=
5a7f460) at ./monitor/monitor.c:140
          rc =3D 219264
          len =3D 3865832
          buf =3D 0x7f5afc00e480 "{\"return\": \"ffff9eb480000000-ffff9eb48=
0099000 ", '0' <repeats 11 times>, "99000 -rw\\r\\nffff9eb480099000-ffff9eb=
48009b000 ", '0' <repeats 12 times>, "2000 -r-\\r\\nffff9eb48009b000-ffff9e=
b486800000 0000000006765000 -rw\\r\\nffff9eb4868000"...
  #4  0x0000559902f7360e in monitor_flush_locked (mon=3D0x559905a7f460) at =
./monitor/monitor.c:160
          i =3D 3865830
          c =3D <optimized out>
  #5  0x0000559902f7360e in monitor_puts (mon=3Dmon@entry=3D0x559905a7f460,=
 str=3D0x7f5aa1eda010 "{\"return\": \"ffff9eb480000000-ffff9eb480099000 ", =
'0' <repeats 11 times>, "99000 -rw\\r\\nffff9eb480099000-ffff9eb48009b000 "=
, '0' <repeats 12 times>, "2000 -r-\\r\\nffff9eb48009b000-ffff9eb486800000 =
0000000006765000 -rw\\r\\nffff9eb4868000"...) at ./monitor/monitor.c:167
          i =3D 3865830
          c =3D <optimized out>
  #6  0x0000559902f74342 in qmp_send_response (mon=3D0x559905a7f460, rsp=3D=
<optimized out>) at ./monitor/qmp.c:119
          data =3D <optimized out>
          json =3D 0x559906c88380
  #7  0x0000559902f74409 in monitor_qmp_respond (rsp=3D0x559905bbf740, mon=
=3D0x559905a7f460) at ./monitor/qmp.c:132
          old_mon =3D <optimized out>
          rsp =3D 0x559905bbf740
          error =3D <optimized out>
  #8  0x0000559902f74409 in monitor_qmp_dispatch (mon=3D0x559905a7f460, req=
=3D<optimized out>) at ./monitor/qmp.c:161
          old_mon =3D <optimized out>
          rsp =3D 0x559905bbf740
          error =3D <optimized out>
  #9  0x0000559902f74bc0 in monitor_qmp_bh_dispatcher (data=3D<optimized ou=
t>) at ./monitor/qmp.c:234
          id =3D <optimized out>
          rsp =3D <optimized out>
          need_resume =3D true
          mon =3D 0x559905a7f460
          __PRETTY_FUNCTION__ =3D "monitor_qmp_bh_dispatcher"
  #10 0x00005599030c37be in aio_bh_call (bh=3D0x559905571b40) at ./util/asy=
nc.c:89
          bh =3D 0x559905571b40
          bhp =3D <optimized out>
          next =3D 0x5599055718f0
          ret =3D 1
          deleted =3D false
  #11 0x00005599030c37be in aio_bh_poll (ctx=3Dctx@entry=3D0x5599055706f0) =
at ./util/async.c:117
          bh =3D 0x559905571b40
          bhp =3D <optimized out>
          next =3D 0x5599055718f0
          ret =3D 1
          deleted =3D false
  #12 0x00005599030c6dd0 in aio_dispatch (ctx=3D0x5599055706f0) at ./util/a=
io-posix.c:459
  #13 0x00005599030c369e in aio_ctx_dispatch (source=3D<optimized out>, cal=
lback=3D<optimized out>, user_data=3D<optimized out>) at ./util/async.c:260
          ctx =3D <optimized out>
  #14 0x00007f5b6d37f417 in g_main_context_dispatch () at /usr/lib/x86_64-l=
inux-gnu/libglib-2.0.so.0
  #15 0x00005599030c5e0a in glib_pollfds_poll () at ./util/main-loop.c:219
          context =3D 0x559905652420
          pfds =3D <optimized out>
          context =3D 0x559905652420
          ret =3D 1
          mlpoll =3D {state =3D 0, timeout =3D 4294967295, pollfds =3D 0x55=
9905651800}
  #16 0x00005599030c5e0a in os_host_main_loop_wait (timeout=3D14451267) at =
./util/main-loop.c:242
          context =3D 0x559905652420
          ret =3D 1
          mlpoll =3D {state =3D 0, timeout =3D 4294967295, pollfds =3D 0x55=
9905651800}
  #17 0x00005599030c5e0a in main_loop_wait (nonblocking=3D<optimized out>) =
at ./util/main-loop.c:518
          mlpoll =3D {state =3D 0, timeout =3D 4294967295, pollfds =3D 0x55=
9905651800}
  #18 0x0000559902dd75df in main_loop () at ./vl.c:1810
  #19 0x0000559902c59f49 in main (argc=3D<optimized out>, argv=3D<optimized=
 out>, envp=3D<optimized out>) at ./vl.c:4466
          i =3D <optimized out>
          snapshot =3D 0
          linux_boot =3D <optimized out>
          initrd_filename =3D 0x0
          kernel_filename =3D <optimized out>
          kernel_cmdline =3D <optimized out>
          boot_order =3D 0x55990318bc94 "cad"
          boot_once =3D <optimized out>
          ds =3D <optimized out>
          opts =3D <optimized out>
          icount_opts =3D <optimized out>
          accel_opts =3D 0x0
          olist =3D <optimized out>
          optind =3D 100
          optarg =3D 0x7ffe0ca05e74 "timestamp=3Don"
          loadvm =3D 0x0
          cpu_option =3D 0x7ffe0ca05d42 "SandyBridge-IBRS,-kvm_steal_time,+=
pcid,+ssbd,+spec-ctrl,+md-clear"
          vga_model =3D 0x0
          qtest_chrdev =3D 0x0
          qtest_log =3D 0x0
          incoming =3D 0x0
          userconfig =3D <optimized out>
          nographic =3D false
          display_remote =3D <optimized out>
          log_mask =3D <optimized out>
          log_file =3D 0x0
          trace_file =3D <optimized out>
          maxram_size =3D <optimized out>
          ram_slots =3D 0
          vmstate_dump_file =3D 0x0
          main_loop_err =3D 0x0
          err =3D 0x0
          list_data_dirs =3D false
          dirs =3D <optimized out>
          bdo_queue =3D {sqh_first =3D 0x0, sqh_last =3D 0x7ffe0ca03540}
          plugin_list =3D {tqh_first =3D 0x0, tqh_circ =3D {tql_next =3D 0x=
0, tql_prev =3D 0x7ffe0ca03550}}
          __func__ =3D "main"

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1890395/+subscriptions

