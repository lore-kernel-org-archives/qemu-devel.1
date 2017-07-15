Received: from eggs.gnu.org ([2001:4830:134:3::10]:50159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dWQuP-0006WD-BK
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 13:31:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dWQuK-0000uL-LJ
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 13:31:13 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:36580)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dWQuK-0000u6-Fa
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 13:31:08 -0400
Received: by mail-pf0-x242.google.com with SMTP id k24so866102pfj.3
	for <qemu-devel@nongnu.org>; Sat, 15 Jul 2017 10:31:08 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Sat, 15 Jul 2017 07:30:48 -1000
Message-Id: <20170715173050.31018-7-rth@twiddle.net>
In-Reply-To: <20170715173050.31018-1-rth@twiddle.net>
References: <20170715173050.31018-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 6/8] target/s390x: Mark ETF3 and ETF3_ENH
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
Cc: peter.maydell@linaro.org

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/cpu_models.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 8433010..9e9e649 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -782,11 +782,13 @@ static void add_qemu_cpu_model_features(S390FeatBitmap fbm)
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
