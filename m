Return-Path: <SRS0=vfNf=6Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1656C38A2A
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2020 17:14:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AD5D206D6
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2020 17:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDddxZcL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AD5D206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXpWb-0002Q6-NH
	for qemu-devel@archiver.kernel.org; Sun, 10 May 2020 13:14:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36880)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jXpU7-0005mN-LA; Sun, 10 May 2020 13:11:27 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:42479)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jXpU7-0000Bt-0J; Sun, 10 May 2020 13:11:27 -0400
Received: by mail-ed1-x542.google.com with SMTP id s10so5858008edy.9;
 Sun, 10 May 2020 10:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+R9EYTOiCvQbq05OuVhtB2qHgFEnZLCI6qjL27hF2YM=;
 b=MDddxZcLQ+i1nMJ1VDYjSlrbsSI/8AnySHKjg6Sj2RIURwJQUlfl2olECr+RGeqSCh
 BE61NzR6pOJjkuzO1g/S3AdvyJAisthr6z8Jvw5xJ/98Xlr+19EN/6PEFBPjMtICqZ5z
 9+kdkjjB7EWxdDgIo8NgPvzJ7v5wPUJUZBdoCooIC1YHcW+J/KhjsFy/29/DN1l0TY/3
 qCI6OB+rljyLQoQ3DPKh516rte10nlooxyj4i92tmwda2U5ZxlcLJfnqANYbJjPOsJ3w
 6l9nlJSKIYFkVJE7IH73W37fFCz/NjU8nxwl6RcSmTthN5B7ALCSQRPfcgedkZi4o2sO
 iFww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=+R9EYTOiCvQbq05OuVhtB2qHgFEnZLCI6qjL27hF2YM=;
 b=t6REItwDC8SRcocxU6pJGMwSV6S0J4MWdATjDwgzd8P1mAfdGDzWmZABrG7bkxXND/
 lVKZ786WVwrVuf1i2lZc9aZQcfeC4sQkTtgWwsNpqOuif+ctH0YuzQ5ebFeqC0nTQ42H
 Ab4oKETLXfAHPmMz9xz8yIrabjlhQps7pqw6HyvNpsJMxyoV4qR2jewh3BRvrsMp4VT+
 DKLGhZ8Iz180ktui1i6DoUBghrK4z89AVgbF0retyHG5UkJADQW5JF64BpHPJ5GkORq2
 Fu+xtyoPbSVLqxltY544ElEck7U9TycRnENXHu35RXKSRxUi3r/S7qe+GHx6HBCCx3/7
 YXZA==
X-Gm-Message-State: AGi0PuZMc8w1z/Q1EM7DOg2uLkok9f5r7ExWLaR/zv50nxvodLuZ7UNj
 XYH0QgD7HnmhjxiAv8MZuKu+B8ZM8/M=
X-Google-Smtp-Source: APiQypJaVTuou/HjJPd6Fon9772mjdoCV7ap9k7rX38nALdYYvUXxMeJYJ+nhfK9F42kM7sSFWo7gg==
X-Received: by 2002:a05:6402:1d89:: with SMTP id
 dk9mr10153093edb.382.1589130685005; 
 Sun, 10 May 2020 10:11:25 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id w7sm960776edr.20.2020.05.10.10.11.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 May 2020 10:11:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/3] qemu/plugin: Trivial code movement
Date: Sun, 10 May 2020 19:11:17 +0200
Message-Id: <20200510171119.20827-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200510171119.20827-1-f4bug@amsat.org>
References: <20200510171119.20827-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x542.google.com
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
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Laurent Vivier <laurent@vivier.eu>, "Emilio G . Cota" <cota@braap.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move the qemu_plugin_event enum declaration earlier.
This will make the next commit easier to review.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/qemu/plugin.h | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index 11687e8cdc..e45f950fe3 100644
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
2.21.3


