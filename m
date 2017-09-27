Received: from eggs.gnu.org ([2001:4830:134:3::10]:56445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dx70L-0001PC-BQ
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 03:43:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dx70I-0003z8-87
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 03:43:37 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 27 Sep 2017 17:42:52 +1000
Message-Id: <20170927074316.4454-3-david@gibson.dropbear.id.au>
In-Reply-To: <20170927074316.4454-1-david@gibson.dropbear.id.au>
References: <20170927074316.4454-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 02/26] ppc/kvm: drop kvmppc_has_cap_htab_fd()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, groug@kaod.org, mark.cave-ayland@ilande.co.uk, balaton@eik.bme.hu, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

It never got used since its introduction (commit 7c43bca004af).

Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/kvm.c     | 5 -----
 target/ppc/kvm_ppc.h | 6 ------
 2 files changed, 11 deletions(-)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 208c70e814..be27429b57 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2448,11 +2448,6 @@ bool kvmppc_has_cap_epr(void)
     return cap_epr;
 }
 
-bool kvmppc_has_cap_htab_fd(void)
-{
-    return cap_htab_fd;
-}
-
 bool kvmppc_has_cap_fixup_hcalls(void)
 {
     return cap_fixup_hcalls;
diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index f780e6ec7b..08aab46c5a 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -51,7 +51,6 @@ uint64_t kvmppc_rma_size(uint64_t current_size, unsigned int hash_shift);
 #endif /* !CONFIG_USER_ONLY */
 bool kvmppc_has_cap_epr(void);
 int kvmppc_define_rtas_kernel_token(uint32_t token, const char *function);
-bool kvmppc_has_cap_htab_fd(void);
 int kvmppc_get_htab_fd(bool write);
 int kvmppc_save_htab(QEMUFile *f, int fd, size_t bufsize, int64_t max_ns);
 int kvmppc_load_htab_chunk(QEMUFile *f, int fd, uint32_t index,
@@ -246,11 +245,6 @@ static inline int kvmppc_define_rtas_kernel_token(uint32_t token,
     return -1;
 }
 
-static inline bool kvmppc_has_cap_htab_fd(void)
-{
-    return false;
-}
-
 static inline int kvmppc_get_htab_fd(bool write)
 {
     return -1;
-- 
2.13.5
