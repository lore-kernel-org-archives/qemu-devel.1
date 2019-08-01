Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1341DC433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 23:44:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEFFF206A3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 23:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JpPEC8se"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEFFF206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htKke-0002AL-UA
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 19:44:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60311)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mehta.aaru20@gmail.com>) id 1htKhX-0005yt-1n
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 19:41:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mehta.aaru20@gmail.com>) id 1htKhS-0002mL-2l
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 19:41:37 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:35609)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
 id 1htKhR-0002le-Of; Thu, 01 Aug 2019 19:41:34 -0400
Received: by mail-pf1-x443.google.com with SMTP id u14so34970726pfn.2;
 Thu, 01 Aug 2019 16:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=A+f1nTAYThN43NLD0uFt8nEj4oW9MitsnNvRn4dZPNs=;
 b=JpPEC8se8HS32W2FaKSCQ9OfcIWXXsMyA/CaH0o2CVR2a4dLgp8RhOpTkvJ9w2NqGy
 VXkqJoPM7a/ECKniey8H5Rhu5dwaceLUuR2VODZO42xUx/Yi9xkGa4dpAUNtRhH5bbb9
 1+gKgPVEXXdZCMKwNtrjWocdG3DKFoIX9h4WaFPJDP1r28EIOXovSXVfWug7nfBg/2MY
 6rcc8wC93S2NytY1g653XuKfL8vj7haG/MUrrlMD4jUSjmLFhCEhDVZSBLUYmMdEFC49
 lR8iLA3Yd2ZT40iIa8EPEOxsTtCHDmV+f2/viXCalRcyQlzRS17eFRU/y+dewJmVdG00
 /kfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=A+f1nTAYThN43NLD0uFt8nEj4oW9MitsnNvRn4dZPNs=;
 b=Z9HqAdswV1cwPzpBDw5sdmNwuE53pjOWSXLljNujQJUK/JBwwrXyGZLx/wFSSDkzBG
 Nck9NRQxtYmkdrPNI5XnpBdDlQzhYSurolIUkokfNPjukUOO4iPvz510dEggJnsAsNUA
 jLMkpRY+QVr8S/m+ebBUnH8/zMXrEAPmadqphYwlvfb7JF9VKUIk7Z+mwjxJPXaTE6jM
 WnOYehFv5ab2OQaFv5vRBRw7fWzv8ZhMON+CUoGiIESaRSBE957J+hy1HlhxqiymUU9q
 bExXbDbVyS9iLmecdb/11LefUmy31EW0JMWlLAD3cq81l12svd8sHwVGZj1jxJDgeEih
 Ghww==
X-Gm-Message-State: APjAAAUQYQtlxlOlGuuwqYhNsxMkH0aV1ol27jK6+J8VgWEHbLNiTQqK
 r0RGiMQcdSBETw1cKqafU+dmwz2MV2/DSA==
X-Google-Smtp-Source: APXvYqwzDiNhTtNB1BuLeXleSrsc84/0coAbaMeMH/c2opJ26BBUW/0mVk6qQQEmsqEbKsRdrhf+Zg==
X-Received: by 2002:a62:63c7:: with SMTP id
 x190mr54268536pfb.181.1564702892433; 
 Thu, 01 Aug 2019 16:41:32 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:572:3de5:765:cb16:92cd:ee3e])
 by smtp.gmail.com with ESMTPSA id
 g18sm117975426pgm.9.2019.08.01.16.41.26
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 01 Aug 2019 16:41:31 -0700 (PDT)
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri,  2 Aug 2019 05:10:19 +0530
Message-Id: <20190801234031.29561-6-mehta.aaru20@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190801234031.29561-1-mehta.aaru20@gmail.com>
References: <20190801234031.29561-1-mehta.aaru20@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH v9 05/17] stubs: add stubs for io_uring
 interface
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
Cc: Kevin Wolf <kwolf@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 Sergio Lopez <slp@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 saket.sinha89@gmail.com, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Stefan Hajnoczi <stefan@redhat.com>, Julia Suvorova <jusual@mail.ru>,
 Aarushi Mehta <mehta.aaru20@gmail.com>
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
index be688fcd5e..bca5de7d6c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2536,6 +2536,7 @@ R: Stefan Hajnoczi <stefan@redhat.com>
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
2.21.0


