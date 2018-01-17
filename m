Received: from eggs.gnu.org ([2001:4830:134:3::10]:45584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ebdQJ-0007rU-Pe
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 21:25:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ebdQI-0001JX-A2
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 21:25:55 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 17 Jan 2018 13:25:12 +1100
Message-Id: <20180117022525.31767-10-david@gibson.dropbear.id.au>
In-Reply-To: <20180117022525.31767-1-david@gibson.dropbear.id.au>
References: <20180117022525.31767-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 09/22] spapr: Remove unnecessary 'options' field
 from sPAPRCapabilityInfo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, surajjs@au1.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, joserz@linux.vnet.ibm.com, lvivier@redhat.com, David Gibson <david@gibson.dropbear.id.au>

The options field here is intended to list the available values for the
capability.  It's not used yet, because the existing capabilities are
boolean.

We're going to add capabilities that aren't, but in that case the info on
the possible values can be folded into the .description field.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_caps.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index f95a78547d..d5c9ce774a 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -35,7 +35,6 @@
 typedef struct sPAPRCapabilityInfo {
     const char *name;
     const char *description;
-    const char *options;                        /* valid capability values */
     int index;
 
     /* Getter and Setter Function Pointers */
@@ -126,7 +125,6 @@ sPAPRCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
     [SPAPR_CAP_HTM] = {
         .name = "htm",
         .description = "Allow Hardware Transactional Memory (HTM)",
-        .options = "",
         .index = SPAPR_CAP_HTM,
         .get = spapr_cap_get_bool,
         .set = spapr_cap_set_bool,
@@ -136,7 +134,6 @@ sPAPRCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
     [SPAPR_CAP_VSX] = {
         .name = "vsx",
         .description = "Allow Vector Scalar Extensions (VSX)",
-        .options = "",
         .index = SPAPR_CAP_VSX,
         .get = spapr_cap_get_bool,
         .set = spapr_cap_set_bool,
@@ -146,7 +143,6 @@ sPAPRCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
     [SPAPR_CAP_DFP] = {
         .name = "dfp",
         .description = "Allow Decimal Floating Point (DFP)",
-        .options = "",
         .index = SPAPR_CAP_DFP,
         .get = spapr_cap_get_bool,
         .set = spapr_cap_set_bool,
@@ -338,7 +334,7 @@ void spapr_caps_add_properties(sPAPRMachineClass *smc, Error **errp)
             return;
         }
 
-        desc = g_strdup_printf("%s%s", cap->description, cap->options);
+        desc = g_strdup_printf("%s", cap->description);
         object_class_property_set_description(klass, name, desc, &local_err);
         g_free(desc);
         if (local_err) {
-- 
2.14.3
