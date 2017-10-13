Received: from eggs.gnu.org ([2001:4830:134:3::10]:41595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1e32lS-0002PV-KG
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:24:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1e32lP-0006TT-HA
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:24:46 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:52285)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1e32lP-0006T3-BA
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:24:43 -0400
Received: by mail-wm0-x229.google.com with SMTP id k4so22853715wmc.1
	for <qemu-devel@nongnu.org>; Fri, 13 Oct 2017 09:24:43 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 13 Oct 2017 17:24:11 +0100
Message-Id: <20171013162438.32458-4-alex.bennee@linaro.org>
In-Reply-To: <20171013162438.32458-1-alex.bennee@linaro.org>
References: <20171013162438.32458-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 03/30] include/exec/helper-head.h: support
 f16 in helper calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: richard.henderson@linaro.org
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>

This allows us to explicitly pass float16 to helpers rather than
assuming uint32_t and dealing with the result. Of course they will be
passed in i32 sized registers by default.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/exec/helper-head.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/exec/helper-head.h b/include/exec/helper-head.h
index 1cfc43b9ff..fdb82151d3 100644
--- a/include/exec/helper-head.h
+++ b/include/exec/helper-head.h
@@ -30,6 +30,7 @@
 #define dh_alias_int i32
 #define dh_alias_i64 i64
 #define dh_alias_s64 i64
+#define dh_alias_f16 i32
 #define dh_alias_f32 i32
 #define dh_alias_f64 i64
 #define dh_alias_ptr ptr
@@ -42,6 +43,7 @@
 #define dh_ctype_int int
 #define dh_ctype_i64 uint64_t
 #define dh_ctype_s64 int64_t
+#define dh_ctype_f16 float16
 #define dh_ctype_f32 float32
 #define dh_ctype_f64 float64
 #define dh_ctype_ptr void *
@@ -98,6 +100,7 @@
 #define dh_is_signed_s32 1
 #define dh_is_signed_i64 0
 #define dh_is_signed_s64 1
+#define dh_is_signed_f16 0
 #define dh_is_signed_f32 0
 #define dh_is_signed_f64 0
 #define dh_is_signed_tl  0
-- 
2.14.1
