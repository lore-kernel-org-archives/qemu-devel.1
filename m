Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE18C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 02:41:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E564B2083E
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 02:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d+o7d75w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E564B2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbxdD-0001qQ-5o
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 22:41:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48314)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jbxWk-0003FK-8o
 for qemu-devel@nongnu.org; Thu, 21 May 2020 22:35:14 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:55060)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jbxWi-00059D-ST
 for qemu-devel@nongnu.org; Thu, 21 May 2020 22:35:13 -0400
Received: by mail-pj1-x1042.google.com with SMTP id s69so4293967pjb.4
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 19:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BrFduBNmLob/ZHyXbyYHj/vlX7R48tWvfDpwxlGRg/0=;
 b=d+o7d75w1dlN4N2FIq8e4q06qpBJmNEHlzIZHEEsXlgvTpu/1E3VoqzuVXTJlqRk7r
 Q1dohYUTIFDY7W/ugezO08NFd8RXBhXZj8yVQhFOzhXy494BR8HjI3GBrjPkzQjrfgfp
 Ky0Z+CaWObUzM6P0ZIoJMiSwKPneobr5q8+v7ENzoKCdoevuYUWCEKfvqoMp1sMJcJ74
 Fj70aNxhBWy5wJcnFeuABxs+bWflcgMla8v2SxVmU0Q2CAVWX6B3ssi/ardvAdaEIv4j
 PIWIg7vJgPw19zmrOIR1fDANVl9ZW1bu69e7qsfz+IQKJQvxP7QnD2JVolqbq1iVHrhj
 N0lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BrFduBNmLob/ZHyXbyYHj/vlX7R48tWvfDpwxlGRg/0=;
 b=SfvVHAsVl2Fc/B+UgR2aKN2+qdk59JYDYEHwuAfxfUm41KplCLUDxZYke4O1mwOV14
 y7dWFv85ENnTO7t05I7A9E+jOmyAhN+c0ylO/WTpJY1n35x1LBNY+FdF+WIT6OeC5qtL
 2Yq0tMvH9AXKBU1dTulYUjiGITOpCjV5g17Sk1cap3CKarCB1vYtbwjYroeliI6JNwvB
 sJ9F/ZtnwU3fWeyE1ixpM1/72QdTu/X1C/k6dc3SX08WcNL5ywRKrzONqNvVgb1iYGSZ
 /91FVKC8i95BwzTX2Hb9EJ6nl+W5vv7YIjvLXeQck2xu4N9AbDC1Ezp4ODacipwJlXiK
 D/wQ==
X-Gm-Message-State: AOAM532WW8FBHP9cBtdrJyqn2UiUBTCDT6+C9bscFRwGxhYjEFI+yn7U
 cGbEvud770FZiYRww7P0aSEStfACx/4=
X-Google-Smtp-Source: ABdhPJzgLCnAGnChgvw7j1EcJ3XwbYYugBr8f2c/crGpN1wg8dANLMcewLHltg2dgAgjL0ieUhZ41Q==
X-Received: by 2002:a17:902:bccc:: with SMTP id
 o12mr11723535pls.162.1590114911034; 
 Thu, 21 May 2020 19:35:11 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id gt10sm5443755pjb.30.2020.05.21.19.35.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 19:35:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 23/25] Add --fulldump and --diffdup options
Date: Thu, 21 May 2020 19:34:38 -0700
Message-Id: <20200522023440.26261-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200522023440.26261-1-richard.henderson@linaro.org>
References: <20200522023440.26261-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1042.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These allow the inspection of the trace files.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 risu.c | 117 +++++++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 102 insertions(+), 15 deletions(-)

diff --git a/risu.c b/risu.c
index f613fa9..8d907d9 100644
--- a/risu.c
+++ b/risu.c
@@ -484,23 +484,101 @@ static int apprentice(void)
     }
 }
 
-static int ismaster;
+static int dump_trace(bool isfull)
+{
+    RisuResult res;
+    int tick = 0;
+
+    while (1) {
+        struct reginfo *this_ri;
+
+        this_ri = &ri[tick & 1];
+        res = recv_register_info(this_ri);
+
+        switch (res) {
+        case RES_OK:
+            switch (header.risu_op) {
+            case OP_COMPARE:
+            case OP_TESTEND:
+            case OP_SIGILL:
+                printf("%s: (pc %#lx)\n", op_name(header.risu_op),
+                       (unsigned long)header.pc);
+
+                if (isfull || tick == 0) {
+                    reginfo_dump(this_ri, stdout);
+                } else {
+                    struct reginfo *prev_ri = &ri[(tick - 1) & 1];
+
+                    if (reginfo_is_eq(prev_ri, this_ri)) {
+                        /*
+                         * ??? There should never be no change -- at minimum
+                         * PC should have advanced.  But for completeness...
+                         */
+                        printf("change detail: none\n");
+                    } else {
+                        printf("change detail (prev : next):\n");
+                        reginfo_dump_mismatch(prev_ri, this_ri, stdout);
+                    }
+                }
+                putchar('\n');
+                if (header.risu_op == OP_TESTEND) {
+                    return EXIT_SUCCESS;
+                }
+                tick++;
+                break;
+
+            case OP_COMPAREMEM:
+                /* TODO: Dump 8k of data? */
+                /* fall through */
+            default:
+                printf("%s\n", op_name(header.risu_op));
+                break;
+            }
+            break;
+
+        case RES_BAD_IO:
+            fprintf(stderr, "I/O error\n");
+            return EXIT_FAILURE;
+        case RES_BAD_MAGIC:
+            fprintf(stderr, "Unexpected magic number: %#08x\n", header.magic);
+            return EXIT_FAILURE;
+        case RES_BAD_SIZE:
+            fprintf(stderr, "Unexpected payload size: %u\n", header.size);
+            return EXIT_FAILURE;
+        case RES_BAD_OP:
+            fprintf(stderr, "Unexpected opcode: %d\n", header.risu_op);
+            return EXIT_FAILURE;
+        default:
+            fprintf(stderr, "Unexpected recv result %d\n", res);
+            return EXIT_FAILURE;
+        }
+    }
+}
+
+enum {
+    DO_APPRENTICE,
+    DO_MASTER,
+    DO_FULLDUMP,
+    DO_DIFFDUMP,
+};
+
+static int operation = DO_APPRENTICE;
 
 static void usage(void)
 {
     fprintf(stderr,
-            "Usage: risu [--master] [--host <ip>] [--port <port>] <image file>"
-            "\n\n");
-    fprintf(stderr,
-            "Run through the pattern file verifying each instruction\n");
-    fprintf(stderr, "between master and apprentice risu processes.\n\n");
-    fprintf(stderr, "Options:\n");
-    fprintf(stderr, "  --master          Be the master (server)\n");
-    fprintf(stderr, "  -t, --trace=FILE  Record/playback " TRACE_TYPE " trace file\n");
-    fprintf(stderr,
-            "  -h, --host=HOST   Specify master host machine (apprentice only)"
-            "\n");
-    fprintf(stderr,
+            "Usage: risu [--master|--fulldump|--diffdump]\n"
+            "            [--host <ip>] [--port <port>] <image file>\n"
+            "\n"
+            "Run through the pattern file verifying each instruction\n"
+            "between master and apprentice risu processes.\n"
+            "\n"
+            "Options:\n"
+            "  --master          Be the master (server)\n"
+            "  --fulldump        Dump each record\n"
+            "  --diffdump        Dump difference between each record\n"
+            "  -t, --trace=FILE  Record/playback " TRACE_TYPE " trace file\n"
+            "  -h, --host=HOST   Specify master host machine\n"
             "  -p, --port=PORT   Specify the port to connect to/listen on "
             "(default 9191)\n");
     if (arch_extra_help) {
@@ -512,7 +590,9 @@ static struct option * setup_options(char **short_opts)
 {
     static struct option default_longopts[] = {
         {"help", no_argument, 0, '?'},
-        {"master", no_argument, &ismaster, 1},
+        {"master", no_argument, &operation, DO_MASTER},
+        {"fulldump", no_argument, &operation, DO_FULLDUMP},
+        {"diffdump", no_argument, &operation, DO_DIFFDUMP},
         {"host", required_argument, 0, 'h'},
         {"port", required_argument, 0, 'p'},
         {"trace", required_argument, 0, 't'},
@@ -520,7 +600,7 @@ static struct option * setup_options(char **short_opts)
     };
     struct option *lopts = &default_longopts[0];
 
-    *short_opts = "h:p:t:";
+    *short_opts = "d:h:p:t:";
 
     if (arch_long_opts) {
         const size_t osize = sizeof(struct option);
@@ -551,6 +631,7 @@ int main(int argc, char **argv)
     char *trace_fn = NULL;
     struct option *longopts;
     char *shortopts;
+    bool ismaster;
 
     longopts = setup_options(&shortopts);
 
@@ -586,6 +667,8 @@ int main(int argc, char **argv)
         }
     }
 
+    ismaster = operation == DO_MASTER;
+
     if (trace) {
         if (strcmp(trace_fn, "-") == 0) {
             comm_fd = ismaster ? STDOUT_FILENO : STDIN_FILENO;
@@ -609,6 +692,10 @@ int main(int argc, char **argv)
         }
     }
 
+    if (operation == DO_FULLDUMP || operation == DO_DIFFDUMP) {
+        return dump_trace(operation == DO_FULLDUMP);
+    }
+
     imgfile = argv[optind];
     if (!imgfile) {
         fprintf(stderr, "Error: must specify image file name\n\n");
-- 
2.20.1


