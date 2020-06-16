Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DBF0C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 18:40:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA1012082E
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 18:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ERbJ1zIs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA1012082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlGVU-0001Dt-8w
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 14:40:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39076)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jlGUh-0000Xh-F9; Tue, 16 Jun 2020 14:39:35 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:36325)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jlGUf-0006qF-Vq; Tue, 16 Jun 2020 14:39:35 -0400
Received: by mail-ej1-x644.google.com with SMTP id dr13so22668429ejc.3;
 Tue, 16 Jun 2020 11:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=gpT7+Cr3taESxYqh6JYHpGHEka5gVPb3m/3xE68Bsi4=;
 b=ERbJ1zIs/4NS09/yv2EeZFEPxUoAVUYh3n3uu3En5mJImJu/XwVytpyN9uQ0uQH1LV
 Wn/A/MiKvXKqYOIchMB2VAaDFbUYSlng/G4Jd0UC/lrcwLww2StybyS5tZc8CcZGa29F
 BET3I2CjgMIpUPkmBv84bpmFf7NkxCFeF+ehbxpXv7dpnlGn4gkI5HMSxoW4QWGPNCWM
 Yk9c7Dt6S2vjgGi3bD0jxQbtJ3Biujeh6qN9YbWYppXRtOC2k/XbMOKY2Gla0Lb52scM
 plv0HsoJTt/XgeosTED0YcqmVOeBwwVKZhwlx275aADitFDOBosH5J583m+kseFUaZua
 aEOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=gpT7+Cr3taESxYqh6JYHpGHEka5gVPb3m/3xE68Bsi4=;
 b=UdeX8j1b5PGPwSM7jyhLtAcCCCnbqS5etaOdngq32071P8DGHFuwMlTgQVJxOxWCos
 YrCJIhekApsBb85qdw1A8+aIJwhi+TDjEOEryqtgYbSra7+cdkrl1+hJRfztX1O8RGcU
 8HX8SjIvbzINCATjZ7R3b0bgbe6I/PpWTO79NC/tEkD4oxwuI0BOWjNmmlKnBy4/2BZK
 gAY3uG8VTO+4zYW58MBAWVHB9qnDFjdhy8Kuv+4lapkqNH/S8ru2F73Sad0sCjuOsnLl
 oD6r/XkvCHj5ZGKdc7w7+U5RsxbBKb+8XE3+nO6AjN8KoDLjHIuCaATScfjN64wNiXhf
 sdIA==
X-Gm-Message-State: AOAM530T31oTujAI0Q22CCRdt5LZB+6WCg+OkYl5LjW5omnYNX6kiCzq
 sBavncps88oz+dQFl2hyDKa1ySagDqeapCzpNE6YwKGNb20=
X-Google-Smtp-Source: ABdhPJxNnGZVT5KOGhQa/QtlNgyY37Kx8jFy6SPQMrYjJtEtgv5eEOyZLk0ndlAxJxpqQoC0GRbHnoMzevonwrEUQ7w=
X-Received: by 2002:a17:906:5203:: with SMTP id
 g3mr3971983ejm.58.1592332771431; 
 Tue, 16 Jun 2020 11:39:31 -0700 (PDT)
MIME-Version: 1.0
From: David CARLIER <devnexen@gmail.com>
Date: Tue, 16 Jun 2020 19:39:20 +0100
Message-ID: <CA+XhMqxwC10XHVs4Z-JfE0-WLAU3ztDuU9QKVi31mjr59HWCxg@mail.gmail.com>
Subject: [PATCH V5] util/oslib-posix : qemu_init_exec_dir implementation for
 Mac
To: QEMU Trivial <qemu-trivial@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=devnexen@gmail.com; helo=mail-ej1-x644.google.com
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

From 3025a0ce3fdf7d3559fc35a52c659f635f5c750c Mon Sep 17 00:00:00 2001
From: David Carlier <devnexen@gmail.com>
Date: Tue, 26 May 2020 21:35:27 +0100
Subject: [PATCH] util/oslib-posix : qemu_init_exec_dir implementation for Mac

Using dyld API to get the full path of the current process.

Signed-off-by: David Carlier <devnexen@gmail.com>
---
 util/oslib-posix.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 916f1be224..39ddc77c85 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -57,6 +57,10 @@
 #include <lwp.h>
 #endif

+#ifdef __APPLE__
+#include <mach-o/dyld.h>
+#endif
+
 #include "qemu/mmap-alloc.h"

 #ifdef CONFIG_DEBUG_STACK_USAGE
@@ -375,6 +379,17 @@ void qemu_init_exec_dir(const char *argv0)
             p = buf;
         }
     }
+#elif defined(__APPLE__)
+    {
+        char fpath[PATH_MAX];
+        uint32_t len = sizeof(fpath);
+        if (_NSGetExecutablePath(fpath, &len) == 0) {
+            p = realpath(fpath, buf);
+            if (!p) {
+                return;
+            }
+        }
+    }
 #endif
     /* If we don't have any way of figuring out the actual executable
        location then try argv[0].  */
-- 
2.27.0

