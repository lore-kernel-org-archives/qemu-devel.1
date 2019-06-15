Return-Path: <SRS0=kcoF=UO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D39C31E50
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Jun 2019 15:59:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99D3921473
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Jun 2019 15:59:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99D3921473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32998 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcB5q-0001Y0-TF
	for qemu-devel@archiver.kernel.org; Sat, 15 Jun 2019 11:59:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35709)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hcAqr-0003v4-Ib
 for qemu-devel@nongnu.org; Sat, 15 Jun 2019 11:44:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hcAqp-0000GP-AW
 for qemu-devel@nongnu.org; Sat, 15 Jun 2019 11:44:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35456)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hcAqj-0008HD-9m; Sat, 15 Jun 2019 11:44:15 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E6B953082E1F;
 Sat, 15 Jun 2019 15:44:10 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-41.brq.redhat.com [10.40.204.41])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A8378106F752;
 Sat, 15 Jun 2019 15:44:09 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Sat, 15 Jun 2019 17:43:36 +0200
Message-Id: <20190615154352.26824-8-philmd@redhat.com>
In-Reply-To: <20190615154352.26824-1-philmd@redhat.com>
References: <20190615154352.26824-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Sat, 15 Jun 2019 15:44:10 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 07/23] target/arm: Declare some function
 publicly
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In few commits we will split the v7-M functions from this file.
Some function will be called out of helper.c. Declare them
in the "internals.h" header.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 target/arm/helper.c    | 69 +++++++++++++-----------------------------
 target/arm/internals.h | 45 +++++++++++++++++++++++++++
 2 files changed, 66 insertions(+), 48 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 9a3766b759..a1e74cc471 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -35,17 +35,6 @@
 #define ARM_CPU_FREQ 1000000000 /* FIXME: 1 GHz, should be configurable =
*/
=20
 #ifndef CONFIG_USER_ONLY
-/* Cacheability and shareability attributes for a memory access */
-typedef struct ARMCacheAttrs {
-    unsigned int attrs:8; /* as in the MAIR register encoding */
-    unsigned int shareability:2; /* as in the SH field of the VMSAv8-64 =
PTEs */
-} ARMCacheAttrs;
-
-static bool get_phys_addr(CPUARMState *env, target_ulong address,
-                          MMUAccessType access_type, ARMMMUIdx mmu_idx,
-                          hwaddr *phys_ptr, MemTxAttrs *attrs, int *prot=
,
-                          target_ulong *page_size,
-                          ARMMMUFaultInfo *fi, ARMCacheAttrs *cacheattrs=
);
=20
 static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
                                MMUAccessType access_type, ARMMMUIdx mmu_=
idx,
@@ -53,24 +42,8 @@ static bool get_phys_addr_lpae(CPUARMState *env, targe=
t_ulong address,
                                target_ulong *page_size_ptr,
                                ARMMMUFaultInfo *fi, ARMCacheAttrs *cache=
attrs);
=20
-/* Security attributes for an address, as returned by v8m_security_looku=
p. */
-typedef struct V8M_SAttributes {
-    bool subpage; /* true if these attrs don't cover the whole TARGET_PA=
GE */
-    bool ns;
-    bool nsc;
-    uint8_t sregion;
-    bool srvalid;
-    uint8_t iregion;
-    bool irvalid;
-} V8M_SAttributes;
-
-static void v8m_security_lookup(CPUARMState *env, uint32_t address,
-                                MMUAccessType access_type, ARMMMUIdx mmu=
_idx,
-                                V8M_SAttributes *sattrs);
 #endif
=20
-static void switch_mode(CPUARMState *env, int mode);
-
 static int vfp_gdb_get_reg(CPUARMState *env, uint8_t *buf, int reg)
 {
     int nregs;
@@ -7552,7 +7525,7 @@ uint32_t HELPER(v7m_tt)(CPUARMState *env, uint32_t =
addr, uint32_t op)
     return 0;
 }
=20
-static void switch_mode(CPUARMState *env, int mode)
+void switch_mode(CPUARMState *env, int mode)
 {
     ARMCPU *cpu =3D env_archcpu(env);
=20
@@ -7574,7 +7547,7 @@ void aarch64_sync_64_to_32(CPUARMState *env)
=20
 #else
=20
-static void switch_mode(CPUARMState *env, int mode)
+void switch_mode(CPUARMState *env, int mode)
 {
     int old_mode;
     int i;
@@ -7988,9 +7961,9 @@ void HELPER(v7m_preserve_fp_state)(CPUARMState *env=
)
  * stack pointers if it is done for the CONTROL register for the current
  * security state.
  */
-static void write_v7m_control_spsel_for_secstate(CPUARMState *env,
-                                                 bool new_spsel,
-                                                 bool secstate)
+void write_v7m_control_spsel_for_secstate(CPUARMState *env,
+                                          bool new_spsel,
+                                          bool secstate)
 {
     bool old_is_psp =3D v7m_using_psp(env);
=20
@@ -8015,7 +7988,7 @@ static void write_v7m_control_spsel_for_secstate(CP=
UARMState *env,
  * Write to v7M CONTROL.SPSEL bit. This may change the current
  * stack pointer between Main and Process stack pointers.
  */
-static void write_v7m_control_spsel(CPUARMState *env, bool new_spsel)
+void write_v7m_control_spsel(CPUARMState *env, bool new_spsel)
 {
     write_v7m_control_spsel_for_secstate(env, new_spsel, env->v7m.secure=
);
 }
@@ -8041,7 +8014,7 @@ void write_v7m_exception(CPUARMState *env, uint32_t=
 new_exc)
 }
=20
 /* Switch M profile security state between NS and S */
-static void switch_v7m_security_state(CPUARMState *env, bool new_secstat=
e)
+void switch_v7m_security_state(CPUARMState *env, bool new_secstate)
 {
     uint32_t new_ss_msp, new_ss_psp;
=20
@@ -9447,7 +9420,7 @@ static bool do_v7m_function_return(ARMCPU *cpu)
     return true;
 }
=20
-static void arm_log_exception(int idx)
+void arm_log_exception(int idx)
 {
     if (qemu_loglevel_mask(CPU_LOG_INT)) {
         const char *exc =3D NULL;
@@ -12122,9 +12095,9 @@ static bool v8m_is_sau_exempt(CPUARMState *env,
         (address >=3D 0xe00ff000 && address <=3D 0xe00fffff);
 }
=20
-static void v8m_security_lookup(CPUARMState *env, uint32_t address,
-                                MMUAccessType access_type, ARMMMUIdx mmu=
_idx,
-                                V8M_SAttributes *sattrs)
+void v8m_security_lookup(CPUARMState *env, uint32_t address,
+                         MMUAccessType access_type, ARMMMUIdx mmu_idx,
+                         V8M_SAttributes *sattrs)
 {
     /* Look up the security attributes for this address. Compare the
      * pseudocode SecurityCheck() function.
@@ -12229,11 +12202,11 @@ static void v8m_security_lookup(CPUARMState *en=
v, uint32_t address,
     }
 }
=20
-static bool pmsav8_mpu_lookup(CPUARMState *env, uint32_t address,
-                              MMUAccessType access_type, ARMMMUIdx mmu_i=
dx,
-                              hwaddr *phys_ptr, MemTxAttrs *txattrs,
-                              int *prot, bool *is_subpage,
-                              ARMMMUFaultInfo *fi, uint32_t *mregion)
+bool pmsav8_mpu_lookup(CPUARMState *env, uint32_t address,
+                       MMUAccessType access_type, ARMMMUIdx mmu_idx,
+                       hwaddr *phys_ptr, MemTxAttrs *txattrs,
+                       int *prot, bool *is_subpage,
+                       ARMMMUFaultInfo *fi, uint32_t *mregion)
 {
     /* Perform a PMSAv8 MPU lookup (without also doing the SAU check
      * that a full phys-to-virt translation does).
@@ -12633,11 +12606,11 @@ static ARMCacheAttrs combine_cacheattrs(ARMCach=
eAttrs s1, ARMCacheAttrs s2)
  * @fi: set to fault info if the translation fails
  * @cacheattrs: (if non-NULL) set to the cacheability/shareability attri=
butes
  */
-static bool get_phys_addr(CPUARMState *env, target_ulong address,
-                          MMUAccessType access_type, ARMMMUIdx mmu_idx,
-                          hwaddr *phys_ptr, MemTxAttrs *attrs, int *prot=
,
-                          target_ulong *page_size,
-                          ARMMMUFaultInfo *fi, ARMCacheAttrs *cacheattrs=
)
+bool get_phys_addr(CPUARMState *env, target_ulong address,
+                   MMUAccessType access_type, ARMMMUIdx mmu_idx,
+                   hwaddr *phys_ptr, MemTxAttrs *attrs, int *prot,
+                   target_ulong *page_size,
+                   ARMMMUFaultInfo *fi, ARMCacheAttrs *cacheattrs)
 {
     if (mmu_idx =3D=3D ARMMMUIdx_S12NSE0 || mmu_idx =3D=3D ARMMMUIdx_S12=
NSE1) {
         /* Call ourselves recursively to do the stage 1 and then stage 2
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 5a02f458f3..04711b317a 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -985,4 +985,49 @@ static inline int exception_target_el(CPUARMState *e=
nv)
     return target_el;
 }
=20
+void arm_log_exception(int idx);
+
+/* Cacheability and shareability attributes for a memory access */
+typedef struct ARMCacheAttrs {
+    unsigned int attrs:8; /* as in the MAIR register encoding */
+    unsigned int shareability:2; /* as in the SH field of the VMSAv8-64 =
PTEs */
+} ARMCacheAttrs;
+
+bool get_phys_addr(CPUARMState *env, target_ulong address,
+                   MMUAccessType access_type, ARMMMUIdx mmu_idx,
+                   hwaddr *phys_ptr, MemTxAttrs *attrs, int *prot,
+                   target_ulong *page_size,
+                   ARMMMUFaultInfo *fi, ARMCacheAttrs *cacheattrs);
+
+/* Security attributes for an address, as returned by v8m_security_looku=
p. */
+typedef struct V8M_SAttributes {
+    bool subpage; /* true if these attrs don't cover the whole TARGET_PA=
GE */
+    bool ns;
+    bool nsc;
+    uint8_t sregion;
+    bool srvalid;
+    uint8_t iregion;
+    bool irvalid;
+} V8M_SAttributes;
+
+void v8m_security_lookup(CPUARMState *env, uint32_t address,
+                         MMUAccessType access_type, ARMMMUIdx mmu_idx,
+                         V8M_SAttributes *sattrs);
+
+void switch_mode(CPUARMState *, int);
+
+bool pmsav8_mpu_lookup(CPUARMState *env, uint32_t address,
+                       MMUAccessType access_type, ARMMMUIdx mmu_idx,
+                       hwaddr *phys_ptr, MemTxAttrs *txattrs,
+                       int *prot, bool *is_subpage,
+                       ARMMMUFaultInfo *fi, uint32_t *mregion);
+
+void write_v7m_control_spsel_for_secstate(CPUARMState *env,
+                                          bool new_spsel,
+                                          bool secstate);
+
+void write_v7m_control_spsel(CPUARMState *env, bool new_spsel);
+
+void switch_v7m_security_state(CPUARMState *env, bool new_secstate);
+
 #endif
--=20
2.20.1


