Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7593C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 13:06:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B22962081A
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 13:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JcO+ii/1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B22962081A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joo42-00065k-U9
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 09:06:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52564)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jonzI-0008MB-IA; Fri, 26 Jun 2020 09:01:48 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:36858)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jonzG-0003JG-P4; Fri, 26 Jun 2020 09:01:48 -0400
Received: by mail-ed1-x544.google.com with SMTP id dg28so6858355edb.3;
 Fri, 26 Jun 2020 06:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=x+ueAwuuCoBhWE4SweeoDogBc0rLsINh3QqIieHvwp4=;
 b=JcO+ii/1+CWaULQZ2KI0lI19Lb3DI42/E5HZJn2kD2weVN8PlUMwyHnRj1dJFGWy0e
 kxIIjGAvpmZsIi7qa58OzpAaq8HlEjpq7rZflPArQUYE8E08XvlXr1GDciudNG5Anv1D
 zlFKKkmEIYYO+B40qPaC5EVJP1AYWR5GVPEFKTzoRVCJq24SRMdeE9vzlPkXFfEND9Zz
 6ytDibyz8r+SssA11b6BfwpscEaaF7oxZJMPexxXtllyGHxbfyWm3SB+h6NB6qpTHK+y
 DmuQVcGMXWxCCFSMVZFyiAdmVQLOD2rSMhl+8lEUPU742gFRpYi2gpmAxtI0UKFt6fiq
 fsqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=x+ueAwuuCoBhWE4SweeoDogBc0rLsINh3QqIieHvwp4=;
 b=DYouJ0RvS+YtEoj9/8aX2xXywHFBfNA+ymski+EUs2JuOYksW4tUCTjVsuhELgsXqM
 ND3lK2mFZKUZa2ODxDg7LKgkZmAP/feOxzRxQJ909uRI8TDHgXMUyteohu2YgS6CfK3q
 jiunWqfjMQ5aRy61cLfdXMdciNyY0kp3jVYiyhWXXsZ46a5X7bxfHta7z9oRXFY79074
 PEsnYJcoHJ6PaVZZZ/EI+LR2W/j+jmWHc5oVyykKAcbZYX9nwz9azvvInLXXaspvb+rX
 /EaWyEGeB4yQWu2LNGnTbQ7ozpKx4jfrGtAkhjill8Fv7Q0GnlGCREhOcotOJz1/5z6g
 5N7A==
X-Gm-Message-State: AOAM532cxSuSNnhljNf7HgWF+n1eBToyvVJ3tI66fP/geGZBqcG0oBef
 ISths9WWozomcD3nIBXqK9ZpPz9bHHY6eakG/1tZvpVYZ8I=
X-Google-Smtp-Source: ABdhPJy+M2N9BrkiZlV7swDsVS8lr+foMdrRj87zqll0xgJJ6C3k5biHUlV4OF1DhIKDmM0vzIOa9y1wDtnuMg8vn0U=
X-Received: by 2002:a50:9a82:: with SMTP id p2mr3170066edb.130.1593176504825; 
 Fri, 26 Jun 2020 06:01:44 -0700 (PDT)
MIME-Version: 1.0
From: David CARLIER <devnexen@gmail.com>
Date: Fri, 26 Jun 2020 14:01:34 +0100
Message-ID: <CA+XhMqwEHEEmw+8tnRM8r-Ds4fLKpTBxAqbxVtjr2JZEJdMf4w@mail.gmail.com>
Subject: [PATCH 3/3] haiku build fix
To: QEMU Trivial <qemu-trivial@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::544;
 envelope-from=devnexen@gmail.com; helo=mail-ed1-x544.google.com
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

From a548479cab82200d9df33a70f24aeebb00eb70ad Mon Sep 17 00:00:00 2001
From: David Carlier <devnexen@gmail.com>
Date: Fri, 26 Jun 2020 13:58:34 +0000
Subject: [PATCH 3/3] syscall skipped for haiku used only in qemu_signalfd
 anyway

Signed-off-by: David Carlier <devnexen@gmail.com>
---
 util/compatfd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/util/compatfd.c b/util/compatfd.c
index c296f55d14..ee47dd8089 100644
--- a/util/compatfd.c
+++ b/util/compatfd.c
@@ -16,7 +16,9 @@
 #include "qemu/osdep.h"
 #include "qemu/thread.h"

+#if defined(CONFIG_SIGNALFD)
 #include <sys/syscall.h>
+#endif

 struct sigfd_compat_info
 {
-- 
2.26.0

