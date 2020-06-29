Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 603ACC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 00:45:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F55E206C3
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 00:45:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKOXdLhb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F55E206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jq4Ov-0003UP-CZ
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 20:45:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59996)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jq1dv-0007jp-Ew; Mon, 29 Jun 2020 17:48:47 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:42442)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jq1dt-00088g-QD; Mon, 29 Jun 2020 17:48:47 -0400
Received: by mail-ej1-x642.google.com with SMTP id i14so18367516ejr.9;
 Mon, 29 Jun 2020 14:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=7jJjssFU/PP2r5mJjLoPZrHhXjRyO0Aifak5gnKePUM=;
 b=kKOXdLhbX1+OtsYdNpmm/cgz0Ks+YNFM1H0aSO52Ay9yIDpbiB2cugthYA8zMXc5t8
 ORn5ECnaMOl687qpUHQ2fzgly0pKdYiykVV6loqhsmNlK9MT+jx0u3ovOmSsDZfPo887
 C1zuiwjjnoNZZsaQrAPmysbTRz/tH1+2fhOHFWLBkNEfn3D0iYzOphR8FMeNXPs5Jryd
 8MejH84aufGOi5uWxJdOF9QBnMpPxrelCJl6w1h/IgF1hT8OBh5SVMGoA2oHX3C9YvYX
 CTMrDXEVZkiVUwYe1U1nE8qzJrnewFJtGFT7ly6f5WiC622a2ZT5f2jzd6omgvFJnbjB
 Jyzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=7jJjssFU/PP2r5mJjLoPZrHhXjRyO0Aifak5gnKePUM=;
 b=GPawDCT9G4fsK0xHtWeFWpjaGQGJYV3C87H2RXF5OH7eqytT8tGEVAAnoiLVx/U9WB
 JgttaO2RYpEX0CS++ScSvz0Jr+oWAnZicMErBkIfKJ3d2xtozdI2+hGWFz9dG0pe/6Ti
 uHsaG3hZn/QvLNjioiPUD7g5q8ura2slXgQ50QauYZIjNt0J3rNi3F92mRQMaId5/+B9
 oW8EOX/Pbct6u2eZdxxU38KA1DK4AFLXQ5R0Y79xGhFpv9TY0GUs94+3W2pJobD6CInF
 nHQRW6jn4DnlR/nzT/LHmOSrNs5tDyNrw0m6+E3yAsE5XkNRC2EZTr3Pd9S8a0YI/2ZR
 JVtA==
X-Gm-Message-State: AOAM530TjNTThhpEI9g2NjCdSFtJu+K5q+D83qiPDER95BL6sUWkLVpg
 jLDk3ELHJkfWnEvLjldYkggjttK/Cx3pDBKbsz8N1uG21Ho=
X-Google-Smtp-Source: ABdhPJwuBnm2oXTS3y7yncphMNAvb1eBjmctU/sgHxhlTUVu2pF8rezUuIXJ0FvDzTFYFJiSRpDfsymHcIyzLJHxZQ0=
X-Received: by 2002:a17:907:100a:: with SMTP id
 ox10mr15206686ejb.351.1593467323961; 
 Mon, 29 Jun 2020 14:48:43 -0700 (PDT)
MIME-Version: 1.0
From: David CARLIER <devnexen@gmail.com>
Date: Mon, 29 Jun 2020 22:48:33 +0100
Message-ID: <CA+XhMqzmb0K5HaOBNy31rNU0F0O4kq+B6eeYCUXiJJE6ENDsYw@mail.gmail.com>
Subject: [PATCH 9/9] Implementing qemu_init_exec_dir.
To: QEMU Trivial <qemu-trivial@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=devnexen@gmail.com; helo=mail-ej1-x642.google.com
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
X-Mailman-Approved-At: Mon, 29 Jun 2020 20:42:18 -0400
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

From fcdb25804af98329b52a04e7a4e5191135aac4f6 Mon Sep 17 00:00:00 2001
From: David Carlier <devnexen@gmail.com>
Date: Mon, 29 Jun 2020 22:36:03 +0000
Subject: [PATCH 9/9] Implementing qemu_init_exec_dir.

Signed-off-by: David Carlier <devnexen@gmail.com>
---
 util/oslib-posix.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 7ad9195c44..72907d4d7f 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -60,6 +60,10 @@
 #include <mach-o/dyld.h>
 #endif

+#ifdef __HAIKU__
+#include <kernel/image.h>
+#endif
+
 #include "qemu/mmap-alloc.h"

 #ifdef CONFIG_DEBUG_STACK_USAGE
@@ -389,6 +393,21 @@ void qemu_init_exec_dir(const char *argv0)
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
+                buf[sizeof(buf) - 1] = 0;
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

