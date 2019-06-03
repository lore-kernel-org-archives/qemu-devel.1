Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 876A8C282CE
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 12:47:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A383217D4
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 12:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GN+JDPE5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A383217D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34623 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXmN3-0000HG-6U
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 08:47:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mehta.aaru20@gmail.com>) id 1hXmKg-0007Hi-3w
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 08:45:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mehta.aaru20@gmail.com>) id 1hXmF9-0007ux-BW
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 08:39:16 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:34575)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
	id 1hXmF9-0007sj-0n; Mon, 03 Jun 2019 08:39:15 -0400
Received: by mail-pg1-x541.google.com with SMTP id h2so4981933pgg.1;
	Mon, 03 Jun 2019 05:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=0zPchgJi6YzPvMMFd4UjDrg2UEfvsfzn5zpjZoO+8yc=;
	b=GN+JDPE5sHE8TneYV18T0327b0x23aI20VULiCdCbsuYnRb0diJix1TQA49Fte/pei
	W55EMiRlLx8E78r4ezDG2TaCisS3zaH0Vf5nTfkip193qxBDjL1zT8LQmU4UADDCgkfY
	bV5DS+fMC0gIQ2WyqV5Httf60uMe4CKp0VhIsZvGtGtOuwt0QorIQ3AKpsgDGt9TWzOW
	5tW+v8IyKEQ5DFPrT6kjHrURCuIWdJwwXL+lqjewVKn65yW2ZU5lsiNrb+nsxAUwPZUk
	JotK/gvRt9Soruci7N1MrMrddPLVYHJj1f6Hg2J3cZLkZzrvIBihW4i/GbTdU6QR7PO3
	TuRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=0zPchgJi6YzPvMMFd4UjDrg2UEfvsfzn5zpjZoO+8yc=;
	b=O3J3+8BcHhvRs5gZdcGHTMgroqKwKfovhnoJFTpsvfJJ3SZSoSE4/85z81qfISfsep
	cWonka+65U+NmxZV0k28KEAQQFg36cUh41n+ItkOaF3xamJ4iQXDimdcQI9yTK9VhNso
	yWs1SNpBLGCusrO3tNfjW3ZHVJuDWH5HQYEboFPXIHMLz/J2qc32zV6O32AEeDTQIhAG
	DGHMneTQee9Gurzr0F/bQeiiZNmo3ZYRPJYhDA9I9exXB44MYAHseSAW2+zrZhSv3UwY
	ZvOQsSIGmDOykQxUCgXj+NNFMzGbputFxqHafiFf1krSbDWy7qARjJHnV0IEucXYNwx6
	kyVw==
X-Gm-Message-State: APjAAAVbbiadK0eQHMlqvkGSTWAAtTxbkRak6Gf464GuvY+gAQg7H5CH
	hZPkaWnFzZUQ3Py62Cux4MQZ1P5b/zgG+A==
X-Google-Smtp-Source: APXvYqwgzY4p26lmGP+Vl/Aqmqdi7qNa1/vcxHVIypoU36BDXIAFg7LTiMk9WGz/D5WgX/IB6+3vBg==
X-Received: by 2002:a63:fa16:: with SMTP id y22mr28139592pgh.15.1559565553736; 
	Mon, 03 Jun 2019 05:39:13 -0700 (PDT)
Received: from localhost.localdomain ([136.233.9.100])
	by smtp.gmail.com with ESMTPSA id
	k14sm34860257pga.5.2019.06.03.05.39.07
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 03 Jun 2019 05:39:13 -0700 (PDT)
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon,  3 Jun 2019 18:08:19 +0530
Message-Id: <20190603123823.32661-6-mehta.aaru20@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190603123823.32661-1-mehta.aaru20@gmail.com>
References: <20190603123823.32661-1-mehta.aaru20@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH v4 5/9] stubs: add stubs for io_uring interface
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
	qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
	Max Reitz <mreitz@redhat.com>, saket.sinha89@gmail.com,
	Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Julia Suvorova <jusual@mail.ru>, Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 MAINTAINERS         |  1 +
 stubs/Makefile.objs |  1 +
 stubs/io_uring.c    | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 34 insertions(+)
 create mode 100644 stubs/io_uring.c

diff --git a/MAINTAINERS b/MAINTAINERS
index dcaddec21f..e30f62024e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2521,6 +2521,7 @@ R: Stefan Hajnoczi <stefan@redhat.com>
 L: qemu-block@nongnu.org
 S: Maintained
 F: block/io_uring.c
+F: stubs/io_uring.c
 
 qcow2
 M: Kevin Wolf <kwolf@redhat.com>
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index 9c7393b08c..5cf160a9c8 100644
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


