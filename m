Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB99C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 14:53:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5A9D2076A
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 14:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="if1+c6mF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5A9D2076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZbhv-00070f-TF
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 10:53:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44566)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jZbZX-0002Sm-Jo
 for qemu-devel@nongnu.org; Fri, 15 May 2020 10:44:24 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:54912)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jZbZW-000106-8o
 for qemu-devel@nongnu.org; Fri, 15 May 2020 10:44:22 -0400
Received: by mail-wm1-x32e.google.com with SMTP id h4so2581667wmb.4
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 07:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+a2TvwRII2J7AoPGBoNpj53l/Ezc+QlB4IwOZgMmlqY=;
 b=if1+c6mFY3gjwptzcSIKYu57JQSJPsBtm2MSa1f5mOhsDDcOMRUO5DQO/Xa04vkEDE
 D9vm4MGzPns7zad2RecwqmUMhyYTLrRqlV6OxMhbEAolgHg48MrCM0+8JoBEqXVljKdS
 Aw9gdZg8zXOtkQw5fp2vZhU2iAhDFnFJLXReO4D09A2k5FcwAhPC8O0R39sPQPUtdkSM
 pmNo88+HPjGbMFO81Rn3iqImmXk8GMPixDJvyrh1e3RBCeMRP5ov6sW7RNneJWtMzL7U
 gALE11rnlV01ut2HJSLzhgzA6Ff40jyiKvh9dU5yJpmiOMdIjsYula/1671Py9mZR2Uf
 FsuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+a2TvwRII2J7AoPGBoNpj53l/Ezc+QlB4IwOZgMmlqY=;
 b=Kdmt82YPPNtL4HmamauxUtJ0oUSWJjytn36GvRG2W4qH27yRrn4SNwrCNvsPbU7wgG
 wM3wSLAdy48IpFFOl0uTO5Z/YnrIUE0HiNlLIem9EotclOzGy1eKIpL1feuO1N4DZLMY
 epTpXRXNFs7aqYb3Xw/1EErx9wCcqvPNOXyWOmcpptvNhrc4ECtq7lm8reBmgIqGzW95
 QN+lcf+vRjw/Q5iBL5P+Up5i6aTQWlVfBPsLwZKt4kxoJEeVkiEUkCHFdEjnJmEIb3LJ
 zuR8Vv0L0rYA3hcJUEX6RzQazH5Kds/nf28rb+sMDmiTeP+cP8D3XB4oBZ4VmjGIuGL5
 phfw==
X-Gm-Message-State: AOAM531jxu0SCwujh5t0WiYnDZWaHZm7izTsqv2R+EEi8Fn97GATaKZr
 5yUMKrKf3mlZ0o3X5en5d4z5iA==
X-Google-Smtp-Source: ABdhPJz+TqOIwyABF4FGW1pCKR9WxHx7jEVlbiWVb0f0lVMea9p2sRAgSXaW6XBUgrBBDcQytEp6Wg==
X-Received: by 2002:a1c:b354:: with SMTP id c81mr4355499wmf.136.1589553860752; 
 Fri, 15 May 2020 07:44:20 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t7sm3982423wrq.39.2020.05.15.07.44.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2020 07:44:12 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1D6E61FF99;
 Fri, 15 May 2020 15:44:06 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 10/13] qemu/plugin: Trivial code movement
Date: Fri, 15 May 2020 15:44:02 +0100
Message-Id: <20200515144405.20580-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200515144405.20580-1-alex.bennee@linaro.org>
References: <20200515144405.20580-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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
Cc: "open list:Trivial patches" <qemu-trivial@nongnu.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 qemu-devel@nongnu.org, "Emilio G . Cota" <cota@braap.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Move the qemu_plugin_event enum declaration earlier.
This will make the next commit easier to review.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200510171119.20827-2-f4bug@amsat.org>
Message-Id: <20200513173200.11830-2-alex.bennee@linaro.org>

diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index 11687e8cdc3..e45f950fe36 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -13,6 +13,22 @@
 #include "qemu/queue.h"
 #include "qemu/option.h"
 
+/*
+ * Events that plugins can subscribe to.
+ */
+enum qemu_plugin_event {
+    QEMU_PLUGIN_EV_VCPU_INIT,
+    QEMU_PLUGIN_EV_VCPU_EXIT,
+    QEMU_PLUGIN_EV_VCPU_TB_TRANS,
+    QEMU_PLUGIN_EV_VCPU_IDLE,
+    QEMU_PLUGIN_EV_VCPU_RESUME,
+    QEMU_PLUGIN_EV_VCPU_SYSCALL,
+    QEMU_PLUGIN_EV_VCPU_SYSCALL_RET,
+    QEMU_PLUGIN_EV_FLUSH,
+    QEMU_PLUGIN_EV_ATEXIT,
+    QEMU_PLUGIN_EV_MAX, /* total number of plugin events we support */
+};
+
 /*
  * Option parsing/processing.
  * Note that we can load an arbitrary number of plugins.
@@ -47,22 +63,6 @@ static inline int qemu_plugin_load_list(QemuPluginList *head)
 }
 #endif /* !CONFIG_PLUGIN */
 
-/*
- * Events that plugins can subscribe to.
- */
-enum qemu_plugin_event {
-    QEMU_PLUGIN_EV_VCPU_INIT,
-    QEMU_PLUGIN_EV_VCPU_EXIT,
-    QEMU_PLUGIN_EV_VCPU_TB_TRANS,
-    QEMU_PLUGIN_EV_VCPU_IDLE,
-    QEMU_PLUGIN_EV_VCPU_RESUME,
-    QEMU_PLUGIN_EV_VCPU_SYSCALL,
-    QEMU_PLUGIN_EV_VCPU_SYSCALL_RET,
-    QEMU_PLUGIN_EV_FLUSH,
-    QEMU_PLUGIN_EV_ATEXIT,
-    QEMU_PLUGIN_EV_MAX, /* total number of plugin events we support */
-};
-
 union qemu_plugin_cb_sig {
     qemu_plugin_simple_cb_t          simple;
     qemu_plugin_udata_cb_t           udata;
-- 
2.20.1


