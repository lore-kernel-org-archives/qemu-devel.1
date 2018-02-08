Received: from eggs.gnu.org ([2001:4830:134:3::10]:59552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ejrtD-0007yL-C5
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 14:29:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ejrtA-0004Hb-7k
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 14:29:47 -0500
Received: from indium.canonical.com ([91.189.90.7]:38798)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ejrtA-0004HF-0e
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 14:29:44 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ejrt8-0000kU-Ce
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 19:29:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id D9B062E80DE
	for <qemu-devel@nongnu.org>; Thu,  8 Feb 2018 19:29:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Feb 2018 19:19:16 -0000
From: Thomas Huth <1354167@bugs.launchpad.net>
Reply-To: Bug 1354167 <1354167@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140807211622.24181.42179.malonedeb@wampee.canonical.com>
Message-Id: <151811755632.27379.1506973135427060921.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1354167] Re: On VM restart: Could not open
 'poppy.qcow2': Could not read snapshots: File too large
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Sounds this was not really a bug, but rather a file corruption problem
by using qemu-img on a file that was opened by QEMU already? So could we
close this ticket nowadays?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1354167

Title:
  On VM restart: Could not open 'poppy.qcow2': Could not read snapshots:
  File too large

Status in QEMU:
  Incomplete

Bug description:
  I'm unable to restart a VM.   virt-manager is giving me:

  Error starting domain: internal error: process exited while connecting
  to monitor: qemu-system-x86_64: -drive
  file=3D/var/lib/libvirt/images/poppy.qcow2,if=3Dnone,id=3Ddrive-virtio-
  disk0,format=3Dqcow2: could not open disk image
  /var/lib/libvirt/images/poppy.qcow2: Could not read snapshots: File
  too large

  =

  From the command line trying to check the image also gives me:
  qemu-img check poppy.qcow2
  qemu-img: Could not open 'poppy.qcow2': Could not read snapshots: File to=
o large

  =

  This bug appears with both the default install of qemu for ubuntu 14.04:
  qemu-img version 2.0.0, Copyright (c) 2004-2008 Fabrice Bellard

  And the latest version.
  qemu-img version 2.1.50, Copyright (c) 2004-2008 Fabrice Bellard

  =

  Host: =

  Dual E5-2650 v2 @ 2.60GHz
  32GB Memory
  4TB Disk space (2.1TB Free) =


  Host OS: Ubuntu 14.04.1 LTS 64bit

  Guest:
  Ubuntu 14.04 64bit
  Storage Size: 500gb

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1354167/+subscriptions
