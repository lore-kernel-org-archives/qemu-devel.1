Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76007C0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 13:38:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DDE72146E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 13:38:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DDE72146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhwVL-0004M2-Uf
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 09:37:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40926)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hhwKY-00025u-Jc
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 09:26:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hhwKQ-00029S-Al
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 09:26:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42779)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hhwJz-0001no-Uh; Mon, 01 Jul 2019 09:26:17 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7F3E5356D2;
 Mon,  1 Jul 2019 13:26:11 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.170])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C21986085B;
 Mon,  1 Jul 2019 13:26:08 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  1 Jul 2019 15:25:00 +0200
Message-Id: <20190701132516.26392-12-philmd@redhat.com>
In-Reply-To: <20190701132516.26392-1-philmd@redhat.com>
References: <20190701132516.26392-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Mon, 01 Jul 2019 13:26:11 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 11/27] target/arm: Declare get_phys_addr()
 function publicly
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

In the next commit we will split the TLB related routines of
this file, and this function will also be called in the new
file. Declare it in the "internals.h" header.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 target/arm/helper.c    | 21 +++++----------------
 target/arm/internals.h | 16 ++++++++++++++++
 2 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index a87fda9191..063f4778e0 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -33,17 +33,6 @@
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
@@ -12639,11 +12628,11 @@ static ARMCacheAttrs combine_cacheattrs(ARMCach=
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
index 5a02f458f3..ff5ab0328e 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -985,4 +985,20 @@ static inline int exception_target_el(CPUARMState *e=
nv)
     return target_el;
 }
=20
+#ifndef CONFIG_USER_ONLY
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
+#endif /* !CONFIG_USER_ONLY */
+
 #endif
--=20
2.20.1


