Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2DDBFA372A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:50:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BC8B2067B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:50:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F0Vb0TwW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BC8B2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL6Ae-0005HL-0G
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 09:50:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35456)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iL5mP-00028b-PS
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:25:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iL5mO-0001FC-KC
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:25:25 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:42836)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iL5mO-0001Et-EF
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:25:24 -0400
Received: by mail-wr1-x436.google.com with SMTP id n14so2339894wrw.9
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 06:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=J5h9LF/cBImRwgBymxo6bpvt6wjjRh3DJds8b7bRsjM=;
 b=F0Vb0TwWW1BUduZbamzC0yB5eWrB/FWr0gz4JEIqQQqbx27l7sDZ3xm+0uNKm/56Ri
 CAzQMQZAn/QnafbL6Me8wcdtDJx93zD/piEQwvCN+vHbKkIQJQuRo5FxruOL4P9vrCzv
 p1U6J87gutNnneKMT7t3nsX961zrEwBtaB3I+CblSkDL1AtKUmQ4C6+JsQMIXJO2lwNC
 cn0lTU/5gUiogWn5tuKRHJMsYIKI4pu6BFNpvUOgo69Kkka6l7d2mabRghZDyrTmpiXd
 ua/ljXnkT+61npG0+pak6hhuvr3iGgElfPI+tL3KNLxOc/Ivt9oJUqBBIDgdXssbpOBN
 LqFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=J5h9LF/cBImRwgBymxo6bpvt6wjjRh3DJds8b7bRsjM=;
 b=XbMg3sVj5Wntqe5qMos0al6bWXGNnjnTQvDcpkC33ZmT23f2xOs+u6rf5M/l3yxHPH
 ZDSGSV6PNrsOFUIWC/7sMGKw2n53qLmGi0xk1r8cdAJXl4ElbNj5JCm4L5fFuKPcdJNC
 7/8AfHjZslO46voPzjk2AJ7IeB+mDddvhMQZMBTlePqCG9flFgFtGjD2U5u+7QjWIomw
 GrWp7g0tFPMT7JMJspcPbvQv60d7ThSA+9Wb342BOy27y577JPLmUX1G0wn9cWYFueq0
 XhJhq6NApU4msSvoeTkF6b2RnJgtX3uja6ccC8hFl7TnTNrSJr9ypwu8d9PIKgcfj0s3
 XyNw==
X-Gm-Message-State: APjAAAWnOAoUTtqGjoNxeQGc5Faj7FK6UpyhZqsWn+0D9Ua1/7uC1Ppp
 T2uRO2jsiXP1iO0QhYiy25YKOnrraNs=
X-Google-Smtp-Source: APXvYqyWguMhQDrteAaUtS6t6unxm+CgIaao0CAHGxtBrkO4qUDUCaHsM40Ut4nHn7kBIhVVAjELPA==
X-Received: by 2002:a05:6000:1190:: with SMTP id
 g16mr2997913wrx.133.1571318723103; 
 Thu, 17 Oct 2019 06:25:23 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x5sm2494190wrt.75.2019.10.17.06.25.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 06:25:22 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 921BF1FFBE;
 Thu, 17 Oct 2019 14:16:19 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v6 39/54] plugin: add qemu_plugin_outs helper
Date: Thu, 17 Oct 2019 14:16:00 +0100
Message-Id: <20191017131615.19660-40-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191017131615.19660-1-alex.bennee@linaro.org>
References: <20191017131615.19660-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::436
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
Cc: aaron@os.amperecomputing.com, cota@braap.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 robert.foley@futurewei.com, peter.puhov@futurewei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Having the plugins grab stdout and spew stuff there is a bit ugly and
certainly makes the tests look ugly. Provide a hook back into QEMU
which can be redirected as needed.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v6
  - split and move to pre example plugins
---
 include/qemu/log.h           | 1 +
 include/qemu/qemu-plugin.h   | 6 ++++++
 plugins/api.c                | 8 ++++++++
 plugins/qemu-plugins.symbols | 1 +
 util/log.c                   | 3 +++
 5 files changed, 19 insertions(+)

diff --git a/include/qemu/log.h b/include/qemu/log.h
index b097a6cae1..a91105b2ad 100644
--- a/include/qemu/log.h
+++ b/include/qemu/log.h
@@ -45,6 +45,7 @@ static inline bool qemu_log_separate(void)
 /* LOG_TRACE (1 << 15) is defined in log-for-trace.h */
 #define CPU_LOG_TB_OP_IND  (1 << 16)
 #define CPU_LOG_TB_FPU     (1 << 17)
+#define CPU_LOG_PLUGIN     (1 << 18)
 
 /* Lock output for a series of related logs.  Since this is not needed
  * for a single qemu_log / qemu_log_mask / qemu_log_mask_and_addr, we
diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index ddf267fbfe..a00a7deb46 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -384,4 +384,10 @@ int qemu_plugin_n_vcpus(void);
 /* returns -1 in user-mode */
 int qemu_plugin_n_max_vcpus(void);
 
+/**
+ * qemu_plugin_outs() - output string via QEMU's logging system
+ * @string: a string
+ */
+void qemu_plugin_outs(const char *string);
+
 #endif /* QEMU_PLUGIN_API_H */
diff --git a/plugins/api.c b/plugins/api.c
index 5adc4d25a1..fa1d9f276d 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -331,3 +331,11 @@ int qemu_plugin_n_max_vcpus(void)
     return get_ms()->smp.max_cpus;
 #endif
 }
+
+/*
+ * Plugin output
+ */
+void qemu_plugin_outs(const char *string)
+{
+    qemu_log_mask(CPU_LOG_PLUGIN, "%s", string);
+}
diff --git a/plugins/qemu-plugins.symbols b/plugins/qemu-plugins.symbols
index 267ec381b4..4bdb381f48 100644
--- a/plugins/qemu-plugins.symbols
+++ b/plugins/qemu-plugins.symbols
@@ -36,4 +36,5 @@
   qemu_plugin_vcpu_for_each;
   qemu_plugin_n_vcpus;
   qemu_plugin_n_max_vcpus;
+  qemu_plugin_outs;
 };
diff --git a/util/log.c b/util/log.c
index 1d1b33f7d9..1ca13059ee 100644
--- a/util/log.c
+++ b/util/log.c
@@ -273,6 +273,9 @@ const QEMULogItem qemu_log_items[] = {
     { CPU_LOG_TB_NOCHAIN, "nochain",
       "do not chain compiled TBs so that \"exec\" and \"cpu\" show\n"
       "complete traces" },
+#ifdef CONFIG_PLUGIN
+    { CPU_LOG_PLUGIN, "plugin", "output from TCG plugins\n"},
+#endif
     { 0, NULL, NULL },
 };
 
-- 
2.20.1


