Received: from eggs.gnu.org ([2001:4830:134:3::10]:41897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1dikoV-0007Sj-K9
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 13:12:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1dikoU-0005gL-JX
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 13:12:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39518)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <apahim@redhat.com>) id 1dikoU-0005g7-E4
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 13:12:02 -0400
From: Amador Pahim <apahim@redhat.com>
Date: Fri, 18 Aug 2017 19:05:15 +0200
Message-Id: <20170818170526.13496-1-apahim@redhat.com>
Subject: [Qemu-devel] [PATCH v7 00/11] scripts/qemu.py fixes and cleanups
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

Amador Pahim (11):
  qemu.py: fix is_running() return before first launch()
  qemu.py: avoid writing to stdout/stderr
  qemu.py: use os.path.null instead of /dev/null
  qemu.py: use poll() instead of 'returncode'
  qemu.py: cleanup redundant calls in launch()
  qemu.py: improve message on negative exit code
  qemu.py: include debug information on launch error
  qemu.py: make sure we only remove files we create
  qemu.py: launch vm only if it's not running
  qemu.py: don't launch again before shutdown()
  qemu.py: refactor launch()

 scripts/qemu.py | 141 ++++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 106 insertions(+), 35 deletions(-)

-- 
2.13.5
