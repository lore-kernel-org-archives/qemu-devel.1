Received: from eggs.gnu.org ([2001:4830:134:3::10]:39927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1ctfxs-0003Ay-AN
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 15:42:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1ctfxr-00078v-Ho
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 15:42:36 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Thu, 30 Mar 2017 21:42:14 +0200
Message-Id: <1490902938-9009-2-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1490902938-9009-1-git-send-email-eric.auger@redhat.com>
References: <1490902938-9009-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC v3 1/5] log: Add new IOMMU type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, peter.maydell@linaro.org, edgar.iglesias@gmail.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org, prem.mallappa@gmail.com
Cc: drjones@redhat.com, christoffer.dall@linaro.org, Radha.Chintakuntla@cavium.com, Sunil.Goutham@cavium.com

From: Prem Mallappa <prem.mallappa@broadcom.com>

Add CPU_LOG_IOMMU to log traces related to the IOMMU.

Signed-off-by: Prem Mallappa <prem.mallappa@broadcom.com>
Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

This may be replaced by dynamic traces later on
---
 include/qemu/log.h | 1 +
 util/log.c         | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/include/qemu/log.h b/include/qemu/log.h
index a50e994..906913b 100644
--- a/include/qemu/log.h
+++ b/include/qemu/log.h
@@ -43,6 +43,7 @@ static inline bool qemu_log_separate(void)
 #define CPU_LOG_PAGE       (1 << 14)
 #define LOG_TRACE          (1 << 15)
 #define CPU_LOG_TB_OP_IND  (1 << 16)
+#define CPU_LOG_IOMMU      (1 << 17)
 
 /* Returns true if a bit is set in the current loglevel mask
  */
diff --git a/util/log.c b/util/log.c
index 96f30dd..76968d6 100644
--- a/util/log.c
+++ b/util/log.c
@@ -258,6 +258,8 @@ const QEMULogItem qemu_log_items[] = {
       "show CPU registers before entering a TB (lots of logs)" },
     { CPU_LOG_MMU, "mmu",
       "log MMU-related activities" },
+    { CPU_LOG_IOMMU, "iommu",
+      "log IOMMU-related activities" },
     { CPU_LOG_PCALL, "pcall",
       "x86 only: show protected mode far calls/returns/exceptions" },
     { CPU_LOG_RESET, "cpu_reset",
-- 
2.5.5
