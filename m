Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23341C433E5
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:32:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB84020729
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="XXyGIhqr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB84020729
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyB6m-0001JI-4V
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 05:32:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53602)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAuE-0000k9-5G
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:19:18 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f]:51683)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAuC-0005Xt-M3
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:19:17 -0400
Received: by mail-pj1-x102f.google.com with SMTP id 8so868463pjj.1
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 02:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=t2sySwVAYzBgFbUWGNCph7loGGmEs8LojJHT2BEgias=;
 b=XXyGIhqrBdD6fi+0eDuLGFcejzSU/BUvO8w67CO2ZV+VSjnMxRAC6v1eGRgqsFM3q2
 QfEqlgmhKR0QAyq6QGNguQjZoHqEe6L0Y4CrAtRo6EHJ28JdwTWtJvefYeN/y2CwDTgb
 tISHqjAcOXhp6n0ehXGORwGqyHRvnkoSL6/pj2pCfG8R0LRFKG3DXl/kRDk+mA0xsLq8
 k2Go2c4ct0AySLqPSJmwWJPMh5cMlTg9B1R55xFNEI3XYSJgnBGkYF+0o1AL0dCr/omG
 Yd5a51CMBpxkoW5mVp9BZeiadsgdFz+zqr5a+kK+iez9kM0AOJ3PJOkdQ4JgwqTZHqN7
 ya/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=t2sySwVAYzBgFbUWGNCph7loGGmEs8LojJHT2BEgias=;
 b=um9JhcwEzi3g1r8T0nLv1GQTF/gnrM3uAoG6z8iH/v7/4STh5VvXfOqBR+BJKw68bt
 oeS9SH+biyEMWMO5te+po688iMTpVkWxwmuvaIkFZ8FxR995sd7MTcSdXqTkcvd1UsCB
 nFjpOLfqjM69oGCzo6AVAkeb/fxNs7yx1L+WtActg+fl/SK6lzEagzv6Gyd625RN23rE
 heVwtJq9F7Mfpy32tU3DLE5szSpt7ZoFBm1OWFHS7L66FNyLjVEc7o5GVJCku5+sVr02
 V2/z1KTfYmCBb1k1jQFFlD0SG44JTykUS1JXtB2GLnQr1YapGEiadGmjkF/VV/0sYUe9
 UH5w==
X-Gm-Message-State: AOAM530Ve+kymh7Tqy8ldAv1qInYpVMR1ed/qhsLo1Xaq3fOG+nB93Ae
 on7IcAl1VKckt8IjVxXBs9XolZZirRQ=
X-Google-Smtp-Source: ABdhPJxs7SuZ07/HcM+uwTVeCJ1zCs2ziXosnUbE1NJq5LdHXr/h1wnk8FFojGZYZO4cOY20cxMBpQ==
X-Received: by 2002:a17:90a:8c91:: with SMTP id
 b17mr9343086pjo.74.1595409555109; 
 Wed, 22 Jul 2020 02:19:15 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id c125sm22301879pfa.119.2020.07.22.02.19.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2020 02:19:14 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v2 24/76] target/riscv: rvv-0.9: fix address index overflow bug
 of indexed load/store insns
Date: Wed, 22 Jul 2020 17:15:47 +0800
Message-Id: <20200722091641.8834-25-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200722091641.8834-1-frank.chang@sifive.com>
References: <20200722091641.8834-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=frank.chang@sifive.com; helo=mail-pj1-x102f.google.com
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
index 13634be66a..1c4aba21c6 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -449,10 +449,10 @@ static target_ulong NAME(target_ulong base,            \
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


