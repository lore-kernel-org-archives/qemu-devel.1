Received: from eggs.gnu.org ([2001:4830:134:3::10]:48868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1dY7cr-0008GU-8K
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 05:20:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1dY7cn-00047A-Qx
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 05:20:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59506)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <apahim@redhat.com>) id 1dY7cn-00045Y-Kp
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 05:20:01 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 893ED72D09
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 09:20:00 +0000 (UTC)
From: Amador Pahim <apahim@redhat.com>
Date: Thu, 20 Jul 2017 11:18:59 +0200
Message-Id: <20170720091902.22476-1-apahim@redhat.com>
Subject: [Qemu-devel] [PATCH v3 0/3] scripts/qemu.py small fixes
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

First commit fixes the 'is_running()' method, which is not
working currently.

Second commit includes the qemu command line and its output when
there's an exception during the launch() and the VM is not started.

Last commit renames self._args to self.args. The leading underscore
represents that the variable is private and as such it should not be
accessed externally. But that variable is the main API for inclusion
of Qemu command arguments, so the rename makes it public.

Changes v1->v2:
 - Style fixes to make checkpatch.pl happy.
 - Rebased.
Changes v2->v3:
 - Fix typo in patch 3 ("qemu.py: make 'args' public") commit message.

Amador Pahim (3):
  qemu.py: fix is_running()
  qemu.py: include debug information on launch error
  qemu.py: make 'args' public

 scripts/qemu.py               | 33 ++++++++++++++++++++++++---------
 tests/qemu-iotests/iotests.py | 18 +++++++++---------
 2 files changed, 33 insertions(+), 18 deletions(-)

-- 
2.13.3
