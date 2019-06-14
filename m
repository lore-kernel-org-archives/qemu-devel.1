Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7776C31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 18:23:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97FD52177E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 18:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jPANe3ZR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97FD52177E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54076 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbqrB-00048T-Tv
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 14:23:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34112)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hbq0M-00076s-BD
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:28:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hbq0J-00042r-Er
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:28:44 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:53325)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hbq0H-0003xQ-Q8
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:28:42 -0400
Received: by mail-wm1-x342.google.com with SMTP id x15so3158427wmj.3
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 10:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Qg44j1/fmT2WZWQwTd6B39K1u36F6LVDpErcGgO7T1Y=;
 b=jPANe3ZRmE/XYvdJ91iBIjo0AzjtFtvfz2kqeTbd4VE8uTA9DM+g5Q5SdeOKOGMVyW
 Ral1s4CzaK4ijK90X/2ALR9rWxVxERMcgmy3iwB+J4PyFzeUpCpW93UC/6CUJjiy6z6T
 YLtI9wktTl8mXA781TPfMZAevztaFPnJq79Ni/2T57/mqslcKH8kPvp25B55C99VprZp
 fi5l0KqCoi8r0JcuuD2vJZnpeZCuRH/LWavGuyhwvsXILgdwnv2VKEfgRxEZma0MN8ML
 tEd1iIQOmghgpjFJVWuPTzgtBW0UOT4VE4PtcKtIl8H9PhowfARMBjCiU4DVcF/KZp2c
 LDbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Qg44j1/fmT2WZWQwTd6B39K1u36F6LVDpErcGgO7T1Y=;
 b=N74qB3sBVQ1W+TSt/931fjHBhe/l+H5guGnjCK9vXCJHeY6CY1jT1KlIxhIGJzhBUD
 cdE5oU2Rd5y19mhupnmsMVoHbD/Pn9RN4NkPJeqEKJWwUk+MniMn5MMrvE4sfaFwUKHJ
 b5Gq0g321vgLlkbtRCAQJYy8Qq/jwTEcNBh3BXmCNBRFCn2RTZ/2xUuYtlbqraN93VNk
 EakA1T5LPmCxUbuH4E4zRof8N+1tssaxCSr/DlLYcloK3IwqAg8vwCacDFsqE47YyLbP
 ItCxHE61HuF0EZu/RSLKWPTgYWY9EN4SXajxo9B1NqnpbvQz/By3afwzV9wdMMDrKqO2
 ivYg==
X-Gm-Message-State: APjAAAXF8r/TXuIXpPoibZCRvpu9LAna/cHT1hoHhDqZz0mYSd9yO7J/
 6Hd+YTtyS6ROCS516mbqgJfaDQ==
X-Google-Smtp-Source: APXvYqwwNF2M+YYJZsJMY/VEd12uNEYgIdt/dZg0hAEOwxtUSHVcWh9xXXMqaCtX65dWo1r7QZxz/A==
X-Received: by 2002:a1c:730d:: with SMTP id d13mr8510608wmb.88.1560533318979; 
 Fri, 14 Jun 2019 10:28:38 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id l8sm9147766wrg.40.2019.06.14.10.28.32
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 14 Jun 2019 10:28:36 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E99341FFBE;
 Fri, 14 Jun 2019 18:12:03 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 14 Jun 2019 18:11:49 +0100
Message-Id: <20190614171200.21078-40-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190614171200.21078-1-alex.bennee@linaro.org>
References: <20190614171200.21078-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH  v3 39/50] vl: support -plugin option
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Emilio G . Cota" <cota@braap.org>,
 =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Lluís Vilanova <vilanova@ac.upc.edu>

Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>
[ cota: s/instrument/plugin ]
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 qemu-options.hx | 17 +++++++++++++++++
 vl.c            | 11 +++++++++++
 2 files changed, 28 insertions(+)

diff --git a/qemu-options.hx b/qemu-options.hx
index 0d8beb4afd..47bbf358db 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4130,6 +4130,23 @@ HXCOMM HX does not support conditional compilation of text.
 @findex -trace
 @include qemu-option-trace.texi
 ETEXI
+DEF("plugin", HAS_ARG, QEMU_OPTION_plugin,
+    "-plugin [file=]<file>[,arg=<string>]\n"
+    "                load a plugin\n",
+    QEMU_ARCH_ALL)
+STEXI
+@item -plugin file=@var{file}[,arg=@var{string}]
+@findex -plugin
+
+Load a plugin.
+
+@table @option
+@item file=@var{file}
+Load the given plugin from a shared library file.
+@item arg=@var{string}
+Argument string passed to the plugin. (Can be given multiple times.)
+@end table
+ETEXI
 
 HXCOMM Internal use
 DEF("qtest", HAS_ARG, QEMU_OPTION_qtest, "", QEMU_ARCH_ALL)
diff --git a/vl.c b/vl.c
index 005468cbfb..0be9667315 100644
--- a/vl.c
+++ b/vl.c
@@ -110,6 +110,7 @@ int main(int argc, char **argv)
 
 #include "trace-root.h"
 #include "trace/control.h"
+#include "qemu/plugin.h"
 #include "qemu/queue.h"
 #include "sysemu/arch_init.h"
 
@@ -2954,6 +2955,7 @@ int main(int argc, char **argv, char **envp)
     bool list_data_dirs = false;
     char *dir, **dirs;
     BlockdevOptionsQueue bdo_queue = QSIMPLEQ_HEAD_INITIALIZER(bdo_queue);
+    QemuPluginList plugin_list = QTAILQ_HEAD_INITIALIZER(plugin_list);
 
     error_init(argv[0]);
     module_call_init(MODULE_INIT_TRACE);
@@ -2982,6 +2984,7 @@ int main(int argc, char **argv, char **envp)
     qemu_add_opts(&qemu_global_opts);
     qemu_add_opts(&qemu_mon_opts);
     qemu_add_opts(&qemu_trace_opts);
+    qemu_plugin_add_opts();
     qemu_add_opts(&qemu_option_rom_opts);
     qemu_add_opts(&qemu_machine_opts);
     qemu_add_opts(&qemu_accel_opts);
@@ -3760,6 +3763,9 @@ int main(int argc, char **argv, char **envp)
                 g_free(trace_file);
                 trace_file = trace_opt_parse(optarg);
                 break;
+            case QEMU_OPTION_plugin:
+                qemu_plugin_opt_parse(optarg, &plugin_list);
+                break;
             case QEMU_OPTION_readconfig:
                 {
                     int ret = qemu_read_config_file(optarg);
@@ -4068,6 +4074,11 @@ int main(int argc, char **argv, char **envp)
                                machine_class->default_machine_opts, 0);
     }
 
+    /* process plugin before CPUs are created, but once -smp has been parsed */
+    if (qemu_plugin_load_list(&plugin_list)) {
+        exit(1);
+    }
+
     qemu_opts_foreach(qemu_find_opts("device"),
                       default_driver_check, NULL, NULL);
     qemu_opts_foreach(qemu_find_opts("global"),
-- 
2.20.1


