Received: from eggs.gnu.org ([2001:4830:134:3::10]:48131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1epFYB-0003gW-Tb
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:46:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1epFYA-0008AN-JK
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:46:19 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:42917)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1epFYA-00088b-C2
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:46:18 -0500
Received: by mail-wr0-x244.google.com with SMTP id k9so14539837wre.9
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 07:46:18 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 23 Feb 2018 15:46:08 +0000
Message-Id: <20180223154613.2096-4-alex.bennee@linaro.org>
In-Reply-To: <20180223154613.2096-1-alex.bennee@linaro.org>
References: <20180223154613.2096-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 3/8] aarch64.risu: add cryptographic
 extensions for v8.2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, richard.henderson@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 aarch64.risu | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/aarch64.risu b/aarch64.risu
index 838bded..06a9f3c 100644
--- a/aarch64.risu
+++ b/aarch64.risu
@@ -2937,3 +2937,35 @@ FCVTZUsi_RES A64_V sf:1 0011110 1 type:1 1 11 001 000000 rn:5 rd:5
 # End of:
 # Data processing - SIMD and floating point
 # Data processing - Scalar Floating-Point and Advanced SIMD
+
+# These are optional ARMv8.2 cryptographic extensions
+@v8.2,Cryptographic,CryptographicSHA
+
+# Cryptographic three-register SHA 512
+# 31       21 20  16 15 14 13 12 11    10 9  5 4  0
+# 11001110011   Rm    1  O  0 0   opcode   Rn   Rd
+
+SHA512H   A64_V 1100 1110 011 rm:5 1 0 00 00 rn:5 rd:5
+SHA512H2  A64_V 1100 1110 011 rm:5 1 0 00 01 rn:5 rd:5
+SHA512SUI A64_V 1100 1110 011 rm:5 1 0 00 10 rn:5 rd:5
+RAX1      A64_V 1100 1110 011 rm:5 1 0 00 11 rn:5 rd:5
+SM3PARTW1 A64_V 1100 1110 011 rm:5 1 1 00 00 rn:5 rd:5
+SM3PARTW2 A64_V 1100 1110 011 rm:5 1 1 00 01 rn:5 rd:5
+SM4       A64_V 1100 1110 011 rm:5 1 1 00 10 rn:5 rd:5
+
+# Cryptographic four-register
+# 31       23 22 21 20  16 15 14  10 9  5 4  0
+# 1100 1110 0  Op0    Rm    0   Ra    Rn   Rd
+
+EOR3      A64_V 1110 1110 0 00 rm:5 0 ra:5 rn:5 rd:5
+BCAX      A64_V 1110 1110 0 01 rm:5 0 ra:5 rn:5 rd:5
+SM3SS1    A64_V 1110 1110 0 10 rm:5 0 ra:5 rn:5 rd:5
+
+# Cryptographic two-register SHA 512
+# 31                    12 11  10 9  5 4  0
+# 1100 1110 1100 0000 1000   op    Rn   Rd
+
+SHA512SU0 A64_V 1100 1110 1100 0000 1000 00 rn:5 rd:5
+SM4E      A64_V 1100 1110 1100 0000 1000 01 rn:5 rd:5
+
+@
-- 
2.15.1
