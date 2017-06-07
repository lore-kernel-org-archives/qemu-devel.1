Received: from eggs.gnu.org ([2001:4830:134:3::10]:34555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dIOuB-00042f-7s
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:33:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dIOu8-0002Yq-5Q
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:32:59 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:35681)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dIOu8-0002YD-1H
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:32:56 -0400
Received: by mail-qk0-x242.google.com with SMTP id u129so440719qka.2
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 17:32:55 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue,  6 Jun 2017 17:31:18 -0700
Message-Id: <20170607003119.14778-70-rth@twiddle.net>
In-Reply-To: <20170607003119.14778-1-rth@twiddle.net>
References: <20170607003119.14778-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL v2 69/70] target/s390x: mark ETF2 and ETF2-ENH
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
Cc: peter.maydell@linaro.org, aurelien@aurel32.net

From: Aurelien Jarno <aurelien@aurel32.net>

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
Message-Id: <20170531220129.27724-30-aurelien@aurel32.net>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/cpu_models.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index e5e005a..fc3cb25 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -668,8 +668,10 @@ static void add_qemu_cpu_model_features(S390FeatBitmap fbm)
     static const int feats[] = {
         S390_FEAT_STFLE,
         S390_FEAT_EXTENDED_IMMEDIATE,
+        S390_FEAT_EXTENDED_TRANSLATION_2,
         S390_FEAT_LONG_DISPLACEMENT,
         S390_FEAT_LONG_DISPLACEMENT_FAST,
+        S390_FEAT_ETF2_ENH,
         S390_FEAT_STORE_CLOCK_FAST,
         S390_FEAT_GENERAL_INSTRUCTIONS_EXT,
         S390_FEAT_EXECUTE_EXT,
-- 
2.9.4
