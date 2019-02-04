Received: from eggs.gnu.org ([209.51.188.92]:51472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gqeC2-00010y-05
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 08:21:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gqe3P-0002cN-GT
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 08:12:52 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:40957)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gqe3P-000244-7Q
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 08:12:51 -0500
Received: by mail-wm1-x32a.google.com with SMTP id f188so13378113wmf.5
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 05:12:37 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon,  4 Feb 2019 13:12:25 +0000
Message-Id: <20190204131228.25949-2-richard.henderson@linaro.org>
In-Reply-To: <20190204131228.25949-1-richard.henderson@linaro.org>
References: <20190204131228.25949-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 1/4] fixup! target/arm: Cache the GP bit for
 a page in MemTxAttrs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

We talked about changing this, but missed when applying to target-arm.next.
---
 target/arm/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 2edf84b898..be0ec7de2a 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -10757,7 +10757,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
         }
         /* Merge in attributes from table descriptors */
         attrs |= nstable << 3; /* NS */
-        guarded |= extract64(descriptor, 50, 1);  /* GP */
+        guarded = extract64(descriptor, 50, 1);  /* GP */
         if (param.hpd) {
             /* HPD disables all the table attributes except NSTable.  */
             break;
-- 
2.17.2
