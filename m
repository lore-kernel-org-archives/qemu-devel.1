Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 921A6C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 13:54:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFB172068D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 13:54:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFB172068D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc7cT-0003jJ-Pz
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 08:54:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32900)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kc7UW-00032c-18
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 08:45:52 -0500
Received: from indium.canonical.com ([91.189.90.7]:33910)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kc7UT-0002qq-52
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 08:45:51 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kc7UR-0000dk-1l
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2020 13:45:47 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 0C3B62E812F
 for <qemu-devel@nongnu.org>; Mon,  9 Nov 2020 13:45:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2020 13:35:48 -0000
From: Thomas Huth <1687569@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Incomplete; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: jemmy858585 th-huth
X-Launchpad-Bug-Reporter: Lidong Chen (jemmy858585)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <20170502084810.2931.3440.malonedeb@soybean.canonical.com>
Message-Id: <160492894861.28021.12243837915739381358.malone@chaenomeles.canonical.com>
Subject: [Bug 1687569] Re: when migration cancel, qemu main thread hung
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="e39939c02bd86af4202bc6e2123a7708215ec8ea"; Instance="production"
X-Launchpad-Hash: acc973cbcbc2457d6ee951afe9acdd62d8c560a4
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 01:40:52
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Reply-To: Bug 1687569 <1687569@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The QEMU project is currently considering to move its bug tracking to anoth=
er system. For this we need to know which bugs are still valid and which co=
uld be closed already. Thus we are setting older bugs to "Incomplete" now.
If you still think this bug report here is valid, then please switch the st=
ate back to "New" within the next 60 days, otherwise this report will be ma=
rked as "Expired". Thank you and sorry for the inconvenience.

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1687569

Title:
  when migration cancel, qemu main thread hung

Status in QEMU:
  Incomplete

Bug description:
  qemu version:v2.9.0-rc5 release

  1.virsh migrate --live 165cf436-312f-47e7-90f2-f8aa63f34893 --copy-storag=
e-all qemu+ssh://10.59.163.38/system
  2.press Ctrl+C cancel migrate

   qemu main thread hung

  (gdb) bt
  #0  0x00007fca9f4574b7 in ppoll () from /lib64/libc.so.6
  #1  0x0000000000944970 in qemu_poll_ns (fds=3D0x293e6e0, nfds=3D1, timeou=
t=3D-1) at util/qemu-timer.c:322
  #2  0x0000000000947e16 in aio_poll (ctx=3D0x291d4b0, blocking=3Dtrue) at =
util/aio-posix.c:622
  #3  0x00000000008b6094 in nbd_teardown_connection (bs=3D0x29ccdc0) at blo=
ck/nbd-client.c:59
  #4  0x00000000008b6df1 in nbd_client_close (bs=3D0x29ccdc0) at block/nbd-=
client.c:377
  #5  0x00000000008b5988 in nbd_close (bs=3D0x29ccdc0) at block/nbd.c:488
  #6  0x00000000008435de in bdrv_close (bs=3D0x29ccdc0) at block.c:2919
  #7  0x0000000000843c86 in bdrv_delete (bs=3D0x29ccdc0) at block.c:3100
  #8  0x000000000084620b in bdrv_unref (bs=3D0x29ccdc0) at block.c:4087
  #9  0x00000000008411d1 in bdrv_root_unref_child (child=3D0x30e4800) at bl=
ock.c:1891
  #10 0x000000000084128a in bdrv_unref_child (parent=3D0x29c0660, child=3D0=
x30e4800) at block.c:1915
  #11 0x000000000084362a in bdrv_close (bs=3D0x29c0660) at block.c:2925
  #12 0x0000000000843c86 in bdrv_delete (bs=3D0x29c0660) at block.c:3100
  #13 0x000000000084620b in bdrv_unref (bs=3D0x29c0660) at block.c:4087
  #14 0x00000000008411d1 in bdrv_root_unref_child (child=3D0x3013910) at bl=
ock.c:1891
  #15 0x0000000000848149 in block_job_remove_all_bdrv (job=3D0x3fa7800) at =
blockjob.c:154
  #16 0x00000000008a8dd8 in mirror_exit (job=3D0x3fa7800, opaque=3D0x7fca90=
000bf0) at block/mirror.c:576
  #17 0x0000000000849e22 in block_job_defer_to_main_loop_bh (opaque=3D0x7fc=
a90000d90) at blockjob.c:794
  #18 0x00000000009420c4 in aio_bh_call (bh=3D0x7fca90000dc0) at util/async=
.c:90
  #19 0x000000000094216f in aio_bh_poll (ctx=3D0x291d4b0) at util/async.c:1=
18
  #20 0x00000000009480d9 in aio_poll (ctx=3D0x291d4b0, blocking=3Dtrue) at =
util/aio-posix.c:682
  #21 0x00000000008b6094 in nbd_teardown_connection (bs=3D0x2921350) at blo=
ck/nbd-client.c:59
  #22 0x00000000008b6df1 in nbd_client_close (bs=3D0x2921350) at block/nbd-=
client.c:377
  #23 0x00000000008b5988 in nbd_close (bs=3D0x2921350) at block/nbd.c:488
  #24 0x00000000008435de in bdrv_close (bs=3D0x2921350) at block.c:2919
  #25 0x0000000000843c86 in bdrv_delete (bs=3D0x2921350) at block.c:3100
  #26 0x000000000084620b in bdrv_unref (bs=3D0x2921350) at block.c:4087
  #27 0x00000000008411d1 in bdrv_root_unref_child (child=3D0x390d180) at bl=
ock.c:1891
  #28 0x000000000084128a in bdrv_unref_child (parent=3D0x4eba200, child=3D0=
x390d180) at block.c:1915
  #29 0x000000000084362a in bdrv_close (bs=3D0x4eba200) at block.c:2925
  #30 0x0000000000843c86 in bdrv_delete (bs=3D0x4eba200) at block.c:3100
  #31 0x000000000084620b in bdrv_unref (bs=3D0x4eba200) at block.c:4087
  #32 0x00000000008411d1 in bdrv_root_unref_child (child=3D0x4ebf990) at bl=
ock.c:1891
  #33 0x0000000000848149 in block_job_remove_all_bdrv (job=3D0x4ea85b0) at =
blockjob.c:154
  #34 0x00000000008a8dd8 in mirror_exit (job=3D0x4ea85b0, opaque=3D0x7fca98=
000bf0) at block/mirror.c:576
  #35 0x0000000000849e22 in block_job_defer_to_main_loop_bh (opaque=3D0x7fc=
a980013d0) at blockjob.c:794
  #36 0x00000000009420c4 in aio_bh_call (bh=3D0x7fca9801e0c0) at util/async=
.c:90
  #37 0x000000000094216f in aio_bh_poll (ctx=3D0x291d4b0) at util/async.c:1=
18
  ---Type <return> to continue, or q <return> to quit---  =

  #38 0x00000000009476ae in aio_dispatch (ctx=3D0x291d4b0) at util/aio-posi=
x.c:429
  #39 0x00000000009425e4 in aio_ctx_dispatch (source=3D0x291d4b0, callback=
=3D0, user_data=3D0x0) at util/async.c:261
  #40 0x00007fcaa0101f0e in g_main_context_dispatch () from /lib64/libglib-=
2.0.so.0
  #41 0x0000000000945d86 in glib_pollfds_poll () at util/main-loop.c:213
  #42 0x0000000000945ea7 in os_host_main_loop_wait (timeout=3D124777230) at=
 util/main-loop.c:261
  #43 0x0000000000945f72 in main_loop_wait (nonblocking=3D0) at util/main-l=
oop.c:517
  #44 0x00000000005c7794 in main_loop () at vl.c:1898
  #45 0x00000000005cec57 in main (argc=3D64, argv=3D0x7fffe7020c58, envp=3D=
0x7fffe7020e60) at vl.c:4709

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1687569/+subscriptions

