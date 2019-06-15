Return-Path: <SRS0=kcoF=UO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B51C31E50
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Jun 2019 15:59:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82D6D21473
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Jun 2019 15:59:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82D6D21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32994 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcB5h-0001Ad-Mw
	for qemu-devel@archiver.kernel.org; Sat, 15 Jun 2019 11:59:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35803)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hcAqw-00041t-Qt
 for qemu-devel@nongnu.org; Sat, 15 Jun 2019 11:44:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hcAqu-0000WW-IM
 for qemu-devel@nongnu.org; Sat, 15 Jun 2019 11:44:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35500)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hcAqp-0000FO-JB; Sat, 15 Jun 2019 11:44:19 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AEEEC3082E20;
 Sat, 15 Jun 2019 15:44:18 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-41.brq.redhat.com [10.40.204.41])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6DE041001B05;
 Sat, 15 Jun 2019 15:44:17 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Sat, 15 Jun 2019 17:43:39 +0200
Message-Id: <20190615154352.26824-11-philmd@redhat.com>
In-Reply-To: <20190615154352.26824-1-philmd@redhat.com>
References: <20190615154352.26824-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Sat, 15 Jun 2019 15:44:18 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 10/23] target/arm: Move the v7-M Security
 State helpers to v7m_helper
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

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 target/arm/helper.c     | 73 -----------------------------------------
 target/arm/v7m_helper.c | 73 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+), 73 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index b4fd9b42d7..cf76010ea1 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7885,79 +7885,6 @@ void HELPER(v7m_preserve_fp_state)(CPUARMState *en=
v)
      */
 }
=20
-/*
- * Write to v7M CONTROL.SPSEL bit for the specified security bank.
- * This may change the current stack pointer between Main and Process
- * stack pointers if it is done for the CONTROL register for the current
- * security state.
- */
-void write_v7m_control_spsel_for_secstate(CPUARMState *env,
-                                          bool new_spsel,
-                                          bool secstate)
-{
-    bool old_is_psp =3D v7m_using_psp(env);
-
-    env->v7m.control[secstate] =3D
-        deposit32(env->v7m.control[secstate],
-                  R_V7M_CONTROL_SPSEL_SHIFT,
-                  R_V7M_CONTROL_SPSEL_LENGTH, new_spsel);
-
-    if (secstate =3D=3D env->v7m.secure) {
-        bool new_is_psp =3D v7m_using_psp(env);
-        uint32_t tmp;
-
-        if (old_is_psp !=3D new_is_psp) {
-            tmp =3D env->v7m.other_sp;
-            env->v7m.other_sp =3D env->regs[13];
-            env->regs[13] =3D tmp;
-        }
-    }
-}
-
-/*
- * Write to v7M CONTROL.SPSEL bit. This may change the current
- * stack pointer between Main and Process stack pointers.
- */
-void write_v7m_control_spsel(CPUARMState *env, bool new_spsel)
-{
-    write_v7m_control_spsel_for_secstate(env, new_spsel, env->v7m.secure=
);
-}
-
-/* Switch M profile security state between NS and S */
-void switch_v7m_security_state(CPUARMState *env, bool new_secstate)
-{
-    uint32_t new_ss_msp, new_ss_psp;
-
-    if (env->v7m.secure =3D=3D new_secstate) {
-        return;
-    }
-
-    /*
-     * All the banked state is accessed by looking at env->v7m.secure
-     * except for the stack pointer; rearrange the SP appropriately.
-     */
-    new_ss_msp =3D env->v7m.other_ss_msp;
-    new_ss_psp =3D env->v7m.other_ss_psp;
-
-    if (v7m_using_psp(env)) {
-        env->v7m.other_ss_psp =3D env->regs[13];
-        env->v7m.other_ss_msp =3D env->v7m.other_sp;
-    } else {
-        env->v7m.other_ss_msp =3D env->regs[13];
-        env->v7m.other_ss_psp =3D env->v7m.other_sp;
-    }
-
-    env->v7m.secure =3D new_secstate;
-
-    if (v7m_using_psp(env)) {
-        env->regs[13] =3D new_ss_psp;
-        env->v7m.other_sp =3D new_ss_msp;
-    } else {
-        env->regs[13] =3D new_ss_msp;
-        env->v7m.other_sp =3D new_ss_psp;
-    }
-}
-
 static uint32_t *get_v7m_sp_ptr(CPUARMState *env, bool secure, bool thre=
admode,
                                 bool spsel)
 {
diff --git a/target/arm/v7m_helper.c b/target/arm/v7m_helper.c
index 321154966e..558e143039 100644
--- a/target/arm/v7m_helper.c
+++ b/target/arm/v7m_helper.c
@@ -88,6 +88,79 @@ uint32_t HELPER(v7m_tt)(CPUARMState *env, uint32_t add=
r, uint32_t op)
=20
 #else
=20
+/*
+ * Write to v7M CONTROL.SPSEL bit for the specified security bank.
+ * This may change the current stack pointer between Main and Process
+ * stack pointers if it is done for the CONTROL register for the current
+ * security state.
+ */
+void write_v7m_control_spsel_for_secstate(CPUARMState *env,
+                                          bool new_spsel,
+                                          bool secstate)
+{
+    bool old_is_psp =3D v7m_using_psp(env);
+
+    env->v7m.control[secstate] =3D
+        deposit32(env->v7m.control[secstate],
+                  R_V7M_CONTROL_SPSEL_SHIFT,
+                  R_V7M_CONTROL_SPSEL_LENGTH, new_spsel);
+
+    if (secstate =3D=3D env->v7m.secure) {
+        bool new_is_psp =3D v7m_using_psp(env);
+        uint32_t tmp;
+
+        if (old_is_psp !=3D new_is_psp) {
+            tmp =3D env->v7m.other_sp;
+            env->v7m.other_sp =3D env->regs[13];
+            env->regs[13] =3D tmp;
+        }
+    }
+}
+
+/*
+ * Write to v7M CONTROL.SPSEL bit. This may change the current
+ * stack pointer between Main and Process stack pointers.
+ */
+void write_v7m_control_spsel(CPUARMState *env, bool new_spsel)
+{
+    write_v7m_control_spsel_for_secstate(env, new_spsel, env->v7m.secure=
);
+}
+
+/* Switch M profile security state between NS and S */
+void switch_v7m_security_state(CPUARMState *env, bool new_secstate)
+{
+    uint32_t new_ss_msp, new_ss_psp;
+
+    if (env->v7m.secure =3D=3D new_secstate) {
+        return;
+    }
+
+    /*
+     * All the banked state is accessed by looking at env->v7m.secure
+     * except for the stack pointer; rearrange the SP appropriately.
+     */
+    new_ss_msp =3D env->v7m.other_ss_msp;
+    new_ss_psp =3D env->v7m.other_ss_psp;
+
+    if (v7m_using_psp(env)) {
+        env->v7m.other_ss_psp =3D env->regs[13];
+        env->v7m.other_ss_msp =3D env->v7m.other_sp;
+    } else {
+        env->v7m.other_ss_msp =3D env->regs[13];
+        env->v7m.other_ss_psp =3D env->v7m.other_sp;
+    }
+
+    env->v7m.secure =3D new_secstate;
+
+    if (v7m_using_psp(env)) {
+        env->regs[13] =3D new_ss_psp;
+        env->v7m.other_sp =3D new_ss_msp;
+    } else {
+        env->regs[13] =3D new_ss_msp;
+        env->v7m.other_sp =3D new_ss_psp;
+    }
+}
+
 void HELPER(v7m_bxns)(CPUARMState *env, uint32_t dest)
 {
     /*
--=20
2.20.1


