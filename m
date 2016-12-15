Received: from eggs.gnu.org ([2001:4830:134:3::10]:56996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cHYeN-0007Pq-1q
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 11:12:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cHYeI-0003kL-5T
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 11:12:55 -0500
Received: from indium.canonical.com ([91.189.90.7]:48200)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cHYeI-0003jx-0B
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 11:12:50 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cHYeG-0004V5-HT
	for <qemu-devel@nongnu.org>; Thu, 15 Dec 2016 16:12:48 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 593B72E80C6
	for <qemu-devel@nongnu.org>; Thu, 15 Dec 2016 16:12:48 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Dec 2016 15:54:39 -0000
From: Thomas Huth <810588@bugs.launchpad.net>
Reply-To: Bug 810588 <810588@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20110714164328.4200.70793.malonedeb@wampee.canonical.com>
Message-Id: <20161215155439.20030.50686.launchpad@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 810588] Re: Unexpected crash of qemu-kvm with
 SCSI disk emulation.
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
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/810588

Title:
  Unexpected crash of qemu-kvm with SCSI disk emulation.

Status in QEMU:
  Incomplete

Bug description:
  Virual machine with MS windows 2003 installed on the virtual scsi disk (-=
drive file=3D/my/path/myimage.qcow2.img,boot=3Don,if=3Dscsi,media=3Ddisk,bu=
s=3D0,unit=3D1) unexpectedly crashes without core dump. When the image is c=
onnected as an ide disk (-hda )  vm flies normally.
  Qemu-kvm version: 0.12.5
  Os/distr.: Debian squeeze, x86_64

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/810588/+subscriptions
