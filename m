Received: from eggs.gnu.org ([2001:4830:134:3::10]:50708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cVy7o-0002ih-74
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 05:14:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cVy7l-0002bJ-L2
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 05:14:52 -0500
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Tue, 24 Jan 2017 12:39:09 +0300
Message-Id: <b7dbb62fdd3e766451f9c72f6d4f6ecaed7386b5.1485250702.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
References: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
References: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 05/31] include: Fix typos found by codespell
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Weil <sw@weilnetz.de>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Stefan Weil <sw@weilnetz.de>

Add also a missing parenthesis in a comment.

Signed-off-by: Stefan Weil <sw@weilnetz.de>
Acked-by: Alistair Francis <alistair.francis@xilinx.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 include/hw/dma/xlnx_dpdma.h    | 3 ++-
 include/hw/pci-host/q35.h      | 2 +-
 include/hw/register.h          | 2 +-
 include/qapi/dealloc-visitor.h | 2 +-
 include/qemu/qht.h             | 2 +-
 include/qemu/xattr.h           | 2 +-
 6 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/hw/dma/xlnx_dpdma.h b/include/hw/dma/xlnx_dpdma.h
index 664df28..7a304a5 100644
--- a/include/hw/dma/xlnx_dpdma.h
+++ b/include/hw/dma/xlnx_dpdma.h
@@ -53,7 +53,8 @@ typedef struct XlnxDPDMAState XlnxDPDMAState;
  *                             data to the buffer specified by
  *                             dpdma_set_host_data_location().
  *
- * Returns The number of bytes transfered by the DPDMA or 0 if an error occured.
+ * Returns The number of bytes transferred by the DPDMA
+ *         or 0 if an error occurred.
  *
  * @s The DPDMA state.
  * @channel The channel to start.
diff --git a/include/hw/pci-host/q35.h b/include/hw/pci-host/q35.h
index 94486fd..53b6760 100644
--- a/include/hw/pci-host/q35.h
+++ b/include/hw/pci-host/q35.h
@@ -180,7 +180,7 @@ typedef struct Q35PCIHost {
 uint64_t mch_mcfg_base(void);
 
 /*
- * Arbitary but unique BNF number for IOAPIC device.
+ * Arbitrary but unique BNF number for IOAPIC device.
  *
  * TODO: make sure there would have no conflict with real PCI bus
  */
diff --git a/include/hw/register.h b/include/hw/register.h
index 8c12233..5b6dc32 100644
--- a/include/hw/register.h
+++ b/include/hw/register.h
@@ -92,7 +92,7 @@ struct RegisterInfo {
  * This structure is used to group all of the individual registers which are
  * modeled using the RegisterInfo structure.
  *
- * @r is an aray containing of all the relevent RegisterInfo structures.
+ * @r is an array containing of all the relevant RegisterInfo structures.
  *
  * @num_elements is the number of elements in the array r
  *
diff --git a/include/qapi/dealloc-visitor.h b/include/qapi/dealloc-visitor.h
index b3e5c85..c36715f 100644
--- a/include/qapi/dealloc-visitor.h
+++ b/include/qapi/dealloc-visitor.h
@@ -19,7 +19,7 @@
 typedef struct QapiDeallocVisitor QapiDeallocVisitor;
 
 /*
- * The dealloc visitor is primarly used only by generated
+ * The dealloc visitor is primarily used only by generated
  * qapi_free_FOO() functions, and is the only visitor designed to work
  * correctly in the face of a partially-constructed QAPI tree.
  */
diff --git a/include/qemu/qht.h b/include/qemu/qht.h
index 311139b..56c2c77 100644
--- a/include/qemu/qht.h
+++ b/include/qemu/qht.h
@@ -72,7 +72,7 @@ void qht_destroy(struct qht *ht);
  * In case of successful operation, smp_wmb() is implied before the pointer is
  * inserted into the hash table.
  *
- * Returns true on sucess.
+ * Returns true on success.
  * Returns false if the @p-@hash pair already exists in the hash table.
  */
 bool qht_insert(struct qht *ht, void *p, uint32_t hash);
diff --git a/include/qemu/xattr.h b/include/qemu/xattr.h
index 83cf98c..a83fe8e 100644
--- a/include/qemu/xattr.h
+++ b/include/qemu/xattr.h
@@ -14,7 +14,7 @@
 #define QEMU_XATTR_H
 
 /*
- * Modern distributions (e.g. Fedora 15, have no libattr.so, place attr.h
+ * Modern distributions (e.g. Fedora 15), have no libattr.so, place attr.h
  * in /usr/include/sys, and don't have ENOATTR.
  */
 
-- 
2.1.4
