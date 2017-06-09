Received: from eggs.gnu.org ([2001:4830:134:3::10]:46987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dJCRw-0003va-Jm
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 01:27:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dJCRs-0006bg-I9
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 01:27:08 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  9 Jun 2017 15:26:33 +1000
Message-Id: <20170609052652.23200-2-david@gibson.dropbear.id.au>
In-Reply-To: <20170609052652.23200-1-david@gibson.dropbear.id.au>
References: <20170609052652.23200-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 01/20] target/ppc: pass const string to
 kvmppc_is_mem_backend_page_size_ok()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, mdroth@linux.vnet.ibm.com, sursingh@redhat.com, Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

This function has three implementations. Two are stubs that do nothing
and the third one only passes the obj_path argument to:

Object *object_resolve_path(const char *path, bool *ambiguous);

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/kvm.c     | 4 ++--
 target/ppc/kvm_ppc.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 51249ce..8881762 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -478,7 +478,7 @@ static void kvm_fixup_page_sizes(PowerPCCPU *cpu)
     }
 }
=20
-bool kvmppc_is_mem_backend_page_size_ok(char *obj_path)
+bool kvmppc_is_mem_backend_page_size_ok(const char *obj_path)
 {
     Object *mem_obj =3D object_resolve_path(obj_path, NULL);
     char *mempath =3D object_property_get_str(mem_obj, "mem-path", NULL)=
;
@@ -499,7 +499,7 @@ static inline void kvm_fixup_page_sizes(PowerPCCPU *c=
pu)
 {
 }
=20
-bool kvmppc_is_mem_backend_page_size_ok(char *obj_path)
+bool kvmppc_is_mem_backend_page_size_ok(const char *obj_path)
 {
     return true;
 }
diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index f48243d..eab7c8f 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -64,7 +64,7 @@ int kvmppc_enable_hwrng(void);
 int kvmppc_put_books_sregs(PowerPCCPU *cpu);
 PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void);
=20
-bool kvmppc_is_mem_backend_page_size_ok(char *obj_path);
+bool kvmppc_is_mem_backend_page_size_ok(const char *obj_path);
=20
 #else
=20
@@ -211,7 +211,7 @@ static inline uint64_t kvmppc_rma_size(uint64_t curre=
nt_size,
     return ram_size;
 }
=20
-static inline bool kvmppc_is_mem_backend_page_size_ok(char *obj_path)
+static inline bool kvmppc_is_mem_backend_page_size_ok(const char *obj_pa=
th)
 {
     return true;
 }
--=20
2.9.4
