Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF92C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 14:06:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08897207D8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 14:06:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zat6Fl/T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08897207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joozq-000082-7w
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 10:06:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43440)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jooxi-000610-2b; Fri, 26 Jun 2020 10:04:14 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:45924)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jooxg-0004Oa-ED; Fri, 26 Jun 2020 10:04:13 -0400
Received: by mail-ed1-x541.google.com with SMTP id d16so382337edz.12;
 Fri, 26 Jun 2020 07:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=XA6nzqvVSiJXdseQ/eelzB9rYtYWuwUACPaHWj97sq4=;
 b=Zat6Fl/TI+4DSV/Cxfjj3oMu5Kzn+P5tnqLFexKsqd3B6D9jMFA4zHodLgOfu294VK
 TzylrYLx/+Jsc12OUnmGEQcxtqzBspgzAI8EW+XlZ0ou4ImC+hh97ywJwJscOXLOqgK+
 FDCG8tZgUI/kS8yvKKVw+CzMzM84rxvva3VIPwgyck1Zj57TRZF1Q4tgE8CPLa32DaKK
 eyovMpv5gH32NQ2aRCjDXgCo4hI9t1sUPhALVVh5MLQao5OC6Tt0/Y2FD5UxzP+MbPgT
 HcZdG9UZbuQs4dKFjazaNPOY8rsUj3Kk10q62hY4Qx6ToES8egwcoTlXI7X2MIL1yWTj
 nRvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=XA6nzqvVSiJXdseQ/eelzB9rYtYWuwUACPaHWj97sq4=;
 b=R52Rg+v2Y2e2XajpeUybirZw62k4uG8b6E5G1EhPqs6bnECs0xFdAiFt63vjzRueG+
 BqO/FkKkPG26dLrc2QFb9MBcEEAJXM2boDqI2wz15VhsVzdOA3jbcqIBdCWUqiHydHJW
 xwkdEg3i+8UcqsWK9GsS5Mjaevbsm3JII8T7eXG/O44hjhHtal2Ghl+cjRW9a6nrfOkb
 zLBcV4t1/sUkq6tIt7hQ45nBhQRNTT3x7jDtvEY/o8kVk/RtsiPOS4udFXi9gIV/nx35
 /Zf8P4eNHqMFJ3YPMSPNZL5nPnRaipz22OMk14fX1kvoyEBZLbH6F0hD2qiom6vMVpqd
 csOQ==
X-Gm-Message-State: AOAM53018m5dTXIkZLUBpZ4d7/BgSKIpcrkfV0aP6PoLxAva/Vgw6ELI
 XzzUgDV2ht4ffSYqsT+yjKE+e/77GZpMbYz0rj4Lle7kwsosIA==
X-Google-Smtp-Source: ABdhPJzWKvHq/Cl2NaRCRxA4MJm7SQFp/zQXc5xszIFwcqpe6SBj9Hyj3V29e8E4k4vVIiAqc/Km9BEodJul7+G8REA=
X-Received: by 2002:a05:6402:354:: with SMTP id
 r20mr1966454edw.32.1593180250270; 
 Fri, 26 Jun 2020 07:04:10 -0700 (PDT)
MIME-Version: 1.0
From: David CARLIER <devnexen@gmail.com>
Date: Fri, 26 Jun 2020 15:03:59 +0100
Message-ID: <CA+XhMqyPnFEuD39ZiFcs5qNkR9sEUcXPVe_bzV9WRzTn0tzfxw@mail.gmail.com>
Subject: [PATCH 3/3] qemu_init_exec_dir Haiku implementation
To: QEMU Trivial <qemu-trivial@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=devnexen@gmail.com; helo=mail-ed1-x541.google.com
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

From 6fa7a4108236f513201192654e07c7044a3d7e58 Mon Sep 17 00:00:00 2001
From: David Carlier <devnexen@gmail.com>
Date: Fri, 26 Jun 2020 13:51:37 +0000
Subject: [PATCH 3/3] qemu_init_exec_dir Haiku implementation

Signed-off-by: David Carlier <devnexen@gmail.com>
---
 util/oslib-posix.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 7ad9195c44..459e3f8093 100644
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
+    image_info ii;
+    int32_t c = 0;
+
+    *buf = '\0';
+    while (get_next_image_info(0, &c, &ii) == B_OK) {
+            if (ii.type == B_APP_IMAGE) {
+                strncpy(buf, ii.name, sizeof(buf));
+        buf[sizeof(buf) - 1] = 0;
+        p = buf;
+        break;
+            }
+        }
+    }
 #endif
     /* If we don't have any way of figuring out the actual executable
        location then try argv[0].  */
-- 
2.26.0

