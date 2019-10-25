Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14DC5CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 14:38:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D784221D71
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 14:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YkSkFbqI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D784221D71
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO0ju-0005PY-Fr
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 10:38:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44322)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iO0Th-00052l-A1
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:22:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iO0Tf-0001ce-Li
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:22:09 -0400
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:46521)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iO0Tf-0001cT-HW
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:22:07 -0400
Received: by mail-qk1-x743.google.com with SMTP id e66so1878176qkf.13
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 07:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MG1IpXQvrz4SptVhLZ2ZL/egepQYBWYRd+NyOkeOFrk=;
 b=YkSkFbqI6G90+3ssHtTvEWGgisVbAe8EC13ltfFLwItHvlaQKqD64YJNIhBqmcBHaB
 9UXYAsM5dWPfoI5gacPDu8h6WIJHwGg5ilE6sVerdKfhRIotb0HN+uKCCV0+nNK7k/gp
 BtrVLSpgWyO+c7Zt2kv/VVaYEHIe1ddoQAynNujNYT4F4J8ZT+nhOAjzS9spVEGOlty+
 gi0Kfs3r3M4hrWQVtUtJSwtbxLdgJVQGxoTCHIBzQzFLTGDX6A6OK8laqtJ9QbcKknbX
 V/K+UlkcnmgHavKSpXW3SaFFe0bw9WHXl6oUr1pZMYpV4josDlaHK8U5w6KFcI5CFygr
 6hwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MG1IpXQvrz4SptVhLZ2ZL/egepQYBWYRd+NyOkeOFrk=;
 b=I368fGUS9u941zMKfo1xJ3h+njuJMX+lDZ0JU44D92BeyPb4V6Ba0bSeJ3b5+DM20c
 1tBGi0Q6qGIoKIjbbZxoChyYs4D6OCMIAEwh92BCOZ/OJP5qJtxLcIECDn6Yot1uZNWb
 ouDBvMWgdBK0fhPcK4MSwEZuq2SSmFbBhuvKx4vmczD0rvN7UfDBY4nmGyYRzIsCUfcT
 7tFcR1B+PatTgvFHKjDccCgEH6vOM5P4VtxVYsXHTGFwo30VEY9PkG2sDIW67i0+h4ga
 TIitEgvvRDGHE+z7EQh28XU6GNKeh/iPYt9Kdl2+jOJffo0PCoQlOMejYg2nBpkulPhb
 Tuqw==
X-Gm-Message-State: APjAAAVts1t2yTlEp2miI+G6BlqsWXxj69wTlSVJsIV6Q1SoIJl9TuhA
 nZXWnkPcidwkXnKDB8qO1fOdepToKpE=
X-Google-Smtp-Source: APXvYqxdzedt9gNzkOE9G0a1OpCA5CTIdyTDwLnuGAElmzZy/huOGqcdBbnPAlEGhUFfpc9X4AcCEQ==
X-Received: by 2002:a37:9b50:: with SMTP id d77mr3083262qke.349.1572013326468; 
 Fri, 25 Oct 2019 07:22:06 -0700 (PDT)
Received: from localhost.localdomain (rrcs-172-254-253-50.nyc.biz.rr.com.
 [172.254.253.50])
 by smtp.gmail.com with ESMTPSA id q17sm1137050qtq.58.2019.10.25.07.22.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2019 07:22:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/12] exec: Split out variable page size support to exec-vary.c
Date: Fri, 25 Oct 2019 10:21:51 -0400
Message-Id: <20191025142159.12459-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191025142159.12459-1-richard.henderson@linaro.org>
References: <20191025142159.12459-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::743
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The next patch will play a trick with "const" that will
confuse the compiler about the uses of target_page_bits
within exec.c.  Moving everything to a new file prevents
this confusion.

No functional change so far.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
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


