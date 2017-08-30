Received: from eggs.gnu.org ([2001:4830:134:3::10]:57626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dn9iN-000459-I9
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 16:35:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dn9iJ-0004CA-JL
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 16:35:55 -0400
Received: from indium.canonical.com ([91.189.90.7]:36132)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dn9iJ-0004Bv-CJ
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 16:35:51 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dn9iI-0003X2-BO
	for <qemu-devel@nongnu.org>; Wed, 30 Aug 2017 20:35:50 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 4F4D82E806F
	for <qemu-devel@nongnu.org>; Wed, 30 Aug 2017 20:35:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Aug 2017 20:16:32 -0000
From: Thomas Huth <1599539@bugs.launchpad.net>
Reply-To: Bug 1599539 <1599539@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160706143209.31209.31307.malonedeb@chaenomeles.canonical.com>
Message-Id: <150412419293.16848.16753727015962036417.malone@gac.canonical.com>
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

Another patch has apparently been included here:
https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3Df80256b7eebfbe20683
I assume we can close this ticket now as fixed?

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1599539

Title:
  2.6.0: vvfat driver generates bad FAT entries

Status in QEMU:
  New

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
