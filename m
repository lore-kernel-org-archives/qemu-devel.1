Received: from eggs.gnu.org ([2001:4830:134:3::10]:39016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fOmto-0002dX-87
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:27:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fOmtl-0007al-6Z
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:27:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59610 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fOmtl-0007aI-1K
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:27:29 -0400
Date: Fri, 1 Jun 2018 19:27:28 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180601162620.32362-31-mst@redhat.com>
References: <20180601162620.32362-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180601162620.32362-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL 30/31] ACPI testing: test NFIT platform
 capabilities
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Ross Zwisler <ross.zwisler@linux.intel.com>, Igor Mammedov <imammedo@redhat.com>

From: Ross Zwisler <ross.zwisler@linux.intel.com>

Add testing for the newly added NFIT Platform Capabilities Structure.

Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
Suggested-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/bios-tables-test.c              |   2 +-
 tests/acpi-test-data/pc/NFIT.dimmpxm  | Bin 224 -> 240 bytes
 tests/acpi-test-data/q35/NFIT.dimmpxm | Bin 224 -> 240 bytes
 3 files changed, 1 insertion(+), 1 deletion(-)

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

-- 
MST
