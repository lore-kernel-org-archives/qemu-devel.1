Return-Path: <SRS0=vfNf=6Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C25CC38A2A
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2020 17:12:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45F2320736
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2020 17:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TDiXw/Qo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45F2320736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXpVA-0007Sn-FN
	for qemu-devel@archiver.kernel.org; Sun, 10 May 2020 13:12:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36884)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jXpU9-0005nu-1r; Sun, 10 May 2020 13:11:29 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:43806)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jXpU8-0000C2-AJ; Sun, 10 May 2020 13:11:28 -0400
Received: by mail-ej1-x644.google.com with SMTP id o10so5850371ejn.10;
 Sun, 10 May 2020 10:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2wY0Jnl7mJEYElH4v6fPrm4v3qIHs5F0/By9SpX3QVg=;
 b=TDiXw/QoPa5H9McmoJA25SzFHUBNYwZ2Hb4cv994QyKZJXIrvW+5B6KU11lXuvliQd
 I9Cxtf25FcVDHNy7xThaXFD2PBx7ldOHWPrttFZFv84pRuwLBaWQyVlxBiY92gVALxN+
 nY5/pehTsq6DPz9gsd7j8bN0SLZOY+FecI/7MCjh2+MFJIvrQC/arUqwfoidEqIKwq8C
 leC9bYUuPOpziYTCqVGikc7nGXahXSniNy+gg2eRyA6DlpRr/8qfTw4ZhU++mHnE5tkj
 MpDHYZcKpklUjCHW89q9LuHXUbmhpVwbn7aXa+P73rljvjlF4yJ6PEu6lxBYVF6oJZho
 Mlvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=2wY0Jnl7mJEYElH4v6fPrm4v3qIHs5F0/By9SpX3QVg=;
 b=qrWJvC+2726sb9itMN7RFyVFDp7hviyR+wJmSZiYlTE1XELPGzJl8MJorPDp+GHeZn
 dvIqcRIAI0hTMq08ZfmNhRXuywRYemAZiYxrG1gvtZEiWCzO7ZJsW5Jpz0Mh/HB7hWNh
 wGlBtcJ8/+qy0cuVrRiZm2PXBaPjy48FdosgKGkVNtL+knd6CzAzBf/qjvNUcPMygw9v
 AzHyG/3p1QdGdnxvPWJe83vRan8qDsM0RRK8dsRdo3+ybhnYKYazxgtKpukL2u14lvDT
 001AGOKB75YvMJTPyC+DLzCoIQQDgomYraiCXNv34cDJ8r/iCOEKofoMbtaRg8ZfBGO5
 CdYw==
X-Gm-Message-State: AOAM530E9FEp7jzF1E5vNdtO6O8IJ/WaX6O/pSVyK3nwAmD0HyTzf3Sn
 Flx2FjIdU4s3qdGhBw3QzRLjvuW1ROM=
X-Google-Smtp-Source: ABdhPJxPmol4XpTeOUfNwUHB7wG9A2LzUzAXgxWQkVMQSU2Piu/qwGT/bFIJTOAWNz1HRCTXMaDqlw==
X-Received: by 2002:a17:906:404a:: with SMTP id
 y10mr1173255ejj.130.1589130686406; 
 Sun, 10 May 2020 10:11:26 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id w7sm960776edr.20.2020.05.10.10.11.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 May 2020 10:11:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/3] qemu/plugin: Move !CONFIG_PLUGIN stubs altogether
Date: Sun, 10 May 2020 19:11:18 +0200
Message-Id: <20200510171119.20827-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200510171119.20827-1-f4bug@amsat.org>
References: <20200510171119.20827-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
Cc: qemu-trivial@nongnu.org, "Emilio G . Cota" <cota@braap.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Simplify the ifdef'ry by moving all stubs together.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/qemu/plugin.h | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index e45f950fe3..ab790ad105 100644
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
2.21.3


