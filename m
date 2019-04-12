Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0516FC10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 07:12:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6C5320850
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 07:12:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6C5320850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60084 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEqM2-0003Ml-Jo
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 03:12:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hEqLE-00031U-Fd
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 03:11:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hEqLD-0007tZ-9z
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 03:11:16 -0400
Received: from indium.canonical.com ([91.189.90.7]:34510)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hEqLD-0007t0-1y
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 03:11:15 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hEqLB-0000el-AP
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 07:11:13 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 411512E80CC
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 07:11:13 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Apr 2019 06:57:24 -0000
From: Thomas Huth <1523246@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Committed; importance=Wishlist;
	assignee=None; 
X-Launchpad-Bug-Tags: trim virtio windows
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: jamespharvey20 manouchehri mikemol rustamabd
	socketpair stefanha th-huth
X-Launchpad-Bug-Reporter: David Manouchehri (manouchehri)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <20151206150708.14182.82430.malonedeb@wampee.canonical.com>
Message-Id:
 <155505224494.13466.17362266628532802598.malone@gac.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18920";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 3862e2825d3335fd823395d0b23341dac04ed24d
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1523246] Re: Virtio-blk does not support TRIM
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
Reply-To: Bug 1523246 <1523246@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412065724.TzvHniZ2UXkqbVd_6ndWryrpfbz4WqNnyDImP1zVzZ8@z>

The DISCARD feature has now been implemented in QEMU, too:
https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3D37b06f8d46fe602e630e4

** Changed in: qemu
       Status: Confirmed =3D> Fix Committed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1523246

Title:
  Virtio-blk does not support TRIM

Status in QEMU:
  Fix Committed

Bug description:
  When model=3Dvirtio is used, TRIM is not supported.

  # mount -o discard /dev/vda4 /mnt
  # mount | tail -1
  /dev/vda4 on /mnt type fuseblk (rw,nosuid,nodev,relatime,user_id=3D0,grou=
p_id=3D0,allow_other,blksize=3D4096)
  # fstrim /mnt/
  fstrim: /mnt/: the discard operation is not supported

  Booting without model=3Dvirtio allows using TRIM (in Windows as well).

  Full QEMU line:

  qemu-system-x86_64 -enable-kvm -cpu host -bios
  /usr/share/ovmf/ovmf_x64.bin -smp 2 -m 7G -vga qxl -usbdevice tablet
  -net nic,model=3Dvirtio -net user -drive discard=3Dunmap,detect-
  zeroes=3Dunmap,cache=3Dnone,file=3Dvms/win10.hd.img.vmdk,format=3Dvmdk,if=
=3Dvirtio

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1523246/+subscriptions

