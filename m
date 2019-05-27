Return-Path: <SRS0=zt/K=T3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC98BC07542
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 08:10:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74A1421721
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 08:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="irb0GuOo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74A1421721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41709 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVAhr-0003X2-N5
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 04:10:07 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mehta.aaru20@gmail.com>) id 1hVAcC-0007o2-5q
	for qemu-devel@nongnu.org; Mon, 27 May 2019 04:04:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mehta.aaru20@gmail.com>) id 1hVAcB-00021a-6y
	for qemu-devel@nongnu.org; Mon, 27 May 2019 04:04:16 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:43060)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
	id 1hVAcB-000216-2I; Mon, 27 May 2019 04:04:15 -0400
Received: by mail-pl1-x642.google.com with SMTP id gn7so6724635plb.10;
	Mon, 27 May 2019 01:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=9iDE2hU2W31yYscdifZjS5ZJYVdn4yXv1JMbOqGrwXk=;
	b=irb0GuOobJ8X6wooKiggxIt1r+uXzbnfijGrHUrbpE8JD7TPbTgBYuGZZrJzrq698S
	a87+cnt6qGvswxrAevmc7yir52tlyPtFvGL/kpyKHjSWz7xkrShPwHRJqV6fwtYqc0W3
	Rv+s9qB10BUPUNLPczSWhXvwvgZbdHInZ3xolOLGcRvIS6rAOyyxOQS9pIOITEOriRW1
	EVBLcbpwmhwHIJUZc7Tn3CHRQUpm+DHKVcCi2at/Ygx27TtgQMsfnOhUBBfNBCUU7Eyy
	m660hfgZGYwGlq52IhODYR+2rz1f+dTstPYb1OkUYya3sR6D4RzZ+ckZSwew4g9tYkVw
	sp9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=9iDE2hU2W31yYscdifZjS5ZJYVdn4yXv1JMbOqGrwXk=;
	b=H0GFyC5nH2q9vBQRa/EFjfGQC5RioQ2fBfdEfMjnP2jDU1euA1b6+Cxkz53zhX4Bhh
	Ygj6AnuuavKl91dT4f71Lu3/oaFgu/S0fsRzfSZvY+kknr/tKwc7JtfR5BDMeOrfEHY5
	xBOYSTxPeikLXso0cJChoSK4wFvI0KixzF1zcJ0QnxYD6pUHucOW6mpqoXyiVcw7af9p
	Iz4lUlYDkFnZNOtVNvUKjFAjIFamoHVNM7j3SmbdrVUZwAYWwKJ2G+HijCLk0HBw7iqG
	Js5zAZl6LfjgTP2s7uYYqiY8vlQukhNrZcKKFKrmB1Aik5mpppZFFk7HHRAKOMBaojMo
	63qw==
X-Gm-Message-State: APjAAAVQZWdWGxiZgflaFcXZ4v75X0SLYtz//VoxVIufVDc8/7WJNKG0
	i2ESmS/oKmYMbnF7Ks6qx2BwcFz9RbYmvA==
X-Google-Smtp-Source: APXvYqzUc/sCy2vsPirblMP2i4aqpvVH5EWJ6M3vARFEuApRLt2xBNtJrH2CZDQ2wr3Qj1SjWxHsYw==
X-Received: by 2002:a17:902:1021:: with SMTP id
	b30mr24438282pla.324.1558944253367; 
	Mon, 27 May 2019 01:04:13 -0700 (PDT)
Received: from localhost.localdomain ([120.57.119.140])
	by smtp.gmail.com with ESMTPSA id
	j5sm10030853pfa.15.2019.05.27.01.04.08
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 27 May 2019 01:04:12 -0700 (PDT)
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon, 27 May 2019 13:33:24 +0530
Message-Id: <20190527080327.10780-6-mehta.aaru20@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190527080327.10780-1-mehta.aaru20@gmail.com>
References: <20190527080327.10780-1-mehta.aaru20@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: [Qemu-devel] [PATCH v3 5/8] stubs: add stubs for io_uring interface
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
	Max Reitz <mreitz@redhat.com>, saket.sinha89@gmail.com,
	Stefan Hajnoczi <stefanha@redhat.com>, Julia Suvorova <jusual@mail.ru>,
	Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
---
 MAINTAINERS         |  1 +
 stubs/Makefile.objs |  1 +
 stubs/io_uring.c    | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 34 insertions(+)
 create mode 100644 stubs/io_uring.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 462c00a021..6c6672bda3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2510,6 +2510,7 @@ R: Stefan Hajnoczi <stefan@redhat.com>
 L: qemu-block@nongnu.org
 S: Maintained
 F: block/io_uring.c
+F: stubs/io_uring.c
 
 qcow2
 M: Kevin Wolf <kwolf@redhat.com>
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index 73452ad265..ea158cf0ee 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -13,6 +13,7 @@ stub-obj-y += iothread.o
 stub-obj-y += iothread-lock.o
 stub-obj-y += is-daemonized.o
 stub-obj-$(CONFIG_LINUX_AIO) += linux-aio.o
+stub-obj-$(CONFIG_LINUX_IO_URING) += io_uring.o
 stub-obj-y += machine-init-done.o
 stub-obj-y += migr-blocker.o
 stub-obj-y += change-state-handler.o
diff --git a/stubs/io_uring.c b/stubs/io_uring.c
new file mode 100644
index 0000000000..622d1e4648
--- /dev/null
+++ b/stubs/io_uring.c
@@ -0,0 +1,32 @@
+/*
+ * Linux io_uring support.
+ *
+ * Copyright (C) 2009 IBM, Corp.
+ * Copyright (C) 2009 Red Hat, Inc.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+#include "qemu/osdep.h"
+#include "block/aio.h"
+#include "block/raw-aio.h"
+
+void luring_detach_aio_context(LuringState *s, AioContext *old_context)
+{
+    abort();
+}
+
+void luring_attach_aio_context(LuringState *s, AioContext *new_context)
+{
+    abort();
+}
+
+LuringState *luring_init(Error **errp)
+{
+    abort();
+}
+
+void luring_cleanup(LuringState *s)
+{
+    abort();
+}
-- 
2.17.1


