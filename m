Received: from eggs.gnu.org ([2001:4830:134:3::10]:59007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fDAQ0-00061p-Vz
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 11:08:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fDAPz-0004z2-79
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 11:08:44 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:41025)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1fDAPy-0004yW-VQ
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 11:08:43 -0400
Received: by mail-lf0-x242.google.com with SMTP id o123-v6so12564363lfe.8
	for <qemu-devel@nongnu.org>; Mon, 30 Apr 2018 08:08:42 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Mon, 30 Apr 2018 17:08:33 +0200
Message-Id: <20180430150837.20470-2-edgar.iglesias@gmail.com>
In-Reply-To: <20180430150837.20470-1-edgar.iglesias@gmail.com>
References: <20180430150837.20470-1-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PULL v1 1/5] target-microblaze: Respect MSR.PVR as
 read-only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, sai.pavan.boddu@xilinx.com, alistair@alistair23.me, frasse.iglesias@gmail.com, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Respect MSR.PVR as read-only. We were wrongly overwriting the PVR bit.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 7628b0e25b..f739751930 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -424,7 +424,7 @@ static inline void msr_write(DisasContext *dc, TCGv v)
     /* PVR bit is not writable.  */
     tcg_gen_andi_tl(t, v, ~MSR_PVR);
     tcg_gen_andi_tl(cpu_SR[SR_MSR], cpu_SR[SR_MSR], MSR_PVR);
-    tcg_gen_or_tl(cpu_SR[SR_MSR], cpu_SR[SR_MSR], v);
+    tcg_gen_or_tl(cpu_SR[SR_MSR], cpu_SR[SR_MSR], t);
     tcg_temp_free(t);
 }
 
-- 
2.14.1
