Received: from eggs.gnu.org ([2001:4830:134:3::10]:37431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1diP9R-00042z-VJ
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 14:04:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1diP9P-0005IR-Ki
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 14:04:13 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:33116)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1diP9P-0005Hz-EV
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 14:04:11 -0400
Received: by mail-wr0-x233.google.com with SMTP id b65so50612553wrd.0
	for <qemu-devel@nongnu.org>; Thu, 17 Aug 2017 11:04:11 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 17 Aug 2017 19:03:59 +0100
Message-Id: <20170817180404.29334-5-alex.bennee@linaro.org>
In-Reply-To: <20170817180404.29334-1-alex.bennee@linaro.org>
References: <20170817180404.29334-1-alex.bennee@linaro.org>
Subject: [Qemu-devel] [RFC PATCH 4/9] helper-head: add support for vec type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: rth@twiddle.net, cota@braap.org, batuzovk@ispras.ru
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

---
 include/exec/helper-head.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/exec/helper-head.h b/include/exec/helper-head.h
index 1cfc43b9ff..3fb4c3fc39 100644
--- a/include/exec/helper-head.h
+++ b/include/exec/helper-head.h
@@ -23,6 +23,7 @@
 #define GET_TCGV_i32 GET_TCGV_I32
 #define GET_TCGV_i64 GET_TCGV_I64
 #define GET_TCGV_ptr GET_TCGV_PTR
+#define GET_TCGV_vec GET_TCGV_VEC
 
 /* Some types that make sense in C, but not for TCG.  */
 #define dh_alias_i32 i32
@@ -33,6 +34,7 @@
 #define dh_alias_f32 i32
 #define dh_alias_f64 i64
 #define dh_alias_ptr ptr
+#define dh_alias_vec vec
 #define dh_alias_void void
 #define dh_alias_noreturn noreturn
 #define dh_alias(t) glue(dh_alias_, t)
@@ -45,6 +47,7 @@
 #define dh_ctype_f32 float32
 #define dh_ctype_f64 float64
 #define dh_ctype_ptr void *
+#define dh_ctype_vec void *
 #define dh_ctype_void void
 #define dh_ctype_noreturn void QEMU_NORETURN
 #define dh_ctype(t) dh_ctype_##t
@@ -90,6 +93,7 @@
 #define dh_is_64bit_i32 0
 #define dh_is_64bit_i64 1
 #define dh_is_64bit_ptr (sizeof(void *) == 8)
+#define dh_is_64bit_vec (sizeof(void *) == 8)
 #define dh_is_64bit(t) glue(dh_is_64bit_, dh_alias(t))
 
 #define dh_is_signed_void 0
@@ -106,6 +110,7 @@
    extension instructions that may be required, e.g. ia64's addp4.  But
    for now we don't support any 64-bit targets with 32-bit pointers.  */
 #define dh_is_signed_ptr 0
+#define dh_is_signed_vec dh_is_signed_ptr
 #define dh_is_signed_env dh_is_signed_ptr
 #define dh_is_signed(t) dh_is_signed_##t
 
-- 
2.13.0
