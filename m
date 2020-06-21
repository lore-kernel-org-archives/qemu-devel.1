Return-Path: <SRS0=M+f9=AC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB2C3C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2020 16:35:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA0942078E
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2020 16:35:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JHa0a7Rt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA0942078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jn2wZ-0007YC-T1
	for qemu-devel@archiver.kernel.org; Sun, 21 Jun 2020 12:35:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52624)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noh4hss@gmail.com>) id 1jn2jm-0006oM-HQ
 for qemu-devel@nongnu.org; Sun, 21 Jun 2020 12:22:30 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:39411)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <noh4hss@gmail.com>) id 1jn2jk-0007y5-RX
 for qemu-devel@nongnu.org; Sun, 21 Jun 2020 12:22:30 -0400
Received: by mail-lf1-x141.google.com with SMTP id d21so6150543lfb.6
 for <qemu-devel@nongnu.org>; Sun, 21 Jun 2020 09:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IEq/0MOxjv3VFOKWXkmTsGCVmogmJmtEdGRs+jHMXjw=;
 b=JHa0a7RtIvGTH04Mx/wdFaOFP6HP8n5TGTfaM/T1khOVEKGx0OutBcrW5wEs6NLNOR
 Oz+1CgOTtFtsoWz03AcoYlzefkVBmuo8WjPmSs+Ekl57gjGAZx6OqDyAT682CkEEiBgT
 TEnDhkVKh9jgcBI/Ur7/n+m9togLJ8JNTAh0oT2dF0uq+c4pzFDtp9/sfgexvxCH1YD/
 UHNmVNsOzjPY+ygCaXQgkRZT4Vo9HOrmJZ4C7dyinZsq0laYPy63Dej4bn7RdZi/jKAx
 Oj5x+4K9nvn7PVgB04gGwGY4XgpmjH+C43bwRHkgz9IOyWTfHH6Juzqjvp6VfNXh3Yt4
 Fhag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IEq/0MOxjv3VFOKWXkmTsGCVmogmJmtEdGRs+jHMXjw=;
 b=hMLvwv1Wi2IrkmuGmAOs6fhcBsRYC55ZNy2v2pil43TQTRt4tMKOPUdN20y6k9ukzN
 MqgjpfXMNfnRK1mgQcaxVH5QwDRF0+kite6pdbGLdM8JXFsMatKMjldyV58qcuJddrfz
 dRiZrItUaUNZct01KZvYTRMdTXYDlz77bajRx00eEZX8/aQOEVZr/9zVxGfeKgHGiIMV
 QmQxiyljpPUQyZ3TaK+e0r/regvX+tXfwKLwAFIfzUFD2j4huWzNvuH244BrkxJvcbCT
 z1tTt//M1d+56y1EjGzgrcQybze1vxz7ka9EE3qoCxoPv0feesDFBCwOtsakRhcG/h4q
 cghQ==
X-Gm-Message-State: AOAM533pOw/Rld4RMoYHEmse8CPpZLGYF8Op4QHH8kn7JfEQFu9J2mPv
 iFSx62sVTJjlmvSuqubw/lq+QZzowqghLw==
X-Google-Smtp-Source: ABdhPJzX5BqFUfR4aULh0LWn1LwNtQo6oMqzC9MFspMJpEYEDSb54NLlNv+cQMPlbpwG+CCc2EWMVg==
X-Received: by 2002:a19:7014:: with SMTP id h20mr7293458lfc.49.1592756547093; 
 Sun, 21 Jun 2020 09:22:27 -0700 (PDT)
Received: from localhost.localdomain (193-239-39-51.ksi-system.net.
 [193.239.39.51])
 by smtp.gmail.com with ESMTPSA id k7sm2822838lfd.67.2020.06.21.09.22.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jun 2020 09:22:26 -0700 (PDT)
From: Szymon Lukasz <noh4hss@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/6] char-stdio: add support for the terminal size
Date: Sun, 21 Jun 2020 18:21:30 +0200
Message-Id: <20200621162132.62797-5-noh4hss@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200621162132.62797-1-noh4hss@gmail.com>
References: <20200621162132.62797-1-noh4hss@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::141;
 envelope-from=noh4hss@gmail.com; helo=mail-lf1-x141.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 21 Jun 2020 12:30:17 -0400
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
Cc: lvivier@redhat.com, amit@kernel.org, mst@redhat.com,
 Szymon Lukasz <noh4hss@gmail.com>, marcandre.lureau@redhat.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Implement chr_get_winsize for the stdio backend
and trigger CHR_EVENT_RESIZE upon SIGWINCH delivery.

Signed-off-by: Szymon Lukasz <noh4hss@gmail.com>
---
 chardev/char-stdio.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/chardev/char-stdio.c b/chardev/char-stdio.c
index 82eaebc1db..ab14edffc1 100644
--- a/chardev/char-stdio.c
+++ b/chardev/char-stdio.c
@@ -34,7 +34,9 @@
 #include "chardev/char-win-stdio.h"
 #else
 #include <termios.h>
+#include <sys/ioctl.h>
 #include "chardev/char-fd.h"
+#include "qemu/main-loop.h"
 #endif
 
 #ifndef _WIN32
@@ -45,6 +47,13 @@ static bool stdio_in_use;
 static bool stdio_allow_signal;
 static bool stdio_echo_state;
 
+typedef struct {
+    FDChardev parent;
+    Notifier resize_notifier;
+} StdioChardev;
+
+#define STDIO_CHARDEV(obj) OBJECT_CHECK(StdioChardev, (obj), TYPE_CHARDEV_STDIO)
+
 static void term_exit(void)
 {
     if (stdio_in_use) {
@@ -82,11 +91,31 @@ static void term_stdio_handler(int sig)
     qemu_chr_set_echo_stdio(NULL, stdio_echo_state);
 }
 
+static int qemu_chr_get_winsize_stdio(Chardev *chr, uint16_t *cols, uint16_t *rows)
+{
+    struct winsize ws;
+
+    if (ioctl(1, TIOCGWINSZ, &ws) < 0) {
+        return -1;
+    }
+
+    *cols = ws.ws_col;
+    *rows = ws.ws_row;
+    return 0;
+}
+
+static void term_resize_notify(Notifier *n, void *data)
+{
+    StdioChardev *s = container_of(n, StdioChardev, resize_notifier);
+    qemu_chr_be_event(CHARDEV(s), CHR_EVENT_RESIZE);
+}
+
 static void qemu_chr_open_stdio(Chardev *chr,
                                 ChardevBackend *backend,
                                 bool *be_opened,
                                 Error **errp)
 {
+    StdioChardev *s = STDIO_CHARDEV(chr);
     ChardevStdio *opts = backend->u.stdio.data;
     struct sigaction act;
 
@@ -116,6 +145,9 @@ static void qemu_chr_open_stdio(Chardev *chr,
         stdio_allow_signal = opts->signal;
     }
     qemu_chr_set_echo_stdio(chr, false);
+
+    s->resize_notifier.notify = term_resize_notify;
+    sigwinch_add_notifier(&s->resize_notifier);
 }
 #endif
 
@@ -139,6 +171,7 @@ static void char_stdio_class_init(ObjectClass *oc, void *data)
 #ifndef _WIN32
     cc->open = qemu_chr_open_stdio;
     cc->chr_set_echo = qemu_chr_set_echo_stdio;
+    cc->chr_get_winsize = qemu_chr_get_winsize_stdio;
 #endif
 }
 
@@ -155,6 +188,7 @@ static const TypeInfo char_stdio_type_info = {
     .parent = TYPE_CHARDEV_WIN_STDIO,
 #else
     .parent = TYPE_CHARDEV_FD,
+    .instance_size = sizeof(StdioChardev),
 #endif
     .instance_finalize = char_stdio_finalize,
     .class_init = char_stdio_class_init,
-- 
2.27.0


