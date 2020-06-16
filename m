Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBAF9C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 12:58:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9662E20B1F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 12:58:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HnNkBPLU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9662E20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlBAZ-0004KC-0l
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 08:58:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33992)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jlB65-00046l-C9
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 08:53:49 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:55097)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jlB62-00008W-7r
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 08:53:49 -0400
Received: by mail-wm1-x32f.google.com with SMTP id g10so2765801wmh.4
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 05:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=w7mdCAATXvMppzeAHxgpJb4BtPwpqC6YkEJgrydey+Y=;
 b=HnNkBPLUltrTuIjTLBuAxqFLVnTQmlP26RijbHFh5dUoy12q9/uqo76c01HdDIBJKv
 mj/nPR3P/k2Lx5tTFWx58xBaduionDw93D9SrTfWsJ7MyUH0o5wm++JGKebkNB2/hBHG
 L5OhAQM8kD8JDpaqiyUK0U9TiPclofag39TFW1i+Os7UJgr3tUun1T2WWzNrQaguOVBf
 +bzBMI3LkWaghxbPxN3aHj6aLq6WVYluxgkjeBkXG5Zl2cF6HufqWya4T9dT96CXeyKR
 yUy6uqJU8QZlPpa0On//l5J7kmCgIRrRHv7m3IEcZI2UaDXwbxw9iA42iqoMiVkCDUHp
 +1Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=w7mdCAATXvMppzeAHxgpJb4BtPwpqC6YkEJgrydey+Y=;
 b=FTdSOVjO3TQjKddkWEWL0C1ajVQkA0+GBnDS/0uF0Pt8reAy3JL0CJGmIWEi/xhskc
 v1faFKB0s8YJbla48EXT4z1Wgp3qJd3F2Q5+DuMWrVeEMk4Jfwx6Co/FHfhmLGtVp4Js
 WsnnzW1QmWC3Ma2biqCSni7XehUNvQ8Kxlcz9NJEWhyLdc2dm6Hu4ok9vxT51IBR//Q3
 0gVgh37+KQo8V9O/9Homtma0nG7A34TykFgaVtKuhYrBxfPEY6e0ZWcfjg1yHK+uiIAj
 DtDtry6w34ZtOR3TgL2cGa+amu0BnXcJOS/OcgcNJX6GcrN7Gg6JObDwlqGJyh28FWNT
 s8tg==
X-Gm-Message-State: AOAM533+GjOmBCZU4LVq6f3n5vszDp9pISTU7I5/2OU6ibJdBWGLJllW
 xHstOKlGzdF8lP/M74hoh1vPXQ==
X-Google-Smtp-Source: ABdhPJztSJrjCL+YOp+kHnTzIrmNWsTBVsIuFMPYKjN3RMXvs5r/hwfZ8IVMp5JzJXdqDIb8pjj/rQ==
X-Received: by 2002:a1c:24c6:: with SMTP id k189mr3265346wmk.9.1592312024433; 
 Tue, 16 Jun 2020 05:53:44 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v19sm3853998wml.26.2020.06.16.05.53.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 05:53:37 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4A9D21FFAA;
 Tue, 16 Jun 2020 13:53:26 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 21/21] plugins: new lockstep plugin for debugging TCG changes
Date: Tue, 16 Jun 2020 13:53:24 +0100
Message-Id: <20200616125324.19045-22-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200616125324.19045-1-alex.bennee@linaro.org>
References: <20200616125324.19045-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Robert Foley <robert.foley@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When we make changes to the TCG we sometimes cause regressions that
are deep into the execution cycle of the guest. Debugging this often
requires comparing large volumes of trace information to figure out
where behaviour has diverged.

The lockstep plugin utilises a shared socket so two QEMU's running
with the plugin will write their current execution position and wait
to receive the position of their partner process. When execution
diverges the plugins output where they were and the previous few
blocks before unloading themselves and letting execution continue.

Originally I planned for this to be most useful with -icount but it
turns out you can get divergence pretty quickly due to asynchronous
qemu_cpu_kick_rr_cpus() events causing one side to eventually run into
a short block a few cycles before the other side. For this reason I've
added a bit of tracking and I think the divergence reporting could be
finessed to report only if we really start to diverge in execution.

An example run would be:

  qemu-system-sparc -monitor none -parallel none -net none \
    -M SS-20 -m 256 -kernel day11/zImage.elf \
    -plugin ./tests/plugin/liblockstep.so,arg=lockstep-sparc.sock \
    -d plugin,nochain

with an identical command in another window in the same working
directory.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Robert Foley <robert.foley@linaro.org>
Tested-by: Robert Foley <robert.foley@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-Id: <20200610155509.12850-3-alex.bennee@linaro.org>

diff --git a/tests/plugin/lockstep.c b/tests/plugin/lockstep.c
new file mode 100644
index 00000000000..a696673dff3
--- /dev/null
+++ b/tests/plugin/lockstep.c
@@ -0,0 +1,340 @@
+/*
+ * Lockstep Execution Plugin
+ *
+ * Allows you to execute two QEMU instances in lockstep and report
+ * when their execution diverges. This is mainly useful for developers
+ * who want to see where a change to TCG code generation has
+ * introduced a subtle and hard to find bug.
+ *
+ * Caveats:
+ *   - single-threaded linux-user apps only with non-deterministic syscalls
+ *   - no MTTCG enabled system emulation (icount may help)
+ *
+ * While icount makes things more deterministic it doesn't mean a
+ * particular run may execute the exact same sequence of blocks. An
+ * asynchronous event (for example X11 graphics update) may cause a
+ * block to end early and a new partial block to start. This means
+ * serial only test cases are a better bet. -d nochain may also help.
+ *
+ * This code is not thread safe!
+ *
+ * Copyright (c) 2020 Linaro Ltd
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <glib.h>
+#include <inttypes.h>
+#include <unistd.h>
+#include <sys/socket.h>
+#include <sys/un.h>
+#include <stdio.h>
+#include <errno.h>
+
+#include <qemu-plugin.h>
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
+
+/* saved so we can uninstall later */
+static qemu_plugin_id_t our_id;
+
+static unsigned long bb_count;
+static unsigned long insn_count;
+
+/* Information about a translated block */
+typedef struct {
+    uint64_t pc;
+    uint64_t insns;
+} BlockInfo;
+
+/* Information about an execution state in the log */
+typedef struct {
+    BlockInfo *block;
+    unsigned long insn_count;
+    unsigned long block_count;
+} ExecInfo;
+
+/* The execution state we compare */
+typedef struct {
+    uint64_t pc;
+    unsigned long insn_count;
+} ExecState;
+
+typedef struct {
+    GSList *log_pos;
+    int distance;
+} DivergeState;
+
+/* list of translated block info */
+static GSList *blocks;
+
+/* execution log and points of divergence */
+static GSList *log, *divergence_log;
+
+static int socket_fd;
+static char *path_to_unlink;
+
+static bool verbose;
+
+static void plugin_cleanup(qemu_plugin_id_t id)
+{
+    /* Free our block data */
+    g_slist_free_full(blocks, &g_free);
+    g_slist_free_full(log, &g_free);
+    g_slist_free(divergence_log);
+
+    close(socket_fd);
+    if (path_to_unlink) {
+        unlink(path_to_unlink);
+    }
+}
+
+static void plugin_exit(qemu_plugin_id_t id, void *p)
+{
+    g_autoptr(GString) out = g_string_new("No divergence :-)\n");
+    g_string_append_printf(out, "Executed %ld/%d blocks\n",
+                           bb_count, g_slist_length(log));
+    g_string_append_printf(out, "Executed ~%ld instructions\n", insn_count);
+    qemu_plugin_outs(out->str);
+
+    plugin_cleanup(id);
+}
+
+static void report_divergance(ExecState *us, ExecState *them)
+{
+    DivergeState divrec = { log, 0 };
+    g_autoptr(GString) out = g_string_new("");
+    bool diverged = false;
+
+    /*
+     * If we have diverged before did we get back on track or are we
+     * totally loosing it?
+     */
+    if (divergence_log) {
+        DivergeState *last = (DivergeState *) divergence_log->data;
+        GSList *entry;
+
+        for (entry = log; g_slist_next(entry); entry = g_slist_next(entry)) {
+            if (entry == last->log_pos) {
+                break;
+            }
+            divrec.distance++;
+        }
+
+        /*
+         * If the last two records are so close it is likely we will
+         * not recover synchronisation with the other end.
+         */
+        if (divrec.distance == 1 && last->distance == 1) {
+            diverged = true;
+        }
+    }
+    divergence_log = g_slist_prepend(divergence_log,
+                                     g_memdup(&divrec, sizeof(divrec)));
+
+    /* Output short log entry of going out of sync... */
+    if (verbose || divrec.distance == 1 || diverged) {
+        g_string_printf(out, "@ %#016lx vs %#016lx (%d/%d since last)\n",
+                        us->pc, them->pc, g_slist_length(divergence_log),
+                        divrec.distance);
+        qemu_plugin_outs(out->str);
+    }
+
+    if (diverged) {
+        int i;
+        GSList *entry;
+
+        g_string_printf(out, "Δ insn_count @ %#016lx (%ld) vs %#016lx (%ld)\n",
+                        us->pc, us->insn_count, them->pc, them->insn_count);
+
+        for (entry = log, i = 0;
+             g_slist_next(entry) && i < 5;
+             entry = g_slist_next(entry), i++) {
+            ExecInfo *prev = (ExecInfo *) entry->data;
+            g_string_append_printf(out,
+                                   "  previously @ %#016lx/%ld (%ld insns)\n",
+                                   prev->block->pc, prev->block->insns,
+                                   prev->insn_count);
+        }
+        qemu_plugin_outs(out->str);
+        qemu_plugin_outs("too much divergence... giving up.");
+        qemu_plugin_uninstall(our_id, plugin_cleanup);
+    }
+}
+
+static void vcpu_tb_exec(unsigned int cpu_index, void *udata)
+{
+    BlockInfo *bi = (BlockInfo *) udata;
+    ExecState us, them;
+    ssize_t bytes;
+    ExecInfo *exec;
+
+    us.pc = bi->pc;
+    us.insn_count = insn_count;
+
+    /*
+     * Write our current position to the other end. If we fail the
+     * other end has probably died and we should shut down gracefully.
+     */
+    bytes = write(socket_fd, &us, sizeof(ExecState));
+    if (bytes < sizeof(ExecState)) {
+        qemu_plugin_outs(bytes < 0 ?
+                         "problem writing to socket" :
+                         "wrote less than expected to socket");
+        qemu_plugin_uninstall(our_id, plugin_cleanup);
+        return;
+    }
+
+    /*
+     * Now read where our peer has reached. Again a failure probably
+     * indicates the other end died and we should close down cleanly.
+     */
+    bytes = read(socket_fd, &them, sizeof(ExecState));
+    if (bytes < sizeof(ExecState)) {
+        qemu_plugin_outs(bytes < 0 ?
+                         "problem reading from socket" :
+                         "read less than expected");
+        qemu_plugin_uninstall(our_id, plugin_cleanup);
+        return;
+    }
+
+    /*
+     * Compare and report if we have diverged.
+     */
+    if (us.pc != them.pc) {
+        report_divergance(&us, &them);
+    }
+
+    /*
+     * Assume this block will execute fully and record it
+     * in the execution log.
+     */
+    insn_count += bi->insns;
+    bb_count++;
+    exec = g_new0(ExecInfo, 1);
+    exec->block = bi;
+    exec->insn_count = insn_count;
+    exec->block_count = bb_count;
+    log = g_slist_prepend(log, exec);
+}
+
+static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
+{
+    BlockInfo *bi = g_new0(BlockInfo, 1);
+    bi->pc = qemu_plugin_tb_vaddr(tb);
+    bi->insns = qemu_plugin_tb_n_insns(tb);
+
+    /* save a reference so we can free later */
+    blocks = g_slist_prepend(blocks, bi);
+    qemu_plugin_register_vcpu_tb_exec_cb(tb, vcpu_tb_exec,
+                                         QEMU_PLUGIN_CB_NO_REGS, (void *)bi);
+}
+
+
+/*
+ * Instead of encoding master/slave status into what is essentially
+ * two peers we shall just take the simple approach of checking for
+ * the existence of the pipe and assuming if it's not there we are the
+ * first process.
+ */
+static bool setup_socket(const char *path)
+{
+    struct sockaddr_un sockaddr;
+    int fd;
+
+    fd = socket(AF_UNIX, SOCK_STREAM, 0);
+    if (fd < 0) {
+        perror("create socket");
+        return false;
+    }
+
+    sockaddr.sun_family = AF_UNIX;
+    g_strlcpy(sockaddr.sun_path, path, sizeof(sockaddr.sun_path) - 1);
+    if (bind(fd, (struct sockaddr *)&sockaddr, sizeof(sockaddr)) < 0) {
+        perror("bind socket");
+        close(fd);
+        return false;
+    }
+
+    /* remember to clean-up */
+    path_to_unlink = g_strdup(path);
+
+    if (listen(fd, 1) < 0) {
+        perror("listen socket");
+        close(fd);
+        return false;
+    }
+
+    socket_fd = accept(fd, NULL, NULL);
+    if (socket_fd < 0 && errno != EINTR) {
+        perror("accept socket");
+        return false;
+    }
+
+    qemu_plugin_outs("setup_socket::ready\n");
+
+    return true;
+}
+
+static bool connect_socket(const char *path)
+{
+    int fd;
+    struct sockaddr_un sockaddr;
+
+    fd = socket(AF_UNIX, SOCK_STREAM, 0);
+    if (fd < 0) {
+        perror("create socket");
+        return false;
+    }
+
+    sockaddr.sun_family = AF_UNIX;
+    g_strlcpy(sockaddr.sun_path, path, sizeof(sockaddr.sun_path) - 1);
+
+    if (connect(fd, (struct sockaddr *)&sockaddr, sizeof(sockaddr)) < 0) {
+        perror("failed to connect");
+        return false;
+    }
+
+    qemu_plugin_outs("connect_socket::ready\n");
+
+    socket_fd = fd;
+    return true;
+}
+
+static bool setup_unix_socket(const char *path)
+{
+    if (g_file_test(path, G_FILE_TEST_EXISTS)) {
+        return connect_socket(path);
+    } else {
+        return setup_socket(path);
+    }
+}
+
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
+                                           const qemu_info_t *info,
+                                           int argc, char **argv)
+{
+    int i;
+
+    if (!argc || !argv[0]) {
+        qemu_plugin_outs("Need a socket path to talk to other instance.");
+        return -1;
+    }
+
+    for (i = 0; i < argc; i++) {
+        char *p = argv[i];
+        if (strcmp(p, "verbose") == 0) {
+            verbose = true;
+        } else if (!setup_unix_socket(argv[0])) {
+            qemu_plugin_outs("Failed to setup socket for communications.");
+            return -1;
+        }
+    }
+
+    our_id = id;
+
+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
+    qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
+    return 0;
+}
diff --git a/tests/plugin/Makefile b/tests/plugin/Makefile
index 75467b6db85..b3250e2504c 100644
--- a/tests/plugin/Makefile
+++ b/tests/plugin/Makefile
@@ -13,6 +13,7 @@ NAMES += mem
 NAMES += hotblocks
 NAMES += howvec
 NAMES += hotpages
+NAMES += lockstep
 
 SONAMES := $(addsuffix .so,$(addprefix lib,$(NAMES)))
 
diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
index 2ae86776cdc..4b2b696fcee 100644
--- a/tests/tcg/Makefile.target
+++ b/tests/tcg/Makefile.target
@@ -129,7 +129,8 @@ ifeq ($(CONFIG_PLUGIN),y)
 PLUGIN_SRC=$(SRC_PATH)/tests/plugin
 PLUGIN_LIB=../../plugin
 VPATH+=$(PLUGIN_LIB)
-PLUGINS=$(patsubst %.c, lib%.so, $(notdir $(wildcard $(PLUGIN_SRC)/*.c)))
+PLUGINS=$(filter-out liblockstep.so,\
+		$(patsubst %.c, lib%.so, $(notdir $(wildcard $(PLUGIN_SRC)/*.c))))
 
 # We need to ensure expand the run-plugin-TEST-with-PLUGIN
 # pre-requistes manually here as we can't use stems to handle it. We
-- 
2.20.1


