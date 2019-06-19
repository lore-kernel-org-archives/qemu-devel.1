Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9AF0C31E5D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 07:58:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95E7D20823
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 07:58:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95E7D20823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=efs-auto.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35670 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdVUD-0006MR-SH
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 03:58:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36912)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <david.brenken@efs-auto.org>) id 1hdVSx-0005U8-3V
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 03:57:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david.brenken@efs-auto.org>) id 1hdVSv-0008Pq-87
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 03:57:10 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:41791)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <david.brenken@efs-auto.org>)
 id 1hdVSu-0008NL-V0
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 03:57:09 -0400
Received: from localhost.localdomain ([178.239.76.114]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MEC8L-1hn6Ns28fd-00AF8V; Wed, 19 Jun 2019 09:57:01 +0200
From: David Brenken <david.brenken@efs-auto.org>
To: qemu-devel@nongnu.org
Date: Wed, 19 Jun 2019 09:56:40 +0200
Message-Id: <20190619075643.10048-3-david.brenken@efs-auto.org>
X-Mailer: git-send-email 2.16.1.windows.4
In-Reply-To: <20190619075643.10048-1-david.brenken@efs-auto.org>
References: <20190619075643.10048-1-david.brenken@efs-auto.org>
X-Provags-ID: V03:K1:MI3C7ZPRJVziEjzpwhBTf/pWa8OFdEB1HmbA1cgnUBH5HaazFB8
 ZC+eWk8WJQp5CaavcZwVRIbuvBloy0SWJDn0sE0xRKOV/sWnRpXg0zu1QhD9qBHm2sS+XMG
 oB7t97jmSiTg43oY7cpORwzo96IXf3ZLdrooOShUiKMNnP8aSbLzhtoEky7vMqXzBTC87h6
 lwdghLuM2/2DplYJQ850g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:roPcsERWV1o=:5QiYMZwHQGjGMjdMhFp5JJ
 MVt9O5V5xpoitRq2ncAw1gRy+6j9rVBjZ/b9Z3hmBP9ASlosESl8u08xR0+CI51m/V7K8uilX
 IHaDfKv+m6L3LcDXIRIM7uM52VGTJRBQabv302i2nn9yRY5wzgOrg8pfP7G3zndtlSeb8TX6z
 UwPV/tCE3Z20LlmW6Gk+VgP2Lh7xAJA+9q5f/oLZl2OQnsV6iUxKabZUxAKIKV2w51p5rrmuL
 Dp/MKy6L7GuOh4X3RJNn/hGQYZgv7w7U+rd1iA+NAi/gGLvqz7brFAoa/oBxKpcqozCe3WTR/
 e/qwneeaAmBmbtTg/RGV16QHHq9s2oYfHBydeyKd5dUfMpEms0lTllD/asDfCdlVg/+QP79uv
 Q3898ZdvGl6vrY/vY1vMdvay80seJVChfJdKSiIytF3tg0ip1uDrJkKbMCZ59pkR0T54NxU3I
 pSH2/G8pQhDN4mc3oW22EFhT9QO4jzKuVI5K3vjxZ65qNFHsvJbOIWfx8C9copULi15/jjnlM
 4SDb+vddRQ+6UEU+TScDsdidG7AWZ1Jlern+yxpo4sblQ60DyGet8Aq33owdss/cMuIM679Py
 SM8fwGKFr+6BbvWxLN2mducJxra32nt7KLA/zKa0gbehzpZfO27JQt80Mzyrbhtktfy1eqbI9
 ASbSD+Y3FZA1YXQScnoOG4B72zQ7BxvLpzN6srusFzlIKDrJDmcEr6UxJ64QISDxXqdOIWt80
 ii+eYLK3KRoULPe1r8UAlBjLIjnvnqAjR/r5Tu4aWvQ3Sa61WCOjwV7WH80=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.134
Subject: [Qemu-devel] [PATCH v2 2/5] tricore: add UTOF instruction
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
Cc: kbastian@mail.uni-paderborn.de,
 Lars Biermanski <lars.biermanski@efs-auto.de>,
 Georg Hofstetter <georg.hofstetter@efs-auto.de>,
 David Brenken <david.brenken@efs-auto.de>,
 Robert Rasche <robert.rasche@efs-auto.de>,
 Andreas Konopik <andreas.konopik@efs-auto.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Brenken <david.brenken@efs-auto.de>

Signed-off-by: Andreas Konopik <andreas.konopik@efs-auto.de>
Signed-off-by: David Brenken <david.brenken@efs-auto.de>
Signed-off-by: Georg Hofstetter <georg.hofstetter@efs-auto.de>
Signed-off-by: Robert Rasche <robert.rasche@efs-auto.de>
Signed-off-by: Lars Biermanski <lars.biermanski@efs-auto.de>
Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
---
 target/tricore/fpu_helper.c | 16 ++++++++++++++++
 target/tricore/helper.h     |  1 +
 target/tricore/translate.c  |  3 +++
 3 files changed, 20 insertions(+)

diff --git a/target/tricore/fpu_helper.c b/target/tricore/fpu_helper.c
index f079d9e939..432079c8e2 100644
--- a/target/tricore/fpu_helper.c
+++ b/target/tricore/fpu_helper.c
@@ -303,6 +303,22 @@ uint32_t helper_itof(CPUTriCoreState *env, uint32_t arg)
     return (uint32_t)f_result;
 }
 
+uint32_t helper_utof(CPUTriCoreState *env, uint32_t arg)
+{
+    float32 f_result;
+    uint32_t flags;
+
+    f_result = uint32_to_float32(arg, &env->fp_status);
+
+    flags = f_get_excp_flags(env);
+    if (flags) {
+        f_update_psw_flags(env, flags);
+    } else {
+        env->FPU_FS = 0;
+    }
+    return (uint32_t)f_result;
+}
+
 uint32_t helper_ftoiz(CPUTriCoreState *env, uint32_t arg)
 {
     float32 f_arg = make_float32(arg);
diff --git a/target/tricore/helper.h b/target/tricore/helper.h
index 16b62edf7f..f1a5cb367e 100644
--- a/target/tricore/helper.h
+++ b/target/tricore/helper.h
@@ -111,6 +111,7 @@ DEF_HELPER_4(fmsub, i32, env, i32, i32, i32)
 DEF_HELPER_3(fcmp, i32, env, i32, i32)
 DEF_HELPER_2(ftoi, i32, env, i32)
 DEF_HELPER_2(itof, i32, env, i32)
+DEF_HELPER_2(utof, i32, env, i32)
 DEF_HELPER_2(ftoiz, i32, env, i32)
 DEF_HELPER_2(ftouz, i32, env, i32)
 DEF_HELPER_2(updfl, void, env, i32)
diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 5e1c4f54b9..bd913d71a1 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -6747,6 +6747,9 @@ static void decode_rr_divide(CPUTriCoreState *env, DisasContext *ctx)
     case OPC2_32_RR_UPDFL:
         gen_helper_updfl(cpu_env, cpu_gpr_d[r1]);
         break;
+    case OPC2_32_RR_UTOF:
+        gen_helper_utof(cpu_gpr_d[r3], cpu_env, cpu_gpr_d[r1]);
+        break;
     case OPC2_32_RR_FTOIZ:
         gen_helper_ftoiz(cpu_gpr_d[r3], cpu_env, cpu_gpr_d[r1]);
         break;
-- 
2.22.0.windows.1


