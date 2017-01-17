Received: from eggs.gnu.org ([2001:4830:134:3::10]:44783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cTbPV-00010N-SO
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 16:35:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cTbPS-0005Dr-Kk
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 16:35:21 -0500
Received: from indium.canonical.com ([91.189.90.7]:59963)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cTbPS-0005DO-Ev
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 16:35:18 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cTbPR-0004Gx-8G
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 21:35:17 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 390F42E80C3
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 21:35:17 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Jan 2017 21:24:34 -0000
From: Thomas Huth <784977@bugs.launchpad.net>
Reply-To: Bug 784977 <784977@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20110519041753.18011.86775.malonedeb@wampee.canonical.com>
Message-Id: <20170117212434.26772.22471.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 784977] Re: qemu-img convert fails to convert,
 generates a 512byte file output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Can you still reproduce this problem with the latest version of QEMU?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/784977

Title:
  qemu-img convert fails to convert, generates a 512byte file output

Status in QEMU:
  Incomplete

Bug description:
  I have a Vmware image, so I have files like 'Ubuntu.vmdk', want to
  convert to VirtualBox .vdi format using qemu, the first stage of
  extracting the image with 'qemu-img convert Ubuntu.vmdk output.bin'
  just generates a 512byte file:

  {quote}
  # Disk DescriptorFile
  version=3D1
  CID=3D36be9761
  parentCID=3Dffffffff
  createType=3D"twoGbMaxExtentSparse"

  # Extent description
  RW 4192256 SPARSE "Ubuntu-s001.vmdk"
  RW 4192256 SPARSE "Ubuntu-s002.vmdk"
  RW 4192256 SPARSE "Ubuntu-s003.vmdk"
  RW 4192256 SPARSE "Ubuntu-s004.vmdk"
  RW 4192256 SPARSE "Ubuntu-s005.vmdk"
  RW 4192256 SPARSE "Ubuntu-s006.vmdk"
  RW 4192256 SPARSE "Ubuntu-s007.vmdk"
  RW 4192256 SPARSE "Ubuntu-s008.vmdk"
  RW 4192256 SPARSE "Ubuntu-s009.vmdk"
  RW 4192256 SPARSE "Ubuntu-s010.vmdk"
  RW 20480 SPARSE "Ubunt
  {quote}

  Here is the input Ubuntu.vmdk file:
  {quote}
  # Disk DescriptorFile
  version=3D1
  CID=3D36be9761
  parentCID=3Dffffffff
  createType=3D"twoGbMaxExtentSparse"

  # Extent description
  RW 4192256 SPARSE "Ubuntu-s001.vmdk"
  RW 4192256 SPARSE "Ubuntu-s002.vmdk"
  RW 4192256 SPARSE "Ubuntu-s003.vmdk"
  RW 4192256 SPARSE "Ubuntu-s004.vmdk"
  RW 4192256 SPARSE "Ubuntu-s005.vmdk"
  RW 4192256 SPARSE "Ubuntu-s006.vmdk"
  RW 4192256 SPARSE "Ubuntu-s007.vmdk"
  RW 4192256 SPARSE "Ubuntu-s008.vmdk"
  RW 4192256 SPARSE "Ubuntu-s009.vmdk"
  RW 4192256 SPARSE "Ubuntu-s010.vmdk"
  RW 20480 SPARSE "Ubuntu-s011.vmdk"

  # The Disk Data Base =

  #DDB

  ddb.toolsVersion =3D "7240"
  ddb.adapterType =3D "lsilogic"
  ddb.geometry.sectors =3D "63"
  ddb.geometry.heads =3D "255"
  ddb.geometry.cylinders =3D "2610"
  ddb.virtualHWVersion =3D "6"
  {quote}

  No stack trace or other output was found.  Anything I can add (other
  than the 20G VM image to reproduce and I'll be happy to provide)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/784977/+subscriptions
