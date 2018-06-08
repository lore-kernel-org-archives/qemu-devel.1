Received: from eggs.gnu.org ([2001:4830:134:3::10]:47949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fRLUI-0002UR-RM
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:47:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fRLUG-0001dP-Ik
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:47:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50446 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1fRLUG-0001cV-AR
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:47:44 -0400
From: John Snow <jsnow@redhat.com>
Date: Fri,  8 Jun 2018 13:47:26 -0400
Message-Id: <20180608174733.4936-24-jsnow@redhat.com>
In-Reply-To: <20180608174733.4936-1-jsnow@redhat.com>
References: <20180608174733.4936-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PULL 23/30] MAINTAINERS: Add the cdrom-test to John's
 section
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, peter.maydell@linaro.org, Thomas Huth <thuth@redhat.com>

From: Thomas Huth <thuth@redhat.com>

The cdrom-test checks various block types - IDE, SCSI and
virtio, so it's a little bit hard to decide where this should
belong to in the MAINTAINERS file. But John volunteered to take
it, so let's put it into the IDE section for now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Acked-by: John Snow <jsnow@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4c73c16fee..a40f558694 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1003,6 +1003,7 @@ F: hw/block/cdrom.c
 F: hw/block/hd-geometry.c
 F: tests/ide-test.c
 F: tests/ahci-test.c
+F: tests/cdrom-test.c
 F: tests/libqos/ahci*
 T: git git://github.com/jnsnow/qemu.git ide
 
-- 
2.14.3
