Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23414FA372A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 14:38:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE22621A4C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 14:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SdiZc4vS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE22621A4C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL6uh-0005fK-NL
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 10:38:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37501)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iL5w7-0005xj-5c
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:35:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iL5w5-0004Qj-B0
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:35:27 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44880)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iL5w5-0004Pw-4e
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:35:25 -0400
Received: by mail-wr1-x444.google.com with SMTP id z9so2373666wrl.11
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 06:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=G6i8iHuwznpz+U1YFqKClWDlEDl0r8YmQ0dBefcdrI8=;
 b=SdiZc4vSEfjoFdfXfkIQyfSdh7Ivxp2mD6QH58PL2jNUPKnFotm64MxgX+9lpWDl3H
 La5X6Z3dSrchs0lvo47nwJBynLwkuqglXyHIIFvMvCiBXmDAhkNA+ipGO7V3CKlEemQ/
 txQS0Ksxzpa4ZwiLJcyI3FQOmQYUTOhlZfBX1MBAVqG1/1xS6f0k6E01Wk+G0kJ+AhAK
 9eoJgoIkird8XuMXUgFEFwQFoDV1zE4aU7wSFqB7nIFhrAaHCdBw4/oZnY+9z6QSecVi
 i58+Kh8gmakXVFMjQtlHuSv9YQBiCvCBVanGU+1Q+BRHWgLWD+b74sLW5YIkSzdb+MCL
 cQcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=G6i8iHuwznpz+U1YFqKClWDlEDl0r8YmQ0dBefcdrI8=;
 b=iObofW0oLaExZWuoiRV6OAP2nNslDVkzUiQWl8nV9VE46ziHqqTE5mg/r5C1Qoc8gE
 1vuxGquu8Gd9Xe8yz7oW18/mSysl2R3MFVtvK1WKpUwMq9pBGoQthDlX9FXYCkMGYYuX
 rDdsBT4jrpi2c5QmP9fJ9DMlQLQR4fg5A8CnE3aoxXOXLoLUMKWdxSipQxHKmihqqo26
 uDibNpRfWYMc3dj0OmCUjdR018Y0wFt0X9+ICmCEE7RaGmH4+IpnxrqpE/UsnyuyhUUR
 yLjyPsVGUOSbzdARn0YeKQrtA2hAU2Bxk8CmFtSKdERr95ujioNRd3rvLC5qoxesCTI8
 uQUA==
X-Gm-Message-State: APjAAAW8gzm0nFenbhKbRsY6VWzV+WVjjhzrgQJY3RwGM6El35ypD33y
 9NqjonCQ4Ly26wavAjpHqhRSng==
X-Google-Smtp-Source: APXvYqx77TaQSs5BK1pUHPA1P176r+puyxqjM0+iuVZPCDtqszArjCIhW0h1HOoSyHpYBZ0lB7fX2A==
X-Received: by 2002:a05:6000:1190:: with SMTP id
 g16mr3038816wrx.133.1571319322805; 
 Thu, 17 Oct 2019 06:35:22 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o19sm2622802wmh.27.2019.10.17.06.35.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 06:35:21 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D41C11FFA6;
 Thu, 17 Oct 2019 14:16:17 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v6 20/54] cpu: hook plugin vcpu events
Date: Thu, 17 Oct 2019 14:15:41 +0100
Message-Id: <20191017131615.19660-21-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191017131615.19660-1-alex.bennee@linaro.org>
References: <20191017131615.19660-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, robert.foley@futurewei.com,
 Richard Henderson <richard.henderson@linaro.org>, peter.puhov@futurewei.com,
 aaron@os.amperecomputing.com, cota@braap.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Signed-off-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 cpus.c        | 10 ++++++++++
 exec.c        |  2 ++
 hw/core/cpu.c |  2 ++
 3 files changed, 14 insertions(+)

diff --git a/cpus.c b/cpus.c
index 367f0657c5..cdd2798c0a 100644
--- a/cpus.c
+++ b/cpus.c
@@ -45,6 +45,7 @@
 #include "exec/exec-all.h"
 
 #include "qemu/thread.h"
+#include "qemu/plugin.h"
 #include "sysemu/cpus.h"
 #include "sysemu/qtest.h"
 #include "qemu/main-loop.h"
@@ -1254,9 +1255,18 @@ static void qemu_tcg_rr_wait_io_event(void)
 
 static void qemu_wait_io_event(CPUState *cpu)
 {
+    bool slept = false;
+
     while (cpu_thread_is_idle(cpu)) {
+        if (!slept) {
+            slept = true;
+            qemu_plugin_vcpu_idle_cb(cpu);
+        }
         qemu_cond_wait(cpu->halt_cond, &qemu_global_mutex);
     }
+    if (slept) {
+        qemu_plugin_vcpu_resume_cb(cpu);
+    }
 
 #ifdef _WIN32
     /* Eat dummy APC queued by qemu_cpu_kick_thread.  */
diff --git a/exec.c b/exec.c
index fb0943cfed..1feda0ca76 100644
--- a/exec.c
+++ b/exec.c
@@ -975,6 +975,8 @@ void cpu_exec_realizefn(CPUState *cpu, Error **errp)
     }
     tlb_init(cpu);
 
+    qemu_plugin_vcpu_init_hook(cpu);
+
 #ifndef CONFIG_USER_ONLY
     if (qdev_get_vmsd(DEVICE(cpu)) == NULL) {
         vmstate_register(NULL, cpu->cpu_index, &vmstate_cpu_common, cpu);
diff --git a/hw/core/cpu.c b/hw/core/cpu.c
index 73b1ee34d0..db1a03c6bb 100644
--- a/hw/core/cpu.c
+++ b/hw/core/cpu.c
@@ -32,6 +32,7 @@
 #include "hw/boards.h"
 #include "hw/qdev-properties.h"
 #include "trace-root.h"
+#include "qemu/plugin.h"
 
 CPUInterruptHandler cpu_interrupt_handler;
 
@@ -352,6 +353,7 @@ static void cpu_common_unrealizefn(DeviceState *dev, Error **errp)
     CPUState *cpu = CPU(dev);
     /* NOTE: latest generic point before the cpu is fully unrealized */
     trace_fini_vcpu(cpu);
+    qemu_plugin_vcpu_exit_hook(cpu);
     cpu_exec_unrealizefn(cpu);
 }
 
-- 
2.20.1


