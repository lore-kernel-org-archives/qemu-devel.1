Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28152C28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 06:20:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3EE9206BA
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 06:20:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3EE9206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=efs-auto.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36182 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYPHi-0000Mt-7v
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 02:20:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david.brenken@efs-auto.org>) id 1hYPER-0006zW-LG
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 02:17:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david.brenken@efs-auto.org>) id 1hYPEQ-0006hz-85
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 02:17:07 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:60013)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <david.brenken@efs-auto.org>)
	id 1hYPEK-0006GC-2v
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 02:17:01 -0400
Received: from localhost.localdomain ([178.239.76.114]) by
	mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA
	(Nemesis)
	id 1N8XHb-1gUDfz3aQj-014S32; Wed, 05 Jun 2019 08:11:42 +0200
From: David Brenken <david.brenken@efs-auto.org>
To: qemu-devel@nongnu.org
Date: Wed,  5 Jun 2019 08:11:22 +0200
Message-Id: <20190605061126.10244-2-david.brenken@efs-auto.org>
X-Mailer: git-send-email 2.16.1.windows.4
In-Reply-To: <20190605061126.10244-1-david.brenken@efs-auto.org>
References: <20190605061126.10244-1-david.brenken@efs-auto.org>
X-Provags-ID: V03:K1:GnenMGQ7VAKZr/Cz9lBUqcAD5zucyJsQjMneTeJnYLc+OsBP81U
	XpGrQel1yPjLC9A9Qjx+t7ldIyOfYEocH4xtUF53cz2u8sU6+DD1x6tgFki86FWZ0ebGiuj
	q2DPkaEuLQo/MYpGC6xJJX6bYK8wxkxtnDAHjMDV5I8zbLHva9Ti8MGgkzpOKz6G9McexmB
	eQDhlRdGcB6kGqJDxJmJg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:69Z7dGpGgkY=:HfpjiSKNbhVL9vjLKmeiGD
	NKosQLI3nwdgHfbkcq6JmHhroUf1fqudCGkPcF1Iviu4swOovj4t3WfN0MV1qvzuma0n02ZfA
	P5Dffd6VzJGdo+TLF6gQfCznYMpNP/mz5McMEbJYpcHt8lSwvAcf+G/IqtyfjDHJLR7AJC9XM
	Nf8tWCkXK08PokO2D7+58V4D2EpgLsW5gQ4GGoGc2ScrfZS+GAEvOU1zW59+x2c/Ft4z5r2R0
	37Xoxi+r2+XSBJJckkPX/U0iheJwXVuDB4s1qB64IglBatXThmFuTcSCSvOBQxcpHqhE1gCa5
	cc1bVpa4B+Wx5tI2/VAxHjM9BAQxtRYxQqJYzz5RIsvw2XLehyYfS1YmMviYNl2oUDW1ZlJ5e
	BJ4AJcCGWg2Wcnh6pLm/beOPlRuGcGWeAFwYVrCwAAZUwYJ/IJQERmNXTvBd9SLs/+b6ZggA1
	cR0unxzace/HJtXmZs0xLoj2M6yriSjcjb6FNWAu24YNcM2W9MYw8knN6GpZ82ngm1dHWMZOP
	fzWPEzhGxAACr70m5SNxqfeaT15ZjAIQ8YhAQO2SI7exlmwS5XcjwiPUrkCxRafBIj+KemcQt
	Qjz1LRWNY/yxvL4Ch3UJ91HjATDz1ffddYMlceFe0CyfNKrWuw9xOUSAGQFmAkpYM96oAyP0n
	/BY04v4kymM/t2XOpe6f8uYNtZOCO1iFgVep/a8SetK3r0IjmaLfJ0k4Nx4Nsncak1mVwqtEP
	u6sbxGOTm/nBnz3wTEk8rT/ThGbB1L87Ab11yyHrOBLRBa6gB750k/eRd4c=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.73
Subject: [Qemu-devel] [PATCH 1/5] tricore: add FTOIZ instruction
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
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
index 352f52bb4a..66cdc63286 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -6764,6 +6764,9 @@ static void decode_rr_divide(CPUTriCoreState *env, DisasContext *ctx)
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
2.17.1


