Received: from eggs.gnu.org ([2001:4830:134:3::10]:42249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eBmP4-0003Qz-Rt
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:45:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eBmOz-0000Mu-W2
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:45:46 -0500
Received: from indium.canonical.com ([91.189.90.7]:34246)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eBmOz-0000KK-Qi
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:45:41 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eBmOy-00073L-4r
	for <qemu-devel@nongnu.org>; Mon, 06 Nov 2017 18:45:40 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 1E1392E80CD
	for <qemu-devel@nongnu.org>; Mon,  6 Nov 2017 18:45:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Nov 2017 18:35:03 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1077116 <1077116@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20121109183454.27088.83319.malonedeb@gac.canonical.com>
Message-Id: <150999330382.4653.18389384542431290090.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1077116] Re: automoc4 segfaults when building in
 an armhf pbuilder on an amd64 host
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I was able to reproduce this failure with QEMU 2.5, and the code runs OK
under QEMU current master, so I think this is fixed by the
threading/signal handling bugfixes we've done between then and now. I'm
going to close this as will-be-fixed-in-2.11 (though it's quite possible
it's already fixed in 2.10).


** Changed in: qemu
       Status: New =3D> Fix Committed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1077116

Title:
  automoc4 segfaults when building in an armhf pbuilder on an amd64 host

Status in QEMU:
  Fix Committed
Status in qemu package in Ubuntu:
  Confirmed

Bug description:
  When trying to build kde4libs in an armhf pbuilder created with the
  pbuilder-scripts running on an amd64 host automoc4 recieves a
  segmentation fault and I can't get any useful information out of it:

  root@yofel-thinkpad:/tmp/kde4libs-4.9.3/build/kdeui# /usr/bin/automoc4 kd=
eui_automoc.cpp ../../kdeui/ . moc-qt4 cmake
  unable to dump 00102c00
  Segmentation fault (core dumped)
  root@yofel-thinkpad:/tmp/kde4libs-4.9.3/build/kdeui# gdb /usr/bin/automoc=
4 qemu_automoc4_20121108-211818_15839.core  =

  GNU gdb (GDB) 7.5-ubuntu
  Copyright (C) 2012 Free Software Foundation, Inc.
  License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.h=
tml>
  This is free software: you are free to change and redistribute it.
  There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
  and "show warranty" for details.
  This GDB was configured as "arm-linux-gnueabihf".
  For bug reporting instructions, please see:
  <http://www.gnu.org/software/gdb/bugs/>...
  Reading symbols from /usr/bin/automoc4...done.
  BFD: Warning: /tmp/kde4libs-4.9.3/build/kdeui/qemu_automoc4_20121108-2118=
18_15839.core is truncated: expected core file size >=3D 5150720, found: 97=
4848.
  [New LWP 15839]
  [New LWP 15866]
  Cannot access memory at address 0xf67fe954
  Cannot access memory at address 0xf67fe950
  (gdb) bt
  #0  0xf6630306 in ?? ()
  #1  0xf6415ff8 in ?? ()
  #2  0xf6415ff8 in ?? ()
  Backtrace stopped: previous frame identical to this frame (corrupt stack?)
  (gdb) =


  automoc4 runs fine when building on a nexus7 so this sounds like an issue=
 in qemu.
  Tested in quantal and raring.

  ProblemType: Bug
  DistroRelease: Ubuntu 13.04
  Package: qemu-user-static 1.2.0-2012.09-0ubuntu1
  Uname: Linux 3.6.2-030602-generic x86_64
  NonfreeKernelModules: nvidia
  ApportVersion: 2.6.2-0ubuntu3
  Architecture: amd64
  Date: Fri Nov  9 19:29:28 2012
  EcryptfsInUse: Yes
  InstallationDate: Installed on 2011-10-08 (398 days ago)
  InstallationMedia: Kubuntu 11.10 "Oneiric Ocelot" - Beta amd64 (20111007)
  MarkForUpload: True
  ProcEnviron:
   SHELL=3D/bin/bash
   TERM=3Dxterm
   PATH=3D(custom, user)
   LANG=3Den_US.UTF-8
   LANGUAGE=3Den_US.UTF-8
  SourcePackage: qemu-linaro
  UpgradeStatus: No upgrade log present (probably fresh install)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1077116/+subscriptions
