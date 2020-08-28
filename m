Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F7DC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:55:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7CA420848
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qLeGHQN8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7CA420848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBfn8-00033K-3v
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 10:55:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52062)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfFV-0002QK-Rd
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:21:01 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:33318)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfFT-0005RI-Ur
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:21:01 -0400
Received: by mail-pl1-x642.google.com with SMTP id h2so540833plr.0
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 07:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JAaLtIFS218jhrIntO1CQBLV81E0LrWrKQYBwcRx/ss=;
 b=qLeGHQN8piX0iQLsD4gji7uRrL4cecjHuSY0wXonxtlxgn3Nu7DXVUHSQMwzPrJcdm
 O6saoHhKqfrjj355bqUWjLvQSn8CrvsopWGUEfMB7IiXP8Y/TtWKKmyc+tFyWHC4962P
 KlmEhhq1/rxbB/9Pow1f1GgAeTD+a8ZVcTsiNWahqTonYWkv+IDe+JfmpCvDG2IYWS0d
 Rq6Im67ouWoxE6t6lN2NSAXKv2pM/skQVE+XlEqlZ2ZblMQkGP8Zo+bAfXk8LzrLqwfa
 V27LTPx6jrnHeR6BvQ4PVv//QM3IcMUJdUvh3LfOcof1JMkazYOzqraHUdZAOhcg3/Pd
 t5pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JAaLtIFS218jhrIntO1CQBLV81E0LrWrKQYBwcRx/ss=;
 b=es6pQ3mbq4K5E5fhfNT7MmiJP3VDJo55gf+KY6Yfv32/gxZH/PpYKi7fYNXa/ZvfbW
 Zs5OTSsIZjKHF/Aru42dyTLeAVvRROjlrkRcCty9TWsAivqXCMnhDu4qA2HW5VHQaCqe
 D16HFNgqNutqUahxdZIC3MF1PHLn5sFqCHKEn+1Qx7ulITR98NMR5B3W7QrTcfU6He3K
 35Is+nn/ojSKceQz19pTZPEtJL3pt1UzPcPBhV6TzQOdWE808u/nhPIJ1Fgz0BrHcZJw
 GjEKlsgzbJw0Bz4uRtTSHZ4BrepIXL2bEQWyFRdIyqXgtPkNNAq9aQ+cYNPiVXCILU0w
 jFGQ==
X-Gm-Message-State: AOAM532nTtUY1NEBoBcm9v4Jo1A5xzUfo8gS8wi5H8kaQfz1lKdoEISe
 SrDmD8jYFu+N2bQLfUxeop7cWCu+gju0SQ==
X-Google-Smtp-Source: ABdhPJyQWxp6kvmZbkgHM/nznqhHuVxcUqyXU0LpyvOkwQFufOlWU3CAcoOt/XCNwPffxvsYl7jPcQ==
X-Received: by 2002:a17:902:988f:: with SMTP id
 s15mr1506833plp.26.1598624458291; 
 Fri, 28 Aug 2020 07:20:58 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id j3sm1403080pjw.23.2020.08.28.07.20.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 07:20:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 68/76] target/microblaze: Convert dec_rts to decodetree
Date: Fri, 28 Aug 2020 07:19:21 -0700
Message-Id: <20200828141929.77854-69-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200828141929.77854-1-richard.henderson@linaro.org>
References: <20200828141929.77854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x642.google.com
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
 target/microblaze/insns.decode |  5 ++++
 target/microblaze/translate.c  | 51 +++++++++++++++-------------------
 2 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/target/microblaze/insns.decode b/target/microblaze/insns.decode
index e6a61f147a..8906058a29 100644
--- a/target/microblaze/insns.decode
+++ b/target/microblaze/insns.decode
@@ -202,6 +202,11 @@ rsubic          001011 ..... ..... ................     @typeb
 rsubik          001101 ..... ..... ................     @typeb
 rsubikc         001111 ..... ..... ................     @typeb
 
+rtbd            101101 10010 ..... ................     @typeb_bc
+rtid            101101 10001 ..... ................     @typeb_bc
+rted            101101 10100 ..... ................     @typeb_bc
+rtsd            101101 10000 ..... ................     @typeb_bc
+
 sb              110100 ..... ..... ..... 0000 000 0000  @typea
 sbr             110100 ..... ..... ..... 0100 000 0000  @typea
 sbea            110100 ..... ..... ..... 0001 000 0000  @typea
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index b8dcef8f1c..6c1855b29a 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1252,6 +1252,29 @@ static bool trans_mbar(DisasContext *dc, arg_mbar *arg)
     return true;
 }
 
+static bool do_rts(DisasContext *dc, arg_typeb_bc *arg, int to_set)
+{
+    if (trap_userspace(dc, to_set)) {
+        return true;
+    }
+    dc->tb_flags_to_set |= to_set;
+    setup_dslot(dc, true);
+
+    dc->jmp_cond = TCG_COND_ALWAYS;
+    dc->jmp_dest = -1;
+    tcg_gen_addi_i32(cpu_btarget, reg_for_read(dc, arg->ra), arg->imm);
+    return true;
+}
+
+#define DO_RTS(NAME, IFLAG) \
+    static bool trans_##NAME(DisasContext *dc, arg_typeb_bc *arg) \
+    { return do_rts(dc, arg, IFLAG); }
+
+DO_RTS(rtbd, DRTB_FLAG)
+DO_RTS(rtid, DRTI_FLAG)
+DO_RTS(rted, DRTE_FLAG)
+DO_RTS(rtsd, 0)
+
 static bool trans_zero(DisasContext *dc, arg_zero *arg)
 {
     /* If opcode_0_illegal, trap.  */
@@ -1527,33 +1550,6 @@ static inline void do_rte(DisasContext *dc)
     dc->tb_flags &= ~DRTE_FLAG;
 }
 
-static void dec_rts(DisasContext *dc)
-{
-    unsigned int b_bit, i_bit, e_bit;
-
-    i_bit = dc->ir & (1 << 21);
-    b_bit = dc->ir & (1 << 22);
-    e_bit = dc->ir & (1 << 23);
-
-    if (trap_userspace(dc, i_bit || b_bit || e_bit)) {
-        return;
-    }
-
-    setup_dslot(dc, true);
-
-    if (i_bit) {
-        dc->tb_flags |= DRTI_FLAG;
-    } else if (b_bit) {
-        dc->tb_flags |= DRTB_FLAG;
-    } else if (e_bit) {
-        dc->tb_flags |= DRTE_FLAG;
-    }
-
-    dc->jmp_cond = TCG_COND_ALWAYS;
-    dc->jmp_dest = -1;
-    tcg_gen_add_i32(cpu_btarget, cpu_R[dc->ra], *dec_alu_op_b(dc));
-}
-
 static void dec_null(DisasContext *dc)
 {
     if (trap_illegal(dc, true)) {
@@ -1601,7 +1597,6 @@ static struct decoder_info {
     };
     void (*dec)(DisasContext *dc);
 } decinfo[] = {
-    {DEC_RTS, dec_rts},
     {DEC_MSR, dec_msr},
     {DEC_STREAM, dec_stream},
     {{0, 0}, dec_null}
-- 
2.25.1


