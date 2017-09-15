Received: from eggs.gnu.org ([2001:4830:134:3::10]:41913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dsqTO-0002W6-7W
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 09:15:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dsqTN-0003qK-Bv
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 09:15:58 -0400
Received: from 2.mo2.mail-out.ovh.net ([188.165.53.149]:41416)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dsqTN-0003q5-5R
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 09:15:57 -0400
Received: from player770.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 1A6D4A3035
	for <qemu-devel@nongnu.org>; Fri, 15 Sep 2017 15:15:56 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Fri, 15 Sep 2017 15:15:51 +0200
Message-ID: <150548135159.5945.17545667206379508322.stgit@bahia.lan>
In-Reply-To: <150548133297.5945.7401220081077343726.stgit@bahia.lan>
References: <150548133297.5945.7401220081077343726.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 1/4] ppc/kvm: drop kvmppc_has_cap_htab_fd()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>

It never got used since its introduction (commit 7c43bca004af).

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 target/ppc/kvm.c     |    5 -----
 target/ppc/kvm_ppc.h |    6 ------
 2 files changed, 11 deletions(-)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 1deaf106d2b9..00d7029b8d7a 100644
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
index f780e6ec7b72..08aab46c5a56 100644
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
