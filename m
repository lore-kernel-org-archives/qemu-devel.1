Received: from eggs.gnu.org ([209.51.188.92]:35962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <driver1998@foxmail.com>) id 1hKuUu-0007yY-Sm
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 20:50:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <driver1998@foxmail.com>) id 1hKuUt-0003Q6-DS
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 20:50:20 -0400
Received: from smtpbg444.qq.com ([183.3.255.70]:53817 helo=qq.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <driver1998@foxmail.com>)
	id 1hKuUs-0003OX-PW
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 20:50:19 -0400
From: driver1998 <driver1998@foxmail.com>
Date: Mon, 29 Apr 2019 00:33:22 +0000
Message-Id: <20190429003322.22908-1-driver1998@foxmail.com>
Subject: [Qemu-devel] [PATCH 3/4] util/cacheinfo.c: Use uintptr_t instead of
 unsigned long in AArch64 arch_cache_info()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: driver1998 <driver1998@foxmail.com>

Windows ARM64 uses LLP64 model, which breaks current assumptions.

Signed-off-by: driver1998 <driver1998@foxmail.com>
---
 util/cacheinfo.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/util/cacheinfo.c b/util/cacheinfo.c
index 3cd080b83d..a815cb0722 100644
--- a/util/cacheinfo.c
+++ b/util/cacheinfo.c
@@ -107,7 +107,7 @@ static void sys_cache_info(int *isize, int *dsize)
 static void arch_cache_info(int *isize, int *dsize)
 {
     if (*isize == 0 || *dsize == 0) {
-        unsigned long ctr;
+        uintptr_t ctr;
 
         /* The real cache geometry is in CCSIDR_EL1/CLIDR_EL1/CSSELR_EL1,
            but (at least under Linux) these are marked protected by the
@@ -120,6 +120,8 @@ static void arch_cache_info(int *isize, int *dsize)
         if (*dsize == 0) {
             *dsize = 4 << ((ctr >> 16) & 0xf);
         }
+
+        printf("%d %d\n", *isize, *dsize);
     }
 }
 
-- 
2.17.1
