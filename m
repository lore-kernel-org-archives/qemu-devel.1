Received: from eggs.gnu.org ([2001:4830:134:3::10]:60619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cVyrW-0002fa-Ta
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 06:02:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cVyrW-0008RB-41
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 06:02:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39930)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cVyrV-0008Qt-VJ
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 06:02:06 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue, 24 Jan 2017 11:01:47 +0000
Message-Id: <20170124110151.937-5-berrange@redhat.com>
In-Reply-To: <20170124110151.937-1-berrange@redhat.com>
References: <20170124110151.937-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v3 4/8] trace: move hw/i386/xen events to
 correct subdir
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

The trace-events for a given source file should generally
always live in the same directory as the source file.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 Makefile.objs            | 1 +
 hw/i386/trace-events     | 7 -------
 hw/i386/xen/trace-events | 6 ++++++
 3 files changed, 7 insertions(+), 7 deletions(-)
 create mode 100644 hw/i386/xen/trace-events

diff --git a/Makefile.objs b/Makefile.objs
index 9ac11e7..6abe0b9 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -144,6 +144,7 @@ trace-events-y += hw/sd/trace-events
 trace-events-y += hw/isa/trace-events
 trace-events-y += hw/mem/trace-events
 trace-events-y += hw/i386/trace-events
+trace-events-y += hw/i386/xen/trace-events
 trace-events-y += hw/9pfs/trace-events
 trace-events-y += hw/ppc/trace-events
 trace-events-y += hw/pci/trace-events
diff --git a/hw/i386/trace-events b/hw/i386/trace-events
index d2b4973..a3568ee 100644
--- a/hw/i386/trace-events
+++ b/hw/i386/trace-events
@@ -1,12 +1,5 @@
 # See docs/tracing.txt for syntax documentation.
 
-# hw/i386/xen/xen_platform.c
-xen_platform_log(char *s) "xen platform: %s"
-
-# hw/i386/xen/xen_pvdevice.c
-xen_pv_mmio_read(uint64_t addr) "WARNING: read from Xen PV Device MMIO space (address %"PRIx64")"
-xen_pv_mmio_write(uint64_t addr) "WARNING: write to Xen PV Device MMIO space (address %"PRIx64")"
-
 # hw/i386/x86-iommu.c
 x86_iommu_iec_notify(bool global, uint32_t index, uint32_t mask) "Notify IEC invalidation: global=%d index=%" PRIu32 " mask=%" PRIu32
 
diff --git a/hw/i386/xen/trace-events b/hw/i386/xen/trace-events
new file mode 100644
index 0000000..321fe60
--- /dev/null
+++ b/hw/i386/xen/trace-events
@@ -0,0 +1,6 @@
+# hw/i386/xen/xen_platform.c
+xen_platform_log(char *s) "xen platform: %s"
+
+# hw/i386/xen/xen_pvdevice.c
+xen_pv_mmio_read(uint64_t addr) "WARNING: read from Xen PV Device MMIO space (address %"PRIx64")"
+xen_pv_mmio_write(uint64_t addr) "WARNING: write to Xen PV Device MMIO space (address %"PRIx64")"
-- 
2.9.3
