Received: from eggs.gnu.org ([2001:4830:134:3::10]:55002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dD06x-0005z7-8i
	for qemu-devel@nongnu.org; Mon, 22 May 2017 23:03:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dD06w-0003zY-FS
	for qemu-devel@nongnu.org; Mon, 22 May 2017 23:03:51 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:36083)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dD06w-0003zQ-CZ
	for qemu-devel@nongnu.org; Mon, 22 May 2017 23:03:50 -0400
Received: by mail-qt0-x242.google.com with SMTP id j13so20680053qta.3
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 20:03:50 -0700 (PDT)
Received: from bigtime.twiddle.net.com
	([2602:47:d954:1500:5e51:4fff:fe40:9c64])
	by smtp.gmail.com with ESMTPSA id
	s190sm12918805qkh.57.2017.05.22.20.03.48 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 22 May 2017 20:03:49 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Mon, 22 May 2017 20:03:08 -0700
Message-Id: <20170523030312.6360-28-rth@twiddle.net>
In-Reply-To: <20170523030312.6360-1-rth@twiddle.net>
References: <20170523030312.6360-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 27/31] target/s390x: Use unwind data for
 helper_tprot
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
 target/s390x/mem_helper.c | 1 -
 target/s390x/translate.c  | 1 -
 2 files changed, 2 deletions(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index a874f8a..7f22bf0 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -943,7 +943,6 @@ uint32_t HELPER(testblock)(CPUS390XState *env, uint64_t real_addr)
 uint32_t HELPER(tprot)(uint64_t a1, uint64_t a2)
 {
     /* XXX implement */
-
     return 0;
 }
 
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 694e099..282fa27 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -4054,7 +4054,6 @@ static ExitStatus op_testblock(DisasContext *s, DisasOps *o)
 
 static ExitStatus op_tprot(DisasContext *s, DisasOps *o)
 {
-    potential_page_fault(s);
     gen_helper_tprot(cc_op, o->addr1, o->in2);
     set_cc_static(s);
     return NO_EXIT;
-- 
2.9.4
