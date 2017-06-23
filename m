Received: from eggs.gnu.org ([2001:4830:134:3::10]:60242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dORMM-0001f5-K3
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:23:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dORMK-0007tl-2B
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:23:02 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:34562)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dORMJ-0007tV-Ub
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:22:59 -0400
Received: by mail-qk0-x242.google.com with SMTP id 91so968700qkq.1
	for <qemu-devel@nongnu.org>; Fri, 23 Jun 2017 09:22:59 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 23 Jun 2017 09:22:36 -0700
Message-Id: <20170623162241.8964-11-rth@twiddle.net>
In-Reply-To: <20170623162241.8964-1-rth@twiddle.net>
References: <20170623162241.8964-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 10/15] target/s390x: Mark STFLE_49 facility as
 available
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

This facility bit includes execution-hint, load-and-trap,
miscellaneous-instruction-extensions and processor-assist.

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/cpu_models.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index c55823b..d4fcddb 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -687,6 +687,7 @@ static void add_qemu_cpu_model_features(S390FeatBitmap fbm)
         S390_FEAT_EXECUTE_EXT,
         S390_FEAT_FLOATING_POINT_SUPPPORT_ENH,
         S390_FEAT_STFLE_45,
+        S390_FEAT_STFLE_49,
         S390_FEAT_STFLE_53,
     };
     int i;
-- 
2.9.4
