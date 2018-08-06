Received: from eggs.gnu.org ([2001:4830:134:3::10]:35569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fmgav-0004wL-Au
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 10:34:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fmgat-0000oi-ER
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 10:34:49 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:39561)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <e.emanuelegiuseppe@gmail.com>)
	id 1fmgat-0000oR-69
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 10:34:47 -0400
Received: by mail-ed1-x542.google.com with SMTP id h4-v6so5253002edi.6
	for <qemu-devel@nongnu.org>; Mon, 06 Aug 2018 07:34:47 -0700 (PDT)
From: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Date: Mon,  6 Aug 2018 16:33:46 +0200
Message-Id: <20180806143412.27722-9-e.emanuelegiuseppe@gmail.com>
In-Reply-To: <20180806143412.27722-1-e.emanuelegiuseppe@gmail.com>
References: <20180806143412.27722-1-e.emanuelegiuseppe@gmail.com>
Subject: [Qemu-devel] [PATCH v2 08/34] tests/qgraph: rename qpci_init_spapr
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>, Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>

Rename qpci_init_spapr in qpci_new_spapr, since the function actually
allocates a new QPCIBusSPAPR and initialize it.

Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
---
 tests/libqos/libqos-spapr.c | 2 +-
 tests/libqos/pci-spapr.c    | 2 +-
 tests/libqos/pci-spapr.h    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/libqos/libqos-spapr.c b/tests/libqos/libqos-spapr.c
index a37791e5d0..b3ba421cee 100644
--- a/tests/libqos/libqos-spapr.c
+++ b/tests/libqos/libqos-spapr.c
@@ -6,7 +6,7 @@
 static QOSOps qos_ops = {
     .init_allocator = spapr_alloc_init_flags,
     .uninit_allocator = spapr_alloc_uninit,
-    .qpci_init = qpci_init_spapr,
+    .qpci_init = qpci_spapr_new,
     .qpci_free = qpci_free_spapr,
     .shutdown = qtest_spapr_shutdown,
 };
diff --git a/tests/libqos/pci-spapr.c b/tests/libqos/pci-spapr.c
index c0f7e6db9b..30b6d5b5a7 100644
--- a/tests/libqos/pci-spapr.c
+++ b/tests/libqos/pci-spapr.c
@@ -160,7 +160,7 @@ static void qpci_spapr_config_writel(QPCIBus *bus, int devfn, uint8_t offset,
 #define SPAPR_PCI_MMIO32_WIN_SIZE    0x80000000 /* 2 GiB */
 #define SPAPR_PCI_IO_WIN_SIZE        0x10000
 
-QPCIBus *qpci_init_spapr(QTestState *qts, QGuestAllocator *alloc)
+QPCIBus *qpci_spapr_new(QTestState *qts, QGuestAllocator *alloc)
 {
     QPCIBusSPAPR *ret = g_new0(QPCIBusSPAPR, 1);
 
diff --git a/tests/libqos/pci-spapr.h b/tests/libqos/pci-spapr.h
index 387686dfc8..d5305d16f8 100644
--- a/tests/libqos/pci-spapr.h
+++ b/tests/libqos/pci-spapr.h
@@ -11,7 +11,7 @@
 #include "libqos/malloc.h"
 #include "libqos/pci.h"
 
-QPCIBus *qpci_init_spapr(QTestState *qts, QGuestAllocator *alloc);
+QPCIBus *qpci_spapr_new(QTestState *qts, QGuestAllocator *alloc);
 void     qpci_free_spapr(QPCIBus *bus);
 
 #endif
-- 
2.17.1
