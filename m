Received: from eggs.gnu.org ([2001:4830:134:3::10]:58713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ecOhh-0002GJ-8P
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 23:55:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ecOhg-0000Lt-GP
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 23:55:01 -0500
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:42705)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ecOhg-0000Jz-AS
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 23:55:00 -0500
Received: by mail-pg0-x244.google.com with SMTP id q67so544133pga.9
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 20:55:00 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 18 Jan 2018 20:54:32 -0800
Message-Id: <20180119045438.28582-11-richard.henderson@linaro.org>
In-Reply-To: <20180119045438.28582-1-richard.henderson@linaro.org>
References: <20180119045438.28582-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 10/16] target/arm: Add ARM_FEATURE_SVE
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

Not enabled anywhere so far.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 132da359b5..0a923e42d8 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1371,6 +1371,7 @@ enum arm_features {
     ARM_FEATURE_VBAR, /* has cp15 VBAR */
     ARM_FEATURE_M_SECURITY, /* M profile Security Extension */
     ARM_FEATURE_JAZELLE, /* has (trivial) Jazelle implementation */
+    ARM_FEATURE_SVE, /* has Scalable Vector Extension */
 };
 
 static inline int arm_feature(CPUARMState *env, int feature)
-- 
2.14.3
