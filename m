Received: from eggs.gnu.org ([2001:4830:134:3::10]:54977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ffOiX-0005hd-Sx
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 08:04:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ffOiX-0007Rv-08
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 08:04:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33926 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ffOiW-0007Ql-SL
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 08:04:32 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 75B8A7D84D
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 12:04:32 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Tue, 17 Jul 2018 14:04:10 +0200
Message-Id: <20180717120414.5852-11-quintela@redhat.com>
In-Reply-To: <20180717120414.5852-1-quintela@redhat.com>
References: <20180717120414.5852-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 10/14] check: Only test virtio-serial when it
 is compiled in
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
---
 tests/Makefile.include | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index bb30c56795..7feda20577 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -204,10 +204,10 @@ check-qtest-virtio-y += tests/virtio-9p-test$(EXESUF)
 gcov-files-virtio-y += hw/9pfs/virtio-9p.c
 gcov-files-virtio-y += i386-softmmu/hw/9pfs/virtio-9p-device.c
 endif
-check-qtest-virtio-y += tests/virtio-serial-test$(EXESUF)
-gcov-files-virtio-y += i386-softmmu/hw/char/virtio-serial-bus.c
-check-qtest-virtio-y += $(check-qtest-virtioserial-y)
-gcov-files-virtio-y += $(gcov-files-virtioserial-y)
+check-qtest-virtio-$(CONFIG_VIRTIO_SERIAL) += tests/virtio-serial-test$(EXESUF)
+gcov-files-virtio-$(CONFIG_VIRTIO_SERIAL) += i386-softmmu/hw/char/virtio-serial-bus.c
+check-qtest-virtio-$(CONFIG_VIRTIO_SERIAL) += $(check-qtest-virtioserial-y)
+gcov-files-virtio-$(CONFIG_VIRTIO_SERIAL) += $(gcov-files-virtioserial-y)
 
 check-qtest-pci-y += tests/e1000-test$(EXESUF)
 gcov-files-pci-y += hw/net/e1000.c
-- 
2.17.1
