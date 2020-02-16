Return-Path: <SRS0=HvqS=4E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F5A8C2BA83
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 19:36:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2FAC2072C
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 19:36:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2FAC2072C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3Pi4-0001Vq-3D
	for qemu-devel@archiver.kernel.org; Sun, 16 Feb 2020 14:36:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33776)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1j3PhU-00016f-Qg
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 14:35:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1j3PhT-0007SI-HA
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 14:35:32 -0500
Received: from indium.canonical.com ([91.189.90.7]:36718)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1j3PhT-0007Pj-74
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 14:35:31 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1j3PhR-0008Ia-D5
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2020 19:35:29 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 5853D2E802B
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2020 19:35:29 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 16 Feb 2020 19:27:41 -0000
From: Helmut <1863508@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: helmutsch
X-Launchpad-Bug-Reporter: Helmut (helmutsch)
X-Launchpad-Bug-Modifier: Helmut (helmutsch)
Message-Id: <158188126194.31124.5348536044519461550.malonedeb@wampee.canonical.com>
Subject: [Bug 1863508] [NEW] qemu-system-arm stops with SIGSEGV in
 helper_gvec_eq16
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="19413b719a8df7423ab1390528edadce9e0e4aca";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 1791aac448f0786b4f39e88a2112c53f289a0f55
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
Reply-To: Bug 1863508 <1863508@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

Segmentation fault when trying to start FreeBSD-arm system with qemu-
system-arm (version 4.1.1 on Fedora 31)

Commandline:
gdb -q --args /bin/qemu-system-arm \
 -name FreeBSD12,debug-threads=3Don \
 -m 1536 -machine virt -smp 2 \
 -M virt,highmem=3Doff -serial mon:stdio -monitor telnet::45452,server,nowa=
it \
 -machine virt,accel=3Dtcg,usb=3Doff,dump-guest-core=3Doff,gic-version=3D2 \
 -overcommit mem-lock=3Doff -no-reboot -device virtio-rng-device \
 -bios u-boot-qemu.bin \
 -drive file=3DFreeBSD-12.1-RELEASE-arm-armv7-CUBIEBOARD2.img,if=3Dnone,id=
=3Ddrive0,format=3Draw \
 -device ich9-ahci,id=3Dahci -device ide-drive,drive=3Ddrive0,bus=3Dahci.0 =


Results:
....
Mounting local filesystems:.

Thread 4 "CPU 1/TCG" received signal SIGSEGV, Segmentation fault.
[Switching to Thread 0x7fffcedfe700 (LWP 53608)]
0x00005555558d9332 in helper_gvec_eq16 (d=3D0x5555566748d8, a=3D0x555556674=
8e0, b=3D0x5555566748d0, desc=3D0) at /usr/src/debug/qemu-4.1.1-1.fc31.x86_=
64/accel/tcg/tcg-runtime-gvec.c:948
948     DO_CMP2(16)

Tested different versions of qemu. qemu-3.0.1 worked, but qemu-3.1.1
failed with the same error.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1863508

Title:
  qemu-system-arm stops with SIGSEGV in helper_gvec_eq16

Status in QEMU:
  New

Bug description:
  Segmentation fault when trying to start FreeBSD-arm system with qemu-
  system-arm (version 4.1.1 on Fedora 31)

  Commandline:
  gdb -q --args /bin/qemu-system-arm \
   -name FreeBSD12,debug-threads=3Don \
   -m 1536 -machine virt -smp 2 \
   -M virt,highmem=3Doff -serial mon:stdio -monitor telnet::45452,server,no=
wait \
   -machine virt,accel=3Dtcg,usb=3Doff,dump-guest-core=3Doff,gic-version=3D=
2 \
   -overcommit mem-lock=3Doff -no-reboot -device virtio-rng-device \
   -bios u-boot-qemu.bin \
   -drive file=3DFreeBSD-12.1-RELEASE-arm-armv7-CUBIEBOARD2.img,if=3Dnone,i=
d=3Ddrive0,format=3Draw \
   -device ich9-ahci,id=3Dahci -device ide-drive,drive=3Ddrive0,bus=3Dahci.=
0 =


  Results:
  ....
  Mounting local filesystems:.

  Thread 4 "CPU 1/TCG" received signal SIGSEGV, Segmentation fault.
  [Switching to Thread 0x7fffcedfe700 (LWP 53608)]
  0x00005555558d9332 in helper_gvec_eq16 (d=3D0x5555566748d8, a=3D0x5555566=
748e0, b=3D0x5555566748d0, desc=3D0) at /usr/src/debug/qemu-4.1.1-1.fc31.x8=
6_64/accel/tcg/tcg-runtime-gvec.c:948
  948     DO_CMP2(16)

  Tested different versions of qemu. qemu-3.0.1 worked, but qemu-3.1.1
  failed with the same error.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1863508/+subscriptions

