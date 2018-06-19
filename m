Received: from eggs.gnu.org ([2001:4830:134:3::10]:44616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5go-0000GI-34
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:44:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5gn-0007jP-9Q
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:44:10 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 18 Jun 2018 20:43:14 -0500
Message-Id: <20180619014319.28272-109-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
References: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 108/113] i386: define the AMD 'virt-ssbd' CPUID
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
index bc087e95c3..1acf300cf8 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -490,7 +490,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             "ibpb", NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
-            NULL, NULL, NULL, NULL,
+            NULL, "virt-ssbd", NULL, NULL,
             NULL, NULL, NULL, NULL,
         },
         .cpuid_eax = 0x80000008,
-- 
2.11.0
