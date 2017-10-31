Received: from eggs.gnu.org ([2001:4830:134:3::10]:59323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1e9XwY-0000ah-UF
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 10:55:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1e9XwV-00071O-5N
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 10:55:07 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:45820)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1e9XwU-00070v-Vm
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 10:55:03 -0400
Received: by mail-wm0-x242.google.com with SMTP id y80so16283781wmd.0
	for <qemu-devel@nongnu.org>; Tue, 31 Oct 2017 07:55:02 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 31 Oct 2017 14:54:38 +0000
Message-Id: <20171031145444.13766-2-alex.bennee@linaro.org>
In-Reply-To: <20171031145444.13766-1-alex.bennee@linaro.org>
References: <20171031145444.13766-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RISU PATCH 1/7] aarch64.risu: document naming
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
 aarch64.risu | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/aarch64.risu b/aarch64.risu
index 2f3341c..5e7ec59 100644
--- a/aarch64.risu
+++ b/aarch64.risu
@@ -19,6 +19,14 @@
 # XXX NIY: SP-related instructions
 # XXX NIY: floating point and SIMD specific insns
 
+# Instruction suffixes to identify variants
+#   m - memory (loads/stores)
+#   s - scalar
+#   v - vector
+#   z - zero (e.g. compare to zero)
+#   f - fixed point
+#
+
 # - - - - 1 - 0 - - - - - - - - - - - - - - - Loads and stores
 # C3.3 Loads and stores
 
-- 
2.14.2
