Received: from eggs.gnu.org ([2001:4830:134:3::10]:44302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1epFOt-0002j5-KD
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:36:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1epFOq-0006sA-03
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:36:43 -0500
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:37265)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1epFOp-0006p7-PY
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:36:39 -0500
Received: by mail-wr0-x243.google.com with SMTP id z12so14529962wrg.4
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 07:36:39 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 23 Feb 2018 15:36:06 +0000
Message-Id: <20180223153636.29809-2-alex.bennee@linaro.org>
In-Reply-To: <20180223153636.29809-1-alex.bennee@linaro.org>
References: <20180223153636.29809-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 01/31] include/exec/helper-head.h: support
 f16 in helper calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>

This allows us to explicitly pass float16 to helpers rather than
assuming uint32_t and dealing with the result. Of course they will be
passed in i32 sized registers by default.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/helper-head.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/exec/helper-head.h b/include/exec/helper-head.h
index e1fd08f2ba..15b6a68de3 100644
--- a/include/exec/helper-head.h
+++ b/include/exec/helper-head.h
@@ -26,6 +26,7 @@
 #define dh_alias_int i32
 #define dh_alias_i64 i64
 #define dh_alias_s64 i64
+#define dh_alias_f16 i32
 #define dh_alias_f32 i32
 #define dh_alias_f64 i64
 #define dh_alias_ptr ptr
@@ -38,6 +39,7 @@
 #define dh_ctype_int int
 #define dh_ctype_i64 uint64_t
 #define dh_ctype_s64 int64_t
+#define dh_ctype_f16 float16
 #define dh_ctype_f32 float32
 #define dh_ctype_f64 float64
 #define dh_ctype_ptr void *
@@ -94,6 +96,7 @@
 #define dh_is_signed_s32 1
 #define dh_is_signed_i64 0
 #define dh_is_signed_s64 1
+#define dh_is_signed_f16 0
 #define dh_is_signed_f32 0
 #define dh_is_signed_f64 0
 #define dh_is_signed_tl  0
-- 
2.15.1
