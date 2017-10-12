Received: from eggs.gnu.org ([2001:4830:134:3::10]:39297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e2fkX-0002WJ-BW
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 11:50:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e2fkR-0000dN-Ro
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 11:50:17 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu, 12 Oct 2017 17:50:08 +0200
Message-Id: <1507823408-270386-1-git-send-email-imammedo@redhat.com>
In-Reply-To: <1507578671-158758-19-git-send-email-imammedo@redhat.com>
References: <1507578671-158758-19-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v2 18/24] fixup! ppc: spapr: use generic
 cpu_model parsing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, agraf@suse.de, david@gibson.dropbear.id.au

inot sure how it managed to compile locally and on travis
but build fails with type mismatch on PPC host, fixup it
by casting to expected type

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 target/ppc/kvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 48dc3f7..9d57deb 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2505,7 +2505,7 @@ static int kvm_ppc_register_host_cpu_type(MachineState *ms)
     }
     type_info.parent = object_class_get_name(OBJECT_CLASS(pvr_pcc));
     type_register(&type_info);
-    if (object_dynamic_cast(ms, TYPE_SPAPR_MACHINE)) {
+    if (object_dynamic_cast(OBJECT(ms), TYPE_SPAPR_MACHINE)) {
         /* override TCG default cpu type with 'host' cpu model */
         mc->default_cpu_type = TYPE_HOST_POWERPC_CPU;
     }
-- 
2.7.4
