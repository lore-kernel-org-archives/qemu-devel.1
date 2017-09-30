Received: from eggs.gnu.org ([2001:4830:134:3::10]:49395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1dy7DX-0002PF-NE
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 22:09:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1dy7DW-00050S-R9
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 22:09:23 -0400
From: Aaron Lindsay <alindsay@codeaurora.org>
Date: Fri, 29 Sep 2017 22:08:18 -0400
Message-Id: <1506737310-21880-2-git-send-email-alindsay@codeaurora.org>
In-Reply-To: <1506737310-21880-1-git-send-email-alindsay@codeaurora.org>
References: <1506737310-21880-1-git-send-email-alindsay@codeaurora.org>
Subject: [Qemu-devel] [PATCH 01/13] target/arm: A53: Initialize PMCEID[0]
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Peter Crosthwaite <peter.crosthwaite@xilinx.com>, Wei Huang <wei@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Spradling <mspradli@codeaurora.org>, Aaron Lindsay <alindsay@codeaurora.org>, Digant Desai <digantd@codeaurora.org>
List-ID: <qemu-devel.nongnu.org>

A53 advertises ARM_FEATURE_PMU, but wasn't initializing pmceid[01]

Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
---
 target/arm/cpu.c   | 2 +-
 target/arm/cpu64.c | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 4300de6..a6c29cf 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1402,7 +1402,7 @@ static void cortex_a15_initfn(Object *obj)
     cpu->id_pfr0 = 0x00001131;
     cpu->id_pfr1 = 0x00011011;
     cpu->id_dfr0 = 0x02010555;
-    cpu->pmceid0 = 0x0000000;
+    cpu->pmceid0 = 0x00000000;
     cpu->pmceid1 = 0x00000000;
     cpu->id_afr0 = 0x00000000;
     cpu->id_mmfr0 = 0x10201105;
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 670c07a..7b1642e 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -198,6 +198,8 @@ static void aarch64_a53_initfn(Object *obj)
     cpu->id_isar5 = 0x00011121;
     cpu->id_aa64pfr0 = 0x00002222;
     cpu->id_aa64dfr0 = 0x10305106;
+    cpu->pmceid0 = 0x00000000;
+    cpu->pmceid1 = 0x00000000;
     cpu->id_aa64isar0 = 0x00011120;
     cpu->id_aa64mmfr0 = 0x00001122; /* 40 bit physical addr */
     cpu->dbgdidr = 0x3516d000;
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.\nQualcomm Technologies, Inc. is a member of the\nCode Aurora Forum, a Linux Foundation Collaborative Project.
