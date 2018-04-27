Received: from eggs.gnu.org ([2001:4830:134:3::10]:37368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fBzsI-0002PI-VA
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:41:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fBzsI-0003yn-52
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:41:07 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Fri, 27 Apr 2018 11:40:46 +0200
Message-Id: <1524822046-22779-5-git-send-email-thuth@redhat.com>
In-Reply-To: <1524822046-22779-1-git-send-email-thuth@redhat.com>
References: <1524822046-22779-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v3 4/4] MAINTAINERS: Add the cdrom-test to
 John's section
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org

The cdrom-test checks various block types - IDE, SCSI and
virtio, so it's a little bit hard to decide where this should
belong to in the MAINTAINERS file. But John volunteered to take
it, so let's put it into the IDE section for now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 24b7016..6cceb10 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -998,6 +998,7 @@ F: hw/block/cdrom.c
 F: hw/block/hd-geometry.c
 F: tests/ide-test.c
 F: tests/ahci-test.c
+F: tests/cdrom-test.c
 F: tests/libqos/ahci*
 T: git git://github.com/jnsnow/qemu.git ide
 
-- 
1.8.3.1
