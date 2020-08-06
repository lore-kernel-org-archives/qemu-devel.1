Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB5BC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:08:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FFD522D0B
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="VCVbI+kF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FFD522D0B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3dfq-0001pv-6Y
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 07:03:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40648)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k3dRc-0002Cu-Op
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:48:20 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c]:37216)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k3dRZ-0007nU-S6
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:48:20 -0400
Received: by mail-pf1-x42c.google.com with SMTP id s26so24714326pfm.4
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 03:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=MeZ3DbVQFubD9Ck0Xx/O6GBTXdFjHoV45D2FONbf3aI=;
 b=VCVbI+kFwqbNUL8dAllKLrzgxA9nxxBloX+RSu4VyUg3OVI1XsHNmrJ5xPdtTJ6DTb
 HOMsM6grbh3t17wmT8j3pffN7p1RW2RhzTyNtAiuNxy6MzxJXK27IQgFPF+WlirbMahH
 C3C/TdfIk9i6A9IPTsJr6xQICgrTw25GD0bDu38aas06voBy+qx2LlNbre6H1DFNPpGZ
 XBzxH0WFpJLBtt99INVOX1/YNbyth+sRxjsakw57Hz+oCx/qOwkJtzHxZwGhwh86Olgj
 hCWJfJkE1BwlCLojDhQZ5I7tcISu5yds23cwYUZ5uwuvYLUXBFY9sN9ZIM5mjoOStqFb
 CBkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=MeZ3DbVQFubD9Ck0Xx/O6GBTXdFjHoV45D2FONbf3aI=;
 b=phUkyGKG7NfL9hDlIfiZqRXaB+d8mHmMmy4ODCy1VojAEUJ48eyel1f9N/GIdTCL8S
 e+lYtEwhgoJCNNlmIyobZpSYvts0nJ7GNKVKjZwpnEdr/YfK7tW8DDkIIMGwjnTZKxai
 8PlmMhfGlyZukpvjCSjM74R2IOyB2QTT3NCRHSKFlluogexVp2t9dXWiPEgeCmQ5QCW2
 Rq7LwqvSr9McRcIv5vciQYYKlUyJ4lu4mHBzT45Chy+9qkIoRhlQQJD3c++r0oEXUYmf
 Si0fa7yeA28pBP21eRZSxMC+zy8BdPUaqC/q5qFsj9Nv6Q/I40KMJfgI1gE4f6UptVtb
 NBUw==
X-Gm-Message-State: AOAM532GDoE0QThoN+/qcfMZD5Pq0tKJ2A3MWNhvkEyRacTGp28YA9fX
 QfQGG1e0UWLG30++9B0wt8GigX/p2Xg=
X-Google-Smtp-Source: ABdhPJwa9PY61jq6BwvIjLneO1wLxVNhO27SA5lO3dvk0fASrfWYsVLiLQX0Z1+8bVyTpnH8o55vnw==
X-Received: by 2002:a62:e704:: with SMTP id s4mr8107606pfh.177.1596710895992; 
 Thu, 06 Aug 2020 03:48:15 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id f18sm6567309pgv.84.2020.08.06.03.48.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 03:48:15 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v3 22/71] target/riscv: rvv-1.0: fix address index overflow bug
 of indexed load/store insns
Date: Thu,  6 Aug 2020 18:46:19 +0800
Message-Id: <20200806104709.13235-23-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806104709.13235-1-frank.chang@sifive.com>
References: <20200806104709.13235-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=frank.chang@sifive.com; helo=mail-pf1-x42c.google.com
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
index 9ba60dd7018..1ba4f720922 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -364,10 +364,10 @@ static target_ulong NAME(target_ulong base,            \
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


