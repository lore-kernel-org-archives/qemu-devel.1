Received: from eggs.gnu.org ([2001:4830:134:3::10]:46393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cYvDa-0006K9-Oi
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 08:45:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cYvDZ-0004jG-D8
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 08:45:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56428)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cYvDZ-0004ie-5P
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 08:45:01 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed,  1 Feb 2017 13:44:46 +0000
Message-Id: <20170201134453.11963-4-stefanha@redhat.com>
In-Reply-To: <20170201134453.11963-1-stefanha@redhat.com>
References: <20170201134453.11963-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 03/10] trace: move hw/xen events to correct
 subdir
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Daniel P. Berrange" <berrange@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: "Daniel P. Berrange" <berrange@redhat.com>

The trace-events for a given source file should generally
always live in the same directory as the source file.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Message-id: 20170125161417.31949-4-berrange@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 Makefile.objs       |  1 +
 hw/xen/trace-events | 13 +++++++++++++
 trace-events        | 10 ----------
 3 files changed, 14 insertions(+), 10 deletions(-)
 create mode 100644 hw/xen/trace-events

diff --git a/Makefile.objs b/Makefile.objs
index babbc4e..9ac11e7 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -152,6 +152,7 @@ trace-events-y += hw/vfio/trace-events
 trace-events-y += hw/acpi/trace-events
 trace-events-y += hw/arm/trace-events
 trace-events-y += hw/alpha/trace-events
+trace-events-y += hw/xen/trace-events
 trace-events-y += ui/trace-events
 trace-events-y += audio/trace-events
 trace-events-y += net/trace-events
diff --git a/hw/xen/trace-events b/hw/xen/trace-events
new file mode 100644
index 0000000..c4fb6f1
--- /dev/null
+++ b/hw/xen/trace-events
@@ -0,0 +1,13 @@
+# See docs/tracing.txt for syntax documentation.
+
+# include/hw/xen/xen_common.h
+xen_default_ioreq_server(void) ""
+xen_ioreq_server_create(uint32_t id) "id: %u"
+xen_ioreq_server_destroy(uint32_t id) "id: %u"
+xen_ioreq_server_state(uint32_t id, bool enable) "id: %u: enable: %i"
+xen_map_mmio_range(uint32_t id, uint64_t start_addr, uint64_t end_addr) "id: %u start: %#"PRIx64" end: %#"PRIx64
+xen_unmap_mmio_range(uint32_t id, uint64_t start_addr, uint64_t end_addr) "id: %u start: %#"PRIx64" end: %#"PRIx64
+xen_map_portio_range(uint32_t id, uint64_t start_addr, uint64_t end_addr) "id: %u start: %#"PRIx64" end: %#"PRIx64
+xen_unmap_portio_range(uint32_t id, uint64_t start_addr, uint64_t end_addr) "id: %u start: %#"PRIx64" end: %#"PRIx64
+xen_map_pcidev(uint32_t id, uint8_t bus, uint8_t dev, uint8_t func) "id: %u bdf: %02x.%02x.%02x"
+xen_unmap_pcidev(uint32_t id, uint8_t bus, uint8_t dev, uint8_t func) "id: %u bdf: %02x.%02x.%02x"
diff --git a/trace-events b/trace-events
index 839a9d0..05ac6ac 100644
--- a/trace-events
+++ b/trace-events
@@ -62,16 +62,6 @@ spice_vmc_event(int event) "spice vmc event %d"
 # xen-hvm.c
 xen_ram_alloc(unsigned long ram_addr, unsigned long size) "requested: %#lx, size %#lx"
 xen_client_set_memory(uint64_t start_addr, unsigned long size, bool log_dirty) "%#"PRIx64" size %#lx, log_dirty %i"
-xen_default_ioreq_server(void) ""
-xen_ioreq_server_create(uint32_t id) "id: %u"
-xen_ioreq_server_destroy(uint32_t id) "id: %u"
-xen_ioreq_server_state(uint32_t id, bool enable) "id: %u: enable: %i"
-xen_map_mmio_range(uint32_t id, uint64_t start_addr, uint64_t end_addr) "id: %u start: %#"PRIx64" end: %#"PRIx64
-xen_unmap_mmio_range(uint32_t id, uint64_t start_addr, uint64_t end_addr) "id: %u start: %#"PRIx64" end: %#"PRIx64
-xen_map_portio_range(uint32_t id, uint64_t start_addr, uint64_t end_addr) "id: %u start: %#"PRIx64" end: %#"PRIx64
-xen_unmap_portio_range(uint32_t id, uint64_t start_addr, uint64_t end_addr) "id: %u start: %#"PRIx64" end: %#"PRIx64
-xen_map_pcidev(uint32_t id, uint8_t bus, uint8_t dev, uint8_t func) "id: %u bdf: %02x.%02x.%02x"
-xen_unmap_pcidev(uint32_t id, uint8_t bus, uint8_t dev, uint8_t func) "id: %u bdf: %02x.%02x.%02x"
 handle_ioreq(void *req, uint32_t type, uint32_t dir, uint32_t df, uint32_t data_is_ptr, uint64_t addr, uint64_t data, uint32_t count, uint32_t size) "I/O=%p type=%d dir=%d df=%d ptr=%d port=%#"PRIx64" data=%#"PRIx64" count=%d size=%d"
 handle_ioreq_read(void *req, uint32_t type, uint32_t df, uint32_t data_is_ptr, uint64_t addr, uint64_t data, uint32_t count, uint32_t size) "I/O=%p read type=%d df=%d ptr=%d port=%#"PRIx64" data=%#"PRIx64" count=%d size=%d"
 handle_ioreq_write(void *req, uint32_t type, uint32_t df, uint32_t data_is_ptr, uint64_t addr, uint64_t data, uint32_t count, uint32_t size) "I/O=%p write type=%d df=%d ptr=%d port=%#"PRIx64" data=%#"PRIx64" count=%d size=%d"
-- 
2.9.3
