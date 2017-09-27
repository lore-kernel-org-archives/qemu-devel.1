Received: from eggs.gnu.org ([2001:4830:134:3::10]:58337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dx8mG-0000qV-6m
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 05:37:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dx8mF-00053N-8a
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 05:37:12 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Wed, 27 Sep 2017 11:37:00 +0200
Message-Id: <20170927093700.6058-2-cohuck@redhat.com>
In-Reply-To: <20170927093700.6058-1-cohuck@redhat.com>
References: <20170927093700.6058-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL URGENT 1/1] s390x/cpumodel: remove ais from z14
 default model-> also for 2.10.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, mdroth@linux.vnet.ibm.com, zyimin@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, qemu-stable@nongnu.org, Cornelia Huck <cohuck@redhat.com>

From: Christian Borntraeger <borntraeger@de.ibm.com>

We disabled ais for 2.10, so let's also remove it from the z14
default model.

Fixes: 3f2d07b3b01e ("s390x/ais: for 2.10 stable: disable ais facility")
CC: qemu-stable@nongnu.org
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Message-Id: <20170927072030.35737-2-borntraeger@de.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/gen-features.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index c8dc104bc1..68e6c31b4b 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -527,7 +527,6 @@ static uint16_t default_GEN13_GA1[] = {
 #define default_GEN13_GA2 EmptyFeat
 
 static uint16_t default_GEN14_GA1[] = {
-    S390_FEAT_ADAPTER_INT_SUPPRESSION,
     S390_FEAT_INSTRUCTION_EXEC_PROT,
     S390_FEAT_GUARDED_STORAGE,
     S390_FEAT_VECTOR_PACKED_DECIMAL,
-- 
2.13.5
