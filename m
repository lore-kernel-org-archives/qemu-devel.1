Received: from eggs.gnu.org ([2001:4830:134:3::10]:51556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ddW15-0003XB-Gm
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 02:23:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ddW14-0005SN-KV
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 02:23:23 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:35999)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1ddW14-0005Rd-F5
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 02:23:22 -0400
Received: by mail-pg0-x243.google.com with SMTP id y129so905929pgy.3
	for <qemu-devel@nongnu.org>; Thu, 03 Aug 2017 23:23:22 -0700 (PDT)
Received: from bigtime.twiddle.net (97-126-108-236.tukw.qwest.net.
	[97.126.108.236]) by smtp.gmail.com with ESMTPSA id
	q199sm1335819pfq.135.2017.08.03.23.23.20 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 03 Aug 2017 23:23:20 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Thu,  3 Aug 2017 23:23:12 -0700
Message-Id: <20170804062314.12594-5-rth@twiddle.net>
In-Reply-To: <20170804062314.12594-1-rth@twiddle.net>
References: <20170804062314.12594-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH for-2.11 4/6] disas/i386: Add disassembly of
 rorx
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

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
2.13.3
