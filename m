Received: from eggs.gnu.org ([2001:4830:134:3::10]:38105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dzodp-00088m-7m
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 14:43:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dzodo-0002Yr-GR
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 14:43:33 -0400
Received: from mail-qt0-x230.google.com ([2607:f8b0:400d:c0d::230]:53434)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dzodo-0002YP-Ci
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 14:43:32 -0400
Received: by mail-qt0-x230.google.com with SMTP id 47so21026278qts.10
	for <qemu-devel@nongnu.org>; Wed, 04 Oct 2017 11:43:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  4 Oct 2017 14:43:14 -0400
Message-Id: <20171004184325.24157-2-richard.henderson@linaro.org>
In-Reply-To: <20171004184325.24157-1-richard.henderson@linaro.org>
References: <20171004184325.24157-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v1 01/12] HACK: use objdump disas
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org

---
 disas.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/disas.c b/disas.c
index d6a1eb9c8e..69069a85ca 100644
--- a/disas.c
+++ b/disas.c
@@ -231,7 +231,7 @@ void target_disas(FILE *out, CPUState *cpu, target_ulong code,
     s.info.disassembler_options = (char *)"any";
     s.info.print_insn = print_insn_ppc;
 #endif
-    if (s.info.print_insn == NULL) {
+    if (1 || s.info.print_insn == NULL) {
         s.info.print_insn = print_insn_od_target;
     }
 
-- 
2.13.6
