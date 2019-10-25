Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F7FCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:11:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FFE621929
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:11:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QYJFGeGq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FFE621929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNtki-0001AX-Pn
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 03:11:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37068)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtN7-00088Q-Vv
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:46:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtN6-0003HW-Sn
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:46:53 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:44173)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iNtN4-0003Bu-Oe
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:46:52 -0400
Received: by mail-wr1-x435.google.com with SMTP id z11so914806wro.11
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 23:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EkCfQWBEx+5L5dxa6UBDFdtT+LYaodC4KvARVIxtPwY=;
 b=QYJFGeGq0sSo9sbz/GAMzd1EHA0zEkKRQJYiSnce21KSMl5ACw9b3zfx0+xncshEcW
 kWr5FMUW0V+b/TeQd27lqsEc3NyD+NXC3+RiJebvHcZe0j8jNux6tSCF2LYOS9klsbZQ
 oQKH9iyBFfO0P83MZhIFUyBsa6Ku/8+QgbyGd847gBlgeEmzhEBLIWSKC9gzkHIffmKj
 jEG18/r2tU1g7TevfBOUVBHj+C5kdLKaqhPmN2Brxbo35F5mdDZuZhEUWu2RN0JIt8iR
 QLqZV9NUM9oAkLkQmIpqG/kwhvw9j5Oi6VF+dKezf0Xm47h+EMmNDGreNUnuFvsH+IUA
 4UFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EkCfQWBEx+5L5dxa6UBDFdtT+LYaodC4KvARVIxtPwY=;
 b=QY30FWx8kNmlT5AQCNQvL7+nMKmN9V2aHQRfaHtMbTcHdRiajvi5sS+qlMKd8a6Xoc
 2gLhC/ems2PLh9wQ2HyBhTcnC+9UKMSkttHQEMK9aLBiq6GiJ4C/WqLItj9qGcvBj2FO
 8dAW1CBohkmNsVyu799gd2/SpzgADnKAiHuV7x/un0whZXEE0iibzUEcSrIWlxfk111h
 lZxLa1G3f6qQvb2PO9W9X1b3U1lUXdIhWmLcBX2N6X0HCVAG+UJb+p2eAh2DpZRstmLO
 OLzoso2/Gblu92MD4xvvEFyPgbBWpPosXFCRfu1b4W/syrMSiuHvDzVkqECK3E7kWUzG
 tqyA==
X-Gm-Message-State: APjAAAUrR3S715/qTnHBpNW5L7SlXsVlgiHlD/0lJ0r7eBi7UFHGMveB
 0i5moegXuqCRyOT9+aMevlpDjHcV00M=
X-Google-Smtp-Source: APXvYqxtKwINmBVpc9UNOY+vSn9Y/v5+5xEKUKRRjvj46SkWJ7qDtngeJi3rKuLMtgfprqvegswkjQ==
X-Received: by 2002:a05:6000:34f:: with SMTP id
 e15mr1436825wre.232.1571986002905; 
 Thu, 24 Oct 2019 23:46:42 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id j19sm1777794wre.0.2019.10.24.23.46.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 23:46:37 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3660B1FFBD;
 Fri, 25 Oct 2019 07:37:17 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 36/73] cpu: hook plugin vcpu events
Date: Fri, 25 Oct 2019 07:36:36 +0100
Message-Id: <20191025063713.23374-37-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025063713.23374-1-alex.bennee@linaro.org>
References: <20191025063713.23374-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::435
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 "Emilio G. Cota" <cota@braap.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Signed-off-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/cpus.c b/cpus.c
index fabbeca6f46..63bda152f57 100644
--- a/cpus.c
+++ b/cpus.c
@@ -45,6 +45,7 @@
 #include "exec/exec-all.h"
 
 #include "qemu/thread.h"
+#include "qemu/plugin.h"
 #include "sysemu/cpus.h"
 #include "sysemu/qtest.h"
 #include "qemu/main-loop.h"
@@ -1264,9 +1265,18 @@ static void qemu_tcg_rr_wait_io_event(void)
 
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
index fb0943cfed6..1feda0ca761 100644
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
index 73b1ee34d04..db1a03c6bbb 100644
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


