Received: from eggs.gnu.org ([2001:4830:134:3::10]:46130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1er4u1-0000g8-Kx
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 11:48:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1er4u0-00075a-72
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 11:48:25 -0500
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:36518)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1er4u0-00074c-0C
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 11:48:24 -0500
Received: by mail-pg0-x244.google.com with SMTP id i14so1155511pgv.3
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 08:48:23 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 28 Feb 2018 08:48:15 -0800
Message-Id: <20180228164816.24110-4-richard.henderson@linaro.org>
In-Reply-To: <20180228164816.24110-1-richard.henderson@linaro.org>
References: <20180228164816.24110-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [RISU 2/3] Add aa64 fcadd + fcmla
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 aarch64.risu | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/aarch64.risu b/aarch64.risu
index c1a29f6..a5c92e9 100644
--- a/aarch64.risu
+++ b/aarch64.risu
@@ -2956,6 +2956,19 @@ SQRDMLSHse  A64_V81  01111111 size:2 l:1 m:1 rm:4 1111 h:1 0 rn:5 rd:5
 # SQRDMLSH (element, vector)
 SQRDMLSHve  A64_V81  0 q:1 101111 size:2 l:1 m:1 rm:4 1111 h:1 0 rn:5 rd:5
 
+#
+# AdvSIMD v8.3 extensions
+#
+@v8_3_compnum
+
+# FCADD (three registers of the same type)
+FCADD      A64_V83  0 q:1 101110 size:2 0 rm:5 111 rot:1 01 rn:5 rd:5
+
+# FCMLA (three registers of the same type)
+FCMLA      A64_V83  0 q:1 101110 size:2 0 rm:5 110 rot:2 1 rn:5 rd:5
+# FCMLA (vector x indexed element)
+FCMLA_idx  A64_V83  0 q:1 101111 size:2 l:1 m:1 rm:4 0 rot:2 1 h:1 0 rn:5 rd:5
+
 @
 # End of:
 # Data processing - SIMD and floating point
-- 
2.14.3
