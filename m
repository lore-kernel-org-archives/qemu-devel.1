Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D06CC04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 10:02:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C5662173E
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 10:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CL+qgFoD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C5662173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50464 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT1bO-0006v6-IO
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 06:02:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hT1Z2-0005aW-2u
	for qemu-devel@nongnu.org; Tue, 21 May 2019 06:00:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hT1Z0-0007Ix-Sf
	for qemu-devel@nongnu.org; Tue, 21 May 2019 06:00:08 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39511)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hT1Z0-0007I7-Km
	for qemu-devel@nongnu.org; Tue, 21 May 2019 06:00:06 -0400
Received: by mail-wr1-x442.google.com with SMTP id w8so17869713wrl.6
	for <qemu-devel@nongnu.org>; Tue, 21 May 2019 03:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=HeXxp6ZNbxAIS6ohiuhHmI98E5YPqRc//oGZBvyGF5Q=;
	b=CL+qgFoDDsCC3mCFauqacZsD9WNXyAFdVIrCwaKpL7zlA2Z1M2DQmBCnPmW0SLY4Jd
	mgSqb9Cm8szdNjOn3BSjZyITNovXLFZwFhOYZLuaVnbX/Gtpeisb+F7uaxfkK8f02aN5
	eQvUITNZg9kQsGTFcqcgfs45dqEMnPcBMnuaVs1xx1C8Df7UuD8/RxM7hjzTvxmefbBz
	8RsPlsEbaOdYISpEs2MkEFG44U0wzSDrdz5HyK+E95xbH2mpMcRDvOKO5DGj8cykZUZC
	mI1RLwSNTD0RpVog5g++wZUUxbCp68qyZDfWHgBel4CjWuGipBEmGLuQqer/ZysftI9w
	CSeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=HeXxp6ZNbxAIS6ohiuhHmI98E5YPqRc//oGZBvyGF5Q=;
	b=TOT40CRVJDLF+doBAwRVM6QjeH0+DfK7STit5PmFE7zHFsZYj75auXQbVUsb0T39F4
	i5yUF+rsVcOO0CMFOAUGXOGkQb3l3W3a9bgMyHF7gHwGEb0UQEBJ/C4Gfk/ucqkHPGns
	lLvvDxFwcD/KZDTU9qWvNseYxyQ+Ac5wDK+IxwcZHFde4MyGlw6o+3+RRnsEYt+ByKwd
	acjFHzgFTtykC4pxHM0jvxT0LJkUsy1cHcSXARvlBPoA687e7/ADIrq9ioSWJmMkQX3K
	JMo2FfU3G6Wok78yuiN1jv2KJ2uYWbx4trOhVE3E30bpaRitWC4OWISZF4WQAkWT4uad
	16tQ==
X-Gm-Message-State: APjAAAUeK8Tt4QmrgymjMRuS882yqU9gZSxl1rcDPqmZ5TYSuTlUnuAP
	cC6LZIQ6RGZZ2bNszxF68OMv58Ga
X-Google-Smtp-Source: APXvYqy/SBkO48+OsP2hJ5E6ACi2NqxCXs73UMnI+BkNeBYFBWBUmMCKMPsCpEk3H1JiAWG+cDnf4w==
X-Received: by 2002:a5d:4e09:: with SMTP id p9mr5133683wrt.218.1558432805342; 
	Tue, 21 May 2019 03:00:05 -0700 (PDT)
Received: from jondnuc.lan ([176.230.64.64])
	by smtp.gmail.com with ESMTPSA id 65sm3080257wro.85.2019.05.21.03.00.04
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 21 May 2019 03:00:04 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Tue, 21 May 2019 12:59:29 +0300
Message-Id: <20190521095948.8204-2-arilou@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190521095948.8204-1-arilou@gmail.com>
References: <20190521095948.8204-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH v10 01/20] gdbstub: Add infrastructure to parse
 cmd packets
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: alex.bennee@linaro.org, Jon Doron <arilou@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 195 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 195 insertions(+)

diff --git a/gdbstub.c b/gdbstub.c
index d54abd17cc..e6d895177b 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1268,6 +1268,201 @@ out:
     return res;
 }
 
+typedef union GdbCmdVariant {
+    const char *data;
+    uint8_t opcode;
+    unsigned long val_ul;
+    unsigned long long val_ull;
+    struct {
+        GDBThreadIdKind kind;
+        uint32_t pid;
+        uint32_t tid;
+    } thread_id;
+} GdbCmdVariant;
+
+static const char *cmd_next_param(const char *param, const char delimiter)
+{
+    static const char all_delimiters[] = ",;:=";
+    char curr_delimiters[2] = {0};
+    const char *delimiters;
+
+    if (delimiter == '?') {
+        delimiters = all_delimiters;
+    } else if (delimiter == '0') {
+        return strchr(param, '\0');
+    } else if (delimiter == '.' && *param) {
+        return param + 1;
+    } else {
+        curr_delimiters[0] = delimiter;
+        delimiters = curr_delimiters;
+    }
+
+    param += strcspn(param, delimiters);
+    if (*param) {
+        param++;
+    }
+    return param;
+}
+
+static int cmd_parse_params(const char *data, const char *schema,
+                            GdbCmdVariant *params, int *num_params)
+{
+    int curr_param;
+    const char *curr_schema, *curr_data;
+
+    *num_params = 0;
+
+    if (!schema) {
+        return 0;
+    }
+
+    curr_schema = schema;
+    curr_param = 0;
+    curr_data = data;
+    while (curr_schema[0] && curr_schema[1] && *curr_data) {
+        switch (curr_schema[0]) {
+        case 'l':
+            if (qemu_strtoul(curr_data, &curr_data, 16,
+                             &params[curr_param].val_ul)) {
+                return -EINVAL;
+            }
+            curr_param++;
+            curr_data = cmd_next_param(curr_data, curr_schema[1]);
+            break;
+        case 'L':
+            if (qemu_strtou64(curr_data, &curr_data, 16,
+                              (uint64_t *)&params[curr_param].val_ull)) {
+                return -EINVAL;
+            }
+            curr_param++;
+            curr_data = cmd_next_param(curr_data, curr_schema[1]);
+            break;
+        case 's':
+            params[curr_param].data = curr_data;
+            curr_param++;
+            curr_data = cmd_next_param(curr_data, curr_schema[1]);
+            break;
+        case 'o':
+            params[curr_param].opcode = *(uint8_t *)curr_data;
+            curr_param++;
+            curr_data = cmd_next_param(curr_data, curr_schema[1]);
+            break;
+        case 't':
+            params[curr_param].thread_id.kind =
+                read_thread_id(curr_data, &curr_data,
+                               &params[curr_param].thread_id.pid,
+                               &params[curr_param].thread_id.tid);
+            curr_param++;
+            curr_data = cmd_next_param(curr_data, curr_schema[1]);
+            break;
+        case '?':
+            curr_data = cmd_next_param(curr_data, curr_schema[1]);
+            break;
+        default:
+            return -EINVAL;
+        }
+        curr_schema += 2;
+    }
+
+    *num_params = curr_param;
+    return 0;
+}
+
+typedef struct GdbCmdContext {
+    GDBState *s;
+    GdbCmdVariant *params;
+    int num_params;
+    uint8_t mem_buf[MAX_PACKET_LENGTH];
+    char str_buf[MAX_PACKET_LENGTH + 1];
+} GdbCmdContext;
+
+typedef void (*GdbCmdHandler)(GdbCmdContext *gdb_ctx, void *user_ctx);
+
+/*
+ * cmd_startswith -> cmd is compared using startswith
+ *
+ *
+ * schema definitions:
+ * Each schema parameter entry consists of 2 chars,
+ * the first char represents the parameter type handling
+ * the second char represents the delimiter for the next parameter
+ *
+ * Currently supported schema types:
+ * 'l' -> unsigned long (stored in .val_ul)
+ * 'L' -> unsigned long long (stored in .val_ull)
+ * 's' -> string (stored in .data)
+ * 'o' -> single char (stored in .opcode)
+ * 't' -> thread id (stored in .thread_id)
+ * '?' -> skip according to delimiter
+ *
+ * Currently supported delimiters:
+ * '?' -> Stop at any delimiter (",;:=\0")
+ * '0' -> Stop at "\0"
+ * '.' -> Skip 1 char unless reached "\0"
+ * Any other value is treated as the delimiter value itself
+ */
+typedef struct GdbCmdParseEntry {
+    GdbCmdHandler handler;
+    const char *cmd;
+    bool cmd_startswith;
+    const char *schema;
+} GdbCmdParseEntry;
+
+static inline int startswith(const char *string, const char *pattern)
+{
+  return !strncmp(string, pattern, strlen(pattern));
+}
+
+static int process_string_cmd(
+        GDBState *s, void *user_ctx, const char *data,
+        const GdbCmdParseEntry *cmds, int num_cmds)
+        __attribute__((unused));
+
+static int process_string_cmd(GDBState *s, void *user_ctx, const char *data,
+                              const GdbCmdParseEntry *cmds, int num_cmds)
+{
+    int i, schema_len, max_num_params = 0;
+    GdbCmdContext gdb_ctx;
+
+    if (!cmds) {
+        return -1;
+    }
+
+    for (i = 0; i < num_cmds; i++) {
+        const GdbCmdParseEntry *cmd = &cmds[i];
+        g_assert(cmd->handler && cmd->cmd);
+
+        if ((cmd->cmd_startswith && !startswith(data, cmd->cmd)) ||
+            (!cmd->cmd_startswith && strcmp(cmd->cmd, data))) {
+            continue;
+        }
+
+        if (cmd->schema) {
+            schema_len = strlen(cmd->schema);
+            if (schema_len % 2) {
+                return -2;
+            }
+
+            max_num_params = schema_len / 2;
+        }
+
+        gdb_ctx.params =
+            (GdbCmdVariant *)alloca(sizeof(*gdb_ctx.params) * max_num_params);
+        memset(gdb_ctx.params, 0, sizeof(*gdb_ctx.params) * max_num_params);
+
+        if (cmd_parse_params(&data[strlen(cmd->cmd)], cmd->schema,
+                             gdb_ctx.params, &gdb_ctx.num_params)) {
+            return -1;
+        }
+
+        gdb_ctx.s = s;
+        cmd->handler(&gdb_ctx, user_ctx);
+        return 0;
+    }
+
+    return -1;
+}
+
 static int gdb_handle_packet(GDBState *s, const char *line_buf)
 {
     CPUState *cpu;
-- 
2.21.0


