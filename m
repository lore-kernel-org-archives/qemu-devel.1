Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2513FA372A
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 17:31:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A78A82064B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 17:31:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A78A82064B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKn9M-0007tb-Ph
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 13:31:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46012)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iKn8N-0007Rq-3n
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 13:30:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iKn8L-0004b7-P1
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 13:30:51 -0400
Received: from indium.canonical.com ([91.189.90.7]:46824)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iKn8L-0004Zy-4s
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 13:30:49 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iKn8J-0006Mj-3B
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2019 17:30:47 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 171B92E80C0
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2019 17:30:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Oct 2019 17:19:47 -0000
From: Anastasios Vacharakis <1848244@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: docmax3
X-Launchpad-Bug-Reporter: Anastasios Vacharakis (docmax3)
X-Launchpad-Bug-Modifier: Anastasios Vacharakis (docmax3)
References: <157116697702.19855.6802467063820397619.malonedeb@gac.canonical.com>
Message-Id: <157124638777.22114.14872963198001534244.malone@wampee.canonical.com>
Subject: [Bug 1848244] Re: QEMU KVM IGD SandyBridge Passthrough crash
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="186023fa645d8be19d403a76064f0643f510db2f";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 21f509f385144b72445b61f9cddce530fd0b5809
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Reply-To: Bug 1848244 <1848244@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Solved: I added kvm.ignore_msrs=3D1 to kernel parameter!

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1848244

Title:
  QEMU KVM IGD SandyBridge Passthrough crash

Status in QEMU:
  New

Bug description:
  I try to passthrough my Intel GPU with this command:

  qemu-system-x86_64 -nodefaults -parallel none -k de -rtc
  base=3Dlocaltime -serial unix:/run/qemu/win7-serial.sock,server,nowait
  -monitor unix:/run/qemu/win7-monitor.sock,server,nowait -netdev
  user,id=3Dnet0 -device virtio-net-pci,netdev=3Dnet0,mac=3D52:54:00:00:00:=
07
  -device vfio-pci,host=3D0000:00:02.0,addr=3D0x2 -device vfio-
  pci,host=3D0000:00:1b.0 -device virtio-keyboard-pci -device virtio-
  mouse-pci -object input-linux,id=3Dkbd1,evdev=3D/dev/input/by-
  path/pci-0000:00:1a.0-usb-0:1.2.2:1.2-event-kbd,grab_all=3Don,repeat=3Don
  -object input-linux,id=3Dmouse1,evdev=3D/dev/input/by-
  path/pci-0000:00:1a.0-usb-0:1.2.2:1.2-event-mouse -enable-kvm -cpu
  host -smp 4,sockets=3D1,cores=3D4,threads=3D1 -vga none -display none -m =
2g
  -device virtio-blk-pci,drive=3Dboot,bootindex=3D1 -drive
  file=3D/opt/vm/qcow2/win7.qcow2,format=3Dqcow2,if=3Dnone,id=3Dboot

  This ONLY works if i remove "-enable-kvm" else the windows (7 and 10)
  boot crashes in bluescreen "stop 0x0000003b" (probably while loading
  the intel gpu driver (intel graphics 3000).

  The system is an older ThinkPad T420 with Intel(R) Core(TM) i5-2520M
  CPU @ 2.50GHz.

  CMDLINE: BOOT_IMAGE=3D/vmlinuz-linux root=3DLABEL=3Droot rw ipv6.disable=
=3D0
  net.ifnames=3D0 intel_iommu=3Don iommu=3Dpt video=3DLVDS-1:d

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1848244/+subscriptions

