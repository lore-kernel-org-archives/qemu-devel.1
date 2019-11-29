Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B60C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 01:55:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B5812075C
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 01:55:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="iRRivz4D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B5812075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaVVh-000194-L1
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 20:55:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56363)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iaVBs-0002Xs-0t
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 20:35:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iaVBm-0003Mr-VP
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 20:35:20 -0500
Received: from ozlabs.org ([203.11.71.1]:36763)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iaVBj-0002uq-S3; Thu, 28 Nov 2019 20:35:17 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47PHBM6Kxjz9sPZ; Fri, 29 Nov 2019 12:35:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1574991307;
 bh=Z/RibPu8alRi+iP9uoUSxLDuw1fy/hPaLz1Ra2kT/A0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=iRRivz4Dq5pCz48wFsIPSE+se8SxY9btGQUC619DnFFabYKU7D0AekgIQQMevj6l7
 gFpyYI8vAr1BbVIu1rtrakQMLhxHrIaFjoo9P7T5625pyCzcOPFpJH4X1AyTH73TlP
 yfEJbKaHknnz/SfunkY/xrHCjJvZBAqRS22lzhIQ=
From: David Gibson <david@gibson.dropbear.id.au>
To: groug@kaod.org,
	clg@kaod.org
Subject: [for-5.0 1/4] spapr,ppc: Simplify signature of kvmppc_rma_size()
Date: Fri, 29 Nov 2019 12:35:01 +1100
Message-Id: <20191129013504.145455-2-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191129013504.145455-1-david@gibson.dropbear.id.au>
References: <20191129013504.145455-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: aik@ozlabs.ru, lvivier@redhat.com, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This function calculates the maximum size of the RMA as implied by the
host's page size of structure of the VRMA (there are a number of other
constraints on the RMA size which will supersede this one in many
circumstances).

The current interface takes the current RMA size estimate, and clamps it
to the VRMA derived size.  The only current caller passes in an arguably
wrong value (it will match the current RMA estimate in some but not all
cases).

We want to fix that, but for now just keep concerns separated by having t=
he
KVM helper function just return the VRMA derived limit, and let the calle=
r
combine it with other constraints.  We call the new function
kvmppc_vrma_limit() to more clearly indicate its limited responsibility.

The helper should only ever be called in the KVM enabled case, so replace
its !CONFIG_KVM stub with an assert() rather than a dummy value.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c       | 5 +++--
 target/ppc/kvm.c     | 5 ++---
 target/ppc/kvm_ppc.h | 7 +++----
 3 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index d9c9a2bcee..069bd04a8d 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1635,8 +1635,9 @@ void spapr_setup_hpt_and_vrma(SpaprMachineState *sp=
apr)
     spapr_reallocate_hpt(spapr, hpt_shift, &error_fatal);
=20
     if (spapr->vrma_adjust) {
-        spapr->rma_size =3D kvmppc_rma_size(spapr_node0_size(MACHINE(spa=
pr)),
-                                          spapr->htab_shift);
+        hwaddr vrma_limit =3D kvmppc_vrma_limit(spapr->htab_shift);
+
+        spapr->rma_size =3D MIN(spapr_node0_size(MACHINE(spapr)), vrma_l=
imit);
     }
 }
=20
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index c77f9848ec..09b3bd6443 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2101,7 +2101,7 @@ void kvmppc_hint_smt_possible(Error **errp)
=20
=20
 #ifdef TARGET_PPC64
-uint64_t kvmppc_rma_size(uint64_t current_size, unsigned int hash_shift)
+uint64_t kvmppc_vrma_limit(unsigned int hash_shift)
 {
     struct kvm_ppc_smmu_info info;
     long rampagesize, best_page_shift;
@@ -2128,8 +2128,7 @@ uint64_t kvmppc_rma_size(uint64_t current_size, uns=
igned int hash_shift)
         }
     }
=20
-    return MIN(current_size,
-               1ULL << (best_page_shift + hash_shift - 7));
+    return 1ULL << (best_page_shift + hash_shift - 7));
 }
 #endif
=20
diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index 98bd7d5da6..4f0eec4c1b 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -45,7 +45,7 @@ void *kvmppc_create_spapr_tce(uint32_t liobn, uint32_t =
page_shift,
                               int *pfd, bool need_vfio);
 int kvmppc_remove_spapr_tce(void *table, int pfd, uint32_t window_size);
 int kvmppc_reset_htab(int shift_hint);
-uint64_t kvmppc_rma_size(uint64_t current_size, unsigned int hash_shift)=
;
+uint64_t kvmppc_vrma_limit(unsigned int hash_shift);
 bool kvmppc_has_cap_spapr_vfio(void);
 #endif /* !CONFIG_USER_ONLY */
 bool kvmppc_has_cap_epr(void);
@@ -241,10 +241,9 @@ static inline int kvmppc_reset_htab(int shift_hint)
     return 0;
 }
=20
-static inline uint64_t kvmppc_rma_size(uint64_t current_size,
-                                       unsigned int hash_shift)
+static inline uint64_t kvmppc_vrma_limit(unsigned int hash_shift)
 {
-    return ram_size;
+    g_assert_not_reached();
 }
=20
 static inline bool kvmppc_hpt_needs_host_contiguous_pages(void)
--=20
2.23.0


