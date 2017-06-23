Received: from eggs.gnu.org ([2001:4830:134:3::10]:60039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dORMG-0001XR-Ta
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:22:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dORMG-0007po-6B
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:22:56 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:34544)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dORMG-0007pc-1i
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:22:56 -0400
Received: by mail-qk0-x243.google.com with SMTP id 91so968389qkq.1
	for <qemu-devel@nongnu.org>; Fri, 23 Jun 2017 09:22:56 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 23 Jun 2017 09:22:33 -0700
Message-Id: <20170623162241.8964-8-rth@twiddle.net>
In-Reply-To: <20170623162241.8964-1-rth@twiddle.net>
References: <20170623162241.8964-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 07/15] target/s390x: Mark STFLE_53 facility as
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

This facility bit includes load-on-condition-2 and
load-and-zero-rightmost-byte.

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/cpu_models.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index e676d7d..c55823b 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -687,6 +687,7 @@ static void add_qemu_cpu_model_features(S390FeatBitmap fbm)
         S390_FEAT_EXECUTE_EXT,
         S390_FEAT_FLOATING_POINT_SUPPPORT_ENH,
         S390_FEAT_STFLE_45,
+        S390_FEAT_STFLE_53,
     };
     int i;
 
-- 
2.9.4
