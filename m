Received: from eggs.gnu.org ([2001:4830:134:3::10]:52261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fkqHm-0005pr-6Y
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 08:31:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fkqHl-0004Wo-GZ
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 08:31:26 -0400
Received: from mail-vk0-x242.google.com ([2607:f8b0:400c:c05::242]:33290)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fkqHl-0004WY-DG
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 08:31:25 -0400
Received: by mail-vk0-x242.google.com with SMTP id y70-v6so9187212vkc.0
	for <qemu-devel@nongnu.org>; Wed, 01 Aug 2018 05:31:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  1 Aug 2018 08:31:11 -0400
Message-Id: <20180801123111.3595-5-richard.henderson@linaro.org>
In-Reply-To: <20180801123111.3595-1-richard.henderson@linaro.org>
References: <20180801123111.3595-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 4/4] target/arm: Fix typo in helper_sve_movz_d
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, laurent.desnogues@gmail.com

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
