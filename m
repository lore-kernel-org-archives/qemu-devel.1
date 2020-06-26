Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B7A7C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 10:09:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 476C3206C0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 10:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m3hA3mas"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 476C3206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jolIC-0002B1-Hu
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 06:09:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35454)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jolHF-0000yC-B6; Fri, 26 Jun 2020 06:08:09 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:45233)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jolHD-0005u8-Pi; Fri, 26 Jun 2020 06:08:09 -0400
Received: by mail-ed1-x543.google.com with SMTP id t21so6451872edr.12;
 Fri, 26 Jun 2020 03:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=co7casgS8A7yMr6HsfA6ziD3K+HGB0wo6n/jnkFdF6c=;
 b=m3hA3masDltAUq+qQwZlFD/7Vhlw3KGS4KV9ATqlH7BZgfYKctzeZwrO5+pUSDNWxQ
 b8FRT3e28eLxCVdQKx9lkjI9jmVpmLG7t7RPYpkLpzh5PlSkF75nt+ovLpiOqMUfO/0o
 q+DUUBK6eXRU8Y8WCIJh5lbkUASpFXHBfiDOLGMk8pQFl6WZXmO99+zCOJd6XrK66tpG
 f6t1jVMjnD6qz11aqiBFc7SeRDq3kYgZ+DFuQdgSjXZ0A3ygGmaXrs1JdXQqvlTni3jt
 Uk6SuTZk6+Ow27wX/ewVhC6v4Cb8spnucwpDW88iAbyfUrRt6RbDZED7V0BP6pXV26d1
 5+Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=co7casgS8A7yMr6HsfA6ziD3K+HGB0wo6n/jnkFdF6c=;
 b=TGr/EzIYX7tUzrdDLawRj8KchkafVrqms6ofoUush5CfE+FacTmR+Orz6hAeKDdw2W
 epVrIGQfFY0LXA+907tZy7FfGyLUg2Es+MfU3xP+IICiTCj7Lw8J/G3RPWIoMsZW+j0v
 MtlniGlN0TxPpTVczlHiT9ZDFxmiD5lqIrF/KtyNk/5Zz4zYbKyXPgSGUuXlERVZFEPj
 SIZoMFy8z1OXWcRd8JGp9euYCHcjbrp+uNtog1nHfdjSDNWteA/RLVfCYb+XyrO7p8Ct
 7oKFzMq2bt4ZDGBTIDArK9qP3bVvp0+S/7qPTiHi4SHqsHwcPAFkPL4TxIyk1KVz7WcJ
 FM3Q==
X-Gm-Message-State: AOAM533m89j+ZRFaqPiUnEMXAL58aNzgCqJLHUzBu3eExnBI3yN4fDbT
 xgdQnDnqkxajIA47x2yCfrIEw9IqN7UMGldMDnyYBy2r
X-Google-Smtp-Source: ABdhPJxfXhhdm4GIjPDxQJey8+P/V024MK7zV2ktEfJ3/HYD4ztfbKkSHMDwGCkLfBbj2ftRNeA1sxBLZU1iWkcSgGI=
X-Received: by 2002:aa7:d297:: with SMTP id w23mr2438717edq.49.1593166086030; 
 Fri, 26 Jun 2020 03:08:06 -0700 (PDT)
MIME-Version: 1.0
From: David CARLIER <devnexen@gmail.com>
Date: Fri, 26 Jun 2020 11:07:55 +0100
Message-ID: <CA+XhMqzFX3_kNmrLeuk7TCn9MQ5wwe-wWdDdWsGPBViuiHRAAg@mail.gmail.com>
Subject: [PATCH 4/5] haiku build fix
To: QEMU Trivial <qemu-trivial@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::543;
 envelope-from=devnexen@gmail.com; helo=mail-ed1-x543.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From 775173ded5657de4d4b467f2f68e747f6a9c0750 Mon Sep 17 00:00:00 2001
From: David Carlier <devnexen@gmail.com>
Date: Fri, 26 Jun 2020 10:44:36 +0000
Subject: [PATCH 4/5] Platform specific changes qemu_exec_dir implementation

Signed-off-by: David Carlier <devnexen@gmail.com>
---
 include/qemu/osdep.h |  4 ++++
 util/oslib-posix.c   | 20 ++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index ff7c17b857..da970cf654 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -388,6 +388,10 @@ void qemu_anon_ram_free(void *ptr, size_t size);
 #define HAVE_CHARDEV_PARPORT 1
 #endif

+#if defined(__HAIKU__)
+#define SIGIO SIGPOLL
+#endif
+
 #if defined(CONFIG_LINUX)
 #ifndef BUS_MCEERR_AR
 #define BUS_MCEERR_AR 4
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 39ddc77c85..ff36fa41ff 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -38,7 +38,12 @@
 #include "qemu/sockets.h"
 #include "qemu/thread.h"
 #include <libgen.h>
+#if !defined __HAIKU__
 #include <sys/signal.h>
+#else
+#include <kernel/image.h>
+#include <signal.h>
+#endif
 #include "qemu/cutils.h"

 #ifdef CONFIG_LINUX
@@ -390,6 +395,21 @@ void qemu_init_exec_dir(const char *argv0)
             }
         }
     }
+#elif defined(__HAIKU__)
+    {
+        image_info ii;
+        int32_t c = 0;
+
+        *buf = '\0';
+        while (get_next_image_info(0, &c, &ii) == B_OK) {
+            if (ii.type == B_APP_IMAGE) {
+                strncpy(buf, ii.name, sizeof(buf));
+                buf[sizeof(buf) - 1] = '\0';
+                p = buf;
+                break;
+            }
+        }
+    }
 #endif
     /* If we don't have any way of figuring out the actual executable
        location then try argv[0].  */
--
2.26.0

