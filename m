Received: from eggs.gnu.org ([2001:4830:134:3::10]:56216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dO0GJ-0002Zo-OU
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 07:27:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dO0GG-0000H1-JW
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 07:26:59 -0400
From: Laurent Vivier <lvivier@redhat.com>
Date: Thu, 22 Jun 2017 13:26:48 +0200
Message-Id: <20170622112648.24815-1-lvivier@redhat.com>
Subject: [Qemu-devel] [PATCH] target/ppc/cpu-models: set POWER9_v1.0 as
 POWER9 DD1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>

CPU_POWERPC_POWER9_DD1 is 0x004E0100, so this is the POWER9 v1.0.

When we run qemu on a POWER9 DD1 host, we must use either
"-cpu host" or "-cpu POWER9", but in the latter case it fails with

    Unable to find sPAPR CPU Core definition

because POWER9 DD1 doesn't appear in the list of known CPUs.

This patch fixes this by defining POWER9_v1.0 with POWER9 DD1
PVR instead of CPU_POWERPC_POWER9_BASE.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 target/ppc/cpu-models.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/cpu-models.c b/target/ppc/cpu-models.c
index 4d3e635..a22363c 100644
--- a/target/ppc/cpu-models.c
+++ b/target/ppc/cpu-models.c
@@ -1144,7 +1144,7 @@
     POWERPC_DEF("970_v2.2",      CPU_POWERPC_970_v22,                970,
                 "PowerPC 970 v2.2")
 
-    POWERPC_DEF("POWER9_v1.0",   CPU_POWERPC_POWER9_BASE,            POWER9,
+    POWERPC_DEF("POWER9_v1.0",   CPU_POWERPC_POWER9_DD1,             POWER9,
                 "POWER9 v1.0")
 
     POWERPC_DEF("970fx_v1.0",    CPU_POWERPC_970FX_v10,              970,
-- 
2.9.4
