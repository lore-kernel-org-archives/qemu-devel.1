Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEDD6C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 14:45:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADA0B20671
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 14:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h3YvXUce"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADA0B20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZbat-0004Tb-Ss
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 10:45:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44582)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jZbZZ-0002TS-0Y
 for qemu-devel@nongnu.org; Fri, 15 May 2020 10:44:25 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:36296)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jZbZW-0000zt-8l
 for qemu-devel@nongnu.org; Fri, 15 May 2020 10:44:24 -0400
Received: by mail-wr1-x42f.google.com with SMTP id k13so1752012wrx.3
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 07:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tQttWf6rj7Sr02MvNzPrzDKjaidbgt9rChCOOlqQ7tY=;
 b=h3YvXUcey3SwVJH3uSvxflWNCFYtighn8umzhlgeM3Ygr38zm0QgbfA1BGEJ3syD3f
 kVPGwNuKD/68h0A1g/tUyYIJaRJ1AooXFvTJ1GydvZqC8ijDm03Qa/Bj/5owMUxS2OD8
 7je+2tv+dwFbp+DG4Z+57+rH3KRYPnnxJHxLHmpatEQ3xUfKitX2bLMRyynof1Yec7Bo
 VFbXDx9XFEmt2/Z+Itqz1VFcCyV/36SIulZa5X50WDwAwBNgPcs6/Y8jYMVP0qbC/EIA
 Tss28nl0E3yKCTiYHJV8AeC58Ui7xVHd+Ks11+ygdr+O2F66rZjrZM/5jtj4htnPGgbc
 xgwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tQttWf6rj7Sr02MvNzPrzDKjaidbgt9rChCOOlqQ7tY=;
 b=eh19SkChZ2rDIuU7egGOQ8IMU1oll2mrRqeBbnlRoXmKuEzpKYcl4UIZygJoAxjvau
 dGftoBX5C/8iJvrq/GGT5glGi1/K4s/Nj1EdokKHOuF7lVvrVrqFMCQI+ZxMfBN9x4eU
 wbk5B75s0VytaSPDgCsPXW2worHMRKgVC2a8B0JtvNVLf4lY0cPUiN/bRdSem5b5z5v1
 gN/JDO5cGvmMqc5ag35LoQOhOd5uzXKEYXjDL4aIPDe1BXkorV4C4rRJ037BPKxEX5aK
 fxj1vQfVxdUorldAbRPxBdu3B3+lIfm8ylNcG0AhAHi4zDQoDEsn87zmZXQCgCzL4JOy
 PetA==
X-Gm-Message-State: AOAM531tnITXCBbngRCsQL1gy6Knx1/exUVCQMEvDWHMd8J2xdYRIODm
 Fkby5itvu5Rfc8rKOVkJfoGQcw==
X-Google-Smtp-Source: ABdhPJyVhmEc2Q/Tzfh2spg3zVIWM7JglrPXz/y/+wZaI9lH9TVyADaJowLVIoe5eo3VJND+5TXnRA==
X-Received: by 2002:adf:c414:: with SMTP id v20mr4447467wrf.379.1589553859815; 
 Fri, 15 May 2020 07:44:19 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id m23sm3950760wmg.45.2020.05.15.07.44.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2020 07:44:12 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 326A91FF9A;
 Fri, 15 May 2020 15:44:06 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 11/13] qemu/plugin: Move !CONFIG_PLUGIN stubs altogether
Date: Fri, 15 May 2020 15:44:03 +0100
Message-Id: <20200515144405.20580-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200515144405.20580-1-alex.bennee@linaro.org>
References: <20200515144405.20580-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
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
Cc: "Emilio G . Cota" <cota@braap.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Simplify the ifdef'ry by moving all stubs together.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200510171119.20827-3-f4bug@amsat.org>
Message-Id: <20200513173200.11830-3-alex.bennee@linaro.org>

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


