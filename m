Received: from eggs.gnu.org ([2001:4830:134:3::10]:52122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ele1d-0002nc-CX
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:05:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ele1c-0005Fa-E1
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:05:49 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 13 Feb 2018 18:04:38 +0100
Message-Id: <20180213170529.10858-5-kwolf@redhat.com>
In-Reply-To: <20180213170529.10858-1-kwolf@redhat.com>
References: <20180213170529.10858-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 04/55] docs: Document share-rw property more
 thoroughly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Fam Zheng <famz@redhat.com>

Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Kashyap Chamarthy <kchamart@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 docs/qemu-block-drivers.texi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/docs/qemu-block-drivers.texi b/docs/qemu-block-drivers.texi
index cd74767ed3..f1793692bb 100644
--- a/docs/qemu-block-drivers.texi
+++ b/docs/qemu-block-drivers.texi
@@ -845,6 +845,16 @@ QEMU transparently handles lock handover during shared storage migration.  For
 shared virtual disk images between multiple VMs, the "share-rw" device option
 should be used.
 
+By default, the guest has exclusive write access to its disk image. If the
+guest can safely share the disk image with other writers the @code{-device
+...,share-rw=on} parameter can be used.  This is only safe if the guest is
+running software, such as a cluster file system, that coordinates disk accesses
+to avoid corruption.
+
+Note that share-rw=on only declares the guest's ability to share the disk.
+Some QEMU features, such as image file formats, require exclusive write access
+to the disk image and this is unaffected by the share-rw=on option.
+
 Alternatively, locking can be fully disabled by "locking=off" block device
 option. In the command line, the option is usually in the form of
 "file.locking=off" as the protocol driver is normally placed as a "file" child
-- 
2.13.6
