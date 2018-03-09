Received: from eggs.gnu.org ([2001:4830:134:3::10]:47543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1euOWE-0002QP-FD
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 15:21:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1euOWB-0004Z5-CE
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 15:21:34 -0500
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:33489)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1euOWB-0004Yy-4j
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 15:21:31 -0500
Received: by mail-pg0-x243.google.com with SMTP id g12so3979345pgs.0
	for <qemu-devel@nongnu.org>; Fri, 09 Mar 2018 12:21:31 -0800 (PST)
From: Michael Clark <mjc@sifive.com>
Date: Sat, 10 Mar 2018 09:20:18 +1300
Message-Id: <1520626818-93348-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH] RISC-V: Fix isa string logic bug,
 use popcount to count bits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Peter Maydell <peter.maydell@linaro.org>

Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Michael Clark <mjc@sifive.com>
---
 target/riscv/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 4851890..f0d6d1d 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -391,7 +391,7 @@ static const TypeInfo riscv_cpu_type_info = {
 char *riscv_isa_string(RISCVCPU *cpu)
 {
     int i;
-    size_t maxlen = 5 + ctz32(cpu->env.misa);
+    size_t maxlen = 5 + __builtin_popcountll(cpu->env.misa);
     char *isa_string = g_new0(char, maxlen);
     snprintf(isa_string, maxlen, "rv%d", TARGET_LONG_BITS);
     for (i = 0; i < sizeof(riscv_exts); i++) {
-- 
2.7.0
