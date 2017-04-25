Received: from eggs.gnu.org ([2001:4830:134:3::10]:60464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1d2r1t-0005PX-6o
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 23:20:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1d2r1s-0004lV-2S
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 23:20:41 -0400
Received: from mail-it0-x241.google.com ([2607:f8b0:4001:c0b::241]:35725)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1d2r1r-0004kr-Sp
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 23:20:39 -0400
Received: by mail-it0-x241.google.com with SMTP id 70so1383002ita.2
	for <qemu-devel@nongnu.org>; Mon, 24 Apr 2017 20:20:39 -0700 (PDT)
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <D2FDBDAA-4477-4BA6-B03A-8836CB6CE173@gmail.com>
Content-Transfer-Encoding: 7bit
From: G 3 <programmingkidx@gmail.com>
Date: Mon, 24 Apr 2017 23:20:36 -0400
Subject: [Qemu-devel] [PATCH 4/9] Add risu_reginfo_ppc.h file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>

Add the risu_reginfo_ppc.h file. It defines the reginfo structure.

Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
---
  risu_reginfo_ppc.h | 32 ++++++++++++++++++++++++++++++++
  1 file changed, 32 insertions(+)
  create mode 100644 risu_reginfo_ppc.h

diff --git a/risu_reginfo_ppc.h b/risu_reginfo_ppc.h
new file mode 100644
index 0000000..c3b342d
--- /dev/null
+++ b/risu_reginfo_ppc.h
@@ -0,0 +1,32 @@
+/******************************************
+ * File: risu_reginfo_ppc.h
+ * Description: 32 bit powerpc registers
+ * Date: 3-26-2017
+ ******************************************/
+
+#ifndef RISU_REGINFO_PPC_H
+#define RISU_REGINFO_PPC_H
+
+struct reginfo
+{
+    uint32_t faulting_insn;
+    uint32_t previous_instruction;  /* The instruction before the  
faulting instruction */
+    uint32_t second_previous_instruction;  /* The second instruction  
before the faulting instruction */
+
+    /************** User Model UISA *********************************/
+
+    uint32_t gpr[32];    /* General Purpose Registers */
+    double fpr[32];      /* Floating-point Registers */
+    uint32_t cr;         /* Condition Register */
+    uint32_t fpscr;      /* Floating-point Status and Control  
Register */
+    uint32_t xer;        /* Fixed-point Exception Register */
+    uint32_t lr;         /* Link Register */
+    uint32_t ctr;        /* Count Register */
+
+    /*
+     * Since we can't test any registers in the Supervisor Model,  
they are not
+     * included.
+     */
+};
+
+#endif /* RISU_REGINFO_PPC_H */
-- 
2.10.2
