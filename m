Return-Path: <SRS0=kcoF=UO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D67C31E50
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Jun 2019 16:10:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9867B2183F
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Jun 2019 16:10:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9867B2183F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33148 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcBGF-0002Rn-T3
	for qemu-devel@archiver.kernel.org; Sat, 15 Jun 2019 12:10:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35983)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hcArA-00046T-EE
 for qemu-devel@nongnu.org; Sat, 15 Jun 2019 11:44:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hcAr9-0001Ee-Hu
 for qemu-devel@nongnu.org; Sat, 15 Jun 2019 11:44:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41490)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hcAr3-0000te-W3; Sat, 15 Jun 2019 11:44:34 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6A0DF3082207;
 Sat, 15 Jun 2019 15:44:32 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-41.brq.redhat.com [10.40.204.41])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2BF1D1001B05;
 Sat, 15 Jun 2019 15:44:30 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Sat, 15 Jun 2019 17:43:46 +0200
Message-Id: <20190615154352.26824-18-philmd@redhat.com>
In-Reply-To: <20190615154352.26824-1-philmd@redhat.com>
References: <20190615154352.26824-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Sat, 15 Jun 2019 15:44:32 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 17/23] target/arm: Fix coding style issues
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

Since we'll move this code around, fix its style first.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 target/arm/translate.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index c274c8b460..d0ab3e27e6 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -9179,7 +9179,7 @@ static void disas_arm_insn(DisasContext *s, unsigne=
d int insn)
                 loaded_base =3D 0;
                 loaded_var =3D NULL;
                 n =3D 0;
-                for(i=3D0;i<16;i++) {
+                for (i =3D 0; i < 16; i++) {
                     if (insn & (1 << i))
                         n++;
                 }
@@ -9202,7 +9202,7 @@ static void disas_arm_insn(DisasContext *s, unsigne=
d int insn)
                     }
                 }
                 j =3D 0;
-                for(i=3D0;i<16;i++) {
+                for (i =3D 0; i < 16; i++) {
                     if (insn & (1 << i)) {
                         if (is_load) {
                             /* load */
@@ -12427,12 +12427,13 @@ void arm_cpu_dump_state(CPUState *cs, FILE *f, =
int flags)
         return;
     }
=20
-    for(i=3D0;i<16;i++) {
+    for (i =3D 0; i < 16; i++) {
         qemu_fprintf(f, "R%02d=3D%08x", i, env->regs[i]);
-        if ((i % 4) =3D=3D 3)
+        if ((i % 4) =3D=3D 3) {
             qemu_fprintf(f, "\n");
-        else
+        } else {
             qemu_fprintf(f, " ");
+        }
     }
=20
     if (arm_feature(env, ARM_FEATURE_M)) {
--=20
2.20.1


