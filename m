Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5033BC0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 13:41:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27AB22146E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 13:41:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27AB22146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhwYx-0007iW-DO
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 09:41:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41214)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hhwKl-0002RT-1B
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 09:27:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hhwKj-0002UM-4t
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 09:27:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48064)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hhwKd-0002Gi-TK; Mon, 01 Jul 2019 09:26:56 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 957D830842D1;
 Mon,  1 Jul 2019 13:26:50 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.170])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DD1486085B;
 Mon,  1 Jul 2019 13:26:47 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  1 Jul 2019 15:25:10 +0200
Message-Id: <20190701132516.26392-22-philmd@redhat.com>
In-Reply-To: <20190701132516.26392-1-philmd@redhat.com>
References: <20190701132516.26392-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Mon, 01 Jul 2019 13:26:50 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 21/27] target/arm: Declare some M-profile
 functions publicly
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
Cc: Yang Zhong <yang.zhong@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jones <drjones@redhat.com>, Samuel Ortiz <sameo@linux.intel.com>,
 Rob Bradford <robert.bradford@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In the next commit we will split the M-profile functions from this
file. Some function will be called out of helper.c. Declare them in
the "internals.h" header.

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
v3: Was v7-only, add v8
---
 target/arm/helper.c    | 38 ++------------------------------------
 target/arm/internals.h | 42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 36 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 515a82af57..4e59ae4d96 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -41,21 +41,6 @@ static bool get_phys_addr_lpae(CPUARMState *env, targe=
t_ulong address,
                                hwaddr *phys_ptr, MemTxAttrs *txattrs, in=
t *prot,
                                target_ulong *page_size_ptr,
                                ARMMMUFaultInfo *fi, ARMCacheAttrs *cache=
attrs);
-
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
 static void switch_mode(CPUARMState *env, int mode);
@@ -7735,25 +7720,6 @@ void arm_log_exception(int idx)
     }
 }
=20
-/*
- * Return true if the v7M CPACR permits access to the FPU for the specif=
ied
- * security state and privilege level.
- */
-static bool v7m_cpacr_pass(CPUARMState *env, bool is_secure, bool is_pri=
v)
-{
-    switch (extract32(env->v7m.cpacr[is_secure], 20, 2)) {
-    case 0:
-    case 2: /* UNPREDICTABLE: we treat like 0 */
-        return false;
-    case 1:
-        return is_priv;
-    case 3:
-        return true;
-    default:
-        g_assert_not_reached();
-    }
-}
-
 /*
  * What kind of stack write are we doing? This affects how exceptions
  * generated during the stacking are treated.
@@ -12119,7 +12085,7 @@ static bool v8m_is_sau_exempt(CPUARMState *env,
         (address >=3D 0xe00ff000 && address <=3D 0xe00fffff);
 }
=20
-static void v8m_security_lookup(CPUARMState *env, uint32_t address,
+void v8m_security_lookup(CPUARMState *env, uint32_t address,
                                 MMUAccessType access_type, ARMMMUIdx mmu=
_idx,
                                 V8M_SAttributes *sattrs)
 {
@@ -12226,7 +12192,7 @@ static void v8m_security_lookup(CPUARMState *env,=
 uint32_t address,
     }
 }
=20
-static bool pmsav8_mpu_lookup(CPUARMState *env, uint32_t address,
+bool pmsav8_mpu_lookup(CPUARMState *env, uint32_t address,
                               MMUAccessType access_type, ARMMMUIdx mmu_i=
dx,
                               hwaddr *phys_ptr, MemTxAttrs *txattrs,
                               int *prot, bool *is_subpage,
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 11bfdba512..232d963875 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -892,6 +892,27 @@ static inline uint32_t v7m_sp_limit(CPUARMState *env=
)
     }
 }
=20
+/**
+ * v7m_cpacr_pass:
+ * Return true if the v7M CPACR permits access to the FPU for the specif=
ied
+ * security state and privilege level.
+ */
+static inline bool v7m_cpacr_pass(CPUARMState *env,
+                                  bool is_secure, bool is_priv)
+{
+    switch (extract32(env->v7m.cpacr[is_secure], 20, 2)) {
+    case 0:
+    case 2: /* UNPREDICTABLE: we treat like 0 */
+        return false;
+    case 1:
+        return is_priv;
+    case 3:
+        return true;
+    default:
+        g_assert_not_reached();
+    }
+}
+
 /**
  * aarch32_mode_name(): Return name of the AArch32 CPU mode
  * @psr: Program Status Register indicating CPU mode
@@ -988,6 +1009,27 @@ static inline int exception_target_el(CPUARMState *=
env)
=20
 #ifndef CONFIG_USER_ONLY
=20
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
+bool pmsav8_mpu_lookup(CPUARMState *env, uint32_t address,
+                       MMUAccessType access_type, ARMMMUIdx mmu_idx,
+                       hwaddr *phys_ptr, MemTxAttrs *txattrs,
+                       int *prot, bool *is_subpage,
+                       ARMMMUFaultInfo *fi, uint32_t *mregion);
+
 /* Cacheability and shareability attributes for a memory access */
 typedef struct ARMCacheAttrs {
     unsigned int attrs:8; /* as in the MAIR register encoding */
--=20
2.20.1


