Received: from eggs.gnu.org ([2001:4830:134:3::10]:48020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ross.zwisler@linux.intel.com>) id 1fKnjM-0007oc-Dr
	for qemu-devel@nongnu.org; Mon, 21 May 2018 12:32:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ross.zwisler@linux.intel.com>) id 1fKnjI-00087d-Kq
	for qemu-devel@nongnu.org; Mon, 21 May 2018 12:32:16 -0400
Received: from mga14.intel.com ([192.55.52.115]:48360)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ross.zwisler@linux.intel.com>)
	id 1fKnjI-00086Q-Ba
	for qemu-devel@nongnu.org; Mon, 21 May 2018 12:32:12 -0400
From: Ross Zwisler <ross.zwisler@linux.intel.com>
Date: Mon, 21 May 2018 10:32:03 -0600
Message-Id: <20180521163203.26590-5-ross.zwisler@linux.intel.com>
In-Reply-To: <20180521163203.26590-1-ross.zwisler@linux.intel.com>
References: <20180521163203.26590-1-ross.zwisler@linux.intel.com>
Subject: [Qemu-devel] [qemu PATCH v4 4/4] ACPI testing: test NFIT platform
 capabilities
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>, Haozhong Zhang <haozhong.zhang@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, "Elliott, Robert (Persistent Memory)" <elliott@hpe.com>

Add testing for the newly added NFIT Platform Capabilities Structure.

Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
Suggested-by: Igor Mammedov <imammedo@redhat.com>
---
 tests/acpi-test-data/pc/NFIT.dimmpxm  | Bin 224 -> 240 bytes
 tests/acpi-test-data/q35/NFIT.dimmpxm | Bin 224 -> 240 bytes
 tests/bios-tables-test.c              |   2 +-
 3 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/acpi-test-data/pc/NFIT.dimmpxm b/tests/acpi-test-data/pc/NFIT.dimmpxm
index 2bfc6c51f31c25a052803c494c933d4948fc0106..598d331b751cd3cb2137d431c1f34bb8957a0d31 100644
GIT binary patch
delta 35
lcmaFB_<@nj&&@OB0|NsCqsm0CYXa;H0t}2m9y1Vw005dH1-}3Q

delta 18
Zcmeys_<)hi&&@OB0RsaAqyI#%YXCU~1+M@A

diff --git a/tests/acpi-test-data/q35/NFIT.dimmpxm b/tests/acpi-test-data/q35/NFIT.dimmpxm
index 2bfc6c51f31c25a052803c494c933d4948fc0106..598d331b751cd3cb2137d431c1f34bb8957a0d31 100644
GIT binary patch
delta 35
lcmaFB_<@nj&&@OB0|NsCqsm0CYXa;H0t}2m9y1Vw005dH1-}3Q

delta 18
Zcmeys_<)hi&&@OB0RsaAqyI#%YXCU~1+M@A

diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index bf3e193ae9..256d463cb8 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -830,7 +830,7 @@ static void test_acpi_tcg_dimm_pxm(const char *machine)
     memset(&data, 0, sizeof(data));
     data.machine = machine;
     data.variant = ".dimmpxm";
-    test_acpi_one(" -machine nvdimm=on"
+    test_acpi_one(" -machine nvdimm=on,nvdimm-cap=3"
                   " -smp 4,sockets=4"
                   " -m 128M,slots=3,maxmem=1G"
                   " -numa node,mem=32M,nodeid=0"
-- 
2.14.3
