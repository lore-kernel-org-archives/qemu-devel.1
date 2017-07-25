Received: from eggs.gnu.org ([2001:4830:134:3::10]:48814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1da3US-0003gz-1B
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 13:19:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1da3UO-0000bw-0s
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 13:19:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48402)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <apahim@redhat.com>) id 1da3UN-0000aH-QM
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 13:19:19 -0400
From: Amador Pahim <apahim@redhat.com>
Date: Tue, 25 Jul 2017 19:10:08 +0200
Message-Id: <20170725171014.25193-1-apahim@redhat.com>
Subject: [Qemu-devel] [PATCH v5 0/6] scripts/qemu.py fixes and cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com, famz@redhat.com, berrange@redhat.com, ehabkost@redhat.com, mreitz@redhat.com, kwolf@redhat.com, armbru@redhat.com, crosa@redhat.com, ldoktor@redhat.com, Amador Pahim <apahim@redhat.com>

First commit renames self._args to self.args. The leading underscore
represents that the variable is private and as such it should not be
accessed on instances. But that variable is the main API for inclusion
of Qemu command arguments, so the rename makes it public.

Next commits contain a series of fixes and cleanups to make sure we are
correctly trying to launch the VM and properly shutting it down. More
details about the changes in the individual commit messages.

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
Changes v4->v5:
 - Break the cleanup commit into logical changes and include in the
   commit messages the rationale for making them.

Amador Pahim (6):
  qemu.py: make 'args' public
  qemu.py: use poll() instead of 'returncode'
  qemu.py: cleanup message on negative exit code
  qemu.py: cleanup launch()
  qemu.py: make sure shutdown() is called before launching again
  qemu.py: include qemu command line and output on launch error

 scripts/qemu.py               | 72 ++++++++++++++++++++++++++++---------------
 tests/qemu-iotests/iotests.py | 18 +++++------
 2 files changed, 57 insertions(+), 33 deletions(-)

-- 
2.13.3
