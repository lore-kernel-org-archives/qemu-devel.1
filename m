Received: from eggs.gnu.org ([2001:4830:134:3::10]:45485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cdO8o-0004xC-01
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 16:26:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cdO8l-0001Vy-6j
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 16:26:34 -0500
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:35037)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cdO8l-0001Vh-36
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 16:26:31 -0500
Received: by mail-qt0-x243.google.com with SMTP id s58so15047869qtc.2
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 13:26:31 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 14 Feb 2017 08:25:27 +1100
Message-Id: <20170213212536.31871-16-rth@twiddle.net>
In-Reply-To: <20170213212536.31871-1-rth@twiddle.net>
References: <20170213212536.31871-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 15/24] target/openrisc: Set flags on helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
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
