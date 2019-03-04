Received: from eggs.gnu.org ([209.51.188.92]:46088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h0mIc-0008JW-CP
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 07:02:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h0mIa-00088R-2k
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 07:02:26 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon,  4 Mar 2019 13:01:45 +0100
Message-Id: <20190304120210.31500-3-cohuck@redhat.com>
In-Reply-To: <20190304120210.31500-1-cohuck@redhat.com>
References: <20190304120210.31500-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 02/27] s390x: use a QEMU-style typedef + name
 for SIGP save area struct
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

Convert this to QEMU style.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20190222081153.14206-3-david@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/helper.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index f3fcf96482ef..a7edd5df7d59 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -211,7 +211,7 @@ void s390_cpu_recompute_watchpoints(CPUState *cs)
     }
 }
 
-struct sigp_save_area {
+typedef struct SigpSaveArea {
     uint64_t    fprs[16];                       /* 0x0000 */
     uint64_t    grs[16];                        /* 0x0080 */
     PSW         psw;                            /* 0x0100 */
@@ -225,13 +225,13 @@ struct sigp_save_area {
     uint8_t     pad_0x0138[0x0140 - 0x0138];    /* 0x0138 */
     uint32_t    ars[16];                        /* 0x0140 */
     uint64_t    crs[16];                        /* 0x0384 */
-};
-QEMU_BUILD_BUG_ON(sizeof(struct sigp_save_area) != 512);
+} SigpSaveArea;
+QEMU_BUILD_BUG_ON(sizeof(SigpSaveArea) != 512);
 
 int s390_store_status(S390CPU *cpu, hwaddr addr, bool store_arch)
 {
     static const uint8_t ar_id = 1;
-    struct sigp_save_area *sa;
+    SigpSaveArea *sa;
     hwaddr len = sizeof(*sa);
     int i;
 
-- 
2.17.2
