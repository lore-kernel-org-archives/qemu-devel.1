Received: from eggs.gnu.org ([2001:4830:134:3::10]:34580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1e2vjJ-0003lD-GO
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 04:54:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1e2vjI-0000bc-Js
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 04:54:05 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 13 Oct 2017 16:53:53 +0800
Message-Id: <20171013085355.7563-2-famz@redhat.com>
In-Reply-To: <20171013085355.7563-1-famz@redhat.com>
References: <20171013085355.7563-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/3] MAINTAINERS: Clean up SCSI device
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
Cc: qemu-trivial@nongnu.org, Thomas Huth <thuth@redhat.com>

1. Remove nonexistent file util/scsi*.
2. Drop useless section for LSI53C895A.
3. Leave include/scsi to "Block SCSI subsystem" section.

Suggested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 MAINTAINERS | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 772ac209e1..18ddaf4070 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -980,16 +980,10 @@ SCSI
 M: Paolo Bonzini <pbonzini@redhat.com>
 S: Supported
 F: include/hw/scsi/*
-F: include/scsi/*
 F: hw/scsi/*
-F: util/scsi*
 F: tests/virtio-scsi-test.c
 T: git git://github.com/bonzini/qemu.git scsi-next
 
-LSI53C895A
-S: Orphan
-F: hw/scsi/lsi53c895a.c
-
 SSI
 M: Peter Crosthwaite <crosthwaite.peter@gmail.com>
 M: Alistair Francis <alistair.francis@xilinx.com>
-- 
2.13.5
