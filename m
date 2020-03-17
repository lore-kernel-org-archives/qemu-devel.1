Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 413E5C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:06:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E850205ED
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="BrE2U5+Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E850205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE97a-0003hm-6h
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 06:06:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45062)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jE95c-0000oA-9u
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:04:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jE95a-0001qj-Bh
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:04:48 -0400
Received: from ozlabs.org ([203.11.71.1]:38101)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jE95Z-0001G2-Q7; Tue, 17 Mar 2020 06:04:46 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48hTKv6Vs5z9sSM; Tue, 17 Mar 2020 21:04:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1584439475;
 bh=UOHF20krMv8ludcowjauA+f5cObH+ONZIZJKweMcMpU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=BrE2U5+QiThVGTKJDh588HDXjSpLix7anN3Y50zi/TRMMkFzKpQPXkKSONwzt1jeF
 8Q2wWOcVRgTsADzRl7/3xzjyuoQ2Aje6mi3XfuvRXEO63+xanRf0CoB/1di7Guc3dw
 +323DBbaPS/5Z8l/875/hLuxzwF4+nWP06d4JGz4=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 06/45] ppc: Remove stub support for 32-bit hypervisor mode
Date: Tue, 17 Mar 2020 21:03:44 +1100
Message-Id: <20200317100423.622643-7-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317100423.622643-1-david@gibson.dropbear.id.au>
References: <20200317100423.622643-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: lvivier@redhat.com, Fabiano Rosas <farosas@linux.ibm.com>, aik@ozlabs.ru,
 mdroth@linux.vnet.ibm.com, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

a4f30719a8cd, way back in 2007 noted that "PowerPC hypervisor mode is not
fundamentally available only for PowerPC 64" and added a 32-bit version
of the MSR[HV] bit.

But nothing was ever really done with that; there is no meaningful suppor=
t
for 32-bit hypervisor mode 13 years later.  Let's stop pretending and jus=
t
remove the stubs.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Fabiano Rosas <farosas@linux.ibm.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 target/ppc/cpu.h                | 21 +++++++--------------
 target/ppc/translate_init.inc.c |  6 +++---
 2 files changed, 10 insertions(+), 17 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index b283042515..8077fdb068 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -24,8 +24,6 @@
 #include "exec/cpu-defs.h"
 #include "cpu-qom.h"
=20
-/* #define PPC_EMULATE_32BITS_HYPV */
-
 #define TCG_GUEST_DEFAULT_MO 0
=20
 #define TARGET_PAGE_BITS_64K 16
@@ -300,13 +298,12 @@ typedef struct ppc_v3_pate_t {
 #define MSR_SF   63 /* Sixty-four-bit mode                            hf=
lags */
 #define MSR_TAG  62 /* Tag-active mode (POWERx ?)                       =
     */
 #define MSR_ISF  61 /* Sixty-four-bit interrupt mode on 630             =
     */
-#define MSR_SHV  60 /* hypervisor state                               hf=
lags */
+#define MSR_HV   60 /* hypervisor state                               hf=
lags */
 #define MSR_TS0  34 /* Transactional state, 2 bits (Book3s)             =
     */
 #define MSR_TS1  33
 #define MSR_TM   32 /* Transactional Memory Available (Book3s)          =
     */
 #define MSR_CM   31 /* Computation mode for BookE                     hf=
lags */
 #define MSR_ICM  30 /* Interrupt computation mode for BookE             =
     */
-#define MSR_THV  29 /* hypervisor state for 32 bits PowerPC           hf=
lags */
 #define MSR_GS   28 /* guest state for BookE                            =
     */
 #define MSR_UCLE 26 /* User-mode cache lock enable for BookE            =
     */
 #define MSR_VR   25 /* altivec available                            x hf=
lags */
@@ -401,10 +398,13 @@ typedef struct ppc_v3_pate_t {
=20
 #define msr_sf   ((env->msr >> MSR_SF)   & 1)
 #define msr_isf  ((env->msr >> MSR_ISF)  & 1)
-#define msr_shv  ((env->msr >> MSR_SHV)  & 1)
+#if defined(TARGET_PPC64)
+#define msr_hv   ((env->msr >> MSR_HV)   & 1)
+#else
+#define msr_hv   (0)
+#endif
 #define msr_cm   ((env->msr >> MSR_CM)   & 1)
 #define msr_icm  ((env->msr >> MSR_ICM)  & 1)
-#define msr_thv  ((env->msr >> MSR_THV)  & 1)
 #define msr_gs   ((env->msr >> MSR_GS)   & 1)
 #define msr_ucle ((env->msr >> MSR_UCLE) & 1)
 #define msr_vr   ((env->msr >> MSR_VR)   & 1)
@@ -449,16 +449,9 @@ typedef struct ppc_v3_pate_t {
=20
 /* Hypervisor bit is more specific */
 #if defined(TARGET_PPC64)
-#define MSR_HVB (1ULL << MSR_SHV)
-#define msr_hv  msr_shv
-#else
-#if defined(PPC_EMULATE_32BITS_HYPV)
-#define MSR_HVB (1ULL << MSR_THV)
-#define msr_hv  msr_thv
+#define MSR_HVB (1ULL << MSR_HV)
 #else
 #define MSR_HVB (0ULL)
-#define msr_hv  (0)
-#endif
 #endif
=20
 /* DSISR */
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.=
inc.c
index 2f7125c51f..df3401cf06 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -8764,7 +8764,7 @@ POWERPC_FAMILY(POWER8)(ObjectClass *oc, void *data)
                         PPC2_ISA205 | PPC2_ISA207S | PPC2_FP_CVT_S64 |
                         PPC2_TM | PPC2_PM_ISA206;
     pcc->msr_mask =3D (1ull << MSR_SF) |
-                    (1ull << MSR_SHV) |
+                    (1ull << MSR_HV) |
                     (1ull << MSR_TM) |
                     (1ull << MSR_VR) |
                     (1ull << MSR_VSX) |
@@ -8976,7 +8976,7 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *data)
                         PPC2_ISA205 | PPC2_ISA207S | PPC2_FP_CVT_S64 |
                         PPC2_TM | PPC2_ISA300 | PPC2_PRCNTL;
     pcc->msr_mask =3D (1ull << MSR_SF) |
-                    (1ull << MSR_SHV) |
+                    (1ull << MSR_HV) |
                     (1ull << MSR_TM) |
                     (1ull << MSR_VR) |
                     (1ull << MSR_VSX) |
@@ -9186,7 +9186,7 @@ POWERPC_FAMILY(POWER10)(ObjectClass *oc, void *data=
)
                         PPC2_ISA205 | PPC2_ISA207S | PPC2_FP_CVT_S64 |
                         PPC2_TM | PPC2_ISA300 | PPC2_PRCNTL;
     pcc->msr_mask =3D (1ull << MSR_SF) |
-                    (1ull << MSR_SHV) |
+                    (1ull << MSR_HV) |
                     (1ull << MSR_TM) |
                     (1ull << MSR_VR) |
                     (1ull << MSR_VSX) |
--=20
2.24.1


