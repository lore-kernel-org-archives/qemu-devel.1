Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 074CAC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:09:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0E3E22D0B
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="a6COSk7j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0E3E22D0B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3dtU-0005IG-Ng
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 07:17:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41748)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k3dSx-0004Fr-57
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:49:43 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a]:34958)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k3dSu-00083T-TO
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:49:42 -0400
Received: by mail-pg1-x52a.google.com with SMTP id o5so8496039pgb.2
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 03:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=CESX6q26+3ZHamBv09KqrV0Utgcx/nTm3sAptnzacM0=;
 b=a6COSk7jQF9HKxB2XBSpkHCVaR8C6uvRIgYiuh+klFXaQ7YhMSzsBEDmNT0cmuwBXI
 yIc2oDrnQZmUa18+CdN8Uo1vE/U6cWT/edXZa7mqx1aBrqhQzamgPJUtbMoSXCWoB/4E
 +VHUI01WNTvuodtqECmTS2gJs770GNY+L0DSUqHFmsJo/CUs4zr66/v/FtTH2zQq48NP
 gShuBfAdRlbQT1rV0PA6DL52yfVU2wOvpivk+J8cV1mfW/z21YqpLMOY74KHE2BlzHwB
 qrLgAYYlTiOGOjt4M2SJ0NooUDiplFZFWzeFe3tCLXbc5PClNC+h3OUgri1Jz99K+sUv
 fd0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=CESX6q26+3ZHamBv09KqrV0Utgcx/nTm3sAptnzacM0=;
 b=oO6uvJMl4p4lUZX1I9Hu64ivUpwvr5qlud57aijAEKy9Wv+heaDyhpItH/aEOwi+If
 QYhcQDew9Oa/OJtajb86sS2sR9SoqqIhkihUIToOwcWUJbqOSqpWbWyRGvA33YxTs9Uz
 LOf4E9QiLAZb/FWRUfbznzXzcyDu3p2Wr3h+c7zgiTsFXTTJWAnzcUpc5EN5yheCfB1w
 qs/qN+bWKyGxSx4wtYuqwfL80boqZmRL+ptXCPO4DgvIVvy4VXJ3AX5flQ3wSLJ4YlF1
 HVfI5+/yjKQt00hQrA+DXrj2pwZTq7k5JcD6vbONr19Q2SaaQ9O8NwfxLe4w2dQu9Neh
 xsQQ==
X-Gm-Message-State: AOAM533PYcD1eeVFHGV2XJ+HTzbtBTHT4SZrzcuQ3InoNhTrT0xUi4oP
 p94ZA1TzagNyLEujw+7X9r67FCNfNl8=
X-Google-Smtp-Source: ABdhPJyr/yFALEQKfcTj6wonnAmiXtqE3Km7IZKJzJhhMcWWw5TeoWHaOtep+9ReP8lPu32ztdUjlg==
X-Received: by 2002:a63:c34e:: with SMTP id e14mr6529502pgd.55.1596710979528; 
 Thu, 06 Aug 2020 03:49:39 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id f18sm6567309pgv.84.2020.08.06.03.49.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 03:49:39 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v3 57/71] target/riscv: rvv-1.0: single-width floating-point
 reduction
Date: Thu,  6 Aug 2020 18:46:54 +0800
Message-Id: <20200806104709.13235-58-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806104709.13235-1-frank.chang@sifive.com>
References: <20200806104709.13235-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=frank.chang@sifive.com; helo=mail-pg1-x52a.google.com
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

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/vector_helper.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index a3679f79d0a..543d94ba6a8 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -4450,14 +4450,14 @@ GEN_VEXT_FRED(vfredsum_vs_w, uint32_t, uint32_t, H4, H4, float32_add)
 GEN_VEXT_FRED(vfredsum_vs_d, uint64_t, uint64_t, H8, H8, float64_add)
 
 /* Maximum value */
-GEN_VEXT_FRED(vfredmax_vs_h, uint16_t, uint16_t, H2, H2, float16_maxnum)
-GEN_VEXT_FRED(vfredmax_vs_w, uint32_t, uint32_t, H4, H4, float32_maxnum)
-GEN_VEXT_FRED(vfredmax_vs_d, uint64_t, uint64_t, H8, H8, float64_maxnum)
+GEN_VEXT_FRED(vfredmax_vs_h, uint16_t, uint16_t, H2, H2, float16_maxnum_noprop)
+GEN_VEXT_FRED(vfredmax_vs_w, uint32_t, uint32_t, H4, H4, float32_maxnum_noprop)
+GEN_VEXT_FRED(vfredmax_vs_d, uint64_t, uint64_t, H8, H8, float64_maxnum_noprop)
 
 /* Minimum value */
-GEN_VEXT_FRED(vfredmin_vs_h, uint16_t, uint16_t, H2, H2, float16_minnum)
-GEN_VEXT_FRED(vfredmin_vs_w, uint32_t, uint32_t, H4, H4, float32_minnum)
-GEN_VEXT_FRED(vfredmin_vs_d, uint64_t, uint64_t, H8, H8, float64_minnum)
+GEN_VEXT_FRED(vfredmin_vs_h, uint16_t, uint16_t, H2, H2, float16_minnum_noprop)
+GEN_VEXT_FRED(vfredmin_vs_w, uint32_t, uint32_t, H4, H4, float32_minnum_noprop)
+GEN_VEXT_FRED(vfredmin_vs_d, uint64_t, uint64_t, H8, H8, float64_minnum_noprop)
 
 /* Vector Widening Floating-Point Reduction Instructions */
 /* Unordered reduce 2*SEW = 2*SEW + sum(promote(SEW)) */
-- 
2.17.1


