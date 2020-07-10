Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4CC6C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 13:17:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BC7B206A5
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 13:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="PDsdGMHW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BC7B206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtstn-0005Qj-Qa
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 09:17:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37544)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jtqdh-0005SZ-9R
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 06:52:21 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432]:34644)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jtqdf-0006gO-KJ
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 06:52:21 -0400
Received: by mail-pf1-x432.google.com with SMTP id u185so2395064pfu.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 03:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=kBSFjsOF78wUPVmQ5lBjOZbQCpF/mwVTJu2jvHOc3+g=;
 b=PDsdGMHWlXCRahX0RZac3AZ2gKUzzI6yvjN+0srmuTpZ04yzqN0zwQ2GegzYKvQ56C
 j00ao4GNbh66KoWWQpCm0dHGG9INV7M7zg+mJry3HfoNEv2LkvkemnHGHqukN/1f2k7v
 0a17CAdvqrsPOCwijNAh4Whyj3M0ZBv7wOiEisVfxzikPmei5sEmY0IS/lXBS1P4Jvqb
 5DU9llssjEOQ/L2xrF6ksPokQ4UC0IXWwqHDOB/iWqPgdfXevtysL5FvNmqZxBXfhJHC
 StZZwrljnIJeDAHjFz4OYORLcWzRtCw221o1urKZJPd6DFA0mt6L7t4PL5G+Qz6f04cg
 Bmng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=kBSFjsOF78wUPVmQ5lBjOZbQCpF/mwVTJu2jvHOc3+g=;
 b=sbs3SCGZ2O9Trm8hj+WmMqCd2zZkXpGhLneuLwh8wXfb4revhNilop3z/XTSZ9y5nm
 EyTC8XZwLRPd7L59T4YqcdOEQCU9F44L6cLkZF49DtcJsd4JMZSPXIhJ6SWAGaN8KHiI
 TtWxmr4Ni0oJ9FIBVa+l76uw3cwIo2E7EUgCIMDBvbXwabVy02F4rPY59ZQtoalHv+PN
 /ZedpN9s4Iq+irQYCtdH7vWd6/6XcizMQXqabnVxLpYDeCCuR5tOXr9YO0OSChiig+de
 Hdk0bbx3Cjm7Zv8t/EyRpwQiKknT/HCwjWwmV6mz6O+spvfSuZ/UdxtGVR8eILgvjUaX
 gaFQ==
X-Gm-Message-State: AOAM531K4pV7xmxoyHECUrwIxou7DKH537bpwDX0m9SJ8uE4b0q7cMqX
 av0HyU9AYaf8hjWaCDuNVOdj/tAhWNPpUg==
X-Google-Smtp-Source: ABdhPJzXgggfyVwUaRX09Yd4crffuz2bMi1LCZPdBZ4skdncVLOo/n6GuqbdYUcmojhZ00sbd2hAqQ==
X-Received: by 2002:a63:5fcc:: with SMTP id t195mr48744127pgb.56.1594378338131; 
 Fri, 10 Jul 2020 03:52:18 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id r191sm5519406pfr.181.2020.07.10.03.52.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2020 03:52:17 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC 26/65] target/riscv: rvv-0.9: set-X-first mask bit instructions
Date: Fri, 10 Jul 2020 18:48:40 +0800
Message-Id: <20200710104920.13550-27-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200710104920.13550-1-frank.chang@sifive.com>
References: <20200710104920.13550-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=frank.chang@sifive.com; helo=mail-pf1-x432.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 10 Jul 2020 08:57:17 -0400
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
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Frank Chang <frank.chang@sifive.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Frank Chang <frank.chang@sifive.com>

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/insn32.decode              |  6 ++---
 target/riscv/insn_trans/trans_rvv.inc.c | 32 +++++++++++++------------
 target/riscv/vector_helper.c            |  4 ----
 3 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index b5b59fe6dd..37b2582981 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -575,9 +575,9 @@ vmornot_mm      011100 - ..... ..... 010 ..... 1010111 @r
 vmxnor_mm       011111 - ..... ..... 010 ..... 1010111 @r
 vpopc_m         010000 . ..... 10000 010 ..... 1010111 @r2_vm
 vfirst_m        010000 . ..... 10001 010 ..... 1010111 @r2_vm
-vmsbf_m         010110 . ..... 00001 010 ..... 1010111 @r2_vm
-vmsif_m         010110 . ..... 00011 010 ..... 1010111 @r2_vm
-vmsof_m         010110 . ..... 00010 010 ..... 1010111 @r2_vm
+vmsbf_m         010100 . ..... 00001 010 ..... 1010111 @r2_vm
+vmsif_m         010100 . ..... 00011 010 ..... 1010111 @r2_vm
+vmsof_m         010100 . ..... 00010 010 ..... 1010111 @r2_vm
 viota_m         010110 . ..... 10000 010 ..... 1010111 @r2_vm
 vid_v           010110 . 00000 10001 010 ..... 1010111 @r1_vm
 vext_x_v        001100 1 ..... ..... 010 ..... 1010111 @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 2db7e7f58f..c1efb87e8d 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -2758,22 +2758,24 @@ static bool trans_vfirst_m(DisasContext *s, arg_rmr *a)
 #define GEN_M_TRANS(NAME)                                          \
 static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
 {                                                                  \
-    if (vext_check_isa_ill(s)) {                                   \
-        uint32_t data = 0;                                         \
-        gen_helper_gvec_3_ptr *fn = gen_helper_##NAME;             \
-        TCGLabel *over = gen_new_label();                          \
-        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);          \
+    REQUIRE_RVV;                                                   \
+    VEXT_CHECK_ISA_ILL(s);                                         \
+    require_vm(a->vm, a->rd);                                      \
+    require(a->rd != a->rs2);                                      \
                                                                    \
-        data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
-        data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
-        data = FIELD_DP32(data, VDATA, VMA, s->vma);               \
-        tcg_gen_gvec_3_ptr(vreg_ofs(s, a->rd),                     \
-                           vreg_ofs(s, 0), vreg_ofs(s, a->rs2),    \
-                           cpu_env, 0, s->vlen / 8, data, fn);     \
-        gen_set_label(over);                                       \
-        return true;                                               \
-    }                                                              \
-    return false;                                                  \
+    uint32_t data = 0;                                             \
+    gen_helper_gvec_3_ptr *fn = gen_helper_##NAME;                 \
+    TCGLabel *over = gen_new_label();                              \
+    tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);              \
+                                                                   \
+    data = FIELD_DP32(data, VDATA, VM, a->vm);                     \
+    data = FIELD_DP32(data, VDATA, LMUL, s->lmul);                 \
+    data = FIELD_DP32(data, VDATA, VMA, s->vma);                   \
+    tcg_gen_gvec_3_ptr(vreg_ofs(s, a->rd),                         \
+                       vreg_ofs(s, 0), vreg_ofs(s, a->rs2),        \
+                       cpu_env, 0, s->vlen / 8, data, fn);         \
+    gen_set_label(over);                                           \
+    return true;                                                   \
 }
 
 GEN_M_TRANS(vmsbf_m)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index f13f6c6dda..bc1363fb7d 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -4675,7 +4675,6 @@ enum set_mask_type {
 static void vmsetm(void *vd, void *v0, void *vs2, CPURISCVState *env,
                    uint32_t desc, enum set_mask_type type)
 {
-    uint32_t vlmax = env_archcpu(env)->cfg.vlen;
     uint32_t vm = vext_vm(desc);
     uint32_t vl = env->vl;
     int i;
@@ -4705,9 +4704,6 @@ static void vmsetm(void *vd, void *v0, void *vs2, CPURISCVState *env,
             }
         }
     }
-    for (; i < vlmax; i++) {
-        vext_set_elem_mask(vd, i, 0);
-    }
 }
 
 void HELPER(vmsbf_m)(void *vd, void *v0, void *vs2, CPURISCVState *env,
-- 
2.17.1


