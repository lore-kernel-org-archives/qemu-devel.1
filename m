Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A11C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:48:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EC202071E
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cw4220VZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EC202071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAgnx-0003dK-D4
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 17:48:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36688)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg4U-0000jz-Nd
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:01:37 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b]:50602)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg4P-00024m-UO
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:01:34 -0400
Received: by mail-pj1-x102b.google.com with SMTP id i13so131293pjv.0
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 14:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sTzoHpTs6c42UNIKcjYj4AhcDm+2RYpkHEK+aRGbqEc=;
 b=cw4220VZyJl6GMsoTzaGf2jQSw3HHqj6uIL0Jdgoicdo6ph97xyqGLwnoBadfsLz5o
 0tb11+Tm4M3xqlhqfNZ1BlzYxO3oVtyjocqOZuwJEHpOIqD5vLVpquxo0+nHnTnpeEWe
 47YhXIxOy+1kXYAsDY8e8YYsXEhzsCkweV1BU3buyFv/AxbcsZU4nuQ9dAQWyKBbBLYu
 yDVxaeby5tdt2w0k6NvtY6gmzPp5SYNmpPwQZM2icOVpI6e/k5HTidOKQJXODon02MsU
 7rZJtoC3CkIlcHQgbQcGinMQyfbBkxls4rRcaRzt1kLrBNyjZVnvmBO9JK4FDjTX/6QK
 EaoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sTzoHpTs6c42UNIKcjYj4AhcDm+2RYpkHEK+aRGbqEc=;
 b=GVfnztabBQPh4p/8U0Jw2qHs8b+wXyylmusOYGTDJMUxNTellwiU6mv+PAHo4/VQ5w
 3QutcMGVMAQVcHdAIx7Ta7dfyG79TSOqUWYCiVIk4wDapw0K/0HxjjUb1wwL3u89avmv
 UPpiOVYL7RlmlJtGKnuHZ3eiJH76NzynPb4A3G2Ubg8HqWahig2yglXZ5qKivhYuvmJP
 PTtc1eHw6Li7vtwxM4jQdTmaWXF5OADJ/Uslcdd0R3ccp9WkTczBB9kFm0Kaedbh9IrO
 1wtP90i264/nOlnCbQ9M99vGmG4wP5zpgxgVECBWvd2zvHw/3oBRfuAh1WMYh1hQtiwV
 CKfA==
X-Gm-Message-State: AOAM530ycq5QhpJKDTHx2ekSuaASTu/5roiiGYJZwn9R9BLYqoF0FshR
 dh9NLCsxPeRxTD2BGTr7lcjwFfzgLpprVg==
X-Google-Smtp-Source: ABdhPJztrT/qQFhbMaVtFwrVibZLRkvk+iYX38JMuzy4v4GTfXaPA8ZiRFra0y7HlQrMDwD8aZSulA==
X-Received: by 2002:a17:90a:b008:: with SMTP id
 x8mr3034133pjq.75.1598389288200; 
 Tue, 25 Aug 2020 14:01:28 -0700 (PDT)
Received: from localhost.localdomain
 (h216-228-167-147.bendor.dedicated.static.tds.net. [216.228.167.147])
 by smtp.gmail.com with ESMTPSA id k4sm16074pgr.87.2020.08.25.14.01.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2020 14:01:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 73/77] target/microblaze: Convert dec_stream to decodetree
Date: Tue, 25 Aug 2020 13:59:46 -0700
Message-Id: <20200825205950.730499-74-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200825205950.730499-1-richard.henderson@linaro.org>
References: <20200825205950.730499-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/insns.decode |  6 ++++
 target/microblaze/translate.c  | 64 ++++++++++++++++++++++++++--------
 2 files changed, 55 insertions(+), 15 deletions(-)

diff --git a/target/microblaze/insns.decode b/target/microblaze/insns.decode
index 48c60082e0..79d32c826c 100644
--- a/target/microblaze/insns.decode
+++ b/target/microblaze/insns.decode
@@ -156,6 +156,9 @@ flt             010110 ..... ..... ----- 0101 000 0000  @typea0
 fint            010110 ..... ..... ----- 0110 000 0000  @typea0
 fsqrt           010110 ..... ..... 00000 0111 000 0000  @typea0
 
+get             011011 rd:5  00000 0 ctrl:5 000000 imm:4
+getd            010011 rd:5  00000 rb:5  0 ctrl:5  00000
+
 idiv            010010 ..... ..... ..... 000 0000 0000  @typea
 idivu           010010 ..... ..... ..... 000 0000 0010  @typea
 
@@ -198,6 +201,9 @@ pcmpbf          100000 ..... ..... ..... 100 0000 0000  @typea
 pcmpeq          100010 ..... ..... ..... 100 0000 0000  @typea
 pcmpne          100011 ..... ..... ..... 100 0000 0000  @typea
 
+put             011011 00000 ra:5  1 ctrl:5 000000 imm:4
+putd            010011 00000 ra:5  rb:5  1 ctrl:5  00000
+
 rsub            000001 ..... ..... ..... 000 0000 0000  @typea
 rsubc           000011 ..... ..... ..... 000 0000 0000  @typea
 rsubk           000101 ..... ..... ..... 000 0000 0000  @typea
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index e9e4a0e1db..0a05b49f8e 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1587,33 +1587,68 @@ static void dec_null(DisasContext *dc)
 }
 
 /* Insns connected to FSL or AXI stream attached devices.  */
-static void dec_stream(DisasContext *dc)
+static bool do_get(DisasContext *dc, int rd, int rb, int imm, int ctrl)
 {
     TCGv_i32 t_id, t_ctrl;
-    int ctrl;
 
     if (trap_userspace(dc, true)) {
-        return;
+        return true;
     }
 
     t_id = tcg_temp_new_i32();
-    if (dc->type_b) {
-        tcg_gen_movi_i32(t_id, dc->imm & 0xf);
-        ctrl = dc->imm >> 10;
+    if (rb) {
+        tcg_gen_andi_i32(t_id, cpu_R[rb], 0xf);
     } else {
-        tcg_gen_andi_i32(t_id, cpu_R[dc->rb], 0xf);
-        ctrl = dc->imm >> 5;
+        tcg_gen_movi_i32(t_id, imm);
     }
 
     t_ctrl = tcg_const_i32(ctrl);
-
-    if (dc->rd == 0) {
-        gen_helper_put(t_id, t_ctrl, cpu_R[dc->ra]);
-    } else {
-        gen_helper_get(cpu_R[dc->rd], t_id, t_ctrl);
-    }
+    gen_helper_get(reg_for_write(dc, rd), t_id, t_ctrl);
     tcg_temp_free_i32(t_id);
     tcg_temp_free_i32(t_ctrl);
+    return true;
+}
+
+static bool trans_get(DisasContext *dc, arg_get *arg)
+{
+    return do_get(dc, arg->rd, 0, arg->imm, arg->ctrl);
+}
+
+static bool trans_getd(DisasContext *dc, arg_getd *arg)
+{
+    return do_get(dc, arg->rd, arg->rb, 0, arg->ctrl);
+}
+
+static bool do_put(DisasContext *dc, int ra, int rb, int imm, int ctrl)
+{
+    TCGv_i32 t_id, t_ctrl;
+
+    if (trap_userspace(dc, true)) {
+        return true;
+    }
+
+    t_id = tcg_temp_new_i32();
+    if (rb) {
+        tcg_gen_andi_i32(t_id, cpu_R[rb], 0xf);
+    } else {
+        tcg_gen_movi_i32(t_id, imm);
+    }
+
+    t_ctrl = tcg_const_i32(ctrl);
+    gen_helper_get(t_id, t_ctrl, reg_for_read(dc, ra));
+    tcg_temp_free_i32(t_id);
+    tcg_temp_free_i32(t_ctrl);
+    return true;
+}
+
+static bool trans_put(DisasContext *dc, arg_put *arg)
+{
+    return do_put(dc, arg->ra, 0, arg->imm, arg->ctrl);
+}
+
+static bool trans_putd(DisasContext *dc, arg_putd *arg)
+{
+    return do_put(dc, arg->ra, arg->rb, 0, arg->ctrl);
 }
 
 static struct decoder_info {
@@ -1623,7 +1658,6 @@ static struct decoder_info {
     };
     void (*dec)(DisasContext *dc);
 } decinfo[] = {
-    {DEC_STREAM, dec_stream},
     {{0, 0}, dec_null}
 };
 
-- 
2.25.1


