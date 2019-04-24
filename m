Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D74C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 19:03:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0591206BA
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 19:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="msEeSyZh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0591206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45816 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJNAa-0005wF-UO
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 15:03:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJN69-0001z4-Ew
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 14:58:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJMuw-00065g-Cg
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 14:46:51 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39875)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJMuw-000654-3k
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 14:46:50 -0400
Received: by mail-wm1-x343.google.com with SMTP id n25so6515699wmk.4
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 11:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=VZlgR/bdvBO9GYH8kPpcaYFD1ijB8eF/54ekGvMt5aM=;
	b=msEeSyZhiXA1F7oDOJWvmNK4jruzKPSS6eWxuQU5Cx6xPxUPcPujwG2GdovNs3Gyzs
	RkEOcLJ2divFyipcwK79JT5GuCIyZGvb1ooMR/tKeXWc6EGVvHXTOvgfzaKa0kwPTyIe
	vH1KMsmS/CvJqmdCWm2rs3crdB29sAPM3xMHw1FMgPpppFNKIIHR/B3P1Rz6AdMIz6Zs
	2WFYNCuXQ8VZoRkWj//mjihorJUJyQPuVe+z4nlkAH/moWWMqR94rKnIGkB52OAs34wQ
	hfnGo4D2kUnhUo0k9ICH4ETNvf+RknKHvCVwm3TtXWuzG2Lhf9v/7AQ5g9f5FgHrPguc
	T2Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=VZlgR/bdvBO9GYH8kPpcaYFD1ijB8eF/54ekGvMt5aM=;
	b=eBDfAh2frtBlYUiukxu9v54iai+psj7gIa1/rOvo1vhdnK691nMkbf1J2qC/75tFdT
	EJ3oGS6IkCAhjGUqYrzqvaZzKi5js/hzFERFu0nwDFiTtmgu05TkTTVsMQSgTplgYUGx
	6sKG41505z9MPYZE1D6ReiwpdIi5LDeRduEbAXtzOx5nOlUzbSpXrXV+KbWtJBi3bzwr
	VzGjMp52wo9l28bJYZBX4hnLedCM8MEmb4L51iqqnDmwrll4yxE4weMYxxt23KSCqKlr
	l8OUZltSlui5qp3NKBUVxtEz4nYBjtDANDBbrVQQQngRyYSqurkIXbbfFzRZN1PhOt0/
	XqzQ==
X-Gm-Message-State: APjAAAWKanIBAjmmIf+sw5UvyFle6nI3ggjv0YCX51Mh83iQNrXJR0bV
	ulTVbSGH0zS6Nm+n2+Nsf0bpd3jr
X-Google-Smtp-Source: APXvYqxJ277h6KDM0p89zfOW6GKlcb1BcMi//dkUHJW8VwrMhh2osyvzXxJVabhquSwTNTQ7XFzLKQ==
X-Received: by 2002:a1c:f205:: with SMTP id s5mr338572wmc.131.1556131608349;
	Wed, 24 Apr 2019 11:46:48 -0700 (PDT)
Received: from linux.local ([31.154.166.148])
	by smtp.gmail.com with ESMTPSA id h9sm14720106wmb.5.2019.04.24.11.46.46
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 24 Apr 2019 11:46:47 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 24 Apr 2019 21:46:00 +0300
Message-Id: <20190424184600.8445-20-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190424184600.8445-1-arilou@gmail.com>
References: <20190424184600.8445-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PATCH v4 20/20] gdbstub: Refactor parse handle packet
 to work with a static array
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
Message-ID: <20190424184600.EzmOPOgGpgVdKKV1g_ksR3covkwL4un14prsaVYprqE@z>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 386 ++++++++++++++++++++++--------------------------------
 1 file changed, 158 insertions(+), 228 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 61ab630d9e..69b3a5185e 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -2257,240 +2257,170 @@ static void handle_gen_set(GdbCmdContext *gdb_ctx, void *user_ctx)
     put_packet(gdb_ctx->s, "");
 }
 
-static int gdb_handle_packet(GDBState *s, const char *line_buf)
+static void handle_extend_mode(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    put_packet(gdb_ctx->s, "OK");
+}
+
+static void handle_target_halt(GdbCmdContext *gdb_ctx, void *user_ctx)
 {
-    const char *p;
-    int ch;
-    uint8_t mem_buf[MAX_PACKET_LENGTH];
-    char buf[sizeof(mem_buf) + 1 /* trailing NUL */];
     char thread_id[16];
 
+    /* TODO: Make this return the correct value for user-mode.  */
+    gdb_fmt_thread_id(gdb_ctx->s, gdb_ctx->s->c_cpu, thread_id,
+                      sizeof(thread_id));
+    snprintf(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf), "T%02xthread:%s;",
+             GDB_SIGNAL_TRAP, thread_id);
+    put_packet(gdb_ctx->s, gdb_ctx->str_buf);
+    /*
+     * Remove all the breakpoints when this query is issued,
+     * because gdb is doing and initial connect and the state
+     * should be cleaned up.
+     */
+    gdb_breakpoint_remove_all();
+}
+
+static void handle_kill(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    /* Kill the target */
+    error_report("QEMU: Terminated via GDBstub");
+    exit(0);
+}
+
+static GdbCmdParseEntry gdb_packet_table[0x100] = {
+    ['!'] = {
+        .handler = handle_extend_mode,
+        .cmd = "!",
+        .cmd_startswith = 1
+    },
+    ['?'] = {
+        .handler = handle_target_halt,
+        .cmd = "?",
+        .cmd_startswith = 1
+    },
+    ['c'] = {
+        .handler = handle_continue,
+        .cmd = "c",
+        .cmd_startswith = 1,
+        .schema = "L0"
+    },
+    ['C'] = {
+        .handler = handle_cont_with_sig,
+        .cmd = "C",
+        .cmd_startswith = 1,
+        .schema = "l0"
+    },
+    ['v'] = {
+        .handler = handle_v_commands,
+        .cmd = "v",
+        .cmd_startswith = 1,
+        .schema = "s0"
+    },
+    ['k'] = {
+        .handler = handle_kill,
+        .cmd = "k",
+        .cmd_startswith = 1
+    },
+    ['D'] = {
+        .handler = handle_detach,
+        .cmd = "D",
+        .cmd_startswith = 1,
+        .schema = "?.l0"
+    },
+    ['s'] = {
+        .handler = handle_step,
+        .cmd = "s",
+        .cmd_startswith = 1,
+        .schema = "L0"
+    },
+    ['F'] = {
+        .handler = handle_file_io,
+        .cmd = "F",
+        .cmd_startswith = 1,
+        .schema = "s0"
+    },
+    ['g'] = {
+        .handler = handle_read_all_regs,
+        .cmd = "g",
+        .cmd_startswith = 1
+    },
+    ['G'] = {
+        .handler = handle_write_all_regs,
+        .cmd = "G",
+        .cmd_startswith = 1,
+        .schema = "s0"
+    },
+    ['m'] = {
+        .handler = handle_read_mem,
+        .cmd = "m",
+        .cmd_startswith = 1,
+        .schema = "L,L0"
+    },
+    ['M'] = {
+        .handler = handle_write_mem,
+        .cmd = "M",
+        .cmd_startswith = 1,
+        .schema = "L,L:s0"
+    },
+    ['p'] = {
+        .handler = handle_get_reg,
+        .cmd = "p",
+        .cmd_startswith = 1,
+        .schema = "L0"
+    },
+    ['P'] = {
+        .handler = handle_set_reg,
+        .cmd = "P",
+        .cmd_startswith = 1,
+        .schema = "L?s0"
+    },
+    ['Z'] = {
+        .handler = handle_insert_bp,
+        .cmd = "Z",
+        .cmd_startswith = 1,
+        .schema = "l?L?L0"
+    },
+    ['z'] = {
+        .handler = handle_remove_bp,
+        .cmd = "z",
+        .cmd_startswith = 1,
+        .schema = "l?L?L0"
+    },
+    ['H'] = {
+        .handler = handle_set_thread,
+        .cmd = "H",
+        .cmd_startswith = 1,
+        .schema = "o.t0"
+    },
+    ['T'] = {
+        .handler = handle_thread_alive,
+        .cmd = "T",
+        .cmd_startswith = 1,
+        .schema = "t0"
+    },
+    ['q'] = {
+        .handler = handle_gen_query,
+        .cmd = "q",
+        .cmd_startswith = 1,
+        .schema = "s0"
+    },
+    ['Q'] = {
+        .handler = handle_gen_set,
+        .cmd = "Q",
+        .cmd_startswith = 1,
+        .schema = "s0"
+    },
+};
+
+static int gdb_handle_packet(GDBState *s, const char *line_buf)
+{
     trace_gdbstub_io_command(line_buf);
 
-    p = line_buf;
-    ch = *p++;
-    switch(ch) {
-    case '!':
-        put_packet(s, "OK");
-        break;
-    case '?':
-        /* TODO: Make this return the correct value for user-mode.  */
-        snprintf(buf, sizeof(buf), "T%02xthread:%s;", GDB_SIGNAL_TRAP,
-                 gdb_fmt_thread_id(s, s->c_cpu, thread_id, sizeof(thread_id)));
-        put_packet(s, buf);
-        /* Remove all the breakpoints when this query is issued,
-         * because gdb is doing and initial connect and the state
-         * should be cleaned up.
-         */
-        gdb_breakpoint_remove_all();
-        break;
-    case 'c':
-        {
-            static GdbCmdParseEntry continue_cmd_desc = {
-                .handler = handle_continue,
-                .cmd = "c",
-                .cmd_startswith = 1,
-                .schema = "L0"
-            };
-            process_string_cmd(s, NULL, line_buf, &continue_cmd_desc, 1);
-        }
-        break;
-    case 'C':
-        {
-            static GdbCmdParseEntry cont_with_sig_cmd_desc = {
-                .handler = handle_cont_with_sig,
-                .cmd = "C",
-                .cmd_startswith = 1,
-                .schema = "l0"
-            };
-            process_string_cmd(s, NULL, line_buf, &cont_with_sig_cmd_desc, 1);
-        }
-        break;
-    case 'v':
-        {
-            static GdbCmdParseEntry v_cmd_desc = {
-                .handler = handle_v_commands,
-                .cmd = "v",
-                .cmd_startswith = 1,
-                .schema = "s0"
-            };
-            process_string_cmd(s, NULL, line_buf, &v_cmd_desc, 1);
-        }
-        break;
-    case 'k':
-        /* Kill the target */
-        error_report("QEMU: Terminated via GDBstub");
-        exit(0);
-    case 'D':
-        {
-            static GdbCmdParseEntry deatch_cmd_desc = {
-                .handler = handle_detach,
-                .cmd = "D",
-                .cmd_startswith = 1,
-                .schema = "?.l0"
-            };
-            process_string_cmd(s, NULL, line_buf, &deatch_cmd_desc, 1);
-        }
-        break;
-    case 's':
-        {
-            static GdbCmdParseEntry step_cmd_desc = {
-                .handler = handle_step,
-                .cmd = "s",
-                .cmd_startswith = 1,
-                .schema = "L0"
-            };
-            process_string_cmd(s, NULL, line_buf, &step_cmd_desc, 1);
-        }
-        break;
-    case 'F':
-        {
-            static GdbCmdParseEntry file_io_cmd_desc = {
-                .handler = handle_file_io,
-                .cmd = "F",
-                .cmd_startswith = 1,
-                .schema = "s0"
-            };
-            process_string_cmd(s, NULL, line_buf, &file_io_cmd_desc, 1);
-        }
-        break;
-    case 'g':
-        {
-            static GdbCmdParseEntry read_all_regs_cmd_desc = {
-                .handler = handle_read_all_regs,
-                .cmd = "g",
-                .cmd_startswith = 1
-            };
-            process_string_cmd(s, NULL, line_buf, &read_all_regs_cmd_desc, 1);
-        }
-        break;
-    case 'G':
-        {
-            static GdbCmdParseEntry write_all_regs_cmd_desc = {
-                .handler = handle_write_all_regs,
-                .cmd = "G",
-                .cmd_startswith = 1,
-                .schema = "s0"
-            };
-            process_string_cmd(s, NULL, line_buf, &write_all_regs_cmd_desc, 1);
-        }
-        break;
-    case 'm':
-        {
-            static GdbCmdParseEntry read_mem_cmd_desc = {
-                .handler = handle_read_mem,
-                .cmd = "m",
-                .cmd_startswith = 1,
-                .schema = "L,L0"
-            };
-            process_string_cmd(s, NULL, line_buf, &read_mem_cmd_desc, 1);
-        }
-        break;
-    case 'M':
-        {
-            static GdbCmdParseEntry write_mem_cmd_desc = {
-                .handler = handle_write_mem,
-                .cmd = "M",
-                .cmd_startswith = 1,
-                .schema = "L,L:s0"
-            };
-            process_string_cmd(s, NULL, line_buf, &write_mem_cmd_desc, 1);
-        }
-        break;
-    case 'p':
-        {
-            static GdbCmdParseEntry get_reg_cmd_desc = {
-                .handler = handle_get_reg,
-                .cmd = "p",
-                .cmd_startswith = 1,
-                .schema = "L0"
-            };
-            process_string_cmd(s, NULL, line_buf, &get_reg_cmd_desc, 1);
-        }
-        break;
-    case 'P':
-        {
-            static GdbCmdParseEntry set_reg_cmd_desc = {
-                .handler = handle_set_reg,
-                .cmd = "P",
-                .cmd_startswith = 1,
-                .schema = "L?s0"
-            };
-            process_string_cmd(s, NULL, line_buf, &set_reg_cmd_desc, 1);
-        }
-        break;
-    case 'Z':
-        {
-            static GdbCmdParseEntry insert_bp_cmd_desc = {
-                .handler = handle_insert_bp,
-                .cmd = "Z",
-                .cmd_startswith = 1,
-                .schema = "l?L?L0"
-            };
-            process_string_cmd(s, NULL, line_buf, &insert_bp_cmd_desc, 1);
-        }
-        break;
-    case 'z':
-        {
-            static GdbCmdParseEntry remove_bp_cmd_desc = {
-                .handler = handle_remove_bp,
-                .cmd = "z",
-                .cmd_startswith = 1,
-                .schema = "l?L?L0"
-            };
-            process_string_cmd(s, NULL, line_buf, &remove_bp_cmd_desc, 1);
-        }
-        break;
-    case 'H':
-        {
-            static GdbCmdParseEntry set_thread_cmd_desc = {
-                .handler = handle_set_thread,
-                .cmd = "H",
-                .cmd_startswith = 1,
-                .schema = "o.t0"
-            };
-            process_string_cmd(s, NULL, line_buf, &set_thread_cmd_desc, 1);
-        }
-        break;
-    case 'T':
-        {
-            static GdbCmdParseEntry thread_alive_cmd_desc = {
-                .handler = handle_thread_alive,
-                .cmd = "T",
-                .cmd_startswith = 1,
-                .schema = "t0"
-            };
-            process_string_cmd(s, NULL, line_buf, &thread_alive_cmd_desc, 1);
-        }
-        break;
-    case 'q':
-        {
-            static GdbCmdParseEntry gen_query_cmd_desc = {
-                .handler = handle_gen_query,
-                .cmd = "q",
-                .cmd_startswith = 1,
-                .schema = "s0"
-            };
-            process_string_cmd(s, NULL, line_buf, &gen_query_cmd_desc, 1);
-        }
-        break;
-    case 'Q':
-        {
-            static GdbCmdParseEntry gen_set_cmd_desc = {
-                .handler = handle_gen_set,
-                .cmd = "Q",
-                .cmd_startswith = 1,
-                .schema = "s0"
-            };
-            process_string_cmd(s, NULL, line_buf, &gen_set_cmd_desc, 1);
-        }
-        break;
-    default:
-        /* put empty packet */
-        buf[0] = '\0';
-        put_packet(s, buf);
-        break;
+    if (process_string_cmd(s, NULL, line_buf,
+                           &gdb_packet_table[*(uint8_t *)line_buf], 1)) {
+        put_packet(s, "");
     }
+
     return RS_IDLE;
 }
 
-- 
2.20.1


