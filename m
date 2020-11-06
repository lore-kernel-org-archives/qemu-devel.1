Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B573C2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 03:49:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4D7520735
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 03:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NkdrAp1D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4D7520735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaskb-0000fe-Rv
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 22:49:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47498)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kasSQ-0005yH-TR
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 22:30:38 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:42521)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kasSI-0007Jy-Uy
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 22:30:34 -0500
Received: by mail-pg1-x544.google.com with SMTP id u4so2872797pgr.9
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 19:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=U1AlMjq14SkWUeaRW64JEUc91BuQIjZvXubJwS4y6yc=;
 b=NkdrAp1DUQ19z8It1EAI73AI/mVT2EzJWvY2tYzHGtTld7oNDUZAqfDuFpU4pIxATv
 mAMTnmNZyDJDxMcep+DaPj+CfpdCzO+P77qhsu8Cg7RdNy/8/XIhNhYkdO9aDreZzM9n
 lnloWf/U4CTvVbdtg4+gUsNct/6iN8KTu59TMKGGfArAwhj8DFIZet4w41V++svBRBo9
 uOicCLGH15fFfIyiVx4JXlm+YFe1koV9daJCdxOaFWUzaScEOE29fQJDTtEwNbw7i9Z8
 XPFusJ889FLbYyYZ0FuF9h/49fI3xVD2IeVFlV+w+dIteju2YhZ1CNGRhcx3M/3cMh+x
 aZww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=U1AlMjq14SkWUeaRW64JEUc91BuQIjZvXubJwS4y6yc=;
 b=oyeEmeHDbfxgrKR4HtSgj9PgIjJOuM4EJx7NmD+lVgMMosqwPyCjBJlwPdOMviXFuw
 VwrAQVR7toXycu+YeB/d4U8gmhpqHi/03JjJdqg8zF9U2MfBAf77BO5RwyLOeO/EXa45
 lK9J6OBaoKxv98RBx1H4swikUPdBJA+LGY7/GhfmI5tbOSvGudHQQG01Ei9rPrgajUZV
 fRfu6hp0UzKH2Wh+G+dlGrqeZ5bblsedikA2M6LSCDcu+EtC04jxmjde2JCZFlVredt0
 wSbdaRezDsnUEZi0Gm0lqz1T5mxw8vhFNOQHzqVL+lpqzhUEe7TOI6ZsltXIshcyqeaO
 KoiQ==
X-Gm-Message-State: AOAM530b2fhQEWtqKAFQ0z9YBIUR+NllbEG+f38UiPMZ4SuftItFJ2xp
 PAK/JXGPIFhp2JY/n92uWeNWQX7rzq8Dww==
X-Google-Smtp-Source: ABdhPJx63iSBsUCuDJp2XvKMCbsyunWafJgkFdaKjcwNlDD9MpdbY1csC+gVrNIEVxhPQxLQjyYT/A==
X-Received: by 2002:a05:6a00:212b:b029:18b:ad77:1a27 with SMTP id
 n11-20020a056a00212bb029018bad771a27mr128686pfj.40.1604633425282; 
 Thu, 05 Nov 2020 19:30:25 -0800 (PST)
Received: from localhost.localdomain (76-14-210-194.or.wavecable.com.
 [76.14.210.194])
 by smtp.gmail.com with ESMTPSA id i10sm40773pfd.60.2020.11.05.19.30.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 19:30:23 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 41/41] tcg: Constify TCGLabelQemuLdst.raddr
Date: Thu,  5 Nov 2020 19:29:21 -0800
Message-Id: <20201106032921.600200-42-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106032921.600200-1-richard.henderson@linaro.org>
References: <20201106032921.600200-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x544.google.com
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
Cc: j@getutm.app
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now that all native tcg hosts support splitwx,
make this pointer const.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.c.inc | 3 +--
 tcg/arm/tcg-target.c.inc     | 3 +--
 tcg/i386/tcg-target.c.inc    | 3 +--
 tcg/mips/tcg-target.c.inc    | 3 +--
 tcg/ppc/tcg-target.c.inc     | 3 +--
 tcg/riscv/tcg-target.c.inc   | 3 +--
 tcg/s390/tcg-target.c.inc    | 3 +--
 tcg/tcg-ldst.c.inc           | 2 +-
 8 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 32a60eba5e..9e15128f31 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -1636,8 +1636,7 @@ static void add_qemu_ldst_label(TCGContext *s, bool is_ld, TCGMemOpIdx oi,
     label->type = ext;
     label->datalo_reg = data_reg;
     label->addrlo_reg = addr_reg;
-    /* TODO: Cast goes away when all hosts converted */
-    label->raddr = (void *)tcg_splitwx_to_rx(raddr);
+    label->raddr = tcg_splitwx_to_rx(raddr);
     label->label_ptr[0] = label_ptr;
 }
 
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index d6cb19ca9f..0fd1126454 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1340,8 +1340,7 @@ static void add_qemu_ldst_label(TCGContext *s, bool is_ld, TCGMemOpIdx oi,
     label->datahi_reg = datahi;
     label->addrlo_reg = addrlo;
     label->addrhi_reg = addrhi;
-    /* TODO: Cast goes away when all hosts converted */
-    label->raddr = (void *)tcg_splitwx_to_rx(raddr);
+    label->raddr = tcg_splitwx_to_rx(raddr);
     label->label_ptr[0] = label_ptr;
 }
 
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index be57d2330a..18a3af53bb 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -1786,8 +1786,7 @@ static void add_qemu_ldst_label(TCGContext *s, bool is_ld, bool is_64,
     label->datahi_reg = datahi;
     label->addrlo_reg = addrlo;
     label->addrhi_reg = addrhi;
-    /* TODO: Cast goes away when all hosts converted */
-    label->raddr = (void *)tcg_splitwx_to_rx(raddr);
+    label->raddr = tcg_splitwx_to_rx(raddr);
     label->label_ptr[0] = label_ptr[0];
     if (TARGET_LONG_BITS > TCG_TARGET_REG_BITS) {
         label->label_ptr[1] = label_ptr[1];
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 18fd474593..add157f6c3 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -1283,8 +1283,7 @@ static void add_qemu_ldst_label(TCGContext *s, int is_ld, TCGMemOpIdx oi,
     label->datahi_reg = datahi;
     label->addrlo_reg = addrlo;
     label->addrhi_reg = addrhi;
-    /* TODO: Cast goes away when all hosts converted */
-    label->raddr = (void *)tcg_splitwx_to_rx(raddr);
+    label->raddr = tcg_splitwx_to_rx(raddr);
     label->label_ptr[0] = label_ptr[0];
     if (TCG_TARGET_REG_BITS < TARGET_LONG_BITS) {
         label->label_ptr[1] = label_ptr[1];
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 3580bbabc1..71b40e7490 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -2001,8 +2001,7 @@ static void add_qemu_ldst_label(TCGContext *s, bool is_ld, TCGMemOpIdx oi,
     label->datahi_reg = datahi_reg;
     label->addrlo_reg = addrlo_reg;
     label->addrhi_reg = addrhi_reg;
-    /* TODO: Cast goes away when all hosts converted */
-    label->raddr = (void *)tcg_splitwx_to_rx(raddr);
+    label->raddr = tcg_splitwx_to_rx(raddr);
     label->label_ptr[0] = lptr;
 }
 
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 7b4ee4a084..f48a028dac 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -996,8 +996,7 @@ static void add_qemu_ldst_label(TCGContext *s, int is_ld, TCGMemOpIdx oi,
     label->datahi_reg = datahi;
     label->addrlo_reg = addrlo;
     label->addrhi_reg = addrhi;
-    /* TODO: Cast goes away when all hosts converted */
-    label->raddr = (void *)tcg_splitwx_to_rx(raddr);
+    label->raddr = tcg_splitwx_to_rx(raddr);
     label->label_ptr[0] = label_ptr[0];
 }
 
diff --git a/tcg/s390/tcg-target.c.inc b/tcg/s390/tcg-target.c.inc
index b3660ffedf..d7ef079055 100644
--- a/tcg/s390/tcg-target.c.inc
+++ b/tcg/s390/tcg-target.c.inc
@@ -1587,8 +1587,7 @@ static void add_qemu_ldst_label(TCGContext *s, bool is_ld, TCGMemOpIdx oi,
     label->oi = oi;
     label->datalo_reg = data;
     label->addrlo_reg = addr;
-    /* TODO: Cast goes away when all hosts converted */
-    label->raddr = (void *)tcg_splitwx_to_rx(raddr);
+    label->raddr = tcg_splitwx_to_rx(raddr);
     label->label_ptr[0] = label_ptr;
 }
 
diff --git a/tcg/tcg-ldst.c.inc b/tcg/tcg-ldst.c.inc
index 05f9b3ccd6..c3ce88e69d 100644
--- a/tcg/tcg-ldst.c.inc
+++ b/tcg/tcg-ldst.c.inc
@@ -28,7 +28,7 @@ typedef struct TCGLabelQemuLdst {
     TCGReg addrhi_reg;      /* reg index for high word of guest virtual addr */
     TCGReg datalo_reg;      /* reg index for low word to be loaded or stored */
     TCGReg datahi_reg;      /* reg index for high word to be loaded or stored */
-    tcg_insn_unit *raddr;   /* gen code addr of the next IR of qemu_ld/st IR */
+    const tcg_insn_unit *raddr;   /* addr of the next IR of qemu_ld/st IR */
     tcg_insn_unit *label_ptr[2]; /* label pointers to be updated */
     QSIMPLEQ_ENTRY(TCGLabelQemuLdst) next;
 } TCGLabelQemuLdst;
-- 
2.25.1


