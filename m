Received: from eggs.gnu.org ([2001:4830:134:3::10]:39829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fYNDe-0004td-J3
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 23:03:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fYNDb-0007cm-Hx
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 23:03:38 -0400
Received: from mail-pg0-x231.google.com ([2607:f8b0:400e:c05::231]:44029)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fYNDb-0007cb-BT
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 23:03:35 -0400
Received: by mail-pg0-x231.google.com with SMTP id a14-v6so1794231pgw.10
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 20:03:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 27 Jun 2018 20:03:08 -0700
Message-Id: <20180628030330.15615-2-richard.henderson@linaro.org>
In-Reply-To: <20180628030330.15615-1-richard.henderson@linaro.org>
References: <20180628030330.15615-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 01/23] target/openrisc: Fix mtspr shadow gprs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: shorne@gmail.com

Missing break.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/openrisc/sys_helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/openrisc/sys_helper.c b/target/openrisc/sys_helper.c
index b284064381..2f337363ec 100644
--- a/target/openrisc/sys_helper.c
+++ b/target/openrisc/sys_helper.c
@@ -98,6 +98,7 @@ void HELPER(mtspr)(CPUOpenRISCState *env,
     case TO_SPR(0, 1024) ... TO_SPR(0, 1024 + (16 * 32)): /* Shadow GPRs */
         idx = (spr - 1024);
         env->shadow_gpr[idx / 32][idx % 32] = rb;
+        break;
 
     case TO_SPR(1, 512) ... TO_SPR(1, 512+DTLB_SIZE-1): /* DTLBW0MR 0-127 */
         idx = spr - TO_SPR(1, 512);
-- 
2.17.1
