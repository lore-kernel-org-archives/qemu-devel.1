Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7309FC35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 15:56:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 495392084E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 15:56:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 495392084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz0Yn-00083q-HS
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 10:56:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59871)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iz0Y3-0007M7-Pz
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 10:55:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iz0Y2-0006ot-Fj
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 10:55:35 -0500
Received: from indium.canonical.com ([91.189.90.7]:52982)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iz0Y2-0006lw-74
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 10:55:34 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iz0Y1-000304-9s
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2020 15:55:33 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 3724B2E804A
 for <qemu-devel@nongnu.org>; Tue,  4 Feb 2020 15:55:33 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Feb 2020 15:48:42 -0000
From: Maarten <1861884@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: mvgijssel
X-Launchpad-Bug-Reporter: Maarten (mvgijssel)
X-Launchpad-Bug-Modifier: Maarten (mvgijssel)
References: <158083099190.20144.2427615447806299744.malonedeb@wampee.canonical.com>
Message-Id: <158083132308.27184.9025299138991480078.launchpad@soybean.canonical.com>
Subject: [Bug 1861884] Re: qemu socket multicast not working
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="0a62c17273454a1313f81a74a2198ec30b44c7b6";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: cc19c4d1c2d96c9d023b316b68e2fa154a45d394
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
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
Reply-To: Bug 1861884 <1861884@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

** Description changed:

  Running two qemu vms on the same socket multicast address:
  =

  =C2=A0=C2=A0qemu-system-x86_64 -m 2048 -smp 2 -serial mon:stdio
-     -display none -vga none
+ =C2=A0=C2=A0=C2=A0=C2=A0-display none -vga none
  =C2=A0=C2=A0=C2=A0=C2=A0-nodefaults -accel hax
  =C2=A0=C2=A0=C2=A0=C2=A0-netdev user,id=3Dmynet0
  =C2=A0=C2=A0=C2=A0=C2=A0-device virtio-net-pci,netdev=3Dmynet0
  =C2=A0=C2=A0=C2=A0=C2=A0-netdev socket,id=3Dvlan,mcast=3D239.192.0.1:1235
  =C2=A0=C2=A0=C2=A0=C2=A0-device virtio-net-pci,netdev=3Dvlan
  =C2=A0=C2=A0=C2=A0=C2=A0-device virtio-rng-pci
  =C2=A0=C2=A0=C2=A0=C2=A0-drive file=3Dworker.qcow2,if=3Dvirtio
  =C2=A0=C2=A0=C2=A0=C2=A0-drive file=3Dcloud-init.iso,format=3Draw,if=3Dvi=
rtio
  =

  The two machines have a static ip on the socket network interface,
  192.168.100.11 and 192.168.100.12, but are unable to reach each other.
  =

+ Result when using ping command
+ =

+   PING 192.168.100.11 (192.168.100.11) 56(84) bytes of data.
+   From 192.168.100.12 icmp_seq=3D1 Destination Host Unreachable
+   From 192.168.100.12 icmp_seq=3D2 Destination Host Unreachable
+   From 192.168.100.12 icmp_seq=3D3 Destination Host Unreachable
+ =

  Is there additional configuration necessary on macos? Does this only
- work on Linux?
+ work on Linux? Is there additional configuration required inside of the
+ guest OS?
  =

  guest OS: Debian 10 (Buster)
  host OS: macOS 10.15.2
  qemu: 4.2.0

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1861884

Title:
  qemu socket multicast not working

Status in QEMU:
  New

Bug description:
  Running two qemu vms on the same socket multicast address:

  =C2=A0=C2=A0qemu-system-x86_64 -m 2048 -smp 2 -serial mon:stdio
  =C2=A0=C2=A0=C2=A0=C2=A0-display none -vga none
  =C2=A0=C2=A0=C2=A0=C2=A0-nodefaults -accel hax
  =C2=A0=C2=A0=C2=A0=C2=A0-netdev user,id=3Dmynet0
  =C2=A0=C2=A0=C2=A0=C2=A0-device virtio-net-pci,netdev=3Dmynet0
  =C2=A0=C2=A0=C2=A0=C2=A0-netdev socket,id=3Dvlan,mcast=3D239.192.0.1:1235
  =C2=A0=C2=A0=C2=A0=C2=A0-device virtio-net-pci,netdev=3Dvlan
  =C2=A0=C2=A0=C2=A0=C2=A0-device virtio-rng-pci
  =C2=A0=C2=A0=C2=A0=C2=A0-drive file=3Dworker.qcow2,if=3Dvirtio
  =C2=A0=C2=A0=C2=A0=C2=A0-drive file=3Dcloud-init.iso,format=3Draw,if=3Dvi=
rtio

  The two machines have a static ip on the socket network interface,
  192.168.100.11 and 192.168.100.12, but are unable to reach each other.

  Result when using ping command

    PING 192.168.100.11 (192.168.100.11) 56(84) bytes of data.
    From 192.168.100.12 icmp_seq=3D1 Destination Host Unreachable
    From 192.168.100.12 icmp_seq=3D2 Destination Host Unreachable
    From 192.168.100.12 icmp_seq=3D3 Destination Host Unreachable

  Is there additional configuration necessary on macos? Does this only
  work on Linux? Is there additional configuration required inside of
  the guest OS?

  guest OS: Debian 10 (Buster)
  host OS: macOS 10.15.2
  qemu: 4.2.0

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1861884/+subscriptions

