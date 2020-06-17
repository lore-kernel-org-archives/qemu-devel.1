Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5FCAC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:36:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEE3B2085B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jsBY4oHC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEE3B2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlfjP-0005dK-P4
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 17:36:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38044)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfEm-0004Tx-Dr
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:04:48 -0400
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:34524)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfEk-0000Np-53
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:04:48 -0400
Received: by mail-qk1-x744.google.com with SMTP id f18so3524898qkh.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 14:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2fC2p4q7EXMT22jmjpJyi2yYnEcYk9REFP3VTNIoqTk=;
 b=jsBY4oHCFsO3VZPpm5UPbNXmnE7ZOy0NoqalWszny0h/zWNqlLNEOPiLpOw3HWaljV
 ymmlyJ9kqHsZdj9V2W0+LPPm9Hno71HpFkxyHgmCOjoYS8t+SY3zKYK8k9bz00r7ZMVF
 dQt+Gd+YgR4ROEUgHBJHhmAoCPNomgrHm5yDwdO2F+LKBUw+fp4Nmc1Phw+Kuucj3z/o
 fP61PUBL91eHaQ65dXzI0fp2IGNus7maKC8eAwwSqeZ/j1PT3/XQJj1Wzq6AOlbdc5QP
 BOdeEtfV5LtFJnEt1JQ7djZYdLKYUkOFuw/2fEBVmmhqWd4wlzqN6B0fM3GLaFkj/eTZ
 hQhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2fC2p4q7EXMT22jmjpJyi2yYnEcYk9REFP3VTNIoqTk=;
 b=ThdhzRcf3hsKsyF556Wy9fWAUaHPVXcijuFVmink1MJfStpxz6N2awWSi6ERB6xRSa
 jSL5sMbX4Y82TC3REv6zTruJDnT6FOtqFpJchAsmgAYdgqP2GGo2uKJRbSiFNhxnS8YH
 SlEQWoXBN1jrJWRrr60qukp+5LT8EEYgw9Hn7IWjo2dZ3kkF9rR5FroO9i3NAr1PTAP8
 6jUeoYBN3imMvTn9Iw+gaUo2q4zjtsu71D/6IXe5KL1PFb7Gus8QFEVq8XGsgz65P1cQ
 ok9X/w67DPNPKKSp8cHtyecv6/yJh2Edm15B+p33cQuz3P3Cn2Ef3FIlBEl9Z/nwswJA
 v9hw==
X-Gm-Message-State: AOAM532lOpeTbl318b+I1Fl5eDYVmnB22i2fFI0aB6nMR5gwFg+z/5Uw
 D4goji25fheBYRoc1t0sM5pAK30aQVO8qw==
X-Google-Smtp-Source: ABdhPJxchMTSZ7tuU+6x+Tf4VT1yIsiZl+CER43NGdd4pyESY7D2ChqI/yhMgqWGdSFtGSrtj1t1qg==
X-Received: by 2002:a05:620a:1524:: with SMTP id
 n4mr541319qkk.295.1592427884939; 
 Wed, 17 Jun 2020 14:04:44 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fc79:714c:9711:2e9c])
 by smtp.gmail.com with ESMTPSA id w13sm997245qkb.91.2020.06.17.14.04.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 14:04:44 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 62/73] cpu: introduce cpu_has_work_with_iothread_lock
Date: Wed, 17 Jun 2020 17:02:20 -0400
Message-Id: <20200617210231.4393-63-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200617210231.4393-1-robert.foley@linaro.org>
References: <20200617210231.4393-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::744;
 envelope-from=robert.foley@linaro.org; helo=mail-qk1-x744.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: robert.foley@linaro.org, cota@braap.org, peter.puhov@linaro.org,
 alex.bennee@linaro.org, Eduardo Habkost <ehabkost@redhat.com>
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
index 79da78cd10..720bc85a84 100644
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
@@ -805,14 +809,41 @@ const char *parse_cpu_option(const char *cpu_option);
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


