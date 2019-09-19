Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F72C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 23:33:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5C02218AF
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 23:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vJzAZ60U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5C02218AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB5vN-0000aA-Ou
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 19:33:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39261)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iB5s8-0006IK-Dz
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 19:30:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iB5s6-0000jr-Ph
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 19:30:00 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:40490)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iB5s6-0000jB-EI
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 19:29:58 -0400
Received: by mail-pg1-x544.google.com with SMTP id w10so2729064pgj.7
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 16:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=q7PGmLFt8k2gMw2v7XrzLTew2NhAfZzpYEa2cTqkTY8=;
 b=vJzAZ60Uz+FyOHGBPbW7vw1/Rm7vhO0zQKoqyGu7Z3I+lnrrpkVi/ntQiMICrWDv2t
 wfmyDDIRnw2JpwO/w+m+++dIufEhQ72lLz/XRPcbCRh0v2OvU6SgoXOUj/+3IeLz3639
 FE2eZux4+VAQ8gIEbUyKuncJMmfrkAzWU8pzBicCTUTOsrEqgNMXdO0aNx4DaCkQhAMQ
 2kRt+bhd4Opu3k23Mb+TtkxT53kDq6WqP7a/CnkxfEotOArNf8LXGOmOrZCGHfqIQNm/
 9jHUYk4IxwQdfppme3UETl17SEoFhOIpT3yzM4c7Y+jTxBNMxjTGwCWPkYxDDfsErqJ6
 XGkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=q7PGmLFt8k2gMw2v7XrzLTew2NhAfZzpYEa2cTqkTY8=;
 b=pobzVgUTzXm0bybhnBlHKSOPm9wWzcM3KJP1l0xPPwjP+ddUvcUP2SG9TSE18nE5J7
 VRmS6XDYHq1YRia4dkkIL/PvB+DePvkETUqFCP1VA5H+i0Sc67LT5/U+gn00I54ni6uq
 wnu09jOCqKkwKR1cD7/v8ktFUuPtktbdj7iAVT3011zz8B74g8El8eIaNBZ+DtmMEZnw
 tx/o9lCABioNzgj9/b3TOmcMqouFvmFBOGPDD5wIHOnYA52uHMcaJBtNUCBB7m7StJE0
 Ze7qFVaZT7s9Stb/Ey1mxVqCHbAet56HaN24mhyWhf75gxyOm2xy25jjuQKHQpWE4nvN
 35oA==
X-Gm-Message-State: APjAAAXL9c/SKo+yE1jBRtdVRMJL9DMnbl/iV+5dW5cIW4rYRG9Xhxi5
 I3Hwk4trcBUaSYdiO6UpmGgcApxFna0=
X-Google-Smtp-Source: APXvYqyVd7txXYUKncVIQtCheCQWMGN9O0JEDn+pbcgrVTwmg30WtzLdq5IPcW6g0/CzCsaFHaWacA==
X-Received: by 2002:a63:c050:: with SMTP id z16mr10063295pgi.250.1568935796893; 
 Thu, 19 Sep 2019 16:29:56 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id h8sm103340pfo.64.2019.09.19.16.29.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2019 16:29:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/7] exec: Split out variable page size support to exec-vary.c
Date: Thu, 19 Sep 2019 16:29:47 -0700
Message-Id: <20190919232952.6382-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190919232952.6382-1-richard.henderson@linaro.org>
References: <20190919232952.6382-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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
Cc: pbonzini@redhat.com, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The next patch will play a trick with "const" that will
confuse the compiler about the uses of target_page_bits
within exec.c.  Moving everything to a new file prevents
this confusion.

No functional change so far.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 Makefile.target       |  2 +-
 include/qemu-common.h |  6 +++++
 exec-vary.c           | 57 +++++++++++++++++++++++++++++++++++++++++++
 exec.c                | 34 --------------------------
 4 files changed, 64 insertions(+), 35 deletions(-)
 create mode 100644 exec-vary.c

diff --git a/Makefile.target b/Makefile.target
index 5e916230c4..ca3d14efe1 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -107,7 +107,7 @@ obj-y += trace/
 
 #########################################################
 # cpu emulator library
-obj-y += exec.o
+obj-y += exec.o exec-vary.o
 obj-y += accel/
 obj-$(CONFIG_TCG) += tcg/tcg.o tcg/tcg-op.o tcg/tcg-op-vec.o tcg/tcg-op-gvec.o
 obj-$(CONFIG_TCG) += tcg/tcg-common.o tcg/optimize.o
diff --git a/include/qemu-common.h b/include/qemu-common.h
index 0235cd3b91..3e800c2224 100644
--- a/include/qemu-common.h
+++ b/include/qemu-common.h
@@ -74,6 +74,12 @@ void cpu_exec_step_atomic(CPUState *cpu);
  */
 bool set_preferred_target_page_bits(int bits);
 
+/**
+ * finalize_target_page_bits:
+ * Commit the final value set by set_preferred_target_page_bits.
+ */
+void finalize_target_page_bits(void);
+
 /**
  * Sends a (part of) iovec down a socket, yielding when the socket is full, or
  * Receives data into a (part of) iovec from a socket,
diff --git a/exec-vary.c b/exec-vary.c
new file mode 100644
index 0000000000..48c0ab306c
--- /dev/null
+++ b/exec-vary.c
@@ -0,0 +1,57 @@
+/*
+ * Variable page size handling
+ *
+ *  Copyright (c) 2003 Fabrice Bellard
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "exec/exec-all.h"
+
+#ifdef TARGET_PAGE_BITS_VARY
+int target_page_bits;
+bool target_page_bits_decided;
+#endif
+
+bool set_preferred_target_page_bits(int bits)
+{
+    /*
+     * The target page size is the lowest common denominator for all
+     * the CPUs in the system, so we can only make it smaller, never
+     * larger. And we can't make it smaller once we've committed to
+     * a particular size.
+     */
+#ifdef TARGET_PAGE_BITS_VARY
+    assert(bits >= TARGET_PAGE_BITS_MIN);
+    if (target_page_bits == 0 || target_page_bits > bits) {
+        if (target_page_bits_decided) {
+            return false;
+        }
+        target_page_bits = bits;
+    }
+#endif
+    return true;
+}
+
+void finalize_target_page_bits(void)
+{
+#ifdef TARGET_PAGE_BITS_VARY
+    if (target_page_bits == 0) {
+        target_page_bits = TARGET_PAGE_BITS_MIN;
+    }
+    target_page_bits_decided = true;
+#endif
+}
diff --git a/exec.c b/exec.c
index 8b998974f8..33bd0e36c1 100644
--- a/exec.c
+++ b/exec.c
@@ -92,11 +92,6 @@ MemoryRegion io_mem_rom, io_mem_notdirty;
 static MemoryRegion io_mem_unassigned;
 #endif
 
-#ifdef TARGET_PAGE_BITS_VARY
-int target_page_bits;
-bool target_page_bits_decided;
-#endif
-
 CPUTailQ cpus = QTAILQ_HEAD_INITIALIZER(cpus);
 
 /* current CPU in the current thread. It is only valid inside
@@ -110,37 +105,8 @@ int use_icount;
 uintptr_t qemu_host_page_size;
 intptr_t qemu_host_page_mask;
 
-bool set_preferred_target_page_bits(int bits)
-{
-    /* The target page size is the lowest common denominator for all
-     * the CPUs in the system, so we can only make it smaller, never
-     * larger. And we can't make it smaller once we've committed to
-     * a particular size.
-     */
-#ifdef TARGET_PAGE_BITS_VARY
-    assert(bits >= TARGET_PAGE_BITS_MIN);
-    if (target_page_bits == 0 || target_page_bits > bits) {
-        if (target_page_bits_decided) {
-            return false;
-        }
-        target_page_bits = bits;
-    }
-#endif
-    return true;
-}
-
 #if !defined(CONFIG_USER_ONLY)
 
-static void finalize_target_page_bits(void)
-{
-#ifdef TARGET_PAGE_BITS_VARY
-    if (target_page_bits == 0) {
-        target_page_bits = TARGET_PAGE_BITS_MIN;
-    }
-    target_page_bits_decided = true;
-#endif
-}
-
 typedef struct PhysPageEntry PhysPageEntry;
 
 struct PhysPageEntry {
-- 
2.17.1


