Received: from eggs.gnu.org ([2001:4830:134:3::10]:49739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dsYz6-0000Rd-5H
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 14:35:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dsYz5-0000at-6R
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 14:35:32 -0400
Received: from mail-pg0-x22f.google.com ([2607:f8b0:400e:c05::22f]:55977)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dsYz5-0000a7-0k
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 14:35:31 -0400
Received: by mail-pg0-x22f.google.com with SMTP id b11so108961pgn.12
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 11:35:30 -0700 (PDT)
Received: from bigtime.twiddle.net (97-126-103-167.tukw.qwest.net.
	[97.126.103.167]) by smtp.gmail.com with ESMTPSA id
	l85sm32473848pfb.176.2017.09.14.11.35.28 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 14 Sep 2017 11:35:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 14 Sep 2017 11:35:14 -0700
Message-Id: <20170914183516.19537-9-richard.henderson@linaro.org>
In-Reply-To: <20170914183516.19537-1-richard.henderson@linaro.org>
References: <20170914183516.19537-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 08/10] target/s390x: Support Capstone in
 disas_set_info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 74b3e4fd0d..a4f7ff3da8 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -42,6 +42,7 @@
 #include "sysemu/sysemu.h"
 #include "hw/s390x/sclp.h"
 #endif
+#include "disas/capstone.h"
 
 #define CR0_RESET       0xE0UL
 #define CR14_RESET      0xC2000000UL;
@@ -172,6 +173,7 @@ static void s390_cpu_disas_set_info(CPUState *cpu, disassemble_info *info)
 {
     info->mach = bfd_mach_s390_64;
     info->print_insn = print_insn_s390;
+    info->cap_arch = CS_ARCH_SYSZ;
 }
 
 static void s390_cpu_realizefn(DeviceState *dev, Error **errp)
-- 
2.13.5
