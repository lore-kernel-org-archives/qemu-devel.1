Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12CEBC4727F
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 20:07:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 719702076B
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 20:07:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="KwEYdBgt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 719702076B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNLtw-0000kF-E4
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 16:07:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45458)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1kNKzu-0008Eb-BX
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 15:09:10 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:36351)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1kNKzs-0002Wp-NJ
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 15:09:10 -0400
Received: by mail-pf1-x441.google.com with SMTP id d9so5550710pfd.3
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 12:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=W1RnwHdcfPqUNeQK0zvGYuf3hB9xeHXDqfa7SIUjDuo=;
 b=KwEYdBgtpMNJOx/cj77iAtoIb5CneK1nbmpzGIGRJPYffVLScnX6zvs9OYm0i9JZQK
 WWl7pEZDavHD48GDDzZn9ppUX6K7Ngewa1DJZ4WCKmaKyubJ2gBH5L0q0YHLIYs9dG7P
 zGzBHTgvALrm2b7S5c2gnVA5CiT0LxppPTTlM+vVFT3Kdgu4BjgH8DQpO4z10iDg4RwI
 GYkCxybTy/b9wj4Y92gF9NLm5v48z5kVl69xBvewaSmgO/ZyiQ6OJ2ygXnZ75rmFQKsS
 bM7CoGrgv9Je9wwAzMArxHqXaF5iDhGVH1b0qD3jhMH2noBgoIYBUIOev1JZtEsH4Os1
 obgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=W1RnwHdcfPqUNeQK0zvGYuf3hB9xeHXDqfa7SIUjDuo=;
 b=mYs7/Pqi+kZa6doOOtVCJY/iXjT27/ydmwZL5O+CEwJyTI2PmcMQo3lNFeC+dIumM0
 5SWIi8d7r30fAEx0X1lsatd3BAKNjz2MLZNmXOrfF6G7bvkSO08p9/FfJDY3gOIETs3w
 QIVy3yOJgF7iXSE4yZe8Ho4B03I0TXlyw2Gs/4t4VlAVTmo3fsISbzrxwRujKxTxzja/
 145laPfm/7MdfgSOkQJV35LYzdUnJtdvqYVGhaAeKv1IjDBYaUfKZpJ2zsM128b2MBMS
 JdkOeap02p5juqgqOQASX3x+HOKln4Af/5ImdyNHtkxTq79pJguQx7ol7rZPi7R4aFfM
 rHgw==
X-Gm-Message-State: AOAM531wRbW9RYHqYZRIHZUI2PoYJk0Rg+VUKl1aZ0vzr32nmcRGZa3r
 szvouzX54DkdWEYEK420qTRxxxUrOPGIRw==
X-Google-Smtp-Source: ABdhPJyPcD0QtMAPSqvqWHHV41sujCrP5LwrHoX1s/vQJkhd6rI/XUIEHQHDmE53ypjRcSGsVouD8Q==
X-Received: by 2002:a63:1b44:: with SMTP id b4mr4264053pgm.175.1601406547270; 
 Tue, 29 Sep 2020 12:09:07 -0700 (PDT)
Received: from localhost.localdomain (122-116-72-36.HINET-IP.hinet.net.
 [122.116.72.36])
 by smtp.gmail.com with ESMTPSA id v8sm6003950pgg.58.2020.09.29.12.09.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 12:09:06 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v5 64/68] target/riscv: rvv-1.0: relax RV_VLEN_MAX to 1024-bits
Date: Wed, 30 Sep 2020 03:04:39 +0800
Message-Id: <20200929190448.31116-65-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929190448.31116-1-frank.chang@sifive.com>
References: <20200929190448.31116-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=frank.chang@sifive.com; helo=mail-pf1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Frank Chang <frank.chang@sifive.com>

--

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/cpu.h                      | 2 +-
 target/riscv/insn_trans/trans_rvv.c.inc | 4 ++--
 target/riscv/vector_helper.c            | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 930607de24..ca78b7f352 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -92,7 +92,7 @@ typedef struct CPURISCVState CPURISCVState;
 
 #include "pmp.h"
 
-#define RV_VLEN_MAX 256
+#define RV_VLEN_MAX 1024
 
 FIELD(VTYPE, VLMUL, 0, 3)
 FIELD(VTYPE, VSEW, 3, 3)
diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index db6c3d9bdf..576d20c6eb 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -631,8 +631,8 @@ static bool ldst_us_trans(uint32_t vd, uint32_t rs1, uint32_t data,
     base = tcg_temp_new();
 
     /*
-     * As simd_desc supports at most 256 bytes, and in this implementation,
-     * the max vector group length is 2048 bytes. So split it into two parts.
+     * As simd_desc supports at most 2048 bytes, and in this implementation,
+     * the max vector group length is 4096 bytes. So split it into two parts.
      *
      * The first part is vlen in bytes, encoded in maxsz of simd_desc.
      * The second part is lmul, encoded in data of simd_desc.
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 8d389af4b7..16331939b6 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -129,7 +129,7 @@ static uint32_t vext_wd(uint32_t desc)
 static inline uint32_t vext_max_elems(uint32_t desc, uint32_t esz)
 {
     /*
-     * As simd_desc support at most 256 bytes, the max vlen is 256 bits.
+     * As simd_desc support at most 2048 bytes, the max vlen is 1024 bits.
      * so vlen in bytes (vlenb) is encoded as maxsz.
      */
     uint32_t vlenb = simd_maxsz(desc);
-- 
2.17.1


