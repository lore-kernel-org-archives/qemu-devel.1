Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E715ECE58D
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 13:44:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2296D206BB
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 13:44:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2296D206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHTJe-0004jB-05
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 09:44:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60906)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iHTFt-0001DS-EF
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 09:40:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iHTFr-0001Om-4N
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 09:40:53 -0400
Received: from indium.canonical.com ([91.189.90.7]:55806)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iHTFq-0001OM-Rp
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 09:40:51 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iHTFp-0001fJ-H7
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2019 13:40:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 6CA8B2E8079
 for <qemu-devel@nongnu.org>; Mon,  7 Oct 2019 13:40:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Oct 2019 13:33:00 -0000
From: Leonardo <1846816@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: aix ppc
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: gkurz leohori philmd th-huth
X-Launchpad-Bug-Reporter: Leonardo (leohori)
X-Launchpad-Bug-Modifier: Leonardo (leohori)
References: <157021536568.1047.12130451733202459497.malonedeb@chaenomeles.canonical.com>
Message-Id: <157045518088.9787.12242685135568827194.malone@wampee.canonical.com>
Subject: [Bug 1846816] Re: Booting error on AIX 6.1 "Illegal Trap Instruction
 Interrupt in Kernel""
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="af2eefe214bd95389a09b7c956720881bab16807";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: a005811437c15f4c7b732dca55b3cff5b4c8ba79
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
Reply-To: Bug 1846816 <1846816@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

# qemu-system-ppc64 -cpu POWER8 -machine pseries,max-cpu-compat=3Dpower7 -m=
 8G -d unimp -serial stdio \
-prom-env boot-command=3D'boot cdrom: -s verbose'> -drive file=3D/qemu/AIX6=
1.img,if=3Dnone,id=3Ddrive-virtio-disk0 \
> -device virtio-scsi-pci,id=3Dscsi -device scsi-hd,drive=3Ddrive-virtio-di=
sk0 \
> -cdrom /qemu/AIX.vol1.iso \
> -prom-env boot-command=3D'boot cdrom: -s verbose'
VNC server running on ::1:5900
qemu-system-ppc64: warning: TCG doesn't support requested feature, cap-ibs=
=3Dworkaround


SLOF **********************************************************************
QEMU Starting
 Build Date =3D Jul  3 2019 12:26:14
 FW Version =3D git-ba1ab360eebe6338
 Press "s" to enter Open Firmware.

Populating /vdevice methods
Populating /vdevice/vty@71000000
Populating /vdevice/nvram@71000001
Populating /vdevice/l-lan@71000002
Populating /vdevice/v-scsi@71000003
       SCSI: Looking for devices
          8200000000000000 CD-ROM   : "QEMU     QEMU CD-ROM      2.5+"
Populating /pci@800000020000000
                     00 0000 (D) : 1234 1111    qemu vga
                     00 0800 (D) : 1033 0194    serial bus [ usb-xhci ]
                     00 1000 (D) : 1af4 1004    virtio [ scsi ]
Populating /pci@800000020000000/scsi@2
       SCSI: Looking for devices
          100000000000000 DISK     : "QEMU     QEMU HARDDISK    2.5+"
Installing QEMU fb


Scanning USB
  XHCI: Initializing
    USB Keyboard
    USB mouse
No console specified using screen & keyboard

  Welcome to Open Firmware

  Copyright (c) 2004, 2017 IBM Corporation All rights reserved.
  This program and the accompanying materials are made available
  under the terms of the BSD License available at
  http://www.opensource.org/licenses/bsd-license.php


Trying to load: -s verbose from: /vdevice/v-scsi@71000003/disk@820000000000=
0000: ...   Successfully loaded
qemu-system-ppc64: Couldn't negotiate a suitable PVR during CAS
AIX Unimplemented SPAPR hcall 0x00000000000000ec
StarUnimplemented SPAPR hcall 0x00000000000000ec
LED{814}

AIX Version 6.1
exec(/etc/init){1,0}

INIT: EXECUTING /sbin/rc.boot 1
exec(/usr/bin/sh,-c,/sbin/rc.boot 1){1114146,1}
Unimplemented SPAPR hcall 0x00000000000002b8
Unimplemented SPAPR hcall 0x00000000000002b8
exec(/sbin/rc.boot,/sbin/rc.boot,1){1114146,1}
Unimplemented SPAPR hcall 0x00000000000002b8
+ PHASE=3D1
+ + bootinfo -p
exec(/usr/sbin/bootinfo,-p){1179684,1114146}
Unimplemented SPAPR hcall 0x00000000000002b8
PLATFORM=3Dchrp
+ [ ! -x /usr/lib/boot/bin/bootinfo_chrp ]
+ [ 1 -eq 1 ]
+ 1> /usr/lib/libc.a
+ init -c unlink /usr/lib/boot/bin/!(*_chrp)
Unimplemented SPAPR hcall 0x00000000000002b8
exec(/etc/init,-c,unlink /usr/lib/boot/bin/!(*_chrp)){1179686,1114146}
Unimplemented SPAPR hcall 0x00000000000002b8
+ chramfs -t
exec(/usr/sbin/chramfs,-t){1179688,1114146}
Unimplemented SPAPR hcall 0x00000000000002b8
Unimplemented SPAPR hcall 0x00000000000002b8
Unimplemented SPAPR hcall 0x00000000000002b8
Unimplemented SPAPR hcall 0x00000000000002b8
Unimplemented SPAPR hcall 0x00000000000002b8
Unimplemented SPAPR hcall 0x00000000000002b8
Unimplemented SPAPR hcall 0x00000000000002b8
+ init -c unlink /usr/sbin/chramfs
+ 1> /dev/null
exec(/etc/init,-c,unlink /usr/sbin/chramfs){1179690,1114146}
Unimplemented SPAPR hcall 0x00000000000002b8
+ + bootinfo -t
exec(/usr/sbin/bootinfo,-t){1179692,1114146}
Unimplemented SPAPR hcall 0x00000000000002b8
BOOTYPE=3D3
+ [ 0 -ne 0 ]
+ [ -z 3 ]
+ unset pdev_to_ldev undolt native_netboot_cfg
+ unset disknet_odm_init config_ATM
+ /usr/lib/methods/showled 0x510 DEV CFG 1 START
Unimplemented SPAPR hcall 0x00000000000002b8
exec(/usr/lib/methods/showled,0x510,DEV CFG 1 START){1179694,1114146}
Unimplemented SPAPR hcall 0x00000000000002b8
+ cfgmgr -f -v
exec(/usr/sbin/cfgmgr,-f,-v){1179696,1114146}
Unimplemented SPAPR hcall 0x00000000000002b8
Unimplemented SPAPR hcall 0x00000000000002b8
cfgmgr is running in phase 1
----------------
Time: 0 LEDS: 0x538
Invoking top level program -- "/etc/methods/defsys"
exec(/bin/sh,-c,/etc/methods/defsys ){1245222,1179696}
Unimplemented SPAPR hcall 0x00000000000002b8
exec(/etc/methods/defsys){1245222,1179696}
Unimplemented SPAPR hcall 0x00000000000002b8
exec(/bin/sh,-c,/usr/lib/methods/define_rspc -n -c sys -s node -t chrp){131=
0760,1245222}
Unimplemented SPAPR hcall 0x00000000000002b8
exec(/usr/lib/methods/define_rspc,-n,-c,sys,-s,node,-t,chrp){1310760,124522=
2}
Unimplemented SPAPR hcall 0x00000000000002b8
Time: 0 LEDS: 0x539
Return code =3D 0
***** stdout *****
sys0

*** no stderr ****
Unimplemented SPAPR hcall 0x00000000000002b8
----------------
Attempting to configure device 'sys0'
Time: 0 LEDS: 0x811
Invoking /usr/lib/methods/cfgsys_chrp -1 -l sys0
exec(/bin/sh,-c,/usr/lib/methods/cfgsys_chrp -1 -l sys0){1245224,1179696}
Number of running methods: 1
Unimplemented SPAPR hcall 0x00000000000002b8
exec(/usr/lib/methods/cfgsys_chrp,-1,-l,sys0){1245224,1179696}
Unimplemented SPAPR hcall 0x00000000000002b8
LED{A20}
Illegal Trap Instruction Interrupt in Kernel
04151A74      tweqi    r0,0                r0=3D0
KDB(0)>
KDB(0)> stack
pvthread+002100 STACK:
[04151A74]init_extint_chrp+0001B4 (0000000000000000 [??])
[0415030C]config_pal+00004C (??)
[04152D9C]config_chrp_pal@AF31_1+00009C (??, ??)
[00665BBC]config_kmod+0000DC (??, ??, ??)
[00666650]sysconfig+0001F0 (??, ??, ??)
[00003850]ovlya_addr_sc_flih_main+000130 ()
[10004D48]cfgpal_chrp+0004A8 (??)
[100045AC]configure_device+00004C ()
[100011B4]make_dvc_available+000034 ()
[10000568]main+000248 (??, ??, ??)
[10000168]__start+000068 ()

KDB(0)>


** Description changed:

  # ls -ltr
  total 8750584
  -rw-rw-r--  1 linux linux 4274997248 Oct  4 18:33 AIX.vol1.iso
  -rw-rw-r--  1 linux linux 4293888000 Oct  4 18:45 AIX.vol2.iso
  -rw-rw-r--  1 linux linux  391485440 Oct  4 18:50 AIX.vol3.iso
  -rw-r--r--  1 root  root      204608 Oct  4 19:00 AIX61.img
  =

  # qemu-system-ppc64 -cpu POWER8,compat=3Dpower7 -machine pseries -m 8192 =
-serial mon:stdio \
- > -drive file=3D/qemu/BST/AIX61.img,if=3Dnone,id=3Ddrive-virtio-disk0 \
+ > -drive file=3D/qemu/AIX61.img,if=3Dnone,id=3Ddrive-virtio-disk0 \
  > -device virtio-scsi-pci,id=3Dscsi -device scsi-hd,drive=3Ddrive-virtio-=
disk0 \
- > -cdrom /qemu/BST/AIX.vol1.iso \
+ > -cdrom /qemu/AIX.vol1.iso \
  > -prom-env boot-command=3D'boot cdrom: -s verbose'
- =

  =

  VNC server running on ::1:5900
  qemu-system-ppc64: warning: TCG doesn't support requested feature, cap-ib=
s=3Dworkaround
  =

- =

  SLOF ********************************************************************=
**
  QEMU Starting
-  Build Date =3D Jul  3 2019 12:26:14
-  FW Version =3D git-ba1ab360eebe6338
-  Press "s" to enter Open Firmware.
+ =C2=A0Build Date =3D Jul  3 2019 12:26:14
+ =C2=A0FW Version =3D git-ba1ab360eebe6338
+ =C2=A0Press "s" to enter Open Firmware.
  =

  Populating /vdevice methods
  Populating /vdevice/vty@71000000
  Populating /vdevice/nvram@71000001
  Populating /vdevice/l-lan@71000002
  Populating /vdevice/v-scsi@71000003
-        SCSI: Looking for devices
-           8200000000000000 CD-ROM   : "QEMU     QEMU CD-ROM      2.5+"
+ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0SCSI: Looking for devices
+ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A08200000000000=
000 CD-ROM   : "QEMU     QEMU CD-ROM      2.5+"
  Populating /pci@800000020000000
-                      00 0000 (D) : 1234 1111    qemu vga
-                      00 0800 (D) : 1033 0194    serial bus [ usb-xhci ]
-                      00 1000 (D) : 1af4 1004    virtio [ scsi ]
+ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A000 0000 (D) : 1234 11=
11    qemu vga
+ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A000 0800 (D) : 1033 01=
94    serial bus [ usb-xhci ]
+ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A000 1000 (D) : 1af4 10=
04    virtio [ scsi ]
  Populating /pci@800000020000000/scsi@2
-        SCSI: Looking for devices
-           100000000000000 DISK     : "QEMU     QEMU HARDDISK    2.5+"
+ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0SCSI: Looking for devices
+ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A01000000000000=
00 DISK     : "QEMU     QEMU HARDDISK    2.5+"
  Installing QEMU fb
  =

- =

  Scanning USB
-   XHCI: Initializing
-     USB Keyboard
-     USB mouse
+ =C2=A0=C2=A0XHCI: Initializing
+ =C2=A0=C2=A0=C2=A0=C2=A0USB Keyboard
+ =C2=A0=C2=A0=C2=A0=C2=A0USB mouse
  No console specified using screen & keyboard
  =

-   Welcome to Open Firmware
+ =C2=A0=C2=A0Welcome to Open Firmware
  =

-   Copyright (c) 2004, 2017 IBM Corporation All rights reserved.
-   This program and the accompanying materials are made available
-   under the terms of the BSD License available at
-   http://www.opensource.org/licenses/bsd-license.php
- =

+ =C2=A0=C2=A0Copyright (c) 2004, 2017 IBM Corporation All rights reserved.
+ =C2=A0=C2=A0This program and the accompanying materials are made available
+ =C2=A0=C2=A0under the terms of the BSD License available at
+ =C2=A0=C2=A0http://www.opensource.org/licenses/bsd-license.php
  =

  Trying to load: -s verbose from: /vdevice/v-scsi@71000003/disk@8200000000=
000000: ...   Successfully loaded
  qemu-system-ppc64: Couldn't negotiate a suitable PVR during CAS
  AIX
  StarLED{814}
  =

  AIX Version 6.1
  exec(/etc/init){1,0}
  =

  INIT: EXECUTING /sbin/rc.boot 1
  exec(/usr/bin/sh,-c,/sbin/rc.boot 1){1114146,1}
  exec(/sbin/rc.boot,/sbin/rc.boot,1){1114146,1}
  + PHASE=3D1
  + + bootinfo -p
  exec(/usr/sbin/bootinfo,-p){1179684,1114146}
  PLATFORM=3Dchrp
  + [ ! -x /usr/lib/boot/bin/bootinfo_chrp ]
  + [ 1 -eq 1 ]
  + 1> /usr/lib/libc.a
  + init -c unlink /usr/lib/boot/bin/!(*_chrp)
  exec(/etc/init,-c,unlink /usr/lib/boot/bin/!(*_chrp)){1179686,1114146}
  + chramfs -t
  exec(/usr/sbin/chramfs,-t){1179688,1114146}
  + init -c unlink /usr/sbin/chramfs
  + 1> /dev/null
  exec(/etc/init,-c,unlink /usr/sbin/chramfs){1179690,1114146}
  + + bootinfo -t
  exec(/usr/sbin/bootinfo,-t){1179692,1114146}
  BOOTYPE=3D3
  + [ 0 -ne 0 ]
  + [ -z 3 ]
  + unset pdev_to_ldev undolt native_netboot_cfg
  + unset disknet_odm_init config_ATM
  + /usr/lib/methods/showled 0x510 DEV CFG 1 START
  exec(/usr/lib/methods/showled,0x510,DEV CFG 1 START){1179694,1114146}
  + cfgmgr -f -v
  exec(/usr/sbin/cfgmgr,-f,-v){1179696,1114146}
  cfgmgr is running in phase 1
  ----------------
  Time: 0 LEDS: 0x538
  Invoking top level program -- "/etc/methods/defsys"
  exec(/bin/sh,-c,/etc/methods/defsys ){1245222,1179696}
  exec(/etc/methods/defsys){1245222,1179696}
  exec(/bin/sh,-c,/usr/lib/methods/define_rspc -n -c sys -s node -t chrp){1=
310760,1245222}
  exec(/usr/lib/methods/define_rspc,-n,-c,sys,-s,node,-t,chrp){1310760,1245=
222}
  Time: 0 LEDS: 0x539
  Return code =3D 0
  ***** stdout *****
  sys0
  =

  *** no stderr ****
  ----------------
  Attempting to configure device 'sys0'
  Time: 0 LEDS: 0x811
  Invoking /usr/lib/methods/cfgsys_chrp -1 -l sys0
  exec(/bin/sh,-c,/usr/lib/methods/cfgsys_chrp -1 -l sys0){1245224,1179696}
  Number of running methods: 1
  exec(/usr/lib/methods/cfgsys_chrp,-1,-l,sys0){1245224,1179696}
  LED{A20}
  Illegal Trap Instruction Interrupt in Kernel
  04151A74      tweqi    r0,0                r0=3D0
  KDB(0)>

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1846816

Title:
  Booting error on AIX 6.1 "Illegal Trap Instruction Interrupt in
  Kernel""

Status in QEMU:
  New

Bug description:
  # ls -ltr
  total 8750584
  -rw-rw-r--  1 linux linux 4274997248 Oct  4 18:33 AIX.vol1.iso
  -rw-rw-r--  1 linux linux 4293888000 Oct  4 18:45 AIX.vol2.iso
  -rw-rw-r--  1 linux linux  391485440 Oct  4 18:50 AIX.vol3.iso
  -rw-r--r--  1 root  root      204608 Oct  4 19:00 AIX61.img

  # qemu-system-ppc64 -cpu POWER8,compat=3Dpower7 -machine pseries -m 8192 =
-serial mon:stdio \
  > -drive file=3D/qemu/AIX61.img,if=3Dnone,id=3Ddrive-virtio-disk0 \
  > -device virtio-scsi-pci,id=3Dscsi -device scsi-hd,drive=3Ddrive-virtio-=
disk0 \
  > -cdrom /qemu/AIX.vol1.iso \
  > -prom-env boot-command=3D'boot cdrom: -s verbose'

  VNC server running on ::1:5900
  qemu-system-ppc64: warning: TCG doesn't support requested feature, cap-ib=
s=3Dworkaround

  SLOF ********************************************************************=
**
  QEMU Starting
  =C2=A0Build Date =3D Jul  3 2019 12:26:14
  =C2=A0FW Version =3D git-ba1ab360eebe6338
  =C2=A0Press "s" to enter Open Firmware.

  Populating /vdevice methods
  Populating /vdevice/vty@71000000
  Populating /vdevice/nvram@71000001
  Populating /vdevice/l-lan@71000002
  Populating /vdevice/v-scsi@71000003
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0SCSI: Looking for devices
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A08200000000000=
000 CD-ROM   : "QEMU     QEMU CD-ROM      2.5+"
  Populating /pci@800000020000000
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A000 0000 (D) : 1234 11=
11    qemu vga
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A000 0800 (D) : 1033 01=
94    serial bus [ usb-xhci ]
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A000 1000 (D) : 1af4 10=
04    virtio [ scsi ]
  Populating /pci@800000020000000/scsi@2
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0SCSI: Looking for devices
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A01000000000000=
00 DISK     : "QEMU     QEMU HARDDISK    2.5+"
  Installing QEMU fb

  Scanning USB
  =C2=A0=C2=A0XHCI: Initializing
  =C2=A0=C2=A0=C2=A0=C2=A0USB Keyboard
  =C2=A0=C2=A0=C2=A0=C2=A0USB mouse
  No console specified using screen & keyboard

  =C2=A0=C2=A0Welcome to Open Firmware

  =C2=A0=C2=A0Copyright (c) 2004, 2017 IBM Corporation All rights reserved.
  =C2=A0=C2=A0This program and the accompanying materials are made available
  =C2=A0=C2=A0under the terms of the BSD License available at
  =C2=A0=C2=A0http://www.opensource.org/licenses/bsd-license.php

  Trying to load: -s verbose from: /vdevice/v-scsi@71000003/disk@8200000000=
000000: ...   Successfully loaded
  qemu-system-ppc64: Couldn't negotiate a suitable PVR during CAS
  AIX
  StarLED{814}

  AIX Version 6.1
  exec(/etc/init){1,0}

  INIT: EXECUTING /sbin/rc.boot 1
  exec(/usr/bin/sh,-c,/sbin/rc.boot 1){1114146,1}
  exec(/sbin/rc.boot,/sbin/rc.boot,1){1114146,1}
  + PHASE=3D1
  + + bootinfo -p
  exec(/usr/sbin/bootinfo,-p){1179684,1114146}
  PLATFORM=3Dchrp
  + [ ! -x /usr/lib/boot/bin/bootinfo_chrp ]
  + [ 1 -eq 1 ]
  + 1> /usr/lib/libc.a
  + init -c unlink /usr/lib/boot/bin/!(*_chrp)
  exec(/etc/init,-c,unlink /usr/lib/boot/bin/!(*_chrp)){1179686,1114146}
  + chramfs -t
  exec(/usr/sbin/chramfs,-t){1179688,1114146}
  + init -c unlink /usr/sbin/chramfs
  + 1> /dev/null
  exec(/etc/init,-c,unlink /usr/sbin/chramfs){1179690,1114146}
  + + bootinfo -t
  exec(/usr/sbin/bootinfo,-t){1179692,1114146}
  BOOTYPE=3D3
  + [ 0 -ne 0 ]
  + [ -z 3 ]
  + unset pdev_to_ldev undolt native_netboot_cfg
  + unset disknet_odm_init config_ATM
  + /usr/lib/methods/showled 0x510 DEV CFG 1 START
  exec(/usr/lib/methods/showled,0x510,DEV CFG 1 START){1179694,1114146}
  + cfgmgr -f -v
  exec(/usr/sbin/cfgmgr,-f,-v){1179696,1114146}
  cfgmgr is running in phase 1
  ----------------
  Time: 0 LEDS: 0x538
  Invoking top level program -- "/etc/methods/defsys"
  exec(/bin/sh,-c,/etc/methods/defsys ){1245222,1179696}
  exec(/etc/methods/defsys){1245222,1179696}
  exec(/bin/sh,-c,/usr/lib/methods/define_rspc -n -c sys -s node -t chrp){1=
310760,1245222}
  exec(/usr/lib/methods/define_rspc,-n,-c,sys,-s,node,-t,chrp){1310760,1245=
222}
  Time: 0 LEDS: 0x539
  Return code =3D 0
  ***** stdout *****
  sys0

  *** no stderr ****
  ----------------
  Attempting to configure device 'sys0'
  Time: 0 LEDS: 0x811
  Invoking /usr/lib/methods/cfgsys_chrp -1 -l sys0
  exec(/bin/sh,-c,/usr/lib/methods/cfgsys_chrp -1 -l sys0){1245224,1179696}
  Number of running methods: 1
  exec(/usr/lib/methods/cfgsys_chrp,-1,-l,sys0){1245224,1179696}
  LED{A20}
  Illegal Trap Instruction Interrupt in Kernel
  04151A74      tweqi    r0,0                r0=3D0
  KDB(0)>

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1846816/+subscriptions

