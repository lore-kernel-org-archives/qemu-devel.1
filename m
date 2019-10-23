Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC7ACA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 16:57:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0644B21906
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 16:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DrjcKVqM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0644B21906
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNJwq-0003sD-M5
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 12:57:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42527)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iNIp3-0004iA-18
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:45:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iNIp1-0005VQ-2y
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:45:16 -0400
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:38958)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iNIoz-0005Nw-3Y
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:45:15 -0400
Received: by mail-qt1-x843.google.com with SMTP id t8so15415592qtc.6
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 08:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PzEJPTABzvYPmN/2adJfy5uLdEuaRGm0+mdzHd64cl8=;
 b=DrjcKVqMKxbcZyq0X/pR2ND36ep6US7cUZWY57k9PsE4RyArSC6l97TFoIIN52WWRs
 t1NC/LEP+njpM75STy6IiBgWw6/E9R7iYfeVB0viiosCU1H0jgvJiDkJOIspaEGNqwXV
 h52rrVNW+Wx8t1H8qTSTCgM3/cIXA5Q0+Z/HNdk8SE8z0IPsA9sfUHZTqyB1QIQ0Jka2
 LbejPbtmfhQv6jeI6EfLcEeLFpKg9eBdnOIQ1XFDXIcFTi2zS5DhRvdrPS1bzbrRUy4l
 TW01AS054vW39CBmDTcb/DBYBJYaNf5aggxuFKf3p3MvUUmHRikYnwdmmALhJQvBw7Ev
 OrYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PzEJPTABzvYPmN/2adJfy5uLdEuaRGm0+mdzHd64cl8=;
 b=r81khUpJehhF8wsmftcmBxiHrSWO/gwpfgC6QDOiZ0hQ4afqEhWBt4BQYj7fZdJlBz
 vHa8efw5l9DcbdYX0trZBoXShqW4aTjN6jUMA+MCwq5mUeVxwF/2h9g60k5zFHAc5JBC
 ZPExmtYZiIJzPTg2saaU54NSV6fChQCUOBR+VbJvNewitQ9LaED4Z1uWC+onjz4NCgAk
 0EMurENAATZJppObpzO2Ps+YwLwUupXxeQHt7kqQWefH0a4xQK3cyDgTKAfW2I978fGC
 c+VxP7K1zUs/UcFlGTJKXJaOIpcLLe47n/Tm6hyY5uHoAkNeSJYkEAoDsxqNMR3/Pphc
 T4OQ==
X-Gm-Message-State: APjAAAXxoYMRlU6OWZvgF9j7pXpjJ6qhGrPNg0qJRQ3meSqQNciyJvfT
 cAMBn9cJKorHWuThSFoUhxUaceYLrE0=
X-Google-Smtp-Source: APXvYqyo/3SEPMr1inThK2IabmZ4wG9NUE2l4purg4v/UFYveD25eBVmxB0QQofw34Udy65ki6acpw==
X-Received: by 2002:ac8:2247:: with SMTP id p7mr10137158qtp.180.1571845510213; 
 Wed, 23 Oct 2019 08:45:10 -0700 (PDT)
Received: from localhost.localdomain (rrcs-172-254-253-50.nyc.biz.rr.com.
 [172.254.253.50])
 by smtp.gmail.com with ESMTPSA id o1sm2456272qtb.82.2019.10.23.08.45.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2019 08:45:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/7] exec: Split out variable page size support to
 exec-vary.c
Date: Wed, 23 Oct 2019 11:45:00 -0400
Message-Id: <20191023154505.30521-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191023154505.30521-1-richard.henderson@linaro.org>
References: <20191023154505.30521-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::843
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
Cc: pbonzini@redhat.com, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The next patch will play a trick with "const" that will
confuse the compiler about the uses of target_page_bits
within exec.c.  Moving everything to a new file prevents
this confusion.

No functional change so far.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
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
index 8d84db90b0..082da59e85 100644
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
index fb0943cfed..5bf181d23e 100644
--- a/exec.c
+++ b/exec.c
@@ -91,11 +91,6 @@ AddressSpace address_space_memory;
 static MemoryRegion io_mem_unassigned;
 #endif
 
-#ifdef TARGET_PAGE_BITS_VARY
-int target_page_bits;
-bool target_page_bits_decided;
-#endif
-
 CPUTailQ cpus = QTAILQ_HEAD_INITIALIZER(cpus);
 
 /* current CPU in the current thread. It is only valid inside
@@ -109,37 +104,8 @@ int use_icount;
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


