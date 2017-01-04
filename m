Received: from eggs.gnu.org ([2001:4830:134:3::10]:33764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cOdDz-0004S8-1b
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 23:30:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cOdDx-0004vU-P5
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 23:30:55 -0500
Received: from indium.canonical.com ([91.189.90.7]:60655)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cOdDx-0004uh-J5
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 23:30:53 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cOdDw-0002S8-80
	for <qemu-devel@nongnu.org>; Wed, 04 Jan 2017 04:30:52 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 38EC22E80C3
	for <qemu-devel@nongnu.org>; Wed,  4 Jan 2017 04:30:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Jan 2017 04:17:50 -0000
From: Launchpad Bug Tracker <322602@bugs.launchpad.net>
Reply-To: Bug 322602 <322602@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20090129032712.7039.50315.malonedeb@gandwana.canonical.com>
Message-Id: <20170104041750.27545.73737.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 322602] Re: Snapshot usage makes qcow2 image
 unusable due to large tables
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
https://bugs.launchpad.net/bugs/322602

Title:
  Snapshot usage makes qcow2 image unusable due to large tables

Status in QEMU:
  Expired

Bug description:
  To reproduce with 0.9.1 and svn:
  - Create a 20G (or some size much greater than system RAM) qcow2 image
  - Inside VM, install some OS, formatting whole drive
  - Create snapshot with savevm
  - Inside VM, reformat and reinstall OS
  - Create snapshot with savevm
  [...]

  Eventually, qemu crashes, then neither qemu-img nor qemu can open the
  image because memory is exhausted.  The reason is that the whole
  refcount_table is loaded into memory, and this refcount_table has now
  become much bigger than the size of memory due to each snapshot taken
  after significant changes to the disk image.

  The refcount_table really needs to be loaded and used in fixed size
  chunks to avoid this problem.  It will only get worse as typical
  storage set modifications during work sessions between snapshots
  outpace the size of system RAM.

  Alternatively, there needs to be a way to "rollback" a snapshot
  without loading the whole disk image normally, so that a snapshot
  which has made the image unusable in this way can be reversed.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/322602/+subscriptions
