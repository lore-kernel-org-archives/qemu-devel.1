Received: from eggs.gnu.org ([2001:4830:134:3::10]:59550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1dnkAY-0000vs-An
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 07:31:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1dnkAV-0006et-48
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 07:31:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35358)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <apahim@redhat.com>) id 1dnkAU-0006eW-Uf
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 07:31:23 -0400
From: Amador Pahim <apahim@redhat.com>
Date: Fri,  1 Sep 2017 13:28:16 +0200
Message-Id: <20170901112829.2571-1-apahim@redhat.com>
Subject: [Qemu-devel] [PATCH v8 00/13] scripts/qemu.py fixes and cleanups
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
Changes v6->v7:
 - Split commits in self-contained/atomic changes.
 - Addressed the comments from previous version, basically improving the
   logging messages and the control over created files. See individual
   commit messages for details.
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

Amador Pahim (13):
  qemu.py: fix is_running() return before first launch()
  qemu.py: avoid writing to stdout/stderr
  qemu.py: use os.path.null instead of /dev/null
  qemu.py: improve message on negative exit code
  qemu.py: include debug information on launch error
  qemu.py: make sure we only remove files we create
  qemu.py: close _qemu_log_path on cleanup
  qemu.py: refactor launch()
  qemu.py: always cleanup on shutdown()
  qemu.py: use poll() instead of 'returncode'
  qemu.py: cleanup redundant calls in launch()
  qemu.py: launch vm only if it's not running
  qemu.py: don't launch again before shutdown()

 scripts/qemu.py | 136 +++++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 101 insertions(+), 35 deletions(-)

-- 
2.13.5
