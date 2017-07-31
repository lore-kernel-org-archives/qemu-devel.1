Received: from eggs.gnu.org ([2001:4830:134:3::10]:55195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1dc6Vh-0001yo-7p
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 04:57:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1dc6Vd-000301-D2
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 04:57:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49886)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <apahim@redhat.com>) id 1dc6Vd-0002zp-7U
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 04:57:05 -0400
From: Amador Pahim <apahim@redhat.com>
Date: Mon, 31 Jul 2017 10:51:03 +0200
Message-Id: <20170731085110.1050-1-apahim@redhat.com>
Subject: [Qemu-devel] [PATCH v6 0/7] scripts/qemu.py fixes and cleanups
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
Changes v5->v6:
 - Remove the commit to rename self._args.
 - Fix is_running() return before first call to maunch().
 - Use python logging system.
 - Include the full command line on negative exit code error message.
 - Use os.path.null instead of /dev/null.
 - Improve the control over the created/deleted files.

Amador Pahim (7):
  qemu.py: use poll() instead of 'returncode'
  qemu.py: fix is_running() return before first launch()
  qemu.py: use python logging system
  qemu.py: improve message on negative exit code
  qemu.py: use os.path.null instead of /dev/null
  qemu.py: cleanup and improve launch()/shutdown()
  qemu.py: include debug information on launch error

 scripts/qemu.py | 121 ++++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 91 insertions(+), 30 deletions(-)

-- 
2.13.3
