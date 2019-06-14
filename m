Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 096AEC31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 17:27:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEC1D217F9
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 17:27:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pi3oeKyZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEC1D217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53774 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbpz9-0005lB-4E
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 13:27:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58585)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hbpqh-0005al-1I
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:18:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hbpqd-00075y-W2
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:18:46 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35206)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hbpqd-0006nJ-Jc
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:18:43 -0400
Received: by mail-wr1-x442.google.com with SMTP id m3so3351531wrv.2
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 10:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=P9bsnv/ggrydM2zdkz7ungy+IkQQkZz8WUvWT7dsGh0=;
 b=Pi3oeKyZ6lkA9rSME++oaRwdyK0KNvzRb9FhCxfeql0ZGOHxlDVmX8GwxY6za3KMz2
 lO8FQV0iQUmHquHPF5qOIMu9/Wx5i6IDqf7qCOWiUWYWlJ0f7EIzjdJ2hydaN7S7myOo
 L28d1LDHJUs1p5YQ9qZsuK+anhccmTu7KHIiEee4i7n8rnx2G44J9MMVHq+5O5UnkMEd
 4B/bQzWv+BN7dKPeT5xPPigPNltar0EC+TDsLQwh1bVS6dnoZgQflhw0+rVAZx8a+LJr
 ETJ7ogEjbyYp7mxXF59Dk/JSHRfVf0NUolWLRi9kB2b/uDjBrsU07+acYiUFErvwaSTn
 sf0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=P9bsnv/ggrydM2zdkz7ungy+IkQQkZz8WUvWT7dsGh0=;
 b=kuAOXskea8D7TMy0IsJ0FJik6JH7uUE4uckn/I+ShJGcphO58C6/1ztqgqE8cwuc03
 q6vHHFO+sTx/D8+wv3FNkTpVV5opVJjAa4V7UwB0eIbzM+f8zrfUG/msuS979nCRtp9E
 77byoJs0MDyiknWh0AudBIWEexDLEEDrvkzdpSg3djtmJk4w27RUr+dcUF7VZJltaUGi
 Q+XSTRCP3wdUoytwEkYI5z3JGsdfRFyNkkDeox1wha1Zl48lhnq+YuXIbeteoDE4waGR
 y07Th0gTTuoY0nxcUQ3+OZTBgSP11HEnCCG3zzg2Y6GQtdJast7rQca2Bqt0HiD0Lo2c
 ozkg==
X-Gm-Message-State: APjAAAWE7QGMRsVdIj/vHPhnIA62XhNcyWnB60A6gI7N6reA3UlzLmnY
 4llY9HXkUqVwieqQgH8n4DNp3A5UkOc=
X-Google-Smtp-Source: APXvYqzIn8CV4RvLu2tBmZWNPNVejfhi7H7xUjzkM2OPPybFYx53HxEbuIKhND7dS+IllAWDexX30Q==
X-Received: by 2002:a5d:4310:: with SMTP id h16mr55726729wrq.331.1560532716118; 
 Fri, 14 Jun 2019 10:18:36 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id c2sm4090092wrf.75.2019.06.14.10.18.29
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 14 Jun 2019 10:18:34 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 08CC01FFBF;
 Fri, 14 Jun 2019 18:12:04 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 14 Jun 2019 18:11:50 +0100
Message-Id: <20190614171200.21078-41-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190614171200.21078-1-alex.bennee@linaro.org>
References: <20190614171200.21078-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH  v3 40/50] linux-user: support -plugin option
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
Cc: Riku Voipio <riku.voipio@iki.fi>, "Emilio G . Cota" <cota@braap.org>,
 =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Lluís Vilanova <vilanova@ac.upc.edu>

Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>
[ cota: s/instrument/plugin ]
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 linux-user/main.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/linux-user/main.c b/linux-user/main.c
index a59ae9439d..1009eab92d 100644
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
@@ -387,6 +388,15 @@ static void handle_arg_trace(const char *arg)
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
@@ -438,6 +448,10 @@ static const struct qemu_argument arg_table[] = {
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
@@ -628,6 +642,7 @@ int main(int argc, char **argv, char **envp)
     cpu_model = NULL;
 
     qemu_add_opts(&qemu_trace_opts);
+    qemu_plugin_add_opts();
 
     optind = parse_args(argc, argv);
 
@@ -635,6 +650,9 @@ int main(int argc, char **argv, char **envp)
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


