Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E21C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 19:44:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C69DA22B51
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 19:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="meN6JdkM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C69DA22B51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvQrB-0001Ya-4N
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 15:44:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50582)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jvQqY-00011V-Am; Tue, 14 Jul 2020 15:44:10 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:39478)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jvQqW-0000W4-Rq; Tue, 14 Jul 2020 15:44:10 -0400
Received: by mail-ed1-x541.google.com with SMTP id d18so19150277edv.6;
 Tue, 14 Jul 2020 12:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=zCdZu/DdWBzf+eU9SOeiPxUe+cDs7+crVc5jMBJ3Cs0=;
 b=meN6JdkMVECqwmUEBEF97P6bGUn4o7b2irrjqqKyrZUHmiE4lSfplZpZMHkcYjuhhY
 H1qWUCKsc3uDMLwzCJlke7CXtuBV0OF2sA+Cl53w+hwavMx6MJH20q4gmac9xn31KMjE
 2vQvYuTK7RY7/kgSQaHuxDOpyRdRtn52nmnBO4rZEYnzASBkFhvE31Eyt7MV0Nh2dX4o
 A5KcZAcSebur2WOMDYwfzbvwETJdv63LIaYS3G/2H7EAd3f/FJi610GXwILakJMBuliG
 0ziVp/RPH4wW3D/mKuHkSG2Sd+p7C5hKjGvOZ5tJBucGX117MRyBjVQjYC3XDhOolVdS
 Pjkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=zCdZu/DdWBzf+eU9SOeiPxUe+cDs7+crVc5jMBJ3Cs0=;
 b=QWz5jADiptOMscXZ51caJOJ8ypL4cW6w6Q+XFdzp4CkhuDvyzgEvqBt6Vg1DonIUsx
 ZS4KJFAwsaZ5g8H7ozqBab0P+oaChObXhw5D9e3odevO9KZ1oWVQHbpEcAgGHU3qCXii
 FycSBkaIIiVmC73kXY01yINdYr1sn9f4DI4o0wEIcR+JnXG9ufyizQH1qqDZ14ZQNyzQ
 uqZ1yOF3iNBoZWBkvdZ8x4gUG88kv/X1LpU47jECG7akaTxjdMR86yw0nAwTP3XxruwB
 En38t23nDtM2RKHwj6a6zhOdpqWxNYnlpJb5MQ8dlHjBJYd0+rM5SZhwSrZPBgnLQAXG
 BPyw==
X-Gm-Message-State: AOAM5338x5OLeGjJrRfvXht3gzE9iRO1GKnWpcCG7BKiTbbptS8E8jkC
 f2t2d69PgFxND2g7Rz6bXXH28euf0N4nnxSJWuZ4z2DQ7s4=
X-Google-Smtp-Source: ABdhPJwBT8qfAy3CndbvOIqF08fzQi+jYPeRrvuDflhKUDXiDMwGnKa5mgh2C3ubN6WAH4N/7iLAKhA0Rn28sTF/ZV4=
X-Received: by 2002:a05:6402:354:: with SMTP id
 r20mr6524594edw.32.1594755846117; 
 Tue, 14 Jul 2020 12:44:06 -0700 (PDT)
MIME-Version: 1.0
From: David CARLIER <devnexen@gmail.com>
Date: Tue, 14 Jul 2020 20:43:55 +0100
Message-ID: <CA+XhMqwMKk1eCNg-T15KRAa_e1-r0cmZ49f-135sppTFWpTerQ@mail.gmail.com>
Subject: [PATCH v1] util: OpenBSD build fix
To: qemu-devel <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From e2103b86b031ab74ff4c8dd0a3944cb488c9333e Mon Sep 17 00:00:00 2001
From: David Carlier <devnexen@gmail.com>
Date: Tue, 14 Jul 2020 21:34:59 +0100
Subject: [PATCH] util: OpenBSD build fix.

thread id implementation, using getthrid syscall.
qemu_exec_dir implementation as beast as we can as
path is not always possible to resolve this on this platform.

Signed-off-by: David Carlier <devnexen@gmail.com>
---
 util/oslib-posix.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 72907d4d7f..4a0cce15b4 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -56,6 +56,10 @@
 #include <lwp.h>
 #endif

+#ifdef __OpenBSD__
+#include <sys/sysctl.h>
+#endif
+
 #ifdef __APPLE__
 #include <mach-o/dyld.h>
 #endif
@@ -100,6 +104,8 @@ int qemu_get_thread_id(void)
     return (int)tid;
 #elif defined(__NetBSD__)
     return _lwp_self();
+#elif defined(__OpenBSD__)
+    return getthrid();
 #else
     return getpid();
 #endif
@@ -408,6 +414,23 @@ void qemu_init_exec_dir(const char *argv0)
             }
         }
     }
+#elif defined(__OpenBSD__)
+    {
+
+        char **args;
+        size_t len;
+        int mib[4] = {CTL_KERN, KERN_PROC_ARGS, getpid(), KERN_PROC_ARGV};
+
+        *buf = 0;
+        if (!sysctl(mib, ARRAY_SIZE(mib), NULL, &len, NULL, 0)) {
+            args = malloc(len);
+            if (!sysctl(mib, ARRAY_SIZE(mib), args, &len, NULL, 0)) {
+                p = realpath(*args, buf);
+            }
+
+            free(args);
+        }
+    }
 #endif
     /* If we don't have any way of figuring out the actual executable
        location then try argv[0].  */
-- 
2.27.0

