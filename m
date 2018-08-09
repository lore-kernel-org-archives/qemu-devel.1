Received: from eggs.gnu.org ([2001:4830:134:3::10]:37694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fnboZ-0006dy-QR
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 23:40:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fnboY-00039p-WD
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 23:40:43 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f]:35858)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fnboY-000398-QP
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 23:40:42 -0400
Received: by mail-pg1-x52f.google.com with SMTP id h12-v6so2073615pgs.3
	for <qemu-devel@nongnu.org>; Wed, 08 Aug 2018 20:40:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  8 Aug 2018 20:40:26 -0700
Message-Id: <20180809034033.10579-5-richard.henderson@linaro.org>
In-Reply-To: <20180809034033.10579-1-richard.henderson@linaro.org>
References: <20180809034033.10579-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 04/11] target/arm: Fix typo in helper_sve_movz_d
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent.desnogues@gmail.com, peter.maydell@linaro.org, alex.bennee@linaro.org, qemu-stable@nongnu.org

Cc: qemu-stable@nongnu.org (3.0.1)
Tested-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Reviewed-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/sve_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 87594a8adb..c3cbec9cf5 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -1042,7 +1042,7 @@ void HELPER(sve_movz_d)(void *vd, void *vn, void *vg, uint32_t desc)
     uint64_t *d = vd, *n = vn;
     uint8_t *pg = vg;
     for (i = 0; i < opr_sz; i += 1) {
-        d[i] = n[1] & -(uint64_t)(pg[H1(i)] & 1);
+        d[i] = n[i] & -(uint64_t)(pg[H1(i)] & 1);
     }
 }
 
-- 
2.17.1
