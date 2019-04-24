Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B55DFC10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 19:07:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DB3420835
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 19:07:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ALb2hSTi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DB3420835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45876 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJNEn-0001P2-Im
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 15:07:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJN6F-0002DH-Fj
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 14:58:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJMuK-0005MI-O9
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 14:46:13 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34676)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJMuK-0005Lk-Hc
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 14:46:12 -0400
Received: by mail-wr1-x443.google.com with SMTP id c6so20879665wrm.1
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 11:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=OoefeN2QNtrGn/jEm91iE7+6LVC6PL2qw7F8wxXc95w=;
	b=ALb2hSTiHscUyp+V/5A4lwWFow1qBevJMug2ewtcoZsxevJbkjaoMkDjc5YjYnSXcu
	qsLjpJ8VxQH1jusLftkv97j3+UTVD5pXmsl6iyhfVEdcQ0o0WRjA85YXZgpij274TT2i
	kMonWjHHxkT8zzqsis+p/+rmorION4+4t3gUfrzIf9nG4CVFj82wi9QXLSrmOGWZwUUU
	vW7W+Ms3nSxhjEeRs1gr4WAFqfDxM4xfzDu3ladCH1RyNei5JF7is9oLnI/DvxaVlXjC
	pb/hz8vPlLkpOD7h/d5s9XkHtJWzouLxuecAlhG3szoIhlQal/ijj8wWaviO65TFNptt
	tkdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=OoefeN2QNtrGn/jEm91iE7+6LVC6PL2qw7F8wxXc95w=;
	b=qZwUjIUI2QWmgwmDDx3tLZP60VZ0DH2pixpeO0xrY/U3L7nhwKj8qtiUpjMunUduSG
	D5sI1DEezceaQWMeKlXVxMQtDW2aVbdHliqxlfUEboHCzlgJ/I6WV6BQ0C2/SUs0JB9B
	nnFFjfUPjRJG5DU6n2PiwvjSMG2gwRp+XBuqWKno9cnUyyeqPpspMhTGTLC8Xyv346uL
	8H2mUVKDko7kTQzyqnqMzX8h//iNHPzmkBxwHOSUpYYOvfvZHbecA0HUpvDvF2EnJewB
	bDR760D3eeHYN0HiZ5hsjMow/e4wE+Bfh9PUmt1lcNf6C97BiFuiO80QeBW/CgbWeV7k
	F6uw==
X-Gm-Message-State: APjAAAUKMEpKB2dIUx2AQk3J76mjdh2KTGoaBjZwTQjwQ8RWYbaeBVKA
	cIi3+2t1CdALw3FMYw0V4GQMMe/t
X-Google-Smtp-Source: APXvYqwRNFANfGJWEAq/ls6bvaqbFH2inqg0hRy2MDfG3DZ8/juKfODnciaUberipGMev04+XIM2UA==
X-Received: by 2002:adf:ea86:: with SMTP id s6mr6813810wrm.44.1556131570356;
	Wed, 24 Apr 2019 11:46:10 -0700 (PDT)
Received: from linux.local ([31.154.166.148])
	by smtp.gmail.com with ESMTPSA id h9sm14720106wmb.5.2019.04.24.11.46.07
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 24 Apr 2019 11:46:08 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 24 Apr 2019 21:45:41 +0300
Message-Id: <20190424184600.8445-1-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH v4 01/20] gdbstub: Add infrastructure to parse
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
Cc: Jon Doron <arilou@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190424184541.lXlq7OJ3Sv_OMae5248YL2nPKFJQFqvC3kw0roijwLc@z>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 209 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 209 insertions(+)

diff --git a/gdbstub.c b/gdbstub.c
index d54abd17cc..64680722fc 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1268,6 +1268,215 @@ out:
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
+    const char *delim;
+    static char all_delimiters[] = ",;:=";
+    static char no_delimiter[] = "\0";
+    char curr_delimiters[2] = {0};
+    const char *delimiters;
+
+    if (delimiter == '?') {
+        delimiters = all_delimiters;
+    } else if (delimiter == '0') {
+        delimiters = no_delimiter;
+    } else if (delimiter == '.' && *param) {
+        return param + 1;
+    } else {
+        curr_delimiters[0] = delimiter;
+        delimiters = curr_delimiters;
+    }
+
+    while (*param) {
+        delim = delimiters;
+        while (*delim) {
+            if (*param == *delim) {
+                return param + 1;
+            }
+            delim++;
+        }
+        param++;
+    }
+
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
+ * cmd_full_match -> cmd is compared using strcmp
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
+    union {
+        int flags;
+        struct {
+            int cmd_startswith:1;
+            int cmd_full_match:1;
+        };
+    };
+    const char *schema;
+} GdbCmdParseEntry;
+
+static inline int startswith(const char *string, const char *pattern)
+{
+  return !strncmp(string, pattern, strlen(pattern));
+}
+
+__attribute__((unused)) static int process_string_cmd(
+        GDBState *s, void *user_ctx, const char *data,
+        GdbCmdParseEntry *cmds, int num_cmds);
+
+static int process_string_cmd(GDBState *s, void *user_ctx, const char *data,
+                              GdbCmdParseEntry *cmds, int num_cmds)
+{
+    int i, schema_len, max_num_params;
+    GdbCmdContext gdb_ctx;
+
+    if (!cmds) {
+        return -1;
+    }
+
+    for (i = 0; i < num_cmds; i++) {
+        if (!cmds[i].handler || !cmds[i].cmd ||
+            (cmds[i].cmd_startswith && !startswith(data, cmds[i].cmd)) ||
+            (cmds[i].cmd_full_match && strcmp(data, cmds[i].cmd))) {
+            continue;
+        }
+
+        max_num_params = 0;
+        if (cmds[i].schema) {
+            schema_len = strlen(cmds[i].schema);
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
+        if (cmd_parse_params(&data[strlen(cmds[i].cmd)], cmds[i].schema,
+                             gdb_ctx.params, &gdb_ctx.num_params)) {
+            return -1;
+        }
+
+        gdb_ctx.s = s;
+        cmds[i].handler(&gdb_ctx, user_ctx);
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
2.20.1


