Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C4BC28CC7
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 13:54:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 463C320679
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 13:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LH1lcG4o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 463C320679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46742 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haKlD-0005nt-FT
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 09:54:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51160)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mehta.aaru20@gmail.com>) id 1haKgc-0008Qp-2w
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 09:50:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mehta.aaru20@gmail.com>) id 1haKga-0001it-U8
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 09:50:09 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:44450)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
 id 1haKga-0001he-OK; Mon, 10 Jun 2019 09:50:08 -0400
Received: by mail-pg1-x544.google.com with SMTP id n2so5072774pgp.11;
 Mon, 10 Jun 2019 06:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=c7OL+TvejrK+J39mndDS6U2ikA3eTizaB36rrB9ZJvI=;
 b=LH1lcG4oVWqFJWS8E3b4H2aGCryFVZ3QxDmATzLkc128RQzYVEucsV5TeH05qmhm1o
 zDjB/6PuOWNd7uMorcyb4hq0lh0SWhnofFY/LxQIrNuF2Pw2eXncqeVYOby6yF0XjAr6
 M3U66d1Gs8Cv4WcP7WkRXMY4MIiNVILgQ/cB5+tryVw3qlPWM2whuBsXZBohZR+ThtSF
 i/gAWiMKhgPazxqjHX6nx0f0Gud/+FByQmuwkMTcLe6VGvdowTIZwhByBFEKBSNs7IzV
 x6afVvqT4T2Tt8zYgFt150ugfExsqTR9fyjK16eWrF/pFWpGkRnoM5WaLYZuwOHWjLlc
 HPfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=c7OL+TvejrK+J39mndDS6U2ikA3eTizaB36rrB9ZJvI=;
 b=U9JQiOCqbWRU731PR2yTsqWTxyKkelA16HDPGW0BsNa7Osxh6LrQ/RhMya4ZnzDJGh
 yCsCWmLhKSq01zvmp/B2KmXGrem4KB72dchoEHAszMdEWzYTRYgQCjUEW6a+Sf4doAyH
 MfkQGZGua4uvpKa1PNacVx1N4ZWK/XvGOmJmkREb5jn1cuJe6CN+ECpY9nzOL0N1oxo6
 J3DL1zkNOQNRysvv/4XBY5l1IbNE4HxuWrMGrJCtwMZHoI6rbleTQBwG1206jGZQmRJC
 f9qFahwIKjbmPfmo0BOoRBy7ZuJmzZqyi7TL4dgY/tTU8+jIBD09T6x22yh7/+P/f18q
 e62w==
X-Gm-Message-State: APjAAAUCgh5q4SkHzRFw7NB4mayDgtBg452nSoeUgBqSBSIpoLQbcsmd
 tFIzgH7WsVO245iii1NhBCoo967p/ClW7Q==
X-Google-Smtp-Source: APXvYqw6jVJDVEmk6+UrSqnPoxHEaEqj5MqJBStBCjp32swIaq3aYZuCU8eeCj+OtcR4sOyiN/D21A==
X-Received: by 2002:aa7:956d:: with SMTP id x13mr35258432pfq.132.1560174605239; 
 Mon, 10 Jun 2019 06:50:05 -0700 (PDT)
Received: from localhost.localdomain ([136.233.9.100])
 by smtp.gmail.com with ESMTPSA id d4sm13969837pfc.149.2019.06.10.06.49.58
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Jun 2019 06:50:04 -0700 (PDT)
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon, 10 Jun 2019 19:18:58 +0530
Message-Id: <20190610134905.22294-6-mehta.aaru20@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190610134905.22294-1-mehta.aaru20@gmail.com>
References: <20190610134905.22294-1-mehta.aaru20@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel] [PATCH v5 05/12] stubs: add stubs for io_uring
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Sergio Lopez <slp@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 saket.sinha89@gmail.com, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
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
index 49f896796e..bc38175124 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2522,6 +2522,7 @@ R: Stefan Hajnoczi <stefan@redhat.com>
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


