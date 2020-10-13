Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 944D7C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 00:33:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F06B421655
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 00:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QmVfaBHb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F06B421655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS8GI-00043g-QL
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 20:33:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54858)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kS8BA-00089m-3h
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 20:28:36 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634]:44954)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kS8B8-0004n5-7I
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 20:28:35 -0400
Received: by mail-pl1-x634.google.com with SMTP id h2so9663284pll.11
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 17:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6EEWtf959v7hUyUxi3MVaZ6cv8vfOrUV9fQH+OQchcM=;
 b=QmVfaBHbdibNYWTsXW5fn9cmR8+8VSx3RISHjy/0KvrDXhLPonSjFVYVs7yAIFRD0U
 e2rkzkJ4pA97d+y6zP6paTbdfA7Ya+OeXCsx1S1t5SUAo8jwSo224GkLXEzs7JKwhhHm
 6ikb0+pYXW/Sa6mzQXnwScQbY09grbbeAI0Fo+U9S57aP0IiFGditfqeoBtlclsu65LR
 N2tBun9OYoximlBeNAmfKs7SIgthBKkOu0I3zcGbJBRdkA0NgNItEhoNiMMuiXdE5h3M
 ChILpG8yZAYLP3CcxQ+41/rAMM78EAre6KuHwnFdftvPwRURIOLbuiqHo9KGslo/T3yf
 3L2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6EEWtf959v7hUyUxi3MVaZ6cv8vfOrUV9fQH+OQchcM=;
 b=dy5C85Ogr1GGQFxI1XvSbjU/tvY8qzNvwS0yQmvlOntX7aguLxZ5pNdcgqdfZmPWEd
 buPUXrR5hPQddkDXQpvzfLfa938/c7g9sBIJGHDCUGD3DiacuNuMhacVaQLsO6Wqg8iV
 zbfe9S5CHQai90shbgCzO2tFJc815RHaPnz3sVeJO82DumGdxKvLIB7QX0744XOTD2eN
 3rx6V1uX98K7+0UedYW0ZuUHW10W4YQhzFk/YKxV0J0os55o1SFkw45wCvrYOfFbRPkk
 R2gV1Me4k3Y36GM6HllPMfuslIaf92HMG1v8ckxdHeIhnvDuBhzuyJ4DJApnaGrGe7Gr
 kZNg==
X-Gm-Message-State: AOAM531teJ4C5xSyXGQDxrFB+v0Be/DhIjaMDnlLWrS0VlHNYm1k6Duq
 otvyP/1957ly0q1jEXNM5caIjQjjUKqB6g==
X-Google-Smtp-Source: ABdhPJy/IQFDqlIEDsCgXhRr3uXj80AfmZaBhVPbynymGr05VNHJ9vvuvJXyQxaq93cVqX551pQdpg==
X-Received: by 2002:a17:902:aa94:b029:d3:b593:2736 with SMTP id
 d20-20020a170902aa94b02900d3b5932736mr25905862plr.57.1602548912361; 
 Mon, 12 Oct 2020 17:28:32 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id y5sm22565925pge.62.2020.10.12.17.28.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 17:28:31 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 4/5] plugins: Getting qemu-plugin.h can be included in
 multiple source file
Date: Tue, 13 Oct 2020 08:28:05 +0800
Message-Id: <20201013002806.1447-5-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20201013002806.1447-1-luoyonggang@gmail.com>
References: <20201013002806.1447-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=luoyonggang@gmail.com; helo=mail-pl1-x634.google.com
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If we only have a single .c file in a plugin, then define
QEMU_PLUGIN_EXTERN to empty is OK, but if we have multiple .c files
in a plugin, then we need distinguish the implementation and the
deceleration. only the main .c file should define the macro QEMU_PLUGIN_IMPLEMENTATION
other sources are user and should use extern

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 contrib/plugins/hotblocks.c | 1 +
 contrib/plugins/hotpages.c  | 1 +
 contrib/plugins/howvec.c    | 1 +
 contrib/plugins/lockstep.c  | 1 +
 include/qemu/qemu-plugin.h  | 6 ++++++
 plugins/core.c              | 1 +
 tests/plugin/bb.c           | 1 +
 tests/plugin/empty.c        | 1 +
 tests/plugin/insn.c         | 1 +
 tests/plugin/mem.c          | 1 +
 10 files changed, 15 insertions(+)

diff --git a/contrib/plugins/hotblocks.c b/contrib/plugins/hotblocks.c
index 37435a3fc7..39e77d2980 100644
--- a/contrib/plugins/hotblocks.c
+++ b/contrib/plugins/hotblocks.c
@@ -13,6 +13,7 @@
 #include <stdio.h>
 #include <glib.h>
 
+#define QEMU_PLUGIN_IMPLEMENTATION
 #include <qemu-plugin.h>
 
 QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
diff --git a/contrib/plugins/hotpages.c b/contrib/plugins/hotpages.c
index ecd6c18732..1ae3f44aed 100644
--- a/contrib/plugins/hotpages.c
+++ b/contrib/plugins/hotpages.c
@@ -16,6 +16,7 @@
 #include <stdio.h>
 #include <glib.h>
 
+#define QEMU_PLUGIN_IMPLEMENTATION
 #include <qemu-plugin.h>
 
 QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
diff --git a/contrib/plugins/howvec.c b/contrib/plugins/howvec.c
index 3b9a6939f2..db1b4e5780 100644
--- a/contrib/plugins/howvec.c
+++ b/contrib/plugins/howvec.c
@@ -18,6 +18,7 @@
 #include <stdio.h>
 #include <glib.h>
 
+#define QEMU_PLUGIN_IMPLEMENTATION
 #include <qemu-plugin.h>
 
 QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
diff --git a/contrib/plugins/lockstep.c b/contrib/plugins/lockstep.c
index a696673dff..7173b2910d 100644
--- a/contrib/plugins/lockstep.c
+++ b/contrib/plugins/lockstep.c
@@ -31,6 +31,7 @@
 #include <stdio.h>
 #include <errno.h>
 
+#define QEMU_PLUGIN_IMPLEMENTATION
 #include <qemu-plugin.h>
 
 QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index af2f6ccb78..a6ebb295de 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -426,7 +426,11 @@ typedef void (*qemu_plugin_outs_t)(const char *string);
 
 #if !defined(QEMU_PLUGIN_API_IMPLEMENTATION)
 
+#if defined(QEMU_PLUGIN_IMPLEMENTATION)
 #define qemu_plugin_decl_symbol(symbol_name) symbol_name##_t symbol_name
+#else
+#define qemu_plugin_decl_symbol(symbol_name) extern symbol_name##_t symbol_name
+#endif
 
 #define qemu_plugin_load_symbol(info, symbol_name) do {\
     symbol_name = info->dlsym(info->context, #symbol_name); \
@@ -472,6 +476,7 @@ qemu_plugin_decl_symbol(qemu_plugin_n_vcpus);
 qemu_plugin_decl_symbol(qemu_plugin_n_max_vcpus);
 qemu_plugin_decl_symbol(qemu_plugin_outs);
 
+#if defined(QEMU_PLUGIN_IMPLEMENTATION)
 QEMU_PLUGIN_EXPORT int qemu_plugin_initialize(const qemu_info_t *info)
 {
     qemu_plugin_load_symbol(info, qemu_plugin_uninstall);
@@ -512,6 +517,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_initialize(const qemu_info_t *info)
     qemu_plugin_load_symbol(info, qemu_plugin_outs);
     return 0;
 }
+#endif /* QEMU_PLUGIN_IMPLEMENTATION */
 
 #endif /* QEMU_PLUGIN_API_IMPLEMENTATION */
 
diff --git a/plugins/core.c b/plugins/core.c
index 3df3e7d9af..dd1ec7b3fc 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -12,6 +12,7 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 #include "qemu/osdep.h"
+#define QEMU_PLUGIN_API_IMPLEMENTATION
 #include "qemu/error-report.h"
 #include "qemu/config-file.h"
 #include "qapi/error.h"
diff --git a/tests/plugin/bb.c b/tests/plugin/bb.c
index de09bdde4e..cda3fbdde9 100644
--- a/tests/plugin/bb.c
+++ b/tests/plugin/bb.c
@@ -12,6 +12,7 @@
 #include <stdio.h>
 #include <glib.h>
 
+#define QEMU_PLUGIN_IMPLEMENTATION
 #include <qemu-plugin.h>
 
 QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
diff --git a/tests/plugin/empty.c b/tests/plugin/empty.c
index 8fa6bacd93..0c3adf7aa0 100644
--- a/tests/plugin/empty.c
+++ b/tests/plugin/empty.c
@@ -11,6 +11,7 @@
 #include <unistd.h>
 #include <stdio.h>
 
+#define QEMU_PLUGIN_IMPLEMENTATION
 #include <qemu-plugin.h>
 
 QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
diff --git a/tests/plugin/insn.c b/tests/plugin/insn.c
index a9a6e41237..bf86fdafe6 100644
--- a/tests/plugin/insn.c
+++ b/tests/plugin/insn.c
@@ -12,6 +12,7 @@
 #include <stdio.h>
 #include <glib.h>
 
+#define QEMU_PLUGIN_IMPLEMENTATION
 #include <qemu-plugin.h>
 
 QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
diff --git a/tests/plugin/mem.c b/tests/plugin/mem.c
index 4725bd851d..f39be9c969 100644
--- a/tests/plugin/mem.c
+++ b/tests/plugin/mem.c
@@ -12,6 +12,7 @@
 #include <stdio.h>
 #include <glib.h>
 
+#define QEMU_PLUGIN_IMPLEMENTATION
 #include <qemu-plugin.h>
 
 QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
-- 
2.28.0.windows.1


