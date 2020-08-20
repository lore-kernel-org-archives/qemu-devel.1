Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4244BC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 17:39:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11908207DE
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 17:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u7cHdir9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11908207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8oXe-0002Mr-AG
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 13:39:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45464)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aladjev.andrew@gmail.com>)
 id 1k8oWj-0001B8-Oj
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 13:39:01 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:45759)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aladjev.andrew@gmail.com>)
 id 1k8oWi-0002sc-6C
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 13:39:01 -0400
Received: by mail-lj1-x241.google.com with SMTP id w25so2989437ljo.12
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2020 10:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8WXZes1y04oUg9FXA0T8sp9tZMtYPGELgZbqWosaRUA=;
 b=u7cHdir99O0tJvEIecRKEpFV/0DUMQy5vBzjJhVXAEsRbN1aQGgMBmNCrBs3Ajmj4f
 VF5hk7WywRcyQuivHwh0o+B61UtQ6h9V/ULdVVtN7V2MvVtkiXGtlhcGStH6V+rhhRzg
 8LQ496GBhflZIUaqHmNCNRzV7gDosPWCE/KmR2SW9TUJR4530CszD/YSVkzwQlo7H9lI
 6DGjeljxmPHHDQdtdBSmBR59HK7mCp8jIxzy8mxYFJp3yBb7j9tP5yMjERxVy+7v2+t2
 C2GWXGjA0NewSQQwcmKYPpAB+sRvjscvTCbJkjADrru/HUfTzEozD/43C7PBw/JfFyy8
 0XCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8WXZes1y04oUg9FXA0T8sp9tZMtYPGELgZbqWosaRUA=;
 b=ImpzYAVM+F825JWQGEAzcdRu65SLbchR648uSMSm6SUFc2CwfHzagu4nr0aDHgqwZz
 VS6LKxQXtwSrhxqf2QAw1m//S2PLmNHZVASjIDCW48c6B2WlRrGA6tKUAhlniMg+vKCK
 t8h74JxZ1xUSmJiUzVrOouWGbZiroxcS6feoF2Upp1OE9XY1hcrf5tqS4yOF+WZcEuWT
 9tYwk49SCDemqZerXIOUe0Urw3AGI4wUEWL6J5tafpOg3NGRVMO7cC9IsDMi0yb5HCVu
 141Vh3JligLRd0n6QfrKhQruI/yNRH8MnwTIffagBzyNpOuHNARbpN0jx2WuF4ZiEIPn
 6w+Q==
X-Gm-Message-State: AOAM532Tlcszua0WB9itO/NNtkRE9MfJrOBRnrbCFNfy9a1h0hHikKVA
 umxhznc4fN+SFHOvDvBHHLTPhLUSLC1w+Q==
X-Google-Smtp-Source: ABdhPJwSQlIC4y3jIK4NNB5G1dbBTsTTvk2UP1ZetBNWJFxBcatxED2dWVcH7gGg7ghkjjQKN5mqKQ==
X-Received: by 2002:a05:651c:233:: with SMTP id
 z19mr2175239ljn.347.1597945138235; 
 Thu, 20 Aug 2020 10:38:58 -0700 (PDT)
Received: from mini.lan (ns331963.ip-37-187-122.eu. [37.187.122.190])
 by smtp.gmail.com with ESMTPSA id g19sm566930ljn.91.2020.08.20.10.38.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2020 10:38:57 -0700 (PDT)
From: Andrew Aladjev <aladjev.andrew@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] linux user: refactored is proc functions for syscalls
Date: Thu, 20 Aug 2020 20:38:39 +0300
Message-Id: <20200820173839.20184-2-aladjev.andrew@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200820173839.20184-1-aladjev.andrew@gmail.com>
References: <20200820173839.20184-1-aladjev.andrew@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::241;
 envelope-from=aladjev.andrew@gmail.com; helo=mail-lj1-x241.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Andrew Aladjev <aladjev.andrew@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Andrew Aladjev <aladjev.andrew@gmail.com>
---
 linux-user/syscall.c | 81 ++++++++++++++++++++++++++++++--------------
 1 file changed, 56 insertions(+), 25 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 3d8c57522d..7b4d7cc197 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7482,38 +7482,69 @@ static int open_self_auxv(void *cpu_env, int fd)
     return 0;
 }
 
-static int is_proc_myself(const char *filename, const char *entry)
-{
-    if (!strncmp(filename, "/proc/", strlen("/proc/"))) {
-        filename += strlen("/proc/");
-        if (!strncmp(filename, "self/", strlen("self/"))) {
-            filename += strlen("self/");
-        } else if (*filename >= '1' && *filename <= '9') {
-            char myself[80];
-            snprintf(myself, sizeof(myself), "%d/", getpid());
-            if (!strncmp(filename, myself, strlen(myself))) {
-                filename += strlen(myself);
-            } else {
-                return 0;
-            }
-        } else {
-            return 0;
-        }
-        if (!strcmp(filename, entry)) {
-            return 1;
+#define PROC "/proc/"
+#define SELF "self/"
+
+#define STARTS_WITH(path, CONSTANT) (              \
+    strlen(path) >= strlen(CONSTANT) &&            \
+    strncmp(path, CONSTANT, strlen(CONSTANT)) == 0 \
+)
+
+static inline char *scope_to_proc(const char *path)
+{
+    if (STARTS_WITH(path, PROC)) {
+        return (char *)path + strlen(PROC);
+    }
+
+    return NULL;
+}
+
+static inline char *scope_to_proc_myself(const char *path)
+{
+    char *scope_path = scope_to_proc(path);
+    if (scope_path == NULL) {
+        return NULL;
+    }
+
+    if (STARTS_WITH(scope_path, SELF)) {
+        return scope_path + strlen(SELF);
+    }
+
+    if (strlen(scope_path) >= 1 &&
+        *scope_path >= '1' && *scope_path <= '9') {
+        char pid_path[80];
+        snprintf(pid_path, sizeof(pid_path), "%d/", getpid());
+        if (STARTS_WITH(scope_path, pid_path)) {
+            return scope_path + strlen(pid_path);
         }
     }
-    return 0;
+
+    return NULL;
 }
 
 #if defined(HOST_WORDS_BIGENDIAN) != defined(TARGET_WORDS_BIGENDIAN) || \
     defined(TARGET_SPARC) || defined(TARGET_M68K) || defined(TARGET_HPPA)
-static int is_proc(const char *filename, const char *entry)
+static int is_proc(const char *path, const char *entry)
 {
-    return strcmp(filename, entry) == 0;
+    char *scope_path = scope_to_proc(path);
+    if (scope_path == NULL) {
+        return 0;
+    }
+
+    return strcmp(scope_path, entry) == 0;
 }
 #endif
 
+static int is_proc_myself(const char *path, const char *entry)
+{
+    char *scope_path = scope_to_proc_myself(path);
+    if (scope_path == NULL) {
+        return 0;
+    }
+
+    return strcmp(scope_path, entry) == 0;
+}
+
 #if defined(HOST_WORDS_BIGENDIAN) != defined(TARGET_WORDS_BIGENDIAN)
 static int open_net_route(void *cpu_env, int fd)
 {
@@ -7601,13 +7632,13 @@ static int do_openat(void *cpu_env, int dirfd, const char *pathname, int flags,
         { "auxv", open_self_auxv, is_proc_myself },
         { "cmdline", open_self_cmdline, is_proc_myself },
 #if defined(HOST_WORDS_BIGENDIAN) != defined(TARGET_WORDS_BIGENDIAN)
-        { "/proc/net/route", open_net_route, is_proc },
+        { "net/route", open_net_route, is_proc },
 #endif
 #if defined(TARGET_SPARC) || defined(TARGET_HPPA)
-        { "/proc/cpuinfo", open_cpuinfo, is_proc },
+        { "cpuinfo", open_cpuinfo, is_proc },
 #endif
 #if defined(TARGET_M68K)
-        { "/proc/hardware", open_hardware, is_proc },
+        { "hardware", open_hardware, is_proc },
 #endif
         { NULL, NULL, NULL }
     };
-- 
2.26.2


