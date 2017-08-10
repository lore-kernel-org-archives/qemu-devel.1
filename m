Received: from eggs.gnu.org ([2001:4830:134:3::10]:53560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chugh.ishani@research.iiit.ac.in>)
	id 1dfrVv-0004h0-PQ
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 13:44:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chugh.ishani@research.iiit.ac.in>)
	id 1dfrVr-0002UJ-PL
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 13:44:55 -0400
Received: from research.iiit.ac.in ([196.12.53.8]:49092)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <chugh.ishani@research.iiit.ac.in>)
	id 1dfrVq-0002LJ-6F
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 13:44:51 -0400
From: Ishani Chugh <chugh.ishani@research.iiit.ac.in>
Date: Thu, 10 Aug 2017 23:14:33 +0530
Message-Id: <1502387075-29078-1-git-send-email-chugh.ishani@research.iiit.ac.in>
Subject: [Qemu-devel] [PATCH 0/2] QEMU Backup Tool
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, jsnow@redhat.com, Ishani Chugh <chugh.ishani@research.iiit.ac.in>

This patch series is intended to introduce QEMU Backup tool.
qemu-backup will be a command-line tool for performing full and
incremental disk backups on running VMs. It is intended as a
reference implementation for management stack and backup developers
to see QEMU's backup features in action.
This patch series contains two patches,
     1) Adding Manpage for the tool
     2) QEMU Backup command line tool

Ishani Chugh (2):
  Add manpage for QEMU Backup Tool
  backup: QEMU Backup Tool

 Makefile                        |  15 +-
 contrib/backup/qemu-backup.py   | 309 ++++++++++++++++++++++++++++++++++++++++
 contrib/backup/qemu-backup.texi | 135 ++++++++++++++++++
 3 files changed, 455 insertions(+), 4 deletions(-)
 create mode 100644 contrib/backup/qemu-backup.py
 create mode 100644 contrib/backup/qemu-backup.texi

-- 
2.7.4
