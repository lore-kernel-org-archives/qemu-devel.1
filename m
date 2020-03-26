Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C23A8C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 20:11:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B55F206E6
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 20:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XessdbHN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B55F206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHYqA-0006d2-QJ
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 16:10:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59327)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1jHYLH-0008QO-Hp
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:39:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1jHYLG-00029u-Ca
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:39:03 -0400
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:36794)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1jHYLG-00029m-8O
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:39:02 -0400
Received: by mail-qk1-x744.google.com with SMTP id d11so8195804qko.3
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 12:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+znDl+e4Ijoaeb8N9+twYWXre7kV5d4tOF3Cbrdh+d8=;
 b=XessdbHNqdlhsujH92G+AZWufPiC7tjIBNftkvgrRo7HOs/3MnrAxHpphSF7QCxp9J
 WeK4GS9m0Z1Opphaqsz9WpCnzM73wXaUv2nMA59mOqZiETEiLbPD7mhZrD2o4cf9ASj0
 ayrGBtZHCDFaseT85qs3x5+wziNDsPA+zj/T1ruCGwnApwmoH70VynsRQCmbea6uoiyD
 tvbkbfxMufeZFPs1uctOfY4CGf5EdXmlLRVzyKTwqJNNiz2DOKIJad54PeNUDgyFsgZG
 8x9AM5IBAHYuqGJyPRTlyuxRyMxotVtWvnTmo4gs3KdhxnV9Eje2qPrV5Q6dp4o4qThV
 N3GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+znDl+e4Ijoaeb8N9+twYWXre7kV5d4tOF3Cbrdh+d8=;
 b=M5ZIHyGxoaxpHWw6Cj26XmxdyALa5ouf755d+00At0k6IfckuBPJ7qQynIVm6wA3fd
 YPbSCXygiDK2MgDiNVYmcWnpA9lpOja6mm8p54OBfVsQoTR2S+g96Wmy7ONu4HI53Win
 hYf9uOv5dxUdlaafUukZNYsPvlXHkq1ab9GZqZ1aKIyCNRlXiMvgGaBibzKIHQaXyvhf
 4y0jiYeqWKeCQBD6xTjUAR7issjCnyo1PFtvUG2KkZXCAjgh5Jgmp3q1ihNyiZdSXdJY
 /nlniUfFDHW6hnBlcsok9GLA+G03f6hqatE7Fm+PBkHpvipORCEedq6JJgNb0jn29MtA
 IrSw==
X-Gm-Message-State: ANhLgQ077cj2aRlyKl9cgvMyr33tjA33r4onvdjLzOBkq4psYU2tb+Hj
 T7+yxf6YhaPfIGEqi8WON1CFtdrggYbPdA==
X-Google-Smtp-Source: ADFU+vsf89YAh1S5MGgJD+pzSOkGXhSBLGseWQtUZArwz8g3W+7JNzhcZ/qyN8BPlUbF28qpLqwkDQ==
X-Received: by 2002:a37:2d83:: with SMTP id
 t125mr10373982qkh.359.1585251541396; 
 Thu, 26 Mar 2020 12:39:01 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fd55:4e67:1038:8302])
 by smtp.gmail.com with ESMTPSA id u51sm2161916qth.46.2020.03.26.12.39.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 12:39:00 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 63/74] cpu: introduce cpu_has_work_with_iothread_lock
Date: Thu, 26 Mar 2020 15:31:45 -0400
Message-Id: <20200326193156.4322-64-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200326193156.4322-1-robert.foley@linaro.org>
References: <20200326193156.4322-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::744
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
Cc: richard.henderson@linaro.org, "Emilio G. Cota" <cota@braap.org>,
 alex.bennee@linaro.org, robert.foley@linaro.org, peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

It will gain some users soon.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 include/hw/core/cpu.h | 37 ++++++++++++++++++++++++++++++++++---
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index a01c258320..e3527b6194 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -26,6 +26,7 @@
 #include "exec/memattrs.h"
 #include "qapi/qapi-types-run-state.h"
 #include "qemu/bitmap.h"
+#include "qemu/main-loop.h"
 #include "qemu/rcu_queue.h"
 #include "qemu/queue.h"
 #include "qemu/thread.h"
@@ -82,6 +83,8 @@ struct TranslationBlock;
  * @reset_dump_flags: #CPUDumpFlags to use for reset logging.
  * @has_work: Callback for checking if there is work to do. Called with the
  * CPU lock held.
+ * @has_work_with_iothread_lock: Callback for checking if there is work to do.
+ * Called with both the BQL and the CPU lock held.
  * @do_interrupt: Callback for interrupt handling.
  * @do_unaligned_access: Callback for unaligned access handling, if
  * the target defines #TARGET_ALIGNED_ONLY.
@@ -167,6 +170,7 @@ typedef struct CPUClass {
 
     int reset_dump_flags;
     bool (*has_work)(CPUState *cpu);
+    bool (*has_work_with_iothread_lock)(CPUState *cpu);
     void (*do_interrupt)(CPUState *cpu);
     void (*do_unaligned_access)(CPUState *cpu, vaddr addr,
                                 MMUAccessType access_type,
@@ -800,14 +804,41 @@ const char *parse_cpu_option(const char *cpu_option);
 static inline bool cpu_has_work(CPUState *cpu)
 {
     CPUClass *cc = CPU_GET_CLASS(cpu);
+    bool has_cpu_lock = cpu_mutex_locked(cpu);
+    bool (*func)(CPUState *cpu);
     bool ret;
 
+    /* some targets require us to hold the BQL when checking for work */
+    if (cc->has_work_with_iothread_lock) {
+        if (qemu_mutex_iothread_locked()) {
+            func = cc->has_work_with_iothread_lock;
+            goto call_func;
+        }
+
+        if (has_cpu_lock) {
+            /* avoid deadlock by acquiring the locks in order */
+            cpu_mutex_unlock(cpu);
+        }
+        qemu_mutex_lock_iothread();
+        cpu_mutex_lock(cpu);
+
+        ret = cc->has_work_with_iothread_lock(cpu);
+
+        qemu_mutex_unlock_iothread();
+        if (!has_cpu_lock) {
+            cpu_mutex_unlock(cpu);
+        }
+        return ret;
+    }
+
     g_assert(cc->has_work);
-    if (cpu_mutex_locked(cpu)) {
-        return cc->has_work(cpu);
+    func = cc->has_work;
+ call_func:
+    if (has_cpu_lock) {
+        return func(cpu);
     }
     cpu_mutex_lock(cpu);
-    ret = cc->has_work(cpu);
+    ret = func(cpu);
     cpu_mutex_unlock(cpu);
     return ret;
 }
-- 
2.17.1


