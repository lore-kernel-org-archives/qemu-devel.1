Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A511DC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 09:17:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75C142072D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 09:17:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="WoZasPOD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75C142072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7bGI-00080b-K1
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 05:17:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45574)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k7as5-0001Me-NT
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 04:52:03 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:33165)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k7ary-00058p-4f
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 04:52:01 -0400
Received: by mail-pf1-x441.google.com with SMTP id u20so7905544pfn.0
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 01:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=aSuxM7z3Zcd8Qt9fuXNwzVvaRXhXe1Q5X81hD5IACMw=;
 b=WoZasPODCnVrPrvyBi1YVI1DHb6PQZ7w1ZED7/y3Wagd88IAa9QgWrypjy+ar1iCmd
 H8FXY6cigtIXNXQ5HoMKmldtxvVzv8IVjMW2nqxPSI3bjY+SVV/kq7O//3dV44zvyWzg
 Etr6PfRKUaTAi6tII74Fg7wAKAsP6Qjq890/zGiM309pnJ1TWkWshGvaGovo1tgOWmJG
 vcyMHScCrz+dbOeJN8wWefydiMczqFIJT0R+5OwVh+h5m/IuC/dLAIFdmLqZepQ6yxgI
 RxovUAJNOa2b2s73PP8lX63fFIFQ3UXY+MTBGgP/DC+TYtQryczbsFOs96jxZ2DIoLF6
 KvVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=aSuxM7z3Zcd8Qt9fuXNwzVvaRXhXe1Q5X81hD5IACMw=;
 b=M9CWvgvMempSgtmIRzngpMAida0XQx+SV22WJdz7PIWBWaI7GfHeDxr5VcbxnWmwvK
 GBBe8cPrWbIUNr2bGe5Ekr9+HHcBW/n99DZMwzhAaYbLaFLOwDVpqymANbycO0+fCLW9
 icGfWVBu20NhwOPp9AmlR8ZyqN/PA0nCzVBoFaNG4znqdLGYoyyRO96VwEBYvCt9busN
 i0N7O6BHFMVHbpvEm7T1FFX+flY7aMNAbRF9DzFOf6+RY1vN46RxwIB+jHHpxpc0JL7u
 HgvLVbbZinvGmcx5EMnvDuKnysDjkcuzG+7BE/cO4OZJ512AM693o/GAVIj+FKpfSiRn
 I93w==
X-Gm-Message-State: AOAM5308d9ndc2MBvuxDLXzbVPakTPzuHZieW1j/weQQgUwNz9v8lv+a
 jRazna5LJSJSEdQowz6FtxRArQfAxZnTAQ==
X-Google-Smtp-Source: ABdhPJwwx2RZogmwC+ZAfV9vQhVgChGrBOzodhyhkR4+TWRI+MB7Xrjc3jYhIzDYilx2hntvK18R6w==
X-Received: by 2002:a62:7687:: with SMTP id
 r129mr10627548pfc.308.1597654312559; 
 Mon, 17 Aug 2020 01:51:52 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id d9sm16478588pgv.45.2020.08.17.01.51.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 01:51:52 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v4 38/70] target/riscv: rvv-1.0: whole register move instructions
Date: Mon, 17 Aug 2020 16:49:23 +0800
Message-Id: <20200817084955.28793-39-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817084955.28793-1-frank.chang@sifive.com>
References: <20200817084955.28793-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=frank.chang@sifive.com; helo=mail-pf1-x441.google.com
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
Cc: Frank Chang <frank.chang@sifive.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Frank Chang <frank.chang@sifive.com>

Add the following instructions:

* vmv1r.v
* vmv2r.v
* vmv4r.v
* vmv8r.v

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/insn32.decode              |  4 ++++
 target/riscv/insn_trans/trans_rvv.inc.c | 25 +++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 97fce34fcd8..65ff1688c25 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -614,6 +614,10 @@ vrgatherei16_vv 001110 . ..... ..... 000 ..... 1010111 @r_vm
 vrgather_vx     001100 . ..... ..... 100 ..... 1010111 @r_vm
 vrgather_vi     001100 . ..... ..... 011 ..... 1010111 @r_vm
 vcompress_vm    010111 - ..... ..... 010 ..... 1010111 @r
+vmv1r_v         100111 1 ..... 00000 011 ..... 1010111 @r2rd
+vmv2r_v         100111 1 ..... 00001 011 ..... 1010111 @r2rd
+vmv4r_v         100111 1 ..... 00011 011 ..... 1010111 @r2rd
+vmv8r_v         100111 1 ..... 00111 011 ..... 1010111 @r2rd
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 95fdd972fdf..52f2f4902c0 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -3479,3 +3479,28 @@ static bool trans_vcompress_vm(DisasContext *s, arg_r *a)
     }
     return false;
 }
+
+/*
+ * Whole Vector Register Move Instructions ignore vtype and vl setting.
+ * Thus, we don't need to check vill bit. (Section 17.6)
+ */
+#define GEN_VMV_WHOLE_TRANS(NAME, LEN)                          \
+static bool trans_##NAME(DisasContext *s, arg_##NAME * a)       \
+{                                                               \
+    if (require_rvv(s) &&                                       \
+        QEMU_IS_ALIGNED(a->rd, LEN) &&                          \
+        QEMU_IS_ALIGNED(a->rs2, LEN)) {                         \
+        /* EEW = 8 */                                           \
+        tcg_gen_gvec_mov(MO_8, vreg_ofs(s, a->rd),              \
+                         vreg_ofs(s, a->rs2),                   \
+                         s->vlen / 8 * LEN, s->vlen / 8 * LEN); \
+        mark_vs_dirty(s);                                       \
+        return true;                                            \
+    }                                                           \
+    return false;                                               \
+}
+
+GEN_VMV_WHOLE_TRANS(vmv1r_v, 1)
+GEN_VMV_WHOLE_TRANS(vmv2r_v, 2)
+GEN_VMV_WHOLE_TRANS(vmv4r_v, 4)
+GEN_VMV_WHOLE_TRANS(vmv8r_v, 8)
-- 
2.17.1


