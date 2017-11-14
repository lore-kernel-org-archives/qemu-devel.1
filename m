Received: from eggs.gnu.org ([2001:4830:134:3::10]:51879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1eEYNU-0008Gd-8J
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 05:23:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1eEYNT-000371-7N
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 05:23:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48432)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <apahim@redhat.com>) id 1eEYNT-00036G-1W
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 05:23:35 -0500
From: Amador Pahim <apahim@redhat.com>
Date: Tue, 14 Nov 2017 11:22:38 +0100
Message-Id: <20171114102246.22221-1-apahim@redhat.com>
Subject: [Qemu-devel] [PATCH v11 0/8] scripts/qemu.py fixes and cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, crosa@redhat.com, ehabkost@redhat.com, muriloo@linux.vnet.ibm.com, armbru@redhat.com, Amador Pahim <apahim@redhat.com>

Changes v10->v11:
 - Fix messed indentation.
 - Rename self._qemu_log_fd to self._qemu_log_file.
 - Patch changelog in reverse order.
Changes v9->v10:
 - Keep method _remove_if_exists().
Changes v8->v9:
 - Some commits were already merged. Rebased the remaining ones.
 - New commit to remove unused import.
 - VM files control logic changed to use a temporary directory.
 - Better naming for variable controlling the need of a shutdown before
   next launch.
Changes v7->v8:
 - Rebased.
 - Reorder commits to avoid break->fix sequence.
 - Split commits "use poll() instead of 'returncode'" and "refactor
   launch()".
 - Don't ignore errors in _load_io_log(). Instead, check if we created
   the file before reading it.
 - Use LOG.warn() instead of LOG.debug() for the negative exit code
   message.
 - Fix the exception name called in commits "launch vm only if it's not
   running" and "don't launch again before shutdown()".
 - Minor style fixes.
Changes v6->v7:
 - Split commits in self-contained/atomic changes.
 - Addressed the comments from previous version, basically improving the
   logging messages and the control over created files. See individual
   commit messages for details.
Changes v5->v6:
 - Remove the commit to rename self._args.
 - Fix is_running() return before first call to maunch().
 - Use python logging system.
 - Include the full command line on negative exit code error message.
 - Use os.path.null instead of /dev/null.
 - Improve the control over the created/deleted files.
Changes v4->v5:
 - Break the cleanup commit into logical changes and include in the
   commit messages the rationale for making them.
Changes v3->v4:
 - Squash the 2 first commits since they are co-dependant.
 - Cleanup launch() and shutdown().
 - Reorder the commits, putting the rename of self._args first.
 - Rebased.
Changes v2->v3:
 - Fix typo in patch 3 ("qemu.py: make 'args' public") commit message.
Changes v1->v2:
 - Style fixes to make checkpatch.pl happy.
 - Rebased.

Amador Pahim (8):
  qemu.py: remove unused import
  qemu.py: better control of created files
  qemu.py: refactor launch()
  qemu.py: always cleanup on shutdown()
  qemu.py: use poll() instead of 'returncode'
  qemu.py: cleanup redundant calls in launch()
  qemu.py: launch vm only if it's not running
  qemu.py: don't launch again before shutdown()

 scripts/qemu.py | 89 ++++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 59 insertions(+), 30 deletions(-)

-- 
2.13.6
