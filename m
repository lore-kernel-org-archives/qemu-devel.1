Received: from eggs.gnu.org ([2001:4830:134:3::10]:50579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dXlmS-0000vj-2O
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 06:00:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dXlmN-0006H3-4R
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 06:00:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46636)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dXlmM-0006GU-Ut
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 06:00:27 -0400
From: David Hildenbrand <david@redhat.com>
Date: Wed, 19 Jul 2017 11:50:29 +0200
Message-Id: <20170719095033.20482-2-david@redhat.com>
In-Reply-To: <20170719095033.20482-1-david@redhat.com>
References: <20170719095033.20482-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 1/5] target/s390x: drop BE_BIT()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: rth@twiddle.net, thuth@redhat.com, cohuck@redhat.com, jjherne@linux.vnet.ibm.com, david@redhat.com, borntraeger@de.ibm.com

Unused and broken, let's just get rid of it.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/cpu_features.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/s390x/cpu_features.h b/target/s390x/cpu_features.h
index 14bc311..770435e 100644
--- a/target/s390x/cpu_features.h
+++ b/target/s390x/cpu_features.h
@@ -92,6 +92,5 @@ typedef struct {
 const S390FeatGroupDef *s390_feat_group_def(S390FeatGroup group);
 
 #define BE_BIT_NR(BIT) (BIT ^ (BITS_PER_LONG - 1))
-#define BE_BIT(BIT) (1ULL < BE_BIT_NR(BIT))
 
 #endif /* TARGET_S390X_CPU_FEATURES_H */
-- 
2.9.4
