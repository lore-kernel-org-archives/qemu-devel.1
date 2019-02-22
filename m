Received: from eggs.gnu.org ([209.51.188.92]:38918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gxHra-0003HB-MU
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 15:56:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gxHgx-0006vP-M7
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 15:45:08 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:43109)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gxHgx-0006u8-19
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 15:45:07 -0500
Received: by mail-wr1-x443.google.com with SMTP id d17so3725638wre.10
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 12:45:06 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 22 Feb 2019 20:44:59 +0000
Message-Id: <20190222204500.24434-6-alex.bennee@linaro.org>
In-Reply-To: <20190222204500.24434-1-alex.bennee@linaro.org>
References: <20190222204500.24434-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 5/6] tests/fp: enable f128_to_ui[32/64]
 tests in float-to-uint
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

We've just added f128_to_ui32 and we missed out the f128_to_ui64 tests
last time.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/Makefile.include | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 3741f8f6dd..060f765b0e 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -909,8 +909,7 @@ test-softfloat = $(call quiet-command, \
 
 # Conversion Routines:
 # FIXME: i32_to_extF80 (broken), i64_to_extF80 (broken)
-#        ui32_to_f128 (not implemented), f128_to_ui32 (not implemented)
-#        extF80_roundToInt (broken)
+#        ui32_to_f128 (not implemented), extF80_roundToInt (broken)
 #
 check-softfloat-conv: $(FP_TEST_BIN)
 	$(call test-softfloat, \
@@ -939,9 +938,11 @@ check-softfloat-conv: $(FP_TEST_BIN)
 		f16_to_ui32 f16_to_ui32_r_minMag \
 		f32_to_ui32 f32_to_ui32_r_minMag \
 		f64_to_ui32 f64_to_ui32_r_minMag \
+		f128_to_ui32 f128_to_ui32_r_minMag \
 		f16_to_ui64 f16_to_ui64_r_minMag \
 		f32_to_ui64 f32_to_ui64_r_minMag \
-		f64_to_ui64 f64_to_ui64_r_minMag, \
+		f64_to_ui64 f64_to_ui64_r_minMag \
+		f128_to_ui64 f128_to_ui64_r_minMag, \
 		float-to-uint)
 	$(call test-softfloat, \
 		f16_roundToInt f32_roundToInt \
-- 
2.20.1
