Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF6B3C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 10:38:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 994582073E
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 10:38:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VAzbGJKB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 994582073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqwcK-0001vV-UT
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 06:38:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43696)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqwbm-0001Qm-N0
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 06:38:22 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:40517)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqwbl-00063B-1r
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 06:38:22 -0400
Received: by mail-ed1-x543.google.com with SMTP id b15so23093970edy.7
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2020 03:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=mEdie+sgoovn6l4efVOCgpUKqagorM8gT9QHHsKXzTk=;
 b=VAzbGJKByjGH0Gjm8ufb9m837QgodA37JVrFQ15uBAIdGlAVVYEqzqaZ9pS1wXMTWa
 4e5ML6oTpt5ywKhRVJYdrFguWZRI1Yc65RHLGhIJA/6AtYpxCELAm6W5bDPA5L2IQ2AB
 FT/w5Cr39MGkHSK6KKihS/C1A/JMfv7LvhttFcn6KPxnFoyAcO86cktmReicHmtHqRXr
 CFkzJcNX8CHvrzAV0QB95q3/KkTDYUbJ/1OuEli+HOFYldsj9fxSn1ts+e+6CkFg6PSg
 PZDprnXin+wrYDzz5bWPzDx2jMiqGNzVS9FdD+cvA7u595fWo8AAXcAFgo9EYI9/XsWV
 DHdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=mEdie+sgoovn6l4efVOCgpUKqagorM8gT9QHHsKXzTk=;
 b=DqelCEpbsrVmeVRimzey+kS7/Aizrj7l/JNi8ArHqu4l/LB3HmreOT5aFX5o7KFOMR
 6pMLEurXVKrjC4ef0EW9BHyQ6ufw3yQGc7MxqL+imKZ07+ghsiOq13ZLQz9Q48Wx5xrt
 d/nRM8aO2y2V6XvFzKkg9Ha9Kn0pMAzZp6q3EGJ5EA0CKgVK8tVYhKAA1jJRvv4FDKkA
 QZO7dUkl5Z7IMRqCaUhzU3UbkjuYsk0KODs3lYWs5xj24iHxBjI6wTYpoOrkgp4ouzTT
 q57m4xrTCK9p1RUP0CBPwcRdm7QY+2cNoUoIw1cldixzn1ayHJFo7y5+lBVRzqA4LY8p
 6cvA==
X-Gm-Message-State: AOAM531PUC4r+bCs7miNGIO+98NXRHN7wM163xNmvVwHk6g7vKkQZ0yB
 /nrlIiP+aalTIFUe4AMAxgSxxf1O2+o=
X-Google-Smtp-Source: ABdhPJyyX6DbAB+bOG5d0NMTW668wbTs7VgnvXU3c6vFe+d0zqCg2kqculbs94Hg7K3IOHepwUq3iA==
X-Received: by 2002:a50:9f8c:: with SMTP id c12mr30760386edf.149.1593686298513; 
 Thu, 02 Jul 2020 03:38:18 -0700 (PDT)
Received: from x1w.redhat.com (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id d23sm6495413eja.27.2020.07.02.03.38.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2020 03:38:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] cpus: Move CPU code from exec.c to cpus-common.c
Date: Thu,  2 Jul 2020 12:38:16 +0200
Message-Id: <20200702103816.13798-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::543;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

This code was introduced with SMP support in commit 6a00d60127,
later commit 267f685b8b moved CPU list management to common code
but forgot this code. Move now and simplify ifdef'ry.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 cpus-common.c | 18 ++++++++++++++++++
 exec.c        | 22 ----------------------
 2 files changed, 18 insertions(+), 22 deletions(-)

diff --git a/cpus-common.c b/cpus-common.c
index 8f5512b3d7..34044f4e4c 100644
--- a/cpus-common.c
+++ b/cpus-common.c
@@ -72,6 +72,8 @@ static int cpu_get_free_index(void)
     return max_cpu_index;
 }
 
+CPUTailQ cpus = QTAILQ_HEAD_INITIALIZER(cpus);
+
 void cpu_list_add(CPUState *cpu)
 {
     QEMU_LOCK_GUARD(&qemu_cpu_list_lock);
@@ -96,6 +98,22 @@ void cpu_list_remove(CPUState *cpu)
     cpu->cpu_index = UNASSIGNED_CPU_INDEX;
 }
 
+CPUState *qemu_get_cpu(int index)
+{
+    CPUState *cpu;
+
+    CPU_FOREACH(cpu) {
+        if (cpu->cpu_index == index) {
+            return cpu;
+        }
+    }
+
+    return NULL;
+}
+
+/* current CPU in the current thread. It is only valid inside cpu_exec() */
+__thread CPUState *current_cpu;
+
 struct qemu_work_item {
     QSIMPLEQ_ENTRY(qemu_work_item) node;
     run_on_cpu_func func;
diff --git a/exec.c b/exec.c
index 21926dc9c7..997b7db15f 100644
--- a/exec.c
+++ b/exec.c
@@ -98,12 +98,6 @@ AddressSpace address_space_memory;
 static MemoryRegion io_mem_unassigned;
 #endif
 
-CPUTailQ cpus = QTAILQ_HEAD_INITIALIZER(cpus);
-
-/* current CPU in the current thread. It is only valid inside
-   cpu_exec() */
-__thread CPUState *current_cpu;
-
 uintptr_t qemu_host_page_size;
 intptr_t qemu_host_page_mask;
 
@@ -832,22 +826,6 @@ const VMStateDescription vmstate_cpu_common = {
     }
 };
 
-#endif
-
-CPUState *qemu_get_cpu(int index)
-{
-    CPUState *cpu;
-
-    CPU_FOREACH(cpu) {
-        if (cpu->cpu_index == index) {
-            return cpu;
-        }
-    }
-
-    return NULL;
-}
-
-#if !defined(CONFIG_USER_ONLY)
 void cpu_address_space_init(CPUState *cpu, int asidx,
                             const char *prefix, MemoryRegion *mr)
 {
-- 
2.21.3


