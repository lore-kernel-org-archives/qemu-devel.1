Received: from eggs.gnu.org ([2001:4830:134:3::10]:41770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhJN-0002ZR-OO
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:20:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhJM-0004Il-Lk
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:20:05 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 23 Jul 2018 15:16:53 -0500
Message-Id: <20180723201748.25573-45-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
References: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 44/99] i386: define the AMD 'virt-ssbd' CPUID
 feature bit (CVE-2018-3639)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

AMD Zen expose the Intel equivalant to Speculative Store Bypass Disable
via the 0x80000008_EBX[25] CPUID feature bit.

This needs to be exposed to guest OS to allow them to protect
against CVE-2018-3639.

Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20180521215424.13520-3-berrange@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
(cherry picked from commit 403503b162ffc33fb64cfefdf7b880acf41772cd)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 target/i386/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 2f5263e22f..2e305ab689 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -541,7 +541,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             "ibpb", NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
-            NULL, NULL, NULL, NULL,
+            NULL, "virt-ssbd", NULL, NULL,
             NULL, NULL, NULL, NULL,
         },
         .cpuid_eax = 0x80000008,
-- 
2.17.1
