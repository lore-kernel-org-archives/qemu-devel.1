Received: from eggs.gnu.org ([2001:4830:134:3::10]:42582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVxYk-0000R1-7h
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:10:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVxYj-00056W-BA
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:10:54 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:33588)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dVxYj-000561-0G
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:10:53 -0400
Received: by mail-wr0-x241.google.com with SMTP id g46so1016827wrd.0
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 03:10:52 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 14 Jul 2017 12:10:28 +0200
Message-Id: <1500027028-4127-17-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1500027028-4127-1-git-send-email-pbonzini@redhat.com>
References: <1500027028-4127-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 55/55] spapr_rng: Convert to DEFINE_PROP_LINK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>

From: Fam Zheng <famz@redhat.com>

Signed-off-by: Fam Zheng <famz@redhat.com>
Message-Id: <20170714021509.23681-21-famz@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/ppc/spapr_rng.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/hw/ppc/spapr_rng.c b/hw/ppc/spapr_rng.c
index 80515eb..d2acd61 100644
--- a/hw/ppc/spapr_rng.c
+++ b/hw/ppc/spapr_rng.c
@@ -96,17 +96,11 @@ static target_ulong h_random(PowerPCCPU *cpu, sPAPRMachineState *spapr,
 
 static void spapr_rng_instance_init(Object *obj)
 {
-    sPAPRRngState *rngstate = SPAPR_RNG(obj);
-
     if (object_resolve_path_type("", TYPE_SPAPR_RNG, NULL) != NULL) {
         error_report("spapr-rng can not be instantiated twice!");
         return;
     }
 
-    object_property_add_link(obj, "rng", TYPE_RNG_BACKEND,
-                             (Object **)&rngstate->backend,
-                             object_property_allow_set_link,
-                             OBJ_PROP_LINK_UNREF_ON_RELEASE, NULL);
     object_property_set_description(obj, "rng",
                                     "ID of the random number generator backend",
                                     NULL);
@@ -163,6 +157,8 @@ int spapr_rng_populate_dt(void *fdt)
 
 static Property spapr_rng_properties[] = {
     DEFINE_PROP_BOOL("use-kvm", sPAPRRngState, use_kvm, false),
+    DEFINE_PROP_LINK("rng", sPAPRRngState, backend, TYPE_RNG_BACKEND,
+                     RngBackend *),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
1.8.3.1
