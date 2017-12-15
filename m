Received: from eggs.gnu.org ([2001:4830:134:3::10]:48928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ePt1G-0004wF-Dj
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 11:39:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ePt1C-0001kG-DR
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 11:39:30 -0500
Received: from indium.canonical.com ([91.189.90.7]:36030)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ePt1C-0001iw-6b
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 11:39:26 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ePt1B-0000G3-1x
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 16:39:25 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id E8A8F2E80D2
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 16:39:24 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 Dec 2017 16:28:27 -0000
From: Thomas Huth <1599539@bugs.launchpad.net>
Reply-To: Bug 1599539 <1599539@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160706143209.31209.31307.malonedeb@chaenomeles.canonical.com>
Message-Id: <151335530820.26077.1363669173851748150.launchpad@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1599539] Re: 2.6.0: vvfat driver generates bad
 FAT entries
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
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1599539

Title:
  2.6.0: vvfat driver generates bad FAT entries

Status in QEMU:
  Fix Released

Bug description:
  The vvfat driver sometimes generates entries about which file system
  checking utilities generate complaints.

  For example, dosfsck will complain that the volume label entry has
  non-zero size. ScanDisk from Windows 9x complains about invalid dot
  (".") and dot-dot ("..") entries in directories and also about invalid
  long file name entries. MS-DOS ScanDisk also often manages to find
  "lost clusters" on the drive.

  Tangentially: qemu-img convert fat:test test.img doesn't seem to work
  -- it generates an 504MiB of zero bytes and hangs. qemu-img map
  fat:test generates an assertion failure. Having qemu-img working might
  have helped with debugging the above issue.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1599539/+subscriptions
