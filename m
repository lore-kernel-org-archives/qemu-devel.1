Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 087BCC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:23:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF93520738
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:23:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R8tZQiaL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF93520738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAgPe-0003YS-Ue
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 17:23:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36596)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg4M-0000hB-Ce
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:01:26 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:35182)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg4K-00024D-HU
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:01:26 -0400
Received: by mail-pg1-x542.google.com with SMTP id o5so7680871pgb.2
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 14:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LiD17jdfSZ6zoYmLZKhAoxxQtSYU9ummw+8AuEiDbOo=;
 b=R8tZQiaLS9/YAgwtVCL2/g3j86yToLIsJ+rqSz4s2NVvAGijfAOr3EgpEkZSsDg+Zc
 tc0OjblT7GK99/ZaFQkL6ecNEO4jV+QnFIk7r/VxhyneRzmbNQp1OjVpYknpj6u+YbFU
 uJU+2pAm9bRiKbLfG9rQaciVloKr2k0WwUQ33xvZcL3Rm7DYocpWJbjhqChwHQcccXmN
 mbVAAxnscPBXnpU6kALbykHm0FCjrX211Orz09JG/PUUB67gToYpDGLGhTalPLe8NWBt
 q625uOtBDPC++jsl1WeUUav8q5ipSK/jItYB0nkoU0YXpa86z88E5sEL+SEADLM4YYAR
 FciA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LiD17jdfSZ6zoYmLZKhAoxxQtSYU9ummw+8AuEiDbOo=;
 b=V/Kh0wofEfWvVSKX5t83gKxlYvDOv7oGYZkzDfr564mf8xLAF+4vyOQ0jeBvZ80dke
 zz/9+O1/9/qgIyi1NCKe2P8GZgqWxzwLDxbOMT6y6kTXAWCBlTTwpMT8rQOCd7lGS5Wa
 nX78qKm83JC+sA2HUKrI4vJadOPvPiPFOT+jr9Z/SlSKhyBJLxGWl7AEsvZrPkfgrzBJ
 s8KVswQQOCquWDSsd+VodEe2PtKD/WHMPlneU3VaN+qKK5bELQlpdNMMKr+twdxGqSBj
 pp3uGZglzhEdQ9Hzoxt685atQu1XfXSq9PVg5861dsbZeTxqMz/pGOqzM/bQZ9S4QLMI
 UsSg==
X-Gm-Message-State: AOAM533UoL63PJL2n0Di1WnIOkC3x06HJqUDV8bwiPowVyFOoMy2qcCr
 BEonSicOZEx83d9L8jVodxaobrGmWYykZQ==
X-Google-Smtp-Source: ABdhPJwvBfhMZPsw/skpHFho6dPD08MWClD6suBhACS9fU261+PYBH/tuWmgZbJInbpQSjlNBnC6Ig==
X-Received: by 2002:a05:6a00:2285:: with SMTP id
 f5mr9213748pfe.173.1598389282779; 
 Tue, 25 Aug 2020 14:01:22 -0700 (PDT)
Received: from localhost.localdomain
 (h216-228-167-147.bendor.dedicated.static.tds.net. [216.228.167.147])
 by smtp.gmail.com with ESMTPSA id k4sm16074pgr.87.2020.08.25.14.01.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2020 14:01:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 69/77] target/microblaze: Convert dec_rts to decodetree
Date: Tue, 25 Aug 2020 13:59:42 -0700
Message-Id: <20200825205950.730499-70-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200825205950.730499-1-richard.henderson@linaro.org>
References: <20200825205950.730499-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
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
 target/microblaze/insns.decode |  5 ++++
 target/microblaze/translate.c  | 54 +++++++++++++++-------------------
 2 files changed, 29 insertions(+), 30 deletions(-)

diff --git a/target/microblaze/insns.decode b/target/microblaze/insns.decode
index 21d08289f7..f12e85b492 100644
--- a/target/microblaze/insns.decode
+++ b/target/microblaze/insns.decode
@@ -199,6 +199,11 @@ rsubic          001011 ..... ..... ................     @typeb
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
index f79b02e987..22569693f7 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1291,6 +1291,30 @@ static bool trans_mbar(DisasContext *dc, arg_mbar *arg)
     return true;
 }
 
+static bool do_rts(DisasContext *dc, arg_typeb_bc *arg, int to_set)
+{
+    if (trap_userspace(dc, to_set)) {
+        return true;
+    }
+    if (setup_dslot(dc)) {
+        return true;
+    }
+    dc->tb_flags_to_set |= to_set;
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
 
 static void msr_read(DisasContext *dc, TCGv_i32 d)
 {
@@ -1553,35 +1577,6 @@ static inline void do_rte(DisasContext *dc)
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
-    if (setup_dslot(dc)) {
-        return;
-    }
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
@@ -1629,7 +1624,6 @@ static struct decoder_info {
     };
     void (*dec)(DisasContext *dc);
 } decinfo[] = {
-    {DEC_RTS, dec_rts},
     {DEC_MSR, dec_msr},
     {DEC_STREAM, dec_stream},
     {{0, 0}, dec_null}
-- 
2.25.1


