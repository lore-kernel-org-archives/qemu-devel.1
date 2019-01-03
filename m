Received: from eggs.gnu.org ([208.118.235.92]:33616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gf1zQ-0003Lr-T3
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 07:20:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gf1zN-0002KM-PV
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 07:20:44 -0500
Received: from indium.canonical.com ([91.189.90.7]:57356)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gf1zN-0002Jp-JY
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 07:20:41 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gf1zM-0007kv-7m
	for <qemu-devel@nongnu.org>; Thu, 03 Jan 2019 12:20:40 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 324AA2E806E
	for <qemu-devel@nongnu.org>; Thu,  3 Jan 2019 12:20:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Jan 2019 12:11:44 -0000
From: David <1810405@bugs.launchpad.net>
Reply-To: Bug 1810405 <1810405@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <154651750421.25988.5720567987776657968.malonedeb@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1810405] [NEW] source tarball has errors when
 untarring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

If you download qemu-2.10.0.tar.xv and/or qemu-2.10.1.tar.xv, and follow
the directions at https://www.qemu.org/download/, you get a tar error.


To repro:
$ wget  https://download.qemu.org/qemu-2.10.0.tar.xz
$ tar  xJf qemu-2.10.0.tar.xz =

tar: qemu-2.10.0/roms/u-boot/scripts/Kconfig: Cannot open: File exists
tar: Exiting with failure status due to previous errors

$ tar --version
tar (GNU tar) 1.29
Copyright (C) 2015 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.htm=
l>.
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

Written by John Gilmore and Jay Fenlason.


Apologies if I'm being an idiot here.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1810405

Title:
  source tarball has errors when untarring

Status in QEMU:
  New

Bug description:
  If you download qemu-2.10.0.tar.xv and/or qemu-2.10.1.tar.xv, and
  follow the directions at https://www.qemu.org/download/, you get a tar
  error.

  =

  To repro:
  $ wget  https://download.qemu.org/qemu-2.10.0.tar.xz
  $ tar  xJf qemu-2.10.0.tar.xz =

  tar: qemu-2.10.0/roms/u-boot/scripts/Kconfig: Cannot open: File exists
  tar: Exiting with failure status due to previous errors

  $ tar --version
  tar (GNU tar) 1.29
  Copyright (C) 2015 Free Software Foundation, Inc.
  License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.h=
tml>.
  This is free software: you are free to change and redistribute it.
  There is NO WARRANTY, to the extent permitted by law.

  Written by John Gilmore and Jay Fenlason.

  =

  Apologies if I'm being an idiot here.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1810405/+subscriptions
