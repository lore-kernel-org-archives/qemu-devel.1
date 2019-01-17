Received: from eggs.gnu.org ([209.51.188.92]:53232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gkCBg-0008Al-5o
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 13:14:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gkCBf-0004nf-EX
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 13:14:44 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:51734 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gkCBb-00041X-KF
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 13:14:41 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu, 17 Jan 2019 19:13:03 +0100
Message-Id: <1547748785-14030-11-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1547748785-14030-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1547748785-14030-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL 10/12] target/mips: Add CP0 register MemoryMapID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Add CP0 register MemoryMapID. Only data field is added.
The corresponding functionality will be added in future
patches.

Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/cpu.h     | 1 +
 target/mips/machine.c | 5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index a5381b7..21daf50 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -536,6 +536,7 @@ struct CPUMIPSState {
  */
     target_ulong CP0_Context;
     target_ulong CP0_KScratch[MIPS_KSCRATCH_NUM];
+    int32_t CP0_MemoryMapID;
 /*
  * CP0 Register 5
  */
diff --git a/target/mips/machine.c b/target/mips/machine.c
index 111d7c3..1341ab1 100644
--- a/target/mips/machine.c
+++ b/target/mips/machine.c
@@ -214,8 +214,8 @@ const VMStateDescription vmstate_tlb = {
 
 const VMStateDescription vmstate_mips_cpu = {
     .name = "cpu",
-    .version_id = 16,
-    .minimum_version_id = 16,
+    .version_id = 17,
+    .minimum_version_id = 17,
     .post_load = cpu_post_load,
     .fields = (VMStateField[]) {
         /* Active TC */
@@ -253,6 +253,7 @@ const VMStateDescription vmstate_mips_cpu = {
         VMSTATE_UINT64(env.CP0_EntryLo0, MIPSCPU),
         VMSTATE_UINT64(env.CP0_EntryLo1, MIPSCPU),
         VMSTATE_UINTTL(env.CP0_Context, MIPSCPU),
+        VMSTATE_INT32(env.CP0_MemoryMapID, MIPSCPU),
         VMSTATE_INT32(env.CP0_PageMask, MIPSCPU),
         VMSTATE_INT32(env.CP0_PageGrain, MIPSCPU),
         VMSTATE_UINTTL(env.CP0_SegCtl0, MIPSCPU),
-- 
2.7.4
