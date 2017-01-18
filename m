Received: from eggs.gnu.org ([2001:4830:134:3::10]:37071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cTytL-0006kb-Qk
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 17:39:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cTytH-0002rG-30
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 17:39:43 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:34323)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1cTytG-0002qp-Tg
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 17:39:39 -0500
Received: by mail-wm0-x243.google.com with SMTP id c85so7558121wmi.1
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 14:39:38 -0800 (PST)
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Wed, 18 Jan 2017 23:38:30 +0100
Message-Id: <1484779123-18968-18-git-send-email-atar4qemu@gmail.com>
In-Reply-To: <1484779123-18968-1-git-send-email-atar4qemu@gmail.com>
References: <1484779123-18968-1-git-send-email-atar4qemu@gmail.com>
Subject: [Qemu-devel] [PULL 17/30] target-sparc: ignore writes to UA2005 CPU
 mondo queue register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, mark.cave-ayland@ilande.co.uk, rth@twiddle.net, Artyom Tarasenko <atar4qemu@gmail.com>

Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
Reviewed-by: Richard Henderson <rth@twiddle.net>
---
 target/sparc/ldst_helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index ade4fb0..d3747cf 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -1631,6 +1631,7 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, target_ulong val,
             env->scratch[i] = val;
             return;
         }
+    case ASI_QUEUE: /* UA2005 CPU mondo queue */
     case ASI_DCACHE_DATA: /* D-cache data */
     case ASI_DCACHE_TAG: /* D-cache tag access */
     case ASI_ESTATE_ERROR_EN: /* E-cache error enable */
-- 
2.7.2
