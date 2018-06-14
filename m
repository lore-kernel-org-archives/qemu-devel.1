Received: from eggs.gnu.org ([2001:4830:134:3::10]:48662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fTGuW-0001Hy-0G
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 21:18:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fTGuR-0007hx-PZ
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 21:18:47 -0400
Received: from mail-eopbgr700076.outbound.protection.outlook.com
	([40.107.70.76]:10976
	helo=NAM04-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1fTGuR-0007gd-Jq
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 21:18:43 -0400
From: Babu Moger <babu.moger@amd.com>
Date: Wed, 13 Jun 2018 21:18:24 -0400
Message-Id: <1528939107-17193-4-git-send-email-babu.moger@amd.com>
In-Reply-To: <1528939107-17193-1-git-send-email-babu.moger@amd.com>
References: <1528939107-17193-1-git-send-email-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v14 3/6] i386: Disable TOPOEXT feature on
 pc-2.12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, mtosatti@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, babu.moger@amd.com, kash@tripleback.net, geoff@hostfission.com

Disable TOPOEXT feature for older machines.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 include/hw/i386/pc.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 04d1f8c..ecccf6b 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -303,6 +303,10 @@ bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
         .driver   = TYPE_X86_CPU,\
         .property = "legacy-cache",\
         .value    = "on",\
+    },{\
+        .driver   = TYPE_X86_CPU,\
+        .property = "topoext",\
+        .value    = "off",\
     },
 
 #define PC_COMPAT_2_11 \
-- 
1.8.3.1
