Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCA5C282E1
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 14:37:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D009A218FD
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 14:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLsLaoX1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D009A218FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42663 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJJ1H-0006Ux-Em
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 10:37:07 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJIzG-0004gM-27
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:35:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJIsh-0001Ed-HS
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:28:17 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:39748)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJIsh-0001ER-8U
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:28:15 -0400
Received: by mail-wr1-x443.google.com with SMTP id a9so7883248wrp.6
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 07:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=M3YSO3dI0sJMlSR+ppmy4WdoBSCnY0dsCE1UChjYBRM=;
	b=NLsLaoX1THaHDpO79DaABC6kpxTLYO+QlvLSMAEVpcpO9vsNbWKjL7h3nSW71JQY1e
	zN6S0UMiolNCgMGsYHxALGea/TzaC7IKhD8U4BIqDmAzwrEIjNTyZw+KUqNRGr7853vk
	URJanL6Mu+Nj+YebkNHwmhlZr0uTzygrbpJXLTYhre5lrykLXSkaNn/ygKFi66oacjE8
	pM6cF8koZihM8F+oo+TozbFKOYTIFTj7kwO3xz/Scd2M7zCl1zqHJKig5TzB1SQY3a73
	1r9ML1H5tQ/BWibJr+R2xuGu3ShBqXKsDz2f49T/P5bDgTTbvyS9+SdMrgTIofAWSlEc
	54CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=M3YSO3dI0sJMlSR+ppmy4WdoBSCnY0dsCE1UChjYBRM=;
	b=TdzhvBCGulj1k/FOEJYNfFz3rs/V68Kyb31ehZLkmUEqGI5HnIIpE0GMTurlIbqomi
	gv4Kc0U5ZaqZHMx/wmhhgjyzKehTa8OqWMoopjBL0UchHksKpWR4GWkwpAVjfx4tO4sB
	cbDUlZ/wYRRcGxCvvSsqd/K/T47XUSM1UTWGZARJovlVCty1KlNgaofLiPF/QaHK/xoO
	DtFSUt8/Ku3N2kIGB1MRhG11e8kZ8Cg92vnz5weuIRviEpXSsaej8GKLhfvws6pYicWl
	y4T7OgJPz2c9WBxYA/T3u1PHfNUuj0/DWfiNxuSQbqTpf2Syb0T+D45BsEw/7sL9vrUH
	PgLg==
X-Gm-Message-State: APjAAAVAQCDw0ASowoEDWcoNwUM4kxs7ahSuXDNNTtK4MFQTR9RcPyTy
	4X3AmszGjxYYj0mIQnlfmLMSAvLc
X-Google-Smtp-Source: APXvYqwODb+IDEspFRGAA2pyiACETIsBI/yrR785XuoOAuHTje6gEwx1Vml+zXr8XJwjk2hs8hRZyw==
X-Received: by 2002:adf:eb02:: with SMTP id s2mr21682587wrn.29.1556116093459; 
	Wed, 24 Apr 2019 07:28:13 -0700 (PDT)
Received: from linux.local ([31.154.166.148])
	by smtp.gmail.com with ESMTPSA id q7sm5518041wmc.11.2019.04.24.07.28.11
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 24 Apr 2019 07:28:12 -0700 (PDT)
From: arilou@gmail.com
To: qemu-devel@nongnu.org
Date: Wed, 24 Apr 2019 17:27:14 +0300
Message-Id: <20190424142714.28460-20-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190424142714.28460-1-arilou@gmail.com>
References: <20190424142714.28460-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH v3 20/20] gdbstub: Refactor parse handle packet
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
Message-ID: <20190424142714.vsCNpDjZcglAN-gAEShXL4x-MeJA2-B5PaBvNsC7MmY@z>

From: Jon Doron <arilou@gmail.com>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 386 ++++++++++++++++++++++--------------------------------
 1 file changed, 158 insertions(+), 228 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index c206a9a7c6..0ed9a91768 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -2263,240 +2263,170 @@ static void handle_gen_set(GdbCmdContext *gdb_ctx, void *user_ctx)
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


