Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38DC5C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:15:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0491C206A3
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:15:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sM5s12xn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0491C206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsrGT-0006Sq-9Y
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 12:15:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40375)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hsr8h-00027w-GZ
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:07:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hsr8f-0000lE-5T
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:07:43 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33613)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hsr8e-0000hn-Cz
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:07:40 -0400
Received: by mail-wr1-x441.google.com with SMTP id n9so70407051wru.0
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 09:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GmxoVYqSi+9b817kRDEMuLT6apMjPTB3tafVvwHS5rQ=;
 b=sM5s12xnGTDAcJgriEAPd069+NsIoDM75HbkFazGQOGkmgQqIwCwYuOK6xz7Mx0Bc+
 tnduWy/ebK0pTGdAUfXJI7Af8UmnpPh7XWo31loVDo7GHj2e5psthcg0ImmtlQc0bHBM
 OgprmpnjWiYaXLzgE1c6qNoyEzbQDZy97uRU32bPK4Iz3My1YgT0UZxqUDGvXNW85sZx
 frZI5pCnO5cfNWUsfWymNM+HpC4RWS9PUvRPpX3VjBLcNfowFNmwHcxElcprI+g92vqE
 yY5rwUX9R3Ns0ItyvdCoPAH8uQkwzJ9v/LeIIWTG380fCGP2aqU8D7NhuVHHjwWjCk8X
 rAIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GmxoVYqSi+9b817kRDEMuLT6apMjPTB3tafVvwHS5rQ=;
 b=MtN8gTxikcS7PtDQdtx/z5UdyT3SNxBQZNe/WC+0hA9/J/el48w2CgPWesjRZC3aED
 R6Zdoq4pch4GvFD7C4RwdCKjWRkxv3X8dkeYlN1NiiFKZn89wIKu5ZMpRBbxonufwVyQ
 Gj3J4GaKgRgesXKqbY/QxLanOUly6cyGSfwPerwGIGf4+6rNC7MkAfe/KdFixvQHiDKH
 e+B0akv3ilSvGvyGXwMX1A9CBvu2idUZZdaMeMlqJIgEiBJqsPDW8EfaYEcYowWyV8DS
 eRjQOClNVSHmwva1SCCJ7hm1WuspnDv74A/tAZ7req+yfagcX1FXYQnua1n+iW8GW/+/
 pi7A==
X-Gm-Message-State: APjAAAXyXoTCD73M56OqzUl97Hf2cJpg+btyGOrtFqtpY7AzbvnQyTAw
 EvAsLDa0v/GohBUpy+qfYwyaPQ==
X-Google-Smtp-Source: APXvYqzonY00aribchdiGNrDW2Cz73vIuscEhJItbN2oO6pAbM7yKq/zagDIfkyUJfN42RQ4q1WfPg==
X-Received: by 2002:adf:f646:: with SMTP id x6mr143350740wrp.18.1564589252615; 
 Wed, 31 Jul 2019 09:07:32 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id z1sm72144165wrp.51.2019.07.31.09.07.25
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 09:07:31 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 419831FFB3;
 Wed, 31 Jul 2019 17:07:22 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 17:06:54 +0100
Message-Id: <20190731160719.11396-30-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190731160719.11396-1-alex.bennee@linaro.org>
References: <20190731160719.11396-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH  v4 29/54] plugin-gen: add plugin_insn_append
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
Cc: bobby.prani@gmail.com, cota@braap.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 aaron@os.amperecomputing.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

By adding it to plugin-gen's header file, we can export is as
an inline, since tcg.h is included in the header (we need tcg_ctx).

Signed-off-by: Emilio G. Cota <cota@braap.org>
[AJB: use g_byte_array]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v3
  - use g_byte_array
---
 include/exec/plugin-gen.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/exec/plugin-gen.h b/include/exec/plugin-gen.h
index de519883b16..4834a9e2f40 100644
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


