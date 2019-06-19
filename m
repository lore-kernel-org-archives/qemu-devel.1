Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08319C31E49
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 08:00:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD9E620823
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 08:00:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD9E620823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=efs-auto.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35690 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdVVg-00080F-3t
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 04:00:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36916)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <david.brenken@efs-auto.org>) id 1hdVSx-0005UJ-C7
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 03:57:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david.brenken@efs-auto.org>) id 1hdVSw-0008Qd-2Z
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 03:57:11 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:43247)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <david.brenken@efs-auto.org>)
 id 1hdVSv-0008NK-QE
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 03:57:10 -0400
Received: from localhost.localdomain ([178.239.76.114]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MRVy9-1i0He41Pzp-00NQOB; Wed, 19 Jun 2019 09:57:01 +0200
From: David Brenken <david.brenken@efs-auto.org>
To: qemu-devel@nongnu.org
Date: Wed, 19 Jun 2019 09:56:39 +0200
Message-Id: <20190619075643.10048-2-david.brenken@efs-auto.org>
X-Mailer: git-send-email 2.16.1.windows.4
In-Reply-To: <20190619075643.10048-1-david.brenken@efs-auto.org>
References: <20190619075643.10048-1-david.brenken@efs-auto.org>
X-Provags-ID: V03:K1:yTkp36XY1xIaDQHU6e+ZmNKlaq7hsBP+n4ypngsTo9LOJjO8tie
 e3TnzsSWJabJFeewjbkrgnP+UkehS4T/X9NyhwH0TuaIQn6lnShLcFQkO8jbbsPWjWb0rmS
 xUzxX0E5vJesWjU0xsqjGOrzoHICJWr+doKufpmjzZ7rrqRILdy/+3FhOzdyZQSOc5cmcH/
 xkZUDyVPonin3ScrB0Ezg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WVmo8/ZHvjU=:BSiw/FP/AlVCa5XYtmx7yj
 24jBIrYIv+6RzXTZUJaSBZsi7kt7cLqwgAPH/piQSCWHKy/eX/Cj1hH1ShVWw3vy+HYsykEWM
 QV99ZQmqNtrBKLWFa37sj+8/Dd5NlVwCsOnANN3H3sMk3FQQhPmI8DfxTsPglHkhmXCEbo5Hh
 kDIi/bGAiJ6ZrE9q2QospNZ0zPus0/nOFx5DAddOia9kRM99MC+526QI6qxJ2aZ+WLAkVy2ov
 UiP5pNXUyxBCpbVveQKSbsH7g1xcsw6v+qY906yOqQnxbYLelmBY4Vzyd9/SsqLI+KMcMLuSC
 kF4cDEAhPCvwkTNVBQtYstiqd1O9evKw+Dzdv4K3WColBNP/nJVwxoZuXRTHkBcQmEOIjESVx
 KjaQkkouzJAcy8o+pQBRkpTOvAhvqHcIGHa6bzc88KRUfS5bqHgf2tEpXLpWk4cHZXEOQg24K
 1oFNF5cBcHkgWMKzVUdoTr41aU7/KhCG6LGPWLdddpsZWx38+mp3nFnpXe7eBn8+ku+T3GcMm
 jbD+NwB8fV6vaqnXIUm3AIRbY2fVq0yKeLvpDYjDtWRwKrIHFPy1YqWCefE1GvKMDHSYIVwvG
 IAcQnlJCRmeZisKclXY8mrU0AYCEU7UtkIahWGN9Dd71/TkNcFSxAtx+e8dOe84dw8V9wucOr
 WVOKzw1UbAX9Zw8NmI0+fcwEgW3LA3I4QfFtkcUM1tv3784HwSSEq0dzJOrIBJGWbYaPcqpkC
 HoibWPnueLTLoTl2y6cGflqNV8tZ9060l5QttgKpFaC5qoV/oWtMU7Rhkns=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.134
Subject: [Qemu-devel] [PATCH v2 1/5] tricore: add FTOIZ instruction
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
 target/tricore/fpu_helper.c | 25 +++++++++++++++++++++++++
 target/tricore/helper.h     |  1 +
 target/tricore/translate.c  |  3 +++
 3 files changed, 29 insertions(+)

diff --git a/target/tricore/fpu_helper.c b/target/tricore/fpu_helper.c
index d8a6c0d25b..f079d9e939 100644
--- a/target/tricore/fpu_helper.c
+++ b/target/tricore/fpu_helper.c
@@ -303,6 +303,31 @@ uint32_t helper_itof(CPUTriCoreState *env, uint32_t arg)
     return (uint32_t)f_result;
 }
 
+uint32_t helper_ftoiz(CPUTriCoreState *env, uint32_t arg)
+{
+    float32 f_arg = make_float32(arg);
+    uint32_t result;
+    int32_t flags;
+
+    result = float32_to_int32_round_to_zero(f_arg, &env->fp_status);
+
+    flags = f_get_excp_flags(env);
+    if (flags & float_flag_invalid) {
+        flags &= ~float_flag_inexact;
+        if (float32_is_any_nan(f_arg)) {
+            result = 0;
+        }
+    }
+
+    if (flags) {
+        f_update_psw_flags(env, flags);
+    } else {
+        env->FPU_FS = 0;
+    }
+
+    return result;
+}
+
 uint32_t helper_ftouz(CPUTriCoreState *env, uint32_t arg)
 {
     float32 f_arg = make_float32(arg);
diff --git a/target/tricore/helper.h b/target/tricore/helper.h
index f60e81096b..16b62edf7f 100644
--- a/target/tricore/helper.h
+++ b/target/tricore/helper.h
@@ -111,6 +111,7 @@ DEF_HELPER_4(fmsub, i32, env, i32, i32, i32)
 DEF_HELPER_3(fcmp, i32, env, i32, i32)
 DEF_HELPER_2(ftoi, i32, env, i32)
 DEF_HELPER_2(itof, i32, env, i32)
+DEF_HELPER_2(ftoiz, i32, env, i32)
 DEF_HELPER_2(ftouz, i32, env, i32)
 DEF_HELPER_2(updfl, void, env, i32)
 /* dvinit */
diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 06c4485e55..5e1c4f54b9 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -6747,6 +6747,9 @@ static void decode_rr_divide(CPUTriCoreState *env, DisasContext *ctx)
     case OPC2_32_RR_UPDFL:
         gen_helper_updfl(cpu_env, cpu_gpr_d[r1]);
         break;
+    case OPC2_32_RR_FTOIZ:
+        gen_helper_ftoiz(cpu_gpr_d[r3], cpu_env, cpu_gpr_d[r1]);
+        break;
     default:
         generate_trap(ctx, TRAPC_INSN_ERR, TIN2_IOPC);
     }
-- 
2.22.0.windows.1


