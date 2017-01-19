Received: from eggs.gnu.org ([2001:4830:134:3::10]:53052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cUDpe-0006d4-WB
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:36:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cUDpa-0002MF-2w
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:36:55 -0500
Received: from indium.canonical.com ([91.189.90.7]:38550)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cUDpZ-0002M8-Ta
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:36:50 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cUDpX-0004su-OE
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 14:36:48 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 1EFD82E8195
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 14:36:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Jan 2017 14:23:33 -0000
From: Thomas Huth <1006655@bugs.launchpad.net>
Reply-To: Bug 1006655 <1006655@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120530234408.16043.24886.malonedeb@chaenomeles.canonical.com>
Message-Id: <20170119142333.27340.66024.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1006655] Re: Can't convert to vmdk with the
 streamOptimized subformat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Patch 3efffc3292d9427 had been released with QEMU 2.5

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1006655

Title:
  Can't convert to vmdk with the streamOptimized subformat

Status in QEMU:
  Fix Released
Status in qemu package in Ubuntu:
  Fix Released
Status in qemu-kvm package in Ubuntu:
  Invalid

Bug description:
  Hi all,
  I'm trying to convert a qcow2 image file to the vmdk (on Ubuntu Server 12=
.04):

  # qemu-img convert -f qcow2 -O vmdk -o Stream spv-2912.qcow2 spv-2912-3.v=
mdk -o subformat=3DstreamOptimized
  VMDK: can't write to allocated cluster for streamOptimized
  qemu-img: error while writing sector 65: Input/output error

  Same result with any input format. Others subformats work but the
  StreamOptimized is by far the most important one. The only workaround
  I found is to migrate to raw and then to use VBoxManage (VirtualBox).

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1006655/+subscriptions
