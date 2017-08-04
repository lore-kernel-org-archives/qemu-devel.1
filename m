Received: from eggs.gnu.org ([2001:4830:134:3::10]:51517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ddW14-0003Wr-96
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 02:23:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ddW12-0005Q0-L4
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 02:23:22 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:37455)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1ddW12-0005Ol-Fb
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 02:23:20 -0400
Received: by mail-pg0-x243.google.com with SMTP id 83so904371pgb.4
	for <qemu-devel@nongnu.org>; Thu, 03 Aug 2017 23:23:20 -0700 (PDT)
Received: from bigtime.twiddle.net (97-126-108-236.tukw.qwest.net.
	[97.126.108.236]) by smtp.gmail.com with ESMTPSA id
	q199sm1335819pfq.135.2017.08.03.23.23.18 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 03 Aug 2017 23:23:18 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Thu,  3 Aug 2017 23:23:10 -0700
Message-Id: <20170804062314.12594-3-rth@twiddle.net>
In-Reply-To: <20170804062314.12594-1-rth@twiddle.net>
References: <20170804062314.12594-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH for-2.11 2/6] disas/i386: Fix disassembly of
 two-byte vex prefixes
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
2.13.3
