Received: from eggs.gnu.org ([2001:4830:134:3::10]:51924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1e4CDw-0006fD-8A
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 16:42:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1e4CDt-0006QD-4g
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 16:42:56 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Mon, 16 Oct 2017 23:33:37 +0300
Message-Id: <43621fafc2605f81ff101eddd57feaeeec9b3b99.1508185933.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1508185933.git.mjt@msgid.tls.msk.ru>
References: <cover.1508185933.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1508185933.git.mjt@msgid.tls.msk.ru>
References: <cover.1508185933.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 10/14] MAINTAINERS: Clean up SCSI device section
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Fam Zheng <famz@redhat.com>

1. Remove nonexistent file util/scsi*.
2. Drop useless section for LSI53C895A.
3. Leave include/scsi to "Block SCSI subsystem" section.

Suggested-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 MAINTAINERS | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9cff9737d3..86c9ec9cde 100644
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
2.11.0
