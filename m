Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE07FA372A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 14:43:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 175EB21A4C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 14:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xx9cw4yu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 175EB21A4C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL70P-0005Jh-25
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 10:43:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37547)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iL5wB-0005zP-4N
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:35:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iL5w9-0004SH-2V
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:35:30 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:45501)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iL5w7-0004Qy-2Q
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:35:28 -0400
Received: by mail-wr1-x441.google.com with SMTP id r5so2365609wrm.12
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 06:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wXzF3UTyYexiGoLPILzFIA+g87jBMrJCBXwgiVbZAdU=;
 b=Xx9cw4yu1TSSeSMg8VZlvM353VSsXYztlUJMW5eYaIusRFClRVHACQt23jC7UjXfQF
 OgIVA37dqY8NFY7FcQRUtdRHsil4FZFgOHXrTrM0Fhvfb5CqyYmI86TcWP9PNSDhn+Xv
 EVZwNxPJQUuo9bSy68nPXw3sr2v0ZuUyYx8hxIjndHXXnmgiO7Vm5d91jEEf26Nvoyov
 GnhHbGI9K3turwctXPPfmUWvfwAWA0VVuyIwQYF4G12iy4CwMTlHAyazjvoXTt/WjtbN
 TwqdHTa7ax9ZEtiTL2GI6Vas+nIC3DwjLEWUYrpyCe4Hdyi77JwBe02ota69OGmn03lN
 mW2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wXzF3UTyYexiGoLPILzFIA+g87jBMrJCBXwgiVbZAdU=;
 b=LeaYGGZp4/AHWW2x2q4UsqoN1D0+LCYTbJZuz6Azf3c5suYZozDeq1RNFS5bGT8lgc
 5YgftKZcd74yqZKTMbKokB8mJpKeNlU1yQRCPgcIDyR+FXMNX5ndVf7whmWLesg/B7UT
 NSpf9NhrqqjmwF0HDR+l0v50Zox5dUBFyb3pw93vDtIiOhnY20vXOdqrU4UeB6Hkvwey
 3s7r/Pp8/pGlZoxtBQpe2kRWIyTlRCePrihX5XHA6Iz1p6eXoCWyt3dZM071V8USVTaj
 SYQYcbSwFaH+9rkesuDbH/g2nYbgfJvSlCQv2PV8isw8FpSJ+Cs6Fuh9TBaw7XeO7NpG
 5DAA==
X-Gm-Message-State: APjAAAXfBYl9/DJmT3Hlso5zON3QjPtt/FHd5mlotLNEGP/DzisveM7S
 UE4P0435D4x91e5ek0de/vICkw==
X-Google-Smtp-Source: APXvYqzNxcTKtf5dRVM9IAkZCZbZySGiOaAbpb/wC2yg6LnyvMBFYcVCYSGj/bgJ7vdtyecu3qZLlw==
X-Received: by 2002:a5d:68c7:: with SMTP id p7mr3056653wrw.156.1571319324766; 
 Thu, 17 Oct 2019 06:35:24 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d11sm2248332wrf.80.2019.10.17.06.35.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 06:35:21 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A87761FFBF;
 Thu, 17 Oct 2019 14:16:19 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v6 40/54] vl: support -plugin option
Date: Thu, 17 Oct 2019 14:16:01 +0100
Message-Id: <20191017131615.19660-41-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191017131615.19660-1-alex.bennee@linaro.org>
References: <20191017131615.19660-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: robert.foley@futurewei.com,
 Richard Henderson <richard.henderson@linaro.org>, peter.puhov@futurewei.com,
 aaron@os.amperecomputing.com, cota@braap.org,
 Paolo Bonzini <pbonzini@redhat.com>,
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
 qemu-options.hx | 17 +++++++++++++++++
 vl.c            | 11 +++++++++++
 2 files changed, 28 insertions(+)

diff --git a/qemu-options.hx b/qemu-options.hx
index 793d70ff93..37f13689e7 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4166,6 +4166,23 @@ HXCOMM HX does not support conditional compilation of text.
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
index 4489cfb2bb..8b1b4133e4 100644
--- a/vl.c
+++ b/vl.c
@@ -110,6 +110,7 @@ int main(int argc, char **argv)
 
 #include "trace-root.h"
 #include "trace/control.h"
+#include "qemu/plugin.h"
 #include "qemu/queue.h"
 #include "sysemu/arch_init.h"
 
@@ -2854,6 +2855,7 @@ int main(int argc, char **argv, char **envp)
     bool list_data_dirs = false;
     char *dir, **dirs;
     BlockdevOptionsQueue bdo_queue = QSIMPLEQ_HEAD_INITIALIZER(bdo_queue);
+    QemuPluginList plugin_list = QTAILQ_HEAD_INITIALIZER(plugin_list);
 
     os_set_line_buffering();
 
@@ -2884,6 +2886,7 @@ int main(int argc, char **argv, char **envp)
     qemu_add_opts(&qemu_global_opts);
     qemu_add_opts(&qemu_mon_opts);
     qemu_add_opts(&qemu_trace_opts);
+    qemu_plugin_add_opts();
     qemu_add_opts(&qemu_option_rom_opts);
     qemu_add_opts(&qemu_machine_opts);
     qemu_add_opts(&qemu_accel_opts);
@@ -3678,6 +3681,9 @@ int main(int argc, char **argv, char **envp)
                 g_free(trace_file);
                 trace_file = trace_opt_parse(optarg);
                 break;
+            case QEMU_OPTION_plugin:
+                qemu_plugin_opt_parse(optarg, &plugin_list);
+                break;
             case QEMU_OPTION_readconfig:
                 {
                     int ret = qemu_read_config_file(optarg);
@@ -3991,6 +3997,11 @@ int main(int argc, char **argv, char **envp)
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


