Received: from eggs.gnu.org ([2001:4830:134:3::10]:40830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dxZ9T-0006yJ-Ks
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 09:46:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dxZ9N-0002Wj-SS
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 09:46:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36815)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dxZ9N-0002WR-Jo
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 09:46:49 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu, 28 Sep 2017 15:46:07 +0200
Message-Id: <20170928134609.16985-4-david@redhat.com>
In-Reply-To: <20170928134609.16985-1-david@redhat.com>
References: <20170928134609.16985-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 3/5] s390x/cpumodel: fix max STFL(E) bit
 number
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, cohuck@redhat.com, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <richard.henderson@linaro.org>, David Hildenbrand <david@redhat.com>

Not that it would matter in the near future, but it is actually 2048
bytes, therefore 16384 possible bits.

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/cpu_features.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
index 1d3a036393..31a4676f05 100644
--- a/target/s390x/cpu_features.c
+++ b/target/s390x/cpu_features.c
@@ -381,7 +381,7 @@ void s390_add_from_feat_block(S390FeatBitmap features, S390FeatType type,
 
     switch (type) {
     case S390_FEAT_TYPE_STFL:
-       nr_bits = 2048;
+       nr_bits = 16384;
        break;
     case S390_FEAT_TYPE_PLO:
        nr_bits = 256;
-- 
2.13.5
