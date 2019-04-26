Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90655C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 06:26:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4668C20675
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 06:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="M3yqn0Eh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4668C20675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40210 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJuJj-0000Ia-Eo
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 02:26:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu0c-0005ZU-Ou
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:07:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu0Z-0004Ue-3l
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:06:54 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:50549 helo=ozlabs.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hJu0Y-0004P3-BB; Fri, 26 Apr 2019 02:06:50 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 44r3Tm5YrQz9sNN; Fri, 26 Apr 2019 16:06:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1556258796;
	bh=309aFk9SXYG7E9iwhdtgcB8ry2sYHaMEp12uAsQ7BGg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M3yqn0EhLbeAhrqo7AaUgOYD4r9CYvVIQoxFXaoGNs82K+uqu/nBpz0lqtEADjIn0
	Cac5EOQGZutkM32HdqLXn+G4DCP3THstPhZlUJeExUOLse+/F0PKF++QN4qmib74p5
	P4+i0deDFK3aVm+gIPei20mHYN3ARIj5oRLEqRl8=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Fri, 26 Apr 2019 16:06:05 +1000
Message-Id: <20190426060627.18153-15-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190426060627.18153-1-david@gibson.dropbear.id.au>
References: <20190426060627.18153-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: [Qemu-devel] [PULL 14/36] target/ppc: Style fixes for machine.c
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: gkurz@kaod.org, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org,
	qemu-ppc@nongnu.org, clg@kaod.org,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190426060605.zd7jxxXBfkwiWmuihopDPAlgnJcVlY1m9q4np9D1vfE@z>

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 target/ppc/machine.c | 106 +++++++++++++++++++++++++------------------
 1 file changed, 63 insertions(+), 43 deletions(-)

diff --git a/target/ppc/machine.c b/target/ppc/machine.c
index a92d0ad3a3..25cdb9088b 100644
--- a/target/ppc/machine.c
+++ b/target/ppc/machine.c
@@ -24,22 +24,26 @@ static int cpu_load_old(QEMUFile *f, void *opaque, in=
t version_id)
 #endif
     target_ulong xer;
=20
-    for (i =3D 0; i < 32; i++)
+    for (i =3D 0; i < 32; i++) {
         qemu_get_betls(f, &env->gpr[i]);
+    }
 #if !defined(TARGET_PPC64)
-    for (i =3D 0; i < 32; i++)
+    for (i =3D 0; i < 32; i++) {
         qemu_get_betls(f, &env->gprh[i]);
+    }
 #endif
     qemu_get_betls(f, &env->lr);
     qemu_get_betls(f, &env->ctr);
-    for (i =3D 0; i < 8; i++)
+    for (i =3D 0; i < 8; i++) {
         qemu_get_be32s(f, &env->crf[i]);
+    }
     qemu_get_betls(f, &xer);
     cpu_write_xer(env, xer);
     qemu_get_betls(f, &env->reserve_addr);
     qemu_get_betls(f, &env->msr);
-    for (i =3D 0; i < 4; i++)
+    for (i =3D 0; i < 4; i++) {
         qemu_get_betls(f, &env->tgpr[i]);
+    }
     for (i =3D 0; i < 32; i++) {
         union {
             float64 d;
@@ -56,14 +60,19 @@ static int cpu_load_old(QEMUFile *f, void *opaque, in=
t version_id)
     qemu_get_sbe32s(f, &slb_nr);
 #endif
     qemu_get_betls(f, &sdr1);
-    for (i =3D 0; i < 32; i++)
+    for (i =3D 0; i < 32; i++) {
         qemu_get_betls(f, &env->sr[i]);
-    for (i =3D 0; i < 2; i++)
-        for (j =3D 0; j < 8; j++)
+    }
+    for (i =3D 0; i < 2; i++) {
+        for (j =3D 0; j < 8; j++) {
             qemu_get_betls(f, &env->DBAT[i][j]);
-    for (i =3D 0; i < 2; i++)
-        for (j =3D 0; j < 8; j++)
+        }
+    }
+    for (i =3D 0; i < 2; i++) {
+        for (j =3D 0; j < 8; j++) {
             qemu_get_betls(f, &env->IBAT[i][j]);
+        }
+    }
     qemu_get_sbe32s(f, &env->nb_tlb);
     qemu_get_sbe32s(f, &env->tlb_per_way);
     qemu_get_sbe32s(f, &env->nb_ways);
@@ -71,17 +80,19 @@ static int cpu_load_old(QEMUFile *f, void *opaque, in=
t version_id)
     qemu_get_sbe32s(f, &env->id_tlbs);
     qemu_get_sbe32s(f, &env->nb_pids);
     if (env->tlb.tlb6) {
-        // XXX assumes 6xx
+        /* XXX assumes 6xx */
         for (i =3D 0; i < env->nb_tlb; i++) {
             qemu_get_betls(f, &env->tlb.tlb6[i].pte0);
             qemu_get_betls(f, &env->tlb.tlb6[i].pte1);
             qemu_get_betls(f, &env->tlb.tlb6[i].EPN);
         }
     }
-    for (i =3D 0; i < 4; i++)
+    for (i =3D 0; i < 4; i++) {
         qemu_get_betls(f, &env->pb[i]);
-    for (i =3D 0; i < 1024; i++)
+    }
+    for (i =3D 0; i < 1024; i++) {
         qemu_get_betls(f, &env->spr[i]);
+    }
     if (!cpu->vhyp) {
         ppc_store_sdr1(env, sdr1);
     }
@@ -94,8 +105,9 @@ static int cpu_load_old(QEMUFile *f, void *opaque, int=
 version_id)
     qemu_get_sbe32s(f, &env->error_code);
     qemu_get_be32s(f, &env->pending_interrupts);
     qemu_get_be32s(f, &env->irq_input_state);
-    for (i =3D 0; i < POWERPC_EXCP_NB; i++)
+    for (i =3D 0; i < POWERPC_EXCP_NB; i++) {
         qemu_get_betls(f, &env->excp_vectors[i]);
+    }
     qemu_get_betls(f, &env->excp_prefix);
     qemu_get_betls(f, &env->ivor_mask);
     qemu_get_betls(f, &env->ivpr_mask);
@@ -253,22 +265,24 @@ static int cpu_pre_save(void *opaque)
     env->spr[SPR_BOOKE_SPEFSCR] =3D env->spe_fscr;
=20
     for (i =3D 0; (i < 4) && (i < env->nb_BATs); i++) {
-        env->spr[SPR_DBAT0U + 2*i] =3D env->DBAT[0][i];
-        env->spr[SPR_DBAT0U + 2*i + 1] =3D env->DBAT[1][i];
-        env->spr[SPR_IBAT0U + 2*i] =3D env->IBAT[0][i];
-        env->spr[SPR_IBAT0U + 2*i + 1] =3D env->IBAT[1][i];
+        env->spr[SPR_DBAT0U + 2 * i] =3D env->DBAT[0][i];
+        env->spr[SPR_DBAT0U + 2 * i + 1] =3D env->DBAT[1][i];
+        env->spr[SPR_IBAT0U + 2 * i] =3D env->IBAT[0][i];
+        env->spr[SPR_IBAT0U + 2 * i + 1] =3D env->IBAT[1][i];
     }
-    for (i =3D 0; (i < 4) && ((i+4) < env->nb_BATs); i++) {
-        env->spr[SPR_DBAT4U + 2*i] =3D env->DBAT[0][i+4];
-        env->spr[SPR_DBAT4U + 2*i + 1] =3D env->DBAT[1][i+4];
-        env->spr[SPR_IBAT4U + 2*i] =3D env->IBAT[0][i+4];
-        env->spr[SPR_IBAT4U + 2*i + 1] =3D env->IBAT[1][i+4];
+    for (i =3D 0; (i < 4) && ((i + 4) < env->nb_BATs); i++) {
+        env->spr[SPR_DBAT4U + 2 * i] =3D env->DBAT[0][i + 4];
+        env->spr[SPR_DBAT4U + 2 * i + 1] =3D env->DBAT[1][i + 4];
+        env->spr[SPR_IBAT4U + 2 * i] =3D env->IBAT[0][i + 4];
+        env->spr[SPR_IBAT4U + 2 * i + 1] =3D env->IBAT[1][i + 4];
     }
=20
     /* Hacks for migration compatibility between 2.6, 2.7 & 2.8 */
     if (cpu->pre_2_8_migration) {
-        /* Mask out bits that got added to msr_mask since the versions
-         * which stupidly included it in the migration stream. */
+        /*
+         * Mask out bits that got added to msr_mask since the versions
+         * which stupidly included it in the migration stream.
+         */
         target_ulong metamask =3D 0
 #if defined(TARGET_PPC64)
             | (1ULL << MSR_TS0)
@@ -277,9 +291,10 @@ static int cpu_pre_save(void *opaque)
             ;
         cpu->mig_msr_mask =3D env->msr_mask & ~metamask;
         cpu->mig_insns_flags =3D env->insns_flags & insns_compat_mask;
-        /* CPU models supported by old machines all have PPC_MEM_TLBIE,
-         * so we set it unconditionally to allow backward migration from
-         * a POWER9 host to a POWER8 host.
+        /*
+         * CPU models supported by old machines all have
+         * PPC_MEM_TLBIE, so we set it unconditionally to allow
+         * backward migration from a POWER9 host to a POWER8 host.
          */
         cpu->mig_insns_flags |=3D PPC_MEM_TLBIE;
         cpu->mig_insns_flags2 =3D env->insns_flags2 & insns_compat_mask2=
;
@@ -379,23 +394,26 @@ static int cpu_post_load(void *opaque, int version_=
id)
     env->spe_fscr =3D env->spr[SPR_BOOKE_SPEFSCR];
=20
     for (i =3D 0; (i < 4) && (i < env->nb_BATs); i++) {
-        env->DBAT[0][i] =3D env->spr[SPR_DBAT0U + 2*i];
-        env->DBAT[1][i] =3D env->spr[SPR_DBAT0U + 2*i + 1];
-        env->IBAT[0][i] =3D env->spr[SPR_IBAT0U + 2*i];
-        env->IBAT[1][i] =3D env->spr[SPR_IBAT0U + 2*i + 1];
+        env->DBAT[0][i] =3D env->spr[SPR_DBAT0U + 2 * i];
+        env->DBAT[1][i] =3D env->spr[SPR_DBAT0U + 2 * i + 1];
+        env->IBAT[0][i] =3D env->spr[SPR_IBAT0U + 2 * i];
+        env->IBAT[1][i] =3D env->spr[SPR_IBAT0U + 2 * i + 1];
     }
-    for (i =3D 0; (i < 4) && ((i+4) < env->nb_BATs); i++) {
-        env->DBAT[0][i+4] =3D env->spr[SPR_DBAT4U + 2*i];
-        env->DBAT[1][i+4] =3D env->spr[SPR_DBAT4U + 2*i + 1];
-        env->IBAT[0][i+4] =3D env->spr[SPR_IBAT4U + 2*i];
-        env->IBAT[1][i+4] =3D env->spr[SPR_IBAT4U + 2*i + 1];
+    for (i =3D 0; (i < 4) && ((i + 4) < env->nb_BATs); i++) {
+        env->DBAT[0][i + 4] =3D env->spr[SPR_DBAT4U + 2 * i];
+        env->DBAT[1][i + 4] =3D env->spr[SPR_DBAT4U + 2 * i + 1];
+        env->IBAT[0][i + 4] =3D env->spr[SPR_IBAT4U + 2 * i];
+        env->IBAT[1][i + 4] =3D env->spr[SPR_IBAT4U + 2 * i + 1];
     }
=20
     if (!cpu->vhyp) {
         ppc_store_sdr1(env, env->spr[SPR_SDR1]);
     }
=20
-    /* Invalidate all supported msr bits except MSR_TGPR/MSR_HVB before =
restoring */
+    /*
+     * Invalidate all supported msr bits except MSR_TGPR/MSR_HVB
+     * before restoring
+     */
     msr =3D env->msr;
     env->msr ^=3D env->msr_mask & ~((1ULL << MSR_TGPR) | MSR_HVB);
     ppc_store_msr(env, msr);
@@ -409,7 +427,7 @@ static bool fpu_needed(void *opaque)
 {
     PowerPCCPU *cpu =3D opaque;
=20
-    return (cpu->env.insns_flags & PPC_FLOAT);
+    return cpu->env.insns_flags & PPC_FLOAT;
 }
=20
 static const VMStateDescription vmstate_fpu =3D {
@@ -428,7 +446,7 @@ static bool altivec_needed(void *opaque)
 {
     PowerPCCPU *cpu =3D opaque;
=20
-    return (cpu->env.insns_flags & PPC_ALTIVEC);
+    return cpu->env.insns_flags & PPC_ALTIVEC;
 }
=20
 static int get_vscr(QEMUFile *f, void *opaque, size_t size,
@@ -483,7 +501,7 @@ static bool vsx_needed(void *opaque)
 {
     PowerPCCPU *cpu =3D opaque;
=20
-    return (cpu->env.insns_flags2 & PPC2_VSX);
+    return cpu->env.insns_flags2 & PPC2_VSX;
 }
=20
 static const VMStateDescription vmstate_vsx =3D {
@@ -591,7 +609,7 @@ static bool slb_needed(void *opaque)
     PowerPCCPU *cpu =3D opaque;
=20
     /* We don't support any of the old segment table based 64-bit CPUs *=
/
-    return (cpu->env.mmu_model & POWERPC_MMU_64);
+    return cpu->env.mmu_model & POWERPC_MMU_64;
 }
=20
 static int slb_post_load(void *opaque, int version_id)
@@ -600,8 +618,10 @@ static int slb_post_load(void *opaque, int version_i=
d)
     CPUPPCState *env =3D &cpu->env;
     int i;
=20
-    /* We've pulled in the raw esid and vsid values from the migration
-     * stream, but we need to recompute the page size pointers */
+    /*
+     * We've pulled in the raw esid and vsid values from the migration
+     * stream, but we need to recompute the page size pointers
+     */
     for (i =3D 0; i < cpu->hash64_opts->slb_size; i++) {
         if (ppc_store_slb(cpu, i, env->slb[i].esid, env->slb[i].vsid) < =
0) {
             /* Migration source had bad values in its SLB */
--=20
2.20.1


