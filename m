Received: from eggs.gnu.org ([2001:4830:134:3::10]:55577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cRVZ6-0008DR-8M
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:56:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cRVZ5-0006oj-Iz
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:56:36 -0500
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:34634)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cRVZ5-0006oZ-FW
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:56:35 -0500
Received: by mail-qk0-x242.google.com with SMTP id e1so952251qkh.1
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 18:56:35 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Wed, 11 Jan 2017 18:55:53 -0800
Message-Id: <20170112025606.27332-18-rth@twiddle.net>
In-Reply-To: <20170112025606.27332-1-rth@twiddle.net>
References: <20170112025606.27332-1-rth@twiddle.net>
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
To: qemu-devel@nongnu.org
Cc: atar4qemu@gmail.com, mark.cave-ayland@ilande.co.uk, peter.maydell@linaro.org

From: Artyom Tarasenko <atar4qemu@gmail.com>

Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Message-Id: <70562e4ef094e2beb2c56380fdd0db7b15cc0294.1484165352.git.atar4qemu@gmail.com>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/sparc/ldst_helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index 301616b..d524aaa 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -1629,6 +1629,7 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, target_ulong val,
             env->scratch[i] = val;
             return;
         }
+    case ASI_QUEUE: /* UA2005 CPU mondo queue */
     case ASI_DCACHE_DATA: /* D-cache data */
     case ASI_DCACHE_TAG: /* D-cache tag access */
     case ASI_ESTATE_ERROR_EN: /* E-cache error enable */
-- 
2.9.3
