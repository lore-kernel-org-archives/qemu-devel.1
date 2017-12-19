Received: from eggs.gnu.org ([2001:4830:134:3::10]:50225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eRG7C-0008Rj-RR
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 06:31:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eRG76-00065S-Mb
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 06:31:18 -0500
Received: from indium.canonical.com ([91.189.90.7]:34620)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eRG76-00063l-Gc
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 06:31:12 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eRG74-0005KO-Lr
	for <qemu-devel@nongnu.org>; Tue, 19 Dec 2017 11:31:10 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 5CCBF2E80D0
	for <qemu-devel@nongnu.org>; Tue, 19 Dec 2017 11:31:10 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 Dec 2017 11:16:15 -0000
From: Michal Nowak <mnowak@startmail.com>
Reply-To: Bug 1670175 <1670175@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170305190118.21996.2136.malonedeb@gac.canonical.com>
Message-Id: <151368217544.18606.14402698109268557531.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1670175] Re: qemu-system-sparc64 with
 tribblix-sparc-0m16.iso ends with "panic - kernel: no nucleus hblk8 to
 allocate"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

With QEMU 2.11 there are two new warnings I haven't seen before
(execution was still the same):

...
unix-tte:interpret: exception -13 caught
interpret ' unix-tte is va>tte-data failed with error ffffffffffffffed
WARNING: consconfig: cannot find driver for screen device /pci@1fe,0/pci@1,=
1/QEMU,VGA@2
Hostname: tribblix
Remounting root read/write
Probing for device nodes ...
WARNING: ata_controller[0] - Unsupported Controller
        Vendor 0x9510, Device 0x4606, Revision 0x7
WARNING: ebus0 assigning default interrupt level 1 for device i80420
...

Then it hangs the same way it did with older QEMUs.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1670175

Title:
  qemu-system-sparc64 with tribblix-sparc-0m16.iso ends with "panic -
  kernel: no nucleus hblk8 to allocate"

Status in QEMU:
  New

Bug description:
  > qemu-system-sparc64 -m 1024 -cdrom Downloads/tribblix-sparc-0m16.iso -b=
oot d -nographic
  OpenBIOS for Sparc64
  Configuration device id QEMU version 1 machine id 0
  kernel cmdline =

  CPUs: 1 x SUNW,UltraSPARC-IIi
  UUID: 00000000-0000-0000-0000-000000000000
  Welcome to OpenBIOS v1.1 built on Nov 24 2016 21:23
    Type 'help' for detailed information
  Trying cdrom:f...
  Not a bootable ELF image
  Not a bootable a.out image

  Loading FCode image...
  Loaded 7120 bytes
  entry point is 0x4000
  Evaluating FCode...
  Evaluating FCode...
  Ignoring failed claim for va 10a96a0 memsz 19!
  Ignoring failed claim for va 1000000 memsz d1fb6!
  Ignoring failed claim for va 1402000 memsz 32518!
  Ignoring failed claim for va 1800000 memsz 52ac8!
  SunOS Release 5.11 Version tribblix-m16 64-bit
  Copyright (c) 1983, 2010, Oracle and/or its affiliates. All rights reserv=
ed.
  could not find debugger-vocabulary-hook>threads:interpret: exception -13 =
caught
  interpret \ ident	"%Z%%M%	%I%	%E% SMI"
  \ Copyright 2005 Sun Microsystems, Inc.  All rights reserved.
  \ Use is subject to license terms.
  \
  \ CDDL HEADER START
  \
  \ The contents of this file are subject to the terms of the
  \ Common Development and Distribution License, Version 1.0 only
  \ (the "License").  You may not use this file except in compliance
  \ with the License.
  \
  \ You can obtain a copy of the license at usr/src/OPENSOLARIS.LICENSE
  \ or http://www.opensolaris.org/os/licensing.
  \ See the License for =

  WARNING: add_spec: No major number for sf
  panic - kernel: no nucleus hblk8 to allocate
  EXIT

  QEMU keeps running (CPU is on 100 % all the time), I can interact with
  the prompt:

  0 > boot
  Not a Linux kernel image
  Not a bootable ELF image
  Not a bootable a.out image

  Loading FCode image...
  Unhandled Exception 0x0000000000000018
  PC =3D 0x00000000ffd25310 NPC =3D 0x00000000ffd25314
  Stopping execution

  > qemu-system-sparc64 -version
  QEMU emulator version 2.8.0(Virtualization:Staging / SLE_12_SP2)

  from
  https://build.opensuse.org/package/show/Virtualization:Staging/qemu on
  openSUSE Leap 42.2.

  ISO: http://pkgs.tribblix.org/iso/tribblix-sparc-0m16.iso.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1670175/+subscriptions
