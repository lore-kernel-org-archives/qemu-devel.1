Received: from eggs.gnu.org ([2001:4830:134:3::10]:53461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gKnm0-0006nH-Qa
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 12:07:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gKnlu-00051X-Cr
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 12:07:13 -0500
Received: from indium.canonical.com ([91.189.90.7]:39964)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gKnls-0004yD-Sl
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 12:07:09 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gKnlo-0004Jo-5L
	for <qemu-devel@nongnu.org>; Thu, 08 Nov 2018 17:07:04 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id BEDB32E80CE
	for <qemu-devel@nongnu.org>; Thu,  8 Nov 2018 17:07:03 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Nov 2018 16:50:50 -0000
From: Thomas Huth <1734810@bugs.launchpad.net>
Reply-To: Bug 1734810 <1734810@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <151184788907.20350.3674834740850334109.malonedeb@chaenomeles.canonical.com>
Message-Id: <154169585102.24447.3807402176416309095.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1734810] Re: Windows guest virtual PC running
 abnormally slow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

And for the CLI parameters, you could run this in a console window for
example, after starting your guest:

ps aux | grep qemu

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1734810

Title:
  Windows guest virtual PC running abnormally slow

Status in Boxes:
  New
Status in KVM:
  New
Status in libvirt:
  New
Status in QEMU:
  Invalid
Status in spice related packages:
  Confirmed
Status in gnome-boxes package in Ubuntu:
  Confirmed

Bug description:
  Guest systems running Windows 10 in a virtualized environment run
  unacceptably slow, with no option in Boxes to offer the virtual
  machine more (or less) cores from my physical CPU.

  ProblemType: Bug
  DistroRelease: Ubuntu 17.10
  Package: gnome-boxes 3.26.1-1
  ProcVersionSignature: Ubuntu 4.13.0-17.20-lowlatency 4.13.8
  Uname: Linux 4.13.0-17-lowlatency x86_64
  ApportVersion: 2.20.7-0ubuntu3.5
  Architecture: amd64
  CurrentDesktop: ubuntu:GNOME
  Date: Tue Nov 28 00:37:11 2017
  ProcEnviron:
   TERM=3Dxterm-256color
   PATH=3D(custom, no user)
   XDG_RUNTIME_DIR=3D<set>
   LANG=3Den_US.UTF-8
   SHELL=3D/bin/bash
  SourcePackage: gnome-boxes
  UpgradeStatus: No upgrade log present (probably fresh install)

To manage notifications about this bug go to:
https://bugs.launchpad.net/gnome-boxes/+bug/1734810/+subscriptions
