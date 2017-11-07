Received: from eggs.gnu.org ([2001:4830:134:3::10]:34857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eC5SO-0005uf-Rp
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 10:06:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eC5SH-00007o-Vb
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 10:06:28 -0500
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:47066)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eC5SH-000078-P8
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 10:06:21 -0500
Received: by mail-wm0-x233.google.com with SMTP id r68so4413137wmr.1
	for <qemu-devel@nongnu.org>; Tue, 07 Nov 2017 07:06:21 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue,  7 Nov 2017 15:05:56 +0000
Message-Id: <20171107150558.22131-9-alex.bennee@linaro.org>
In-Reply-To: <20171107150558.22131-1-alex.bennee@linaro.org>
References: <20171107150558.22131-1-alex.bennee@linaro.org>
Subject: [Qemu-devel] [RISU PATCH 08/10] aarch64.risu: initial SVE
 instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: Dave.Martin@arm.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

---
 aarch64.risu | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/aarch64.risu b/aarch64.risu
index 838bded..bfa4ff8 100644
--- a/aarch64.risu
+++ b/aarch64.risu
@@ -2937,3 +2937,27 @@ FCVTZUsi_RES A64_V sf:1 0011110 1 type:1 1 11 001 000000 rn:5 rd:5
 # End of:
 # Data processing - SIMD and floating point
 # Data processing - Scalar Floating-Point and Advanced SIMD
+
+# SVE Instructions
+# Top-level Encodings
+#
+# 31            24 | 23 22 | 21      17 | 16 | 15    10 | 9                 0
+#  y y y y y y y m |  -  - |  m m m m m |  - |          | - - - - - - - - - -
+#
+@SVE
+
+# SVE Integer Arithmetic - Binary Predicated Group
+# 31            24 | 23  22 | 21 | 20  19 | 18 16 | 15  13 | 12           0
+#  0 0 0 0 0 1 0 0 |  size  |  0 |   op   |  ---  |  0 0 0 | ------------- |
+
+SVE_INTA_PRED_UNALL A64_V 00000100 ig:2 010 001 000 ignore2:13
+
+# - SVE integer add/subtract vectors (predicated)
+# 31            24 | 23 22 | 21  19 | 18 16 | 15  13 | 12  10 | 9  5 | 4  0 |
+#  0 0 0 0 0 1 0 0 |  size |  0 0 0 |  opc  |  0 0 0 |   Pg   |  Zm  |  Zn  |
+# opc 010/1xx are UNALLOCATED
+
+SVE_INT_ADDSUB_PRED A64_V 00000100 sz:2 000 opc:3 000 pg:3 zm:5 zn:5
+
+@
+# End of SVE instructions
-- 
2.14.2
