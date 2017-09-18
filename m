Received: from eggs.gnu.org ([2001:4830:134:3::10]:37207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dtyTe-0006j4-Ug
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 12:00:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dtyTc-0007jj-DJ
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 12:00:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52344)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dtyTc-0007jR-7A
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 12:00:52 -0400
From: David Hildenbrand <david@redhat.com>
Date: Mon, 18 Sep 2017 17:59:47 +0200
Message-Id: <20170918160012.4317-3-david@redhat.com>
In-Reply-To: <20170918160012.4317-1-david@redhat.com>
References: <20170918160012.4317-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 02/27] s390x/cpumodel: fix max STFL(E) bit
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
Cc: Richard Henderson <richard.henderson@linaro.org>, thuth@redhat.com, cohuck@redhat.com, david@redhat.com, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>, Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Matthew Rosato <mjrosato@linux.vnet.ibm.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Not that it would matter in the near future, but it is actually 2048
bytes, therefore 16384 possible bits.

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
