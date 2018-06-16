Received: from eggs.gnu.org ([2001:4830:134:3::10]:58340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fU9BC-0005r4-WE
	for qemu-devel@nongnu.org; Sat, 16 Jun 2018 07:15:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fU9B9-0008Qi-Q0
	for qemu-devel@nongnu.org; Sat, 16 Jun 2018 07:15:38 -0400
Received: from indium.canonical.com ([91.189.90.7]:44636)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fU9B9-0008Ol-Bo
	for qemu-devel@nongnu.org; Sat, 16 Jun 2018 07:15:35 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fU9B8-0005bW-9J
	for <qemu-devel@nongnu.org>; Sat, 16 Jun 2018 11:15:34 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 3EA3E2E8010
	for <qemu-devel@nongnu.org>; Sat, 16 Jun 2018 11:15:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 16 Jun 2018 11:08:01 -0000
From: Shimi Gersner <gersner@gmail.com>
Reply-To: Bug 1777232 <1777232@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <152914728124.2335.1880022102353250655.malonedeb@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1777232] [NEW] NVME fails on big writes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

NVME Compliance test 8:3.3.0 tries to write and read back big chunks of
pages. Currently, on the latest QEMU operation of size 1024 blocks will
fail when device is backed by a file.

NVME specification has several types of data transfers from guests, one
of the is the PRP list (Physical Region Page List). PRP is a list of
entries pointing to pages to be written. The list it self resides in a
single or multiple pages.

NVME device maps the PRP list into QEMUSGList which will be me mapped
into linux IO vectors. Finally, when the file driver will write the
changes, it uses the posix pwritev, which fails if the number of vectors
exceeds the maximum.


NVME Compliance - https://github.com/nvmecompliance/tnvme/wiki

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1777232

Title:
  NVME fails on big writes

Status in QEMU:
  New

Bug description:
  NVME Compliance test 8:3.3.0 tries to write and read back big chunks
  of pages. Currently, on the latest QEMU operation of size 1024 blocks
  will fail when device is backed by a file.

  NVME specification has several types of data transfers from guests,
  one of the is the PRP list (Physical Region Page List). PRP is a list
  of entries pointing to pages to be written. The list it self resides
  in a single or multiple pages.

  NVME device maps the PRP list into QEMUSGList which will be me mapped
  into linux IO vectors. Finally, when the file driver will write the
  changes, it uses the posix pwritev, which fails if the number of
  vectors exceeds the maximum.

  =

  NVME Compliance - https://github.com/nvmecompliance/tnvme/wiki

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1777232/+subscriptions
