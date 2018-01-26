Received: from eggs.gnu.org ([2001:4830:134:3::10]:47702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1efBjA-0004W0-0f
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 16:40:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1efBj7-00018o-At
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 16:40:04 -0500
Received: from mail-by2nam01on0049.outbound.protection.outlook.com
	([104.47.34.49]:61546
	helo=NAM01-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1efBj7-00017B-3g
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 16:40:01 -0500
From: Babu Moger <babu.moger@amd.com>
Date: Fri, 26 Jan 2018 16:39:40 -0500
Message-Id: <20180126213944.7594-2-babu.moger@amd.com>
In-Reply-To: <20180126213944.7594-1-babu.moger@amd.com>
References: <20180126213944.7594-1-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 1/5] target/i386: Fix instruction cache
 associativity for AMD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, pixo@polepetko.eu
Cc: mtosatti@redhat.com, babu.moger@amd.com, qemu-devel@nongnu.org, kvm@vger.kernel.org

Per Processor Programming Reference, CPUID_Fn80000005_EDX should
report L1 instruction cache associativity as 4(way) instead of 2(way).

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 target/i386/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 3818d72831..cb055f5940 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -123,7 +123,7 @@
 /*FIXME: CPUID leaf 0x80000005 is inconsistent with leaves 2 & 4 */
 #define L1I_LINES_PER_TAG      1
 #define L1I_SIZE_KB_AMD       64
-#define L1I_ASSOCIATIVITY_AMD  2
+#define L1I_ASSOCIATIVITY_AMD  4
 
 /* Level 2 unified cache: */
 #define L2_LINE_SIZE          64
-- 
2.16.0
