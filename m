Received: from eggs.gnu.org ([209.51.188.92]:57543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <driver1998@foxmail.com>) id 1hLXGM-0001oe-Rj
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 14:13:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <driver1998@foxmail.com>) id 1hLXGK-0007LZ-HB
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 14:13:54 -0400
Received: from [103.7.28.233] (port=48940 helo=smtpbg65.qq.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <driver1998@foxmail.com>)
	id 1hLXGJ-0007Hj-0O
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 14:13:52 -0400
From: Cao Jiaxi <driver1998@foxmail.com>
Date: Wed,  1 May 2019 02:13:26 +0800
Message-Id: <20190430181326.1314-1-driver1998@foxmail.com>
Subject: [Qemu-devel] [PATCH v2 3/4] util/cacheinfo.c: Use uintptr_t instead
 of unsigned long in AArch64 arch_cache_info()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Cao Jiaxi <driver1998@foxmail.com>

Windows ARM64 uses LLP64 model, which breaks current assumptions.

Signed-off-by: Cao Jiaxi <driver1998@foxmail.com>
---
 util/cacheinfo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/cacheinfo.c b/util/cacheinfo.c
index 3cd080b83d..ce6f0dbf6a 100644
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
-- 
2.17.1
