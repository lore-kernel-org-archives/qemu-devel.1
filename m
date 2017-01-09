Received: from eggs.gnu.org ([2001:4830:134:3::10]:50771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cQZVy-0000Jf-Oz
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 07:57:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cQZVu-0002tO-U3
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 07:57:30 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Mon,  9 Jan 2017 13:57:24 +0100
Message-Id: <1483966644-14049-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] hw/ppc/spapr: Allow POWER9 as hot-pluggable
 CPU for pseries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>, Bharata B Rao <bharata@linux.vnet.ibm.com>

Running "qemu-system-ppc64 -M pseries -cpu POWER9" currently does not work
yet and results in this error message:

 qemu-system-ppc64: Unable to find sPAPR CPU Core definition

Since we want to support the pseries machine with POWER9 in the future,
allow using POWER9 as hot-pluggable CPU there, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/ppc/spapr_cpu_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 9dddaeb..71253f9 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -360,6 +360,9 @@ static const char *spapr_core_models[] = {
 
     /* POWER8NVL */
     "POWER8NVL_v1.0",
+
+    /* POWER9 */
+    "POWER9_v1.0",
 };
 
 void spapr_cpu_core_class_init(ObjectClass *oc, void *data)
-- 
1.8.3.1
