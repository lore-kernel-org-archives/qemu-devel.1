Received: from eggs.gnu.org ([2001:4830:134:3::10]:41807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fVFNV-000786-JC
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 08:04:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fVFNS-0001o4-2w
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 08:04:53 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Tue, 19 Jun 2018 14:04:27 +0200
Message-Id: <20180619120434.25062-6-cohuck@redhat.com>
In-Reply-To: <20180619120434.25062-1-cohuck@redhat.com>
References: <20180619120434.25062-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 05/12] s390x/cpumodels: add z14 Model ZR1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>

From: Christian Borntraeger <borntraeger@de.ibm.com>

Introduce the new z14 Model ZR1 cpu model. Mostly identical to z14, only
the cpu type differs (3906 vs. 3907)

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Message-Id: <20180613081819.147178-1-borntraeger@de.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/cpu_models.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index e10035aaa8..cfdbccf46d 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -79,6 +79,7 @@ static S390CPUDef s390_cpu_defs[] = {
     CPUDEF_INIT(0x2964, 13, 2, 47, 0x08000000U, "z13.2", "IBM z13 GA2"),
     CPUDEF_INIT(0x2965, 13, 2, 47, 0x08000000U, "z13s", "IBM z13s GA1"),
     CPUDEF_INIT(0x3906, 14, 1, 47, 0x08000000U, "z14", "IBM z14 GA1"),
+    CPUDEF_INIT(0x3907, 14, 1, 47, 0x08000000U, "z14ZR1", "IBM z14 Model ZR1 GA1"),
 };
 
 #define QEMU_MAX_CPU_TYPE 0x2827
-- 
2.14.4
