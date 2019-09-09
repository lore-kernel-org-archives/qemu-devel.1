Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C758C4740C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 16:56:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52E8E21479
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 16:56:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52E8E21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelpath.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7MyB-0005YM-Eu
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 12:56:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42463)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1i7Mx5-0004dG-F0
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 12:55:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1i7Mx4-0005aE-0g
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 12:55:43 -0400
Received: from indium.canonical.com ([91.189.90.7]:52970)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1i7Mx3-0005Zw-RX
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 12:55:41 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1i7Mx2-0001SR-Cb
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2019 16:55:40 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 544312E80CC
 for <qemu-devel@nongnu.org>; Mon,  9 Sep 2019 16:55:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Sep 2019 16:47:25 -0000
From: Rafael David Tinoco <rafaeldtinoco@kernelpath.com>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Confirmed; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; sourcepackage=qemu; component=main;
 status=In Progress; importance=Medium; assignee=rafaeldtinoco@kernelpath.com; 
X-Launchpad-Bug-Tags: qemu-img
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: dannf jnsnow lizhengui rafaeldtinoco
X-Launchpad-Bug-Reporter: dann frazier (dannf)
X-Launchpad-Bug-Modifier: Rafael David Tinoco (rafaeldtinoco)
References: <154327283728.15443.11625169757714443608.malonedeb@soybean.canonical.com>
Message-Id: <156804764550.6967.6905216437390357307.malone@soybean.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19044";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 127d0b69198e863a258fef22809b38cf25395c18
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1805256] Re: qemu-img hangs on high core count
 ARM system
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
Reply-To: Bug 1805256 <1805256@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Alright, with a d06 aarch64 machine I was able to reproduce it after 8
attempts.I'll debug it today and provide feedback on my findings.

(gdb) bt full
#0  0x0000ffffb0b2181c in __GI_ppoll (fds=3D0xaaaace5ab770, nfds=3D4, timeo=
ut=3D<optimized out>, timeout@entry=3D0x0,
    sigmask=3Dsigmask@entry=3D0x0) at ../sysdeps/unix/sysv/linux/ppoll.c:39
        _x3tmp =3D 0
        _x0tmp =3D 187650583213936
        _x0 =3D 187650583213936
        _x3 =3D 0
        _x4tmp =3D 8
        _x1tmp =3D 4
        _x1 =3D 4
        _x4 =3D 8
        _x2tmp =3D <optimized out>
        _x2 =3D 0
        _x8 =3D 73
        _sys_result =3D <optimized out>
        _sys_result =3D <optimized out>
        sc_cancel_oldtype =3D 0
        sc_ret =3D <optimized out>
        tval =3D {tv_sec =3D 0, tv_nsec =3D 187650583137792}
#1  0x0000aaaacd2a773c in ppoll (__ss=3D0x0, __timeout=3D0x0, __nfds=3D<opt=
imized out>, __fds=3D<optimized out>)
    at /usr/include/aarch64-linux-gnu/bits/poll2.h:77
No locals.
#2  qemu_poll_ns (fds=3D<optimized out>, nfds=3D<optimized out>, timeout=3D=
timeout@entry=3D-1) at ./util/qemu-timer.c:322
No locals.
#3  0x0000aaaacd2a8764 in os_host_main_loop_wait (timeout=3D-1) at ./util/m=
ain-loop.c:233
        context =3D 0xaaaace599d90
        ret =3D <optimized out>
        context =3D <optimized out>
        ret =3D <optimized out>
#4  main_loop_wait (nonblocking=3D<optimized out>) at ./util/main-loop.c:497
        ret =3D <optimized out>
        timeout =3D 4294967295
        timeout_ns =3D <optimized out>
#5  0x0000aaaacd1df454 in convert_do_copy (s=3D0xfffff9b2b1d8) at ./qemu-im=
g.c:1981
        ret =3D <optimized out>
        i =3D <optimized out>
        n =3D <optimized out>
        sector_num =3D <optimized out>
        ret =3D <optimized out>
        i =3D <optimized out>
        n =3D <optimized out>
        sector_num =3D <optimized out>
#6  img_convert (argc=3D<optimized out>, argv=3D<optimized out>) at ./qemu-=
img.c:2457
        c =3D <optimized out>
        bs_i =3D <optimized out>
        flags =3D 16898
        src_flags =3D 0
        fmt =3D 0xfffff9b2bad1 "qcow2"
        out_fmt =3D <optimized out>
        cache =3D 0xaaaacd2cb1c8 "unsafe"
        src_cache =3D 0xaaaacd2ca9c0 "writeback"
        out_baseimg =3D <optimized out>
        out_filename =3D <optimized out>
        out_baseimg_param =3D <optimized out>
        snapshot_name =3D 0x0
        drv =3D <optimized out>
        proto_drv =3D <optimized out>
        bdi =3D {cluster_size =3D 65536, vm_state_offset =3D 32212254720, i=
s_dirty =3D false, unallocated_blocks_are_zero =3D true,
          needs_compressed_writes =3D false}
        out_bs =3D <optimized out>
        opts =3D 0xaaaace5ab390
        sn_opts =3D 0x0
        create_opts =3D 0xaaaace5ab0c0
        open_opts =3D <optimized out>
        options =3D 0x0
        local_err =3D 0x0
        writethrough =3D false
        src_writethrough =3D false
        quiet =3D <optimized out>
        image_opts =3D false
        skip_create =3D false
        progress =3D <optimized out>
        tgt_image_opts =3D false
        ret =3D <optimized out>
        force_share =3D false
        explict_min_sparse =3D false
        s =3D {src =3D 0xaaaace577240, src_sectors =3D 0xaaaace577300, src_=
num =3D 1, total_sectors =3D 62914560,allocated_sectors =3D 9572096, alloca=
ted_done =3D 6541440, sector_num =3D 8863744, wr_offs =3D 8859776, status =
=3D BLK_DATA, sector_next_status =3D 8863744, target =3D 0xaaaace5bd2a0, ha=
s_zero_init =3D true,compressed =3D false, unallocated_blocks_are_zero =3D =
true, target_has_backing =3D false, target_backing_sectors =3D -1, wr_in_or=
der =3D true, copy_range =3D false, min_sparse =3D 8, alignment =3D 8,clust=
er_sectors =3D 128, buf_sectors =3D 4096, num_coroutines =3D 8, running_cor=
outines =3D 8, co =3D {0xaaaace5ceda0,0xaaaace5cef50, 0xaaaace5cf100, 0xaaa=
ace5cf2b0, 0xaaaace5cf460, 0xaaaace5cf610, 0xaaaace5cf7c0,0xaaaace5cf970, 0=
x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, wait_sector_num =3D {-1, 8859904, 8=
860928, 8863360,8861952, 8862976, 8862592, 8861440, 0, 0, 0, 0, 0, 0, 0, 0}=
, lock =3D {locked =3D 0, ctx =3D 0x0, from_push =3D {slh_first =3D 0x0}, t=
o_pop =3D {slh_first =3D 0x0}, handoff =3D 0, sequence =3D 0, holder =3D 0x=
0}, ret =3D -115}
        __PRETTY_FUNCTION__ =3D "img_convert"
#7  0x0000aaaacd1d8400 in main (argc=3D7, argv=3D<optimized out>) at ./qemu=
-img.c:4976
        cmd =3D 0xaaaacd34ad78 <img_cmds+80>
        cmdname =3D <optimized out>
        local_error =3D 0x0
        trace_file =3D 0x0
        c =3D <optimized out>
        long_options =3D {{name =3D 0xaaaacd2cbbb0 "help", has_arg =3D 0, f=
lag =3D 0x0, val =3D 104}, {
            name =3D 0xaaaacd2cbc78 "version", has_arg =3D 0, flag =3D 0x0,=
 val =3D 86}, {name =3D 0xaaaacd2cbc80 "trace",
            has_arg =3D 1, flag =3D 0x0, val =3D 84}, {name =3D 0x0, has_ar=
g =3D 0, flag =3D 0x0, val =3D 0}}

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1805256

Title:
  qemu-img hangs on high core count ARM system

Status in QEMU:
  Confirmed
Status in qemu package in Ubuntu:
  In Progress

Bug description:
  On the HiSilicon D06 system - a 96 core NUMA arm64 box - qemu-img
  frequently hangs (~50% of the time) with this command:

  qemu-img convert -f qcow2 -O qcow2 /tmp/cloudimg /tmp/cloudimg2

  Where "cloudimg" is a standard qcow2 Ubuntu cloud image. This
  qcow2->qcow2 conversion happens to be something uvtool does every time
  it fetches images.

  Once hung, attaching gdb gives the following backtrace:

  (gdb) bt
  #0  0x0000ffffae4f8154 in __GI_ppoll (fds=3D0xaaaae8a67dc0, nfds=3D187650=
274213760, =

      timeout=3D<optimized out>, timeout@entry=3D0x0, sigmask=3D0xffffc123b=
950)
      at ../sysdeps/unix/sysv/linux/ppoll.c:39
  #1  0x0000aaaabbefaf00 in ppoll (__ss=3D0x0, __timeout=3D0x0, __nfds=3D<o=
ptimized out>, =

      __fds=3D<optimized out>) at /usr/include/aarch64-linux-gnu/bits/poll2=
.h:77
  #2  qemu_poll_ns (fds=3D<optimized out>, nfds=3D<optimized out>, =

      timeout=3Dtimeout@entry=3D-1) at util/qemu-timer.c:322
  #3  0x0000aaaabbefbf80 in os_host_main_loop_wait (timeout=3D-1)
      at util/main-loop.c:233
  #4  main_loop_wait (nonblocking=3D<optimized out>) at util/main-loop.c:497
  #5  0x0000aaaabbe2aa30 in convert_do_copy (s=3D0xffffc123bb58) at qemu-im=
g.c:1980
  #6  img_convert (argc=3D<optimized out>, argv=3D<optimized out>) at qemu-=
img.c:2456
  #7  0x0000aaaabbe2333c in main (argc=3D7, argv=3D<optimized out>) at qemu=
-img.c:4975

  Reproduced w/ latest QEMU git (@ 53744e0a182)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1805256/+subscriptions

