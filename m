Received: from eggs.gnu.org ([2001:4830:134:3::10]:40634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chugh.ishani@research.iiit.ac.in>)
	id 1dn8T1-0007l0-7P
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 15:16:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chugh.ishani@research.iiit.ac.in>)
	id 1dn8Sy-000827-So
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 15:15:59 -0400
Received: from research.iiit.ac.in ([196.12.53.8]:45862)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <chugh.ishani@research.iiit.ac.in>)
	id 1dn8Sx-000809-CA
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 15:15:56 -0400
From: Ishani Chugh <chugh.ishani@research.iiit.ac.in>
Date: Thu, 31 Aug 2017 00:45:36 +0530
Message-Id: <1504120538-9309-2-git-send-email-chugh.ishani@research.iiit.ac.in>
In-Reply-To: <1504120538-9309-1-git-send-email-chugh.ishani@research.iiit.ac.in>
References: <1504120538-9309-1-git-send-email-chugh.ishani@research.iiit.ac.in>
Subject: [Qemu-devel] [PATCH 1/3] Backup Tool: Manpage for Incremental Backup
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

Adds command description to perform incremental backup and
a full example for the same.

Signed-off-by: Ishani Chugh <chugh.ishani@research.iiit.ac.in>
---
 contrib/backup/qemu-backup.texi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/contrib/backup/qemu-backup.texi b/contrib/backup/qemu-backup.texi
index 7ad266c..8e5cb86 100644
--- a/contrib/backup/qemu-backup.texi
+++ b/contrib/backup/qemu-backup.texi
@@ -58,6 +58,7 @@ qemu-backup command [command options].
 @item qemu-backup restore --guest guestname
 @item qemu-backup guest remove --guest guestname
 @item qemu-backup drive remove --guest guestname --id driveid
+@item qemu-backup backup --inc --guest guestname
 @end itemize
 @node  Command Parameters
 @chapter  Command Parameters
@@ -67,6 +68,7 @@ qemu-backup command [command options].
 @item --id: id of guest or drive.
 @item --qmp: Path of qmp socket.
 @item --target: Destination path on which you want your backup to be made.
+@item --inc: incremental backup (Optional).
 @end itemize
 
 @node  Command Descriptions
@@ -119,6 +121,11 @@ This command helps remove a drive which is set for backup in configuration of gi
 
 example: drive remove --guest=fedora --id=root
 
+@item qemu-backup backup --inc --guest guestname
+This command is used for making incremental backup.
+
+example: qemu-backup backup --inc --guest fedora
+
 @item A full backup can be performed by following the given steps:
 
 Perform a full backup of 'vm001', which has one drive:
@@ -129,6 +136,17 @@ qemu-backup add --id drive0 --guest vm001 --target /backups/vm001-drive0.img
 
 qemu-backup backup --guest vm001
 
+@item An incremental backup can be performed by following the given steps:
+
+Perform an incremental backup of 'vm001', which has one drive:
+
+qemu-backup guest add --guest vm001 --qmp /path/to/vm001.sock
+
+qemu-backup add --id drive0 --guest vm001 --target /backups/vm001-drive0.img
+
+qemu-backup backup --inc --guest vm001
+
+qemu-backup backup --inc --guest vm001
 
 @end itemize
 
-- 
2.7.4
