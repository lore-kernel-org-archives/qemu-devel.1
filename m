Received: from eggs.gnu.org ([2001:4830:134:3::10]:59175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fOBgf-0005H1-Il
	for qemu-devel@nongnu.org; Wed, 30 May 2018 20:43:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fOBge-0006uK-Ps
	for qemu-devel@nongnu.org; Wed, 30 May 2018 20:43:29 -0400
From: John Snow <jsnow@redhat.com>
Date: Wed, 30 May 2018 20:43:20 -0400
Message-Id: <20180531004323.4611-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH 0/3] ahci: fix completion race condition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: John Snow <jsnow@redhat.com>

Commit d759c951f changed the main thread lock release/reacquisition,
and in so doing apparently jostled loose a race condition in the AHCI
code.

Patch 2 should be sufficient to fix this, and patches 1 and 3 are just
little trivial fixes.

This might be sufficient to fix the bug as reported at
https://bugs.launchpad.net/qemu/+bug/1769189
but the nature of the timing changes make it difficult to confirm,
so I am posting this patchset for the reporters to help test.

John Snow (3):
  ahci: trim signatures on raise/lower
  ahci: fix PxCI register race
  ahci: don't schedule unnecessary BH

 hw/ide/ahci.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

-- 
2.14.3
