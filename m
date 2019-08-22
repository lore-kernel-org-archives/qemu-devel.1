Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E72C3A59E
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 01:11:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A611922DD3
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 01:11:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A611922DD3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0bdR-0001xz-L8
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 21:11:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59895)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1i0bcm-0001Wn-Vv
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 21:10:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1i0bcl-0000P2-Il
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 21:10:48 -0400
Received: from indium.canonical.com ([91.189.90.7]:38646)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1i0bcl-0000NP-DQ
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 21:10:47 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1i0bcj-0004We-WF
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 01:10:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id EFA0B2E80C7
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 01:10:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Aug 2019 00:59:11 -0000
From: fangying <1840865@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: yorifang
X-Launchpad-Bug-Reporter: fangying (yorifang)
X-Launchpad-Bug-Modifier: fangying (yorifang)
References: <156635483019.23159.9094249492846476541.malonedeb@chaenomeles.canonical.com>
Message-Id: <156643555230.26445.12748455654865300430.launchpad@soybean.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19022";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: ef9dac9eb5719a31aaafb0f28c2d799a70a34454
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1840865] Re: qemu crashes when doing iotest on
 virtio-9p filesystem
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
Reply-To: Bug 1840865 <1840865@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

** Description changed:

  Qemu crashes when doing avocado-vt test on virtio-9p filesystem.
- This bug can be reproduced running https://github.com/autotest/tp-qemu/bl=
ob/master/qemu/tests/9p.py.
+ This bug can be reproduced running https://github.com/autotest/tp-qemu/bl=
ob/master/qemu/tests/9p.py with the latest qemu-4.0.0.
  The crash stack goes like:
  =

  Program terminated with signal SIGSEGV, Segmentation fault.
  #0  v9fs_mark_fids_unreclaim (pdu=3Dpdu@entry=3D0xaaab00046868, path=3Dpa=
th@entry=3D0xffff851e2fa8)
-     at hw/9pfs/9p.c:505
+ =C2=A0=C2=A0=C2=A0=C2=A0at hw/9pfs/9p.c:505
  #1  0x0000aaaae3585acc in v9fs_unlinkat (opaque=3D0xaaab00046868) at hw/9=
pfs/9p.c:2590
  #2  0x0000aaaae3811c10 in coroutine_trampoline (i0=3D<optimized out>, i1=
=3D<optimized out>)
-     at util/coroutine-ucontext.c:116
+ =C2=A0=C2=A0=C2=A0=C2=A0at util/coroutine-ucontext.c:116
  #3  0x0000ffffa13ddb20 in ?? () from /lib64/libc.so.6
  Backtrace stopped: not enough registers or memory available to unwind fur=
ther
  =

  A segment fault is triggered at hw/9pfs/9p.c line 505
  =

-     for (fidp =3D s->fid_list; fidp; fidp =3D fidp->next) {
-         if (fidp->path.size !=3D path->size) {     # fidp is invalid =

-             continue;
-         }
+ =C2=A0=C2=A0=C2=A0=C2=A0for (fidp =3D s->fid_list; fidp; fidp =3D fidp->n=
ext) {
+ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (fidp->path.size !=3D =
path->size) {     # fidp is invalid
+ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0c=
ontinue;
+ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
  =

  (gdb) p path
  $10 =3D (V9fsPath *) 0xffff851e2fa8
  (gdb) p *path
  $11 =3D {size =3D 21, data =3D 0xaaaafed6f420 "./9p_test/p2a1/d0/f1"}
  (gdb) p *fidp
  Cannot access memory at address 0x101010101010101
  (gdb) p *pdu
  $12 =3D {size =3D 19, tag =3D 54, id =3D 76 'L', cancelled =3D 0 '\000', =
complete =3D {entries =3D {
-       sqh_first =3D 0x0, sqh_last =3D 0xaaab00046870}}, s =3D 0xaaab00045=
4b8, next =3D {
-     le_next =3D 0xaaab000467c0, le_prev =3D 0xaaab00046f88}, idx =3D 88}
- (gdb) =

+ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sqh_first =3D 0x0, sqh_last =3D 0xaaa=
b00046870}}, s =3D 0xaaab000454b8, next =3D {
+ =C2=A0=C2=A0=C2=A0=C2=A0le_next =3D 0xaaab000467c0, le_prev =3D 0xaaab000=
46f88}, idx =3D 88}
+ (gdb)
  =

  Address Sanitizer shows error and saying that there is a heap-use-after-
  free on *fidp*.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1840865

Title:
  qemu crashes when doing iotest on  virtio-9p filesystem

Status in QEMU:
  New

Bug description:
  Qemu crashes when doing avocado-vt test on virtio-9p filesystem.
  This bug can be reproduced running https://github.com/autotest/tp-qemu/bl=
ob/master/qemu/tests/9p.py with the latest qemu-4.0.0.
  The crash stack goes like:

  Program terminated with signal SIGSEGV, Segmentation fault.
  #0  v9fs_mark_fids_unreclaim (pdu=3Dpdu@entry=3D0xaaab00046868, path=3Dpa=
th@entry=3D0xffff851e2fa8)
  =C2=A0=C2=A0=C2=A0=C2=A0at hw/9pfs/9p.c:505
  #1  0x0000aaaae3585acc in v9fs_unlinkat (opaque=3D0xaaab00046868) at hw/9=
pfs/9p.c:2590
  #2  0x0000aaaae3811c10 in coroutine_trampoline (i0=3D<optimized out>, i1=
=3D<optimized out>)
  =C2=A0=C2=A0=C2=A0=C2=A0at util/coroutine-ucontext.c:116
  #3  0x0000ffffa13ddb20 in ?? () from /lib64/libc.so.6
  Backtrace stopped: not enough registers or memory available to unwind fur=
ther

  A segment fault is triggered at hw/9pfs/9p.c line 505

  =C2=A0=C2=A0=C2=A0=C2=A0for (fidp =3D s->fid_list; fidp; fidp =3D fidp->n=
ext) {
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (fidp->path.size !=3D =
path->size) {     # fidp is invalid
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0c=
ontinue;
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}

  (gdb) p path
  $10 =3D (V9fsPath *) 0xffff851e2fa8
  (gdb) p *path
  $11 =3D {size =3D 21, data =3D 0xaaaafed6f420 "./9p_test/p2a1/d0/f1"}
  (gdb) p *fidp
  Cannot access memory at address 0x101010101010101
  (gdb) p *pdu
  $12 =3D {size =3D 19, tag =3D 54, id =3D 76 'L', cancelled =3D 0 '\000', =
complete =3D {entries =3D {
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sqh_first =3D 0x0, sqh_last =3D 0xaaa=
b00046870}}, s =3D 0xaaab000454b8, next =3D {
  =C2=A0=C2=A0=C2=A0=C2=A0le_next =3D 0xaaab000467c0, le_prev =3D 0xaaab000=
46f88}, idx =3D 88}
  (gdb)

  Address Sanitizer shows error and saying that there is a heap-use-
  after-free on *fidp*.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1840865/+subscriptions

