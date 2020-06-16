Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23AF8C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 16:12:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBBDF208B3
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 16:12:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E83cMfY3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBBDF208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlEBs-00077I-8o
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 12:12:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57682)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jlEB5-00064L-Di; Tue, 16 Jun 2020 12:11:11 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:35157)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jlEB3-00056Z-J6; Tue, 16 Jun 2020 12:11:11 -0400
Received: by mail-ed1-x542.google.com with SMTP id e12so14700804eds.2;
 Tue, 16 Jun 2020 09:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=tQGTgMA17a4o6iebS1HxA6AgY6W7CBwK/BaZI98DayA=;
 b=E83cMfY3rnxAqY8XBmXPvAc/fvzBgSODYggbL92DfEvs+SWHT/sJEJP1IXC19cc5mX
 d324qLCxN8Bw8fmPlBxUeY9wvqi7TKYb/MGDCZEIcOOVN9pdE9oay0EfA0HLFumgb92d
 BBKtYxYEqgYq7N4PIgCFye7pzm6EIpEsl8qqY3NrQMHUZQx9BJkmZ1PWtt2zDWlepW0O
 RmlWaXKcVz3OIK2as1rLgwmLJ9jwNEEmhb4jbfEAyCKY8JRbJRsQmqeCXHZ5DfBswDm7
 pmd2YRTCk3V0vlz6uQAKK+cbfLp4d/lVjK4+TxkYnrivf047zlWzt6AN6nDyO9HP67ZS
 i0Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=tQGTgMA17a4o6iebS1HxA6AgY6W7CBwK/BaZI98DayA=;
 b=XCW7K/JDpp/+X4ZKyyEnmS94BNXWmB+L/8qQJ+ySP5XLo6Q/aq++HI4KIlR5q5DyLM
 UTsmDuOALHAPMzqOK3BWYYEBhxaE/fhYXXhrm3yLZUbMl4W419bXlnia38HcABqbO+NE
 ruz7zigBNsXAzWp/urAz2Wn8uTcqNh4XUJYffaIzV6Th4WKhbIRh/cqu5fcTWhh09ZHb
 F7xlUANURqjhavcIyUiAmZPSgy5QqStqErcK5I//PFKl2wNS0KZV6X50krNZQq2kG+Wz
 rHjOh3cvAiaMyvYYZYeDKgxila3SraoUYFgRRKDwfCabLQoAA8ZMIlZwKmPVag+p1iCz
 YYqw==
X-Gm-Message-State: AOAM530v5dU6AQFV7OT30syVpcf5I+8OyIlJpXc9hhqnXJG6rjO3WnEZ
 AbA2I9ld1D7LwDfwJTxF+xZ/hcd5sGda+Cg1PSm/GK7d49Q=
X-Google-Smtp-Source: ABdhPJySHc2+PvED6EqeGjumwLlo+9qhCqZBo0PfV3LbE/jNelL7nSvuH9N72v0ShxcS0+hcscOwFfUVc2EfavjjwN4=
X-Received: by 2002:aa7:da14:: with SMTP id r20mr3309742eds.7.1592323867344;
 Tue, 16 Jun 2020 09:11:07 -0700 (PDT)
MIME-Version: 1.0
From: David CARLIER <devnexen@gmail.com>
Date: Tue, 16 Jun 2020 17:10:56 +0100
Message-ID: <CA+XhMqx6VjRhT6xBzJ-UYs7cPDXVK=PNdfNVdad3Tqhe43P=Ew@mail.gmail.com>
Subject: [PATCH V4] util/oslib-posix : qemu_init_exec_dir implementation for
 Mac
To: QEMU Trivial <qemu-trivial@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=devnexen@gmail.com; helo=mail-ed1-x542.google.com
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

From 7eef8b803cdb0e7148fdf894d2992052695c1ff8 Mon Sep 17 00:00:00 2001
From: David Carlier <devnexen@gmail.com>
Date: Tue, 26 May 2020 21:35:27 +0100
Subject: [PATCH] util/oslib-posix : qemu_init_exec_dir implementation for Mac

Using dyld API to get the full path of the current process.

Signed-off-by: David Carlier <devnexen@gmail.com>
---
 util/oslib-posix.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 916f1be224..3612c2c80e 100644
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
@@ -375,6 +379,16 @@ void qemu_init_exec_dir(const char *argv0)
             p = buf;
         }
     }
+#elif defined(__APPLE__)
+    {
+        uint32_t len = sizeof(buf);
+        if (_NSGetExecutablePath(buf, &len) == 0) {
+     char fpath[PATH_MAX];
+            buf[len - 1] = 0;
+      realpath(buf, fpath);
+            p = fpath;
+        }
+    }
 #endif
     /* If we don't have any way of figuring out the actual executable
        location then try argv[0].  */
-- 
2.27.0

