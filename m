Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 102E3C433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:23:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC2272073A
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QTHtXdGy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC2272073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCmaR-00051n-Vn
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 12:23:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34086)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmKc-0004td-TL
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:06:54 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634]:33304)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmKa-00062K-Pz
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:06:54 -0400
Received: by mail-pl1-x634.google.com with SMTP id h2so3257164plr.0
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 09:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4WVvMqAD78oNbWSebHTpYzLYCLnpF5xHe/3shPVHdfE=;
 b=QTHtXdGy2iVUcaumxu4SBJlBPqlteNQpRMWOqRE4TXv1J1YI1IgiFgSYm/HHH1GpG0
 3DcoutpxqcEd53DWPc7MnkGHFWNFyDHNCfgtbuFHDUFqA57I++V+NElScpn6JY865yqe
 yN4fX3y2CUWo9DnaHOrBPD4/d/eUnPD9hDAGrezR0DTCcT7VDG4HxGT1I7UOqzYpCpJd
 TWxG3CXPX8t5BQLOwv7kbKFzvL17INAmpiUhk4fVewCsZBjKOD3OykimeM0Ea+fduwTV
 J6yDBBLayK5mbyvddu9V55bV+iprwOcgDL84Q9WFvAxMNrqZwO/H5mpThO1LS2iBX8t9
 omyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4WVvMqAD78oNbWSebHTpYzLYCLnpF5xHe/3shPVHdfE=;
 b=Nx89meKhIlD7AOBtRM6nNEvuHmJBKnrG76GyMwSrMFdoFe/zjC81gBk7x2MG0fjZAG
 mSkHfPsiKi9m6LFQMCGSyz8Vf22963xhT6o5yCwwPFzeTzo1qfp0LA8JhuUCcV0Zbxk6
 eYADAinK412Tp4CSXpu4buFZ/CBu376E79WVoBrBxaritOX/GKuIF9OzkULTHY2lP4BP
 pp65OyMKbwj8uBM3q1PggPLFmh1GuFSwK7CbA+GeFCfg9Xa1usTCd/4apk5XdgINfEah
 /5bn72rdrG/pjhGNTtOPpxMSKM53wMo5ErES8SAwHQNgWEnO3Mjvzcm6pswTX8DzZOqZ
 MMxg==
X-Gm-Message-State: AOAM533dLHQ+S927Tmfwsa0AfWWhFVoSQQ8hD++zGalOsbD1m0MCIE5m
 IqyOcAQA+UmN6TPNC/BgcHIxy9l9avskbg==
X-Google-Smtp-Source: ABdhPJxWjUdm0svKrbKTzKTuVl5MNG9EWFm36ehyNio88GGCGf2ucyg9TpjmBJ+l5KL83N1Pvc5DEw==
X-Received: by 2002:a17:90b:4b89:: with SMTP id
 lr9mr92919pjb.190.1598890010991; 
 Mon, 31 Aug 2020 09:06:50 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id gt13sm17218pjb.43.2020.08.31.09.06.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2020 09:06:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 35/76] target/microblaze: Add decodetree infrastructure
Date: Mon, 31 Aug 2020 09:05:20 -0700
Message-Id: <20200831160601.833692-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831160601.833692-1-richard.henderson@linaro.org>
References: <20200831160601.833692-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The new interface is a stub that recognizes no instructions.
It falls back to the old decoder for all instructions.

Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
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


