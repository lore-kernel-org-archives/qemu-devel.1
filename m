Received: from eggs.gnu.org ([2001:4830:134:3::10]:34483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f5kvu-0007nE-AC
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 00:31:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f5kvr-0004db-6H
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 00:31:02 -0400
Received: from indium.canonical.com ([91.189.90.7]:53350)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1f5kvq-0004cy-Vl
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 00:30:59 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1f5kvo-00012y-Nj
	for <qemu-devel@nongnu.org>; Tue, 10 Apr 2018 04:30:56 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 5A09C2E80D9
	for <qemu-devel@nongnu.org>; Tue, 10 Apr 2018 04:30:56 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Apr 2018 04:17:44 -0000
From: Launchpad Bug Tracker <1354167@bugs.launchpad.net>
Reply-To: Bug 1354167 <1354167@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140807211622.24181.42179.malonedeb@wampee.canonical.com>
Message-Id: <152333386493.1655.12174109366959279854.malone@loganberry.canonical.com>
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

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1354167

Title:
  On VM restart: Could not open 'poppy.qcow2': Could not read snapshots:
  File too large

Status in QEMU:
  Expired

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
