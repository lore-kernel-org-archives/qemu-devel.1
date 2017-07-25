Received: from eggs.gnu.org ([2001:4830:134:3::10]:44133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dZwKf-0001oP-RR
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 05:40:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dZwKe-0003XL-Tu
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 05:40:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39904)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dZwKe-0003Vl-N3
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 05:40:48 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Tue, 25 Jul 2017 11:40:16 +0200
Message-Id: <20170725094026.5376-5-cohuck@redhat.com>
In-Reply-To: <20170725094026.5376-1-cohuck@redhat.com>
References: <20170725094026.5376-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL for-2.10 04/14] target/s390x: drop BE_BIT()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, agraf@suse.de, rth@twiddle.net, thuth@redhat.com, david@redhat.com, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

Unused and broken, let's just get rid of it.

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20170720123721.12366-2-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/cpu_features.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/s390x/cpu_features.h b/target/s390x/cpu_features.h
index 14bc311dbe..770435e0cc 100644
--- a/target/s390x/cpu_features.h
+++ b/target/s390x/cpu_features.h
@@ -92,6 +92,5 @@ typedef struct {
 const S390FeatGroupDef *s390_feat_group_def(S390FeatGroup group);
 
 #define BE_BIT_NR(BIT) (BIT ^ (BITS_PER_LONG - 1))
-#define BE_BIT(BIT) (1ULL < BE_BIT_NR(BIT))
 
 #endif /* TARGET_S390X_CPU_FEATURES_H */
-- 
2.13.3
