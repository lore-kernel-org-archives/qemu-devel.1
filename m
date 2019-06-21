Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9FAC43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 07:38:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FFCE2083B
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 07:38:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FFCE2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55326 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heE7Y-00071r-Dj
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 03:38:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40564)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1heE5o-0005qr-UM
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 03:36:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1heE54-0004RW-8g
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 03:35:31 -0400
Received: from indium.canonical.com ([91.189.90.7]:43130)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1heE54-0004N5-3V
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 03:35:30 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1heE52-0006k1-WF
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2019 07:35:29 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id F13BC2E80C7
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2019 07:35:28 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Jun 2019 07:26:51 -0000
From: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <1833661@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided;
 assignee=philmd@redhat.com; 
X-Launchpad-Bug-Tags: mips pflash
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: philmd
X-Launchpad-Bug-Reporter: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
X-Launchpad-Bug-Modifier: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
References: <156110193683.18432.8339006487274258755.malonedeb@chaenomeles.canonical.com>
Message-Id: <156110201112.18276.2218392113056923674.malone@chaenomeles.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18989";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 9625d10457d89940cb79bd4db627fedf6b7c3672
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1833661] Re: Linux kernel oops on Malta board
 while accessing pflash
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
Reply-To: Bug 1833661 <1833661@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Relevant 64-bit output:

tests/acceptance/linux_ssh_mips_malta.py:LinuxSSH.test_mips_malta64eb_kerne=
l3_2_0

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 3.2.0-4-5kc-malta (debian-kernel@lists.debian.=
org) (gcc version 4.6.3 (Debian 4.6.3-14) ) #1 Debian 3.2.51-1
[    0.000000] bootconsole [early0] enabled
[    0.000000] CPU revision is: 000182a0 (MIPS 20Kc)
[    0.000000] FPU revision is: 000f8200
[    0.000000] Checking for the multiply/shift bug... no.
[    0.000000] Checking for the daddiu bug... no.
[    0.000000] Determined physical RAM map:
[    0.000000]  memory: 0000000000001000 @ 0000000000000000 (reserved)
[    0.000000]  memory: 00000000000ef000 @ 0000000000001000 (ROM data)
[    0.000000]  memory: 0000000000748000 @ 00000000000f0000 (reserved)
[    0.000000]  memory: 00000000077c7000 @ 0000000000838000 (usable)
[    0.000000] Wasting 117824 bytes for tracking 2104 unused pages
[    0.000000] Initrd not found or empty - disabling initrd
[    0.000000] Kernel command line: printk.time=3D0 console=3DttyS0 root=3D=
/dev/sda1
[...]
Freeing prom memory: 956k freed
Freeing unused kernel memory: 244k freed

INIT: version 2.88 booting

Using makefile-style concurrent boot in runlevel S.
physmap platform flash device: 00400000 at 1e000000
sr0: scsi3-mmc drive: 4x/4x cd/rw xa/form2 tray
[...]
sd 0:0:0:0: Attached scsi generic sg0 type 0
sr 1:0:0:0: Attached scsi generic sg1 type 5
physmap-flash.0: Found 1 x32 devices at 0x0 in 32-bit bank. Manufacturer ID=
 0x000000 Chip ID 0x000000
input: ImExPS/2 Generic Explorer Mouse as /devices/platform/i8042/serio1/in=
put/input1
Intel/Sharp Extended Query Table at 0x0031
Using buffer write method
Searching for RedBoot partition table in physmap-flash.0 at offset 0x1003f0=
000
Creating 3 MTD partitions on "physmap-flash.0":
0x000000000000-0x000000100000 : "YAMON"
0x000000100000-0x0000003e0000 : "User FS"
0x0000003e0000-0x000000400000 : "Board Config"
CPU 0 Unable to handle kernel paging request at virtual address 00000000000=
00028, epc =3D=3D ffffffffc00f9234, ra =3D=3D ffffffffc00f9210

** Changed in: qemu
     Assignee: (unassigned) =3D> Philippe Mathieu-Daud=C3=A9 (philmd)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1833661

Title:
  Linux kernel oops on Malta board while accessing pflash

Status in QEMU:
  New

Bug description:
  commit 33d609990621dea6c7d056c86f707b8811320ac1

  While running tests/acceptance/linux_ssh_mips_malta.py, the big-endian
  tests fail:

    physmap-flash.0: Found 1 x32 devices at 0x0 in 32-bit bank. Manufacture=
r ID 0x000000 Chip ID 0x000000
    Intel/Sharp Extended Query Table at 0x0031
    Using buffer write method
    Searching for RedBoot partition table in physmap-flash.0 at offset 0x10=
03f0000
    Creating 3 MTD partitions on "physmap-flash.0":
    0x000000000000-0x000000100000 : "YAMON"
    0x000000100000-0x0000003e0000 : "User FS"
    0x0000003e0000-0x000000400000 : "Board Config"
    CPU 0 Unable to handle kernel paging request at virtual address 00000014

  The 64-bit test fails with:

    CPU 0 Unable to handle kernel paging request at virtual address
  0000000000000028

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1833661/+subscriptions

