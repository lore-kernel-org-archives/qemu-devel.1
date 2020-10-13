Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81AB6C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 14:07:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E40CA247A3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 14:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BfqoSDg2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E40CA247A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSKxd-0000fU-Ts
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 10:07:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54510)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jandryuk@gmail.com>)
 id 1kSKw8-0007hn-SF
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 10:05:56 -0400
Received: from mail-qv1-xf41.google.com ([2607:f8b0:4864:20::f41]:44923)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jandryuk@gmail.com>)
 id 1kSKw6-0006L0-Vu
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 10:05:56 -0400
Received: by mail-qv1-xf41.google.com with SMTP id s17so19764qvr.11
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 07:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6+g8uPOejQwBA3L5BeMjyy5nmgRlbyJPcNeaeTMUqfo=;
 b=BfqoSDg2lAx8yDZ2FN5kLj4me9VCGqs5t/tR3Ptz4H2JR5zC2XufHPEpmwFNXk/Y12
 c5OwQMAJbQ8ZpfdnrboeDRZN3J9n3pZhQsXR/dMZWRwVdvONLK5Daja5DtYkW7eD8kNn
 PR8xH+qtCRoUb/GQNy+qkc7t1U9kftRwiByYbcNCT81E0CjLer9oCj6cDEg7QJJLFxnA
 ul2EXccejyh684ib45Er0rsF26tRCGr4LHdIyjtPLZMm16PUcucHwLD3vZRfjaFebP0P
 0pHIAtO+86I721+B7MzEW89NRmD5GEAgokSnvBPxPuqwZplIcaToCVwre/h31i/iX7vW
 gFmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6+g8uPOejQwBA3L5BeMjyy5nmgRlbyJPcNeaeTMUqfo=;
 b=UeT3hDpmQRYJ6ABXePnITqpYDr+hFJ9Bik0mDdoP1AeG9uxc07k+0yg+IbOXO9RStD
 SCsM2YIfcBqtZhdELF1T3N4vBgytPoUTGWLPQHYf1Lvz5AcV+DXwzKS8p+p74H3YfR5/
 AewiXKM9idVi5wCdus6IJHXJuJzmwyHQhg0/vy/VSEyBvR36Y6JpMGSWZamE/eNjlyaL
 G//ZKXp9Z/SyaV5R74nf2V3Y7eAEwfEp3cFyesInunZfxXlGRx7JprJUMpJuCiM97oMr
 bbas96ateLHhahIUqXwDpnXb0K4Gr3jhc1bOweT+hHMBJiq2ZbZuANKpZvNOjWRDE0Vx
 37Dg==
X-Gm-Message-State: AOAM532nDgXDWyuEdxl7+66xBH58fScGO1pGfsGsed69XoYhLM5MtksH
 00A7fUqIJIweer8MELW26p9tVduprrQ=
X-Google-Smtp-Source: ABdhPJzN6wVrQ9U+RAuKI3YeHUAXbPyBvvRNyANqqUZQrv+6NASfi7VEs3T2R5pMIJDYrocA8Qzwvg==
X-Received: by 2002:a05:6214:122a:: with SMTP id
 p10mr146394qvv.0.1602597950173; 
 Tue, 13 Oct 2020 07:05:50 -0700 (PDT)
Received: from shine.lan ([2001:470:8:67e:2df1:3321:942a:fbce])
 by smtp.gmail.com with ESMTPSA id z26sm13793609qki.40.2020.10.13.07.05.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2020 07:05:49 -0700 (PDT)
From: Jason Andryuk <jandryuk@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/3] accel: move qtest CpusAccel functions to a common
 location
Date: Tue, 13 Oct 2020 10:05:10 -0400
Message-Id: <20201013140511.5681-3-jandryuk@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201013140511.5681-1-jandryuk@gmail.com>
References: <20201013140511.5681-1-jandryuk@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f41;
 envelope-from=jandryuk@gmail.com; helo=mail-qv1-xf41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Jason Andryuk <jandryuk@gmail.com>, Claudio Fontana <cfontana@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move and rename accel/qtest/qtest-cpus.c files to accel/dummy-cpus.c so
it can be re-used by Xen.

Signed-off-by: Jason Andryuk <jandryuk@gmail.com>

---
v2:
 - Use accel/dummy-cpus.c
 - Put prototype in include/sysemu/cpus.h
---
 accel/{qtest/qtest-cpus.c => dummy-cpus.c} | 22 ++++------------------
 accel/meson.build                          |  7 +++++++
 accel/qtest/meson.build                    |  1 -
 accel/qtest/qtest-cpus.h                   | 17 -----------------
 accel/qtest/qtest.c                        |  5 ++++-
 include/sysemu/cpus.h                      |  3 +++
 6 files changed, 18 insertions(+), 37 deletions(-)
 rename accel/{qtest/qtest-cpus.c => dummy-cpus.c} (75%)
 delete mode 100644 accel/qtest/qtest-cpus.h

diff --git a/accel/qtest/qtest-cpus.c b/accel/dummy-cpus.c
similarity index 75%
rename from accel/qtest/qtest-cpus.c
rename to accel/dummy-cpus.c
index db094201c1..10429fdfb2 100644
--- a/accel/qtest/qtest-cpus.c
+++ b/accel/dummy-cpus.c
@@ -1,5 +1,5 @@
 /*
- * QTest accelerator code
+ * Dummy cpu thread code
  *
  * Copyright IBM, Corp. 2011
  *
@@ -13,21 +13,12 @@
 
 #include "qemu/osdep.h"
 #include "qemu/rcu.h"
-#include "qapi/error.h"
-#include "qemu/module.h"
-#include "qemu/option.h"
-#include "qemu/config-file.h"
-#include "sysemu/accel.h"
-#include "sysemu/qtest.h"
 #include "sysemu/cpus.h"
-#include "sysemu/cpu-timers.h"
 #include "qemu/guest-random.h"
 #include "qemu/main-loop.h"
 #include "hw/core/cpu.h"
 
-#include "qtest-cpus.h"
-
-static void *qtest_cpu_thread_fn(void *arg)
+static void *dummy_cpu_thread_fn(void *arg)
 {
     CPUState *cpu = arg;
     sigset_t waitset;
@@ -67,7 +58,7 @@ static void *qtest_cpu_thread_fn(void *arg)
     return NULL;
 }
 
-static void qtest_start_vcpu_thread(CPUState *cpu)
+void dummy_start_vcpu_thread(CPUState *cpu)
 {
     char thread_name[VCPU_THREAD_NAME_SIZE];
 
@@ -76,11 +67,6 @@ static void qtest_start_vcpu_thread(CPUState *cpu)
     qemu_cond_init(cpu->halt_cond);
     snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/DUMMY",
              cpu->cpu_index);
-    qemu_thread_create(cpu->thread, thread_name, qtest_cpu_thread_fn, cpu,
+    qemu_thread_create(cpu->thread, thread_name, dummy_cpu_thread_fn, cpu,
                        QEMU_THREAD_JOINABLE);
 }
-
-const CpusAccel qtest_cpus = {
-    .create_vcpu_thread = qtest_start_vcpu_thread,
-    .get_virtual_clock = qtest_get_virtual_clock,
-};
diff --git a/accel/meson.build b/accel/meson.build
index bb00d0fd13..9a417396bd 100644
--- a/accel/meson.build
+++ b/accel/meson.build
@@ -5,3 +5,10 @@ subdir('kvm')
 subdir('tcg')
 subdir('xen')
 subdir('stubs')
+
+dummy_ss = ss.source_set()
+dummy_ss.add(files(
+  'dummy-cpus.c',
+))
+
+specific_ss.add_all(when: ['CONFIG_SOFTMMU', 'CONFIG_POSIX'], if_true: dummy_ss)
diff --git a/accel/qtest/meson.build b/accel/qtest/meson.build
index e477cb2ae2..a2f3276459 100644
--- a/accel/qtest/meson.build
+++ b/accel/qtest/meson.build
@@ -1,7 +1,6 @@
 qtest_ss = ss.source_set()
 qtest_ss.add(files(
   'qtest.c',
-  'qtest-cpus.c',
 ))
 
 specific_ss.add_all(when: ['CONFIG_SOFTMMU', 'CONFIG_POSIX'], if_true: qtest_ss)
diff --git a/accel/qtest/qtest-cpus.h b/accel/qtest/qtest-cpus.h
deleted file mode 100644
index 739519a472..0000000000
--- a/accel/qtest/qtest-cpus.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/*
- * Accelerator CPUS Interface
- *
- * Copyright 2020 SUSE LLC
- *
- * This work is licensed under the terms of the GNU GPL, version 2 or later.
- * See the COPYING file in the top-level directory.
- */
-
-#ifndef QTEST_CPUS_H
-#define QTEST_CPUS_H
-
-#include "sysemu/cpus.h"
-
-extern const CpusAccel qtest_cpus;
-
-#endif /* QTEST_CPUS_H */
diff --git a/accel/qtest/qtest.c b/accel/qtest/qtest.c
index 537e8b449c..b282cea5cf 100644
--- a/accel/qtest/qtest.c
+++ b/accel/qtest/qtest.c
@@ -25,7 +25,10 @@
 #include "qemu/main-loop.h"
 #include "hw/core/cpu.h"
 
-#include "qtest-cpus.h"
+const CpusAccel qtest_cpus = {
+    .create_vcpu_thread = dummy_start_vcpu_thread,
+    .get_virtual_clock = qtest_get_virtual_clock,
+};
 
 static int qtest_init_accel(MachineState *ms)
 {
diff --git a/include/sysemu/cpus.h b/include/sysemu/cpus.h
index 231685955d..e8156728c6 100644
--- a/include/sysemu/cpus.h
+++ b/include/sysemu/cpus.h
@@ -25,6 +25,9 @@ typedef struct CpusAccel {
 /* register accel-specific cpus interface implementation */
 void cpus_register_accel(const CpusAccel *i);
 
+/* Create a dummy vcpu for CpusAccel->create_vcpu_thread */
+void dummy_start_vcpu_thread(CPUState *);
+
 /* interface available for cpus accelerator threads */
 
 /* For temporary buffers for forming a name */
-- 
2.25.1


