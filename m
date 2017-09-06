Received: from eggs.gnu.org ([2001:4830:134:3::10]:39923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dpbeI-0005O2-Mg
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:49:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dpbeH-0000DW-T4
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:49:50 -0400
Received: from mail-pg0-x22e.google.com ([2607:f8b0:400e:c05::22e]:36409)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dpbeH-0000DL-NK
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:49:49 -0400
Received: by mail-pg0-x22e.google.com with SMTP id m9so15675678pgd.3
	for <qemu-devel@nongnu.org>; Wed, 06 Sep 2017 07:49:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  6 Sep 2017 07:49:30 -0700
Message-Id: <20170906144940.30880-5-richard.henderson@linaro.org>
In-Reply-To: <20170906144940.30880-1-richard.henderson@linaro.org>
References: <20170906144940.30880-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 04/14] disas/i386: Fix disassembly of two-byte
 vex prefixes
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
 disas/i386.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/disas/i386.c b/disas/i386.c
index f1e376ca4a..7a238b203b 100644
--- a/disas/i386.c
+++ b/disas/i386.c
@@ -3559,6 +3559,7 @@ ckvexprefix (void)
     } else {
         /* Two byte VEX prefix.  */
         newrex |= (vex2 & 0x80 ? 0 : REX_R);
+        newpfx |= PREFIX_VEX_0F;
         codep += 2;
     }
 
-- 
2.13.5
