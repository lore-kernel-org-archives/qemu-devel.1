Received: from eggs.gnu.org ([2001:4830:134:3::10]:57268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1da497-00030C-Qg
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 14:01:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1da494-0002ZB-1S
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 14:01:25 -0400
Received: from 9.mo5.mail-out.ovh.net ([178.32.96.204]:36845)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1da493-0002Wu-S0
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 14:01:21 -0400
Received: from player760.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 77AC8116653
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 20:01:20 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Tue, 25 Jul 2017 20:01:12 +0200
Message-ID: <150100567284.27487.16381745122889215367.stgit@bahia>
In-Reply-To: <150100547373.27487.3154210751350595400.stgit@bahia>
References: <150100547373.27487.3154210751350595400.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [for-2.11 PATCH 15/26] spapr: add pseries-2.11 machine
 type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr.c      |   22 ++++++++++++++++++++--
 include/hw/compat.h |    3 +++
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 53969315ac24..277daa4f9645 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3533,18 +3533,36 @@ static const TypeInfo spapr_machine_info = {
     type_init(spapr_machine_register_##suffix)
 
 /*
+ * pseries-2.11
+ */
+static void spapr_machine_2_11_instance_options(MachineState *machine)
+{
+}
+
+static void spapr_machine_2_11_class_options(MachineClass *mc)
+{
+    /* Defaults for the latest behaviour inherited from the base class */
+}
+
+DEFINE_SPAPR_MACHINE(2_11, "2.11", true);
+
+/*
  * pseries-2.10
  */
+#define SPAPR_COMPAT_2_10                                              \
+    HW_COMPAT_2_10                                                     \
+
 static void spapr_machine_2_10_instance_options(MachineState *machine)
 {
 }
 
 static void spapr_machine_2_10_class_options(MachineClass *mc)
 {
-    /* Defaults for the latest behaviour inherited from the base class */
+    spapr_machine_2_11_class_options(mc);
+    SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_10);
 }
 
-DEFINE_SPAPR_MACHINE(2_10, "2.10", true);
+DEFINE_SPAPR_MACHINE(2_10, "2.10", false);
 
 /*
  * pseries-2.9
diff --git a/include/hw/compat.h b/include/hw/compat.h
index 08f36004dad7..3e101f8f6783 100644
--- a/include/hw/compat.h
+++ b/include/hw/compat.h
@@ -1,6 +1,9 @@
 #ifndef HW_COMPAT_H
 #define HW_COMPAT_H
 
+#define HW_COMPAT_2_10 \
+    /* empty */
+
 #define HW_COMPAT_2_9 \
     {\
         .driver   = "pci-bridge",\
