Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACAC5C433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:51:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7322C207DF
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JdH2Kdau"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7322C207DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBfiV-0002LO-Jz
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 10:50:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52150)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfFa-0002dw-VH
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:21:06 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429]:38386)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfFY-0005SW-Vb
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:21:06 -0400
Received: by mail-pf1-x429.google.com with SMTP id d22so739663pfn.5
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 07:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=S1J1OXIAUboVyh3Ty609ni6o6b4zaR4IGzxYSfN+fuo=;
 b=JdH2KdauXdi8ZY56ME2elaPcQKpTJbJ4NBo/3Hz2mLwkV63pe+7ChJRUxCZdUSs917
 my+7TzPUr9xaAJDL2GGKddmh+7HTTiJq+eDgLgDWbJcNqs3jPc3F9qiqWOPqWFitaDSc
 6JyBCkzeoZxUW0w2MJaaHJ3ipfeUO9EFFI89S4wd+wvRM7gHZ4ipNGGzdrfp47HmlAfO
 ZtjZ5/U4z87NlFtBvU9vn9LNB/LrA4AxS5qTW7JpHay6ViHGXODreR+c209uj8BVgD4q
 N4hSJxVUq2gqh8RKDocFTpWrH5RjglGk4nB/xMPmwEu0btdpG7yGAciG1feool3YVpaw
 /OVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=S1J1OXIAUboVyh3Ty609ni6o6b4zaR4IGzxYSfN+fuo=;
 b=IX8K43L7ccb7ylPwZsHA41v6w1H5diL9zwUSz73ERMJJAm4huM0tJMkEptyLSnBWh6
 N035N7HlfRK3Gd08vlCr9BTA2E4H2ZOyM429ZTobrKkNjJ2ERt86WHNNPRzc3h/wRuEX
 PcERNk0qX9akWhJwaxJzvneePC5pvrjqtCwzr9TZdVFiL+Pqpt1pwuXaE+1hXSr/RJEl
 A31/P3tdgMGqmvD4M8VhvwdK5N71CkGtGl4F1iQowOGrNqpcwhN/1v7bLPG6vP3J4CDj
 zveBONKdJCyEKhiD6ouw5DsJSh//bBi6oHCvpX48HrCHSjrwJYnEsiaRIFiMsxhUv+bs
 hkQA==
X-Gm-Message-State: AOAM532l3eC9cdELfcGbeGeKnoHg1pmndfTkjA+hvWQNZ8kgYB/KQ3G1
 PWaFOogeByhoMQS3vijo0xKRDujnS06gAg==
X-Google-Smtp-Source: ABdhPJzqG95jYdNgZB3Zf4SyxQmadZVRk0zSxCpnFYPJE1pgt062gZzpHbGkhBZD41nLdm+1sXFikw==
X-Received: by 2002:a62:27c7:: with SMTP id n190mr1483381pfn.128.1598624463015; 
 Fri, 28 Aug 2020 07:21:03 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id j3sm1403080pjw.23.2020.08.28.07.21.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 07:21:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 72/76] target/microblaze: Convert dec_stream to decodetree
Date: Fri, 28 Aug 2020 07:19:25 -0700
Message-Id: <20200828141929.77854-73-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200828141929.77854-1-richard.henderson@linaro.org>
References: <20200828141929.77854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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
Cc: edgar.iglesias@xilinx.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/insns.decode |  6 ++++
 target/microblaze/translate.c  | 64 ++++++++++++++++++++++++++--------
 2 files changed, 55 insertions(+), 15 deletions(-)

diff --git a/target/microblaze/insns.decode b/target/microblaze/insns.decode
index 43c9e16819..fb0f0e6838 100644
--- a/target/microblaze/insns.decode
+++ b/target/microblaze/insns.decode
@@ -159,6 +159,9 @@ flt             010110 ..... ..... ----- 0101 000 0000  @typea0
 fint            010110 ..... ..... ----- 0110 000 0000  @typea0
 fsqrt           010110 ..... ..... 00000 0111 000 0000  @typea0
 
+get             011011 rd:5  00000 0 ctrl:5 000000 imm:4
+getd            010011 rd:5  00000 rb:5  0 ctrl:5  00000
+
 idiv            010010 ..... ..... ..... 000 0000 0000  @typea
 idivu           010010 ..... ..... ..... 000 0000 0010  @typea
 
@@ -201,6 +204,9 @@ pcmpbf          100000 ..... ..... ..... 100 0000 0000  @typea
 pcmpeq          100010 ..... ..... ..... 100 0000 0000  @typea
 pcmpne          100011 ..... ..... ..... 100 0000 0000  @typea
 
+put             011011 00000 ra:5  1 ctrl:5 000000 imm:4
+putd            010011 00000 ra:5  rb:5  1 ctrl:5  00000
+
 rsub            000001 ..... ..... ..... 000 0000 0000  @typea
 rsubc           000011 ..... ..... ..... 000 0000 0000  @typea
 rsubk           000101 ..... ..... ..... 000 0000 0000  @typea
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 582f5a1577..2c87d671ae 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1560,33 +1560,68 @@ static void dec_null(DisasContext *dc)
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
+    gen_helper_put(t_id, t_ctrl, reg_for_read(dc, ra));
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
@@ -1596,7 +1631,6 @@ static struct decoder_info {
     };
     void (*dec)(DisasContext *dc);
 } decinfo[] = {
-    {DEC_STREAM, dec_stream},
     {{0, 0}, dec_null}
 };
 
-- 
2.25.1


