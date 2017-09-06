Received: from eggs.gnu.org ([2001:4830:134:3::10]:39960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dpbeN-0005Rz-2B
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:49:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dpbeK-0000FP-Ft
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:49:55 -0400
Received: from mail-pg0-x22b.google.com ([2607:f8b0:400e:c05::22b]:35783)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dpbeK-0000EN-9n
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:49:52 -0400
Received: by mail-pg0-x22b.google.com with SMTP id 188so12369382pgb.2
	for <qemu-devel@nongnu.org>; Wed, 06 Sep 2017 07:49:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  6 Sep 2017 07:49:32 -0700
Message-Id: <20170906144940.30880-7-richard.henderson@linaro.org>
In-Reply-To: <20170906144940.30880-1-richard.henderson@linaro.org>
References: <20170906144940.30880-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 06/14] disas/i386: Add disassembly of rorx
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Richard Henderson <rth@twiddle.net>

From: Richard Henderson <rth@twiddle.net>

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 disas/i386.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/disas/i386.c b/disas/i386.c
index 7eaa378a10..a557e678ec 100644
--- a/disas/i386.c
+++ b/disas/i386.c
@@ -684,6 +684,7 @@ fetch_data(struct disassemble_info *info, bfd_byte *addr)
 #define PREGRP106 NULL, { { NULL, USE_PREFIX_USER_TABLE }, { NULL, 106 } }
 #define PREGRP107 NULL, { { NULL, USE_PREFIX_USER_TABLE }, { NULL, 107 } }
 #define PREGRP108 NULL, { { NULL, USE_PREFIX_USER_TABLE }, { NULL, 108 } }
+#define PREGRP109 NULL, { { NULL, USE_PREFIX_USER_TABLE }, { NULL, 109 } }
 
 #define X86_64_0  NULL, { { NULL, X86_64_SPECIAL }, { NULL, 0 } }
 #define X86_64_1  NULL, { { NULL, X86_64_SPECIAL }, { NULL, 1 } }
@@ -1557,7 +1558,7 @@ static const unsigned char threebyte_0x3a_uses_REPNZ_prefix[256] = {
   /* c0 */ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, /* cf */
   /* d0 */ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, /* df */
   /* e0 */ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, /* ef */
-  /* f0 */ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, /* ff */
+  /* f0 */ 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, /* ff */
   /*       -------------------------------        */
   /*       0 1 2 3 4 5 6 7 8 9 a b c d e f        */
 };
@@ -2817,6 +2818,14 @@ static const struct dis386 prefix_user_table[][4] = {
     { "(bad)",  { XX } },
     { "pdep",   { Gv, Bv, Ev } },
   },
+
+  /* PREGRP109 */
+  {
+    { "(bad)",  { XX } },
+    { "(bad)",  { XX } },
+    { "(bad)",  { XX } },
+    { "rorx",   { Gv, Ev, Ib } },
+  },
 };
 
 static const struct dis386 x86_64_table[][2] = {
@@ -3403,7 +3412,7 @@ static const struct dis386 three_byte_table[][256] = {
     { "(bad)", { XX } },
     { "(bad)", { XX } },
     /* f0 */
-    { "(bad)", { XX } },
+    { PREGRP109 },
     { "(bad)", { XX } },
     { "(bad)", { XX } },
     { "(bad)", { XX } },
-- 
2.13.5
