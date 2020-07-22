Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33DE5C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:39:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3D4B2068F
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="WCs8Hflb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3D4B2068F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyBE8-0001I3-6Z
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 05:39:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54312)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAvY-0003S4-EL
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:20:40 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:42918)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAvW-0005pM-Q6
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:20:40 -0400
Received: by mail-pf1-x443.google.com with SMTP id 1so860989pfn.9
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 02:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=JuRgjPtCOsLpIolUZl6gtqC4JRe4rAh5K9WEhSEkR1o=;
 b=WCs8HflbE5pzpfdq3qJ6ogzhJgceaZZWH8/TsFbyFy8dwlKS+YKNXapnFn/6YvPQ2p
 EwjbvBP8uxM2cIozsOTrfMAG2H84sZZF8FCEaKIB6yB9veaqeabRHr6dxLQGZzfrzl/m
 UzqptjlxZ+ca2BrLxuNIIWHMMt5fzBaP5QUAi7Jhbhxai+rkabLC109uFPatiCohzEem
 eOMDpFPOrFmll+v6DN08sjisK4jlyEddEHthLuYMVYI816p4kubm+OhwAsfm6KZHYo3h
 hMACme1KEsiQn8bbA9n749dM1t3D5SfajxjYy5TUOxxEhhVLSeFnvveTDl7ILaeiJPhI
 pvug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=JuRgjPtCOsLpIolUZl6gtqC4JRe4rAh5K9WEhSEkR1o=;
 b=rE0YhYUzxPmSoLPHPiPlVVL4lA8XRmXgaS0wGrnHgk7ApUXs9x/jw/92U5KRIU4NHC
 EW9ZbrJuX9Kn1HRL5GjgEB0SWX1jgoVZ3xnatZ0xB8XZk1tu83wVBnBooId0hZkTT4Jc
 1+T5z95gOchtdrWY0+Uo87ZYXS31guYdyor9/V28kGt5PJtcEIQZKLQxqpnepkrYvrUr
 v/ETH2MPBEzYm9XvUhvmEoMt0H2+MFNH5d96YD7RsMrvIv7v0KZMIB1oRAd1dc+TEAWP
 ASTQrJoOXwE5SOmgu9aYfuyIrmk7pxwh8gTAew5aZkkEK2ctbx4ZM7bLB/ngoPNqG1iF
 ewlw==
X-Gm-Message-State: AOAM533CV2p8o5+6TlzCn6oyR0eA7eaTwIXqrMYGin4C307Bx/Y3fdXt
 d4ktGQan8K9+bg96uwiUBxR+x8hRVfk=
X-Google-Smtp-Source: ABdhPJzSPMS/U7lUYSz5935s92fdL9F6shs0vCiaeYxzsCczf6x1O9D2UM6tBb5gIz29nx8r25UjQQ==
X-Received: by 2002:a65:5c08:: with SMTP id u8mr27176937pgr.184.1595409637209; 
 Wed, 22 Jul 2020 02:20:37 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id c125sm22301879pfa.119.2020.07.22.02.20.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2020 02:20:36 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v2 42/76] target/riscv: rvv-0.9: whole register move instructions
Date: Wed, 22 Jul 2020 17:16:05 +0800
Message-Id: <20200722091641.8834-43-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200722091641.8834-1-frank.chang@sifive.com>
References: <20200722091641.8834-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=frank.chang@sifive.com; helo=mail-pf1-x443.google.com
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

Add the following instructions:

* vmv1r.v
* vmv2r.v
* vmv4r.v
* vmv8r.v

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/insn32.decode              |  4 ++++
 target/riscv/insn_trans/trans_rvv.inc.c | 27 +++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 4be1b88e2d..0e1d6b3ead 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -595,6 +595,10 @@ vrgather_vv     001100 . ..... ..... 000 ..... 1010111 @r_vm
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
index 56cd7444f2..85f22a1495 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -3527,3 +3527,30 @@ static bool trans_vcompress_vm(DisasContext *s, arg_r *a)
     }
     return false;
 }
+
+/*
+ * Whole Vector Register Move Instructions ignore vtype and vl setting.
+ * Thus, we don't need to check vill bit. (Section 17.6)
+ */
+#define GEN_VMV_WHOLE_TRANS(NAME, LEN)                    \
+static bool trans_##NAME(DisasContext *s, arg_##NAME * a) \
+{                                                         \
+    if (require_rvv(s) &&                                 \
+        ((a->rd & ((LEN) - 1)) == 0) &&                   \
+        ((a->rs2 & ((LEN) - 1)) == 0)) {                  \
+        for (int i = 0; i < LEN; ++i) {                   \
+            /* EEW = 8 */                                 \
+            tcg_gen_gvec_mov(8, vreg_ofs(s, a->rd + i),   \
+                             vreg_ofs(s, a->rs2 + i),     \
+                             s->vlen / 8, s->vlen / 8);   \
+        }                                                 \
+        mark_vs_dirty(s);                                 \
+        return true;                                      \
+    }                                                     \
+    return false;                                         \
+}
+
+GEN_VMV_WHOLE_TRANS(vmv1r_v, 1)
+GEN_VMV_WHOLE_TRANS(vmv2r_v, 2)
+GEN_VMV_WHOLE_TRANS(vmv4r_v, 4)
+GEN_VMV_WHOLE_TRANS(vmv8r_v, 8)
-- 
2.17.1


