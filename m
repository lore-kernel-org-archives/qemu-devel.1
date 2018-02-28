Received: from eggs.gnu.org ([2001:4830:134:3::10]:46071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1er4u0-0000fj-9p
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 11:48:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1er4tx-00071u-Me
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 11:48:24 -0500
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:46105)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1er4tx-00070k-Gv
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 11:48:21 -0500
Received: by mail-pf0-x243.google.com with SMTP id z10so1209847pfh.13
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 08:48:21 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 28 Feb 2018 08:48:13 -0800
Message-Id: <20180228164816.24110-2-richard.henderson@linaro.org>
In-Reply-To: <20180228164816.24110-1-richard.henderson@linaro.org>
References: <20180228164816.24110-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [RISU 1/3] Add aa64 sqrdml[as]h
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
 aarch64.risu | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/aarch64.risu b/aarch64.risu
index 02e9183..c1a29f6 100644
--- a/aarch64.risu
+++ b/aarch64.risu
@@ -2932,6 +2932,30 @@ FCVTZUsi A64_V sf:1 0011110 type:2 1 11 001 000000 rn:5 rd:5 \
 # UnallocatedEncoding: type >= 2
 FCVTZUsi_RES A64_V sf:1 0011110 1 type:1 1 11 001 000000 rn:5 rd:5
 
+#
+# AdvSIMD v8.1 extensions
+#
+
+@v8_1_simd
+
+# SQRDMLAH (vector, scalar)
+SQRDMLAHvs  A64_V81  01111110 size:2 0 rm:5 100001 rn:5 rd:5
+# SQRDMLAH (vector, vector)
+SQRDMLAHv   A64_V81  0 q:1 101110 size:2 0 rm:5 100001 rn:5 rd:5
+# SQRDMLAH (element, scalar)
+SQRDMLAHse  A64_V81  01111111 size:2 l:1 m:1 rm:4 1101 h:1 0 rn:5 rd:5
+# SQRDMLAH (element, vector)
+SQRDMLAHve  A64_V81  0 q:1 101111 size:2 l:1 m:1 rm:4 1101 h:1 0 rn:5 rd:5
+
+# SQRDMLSH (vector, scalar)
+SQRDMLSHvs  A64_V81  01111110 size:2 0 rm:5 100011 rn:5 rd:5
+# SQRDMLSH (vector, vector)
+SQRDMLSHv   A64_V81  0 q:1 101110 size:2 0 rm:5 100011 rn:5 rd:5
+# SQRDMLSH (element, scalar)
+SQRDMLSHse  A64_V81  01111111 size:2 l:1 m:1 rm:4 1111 h:1 0 rn:5 rd:5
+# SQRDMLSH (element, vector)
+SQRDMLSHve  A64_V81  0 q:1 101111 size:2 l:1 m:1 rm:4 1111 h:1 0 rn:5 rd:5
+
 @
 # End of:
 # Data processing - SIMD and floating point
-- 
2.14.3
