Received: from eggs.gnu.org ([2001:4830:134:3::10]:45517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dDbsW-00025N-2a
	for qemu-devel@nongnu.org; Wed, 24 May 2017 15:23:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dDbsV-0001iM-9y
	for qemu-devel@nongnu.org; Wed, 24 May 2017 15:23:28 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:33854)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dDbsV-0001hf-5q
	for qemu-devel@nongnu.org; Wed, 24 May 2017 15:23:27 -0400
Received: by mail-qk0-x242.google.com with SMTP id u75so27646236qka.1
	for <qemu-devel@nongnu.org>; Wed, 24 May 2017 12:23:27 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Wed, 24 May 2017 12:22:40 -0700
Message-Id: <20170524192246.15905-28-rth@twiddle.net>
In-Reply-To: <20170524192246.15905-1-rth@twiddle.net>
References: <20170524192246.15905-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v2 27/33] target/s390x: Use unwind data for
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
Cc: thuth@redhat.com, aurelien@aurel32.net

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/mem_helper.c | 1 -
 target/s390x/translate.c  | 1 -
 2 files changed, 2 deletions(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 7df2e53..a8c85c9 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -970,7 +970,6 @@ uint32_t HELPER(testblock)(CPUS390XState *env, uint64_t real_addr)
 uint32_t HELPER(tprot)(uint64_t a1, uint64_t a2)
 {
     /* XXX implement */
-
     return 0;
 }
 
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index cd017ce..7b9c111 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -4049,7 +4049,6 @@ static ExitStatus op_testblock(DisasContext *s, DisasOps *o)
 
 static ExitStatus op_tprot(DisasContext *s, DisasOps *o)
 {
-    potential_page_fault(s);
     gen_helper_tprot(cc_op, o->addr1, o->in2);
     set_cc_static(s);
     return NO_EXIT;
-- 
2.9.4
