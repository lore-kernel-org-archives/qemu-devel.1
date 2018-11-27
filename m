Received: from eggs.gnu.org ([2001:4830:134:3::10]:44051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefan@weilnetz.de>) id 1gRcJL-00046n-3G
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 07:17:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefan@weilnetz.de>) id 1gRcJK-0008PG-BR
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 07:17:51 -0500
Received: from mail.weilnetz.de ([37.120.169.71]:37144
	helo=v2201612906741603.powersrv.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefan@weilnetz.de>) id 1gRcJK-0008Ol-5U
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 07:17:50 -0500
From: Stefan Weil <sw@weilnetz.de>
Date: Tue, 27 Nov 2018 13:17:24 +0100
Message-Id: <20181127121724.19755-3-sw@weilnetz.de>
In-Reply-To: <20181127121724.19755-1-sw@weilnetz.de>
References: <20181127121724.19755-1-sw@weilnetz.de>
Subject: [Qemu-devel] [PATCH for-3.1 2/2] disas/nanomips: Fix format strings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Markovic <amarkovic@wavecomp.com>, Stefan Markovic <smarkovic@wavecomp.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Stefan Weil <sw@weilnetz.de>

Signed-off-by: Stefan Weil <sw@weilnetz.de>
---
 disas/nanomips.cpp | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/disas/nanomips.cpp b/disas/nanomips.cpp
index 4c3cfceaba..a3f69348b3 100644
--- a/disas/nanomips.cpp
+++ b/disas/nanomips.cpp
@@ -284,7 +284,8 @@ uint64_t NMD::renumber_registers(uint64_t index, uint64_t *register_list,
     }
 
     throw std::runtime_error(img::format(
-                   "Invalid register mapping index %d, size of list = %d",
+                   "Invalid register mapping index %" PRIu64
+                   ", size of list = %zu",
                    index, register_list_size));
 }
 
@@ -501,7 +502,8 @@ std::string NMD::GPR(uint64_t reg)
         return gpr_reg[reg];
     }
 
-    throw std::runtime_error(img::format("Invalid GPR register index %d", reg));
+    throw std::runtime_error(img::format("Invalid GPR register index %" PRIu64,
+                                         reg));
 }
 
 
@@ -518,7 +520,8 @@ std::string NMD::FPR(uint64_t reg)
         return fpr_reg[reg];
     }
 
-    throw std::runtime_error(img::format("Invalid FPR register index %d", reg));
+    throw std::runtime_error(img::format("Invalid FPR register index %" PRIu64,
+                                         reg));
 }
 
 
@@ -532,26 +535,27 @@ std::string NMD::AC(uint64_t reg)
         return ac_reg[reg];
     }
 
-    throw std::runtime_error(img::format("Invalid AC register index %d", reg));
+    throw std::runtime_error(img::format("Invalid AC register index %" PRIu64,
+                                         reg));
 }
 
 
 std::string NMD::IMMEDIATE(uint64_t value)
 {
-    return img::format("0x%x", value);
+    return img::format("0x%" PRIx64, value);
 }
 
 
 std::string NMD::IMMEDIATE(int64_t value)
 {
-    return img::format("%d", value);
+    return img::format("%" PRId64, value);
 }
 
 
 std::string NMD::CPR(uint64_t reg)
 {
     /* needs more work */
-    return img::format("CP%d", reg);
+    return img::format("CP%" PRIu64, reg);
 }
 
 
-- 
2.11.0
