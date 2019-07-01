Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B47C0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 13:33:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF4FF20665
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 13:33:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF4FF20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhwQx-0008Ga-5q
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 09:33:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40818)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hhwKC-00023o-DK
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 09:26:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hhwK8-0001wd-Jc
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 09:26:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35292)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hhwJn-0001hP-RH; Mon, 01 Jul 2019 09:26:05 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D8BF4A705;
 Mon,  1 Jul 2019 13:26:01 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.170])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 04E6217AC2;
 Mon,  1 Jul 2019 13:25:56 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  1 Jul 2019 15:24:57 +0200
Message-Id: <20190701132516.26392-9-philmd@redhat.com>
In-Reply-To: <20190701132516.26392-1-philmd@redhat.com>
References: <20190701132516.26392-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Mon, 01 Jul 2019 13:26:02 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 08/27] target/arm: Fix coding style issues
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

Since we'll move this code around, fix its style first.

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
v3: added vfp_helper.c
---
 target/arm/translate.c  | 11 ++++++-----
 target/arm/vfp_helper.c | 36 ++++++++++++++++++++++++------------
 2 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 4750b9fa1b..c6bdf026b4 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -9109,7 +9109,7 @@ static void disas_arm_insn(DisasContext *s, unsigne=
d int insn)
                 loaded_base =3D 0;
                 loaded_var =3D NULL;
                 n =3D 0;
-                for(i=3D0;i<16;i++) {
+                for (i =3D 0; i < 16; i++) {
                     if (insn & (1 << i))
                         n++;
                 }
@@ -9132,7 +9132,7 @@ static void disas_arm_insn(DisasContext *s, unsigne=
d int insn)
                     }
                 }
                 j =3D 0;
-                for(i=3D0;i<16;i++) {
+                for (i =3D 0; i < 16; i++) {
                     if (insn & (1 << i)) {
                         if (is_load) {
                             /* load */
@@ -12353,12 +12353,13 @@ void arm_cpu_dump_state(CPUState *cs, FILE *f, =
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
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 7ece78e987..121bdbd3af 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -34,18 +34,24 @@ static inline int vfp_exceptbits_from_host(int host_b=
its)
 {
     int target_bits =3D 0;
=20
-    if (host_bits & float_flag_invalid)
+    if (host_bits & float_flag_invalid) {
         target_bits |=3D 1;
-    if (host_bits & float_flag_divbyzero)
+    }
+    if (host_bits & float_flag_divbyzero) {
         target_bits |=3D 2;
-    if (host_bits & float_flag_overflow)
+    }
+    if (host_bits & float_flag_overflow) {
         target_bits |=3D 4;
-    if (host_bits & (float_flag_underflow | float_flag_output_denormal))
+    }
+    if (host_bits & (float_flag_underflow | float_flag_output_denormal))=
 {
         target_bits |=3D 8;
-    if (host_bits & float_flag_inexact)
+    }
+    if (host_bits & float_flag_inexact) {
         target_bits |=3D 0x10;
-    if (host_bits & float_flag_input_denormal)
+    }
+    if (host_bits & float_flag_input_denormal) {
         target_bits |=3D 0x80;
+    }
     return target_bits;
 }
=20
@@ -80,18 +86,24 @@ static inline int vfp_exceptbits_to_host(int target_b=
its)
 {
     int host_bits =3D 0;
=20
-    if (target_bits & 1)
+    if (target_bits & 1) {
         host_bits |=3D float_flag_invalid;
-    if (target_bits & 2)
+    }
+    if (target_bits & 2) {
         host_bits |=3D float_flag_divbyzero;
-    if (target_bits & 4)
+    }
+    if (target_bits & 4) {
         host_bits |=3D float_flag_overflow;
-    if (target_bits & 8)
+    }
+    if (target_bits & 8) {
         host_bits |=3D float_flag_underflow;
-    if (target_bits & 0x10)
+    }
+    if (target_bits & 0x10) {
         host_bits |=3D float_flag_inexact;
-    if (target_bits & 0x80)
+    }
+    if (target_bits & 0x80) {
         host_bits |=3D float_flag_input_denormal;
+    }
     return host_bits;
 }
=20
--=20
2.20.1


