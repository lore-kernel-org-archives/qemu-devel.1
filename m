Received: from eggs.gnu.org ([2001:4830:134:3::10]:33669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dN6ea-0003U0-86
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 20:04:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dN6eX-0001sV-4l
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 20:04:20 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:34733)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dN6eW-0001rw-VG
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 20:04:17 -0400
Received: by mail-pf0-x241.google.com with SMTP id d5so19894578pfe.1
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 17:04:16 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Mon, 19 Jun 2017 17:03:55 -0700
Message-Id: <20170620000405.3391-9-rth@twiddle.net>
In-Reply-To: <20170620000405.3391-1-rth@twiddle.net>
References: <20170620000405.3391-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v3 08/18] target/s390x: Mark STFLE_53 facility
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

This facility bit includes load-on-condition-2 and
load-and-zero-rightmost-byte.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/cpu_models.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 703feca..1db814b 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -689,6 +689,7 @@ static void add_qemu_cpu_model_features(S390FeatBitmap fbm)
         S390_FEAT_EXECUTE_EXT,
         S390_FEAT_FLOATING_POINT_SUPPPORT_ENH,
         S390_FEAT_STFLE_45,
+        S390_FEAT_STFLE_53,
     };
     int i;
 
-- 
2.9.4
