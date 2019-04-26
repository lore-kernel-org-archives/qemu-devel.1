Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3AA8C43219
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 06:26:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 705BD206BA
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 06:26:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="D+Pnd6VI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 705BD206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40206 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJuJU-0008Ij-Jh
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 02:26:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu0x-0005zx-R3
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:07:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu0t-00051H-TS
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:07:14 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:54057 helo=ozlabs.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hJu0t-0004QE-7y; Fri, 26 Apr 2019 02:07:11 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 44r3Tn3bgCz9sNd; Fri, 26 Apr 2019 16:06:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1556258797;
	bh=is5dGuFEToTkSsfunuJwecq+HsApUZ8X/TgEZDIK2X8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D+Pnd6VILAYpphJsJJNQsk1gJbiF0JhFC+SOxy5HEQa08TxfQEDyKa0ZNR6MNfzq6
	qkpUIymxdFJx5OOBa1VuwJ1gT2j5XHT0aob5cfnm9Q2rIlOb05fnLydphZiw5V3rX6
	ZMmT32QEHmRmn7lJI5NmuKdiFzIMALZ42ZOsKT0A=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Fri, 26 Apr 2019 16:06:10 +1000
Message-Id: <20190426060627.18153-20-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190426060627.18153-1-david@gibson.dropbear.id.au>
References: <20190426060627.18153-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: [Qemu-devel] [PULL 19/36] target/ppc: Style fixes for
 mmu-hash64.[ch]
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
Message-ID: <20190426060610._RrbGeQio08eE2B2nU0pruD7dzHmeJLYXqiO5HZ74xE@z>

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 target/ppc/mmu-hash64.c | 68 +++++++++++++++++++++++++----------------
 1 file changed, 42 insertions(+), 26 deletions(-)

diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index 214149f65b..c74818b2e7 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -30,7 +30,7 @@
 #include "hw/hw.h"
 #include "mmu-book3s-v3.h"
=20
-//#define DEBUG_SLB
+/* #define DEBUG_SLB */
=20
 #ifdef DEBUG_SLB
 #  define LOG_SLB(...) qemu_log_mask(CPU_LOG_MMU, __VA_ARGS__)
@@ -58,9 +58,11 @@ static ppc_slb_t *slb_lookup(PowerPCCPU *cpu, target_u=
long eaddr)
=20
         LOG_SLB("%s: slot %d %016" PRIx64 " %016"
                     PRIx64 "\n", __func__, n, slb->esid, slb->vsid);
-        /* We check for 1T matches on all MMUs here - if the MMU
+        /*
+         * We check for 1T matches on all MMUs here - if the MMU
          * doesn't have 1T segment support, we will have prevented 1T
-         * entries from being inserted in the slbmte code. */
+         * entries from being inserted in the slbmte code.
+         */
         if (((slb->esid =3D=3D esid_256M) &&
              ((slb->vsid & SLB_VSID_B) =3D=3D SLB_VSID_B_256M))
             || ((slb->esid =3D=3D esid_1T) &&
@@ -103,7 +105,8 @@ void helper_slbia(CPUPPCState *env)
=20
         if (slb->esid & SLB_ESID_V) {
             slb->esid &=3D ~SLB_ESID_V;
-            /* XXX: given the fact that segment size is 256 MB or 1TB,
+            /*
+             * XXX: given the fact that segment size is 256 MB or 1TB,
              *      and we still don't have a tlb_flush_mask(env, n, mas=
k)
              *      in QEMU, we just invalidate all TLBs
              */
@@ -126,7 +129,8 @@ static void __helper_slbie(CPUPPCState *env, target_u=
long addr,
     if (slb->esid & SLB_ESID_V) {
         slb->esid &=3D ~SLB_ESID_V;
=20
-        /* XXX: given the fact that segment size is 256 MB or 1TB,
+        /*
+         * XXX: given the fact that segment size is 256 MB or 1TB,
          *      and we still don't have a tlb_flush_mask(env, n, mask)
          *      in QEMU, we just invalidate all TLBs
          */
@@ -306,8 +310,10 @@ static int ppc_hash64_pte_prot(PowerPCCPU *cpu,
 {
     CPUPPCState *env =3D &cpu->env;
     unsigned pp, key;
-    /* Some pp bit combinations have undefined behaviour, so default
-     * to no access in those cases */
+    /*
+     * Some pp bit combinations have undefined behaviour, so default
+     * to no access in those cases
+     */
     int prot =3D 0;
=20
     key =3D !!(msr_pr ? (slb->vsid & SLB_VSID_KP)
@@ -376,7 +382,7 @@ static int ppc_hash64_amr_prot(PowerPCCPU *cpu, ppc_h=
ash_pte64_t pte)
     }
=20
     key =3D HPTE64_R_KEY(pte.pte1);
-    amrbits =3D (env->spr[SPR_AMR] >> 2*(31 - key)) & 0x3;
+    amrbits =3D (env->spr[SPR_AMR] >> 2 * (31 - key)) & 0x3;
=20
     /* fprintf(stderr, "AMR protection: key=3D%d AMR=3D0x%" PRIx64 "\n",=
 key, */
     /*         env->spr[SPR_AMR]); */
@@ -547,8 +553,9 @@ static hwaddr ppc_hash64_pteg_search(PowerPCCPU *cpu,=
 hwaddr hash,
             if (*pshift =3D=3D 0) {
                 continue;
             }
-            /* We don't do anything with pshift yet as qemu TLB only dea=
ls
-             * with 4K pages anyway
+            /*
+             * We don't do anything with pshift yet as qemu TLB only
+             * deals with 4K pages anyway
              */
             pte->pte0 =3D pte0;
             pte->pte1 =3D pte1;
@@ -572,8 +579,10 @@ static hwaddr ppc_hash64_htab_lookup(PowerPCCPU *cpu=
,
     uint64_t vsid, epnmask, epn, ptem;
     const PPCHash64SegmentPageSizes *sps =3D slb->sps;
=20
-    /* The SLB store path should prevent any bad page size encodings
-     * getting in there, so: */
+    /*
+     * The SLB store path should prevent any bad page size encodings
+     * getting in there, so:
+     */
     assert(sps);
=20
     /* If ISL is set in LPCR we need to clamp the page size to 4K */
@@ -732,17 +741,20 @@ int ppc_hash64_handle_mmu_fault(PowerPCCPU *cpu, va=
ddr eaddr,
=20
     assert((rwx =3D=3D 0) || (rwx =3D=3D 1) || (rwx =3D=3D 2));
=20
-    /* Note on LPCR usage: 970 uses HID4, but our special variant
-     * of store_spr copies relevant fields into env->spr[SPR_LPCR].
-     * Similarily we filter unimplemented bits when storing into
-     * LPCR depending on the MMU version. This code can thus just
-     * use the LPCR "as-is".
+    /*
+     * Note on LPCR usage: 970 uses HID4, but our special variant of
+     * store_spr copies relevant fields into env->spr[SPR_LPCR].
+     * Similarily we filter unimplemented bits when storing into LPCR
+     * depending on the MMU version. This code can thus just use the
+     * LPCR "as-is".
      */
=20
     /* 1. Handle real mode accesses */
     if (((rwx =3D=3D 2) && (msr_ir =3D=3D 0)) || ((rwx !=3D 2) && (msr_d=
r =3D=3D 0))) {
-        /* Translation is supposedly "off"  */
-        /* In real mode the top 4 effective address bits are (mostly) ig=
nored */
+        /*
+         * Translation is supposedly "off", but in real mode the top 4
+         * effective address bits are (mostly) ignored
+         */
         raddr =3D eaddr & 0x0FFFFFFFFFFFFFFFULL;
=20
         /* In HV mode, add HRMOR if top EA bit is clear */
@@ -875,8 +887,10 @@ skip_slb_search:
     if (rwx =3D=3D 1) {
         new_pte1 |=3D HPTE64_R_C; /* set changed (dirty) bit */
     } else {
-        /* Treat the page as read-only for now, so that a later write
-         * will pass through this function again to set the C bit */
+        /*
+         * Treat the page as read-only for now, so that a later write
+         * will pass through this function again to set the C bit
+         */
         prot &=3D ~PAGE_WRITE;
     }
=20
@@ -1023,8 +1037,9 @@ static void ppc_hash64_update_vrma(PowerPCCPU *cpu)
         return;
     }
=20
-    /* Make one up. Mostly ignore the ESID which will not be
-     * needed for translation
+    /*
+     * Make one up. Mostly ignore the ESID which will not be needed
+     * for translation
      */
     vsid =3D SLB_VSID_VRMA;
     vrmasd =3D (lpcr & LPCR_VRMASD) >> LPCR_VRMASD_SHIFT;
@@ -1080,11 +1095,12 @@ void ppc_store_lpcr(PowerPCCPU *cpu, target_ulong=
 val)
         }
         env->spr[SPR_RMOR] =3D ((lpcr >> 41) & 0xffffull) << 26;
=20
-        /* XXX We could also write LPID from HID4 here
+        /*
+         * XXX We could also write LPID from HID4 here
          * but since we don't tag any translation on it
          * it doesn't actually matter
-         */
-        /* XXX For proper emulation of 970 we also need
+         *
+         * XXX For proper emulation of 970 we also need
          * to dig HRMOR out of HID5
          */
         break;
--=20
2.20.1


