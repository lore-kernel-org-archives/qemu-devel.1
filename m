Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24AA0C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 17:33:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8293A2053B
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 17:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q3IXCHJ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8293A2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYvFv-0006UN-Sm
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 13:33:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56676)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jYvEp-0004i3-87
 for qemu-devel@nongnu.org; Wed, 13 May 2020 13:32:11 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40745)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jYvEn-0007lP-06
 for qemu-devel@nongnu.org; Wed, 13 May 2020 13:32:10 -0400
Received: by mail-wr1-x441.google.com with SMTP id e16so445908wra.7
 for <qemu-devel@nongnu.org>; Wed, 13 May 2020 10:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=t9Sop/JZIFc8+KcCWQNsKU9OCXVZGmJjWJpVbXq1m9s=;
 b=Q3IXCHJ9ags7AJsZ3eetC1UY49ttWRma2/I/aiUyBZkOjOcDOoOiDqNPipFY7iQRXc
 MDa3DOUnbJD09FVa28baN2AeEc2Ndwsifqb4C7Y/gyAxtgM+pHwT5U288Vg0WmDyXNpb
 QZG4BR3sQa3MW+bosBnNpfgbq/57fXjKZw0OZWCs5SYr0eguQEENih4jsude7X+4wsKD
 MvGJmVj/xy7b+bFaAAvhw68Pl8fRmtPkgrUWQ4jRS4lkJZbfLGquFOiERUcFqq8WHDcD
 6c/CMO8p2xZSQ46/6Vmahp1e9rPHw/WieJl+sw5iuu7B88NyI0/9cq9wMeG8fGaDJV7U
 h9pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=t9Sop/JZIFc8+KcCWQNsKU9OCXVZGmJjWJpVbXq1m9s=;
 b=trJCl3qpT0PQJHm8b/9X36mOHiMnWVvMZFSXpXWgKS5BWhj77msUEAdo7D79fWHlxw
 0fNWJg/7h8RsXUJLOb+myX7YDqUABIy+LpBpan8IXToTilXeciEOvFKkUuUSmSW/Vj5E
 i4qxifKf65qneLcZY5n6l+C4rxUPkBLsj9iGVyGrOMLunF5KK5Ci4/gntNQNm73oo2KX
 JJCVpdybRJeOl0wQ5ekHiM7Lih1PE9K2JO5nyGtbt88mSl2+aZjAkUWT115pv1i2Cg/+
 Yu6m4Xq5eVX2J0Ci2Zb5uW8yITJkWJl5ijQPjt9Fe8SRdbsQ3WST+PfU/vzmXJioobwR
 nopQ==
X-Gm-Message-State: AOAM530BAyEx8gXV9QB+q+3XLNR2iTgSDU++Qw2wLgmY6n23ZCk8IEy3
 XhkTRMGJhqVoHraTk41PsJX/4A==
X-Google-Smtp-Source: ABdhPJzQf3/moO/pp0oN7YE21OFyk0gkAlXVPJ52Lp31bOZLOMBN+sjPaQG20uc0iWICPOHjbkzhmw==
X-Received: by 2002:a5d:49c4:: with SMTP id t4mr408377wrs.127.1589391126623;
 Wed, 13 May 2020 10:32:06 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 81sm20821140wme.16.2020.05.13.10.32.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2020 10:32:04 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 162461FF8C;
 Wed, 13 May 2020 18:32:01 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 2/8] qemu/plugin: Move !CONFIG_PLUGIN stubs altogether
Date: Wed, 13 May 2020 18:31:54 +0100
Message-Id: <20200513173200.11830-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200513173200.11830-1-alex.bennee@linaro.org>
References: <20200513173200.11830-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Simplify the ifdef'ry by moving all stubs together.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200510171119.20827-3-f4bug@amsat.org>
---
 include/qemu/plugin.h | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index e45f950fe36..ab790ad105c 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -46,22 +46,6 @@ static inline void qemu_plugin_add_opts(void)
 
 void qemu_plugin_opt_parse(const char *optarg, QemuPluginList *head);
 int qemu_plugin_load_list(QemuPluginList *head);
-#else /* !CONFIG_PLUGIN */
-static inline void qemu_plugin_add_opts(void)
-{ }
-
-static inline void qemu_plugin_opt_parse(const char *optarg,
-                                         QemuPluginList *head)
-{
-    error_report("plugin interface not enabled in this build");
-    exit(1);
-}
-
-static inline int qemu_plugin_load_list(QemuPluginList *head)
-{
-    return 0;
-}
-#endif /* !CONFIG_PLUGIN */
 
 union qemu_plugin_cb_sig {
     qemu_plugin_simple_cb_t          simple;
@@ -182,8 +166,6 @@ struct qemu_plugin_insn *qemu_plugin_tb_insn_get(struct qemu_plugin_tb *tb)
     return insn;
 }
 
-#ifdef CONFIG_PLUGIN
-
 void qemu_plugin_vcpu_init_hook(CPUState *cpu);
 void qemu_plugin_vcpu_exit_hook(CPUState *cpu);
 void qemu_plugin_tb_trans_cb(CPUState *cpu, struct qemu_plugin_tb *tb);
@@ -207,6 +189,21 @@ void qemu_plugin_disable_mem_helpers(CPUState *cpu);
 
 #else /* !CONFIG_PLUGIN */
 
+static inline void qemu_plugin_add_opts(void)
+{ }
+
+static inline void qemu_plugin_opt_parse(const char *optarg,
+                                         QemuPluginList *head)
+{
+    error_report("plugin interface not enabled in this build");
+    exit(1);
+}
+
+static inline int qemu_plugin_load_list(QemuPluginList *head)
+{
+    return 0;
+}
+
 static inline void qemu_plugin_vcpu_init_hook(CPUState *cpu)
 { }
 
-- 
2.20.1


