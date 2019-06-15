Return-Path: <SRS0=kcoF=UO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FCC9C31E50
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Jun 2019 15:55:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53E3221473
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Jun 2019 15:55:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53E3221473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32966 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcB1u-0005ph-IL
	for qemu-devel@archiver.kernel.org; Sat, 15 Jun 2019 11:55:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35728)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hcAqs-0003wU-3b
 for qemu-devel@nongnu.org; Sat, 15 Jun 2019 11:44:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hcAqq-0000K3-K6
 for qemu-devel@nongnu.org; Sat, 15 Jun 2019 11:44:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35484)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hcAqn-00009n-Nb; Sat, 15 Jun 2019 11:44:17 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F2C9C3082E55;
 Sat, 15 Jun 2019 15:44:16 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-41.brq.redhat.com [10.40.204.41])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8AAEB1001B05;
 Sat, 15 Jun 2019 15:44:13 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Sat, 15 Jun 2019 17:43:38 +0200
Message-Id: <20190615154352.26824-10-philmd@redhat.com>
In-Reply-To: <20190615154352.26824-1-philmd@redhat.com>
References: <20190615154352.26824-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Sat, 15 Jun 2019 15:44:17 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 09/23] target/arm: Move code around
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

To ease the review of the next commit, move the
write_v7m_exception() function around.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 target/arm/helper.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index a829086c6d..b4fd9b42d7 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7923,26 +7923,6 @@ void write_v7m_control_spsel(CPUARMState *env, boo=
l new_spsel)
     write_v7m_control_spsel_for_secstate(env, new_spsel, env->v7m.secure=
);
 }
=20
-void write_v7m_exception(CPUARMState *env, uint32_t new_exc)
-{
-    /*
-     * Write a new value to v7m.exception, thus transitioning into or ou=
t
-     * of Handler mode; this may result in a change of active stack poin=
ter.
-     */
-    bool new_is_psp, old_is_psp =3D v7m_using_psp(env);
-    uint32_t tmp;
-
-    env->v7m.exception =3D new_exc;
-
-    new_is_psp =3D v7m_using_psp(env);
-
-    if (old_is_psp !=3D new_is_psp) {
-        tmp =3D env->v7m.other_sp;
-        env->v7m.other_sp =3D env->regs[13];
-        env->regs[13] =3D tmp;
-    }
-}
-
 /* Switch M profile security state between NS and S */
 void switch_v7m_security_state(CPUARMState *env, bool new_secstate)
 {
@@ -9247,6 +9227,26 @@ static bool do_v7m_function_return(ARMCPU *cpu)
     return true;
 }
=20
+void write_v7m_exception(CPUARMState *env, uint32_t new_exc)
+{
+    /*
+     * Write a new value to v7m.exception, thus transitioning into or ou=
t
+     * of Handler mode; this may result in a change of active stack poin=
ter.
+     */
+    bool new_is_psp, old_is_psp =3D v7m_using_psp(env);
+    uint32_t tmp;
+
+    env->v7m.exception =3D new_exc;
+
+    new_is_psp =3D v7m_using_psp(env);
+
+    if (old_is_psp !=3D new_is_psp) {
+        tmp =3D env->v7m.other_sp;
+        env->v7m.other_sp =3D env->regs[13];
+        env->regs[13] =3D tmp;
+    }
+}
+
 void arm_log_exception(int idx)
 {
     if (qemu_loglevel_mask(CPU_LOG_INT)) {
--=20
2.20.1


