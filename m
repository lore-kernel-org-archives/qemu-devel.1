Received: from eggs.gnu.org ([2001:4830:134:3::10]:33787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dN6ej-0003cp-Jj
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 20:04:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dN6eg-00020U-Fu
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 20:04:29 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:35691)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dN6eg-00020N-AB
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 20:04:26 -0400
Received: by mail-pf0-x241.google.com with SMTP id s66so19892449pfs.2
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 17:04:26 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Mon, 19 Jun 2017 17:04:04 -0700
Message-Id: <20170620000405.3391-18-rth@twiddle.net>
In-Reply-To: <20170620000405.3391-1-rth@twiddle.net>
References: <20170620000405.3391-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v3 17/18] target/s390x: Mark ETF3 and ETF3_ENH
 facilities as available
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

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/cpu_models.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index be7757c..16129f6 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -678,11 +678,13 @@ static void add_qemu_cpu_model_features(S390FeatBitmap fbm)
         S390_FEAT_STFLE,
         S390_FEAT_EXTENDED_IMMEDIATE,
         S390_FEAT_EXTENDED_TRANSLATION_2,
+        S390_FEAT_EXTENDED_TRANSLATION_3,
         S390_FEAT_LONG_DISPLACEMENT,
         S390_FEAT_LONG_DISPLACEMENT_FAST,
         S390_FEAT_ETF2_ENH,
         S390_FEAT_STORE_CLOCK_FAST,
         S390_FEAT_MOVE_WITH_OPTIONAL_SPEC,
+        S390_FEAT_ETF3_ENH,
         S390_FEAT_COMPARE_AND_SWAP_AND_STORE,
         S390_FEAT_COMPARE_AND_SWAP_AND_STORE_2,
         S390_FEAT_GENERAL_INSTRUCTIONS_EXT,
-- 
2.9.4
