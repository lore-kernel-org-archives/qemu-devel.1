Received: from eggs.gnu.org ([2001:4830:134:3::10]:40364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gSoMt-0007ix-1b
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 14:22:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gSoMn-00083C-GD
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 14:22:26 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:38426)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gSoMn-00082u-A0
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 14:22:21 -0500
Received: by mail-pl1-x641.google.com with SMTP id e5so3265969plb.5
	for <qemu-devel@nongnu.org>; Fri, 30 Nov 2018 11:22:21 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 30 Nov 2018 11:22:15 -0800
Message-Id: <20181130192216.26987-2-richard.henderson@linaro.org>
In-Reply-To: <20181130192216.26987-1-richard.henderson@linaro.org>
References: <20181130192216.26987-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH for-4.0 1/2] target/s390x: Move TOD_UNIX_EPOCH
 to cpu.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cohuck@redhat.com, david@redhat.com, qemu-s390x@nongnu.org

We will need this from CONFIG_USER_ONLY as well,
which cannot access include/hw/.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/s390x/tod.h | 3 ---
 target/s390x/cpu.h     | 3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/hw/s390x/tod.h b/include/hw/s390x/tod.h
index 413c0d7c02..6ec4fb426c 100644
--- a/include/hw/s390x/tod.h
+++ b/include/hw/s390x/tod.h
@@ -44,9 +44,6 @@ typedef struct S390TODClass {
     void (*set)(S390TODState *td, const S390TOD *tod, Error **errp);
 } S390TODClass;
 
-/* The value of the TOD clock for 1.1.1970. */
-#define TOD_UNIX_EPOCH 0x7d91048bca000000ULL
-
 /* Converts ns to s390's clock format */
 static inline uint64_t time2tod(uint64_t ns)
 {
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 8c2320e882..d8049d181a 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -797,4 +797,7 @@ void s390_init_sigp(void);
 /* outside of target/s390x/ */
 S390CPU *s390_cpu_addr2state(uint16_t cpu_addr);
 
+/* The value of the TOD clock for 1.1.1970. */
+#define TOD_UNIX_EPOCH 0x7d91048bca000000ULL
+
 #endif
-- 
2.17.2
