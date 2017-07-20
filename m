Received: from eggs.gnu.org ([2001:4830:134:3::10]:55643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dYD88-0003FG-Al
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 11:12:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dYD85-0004Lk-Tm
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 11:12:44 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:38154)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dYD85-0004LS-No
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 11:12:41 -0400
Received: by mail-wr0-x22d.google.com with SMTP id f21so15629930wrf.5
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 08:12:41 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 20 Jul 2017 16:04:19 +0100
Message-Id: <20170720150426.12393-17-alex.bennee@linaro.org>
In-Reply-To: <20170720150426.12393-1-alex.bennee@linaro.org>
References: <20170720150426.12393-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH for 2.11 16/23] include/exec/helper-head.h:
 support f16 in helper calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: rth@twiddle.net, qemu-arm@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

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
2.13.0
