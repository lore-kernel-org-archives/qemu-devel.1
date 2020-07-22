Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A40B7C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:40:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B9F82068F
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:40:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ihOnf8Ib"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B9F82068F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyBEQ-0001hd-M3
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 05:40:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54962)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAwR-0005j6-D1
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:21:35 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:38992)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAwP-00064q-Qs
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:21:35 -0400
Received: by mail-pj1-x1044.google.com with SMTP id b92so867332pjc.4
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 02:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=k/bbYZMF5KJp5b3HZ5BM8JAnwaOB46w118MIToz3Xrg=;
 b=ihOnf8IbSm+ohMq99dU54kGjjWHbl99ykFtKv7tYcl9hYSRFuNONOd2q4OaIrMNUoD
 lA4rhvAxKnGMWZNGrkA2eGX5hViuK/d/Z57nMh873jyPCrWR38mW8L4rAWj8shDCDQeL
 XjfeGoKwFH2qb0mcSLpG0EwXjSxri8y9F8NSS0QhgaO+47bF5HSgiSYWy4lB9LF0ir1a
 z9eS0Gb6omLZrdx1G/mMrheNamTeWjq2W99qENylQJQDzbkLwlsyx2DL92wHpbPFJcUz
 S7XU2fzJ7h/dBk4rcj+tIMHQzDuKrELyt9AdKsHDr8XmKuYnD/W/voHJQU9YQ7Q8Xro+
 jIYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=k/bbYZMF5KJp5b3HZ5BM8JAnwaOB46w118MIToz3Xrg=;
 b=sa7ywvF2xasrCL0E798cVp+7Q4LJPJYoXG+H+H1k0UjhBRLNxC4LkWxZyyPn7O01xt
 EY2D7Cr+mU2y9QBCaK7cuBiKTqMpVudAH5qj/arLbhR3fA9RCy/dKuQZoc+Zz/1rJnsR
 YkpgK+/ewjjVcmFb7j2yXmgXvjQ/Ffp8IUVFbkcS3KGa4b23YcpaMf/10oq5bok2t3Ir
 VRnFlXnLhO/DHn3WPLAgFEgV3vNjygyEV2e2ND4ZOou/9GdsTGPZvFZKCd2fpe4HX6UL
 eEGOaToJkkbhH6fx9Z8hX5tlaWFc6oHbJznzMhCf+QecjinZRZUwPblA1XnHe38ZsePU
 VBJg==
X-Gm-Message-State: AOAM532SYpxZ9rZ19gG5R7HQD9e8+rBLxtA7ZBGelgxGdck7tpi4nahB
 RgSlZ5XvOT4ItUnv/yOK0CndKDpr3AM=
X-Google-Smtp-Source: ABdhPJzCpObdv0jSauMJ3gK7jpJXU/3KwcNgW94h2LD6irmNXXawY9UdneaJV0D2Atmjt/KeLV8OLQ==
X-Received: by 2002:a17:902:b102:: with SMTP id
 q2mr23695082plr.343.1595409692421; 
 Wed, 22 Jul 2020 02:21:32 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id c125sm22301879pfa.119.2020.07.22.02.21.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2020 02:21:32 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v2 56/76] target/riscv: rvv-0.9: widening integer reduction
 instructions
Date: Wed, 22 Jul 2020 17:16:19 +0800
Message-Id: <20200722091641.8834-57-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200722091641.8834-1-frank.chang@sifive.com>
References: <20200722091641.8834-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=frank.chang@sifive.com; helo=mail-pj1-x1044.google.com
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

Remove clear function from helper function as the tail elements
are unchanged in RVV 0.9.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/vector_helper.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 39245b5ac8..fa2459d941 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -4634,14 +4634,14 @@ GEN_VEXT_RED(vredxor_vs_d, int64_t, int64_t, H8, H8, DO_XOR)
 
 /* Vector Widening Integer Reduction Instructions */
 /* signed sum reduction into double-width accumulator */
-GEN_VEXT_RED(vwredsum_vs_b, int16_t, int8_t, H2, H1, DO_ADD, clearh)
-GEN_VEXT_RED(vwredsum_vs_h, int32_t, int16_t, H4, H2, DO_ADD, clearl)
-GEN_VEXT_RED(vwredsum_vs_w, int64_t, int32_t, H8, H4, DO_ADD, clearq)
+GEN_VEXT_RED(vwredsum_vs_b, int16_t, int8_t,  H2, H1, DO_ADD)
+GEN_VEXT_RED(vwredsum_vs_h, int32_t, int16_t, H4, H2, DO_ADD)
+GEN_VEXT_RED(vwredsum_vs_w, int64_t, int32_t, H8, H4, DO_ADD)
 
 /* Unsigned sum reduction into double-width accumulator */
-GEN_VEXT_RED(vwredsumu_vs_b, uint16_t, uint8_t, H2, H1, DO_ADD, clearh)
-GEN_VEXT_RED(vwredsumu_vs_h, uint32_t, uint16_t, H4, H2, DO_ADD, clearl)
-GEN_VEXT_RED(vwredsumu_vs_w, uint64_t, uint32_t, H8, H4, DO_ADD, clearq)
+GEN_VEXT_RED(vwredsumu_vs_b, uint16_t, uint8_t,  H2, H1, DO_ADD)
+GEN_VEXT_RED(vwredsumu_vs_h, uint32_t, uint16_t, H4, H2, DO_ADD)
+GEN_VEXT_RED(vwredsumu_vs_w, uint64_t, uint32_t, H8, H4, DO_ADD)
 
 /* Vector Single-Width Floating-Point Reduction Instructions */
 #define GEN_VEXT_FRED(NAME, TD, TS2, HD, HS2, OP, CLEAR_FN)\
-- 
2.17.1


