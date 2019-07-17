Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A2BAC76186
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 08:31:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C25920818
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 08:31:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C25920818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnfL3-00025M-7k
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 04:31:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45461)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1hnfKr-0001gM-3j
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 04:30:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hnfKp-0003lN-JB
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 04:30:49 -0400
Received: from indium.canonical.com ([91.189.90.7]:57496)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hnfKp-0003j1-Cu
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 04:30:47 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hnfKm-000408-8h
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2019 08:30:44 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 3CDBC2E80BA
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2019 08:30:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jul 2019 08:20:35 -0000
From: =?utf-8?b?6LSe6LS15p2O?= <1836855@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: lizhengui
X-Launchpad-Bug-Reporter: =?utf-8?b?6LSe6LS15p2OIChsaXpoZW5ndWkp?=
X-Launchpad-Bug-Modifier: =?utf-8?b?6LSe6LS15p2OIChsaXpoZW5ndWkp?=
Message-Id: <156335163555.1137.2433837611161042870.malonedeb@gac.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19009";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 4f1d3b65b9c9b8c678cd4db1b8612c40c7261c3a
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1836855] [NEW] virtio_scsi_ctx_check failed when
 detach virtio_scsi disk
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
Reply-To: Bug 1836855 <1836855@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

I found a problem  that virtio_scsi_ctx_check  failed when detaching
virtio_scsi disk.  The  bt is below:

(gdb) bt
#0  0x0000ffffb02e1bd0 in raise () from /lib64/libc.so.6
#1  0x0000ffffb02e2f7c in abort () from /lib64/libc.so.6
#2  0x0000ffffb02db124 in __assert_fail_base () from /lib64/libc.so.6
#3  0x0000ffffb02db1a4 in __assert_fail () from /lib64/libc.so.6
#4  0x00000000004eb9a8 in virtio_scsi_ctx_check (d=3Dd@entry=3D0xc70d790, s=
=3D<optimized out>, s=3D<optimized out>)
    at /Images/lzg/code/710/qemu-2.8.1/hw/scsi/virtio-scsi.c:243
#5  0x00000000004ec87c in virtio_scsi_handle_cmd_req_prepare (s=3Ds@entry=
=3D0xd27a7a0, req=3Dreq@entry=3D0xafc4b90)
    at /Images/lzg/code/710/qemu-2.8.1/hw/scsi/virtio-scsi.c:553
#6  0x00000000004ecc20 in virtio_scsi_handle_cmd_vq (s=3D0xd27a7a0, vq=3D0x=
d283410)
    at /Images/lzg/code/710/qemu-2.8.1/hw/scsi/virtio-scsi.c:588
#7  0x00000000004eda20 in virtio_scsi_data_plane_handle_cmd (vdev=3D0x0, vq=
=3D0xffffae7a6f98)
    at /Images/lzg/code/710/qemu-2.8.1/hw/scsi/virtio-scsi-dataplane.c:57
#8  0x0000000000877254 in aio_dispatch (ctx=3D0xac61010) at util/aio-posix.=
c:323
#9  0x00000000008773ec in aio_poll (ctx=3D0xac61010, blocking=3Dtrue) at ut=
il/aio-posix.c:472
#10 0x00000000005cd7cc in iothread_run (opaque=3D0xac5e4b0) at iothread.c:49
#11 0x000000000087a8b8 in qemu_thread_start (args=3D0xac61360) at util/qemu=
-thread-posix.c:495
#12 0x00000000008a04e8 in thread_entry_for_hotfix (pthread_cb=3D0x0) at uvp=
/hotpatch/qemu_hotpatch_helper.c:579
#13 0x0000ffffb041c8bc in start_thread () from /lib64/libpthread.so.0
#14 0x0000ffffb0382f8c in thread_start () from /lib64/libc.so.6

assert(blk_get_aio_context(d->conf.blk) =3D=3D s->ctx)  failed.

I think this patch
(https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3Da6f230c8d13a7ff3a0c7=
f1097412f44bfd9eff0b)
introduce this problem.

commit a6f230c8d13a7ff3a0c7f1097412f44bfd9eff0b  move blockbackend back
to main AioContext on unplug. It set the AioContext of

SCSIDevice  to the main AioContex, but s->ctx is still the iothread
AioContext.  Is this a bug?

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1836855

Title:
  virtio_scsi_ctx_check failed when detach virtio_scsi disk

Status in QEMU:
  New

Bug description:
  I found a problem  that virtio_scsi_ctx_check  failed when detaching
  virtio_scsi disk.  The  bt is below:

  (gdb) bt
  #0  0x0000ffffb02e1bd0 in raise () from /lib64/libc.so.6
  #1  0x0000ffffb02e2f7c in abort () from /lib64/libc.so.6
  #2  0x0000ffffb02db124 in __assert_fail_base () from /lib64/libc.so.6
  #3  0x0000ffffb02db1a4 in __assert_fail () from /lib64/libc.so.6
  #4  0x00000000004eb9a8 in virtio_scsi_ctx_check (d=3Dd@entry=3D0xc70d790,=
 s=3D<optimized out>, s=3D<optimized out>)
      at /Images/lzg/code/710/qemu-2.8.1/hw/scsi/virtio-scsi.c:243
  #5  0x00000000004ec87c in virtio_scsi_handle_cmd_req_prepare (s=3Ds@entry=
=3D0xd27a7a0, req=3Dreq@entry=3D0xafc4b90)
      at /Images/lzg/code/710/qemu-2.8.1/hw/scsi/virtio-scsi.c:553
  #6  0x00000000004ecc20 in virtio_scsi_handle_cmd_vq (s=3D0xd27a7a0, vq=3D=
0xd283410)
      at /Images/lzg/code/710/qemu-2.8.1/hw/scsi/virtio-scsi.c:588
  #7  0x00000000004eda20 in virtio_scsi_data_plane_handle_cmd (vdev=3D0x0, =
vq=3D0xffffae7a6f98)
      at /Images/lzg/code/710/qemu-2.8.1/hw/scsi/virtio-scsi-dataplane.c:57
  #8  0x0000000000877254 in aio_dispatch (ctx=3D0xac61010) at util/aio-posi=
x.c:323
  #9  0x00000000008773ec in aio_poll (ctx=3D0xac61010, blocking=3Dtrue) at =
util/aio-posix.c:472
  #10 0x00000000005cd7cc in iothread_run (opaque=3D0xac5e4b0) at iothread.c=
:49
  #11 0x000000000087a8b8 in qemu_thread_start (args=3D0xac61360) at util/qe=
mu-thread-posix.c:495
  #12 0x00000000008a04e8 in thread_entry_for_hotfix (pthread_cb=3D0x0) at u=
vp/hotpatch/qemu_hotpatch_helper.c:579
  #13 0x0000ffffb041c8bc in start_thread () from /lib64/libpthread.so.0
  #14 0x0000ffffb0382f8c in thread_start () from /lib64/libc.so.6

  assert(blk_get_aio_context(d->conf.blk) =3D=3D s->ctx)  failed.

  I think this patch
  (https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3Da6f230c8d13a7ff3a0=
c7f1097412f44bfd9eff0b)
  introduce this problem.

  commit a6f230c8d13a7ff3a0c7f1097412f44bfd9eff0b  move blockbackend
  back to main AioContext on unplug. It set the AioContext of

  SCSIDevice  to the main AioContex, but s->ctx is still the iothread
  AioContext.  Is this a bug?

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1836855/+subscriptions

