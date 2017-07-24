Received: from eggs.gnu.org ([2001:4830:134:3::10]:48479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1dZckD-0001iX-Pf
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 08:45:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1dZck9-0000r5-Tc
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 08:45:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59014)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <apahim@redhat.com>) id 1dZck9-0000mw-NL
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 08:45:49 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3A218C0293A9
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 12:45:47 +0000 (UTC)
From: Amador Pahim <apahim@redhat.com>
Date: Mon, 24 Jul 2017 14:44:36 +0200
Message-Id: <20170724124438.27344-1-apahim@redhat.com>
Subject: [Qemu-devel] [PATCH v4 0/2] scripts/qemu.py fixes and cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, berrange@redhat.com, ehabkost@redhat.com, mreitz@redhat.com, kwolf@redhat.com, armbru@redhat.com, crosa@redhat.com, ldoktor@redhat.com, Amador Pahim <apahim@redhat.com>

First commit renames self._args to self.args. The leading underscore
represents that the variable is private and as such it should not be
accessed externally. But that variable is the main API for inclusion
of Qemu command arguments, so the rename makes it public.

Second commit contains some fixes and cleanups to make sure we are
correctly trying to launch the VM and properly shutting it down. More
details about the changes in the commit message.

Changes v1->v2:
 - Style fixes to make checkpatch.pl happy.
 - Rebased.
Changes v2->v3:
 - Fix typo in patch 3 ("qemu.py: make 'args' public") commit message.
Changes v3->v4:
 - Squash the 2 first commits since they are co-dependant.
 - Cleanup launch() and shutdown().
 - Reorder the commits, putting the rename of self._args first.
 - Rebased.

Amador Pahim (2):
  qemu.py: make 'args' public
  qemu.py: cleanup and fixes

 scripts/qemu.py               | 79 ++++++++++++++++++++++++++++---------------
 tests/qemu-iotests/iotests.py | 18 +++++-----
 2 files changed, 60 insertions(+), 37 deletions(-)

-- 
2.13.3
