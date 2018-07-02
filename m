Received: from eggs.gnu.org ([2001:4830:134:3::10]:47859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fZzMF-0002vr-O2
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 09:59:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fZzME-0008Sg-OL
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 09:59:11 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:37762)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1fZzME-0008Rt-IW
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 09:59:10 -0400
Received: by mail-pg0-x244.google.com with SMTP id n15-v6so3961203pgv.4
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 06:59:10 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
Date: Mon,  2 Jul 2018 22:58:04 +0900
Message-Id: <20180702135806.7087-24-shorne@gmail.com>
In-Reply-To: <20180702135806.7087-1-shorne@gmail.com>
References: <20180702135806.7087-1-shorne@gmail.com>
Subject: [Qemu-devel] [PULL 23/25] linux-user: Fix struct sigaltstack for
 openrisc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Development <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>, Stafford Horne <shorne@gmail.com>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 linux-user/openrisc/target_signal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/openrisc/target_signal.h b/linux-user/openrisc/target_signal.h
index c352a8b333..8283eaf544 100644
--- a/linux-user/openrisc/target_signal.h
+++ b/linux-user/openrisc/target_signal.h
@@ -5,8 +5,8 @@
 
 typedef struct target_sigaltstack {
     abi_long ss_sp;
+    abi_int ss_flags;
     abi_ulong ss_size;
-    abi_long ss_flags;
 } target_stack_t;
 
 /* sigaltstack controls  */
-- 
2.17.0
