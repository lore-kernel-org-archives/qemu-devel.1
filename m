Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55388ECE587
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 11:07:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21AB020650
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 11:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fJOwChp4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21AB020650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJyCN-0007gL-0q
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 07:07:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44571)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iJxvQ-0007PV-0n
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:50:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iJxvO-0006AH-Pn
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:50:03 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51318)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iJxvO-00068c-Jm
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:50:02 -0400
Received: by mail-wm1-x341.google.com with SMTP id 7so16758920wme.1
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 03:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=t6U3oBlc6u1UdxE1uAu8xMOurpvpIFfvpufH8BjBIdw=;
 b=fJOwChp4bMBjNwazG0QV8ZPxEsC7CCi2q3piXYzbEJrTvSwWaiB7fHyc5GE+ArfL3+
 M72vgVBDN5hOOHYAKy8mkb0+K/THDwJ07c06Ck1HaJHzoi/I1FMoQEmNpCKGgw7WcY4w
 wOiWix/UrIMynAA7VoYa7IUOVBg7kYjW8g2FXS3lie5ctN4TExw9snmte7e97/VqdmkQ
 boHIeYsvd8iB+7O6RjWBbImno76rzfynKMvjRJcXJuxCjNbHPg0DS/5L4mIRHr/CSH/U
 WkYMIM/hmpBr/m13CWg/lbvPYbloSVs+25Q2v/zG5GUON6XnMbIMyua47Ptyqsqczjyb
 aCGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=t6U3oBlc6u1UdxE1uAu8xMOurpvpIFfvpufH8BjBIdw=;
 b=Wf76U52rTyEt8fm+uR14UDeXo1PyXD6q47bnmBu3ETQ2XkLQd4vjaAqhr6FUrwNvjL
 Brim28xf3wadhmTD09fsjsB65r4unI/6AbDFRAsX5lIR9wj5Seg+5bmBD8ScEoMVT+td
 UeA7w3OurTh67XsFMsck+hEnBxYWsatkPYcGfPO69CJafXxA2WR0YYnKomiOAAWMX1DA
 olfhoMtP5pUNIwcz/Btbd6eh0ufPTiXytxFAbHHYJNVbqWU+9Gv8mmfUek67xOt0tvq8
 x3phTLh1yMGFW83magR2Teo7gfhUfbwNXG4NhoPIvW+WzxyJ8LG4CyQ+9eSeoBlerG5P
 D9Yw==
X-Gm-Message-State: APjAAAV+pK+C7bJH/L/t1xkY16/vstnOKyPXgCMDrlwGl45OmEAbI2UF
 KWu/ED5BqgAq6aJZ5h6pwVncPA==
X-Google-Smtp-Source: APXvYqxFgpKNxE47NR3pCaiTbmyq7sWYTma9HNU9poHa/tVtU9xRaXpde1tr26yazhhyI7U2/vo0kA==
X-Received: by 2002:a05:600c:2054:: with SMTP id
 p20mr15336666wmg.76.1571050201549; 
 Mon, 14 Oct 2019 03:50:01 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z189sm32321718wmc.25.2019.10.14.03.49.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 03:49:59 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6090E1FF92;
 Mon, 14 Oct 2019 11:49:54 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v5 22/55] plugin-gen: add plugin_insn_append
Date: Mon, 14 Oct 2019 11:49:15 +0100
Message-Id: <20191014104948.4291-23-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014104948.4291-1-alex.bennee@linaro.org>
References: <20191014104948.4291-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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


