Received: from eggs.gnu.org ([2001:4830:134:3::10]:36362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chugh.ishani@research.iiit.ac.in>)
	id 1dn6aJ-0005JQ-5t
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 13:15:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chugh.ishani@research.iiit.ac.in>)
	id 1dn6aG-0005Be-1o
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 13:15:23 -0400
Received: from research.iiit.ac.in ([196.12.53.8]:59024)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <chugh.ishani@research.iiit.ac.in>)
	id 1dn6aF-0005B7-DV
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 13:15:19 -0400
From: Ishani Chugh <chugh.ishani@research.iiit.ac.in>
Date: Wed, 30 Aug 2017 22:44:54 +0530
Message-Id: <1504113297-22052-1-git-send-email-chugh.ishani@research.iiit.ac.in>
Subject: [Qemu-devel] [PATCH v3 0/3] QEMU Backup Tool
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, jsnow@redhat.com, famz@redhat.com, Ishani Chugh <chugh.ishani@research.iiit.ac.in>

This patch series is intended to introduce QEMU Backup tool.
qemu-backup will be a command-line tool for performing full and
incremental disk backups on running VMs. It is intended as a
reference implementation for management stack and backup developers
to see QEMU's backup features in action.
This patch series contains three patches,
               1) QEMU Backup command line tool.
               2) Test for full backup.
               3) Manpage for the tool.
v3:
* Added versioning in config file
* Replace location by qemu-img convert in restore
* Removed incremental backup documentation from manpage

Ishani Chugh (3):
  backup: QEMU Backup Tool
  Test for full Backup
  Add manpage for QEMU Backup Tool

 Makefile                        |  14 +-
 contrib/backup/qemu-backup.py   | 343 ++++++++++++++++++++++++++++++++++++++++
 contrib/backup/qemu-backup.texi | 142 +++++++++++++++++
 tests/qemu-iotests/191          |  86 ++++++++++
 tests/qemu-iotests/191.out      |  35 ++++
 tests/qemu-iotests/group        |   2 +
 6 files changed, 618 insertions(+), 4 deletions(-)
 create mode 100644 contrib/backup/qemu-backup.py
 create mode 100644 contrib/backup/qemu-backup.texi
 create mode 100755 tests/qemu-iotests/191
 create mode 100644 tests/qemu-iotests/191.out

-- 
2.7.4
