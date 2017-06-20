Received: from eggs.gnu.org ([2001:4830:134:3::10]:33698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dN6eb-0003VC-Cq
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 20:04:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dN6ea-0001vr-Ga
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 20:04:21 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:35442)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dN6ea-0001uk-BL
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 20:04:20 -0400
Received: by mail-pg0-x241.google.com with SMTP id f127so18598392pgc.2
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 17:04:20 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Mon, 19 Jun 2017 17:03:58 -0700
Message-Id: <20170620000405.3391-12-rth@twiddle.net>
In-Reply-To: <20170620000405.3391-1-rth@twiddle.net>
References: <20170620000405.3391-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v3 11/18] target/s390x: Mark STFLE_49 facility
 as available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, aurelien@aurel32.net

This facility bit includes execution-hint, load-and-trap,
miscellaneous-instruction-extensions and processor-assist.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/cpu_models.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 1db814b..be7757c 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -689,6 +689,7 @@ static void add_qemu_cpu_model_features(S390FeatBitmap fbm)
         S390_FEAT_EXECUTE_EXT,
         S390_FEAT_FLOATING_POINT_SUPPPORT_ENH,
         S390_FEAT_STFLE_45,
+        S390_FEAT_STFLE_49,
         S390_FEAT_STFLE_53,
     };
     int i;
-- 
2.9.4
