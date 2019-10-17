Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CEE8ECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:29:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6899A214E0
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FNlWDAB+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6899A214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL5qF-0006W0-V5
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 09:29:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34015)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iL5dm-00089n-R7
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:16:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iL5dl-0005VP-O6
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:16:30 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:55433)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iL5dl-0005Uo-Hv
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:16:29 -0400
Received: by mail-wm1-x342.google.com with SMTP id a6so2518117wma.5
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 06:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=t6U3oBlc6u1UdxE1uAu8xMOurpvpIFfvpufH8BjBIdw=;
 b=FNlWDAB+eSG4X+dD6IMQrw4QZ9OrnDkuhOJyxyFk4H1+DT2B6LZSbYBrq/k5E2IW4G
 mmp2PvfMCRhvL64CX4xqqAvvWYwqXlRToGPrr1skOD2XOURQpVZyK6LZsI6NfDzn0tlZ
 ruNRp3DWjs2DSmUjE2hZoHBn01YZeYCNK0HdfizIHNY8rJ/brhM+6BSGyUWaXn/lK+FG
 /qBHCUzkfBY6LzmeiaaMGjJCuODT0vu4u0Z8gXG09Ah0917f00cjsmcFL+9klhiTR0r5
 tsfNNS/GGsWUTCdNTfRdLzuQDshFWKBvtkRXhdpdgb/LR+G3UcCpYxvEOoSPYzZibQzi
 yfzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=t6U3oBlc6u1UdxE1uAu8xMOurpvpIFfvpufH8BjBIdw=;
 b=BB9QC5w8x+FMR9Pi9KPd/wspJeX1Omr/lsD6bDpKnFW8jVzWs3Lm78+vGcsyfaCRQb
 uDbJyF2yE/DhDnoYf7JzVTiPD3jnkPiU4T7jdeNP0hlMz2bJ3SFOC9SjCuioCXXEy8qU
 7bSb13P+K5woH/Nad/TsHjfupTdox3GJgpOGC3XWO3BSKc1Pb/A0vpYcN1iUy2JlpYh1
 J5qjVS2ugDfIZ5KPo1vjRtkmoKeJxJ47EWuw4kcvJkjZ3E1NHNFzW0w0yJ3t0BCJPB4s
 M7XP052LXLRwKAheN2NnVF88e6Akk3FA+aU67F44PQaJ6Hn9CQkbdgQ0CD3zM0NmKmZr
 I/HQ==
X-Gm-Message-State: APjAAAVq6CvxpbU2e7IVb/XdBBYEqcN4cEbtMJpmOy/zgvQz+yiinrr/
 Q1RpQ2SA8bQFZXpTLqEaqKBf0d7b6uM=
X-Google-Smtp-Source: APXvYqyCz/TAbJtkF7w8mLE8QGn1miTqK1/c66pfZfczCQdspSlGncqvxLlMOELn4Pt6/g/UFVofcQ==
X-Received: by 2002:a7b:cf28:: with SMTP id m8mr3075893wmg.161.1571318188466; 
 Thu, 17 Oct 2019 06:16:28 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u1sm2020353wmc.38.2019.10.17.06.16.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 06:16:26 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E802B1FFA9;
 Thu, 17 Oct 2019 14:16:17 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v6 21/54] plugin-gen: add plugin_insn_append
Date: Thu, 17 Oct 2019 14:15:42 +0100
Message-Id: <20191017131615.19660-22-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191017131615.19660-1-alex.bennee@linaro.org>
References: <20191017131615.19660-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: robert.foley@futurewei.com,
 Richard Henderson <richard.henderson@linaro.org>, peter.puhov@futurewei.com,
 aaron@os.amperecomputing.com, cota@braap.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

By adding it to plugin-gen's header file, we can export is as
an inline, since tcg.h is included in the header (we need tcg_ctx).

Signed-off-by: Emilio G. Cota <cota@braap.org>
[AJB: use g_byte_array]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
v3
  - use g_byte_array
---
 include/exec/plugin-gen.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/exec/plugin-gen.h b/include/exec/plugin-gen.h
index de519883b1..4834a9e2f4 100644
--- a/include/exec/plugin-gen.h
+++ b/include/exec/plugin-gen.h
@@ -27,6 +27,17 @@ void plugin_gen_insn_end(void);
 void plugin_gen_disable_mem_helpers(void);
 void plugin_gen_empty_mem_callback(TCGv addr, uint32_t info);
 
+static inline void plugin_insn_append(const void *from, size_t size)
+{
+    struct qemu_plugin_insn *insn = tcg_ctx->plugin_insn;
+
+    if (insn == NULL) {
+        return;
+    }
+
+    insn->data = g_byte_array_append(insn->data, from, size);
+}
+
 #else /* !CONFIG_PLUGIN */
 
 static inline
@@ -51,6 +62,9 @@ static inline void plugin_gen_disable_mem_helpers(void)
 static inline void plugin_gen_empty_mem_callback(TCGv addr, uint32_t info)
 { }
 
+static inline void plugin_insn_append(const void *from, size_t size)
+{ }
+
 #endif /* CONFIG_PLUGIN */
 
 #endif /* QEMU_PLUGIN_GEN_H */
-- 
2.20.1


