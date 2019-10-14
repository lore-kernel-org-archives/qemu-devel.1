Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9554ECE587
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 11:47:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77CDC207FF
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 11:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZTxPVhnl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77CDC207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJyp3-0003jV-JQ
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 07:47:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46909)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iJyCF-0008C8-7A
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 07:07:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iJyCD-0007mQ-H8
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 07:07:27 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:41285)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iJyCD-0007lU-AA
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 07:07:25 -0400
Received: by mail-wr1-x441.google.com with SMTP id p4so3326796wrm.8
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 04:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jb94Z+Gp/SEto0c7c9pjyGvoGowBStIfIYtnSg1TGYw=;
 b=ZTxPVhnlh6IJ0i9/HS02KCIiEi452j/wOypJG/2pzNwQM0y55fz2G6P+8xE1OdzHRW
 5NwTdR70fOms4try8kfS76K5rlAhyJX7qvxyK7vH9kuLEwTmGtLoyyvCeZ4pWpCBJid0
 iNk8WARfSjA9N7g3EDTvdHZOKHBhicbmfrM4rvrx69f+KYaVH2YZvJFYyJirw+kbUqDN
 17k33wRfEncHSllzRMpz5jfP3poJiqICCdf3nsXxc5kQE56tPfJf47uNld/wgp0zPdXd
 MzGh3tVLq5o8GTTxdkdxrImEwkSGrjJwH49Lw8opIOFJIqmy9e/mBpZv95Khl7yz+dLh
 WhfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jb94Z+Gp/SEto0c7c9pjyGvoGowBStIfIYtnSg1TGYw=;
 b=rRoTFY7nyFF0+IUhRcrxcq8QI7MGBf5ed4o6rWKBWaF5lzik3CICpjkQeVijZ7V713
 s7bFLPiP7iUSksIPLWXw/XtYEi/q5ETtGm1OTqITijRemK2LLzc4Zv2io87Vw0N0o9Vz
 JDGeMFNWZPFjuWAebvae9Z88BbgOKrT8BsYUGoSoVcXSj7/lk/nqZrJPhtRj+QcWOk+H
 7FlPkl0hZVzOw6d9N6RlkpWGX0ce+z2sv+B3hJORSzpAV8LbhU0YOgRmDZmp26uEa+1p
 wdkZHsvfvGKHMYCW1ANNRt84Rv3kFCcrOSDBXbvZ0ZI/pRpUon0Wjs6393UMq1DKY219
 pX0g==
X-Gm-Message-State: APjAAAX3hI7HMiM6e3rPHuzh7b28kSmiRDnUFU7I0ajv1WU4RMb/atFl
 NC80UyOirlr45WRQ7M13iSAExg==
X-Google-Smtp-Source: APXvYqyJ+h0yBYUlY3GqEsLnp498zG79ulLX8zvNC6Q3Gy5yXJ3qUk0rnkwWvLs6Gl+L3Xo0lKDOrw==
X-Received: by 2002:adf:f188:: with SMTP id h8mr25028454wro.38.1571051244216; 
 Mon, 14 Oct 2019 04:07:24 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f8sm19894304wmb.37.2019.10.14.04.06.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 04:07:23 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C01971FFC9;
 Mon, 14 Oct 2019 11:49:57 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v5 39/55] tests/plugin: add sample plugins
Date: Mon, 14 Oct 2019 11:49:32 +0100
Message-Id: <20191014104948.4291-40-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014104948.4291-1-alex.bennee@linaro.org>
References: <20191014104948.4291-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: aaron@os.amperecomputing.com, cota@braap.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 robert.foley@futurewei.com, peter.puhov@futurewei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Pass arguments with -plugin=libfoo.so,arg=bar,arg=baz

Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v4
   - tweaks for hwaddr API
---
 configure             |  1 +
 tests/plugin/Makefile | 28 +++++++++++++
 tests/plugin/bb.c     | 65 +++++++++++++++++++++++++++++
 tests/plugin/empty.c  | 29 +++++++++++++
 tests/plugin/insn.c   | 62 ++++++++++++++++++++++++++++
 tests/plugin/mem.c    | 96 +++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 281 insertions(+)
 create mode 100644 tests/plugin/Makefile
 create mode 100644 tests/plugin/bb.c
 create mode 100644 tests/plugin/empty.c
 create mode 100644 tests/plugin/insn.c
 create mode 100644 tests/plugin/mem.c

diff --git a/configure b/configure
index 75632b1df1..d5527a9f15 100755
--- a/configure
+++ b/configure
@@ -7887,6 +7887,7 @@ DIRS="$DIRS roms/seabios roms/vgabios"
 LINKS="Makefile"
 LINKS="$LINKS tests/tcg/lm32/Makefile po/Makefile"
 LINKS="$LINKS tests/tcg/Makefile.target tests/fp/Makefile"
+LINKS="$LINKS tests/plugin/Makefile"
 LINKS="$LINKS pc-bios/optionrom/Makefile pc-bios/keymaps"
 LINKS="$LINKS pc-bios/s390-ccw/Makefile"
 LINKS="$LINKS roms/seabios/Makefile roms/vgabios/Makefile"
diff --git a/tests/plugin/Makefile b/tests/plugin/Makefile
new file mode 100644
index 0000000000..f9a3546ea3
--- /dev/null
+++ b/tests/plugin/Makefile
@@ -0,0 +1,28 @@
+BUILD_DIR := $(CURDIR)/../..
+
+include $(BUILD_DIR)/config-host.mak
+include $(SRC_PATH)/rules.mak
+
+$(call set-vpath, $(SRC_PATH)/tests/plugin)
+
+NAMES :=
+NAMES += bb
+NAMES += empty
+NAMES += insn
+NAMES += mem
+
+SONAMES := $(addsuffix .so,$(addprefix lib,$(NAMES)))
+
+QEMU_CFLAGS += -fPIC
+QEMU_CFLAGS += -I$(SRC_PATH)/include/qemu
+
+all: $(SONAMES)
+
+lib%.so: %.o
+	$(CC) -shared -Wl,-soname,$@ -o $@ $^ $(LDLIBS)
+
+clean:
+	rm -f *.o *.so *.d
+	rm -Rf .libs
+
+.PHONY: all clean
diff --git a/tests/plugin/bb.c b/tests/plugin/bb.c
new file mode 100644
index 0000000000..93d25de363
--- /dev/null
+++ b/tests/plugin/bb.c
@@ -0,0 +1,65 @@
+/*
+ * Copyright (C) 2018, Emilio G. Cota <cota@braap.org>
+ *
+ * License: GNU GPL, version 2 or later.
+ *   See the COPYING file in the top-level directory.
+ */
+#include <inttypes.h>
+#include <assert.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <stdio.h>
+
+#include <qemu-plugin.h>
+
+static uint64_t bb_count;
+static uint64_t insn_count;
+static int stdout_fd;
+static bool do_inline;
+
+static void plugin_exit(qemu_plugin_id_t id, void *p)
+{
+    dprintf(stdout_fd, "bb's: %" PRIu64", insns: %" PRIu64 "\n",
+            bb_count, insn_count);
+}
+
+static void vcpu_tb_exec(unsigned int cpu_index, void *udata)
+{
+    unsigned long n_insns = (unsigned long)udata;
+
+    insn_count += n_insns;
+    bb_count++;
+}
+
+static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
+{
+    unsigned long n_insns = qemu_plugin_tb_n_insns(tb);
+
+    if (do_inline) {
+        qemu_plugin_register_vcpu_tb_exec_inline(tb, QEMU_PLUGIN_INLINE_ADD_U64,
+                                                 &bb_count, 1);
+        qemu_plugin_register_vcpu_tb_exec_inline(tb, QEMU_PLUGIN_INLINE_ADD_U64,
+                                                 &insn_count, n_insns);
+    } else {
+        qemu_plugin_register_vcpu_tb_exec_cb(tb, vcpu_tb_exec,
+                                             QEMU_PLUGIN_CB_NO_REGS,
+                                             (void *)n_insns);
+    }
+}
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id, int argc,
+                                           char **argv)
+{
+    if (argc && strcmp(argv[0], "inline") == 0) {
+        do_inline = true;
+    }
+
+    /* to be used when in the exit hook */
+    stdout_fd = dup(STDOUT_FILENO);
+    assert(stdout_fd);
+
+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
+    qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
+    return 0;
+}
diff --git a/tests/plugin/empty.c b/tests/plugin/empty.c
new file mode 100644
index 0000000000..b141ddd0df
--- /dev/null
+++ b/tests/plugin/empty.c
@@ -0,0 +1,29 @@
+/*
+ * Copyright (C) 2018, Emilio G. Cota <cota@braap.org>
+ *
+ * License: GNU GPL, version 2 or later.
+ *   See the COPYING file in the top-level directory.
+ */
+#include <inttypes.h>
+#include <assert.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <stdio.h>
+
+#include <qemu-plugin.h>
+
+/*
+ * Empty TB translation callback.
+ * This allows us to measure the overhead of injecting and then
+ * removing empty instrumentation.
+ */
+static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
+{ }
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id, int argc,
+                                           char **argv)
+{
+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
+    return 0;
+}
diff --git a/tests/plugin/insn.c b/tests/plugin/insn.c
new file mode 100644
index 0000000000..3000ab4b73
--- /dev/null
+++ b/tests/plugin/insn.c
@@ -0,0 +1,62 @@
+/*
+ * Copyright (C) 2018, Emilio G. Cota <cota@braap.org>
+ *
+ * License: GNU GPL, version 2 or later.
+ *   See the COPYING file in the top-level directory.
+ */
+#include <inttypes.h>
+#include <assert.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <stdio.h>
+
+#include <qemu-plugin.h>
+
+static int stdout_fd;
+static uint64_t insn_count;
+static bool do_inline;
+
+static void vcpu_insn_exec_before(unsigned int cpu_index, void *udata)
+{
+    insn_count++;
+}
+
+static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
+{
+    size_t n = qemu_plugin_tb_n_insns(tb);
+    size_t i;
+
+    for (i = 0; i < n; i++) {
+        struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, i);
+
+        if (do_inline) {
+            qemu_plugin_register_vcpu_insn_exec_inline(
+                insn, QEMU_PLUGIN_INLINE_ADD_U64, &insn_count, 1);
+        } else {
+            qemu_plugin_register_vcpu_insn_exec_cb(
+                insn, vcpu_insn_exec_before, QEMU_PLUGIN_CB_NO_REGS, NULL);
+        }
+    }
+}
+
+static void plugin_exit(qemu_plugin_id_t id, void *p)
+{
+    dprintf(stdout_fd, "insns: %" PRIu64 "\n", insn_count);
+}
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id, int argc,
+                                           char **argv)
+{
+    if (argc && !strcmp(argv[0], "inline")) {
+        do_inline = true;
+    }
+
+    /* to be used when in the exit hook */
+    stdout_fd = dup(STDOUT_FILENO);
+    assert(stdout_fd);
+
+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
+    qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
+    return 0;
+}
diff --git a/tests/plugin/mem.c b/tests/plugin/mem.c
new file mode 100644
index 0000000000..e5490f4a99
--- /dev/null
+++ b/tests/plugin/mem.c
@@ -0,0 +1,96 @@
+/*
+ * Copyright (C) 2018, Emilio G. Cota <cota@braap.org>
+ *
+ * License: GNU GPL, version 2 or later.
+ *   See the COPYING file in the top-level directory.
+ */
+#include <inttypes.h>
+#include <assert.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <stdio.h>
+
+#include <qemu-plugin.h>
+
+static uint64_t mem_count;
+static uint64_t io_count;
+static int stdout_fd;
+static bool do_inline;
+static bool do_haddr;
+static enum qemu_plugin_mem_rw rw = QEMU_PLUGIN_MEM_RW;
+
+static void plugin_exit(qemu_plugin_id_t id, void *p)
+{
+    dprintf(stdout_fd, "mem accesses: %" PRIu64 "\n", mem_count);
+    if (do_haddr) {
+        dprintf(stdout_fd, "io accesses: %" PRIu64 "\n", mem_count);
+    }
+}
+
+static void vcpu_mem(unsigned int cpu_index, qemu_plugin_meminfo_t meminfo,
+                     uint64_t vaddr, void *udata)
+{
+    if (do_haddr) {
+        struct qemu_plugin_hwaddr *hwaddr;
+        hwaddr = qemu_plugin_get_hwaddr(meminfo, vaddr);
+        if (qemu_plugin_hwaddr_is_io(hwaddr)) {
+            io_count++;
+        } else {
+            mem_count++;
+        }
+    } else {
+        mem_count++;
+    }
+}
+
+static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
+{
+    size_t n = qemu_plugin_tb_n_insns(tb);
+    size_t i;
+
+    for (i = 0; i < n; i++) {
+        struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, i);
+
+        if (do_inline) {
+            qemu_plugin_register_vcpu_mem_inline(insn, rw,
+                                                 QEMU_PLUGIN_INLINE_ADD_U64,
+                                                 &mem_count, 1);
+        } else {
+            qemu_plugin_register_vcpu_mem_cb(insn, vcpu_mem,
+                                             QEMU_PLUGIN_CB_NO_REGS,
+                                             rw, NULL);
+        }
+    }
+}
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id, int argc,
+                                           char **argv)
+{
+    if (argc) {
+        if (argc >= 3) {
+            if (!strcmp(argv[2], "haddr")) {
+                do_haddr = true;
+            }
+        }
+        if (argc >= 2) {
+            const char *str = argv[1];
+
+            if (!strcmp(str, "r")) {
+                rw = QEMU_PLUGIN_MEM_R;
+            } else if (!strcmp(str, "w")) {
+                rw = QEMU_PLUGIN_MEM_W;
+            }
+        }
+        if (!strcmp(argv[0], "inline")) {
+            do_inline = true;
+        }
+    }
+    /* plugin_exit might write to stdout after stdout has been closed */
+    stdout_fd = dup(STDOUT_FILENO);
+    assert(stdout_fd);
+
+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
+    qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
+    return 0;
+}
-- 
2.20.1


