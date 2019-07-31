Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D523FC433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:20:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3F4E206A3
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:20:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IXVI1UXY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3F4E206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsrLN-0000Sz-Uc
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 12:20:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42322)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hsrG5-0005pH-Ng
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:15:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hsrG1-000475-Os
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:15:19 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33696)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hsrFz-00045J-R9
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:15:17 -0400
Received: by mail-wr1-x444.google.com with SMTP id n9so70435911wru.0
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 09:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ETn84aVwzraVZR/ukzhhM5DHZ0Q2gcDn01igaexosx0=;
 b=IXVI1UXYGYFOZ9jKBjjo/7x0/5Ula4rEgEDzcFYTcVYscj+i1zbqbhNxiX0fo8JAvu
 2RcwY8m5MgfpX/zX/lLdeZL6mvvvQCbfZoHfURxRe44hPBhbtO5Hqodi53cnVEPwV3dK
 pZWO2rSB7Q+6jI1zFjbaodmMdDf4Wyc7uqoBOVGNyvksNCYJ7TVNLkCxl4HnU3NaQRcf
 F1ApoJSMzdwD4SrjL6GdkBY92p1+CI/NIJXDB6xY3UaFjlqi5AneOL+gAzm3YPYemv3u
 gf4AEjbHV5a/u9n6GDzt9bPPdJVro0Y5Jz52g6+Zgol0763C5A3FIfG9h3/98kOWSHsc
 duJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ETn84aVwzraVZR/ukzhhM5DHZ0Q2gcDn01igaexosx0=;
 b=pZcgfX6XmX2FSGHKO6HgIWXZ7Gnaht8hihEfWoKH6KdPGfiX0wRjSfbmF2/8fZMGZl
 Do0hI/vVHim72xiqpHUP1YdrWVrqdXCP2mDPHDva5/Q21Fx8I6VierrAHcaGx0PEjqvL
 IsAok8MEzfpP2trnKzuDGHyx0RY5t8NOiaCpY96tXwjWsjsHW0gJDi0lNK4bfTtzNo05
 Az7Ma8aV6P7qyUgpk9vYPmChH7S0tVhFxWnnxT+hi1XGjKeG3/ay0nSBGyxtCBE7MsTu
 v/wb7aJubRd4+av7Xuc/mnP5F4NhiaVjpO0LSgkmhofnqL7j0iKZ920bP56HkTJF594g
 hGbw==
X-Gm-Message-State: APjAAAUfmNC3GjJpWCxXd/E3BT7PdRNgi55rj/z5Lp1FYlbzue4kcHZm
 aCZr+8ZQlLbsx4IzZ8IjCFfpvQ==
X-Google-Smtp-Source: APXvYqzT697wIZ21eVsK4mf9nOLgLFWnWSRF96rbadKVA/ceGWCUPmVc5kXiXUK2cx68ZRM3EomM8w==
X-Received: by 2002:adf:e705:: with SMTP id c5mr87792253wrm.270.1564589713239; 
 Wed, 31 Jul 2019 09:15:13 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id l2sm46111132wmj.4.2019.07.31.09.15.12
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 09:15:12 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9FE611FFC3;
 Wed, 31 Jul 2019 17:07:23 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 17:07:10 +0100
Message-Id: <20190731160719.11396-46-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190731160719.11396-1-alex.bennee@linaro.org>
References: <20190731160719.11396-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH  v4 45/54] linux-user: support -plugin option
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
Cc: Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, aaron@os.amperecomputing.com,
 cota@braap.org, bobby.prani@gmail.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Lluís Vilanova <vilanova@ac.upc.edu>

Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>
[ cota: s/instrument/plugin ]
Signed-off-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 linux-user/main.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/linux-user/main.c b/linux-user/main.c
index 8ffc5251955..42daa47dd3c 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -33,6 +33,7 @@
 #include "qemu/error-report.h"
 #include "qemu/help_option.h"
 #include "qemu/module.h"
+#include "qemu/plugin.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "tcg.h"
@@ -392,6 +393,15 @@ static void handle_arg_trace(const char *arg)
     trace_file = trace_opt_parse(arg);
 }
 
+static QemuPluginList plugins = QTAILQ_HEAD_INITIALIZER(plugins);
+
+#ifdef CONFIG_PLUGIN
+static void handle_arg_plugin(const char *arg)
+{
+    qemu_plugin_opt_parse(arg, &plugins);
+}
+#endif
+
 struct qemu_argument {
     const char *argv;
     const char *env;
@@ -443,6 +453,10 @@ static const struct qemu_argument arg_table[] = {
      "",           "Seed for pseudo-random number generator"},
     {"trace",      "QEMU_TRACE",       true,  handle_arg_trace,
      "",           "[[enable=]<pattern>][,events=<file>][,file=<file>]"},
+#ifdef CONFIG_PLUGIN
+    {"plugin",     "QEMU_PLUGIN",      true,  handle_arg_plugin,
+     "",           "[file=]<file>[,arg=<string>]"},
+#endif
     {"version",    "QEMU_VERSION",     false, handle_arg_version,
      "",           "display version information and exit"},
     {NULL, NULL, false, NULL, NULL, NULL}
@@ -633,6 +647,7 @@ int main(int argc, char **argv, char **envp)
     cpu_model = NULL;
 
     qemu_add_opts(&qemu_trace_opts);
+    qemu_plugin_add_opts();
 
     optind = parse_args(argc, argv);
 
@@ -640,6 +655,9 @@ int main(int argc, char **argv, char **envp)
         exit(1);
     }
     trace_init_file(trace_file);
+    if (qemu_plugin_load_list(&plugins)) {
+        exit(1);
+    }
 
     /* Zero out regs */
     memset(regs, 0, sizeof(struct target_pt_regs));
-- 
2.20.1


