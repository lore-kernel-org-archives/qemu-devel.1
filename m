Received: from eggs.gnu.org ([2001:4830:134:3::10]:59439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cxqxw-0006w5-PL
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 04:15:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cxqxt-0005uu-J5
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 04:15:56 -0400
Received: from indium.canonical.com ([91.189.90.7]:53619)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cxqxt-0005uZ-DG
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 04:15:53 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cxqxs-0007Fl-10
	for <qemu-devel@nongnu.org>; Tue, 11 Apr 2017 08:15:52 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 049A12E80C1
	for <qemu-devel@nongnu.org>; Tue, 11 Apr 2017 08:15:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 11 Apr 2017 08:01:54 -0000
From: Lidong Chen <jemmy858585@gmail.com>
Reply-To: Bug 1681688 <1681688@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <20170411080154.12474.20009.malonedeb@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1681688] [NEW] qemu live migration failed
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

qemu live migration failed

the dest qemu report this error.

Receiving block device images
Completed 0 %^Mqemu-system-x86_64: block/io.c:1348: bdrv_aligned_pwritev: A=
ssertion `child->perm & BLK_PERM_WRITE' failed.

this bug is caused by this patch:
http://git.qemu-project.org/?p=3Dqemu.git;a=3Dcommit;h=3Dd35ff5e6b3aa3a706b=
0aa3bcf11400fac945b67a

rollback this commit, the problem solved.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1681688

Title:
  qemu live migration failed

Status in QEMU:
  New

Bug description:
  qemu live migration failed

  the dest qemu report this error.

  Receiving block device images
  Completed 0 %^Mqemu-system-x86_64: block/io.c:1348: bdrv_aligned_pwritev:=
 Assertion `child->perm & BLK_PERM_WRITE' failed.

  this bug is caused by this patch:
  http://git.qemu-project.org/?p=3Dqemu.git;a=3Dcommit;h=3Dd35ff5e6b3aa3a70=
6b0aa3bcf11400fac945b67a

  rollback this commit, the problem solved.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1681688/+subscriptions
