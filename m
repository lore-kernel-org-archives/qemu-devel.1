Received: from eggs.gnu.org ([2001:4830:134:3::10]:35776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dSP7k-0008Fj-V1
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 10:48:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dSP7j-00019x-Ud
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 10:48:21 -0400
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:38774)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dSP7j-000193-O9
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 10:48:19 -0400
Received: by mail-wm0-x230.google.com with SMTP id f67so87107186wmh.1
	for <qemu-devel@nongnu.org>; Tue, 04 Jul 2017 07:48:19 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue,  4 Jul 2017 15:48:56 +0100
Message-Id: <20170704144859.17644-9-alex.bennee@linaro.org>
In-Reply-To: <20170704144859.17644-1-alex.bennee@linaro.org>
References: <20170704144859.17644-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RISU PATCH 08/11] aarch64.risu: document naming
 conventions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 aarch64.risu | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/aarch64.risu b/aarch64.risu
index 2f3341c..bfca45f 100644
--- a/aarch64.risu
+++ b/aarch64.risu
@@ -7,6 +7,7 @@
 #
 # Contributors:
 #     Claudio Fontana - initial implementation
+#     Alex Bennée - a number of additions including v8.2 FP16
 #     based on arm.risu by Peter Maydell
 ###############################################################################
 
@@ -19,6 +20,15 @@
 # XXX NIY: SP-related instructions
 # XXX NIY: floating point and SIMD specific insns
 
+# Instruction suffixes to identify variants
+#   m - memory (loads/stores)
+#   s - scalar
+#   v - vector
+#   z - zero (e.g. compare to zero)
+#   f - fixed point
+#
+# _FP16 for ARMv8.2 half-precision extensions
+
 # - - - - 1 - 0 - - - - - - - - - - - - - - - Loads and stores
 # C3.3 Loads and stores
 
-- 
2.13.0
