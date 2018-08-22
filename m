Received: from eggs.gnu.org ([2001:4830:134:3::10]:35819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fsOBh-00035q-75
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 04:08:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fsOBg-0007qN-1Z
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 04:08:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36078 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fsOBd-0007iJ-L6
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 04:08:19 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BBF6B4023ECB
	for <qemu-devel@nongnu.org>; Wed, 22 Aug 2018 08:08:11 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 22 Aug 2018 10:07:40 +0200
Message-Id: <20180822080751.11307-9-quintela@redhat.com>
In-Reply-To: <20180822080751.11307-1-quintela@redhat.com>
References: <20180822080751.11307-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 08/19] check: Only test hda when it is compiled
 in
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 tests/Makefile.include | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index e90a8a251c..ff8534056a 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -243,8 +243,8 @@ gcov-files-pci-y += hw/display/vga-pci.c
 gcov-files-pci-y += hw/display/virtio-gpu.c
 gcov-files-pci-y += hw/display/virtio-gpu-pci.c
 gcov-files-pci-$(CONFIG_VIRTIO_VGA) += hw/display/virtio-vga.c
-check-qtest-pci-y += tests/intel-hda-test$(EXESUF)
-gcov-files-pci-y += hw/audio/intel-hda.c hw/audio/hda-codec.c
+check-qtest-pci-$(CONFIG_HDA) += tests/intel-hda-test$(EXESUF)
+gcov-files-pci-$(CONFIG_HDA) += hw/audio/intel-hda.c hw/audio/hda-codec.c
 check-qtest-pci-$(CONFIG_IVSHMEM) += tests/ivshmem-test$(EXESUF)
 gcov-files-pci-y += hw/misc/ivshmem.c
 check-qtest-pci-y += tests/megasas-test$(EXESUF)
-- 
2.17.1
