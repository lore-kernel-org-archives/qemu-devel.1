Received: from eggs.gnu.org ([2001:4830:134:3::10]:55565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cUDyZ-0006My-Ek
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:46:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cUDyU-0006TY-Hl
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:46:07 -0500
Received: from indium.canonical.com ([91.189.90.7]:42368)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cUDyU-0006TF-B9
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:46:02 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cUDyS-0007Ie-O6
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 14:46:00 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 4960E2E80D3
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 14:46:00 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Jan 2017 14:25:52 -0000
From: Thomas Huth <1588328@bugs.launchpad.net>
Reply-To: Bug 1588328 <1588328@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160602115809.16901.66842.malonedeb@gac.canonical.com>
Message-Id: <20170119142553.20674.3054.launchpad@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1588328] Re: Qemu 2.6 Solaris 9 Sparc
 Segmentation Fault
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1588328

Title:
  Qemu 2.6 Solaris 9 Sparc Segmentation Fault

Status in QEMU:
  Fix Released

Bug description:
  Hi,
  I tried the following command to boot Solaris 9 sparc:
  qemu-system-sparc -nographic -boot d -hda ./Spark9.disk -m 256 -cdrom sol=
-9-905hw-ga-sparc-dvd.iso -serial telnet:0.0.0.0:3000,server =


  It seems there are a few Segmentation Faults, one from the starting of
  the boot. Another at the beginning of the commandline installation.

  Trying 127.0.0.1...
  Connected to localhost.
  Escape character is '^]'.
  Configuration device id QEMU version 1 machine id 32
  Probing SBus slot 0 offset 0
  Probing SBus slot 1 offset 0
  Probing SBus slot 2 offset 0
  Probing SBus slot 3 offset 0
  Probing SBus slot 4 offset 0
  Probing SBus slot 5 offset 0
  Invalid FCode start byte
  CPUs: 1 x FMI,MB86904
  UUID: 00000000-0000-0000-0000-000000000000
  Welcome to OpenBIOS v1.1 built on Apr 18 2016 08:19
    Type 'help' for detailed information
  Trying cdrom:d...
  Not a bootable ELF image
  Loading a.out image...
  Loaded 7680 bytes
  entry point is 0x4000
  bootpath: /iommu@0,10000000/sbus@0,10001000/espdma@5,8400000/esp@5,880000=
0/sd@2,0:d

  Jumping to entry point 00004000 for type 00000005...
  switching to new context:
  SunOS Release 5.9 Version Generic_118558-34 32-bit
  Copyright 1983-2003 Sun Microsystems, Inc.  All rights reserved.
  Use is subject to license terms.
  WARNING: /iommu@0,10000000/sbus@0,10001000/espdma@5,8400000/esp@5,8800000=
/sd@0,0 (sd0):
  	Corrupt label; wrong magic number

  Segmentation Fault
  Configuring /dev and /devices
  NOTICE: Couldn't set value (../../sun/io/audio/sada/drv/audiocs/audio_423=
1.c, Line #1759 0x00 0x88)
  audio may not work correctly until it is stopped and restarted
  Segmentation Fault
  Using RPC Bootparams for network configuration information.
  Skipping interface le0
  Searching for configuration file(s)...
  Search complete.

  ....

  What type of terminal are you using?
   1) ANSI Standard CRT
   2) DEC VT52
   3) DEC VT100
   4) Heathkit 19
   5) Lear Siegler ADM31
   6) PC Console
   7) Sun Command Tool
   8) Sun Workstation
   9) Televideo 910
   10) Televideo 925
   11) Wyse Model 50
   12) X Terminal Emulator (xterms)
   13) CDE Terminal Emulator (dtterm)
   14) Other
  Type the number of your choice and press Return: 3
  syslog service starting.
  savecore: no dump device configured
  Running in command line mode
  /sbin/disk0_install[109]: 143 Segmentation Fault
  /sbin/run_install[130]: 155 Segmentation Fault

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1588328/+subscriptions
