Received: from eggs.gnu.org ([2001:4830:134:3::10]:40633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chugh.ishani@research.iiit.ac.in>)
	id 1dn8T1-0007kz-7B
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 15:16:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chugh.ishani@research.iiit.ac.in>)
	id 1dn8Sy-00081h-13
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 15:15:59 -0400
Received: from research.iiit.ac.in ([196.12.53.8]:45860)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <chugh.ishani@research.iiit.ac.in>)
	id 1dn8Sx-000800-CP
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 15:15:55 -0400
From: Ishani Chugh <chugh.ishani@research.iiit.ac.in>
Date: Thu, 31 Aug 2017 00:45:35 +0530
Message-Id: <1504120538-9309-1-git-send-email-chugh.ishani@research.iiit.ac.in>
Subject: [Qemu-devel] [PATCH 0/3] Backup Tool: Incremental backup
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

This patch series is intended to add incremental backup functionality
to Backup Tool.
This patch series contains three patches,
            1) QEMU Backup command line tool(With Incremental backup).
            2) Test for incremental backup.
            3) Manpage for the tool(Incremental backup example).

Based on: 1504113297-22052-1-git-send-email-chugh.ishani@research.iiit.ac.in
Ishani Chugh (3):
  Backup Tool: Manpage for Incremental Backup
  Backup Tool: Support for Incremental Backup
  Backup Tool: Test for Incremental Backup

 contrib/backup/qemu-backup.py   | 101 +++++++++++++++++++++++++++++++++++++++-
 contrib/backup/qemu-backup.texi |  18 +++++++
 tests/qemu-iotests/193          |  86 ++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/193.out      |  34 ++++++++++++++
 tests/qemu-iotests/group        |   1 +
 5 files changed, 238 insertions(+), 2 deletions(-)
 create mode 100755 tests/qemu-iotests/193
 create mode 100644 tests/qemu-iotests/193.out

-- 
2.7.4
