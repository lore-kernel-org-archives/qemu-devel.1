Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05AA1C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:24:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD16B20738
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:24:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JirQcFos"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD16B20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAgQi-0005tR-Uj
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 17:24:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35932)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg3d-0007vl-0v
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:00:41 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:36391)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg3a-0001qp-Oz
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:00:40 -0400
Received: by mail-pj1-x1041.google.com with SMTP id q1so127786pjd.1
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 14:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+kEx0UptQCrtmnph6sgV6tFoh7UCNGXW3aCpI+f1tQA=;
 b=JirQcFosAldNZ6rO3H280is1x7IULX1PDBdPGd8uRJlUHzt6usQsJH4G2C84x3Dqf5
 PIJnchcgAlY1gX9d766RFTcyWGdA8uL1xcje11qb4LJzA7s7YtVI+gextsJNbIslVILB
 Iln98xYoWhJmuOhEXeNV+kuRRJU8QfdfePFFG5mTupp+dNBrK4mGmgcmnVV+DiLDcd49
 XRYvgWFVVuN9D/twJTqSR8d52JT9BvaDiPSy4Kx+RPgYEhfSMk7ufnb4+MfbxG2IPcAa
 8ccHya6h9jHcVU29TNiknuLdgcn1gglsYlTg7LuJu7lrJYQZONEgkYyE7XWfrO2qUgrw
 a7pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+kEx0UptQCrtmnph6sgV6tFoh7UCNGXW3aCpI+f1tQA=;
 b=BfpjMmrNVvM8mbEpvwEyexnau48jZ/K2Cz4jCREjnHDomXq21Q0jDYKcei5ecR44iw
 8KPJmxIB6dgEM8F1YKEmT2uBsf7Z3uDZHTnG1kTe6wkCUtiP37RunLxjy1CvtAHlkT7o
 TxG4bs51IJZpomD3JCw55K2yMmkVlj6W1lbtPHB+SeSLN0t9YMEvo/WtzXYZ4IiTb0ha
 73NszmMhhes1acn3NW2m+W1yYohqVYmbWNHswSRQDPaGumYo4EZk0QS5tCAAp0jSWz/2
 gQNu19sd91WAbYiuGie/hWYFy5nCty5GCLriurJSX8ukvyGV+tsGBs5bX7BGTccktFgS
 sEoA==
X-Gm-Message-State: AOAM532i3+cr2mBD9ixltLGs8qiw8vrVKCld62DyPS8aa0QTHVjJe9yC
 ZevtSFhW1xn6J85tbNSLwOV8x0uUOnw6dQ==
X-Google-Smtp-Source: ABdhPJwuLlJ8t9RgDEIv81vfPjWICQjTgUAwio3om+FZ90Sq/Iwgaz7OyXK+kwHwpviVWMqHugVGdQ==
X-Received: by 2002:a17:90b:1108:: with SMTP id
 gi8mr2960746pjb.7.1598389237031; 
 Tue, 25 Aug 2020 14:00:37 -0700 (PDT)
Received: from localhost.localdomain
 (h216-228-167-147.bendor.dedicated.static.tds.net. [216.228.167.147])
 by smtp.gmail.com with ESMTPSA id k4sm16074pgr.87.2020.08.25.14.00.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2020 14:00:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 35/77] target/microblaze: Add decodetree infrastructure
Date: Tue, 25 Aug 2020 13:59:08 -0700
Message-Id: <20200825205950.730499-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200825205950.730499-1-richard.henderson@linaro.org>
References: <20200825205950.730499-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: edgar.iglesias@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The new interface is a stub that recognizes no instructions.
It falls back to the old decoder for all instructions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/insns.decode | 18 ++++++++++++++++++
 target/microblaze/translate.c  | 11 +++++++++--
 target/microblaze/meson.build  |  3 +++
 3 files changed, 30 insertions(+), 2 deletions(-)
 create mode 100644 target/microblaze/insns.decode

diff --git a/target/microblaze/insns.decode b/target/microblaze/insns.decode
new file mode 100644
index 0000000000..1ed9ca0731
--- /dev/null
+++ b/target/microblaze/insns.decode
@@ -0,0 +1,18 @@
+#
+# MicroBlaze instruction decode definitions.
+#
+# Copyright (c) 2020 Richard Henderson <rth@twiddle.net>
+#
+# This library is free software; you can redistribute it and/or
+# modify it under the terms of the GNU Lesser General Public
+# License as published by the Free Software Foundation; either
+# version 2.1 of the License, or (at your option) any later version.
+#
+# This library is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+# Lesser General Public License for more details.
+#
+# You should have received a copy of the GNU Lesser General Public
+# License along with this library; if not, see <http://www.gnu.org/licenses/>.
+#
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 65ce8f3cd6..e624093745 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -81,6 +81,9 @@ typedef struct DisasContext {
     int abort_at_next_insn;
 } DisasContext;
 
+/* Include the auto-generated decoder.  */
+#include "decode-insns.c.inc"
+
 static inline void t_sync_flags(DisasContext *dc)
 {
     /* Synch the tb dependent flags between translator and runtime.  */
@@ -1506,7 +1509,7 @@ static struct decoder_info {
     {{0, 0}, dec_null}
 };
 
-static inline void decode(DisasContext *dc, uint32_t ir)
+static void old_decode(DisasContext *dc, uint32_t ir)
 {
     int i;
 
@@ -1584,6 +1587,7 @@ static void mb_tr_translate_insn(DisasContextBase *dcb, CPUState *cs)
 {
     DisasContext *dc = container_of(dcb, DisasContext, base);
     CPUMBState *env = cs->env_ptr;
+    uint32_t ir;
 
     /* TODO: This should raise an exception, not terminate qemu. */
     if (dc->base.pc_next & 3) {
@@ -1592,7 +1596,10 @@ static void mb_tr_translate_insn(DisasContextBase *dcb, CPUState *cs)
     }
 
     dc->clear_imm = 1;
-    decode(dc, cpu_ldl_code(env, dc->base.pc_next));
+    ir = cpu_ldl_code(env, dc->base.pc_next);
+    if (!decode(dc, ir)) {
+        old_decode(dc, ir);
+    }
     if (dc->clear_imm && (dc->tb_flags & IMM_FLAG)) {
         dc->tb_flags &= ~IMM_FLAG;
         tcg_gen_discard_i32(cpu_imm);
diff --git a/target/microblaze/meson.build b/target/microblaze/meson.build
index b8fe4afe61..639c3f73a8 100644
--- a/target/microblaze/meson.build
+++ b/target/microblaze/meson.build
@@ -1,4 +1,7 @@
+gen = decodetree.process('insns.decode')
+
 microblaze_ss = ss.source_set()
+microblaze_ss.add(gen)
 microblaze_ss.add(files(
   'cpu.c',
   'gdbstub.c',
-- 
2.25.1


