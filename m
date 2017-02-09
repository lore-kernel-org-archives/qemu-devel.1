Received: from eggs.gnu.org ([2001:4830:134:3::10]:38161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cbgiu-0002OK-P3
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 23:52:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cbgit-0007tI-0V
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 23:52:48 -0500
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:32932)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cbgis-0007t6-QC
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 23:52:46 -0500
Received: by mail-pf0-x244.google.com with SMTP id e4so12917311pfg.0
	for <qemu-devel@nongnu.org>; Wed, 08 Feb 2017 20:52:46 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Wed,  8 Feb 2017 20:51:46 -0800
Message-Id: <20170209045154.16868-15-rth@twiddle.net>
In-Reply-To: <20170209045154.16868-1-rth@twiddle.net>
References: <20170209045154.16868-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 14/22] target/openrisc: Set flags on helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: shorne@gmail.com

Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/openrisc/helper.h | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/target/openrisc/helper.h b/target/openrisc/helper.h
index f4d97a2..78a123d 100644
--- a/target/openrisc/helper.h
+++ b/target/openrisc/helper.h
@@ -18,26 +18,26 @@
  */
 
 /* exception */
-DEF_HELPER_FLAGS_2(exception, 0, void, env, i32)
+DEF_HELPER_FLAGS_2(exception, TCG_CALL_NO_WG, void, env, i32)
 DEF_HELPER_FLAGS_1(ove_cy, TCG_CALL_NO_WG, void, env)
 DEF_HELPER_FLAGS_1(ove_ov, TCG_CALL_NO_WG, void, env)
 DEF_HELPER_FLAGS_1(ove_cyov, TCG_CALL_NO_WG, void, env)
 
 /* float */
-DEF_HELPER_FLAGS_2(itofd, 0, i64, env, i64)
-DEF_HELPER_FLAGS_2(itofs, 0, i32, env, i32)
-DEF_HELPER_FLAGS_2(ftoid, 0, i64, env, i64)
-DEF_HELPER_FLAGS_2(ftois, 0, i32, env, i32)
+DEF_HELPER_FLAGS_2(itofd, TCG_CALL_NO_WG, i64, env, i64)
+DEF_HELPER_FLAGS_2(itofs, TCG_CALL_NO_WG, i32, env, i32)
+DEF_HELPER_FLAGS_2(ftoid, TCG_CALL_NO_WG, i64, env, i64)
+DEF_HELPER_FLAGS_2(ftois, TCG_CALL_NO_WG, i32, env, i32)
 
 #define FOP_MADD(op)                                             \
-DEF_HELPER_FLAGS_3(float_ ## op ## _s, 0, i32, env, i32, i32)    \
-DEF_HELPER_FLAGS_3(float_ ## op ## _d, 0, i64, env, i64, i64)
+DEF_HELPER_FLAGS_3(float_ ## op ## _s, TCG_CALL_NO_WG, i32, env, i32, i32) \
+DEF_HELPER_FLAGS_3(float_ ## op ## _d, TCG_CALL_NO_WG, i64, env, i64, i64)
 FOP_MADD(muladd)
 #undef FOP_MADD
 
 #define FOP_CALC(op)                                            \
-DEF_HELPER_FLAGS_3(float_ ## op ## _s, 0, i32, env, i32, i32)    \
-DEF_HELPER_FLAGS_3(float_ ## op ## _d, 0, i64, env, i64, i64)
+DEF_HELPER_FLAGS_3(float_ ## op ## _s, TCG_CALL_NO_WG, i32, env, i32, i32) \
+DEF_HELPER_FLAGS_3(float_ ## op ## _d, TCG_CALL_NO_WG, i64, env, i64, i64)
 FOP_CALC(add)
 FOP_CALC(sub)
 FOP_CALC(mul)
@@ -46,8 +46,8 @@ FOP_CALC(rem)
 #undef FOP_CALC
 
 #define FOP_CMP(op)                                              \
-DEF_HELPER_FLAGS_3(float_ ## op ## _s, 0, i32, env, i32, i32)    \
-DEF_HELPER_FLAGS_3(float_ ## op ## _d, 0, i64, env, i64, i64)
+DEF_HELPER_FLAGS_3(float_ ## op ## _s, TCG_CALL_NO_WG, i32, env, i32, i32) \
+DEF_HELPER_FLAGS_3(float_ ## op ## _d, TCG_CALL_NO_WG, i64, env, i64, i64)
 FOP_CMP(eq)
 FOP_CMP(lt)
 FOP_CMP(le)
@@ -61,4 +61,4 @@ DEF_HELPER_FLAGS_1(rfe, 0, void, env)
 
 /* sys */
 DEF_HELPER_FLAGS_4(mtspr, 0, void, env, tl, tl, tl)
-DEF_HELPER_FLAGS_4(mfspr, 0, tl, env, tl, tl, tl)
+DEF_HELPER_FLAGS_4(mfspr, TCG_CALL_NO_WG, tl, env, tl, tl, tl)
-- 
2.9.3
