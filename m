Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E1EC43218
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 19:31:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C38A720693
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 19:31:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C38A720693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51150 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hK6Zh-0006WK-4H
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 15:31:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hK6YW-0005UA-RZ
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 15:30:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hK6YV-0007bq-98
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 15:30:44 -0400
Received: from indium.canonical.com ([91.189.90.7]:34138)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hK6YV-0007bI-42
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 15:30:43 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hK6YU-0002BH-2p
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 19:30:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 0A1B02E8058
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 19:30:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Apr 2019 19:22:59 -0000
From: Ben Wibking <1826599@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: bwibking
X-Launchpad-Bug-Reporter: Ben Wibking (bwibking)
X-Launchpad-Bug-Modifier: Ben Wibking (bwibking)
Message-Id:
 <155630657999.13303.12667909935236826379.malonedeb@wampee.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18928";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 33bfb9a40c6b8e8f6e56879b62f0b217b54197f4
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1826599] [NEW] qemu crashes with HV_ERROR with
 any guest when using HVF on macos
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
Reply-To: Bug 1826599 <1826599@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190426192259.rLABm0YT08AKEPBMHERFqgoT4SlfEBlAE9vfsh-NjF8@z>

Public bug reported:

qemu reliably crashes (after some unknown amount of time) for any guest
I've run on macOS (10.14.4) with HVF acceleration.

I'm using the latest development tree:
% qemu-system-x86_64 --version
QEMU emulator version 4.0.50 (v4.0.0-rc4-52-g3284aa1281-dirty)
Copyright (c) 2003-2019 Fabrice Bellard and the QEMU Project developers

I'm currently running Haiku. After booting and running normally for a
few minutes, it abruptly crashes and shows this error on stdout (I'm
including the command line arguments):

+ ISO=3Dhaiku-release-anyboot.iso
+ ACCEL=3D'-accel hvf -machine type=3Dq35,accel=3Dhvf'
+ MEM=3D'-m 1G'
+ SMP=3D'-c 2'
+ NET=3D'-device virtio-net,netdev=3Dvmnic -netdev user,id=3Dvmnic'
+ IMG_CD=3D'-cdrom haiku-release-anyboot.iso'
+ IMG_HDD=3D'-device virtio-scsi-pci,id=3Dscsi -drive if=3Dnone,id=3Dvd0,fi=
le=3Dhaiku.img,format=3Draw -device scsi-hd,drive=3Dvd0'
+ DISPLAY=3D'-usb -device usb-tablet'
+ qemu-system-x86_64 -accel hvf -machine type=3Dq35,accel=3Dhvf -usb -devic=
e usb-tablet -m 1G -device virtio-net,netdev=3Dvmnic -netdev user,id=3Dvmni=
c -device virtio-scsi-pci,id=3Dscsi -drive if=3Dnone,id=3Dvd0,file=3Dhaiku.=
img,format=3Draw -device scsi-hd,drive=3Dvd0
qemu-system-x86_64: warning: host doesn't support requested feature: CPUID.=
80000001H:ECX.svm [bit 2]
qemu-system-x86_64: Error: HV_ERROR
./qemu-boot.sh: line 19: 67497 Abort trap: 6           qemu-system-x86_64 $=
ACCEL $CPU $EFI $DISPLAY $MEM $NET $IMG_HDD

** Affects: qemu
     Importance: Undecided
         Status: New

** Description changed:

  qemu reliably crashes (after some unknown amount of time) for any guest
- I've run on macos with HVF acceleration.
+ I've run on macOS (10.14.4) with HVF acceleration.
  =

  I'm currently running Haiku. After booting and running normally for a
  few minutes, it abruptly crashes and shows this error on stdout (I'm
  including the command line arguments):
  =

  + ISO=3Dhaiku-release-anyboot.iso
  + ACCEL=3D'-accel hvf -machine type=3Dq35,accel=3Dhvf'
  + MEM=3D'-m 1G'
  + SMP=3D'-c 2'
  + NET=3D'-device virtio-net,netdev=3Dvmnic -netdev user,id=3Dvmnic'
  + IMG_CD=3D'-cdrom haiku-release-anyboot.iso'
  + IMG_HDD=3D'-device virtio-scsi-pci,id=3Dscsi -drive if=3Dnone,id=3Dvd0,=
file=3Dhaiku.img,format=3Draw -device scsi-hd,drive=3Dvd0'
  + DISPLAY=3D'-usb -device usb-tablet'
  + qemu-system-x86_64 -accel hvf -machine type=3Dq35,accel=3Dhvf -usb -dev=
ice usb-tablet -m 1G -device virtio-net,netdev=3Dvmnic -netdev user,id=3Dvm=
nic -device virtio-scsi-pci,id=3Dscsi -drive if=3Dnone,id=3Dvd0,file=3Dhaik=
u.img,format=3Draw -device scsi-hd,drive=3Dvd0
  qemu-system-x86_64: warning: host doesn't support requested feature: CPUI=
D.80000001H:ECX.svm [bit 2]
  qemu-system-x86_64: Error: HV_ERROR
  ./qemu-boot.sh: line 19: 67497 Abort trap: 6           qemu-system-x86_64=
 $ACCEL $CPU $EFI $DISPLAY $MEM $NET $IMG_HDD

** Description changed:

  qemu reliably crashes (after some unknown amount of time) for any guest
  I've run on macOS (10.14.4) with HVF acceleration.
+ =

+ I'm using the latest development tree:
+ % qemu-system-x86_64 --version
+ QEMU emulator version 4.0.50 (v4.0.0-rc4-52-g3284aa1281-dirty)
+ Copyright (c) 2003-2019 Fabrice Bellard and the QEMU Project developers
  =

  I'm currently running Haiku. After booting and running normally for a
  few minutes, it abruptly crashes and shows this error on stdout (I'm
  including the command line arguments):
  =

  + ISO=3Dhaiku-release-anyboot.iso
  + ACCEL=3D'-accel hvf -machine type=3Dq35,accel=3Dhvf'
  + MEM=3D'-m 1G'
  + SMP=3D'-c 2'
  + NET=3D'-device virtio-net,netdev=3Dvmnic -netdev user,id=3Dvmnic'
  + IMG_CD=3D'-cdrom haiku-release-anyboot.iso'
  + IMG_HDD=3D'-device virtio-scsi-pci,id=3Dscsi -drive if=3Dnone,id=3Dvd0,=
file=3Dhaiku.img,format=3Draw -device scsi-hd,drive=3Dvd0'
  + DISPLAY=3D'-usb -device usb-tablet'
  + qemu-system-x86_64 -accel hvf -machine type=3Dq35,accel=3Dhvf -usb -dev=
ice usb-tablet -m 1G -device virtio-net,netdev=3Dvmnic -netdev user,id=3Dvm=
nic -device virtio-scsi-pci,id=3Dscsi -drive if=3Dnone,id=3Dvd0,file=3Dhaik=
u.img,format=3Draw -device scsi-hd,drive=3Dvd0
  qemu-system-x86_64: warning: host doesn't support requested feature: CPUI=
D.80000001H:ECX.svm [bit 2]
  qemu-system-x86_64: Error: HV_ERROR
  ./qemu-boot.sh: line 19: 67497 Abort trap: 6           qemu-system-x86_64=
 $ACCEL $CPU $EFI $DISPLAY $MEM $NET $IMG_HDD

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1826599

Title:
  qemu crashes with HV_ERROR with any guest when using HVF on macos

Status in QEMU:
  New

Bug description:
  qemu reliably crashes (after some unknown amount of time) for any
  guest I've run on macOS (10.14.4) with HVF acceleration.

  I'm using the latest development tree:
  % qemu-system-x86_64 --version
  QEMU emulator version 4.0.50 (v4.0.0-rc4-52-g3284aa1281-dirty)
  Copyright (c) 2003-2019 Fabrice Bellard and the QEMU Project developers

  I'm currently running Haiku. After booting and running normally for a
  few minutes, it abruptly crashes and shows this error on stdout (I'm
  including the command line arguments):

  + ISO=3Dhaiku-release-anyboot.iso
  + ACCEL=3D'-accel hvf -machine type=3Dq35,accel=3Dhvf'
  + MEM=3D'-m 1G'
  + SMP=3D'-c 2'
  + NET=3D'-device virtio-net,netdev=3Dvmnic -netdev user,id=3Dvmnic'
  + IMG_CD=3D'-cdrom haiku-release-anyboot.iso'
  + IMG_HDD=3D'-device virtio-scsi-pci,id=3Dscsi -drive if=3Dnone,id=3Dvd0,=
file=3Dhaiku.img,format=3Draw -device scsi-hd,drive=3Dvd0'
  + DISPLAY=3D'-usb -device usb-tablet'
  + qemu-system-x86_64 -accel hvf -machine type=3Dq35,accel=3Dhvf -usb -dev=
ice usb-tablet -m 1G -device virtio-net,netdev=3Dvmnic -netdev user,id=3Dvm=
nic -device virtio-scsi-pci,id=3Dscsi -drive if=3Dnone,id=3Dvd0,file=3Dhaik=
u.img,format=3Draw -device scsi-hd,drive=3Dvd0
  qemu-system-x86_64: warning: host doesn't support requested feature: CPUI=
D.80000001H:ECX.svm [bit 2]
  qemu-system-x86_64: Error: HV_ERROR
  ./qemu-boot.sh: line 19: 67497 Abort trap: 6           qemu-system-x86_64=
 $ACCEL $CPU $EFI $DISPLAY $MEM $NET $IMG_HDD

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1826599/+subscriptions

