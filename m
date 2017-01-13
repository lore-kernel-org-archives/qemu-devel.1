Received: from eggs.gnu.org ([2001:4830:134:3::10]:53003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1cRvLt-0005uH-Bw
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 01:28:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1cRvLs-0001uN-KH
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 01:28:41 -0500
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Fri, 13 Jan 2017 17:28:08 +1100
Message-Id: <1484288903-18807-3-git-send-email-sjitindarsingh@gmail.com>
In-Reply-To: <1484288903-18807-1-git-send-email-sjitindarsingh@gmail.com>
References: <1484288903-18807-1-git-send-email-sjitindarsingh@gmail.com>
Subject: [Qemu-devel] [RFC PATCH 02/17] hw/ppc/spapr: Add POWER9 to pseries
 cpu models
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: david@gibson.dropbear.id.au, agraf@suse.de, qemu-devel@nongnu.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>

Add POWER9 cpu to list of spapr core models which allows it to be specified
as the cpu model for a pseries guest (e.g. -machine pseries -cpu POWER9).

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 hw/ppc/spapr_cpu_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index c18632b..8cc7058 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -358,6 +358,9 @@ static const char *spapr_core_models[] = {
 
     /* POWER8NVL */
     "POWER8NVL_v1.0",
+
+    /* POWER9 */
+    "POWER9_v1.0",
 };
 
 void spapr_cpu_core_class_init(ObjectClass *oc, void *data)
-- 
2.5.5
