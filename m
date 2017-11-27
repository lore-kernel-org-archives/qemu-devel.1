Received: from eggs.gnu.org ([2001:4830:134:3::10]:40477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eJK2L-00073v-So
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 09:05:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eJK2G-0004vG-5I
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 09:05:29 -0500
Received: from indium.canonical.com ([91.189.90.7]:38870)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eJK2F-0004v0-PL
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 09:05:24 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eJK2E-0002kQ-Rz
	for <qemu-devel@nongnu.org>; Mon, 27 Nov 2017 14:05:22 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id CAE7C2E80C3
	for <qemu-devel@nongnu.org>; Mon, 27 Nov 2017 14:05:22 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Nov 2017 13:45:46 -0000
From: Thomas Huth <1399191@bugs.launchpad.net>
Reply-To: Bug 1399191 <1399191@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20141204133138.26031.92640.malonedeb@wampee.canonical.com>
Message-Id: <151179034623.18804.5488408601682988750.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1399191] Re: Large VHDX image size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Triaging old bug tickets... can you still reproduce this issue with the
latest version of QEMU? Or could we close this ticket nowadays?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1399191

Title:
  Large VHDX image size

Status in QEMU:
  Incomplete

Bug description:
  We are trying to convert a VMDK image to VHDX image for deploy to HyperV =
Server ( SCVMM 2012 SP1) using qemu-img.
  We tried converting the image using both 'fixed' as well as 'dynamic' for=
mat. We found that both the disks occupy the same size of 50GB. When the sa=
me is done with VHD image, we found that the dynamic disks are much lesser =
in size (5 GB) than the fixed disk (50GB). =


  Why is that the VHDX generates large sized images for both the
  formats?

  The following commands were used to convert the vmdk image to VHDX
  format

  1. qemu-img convert -p -o subformat=3Dfixed  -f vmdk -O vhdx Test.vmdk
  Test-fixed.vhdx

  qemu-img info Test-fixed.vhdx
  image: Test-fixed.vhdx
  file format: vhdx
  virtual size: 50G (53687091200 bytes)
  disk size: 50G
  cluster_size: 16777216


  =

  2. qemu-img convert -p -o subformat=3Ddynamic  -f vmdk -O vhdx Test.vmdk =
Test-dynamic.vhdx

  qemu-img info Test-dynamic.vhdx
  image: Test-dynamic.vhdx
  file format: vhdx
  virtual size: 50G (53687091200 bytes)
  disk size: 50G
  cluster_size: 16777216

  =

  We tried this with the following version of qemu
  1. qemu-2.0.0
  2. qemu-2.1.2
  3. qemu-2.2.0-rc4

  =

  Please let us know how to create compact VHDX images using qemu-img.
  Thank you

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1399191/+subscriptions
