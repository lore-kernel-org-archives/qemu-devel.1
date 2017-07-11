Received: from eggs.gnu.org ([2001:4830:134:3::10]:56232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dUzSr-0002UN-DB
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 14:00:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dUzSn-0005Dk-9z
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 14:00:49 -0400
Received: from mail-wr0-f175.google.com ([209.85.128.175]:34676)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dUzSm-0005CE-PO
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 14:00:45 -0400
Received: by mail-wr0-f175.google.com with SMTP id 77so9556886wrb.1
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 11:00:44 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 11 Jul 2017 18:59:34 +0100
Message-Id: <20170711175937.23140-4-alex.bennee@linaro.org>
In-Reply-To: <20170711175937.23140-1-alex.bennee@linaro.org>
References: <20170711175937.23140-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 3/6] target/arm/translate.h: expand comment
 on DISAS_EXIT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, rth@twiddle.net, cota@braap.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, "open list:ARM" <qemu-arm@nongnu.org>

We already have an exit condition, DISAS_UPDATE which will exit the
run-loop. Expand on the difference with DISAS_EXIT in the comments.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <rth@twiddle.net>
---
 target/arm/translate.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/arm/translate.h b/target/arm/translate.h
index 15d383d9af..12fd79ba8e 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -140,7 +140,10 @@ static void disas_set_insn_syndrome(DisasContext *s, uint32_t syn)
  */
 #define DISAS_BX_EXCRET 11
 /* For instructions which want an immediate exit to the main loop,
- * as opposed to attempting to use lookup_and_goto_ptr.
+ * as opposed to attempting to use lookup_and_goto_ptr. Unlike
+ * DISAS_UPDATE this doesn't write the PC on exiting the translation
+ * loop so you need to ensure something (gen_a64_set_pc_im or runtime
+ * helper) has done so before we reach return from cpu_tb_exec.
  */
 #define DISAS_EXIT 12
 
-- 
2.13.0
