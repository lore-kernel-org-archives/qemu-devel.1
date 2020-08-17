Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1AA5C433E4
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 08:57:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C8BB207DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 08:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="eU+JyqH+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C8BB207DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7ax4-0001qL-Ks
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 04:57:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44748)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k7arB-0007Z8-A3
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 04:51:05 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:44777)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k7ar9-0004zw-GA
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 04:51:04 -0400
Received: by mail-pf1-x444.google.com with SMTP id r11so7877742pfl.11
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 01:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=bh+dNsmGP/qZR/VB/85dqarQceH1VG542/49ilIh4wY=;
 b=eU+JyqH+DebpNBwecsGT7dAyOCLWygVzZrBnk33DZZFhFAxIdtGhriUHpqK/iaREgQ
 QvUXaAHoLGJ9EV3MQtlfaEfbXch/SHHRlYk7E3c20dOeqNmqL2KuDJPGtKed78zr5DF5
 GsEb5X1eqrJbfA4TEbMkxqC3emBhlVVNw48vIAwzH5pjuvODfPa3QiaWmeET9VyS8iYm
 2SDxotvUqSgYfDVtufo27FJN3cAs/RIBp65lJcqR380DRgaUh0WtBbcL2PvX1Qr2g8IX
 R7k6p/uQOCLIkX1o/LgsY3JRiWcEKqxrjaJwrr/VnvNbw4IPV5t8/rnWEyG57Ou4roJH
 9TEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=bh+dNsmGP/qZR/VB/85dqarQceH1VG542/49ilIh4wY=;
 b=gXHMM0LPRK8cB/mSS7cgc+Zl0ZplJ23VxFRAviKdMNcTkCYng5vftjUOLu+Ccg87US
 WDeVTrDjqCQKzWibyr5W9TkL9xg37mEGP+dHzSz77PCxAQHgbojJGXjfQYSkICTbtc4K
 eV1NU3s+OLOMWhQNbQncayBEeL9zC+4neChqBlyNBHXihd8G+cIoTKmdLlhCGEPU/VgL
 zLiHOyouZxh4vxbvnFdaEOxBLwS5ieWPcceI0AVJYE5A0kcQ2GZZNU0gbjQD/3eBYlrC
 HqEToZXjQQiYPNKMUCo11Yu9gXaNzH0dY20JbdK65rOXz8ENrY4qsqJyu/B1iOL4X3DL
 b3Tw==
X-Gm-Message-State: AOAM532T1ZDIKJ4W3WQ0ru3KxCChIoaDa0JgbeI3bp9zPjFVrfjfSb0A
 kszOV7VksG3uUj7F/ob0LMOjqjpcatqK+g==
X-Google-Smtp-Source: ABdhPJwrBG3k8yB5pokzqfB+5aVpTtgRqUktZOFQ7Mv+Me+pVOTQ7bONqEcodmPYyqz2J/r7iRaiEA==
X-Received: by 2002:a63:f44b:: with SMTP id p11mr5007805pgk.324.1597654261999; 
 Mon, 17 Aug 2020 01:51:01 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id d9sm16478588pgv.45.2020.08.17.01.51.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 01:51:01 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v4 20/70] target/riscv: rvv-1.0: fix address index overflow bug
 of indexed load/store insns
Date: Mon, 17 Aug 2020 16:49:05 +0800
Message-Id: <20200817084955.28793-21-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817084955.28793-1-frank.chang@sifive.com>
References: <20200817084955.28793-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=frank.chang@sifive.com; helo=mail-pf1-x444.google.com
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

Replace ETYPE from signed int to unsigned int to prevent index overflow
issue, which would lead to wrong index address.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/vector_helper.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 272a65ebb3a..92a2161e373 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -363,10 +363,10 @@ static target_ulong NAME(target_ulong base,            \
     return (base + *((ETYPE *)vs2 + H(idx)));          \
 }
 
-GEN_VEXT_GET_INDEX_ADDR(idx_b, int8_t,  H1)
-GEN_VEXT_GET_INDEX_ADDR(idx_h, int16_t, H2)
-GEN_VEXT_GET_INDEX_ADDR(idx_w, int32_t, H4)
-GEN_VEXT_GET_INDEX_ADDR(idx_d, int64_t, H8)
+GEN_VEXT_GET_INDEX_ADDR(idx_b, uint8_t,  H1)
+GEN_VEXT_GET_INDEX_ADDR(idx_h, uint16_t, H2)
+GEN_VEXT_GET_INDEX_ADDR(idx_w, uint32_t, H4)
+GEN_VEXT_GET_INDEX_ADDR(idx_d, uint64_t, H8)
 
 static inline void
 vext_ldst_index(void *vd, void *v0, target_ulong base,
-- 
2.17.1


