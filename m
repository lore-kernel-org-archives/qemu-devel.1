Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 668CAC352A3
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 23:05:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3144020675
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 23:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hjLNs/VK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3144020675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2NXY-000894-Ap
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 18:05:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40177)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j2NKV-00058V-4C
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 17:51:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j2NKT-00048a-QG
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 17:51:31 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:35928)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j2NKT-00046A-In
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 17:51:29 -0500
Received: by mail-wm1-x343.google.com with SMTP id p17so8613500wma.1
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 14:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KXMngXIFaO7CsnyCy/hFBjzW3N8yM4HjBEk1iXtE1Sc=;
 b=hjLNs/VKAMUlMkReH7wRf1oxOUGeghpQBm9N2Hz8Mh4RmPFZGmz8ve/7deldGMwvWJ
 Y31gXGXoApTbx+/j7vnJSLtHn6Unkm6h1vWTY2zs4NrMWge6i6rxbU2Cow7eyH9ivIFe
 c+4jPnNJGjNqpc/i6AV+sJQFxeNuvJDWzRRflNE5Bh0DVUf655aKQs0iHASXt+LuJ4nQ
 SJqluhI0Hm4ra8vtzmknMo0JyNGHy66GcGi2FlWdqPjSiF3nrStJzPnkQzCCHqJGkBOT
 CQyKRmjN0F4iEtTgr7xcIUz3fcRLBrSNzavhmFyiy1iIfHlHuPdVQYdXtcp+5HuBS/lM
 fTKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KXMngXIFaO7CsnyCy/hFBjzW3N8yM4HjBEk1iXtE1Sc=;
 b=mUQ+K3awauo0kKqk9uvWjopLACZsUembMMa8gLpCssPi5mwX19RaKJ7BPSv+ifWrUJ
 5j7vgY64B4uUFaQ4wg6+n0V4/d1M1Nq5IWF68EO/6EMT+9ZVofUkQWTPHGNZRInH5ogo
 NyY5BZ3GKlXNk4cs4nZSKhmU5l5mA9O71NHp4dzbq6KHyRq7KXIZqy6fHagIhJjO1Lpc
 YNumf0DldMK4S1kmWY+Ol4EMwCJG9AiNwjHKVt6FbznHZVPnbiYlxuwZEUXj7QfsLXyp
 IZu/t/nWt9KfgJgGTE5XCOYuloRcPcT3slJcjuV1byxGjffejkqaSsRpIXk1Mercrsw5
 lLbg==
X-Gm-Message-State: APjAAAVU7k6GdzxizQeY5yZRWFYvrWNy8B9tmArb7R91wRyCzBnEPJBH
 HCdQ8iycmKdzdBSLyqaWjv8hHw==
X-Google-Smtp-Source: APXvYqzHK9ao6abtRObDnx63YVtYorm55G9DyZX8ipG9JSezk1MYyZzHSd977GhJblg7cVIRmYrnLQ==
X-Received: by 2002:a7b:ce98:: with SMTP id q24mr297673wmj.41.1581634288590;
 Thu, 13 Feb 2020 14:51:28 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f12sm4702437wmj.10.2020.02.13.14.51.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 14:51:20 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 223FB1FFA6;
 Thu, 13 Feb 2020 22:51:11 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 17/19] tcg: save vaddr temp for plugin usage
Date: Thu, 13 Feb 2020 22:51:07 +0000
Message-Id: <20200213225109.13120-18-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200213225109.13120-1-alex.bennee@linaro.org>
References: <20200213225109.13120-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: fam@euphon.net, berrange@redhat.com, robert.foley@linaro.org,
 pbonzini@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, robhenry@microsoft.com,
 qemu-stable@nongnu.org, marcandre.lureau@redhat.com,
 aaron@os.amperecomputing.com, cota@braap.org, stefanha@redhat.com,
 kuhn.chenqun@huawei.com, peter.puhov@linaro.org, aurelien@aurel32.net,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

While do_gen_mem_cb does copy (via extu_tl_i64) vaddr into a new temp
this won't help if the vaddr temp gets clobbered by the actual
load/store op. To avoid this clobbering we explicitly copy vaddr
before the op to ensure it is live my the time we do the
instrumentation.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: qemu-stable@nongnu.org
---
 tcg/tcg-op.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 7d782002e3f..e2e25ebf7db 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -2794,13 +2794,26 @@ static void tcg_gen_req_mo(TCGBar type)
     }
 }
 
+static inline TCGv plugin_prep_mem_callbacks(TCGv vaddr)
+{
+#ifdef CONFIG_PLUGIN
+    if (tcg_ctx->plugin_insn != NULL) {
+        /* Save a copy of the vaddr for use after a load.  */
+        TCGv temp = tcg_temp_new();
+        tcg_gen_mov_tl(temp, vaddr);
+        return temp;
+    }
+#endif
+    return vaddr;
+}
+
 static inline void plugin_gen_mem_callbacks(TCGv vaddr, uint16_t info)
 {
 #ifdef CONFIG_PLUGIN
-    if (tcg_ctx->plugin_insn == NULL) {
-        return;
+    if (tcg_ctx->plugin_insn != NULL) {
+        plugin_gen_empty_mem_callback(vaddr, info);
+        tcg_temp_free(vaddr);
     }
-    plugin_gen_empty_mem_callback(vaddr, info);
 #endif
 }
 
@@ -2822,6 +2835,7 @@ void tcg_gen_qemu_ld_i32(TCGv_i32 val, TCGv addr, TCGArg idx, MemOp memop)
         }
     }
 
+    addr = plugin_prep_mem_callbacks(addr);
     gen_ldst_i32(INDEX_op_qemu_ld_i32, val, addr, memop, idx);
     plugin_gen_mem_callbacks(addr, info);
 
@@ -2868,6 +2882,7 @@ void tcg_gen_qemu_st_i32(TCGv_i32 val, TCGv addr, TCGArg idx, MemOp memop)
         memop &= ~MO_BSWAP;
     }
 
+    addr = plugin_prep_mem_callbacks(addr);
     gen_ldst_i32(INDEX_op_qemu_st_i32, val, addr, memop, idx);
     plugin_gen_mem_callbacks(addr, info);
 
@@ -2905,6 +2920,7 @@ void tcg_gen_qemu_ld_i64(TCGv_i64 val, TCGv addr, TCGArg idx, MemOp memop)
         }
     }
 
+    addr = plugin_prep_mem_callbacks(addr);
     gen_ldst_i64(INDEX_op_qemu_ld_i64, val, addr, memop, idx);
     plugin_gen_mem_callbacks(addr, info);
 
@@ -2967,6 +2983,7 @@ void tcg_gen_qemu_st_i64(TCGv_i64 val, TCGv addr, TCGArg idx, MemOp memop)
         memop &= ~MO_BSWAP;
     }
 
+    addr = plugin_prep_mem_callbacks(addr);
     gen_ldst_i64(INDEX_op_qemu_st_i64, val, addr, memop, idx);
     plugin_gen_mem_callbacks(addr, info);
 
-- 
2.20.1


