Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 823B4C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 00:45:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AB8C206C3
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 00:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ouDyQaus"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AB8C206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jq4Ot-0003R4-DR
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 20:45:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59690)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jq1db-0007Eh-Lq; Mon, 29 Jun 2020 17:48:27 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f]:36574)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jq1dZ-00084U-VR; Mon, 29 Jun 2020 17:48:27 -0400
Received: by mail-ed1-x52f.google.com with SMTP id dg28so14305093edb.3;
 Mon, 29 Jun 2020 14:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=byQ9N2ZfflWwiqWzsFO9snWApO2wcknUiGacMsjqgYM=;
 b=ouDyQauswtwobKbIUgsp0x3/XmOeUDGLw4zw/Z5a4kKhcho6th1xHtW/Htz4+aeQFI
 D5uPtc2gcyuuAac0tO6eSZ/7UPlK7J1ZxxPgSgx//ss55qvtcsAs5U1xXzjJufsoY4Z2
 qUOQo1MhSCcb3StB1lQ6dmvz9QbZowdEcrCIU3yX8zEm4aoMXzwvytpjTpDrilh4o8qm
 VhHqaPpaigJg8wNNhYh1aXbmZ7SE1qTMe2iCZ60pxbqpZnqHNVzescLQwhcWIMoLDhIi
 rVCYSKzFlJJ3wIi/7udxQfKbInvE9UhIw6+o1pOLjWKa9WflZp12nL0i2LVEtD0ZLm7b
 d1cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=byQ9N2ZfflWwiqWzsFO9snWApO2wcknUiGacMsjqgYM=;
 b=QEgmONsrNhIoDwSjAT1xcKgaTA21qBRscqCnjVw5t4f2PmM7a+zjiJ6xjPo9ttgN0t
 HMNm+OvUr2kyHltOqSjwd5iUStUJXYDIhKYyDCqzBNYPLXfLqkZsRT7FwzSNp5+tBxPe
 Nc+V1A+tdm0UDOYFgU/R0ii6vKkZ6wRQgMmor0gQ85REdh/PadETKHtUBBxEyRYc5eHN
 aEWHq2B/OujbuB8qt44i6cJTJ8gKpkXERFy6lWGDv2NGQoVofrXl7S6/xD6mndGoO2e2
 wTB405xUaAj/sbXahlJpIszBZaz3dIo2yqH46Nfon1vs4fSSvZMIJPoj5LqMrhguR0Ow
 qtOg==
X-Gm-Message-State: AOAM533EMNdUnnskH/N+zwZRsXU7+/B6ho6nLqn0RqRerFM4gBHNQVU4
 3ob2THfjaYihwnILDw4MUHpPb/HsY0THjL0avILvXc3fBMc=
X-Google-Smtp-Source: ABdhPJwrF6PbU/+r2gcXyaeDPiuDGqd0Xullz7uVbtV1PfWc6TWv3t8dlF2L83K3d/iosJpvWY/LwJSEx0omU2wtP7U=
X-Received: by 2002:a50:f05d:: with SMTP id u29mr20429662edl.137.1593467304056; 
 Mon, 29 Jun 2020 14:48:24 -0700 (PDT)
MIME-Version: 1.0
From: David CARLIER <devnexen@gmail.com>
Date: Mon, 29 Jun 2020 22:48:13 +0100
Message-ID: <CA+XhMqwUHwc-FPgP-YfKPz5CL8BKSQY+0qTJ5uBRhfu22jsh1g@mail.gmail.com>
Subject: [PATCH 2/9] Enabling *pty api
To: QEMU Trivial <qemu-trivial@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=devnexen@gmail.com; helo=mail-ed1-x52f.google.com
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

From 8b205a027dacad08ce9187474d9490667904a4e2 Mon Sep 17 00:00:00 2001
From: David Carlier <devnexen@gmail.com>
Date: Mon, 29 Jun 2020 22:14:53 +0000
Subject: [PATCH 2/9] Enabling *pty api

Signed-off-by: David Carlier <devnexen@gmail.com>
---
 configure           | 9 +++++++++
 util/qemu-openpty.c | 2 +-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index d81931ba5e..50b559238f 100755
--- a/configure
+++ b/configure
@@ -2386,6 +2386,12 @@ else
   l2tpv3=no
 fi

+if check_include "pty.h" ; then
+  pty_h=yes
+else
+  pty_h=no
+fi
+
 #########################################
 # vhost interdependencies and host support

@@ -7856,6 +7862,9 @@ fi
 if test "$sheepdog" = "yes" ; then
   echo "CONFIG_SHEEPDOG=y" >> $config_host_mak
 fi
+if test "$pty_h" = "yes" ; then
+  echo "CONFIG_PTY=y" >> $config_host_mak
+fi
 if test "$fuzzing" = "yes" ; then
   if test "$have_fuzzer" = "yes"; then
     FUZZ_LDFLAGS=" -fsanitize=address,fuzzer"
diff --git a/util/qemu-openpty.c b/util/qemu-openpty.c
index 2e8b43bdf5..9d8ad6905e 100644
--- a/util/qemu-openpty.c
+++ b/util/qemu-openpty.c
@@ -35,7 +35,7 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"

-#if defined(__GLIBC__)
+#if defined CONFIG_PTY
 # include <pty.h>
 #elif defined CONFIG_BSD
 # include <termios.h>
--
2.26.0

