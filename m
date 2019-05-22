Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C2AC282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 19:23:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C63AC2184E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 19:23:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C63AC2184E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50044 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTWpo-0008J2-Vh
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 15:23:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hTWRz-0003FR-PV
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:58:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hTWRy-0000Oi-9A
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:58:55 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:60492 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1hTWRx-0000NP-SZ
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:58:54 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.rt-rk.com (Postfix) with ESMTP id ACE3C1A4516;
	Wed, 22 May 2019 20:58:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
	[10.10.13.43])
	by mail.rt-rk.com (Postfix) with ESMTPSA id 852CD1A453C;
	Wed, 22 May 2019 20:58:49 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Wed, 22 May 2019 20:58:38 +0200
Message-Id: <1558551522-24147-8-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558551522-24147-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1558551522-24147-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PULL v2 07/11] target/mips: Refactor and fix
 INSERT.<B|H|W|D> instructions
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
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>

The old version of the helper for the INSERT.<B|H|W|D> MSA instructions
has been replaced with four helpers that don't use switch, and change
the endianness of the given index, when executed on a big endian host.

Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Message-Id: <1554212605-16457-6-git-send-email-mateja.marjanovic@rt-rk.com>
---
 target/mips/helper.h     |  5 +++-
 target/mips/msa_helper.c | 65 ++++++++++++++++++++++++++++++++++++------------
 target/mips/translate.c  | 19 +++++++++++++-
 3 files changed, 71 insertions(+), 18 deletions(-)

diff --git a/target/mips/helper.h b/target/mips/helper.h
index c4a77e2..2863f60 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -877,7 +877,6 @@ DEF_HELPER_5(msa_hsub_u_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(msa_sldi_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(msa_splati_df, void, env, i32, i32, i32, i32)
 
-DEF_HELPER_5(msa_insert_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(msa_insve_df, void, env, i32, i32, i32, i32)
 DEF_HELPER_3(msa_ctcmsa, void, env, tl, i32)
 DEF_HELPER_2(msa_cfcmsa, tl, env, i32)
@@ -944,6 +943,10 @@ DEF_HELPER_4(msa_copy_s_d, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_copy_u_b, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_copy_u_h, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_copy_u_w, void, env, i32, i32, i32)
+DEF_HELPER_4(msa_insert_b, void, env, i32, i32, i32)
+DEF_HELPER_4(msa_insert_h, void, env, i32, i32, i32)
+DEF_HELPER_4(msa_insert_w, void, env, i32, i32, i32)
+DEF_HELPER_4(msa_insert_d, void, env, i32, i32, i32)
 
 DEF_HELPER_4(msa_fclass_df, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_ftrunc_s_df, void, env, i32, i32, i32)
diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
index 52680fe..ee1b1fa 100644
--- a/target/mips/msa_helper.c
+++ b/target/mips/msa_helper.c
@@ -1340,28 +1340,61 @@ void helper_msa_copy_u_w(CPUMIPSState *env, uint32_t rd,
     env->active_tc.gpr[rd] = (uint32_t)env->active_fpu.fpr[ws].wr.w[n];
 }
 
-void helper_msa_insert_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
+void helper_msa_insert_b(CPUMIPSState *env, uint32_t wd,
                           uint32_t rs_num, uint32_t n)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
     target_ulong rs = env->active_tc.gpr[rs_num];
+    n %= 16;
+#if defined(HOST_WORDS_BIGENDIAN)
+    if (n < 8) {
+        n = 8 - n - 1;
+    } else {
+        n = 24 - n - 1;
+    }
+#endif
+    pwd->b[n] = (int8_t)rs;
+}
 
-    switch (df) {
-    case DF_BYTE:
-        pwd->b[n] = (int8_t)rs;
-        break;
-    case DF_HALF:
-        pwd->h[n] = (int16_t)rs;
-        break;
-    case DF_WORD:
-        pwd->w[n] = (int32_t)rs;
-        break;
-    case DF_DOUBLE:
-        pwd->d[n] = (int64_t)rs;
-        break;
-    default:
-        assert(0);
+void helper_msa_insert_h(CPUMIPSState *env, uint32_t wd,
+                          uint32_t rs_num, uint32_t n)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    target_ulong rs = env->active_tc.gpr[rs_num];
+    n %= 8;
+#if defined(HOST_WORDS_BIGENDIAN)
+    if (n < 4) {
+        n = 4 - n - 1;
+    } else {
+        n = 12 - n - 1;
+    }
+#endif
+    pwd->h[n] = (int16_t)rs;
+}
+
+void helper_msa_insert_w(CPUMIPSState *env, uint32_t wd,
+                          uint32_t rs_num, uint32_t n)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    target_ulong rs = env->active_tc.gpr[rs_num];
+    n %= 4;
+#if defined(HOST_WORDS_BIGENDIAN)
+    if (n < 2) {
+        n = 2 - n - 1;
+    } else {
+        n = 6 - n - 1;
     }
+#endif
+    pwd->w[n] = (int32_t)rs;
+}
+
+void helper_msa_insert_d(CPUMIPSState *env, uint32_t wd,
+                          uint32_t rs_num, uint32_t n)
+{
+    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
+    target_ulong rs = env->active_tc.gpr[rs_num];
+    n %= 2;
+    pwd->d[n] = (int64_t)rs;
 }
 
 void helper_msa_insve_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 68ea6ee..dd706ad 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -28346,7 +28346,24 @@ static void gen_msa_elm_df(CPUMIPSState *env, DisasContext *ctx, uint32_t df,
             }
             break;
         case OPC_INSERT_df:
-            gen_helper_msa_insert_df(cpu_env, tdf, twd, tws, tn);
+            switch (df) {
+            case DF_BYTE:
+                gen_helper_msa_insert_b(cpu_env, twd, tws, tn);
+                break;
+            case DF_HALF:
+                gen_helper_msa_insert_h(cpu_env, twd, tws, tn);
+                break;
+            case DF_WORD:
+                gen_helper_msa_insert_w(cpu_env, twd, tws, tn);
+                break;
+#if defined(TARGET_MIPS64)
+            case DF_DOUBLE:
+                gen_helper_msa_insert_d(cpu_env, twd, tws, tn);
+                break;
+#endif
+            default:
+                assert(0);
+            }
             break;
         }
         break;
-- 
2.7.4


