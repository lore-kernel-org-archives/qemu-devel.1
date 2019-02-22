Received: from eggs.gnu.org ([209.51.188.92]:38918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gxHrf-0003HB-Vu
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 15:56:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gxHgv-0006sd-1x
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 15:45:05 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:35841)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gxHgu-0006rN-Po
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 15:45:04 -0500
Received: by mail-wm1-x341.google.com with SMTP id j125so3123907wmj.1
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 12:45:04 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 22 Feb 2019 20:44:58 +0000
Message-Id: <20190222204500.24434-5-alex.bennee@linaro.org>
In-Reply-To: <20190222204500.24434-1-alex.bennee@linaro.org>
References: <20190222204500.24434-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 4/6] tests/fp: add wrapping for f128_to_ui32
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

Needed to test: softfloat: add float128_is_{normal,denormal}

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/fp/fp-test.c  | 3 ++-
 tests/fp/wrap.inc.c | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/fp/fp-test.c b/tests/fp/fp-test.c
index 2a35ef601d..4114f346a9 100644
--- a/tests/fp/fp-test.c
+++ b/tests/fp/fp-test.c
@@ -622,7 +622,8 @@ static void do_testfloat(int op, int rmode, bool exact)
         test_ab_extF80_z_bool(true_ab_extF80M_z_bool, subj_ab_extF80M_z_bool);
         break;
     case F128_TO_UI32:
-        not_implemented();
+        test_a_f128_z_ui32_rx(slow_f128M_to_ui32, qemu_f128M_to_ui32, rmode,
+                              exact);
         break;
     case F128_TO_UI64:
         test_a_f128_z_ui64_rx(slow_f128M_to_ui64, qemu_f128M_to_ui64, rmode,
diff --git a/tests/fp/wrap.inc.c b/tests/fp/wrap.inc.c
index d3bf600cd0..0cbd20013e 100644
--- a/tests/fp/wrap.inc.c
+++ b/tests/fp/wrap.inc.c
@@ -367,6 +367,7 @@ WRAP_80_TO_INT_MINMAG(qemu_extF80M_to_i64_r_minMag,
 WRAP_128_TO_INT(qemu_f128M_to_i32, float128_to_int32, int_fast32_t)
 WRAP_128_TO_INT(qemu_f128M_to_i64, float128_to_int64, int_fast64_t)
 
+WRAP_128_TO_INT(qemu_f128M_to_ui32, float128_to_uint32, uint_fast32_t)
 WRAP_128_TO_INT(qemu_f128M_to_ui64, float128_to_uint64, uint_fast64_t)
 #undef WRAP_128_TO_INT
 
-- 
2.20.1
