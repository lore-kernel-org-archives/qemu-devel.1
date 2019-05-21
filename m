Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A062C072B5
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 00:01:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65887217D9
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 00:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jHqgYbzD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65887217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:32910 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTEhA-0001KU-Mj
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 20:01:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mehta.aaru20@gmail.com>) id 1hTEcW-0005iQ-QI
	for qemu-devel@nongnu.org; Tue, 21 May 2019 19:56:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mehta.aaru20@gmail.com>) id 1hTEYp-0001hC-1O
	for qemu-devel@nongnu.org; Tue, 21 May 2019 19:52:47 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:41192)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
	id 1hTEYo-0001gr-S8; Tue, 21 May 2019 19:52:46 -0400
Received: by mail-pf1-x444.google.com with SMTP id q17so271533pfq.8;
	Tue, 21 May 2019 16:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=6t8EyasZJmDI3dL3/CDwbkFcNJeDBde1hDDWAyb831A=;
	b=jHqgYbzD0MLSWwn80XgJA6ozg3JiiVqBcEWYyvc6jD/nKXFdSM0ZmmKAQtTfQ+ruY/
	gRloWm2VCuN0fpdd7IRqO28eXccV0RYyNjw6DRkbAE3qpq64Svfy8CbZ0PkRyA8mE6Pd
	Xg36g1kdMnlSFyx0niyoZ2LvvFuJJUL9v62H1ZvrfOS59FBi2lmrzPUx+ZsoKiClwCr6
	dObbxYt/1VXqu/vkJ1F59oF65a410U5Y7cV1hQ4B6uF8a/ChLFLZuh4Aa84OZF6bCVaT
	wy/QTq0VbP5/utrXh+HpMuApuVSyX9GRaM1++wssj38xsYcQ5Rpl+CYii8PMIllH2dcL
	vekA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=6t8EyasZJmDI3dL3/CDwbkFcNJeDBde1hDDWAyb831A=;
	b=r2vsYhAneTGPCx+iqGRzghZBLY+omng7aRTHBbEWsWh+hy4ZII+8/n8MVELQH8srJG
	Tf1OVsI3ioFhzv/Q44UAVjJssduf0Ml0Q5AaUtk6f8v1f7w4MI/LQyI89NErgNEuS98a
	Qj6+c2ed/Pg+F94GnCvQqOf41yqTwRT6SUi0fgxmZpEN0lzcINi+vQMaqmORJivfUK6T
	DABjvwuIPVRmtWLGycKsvRO6oAimEaW2Dk6SO2kcFlwv4DhJ+ioOf7fqGUQ6nGyEANlP
	HnnsIt8MXJtOq29TugY/2LRirarOVU9XsyyuPUnHC35DoVOWGPehBnfvDdqe38He05ZC
	mbSg==
X-Gm-Message-State: APjAAAXdkLjFw9EbiiNtifLm/amrUBFKfnWO1vSARIgI6E+yAOR+HUhi
	+fWlVr7XCGmqAN5sPqcGTeb+ZxcbeHVx8g==
X-Google-Smtp-Source: APXvYqzrWBbsbCPMPl8mF11WMCnG1LHB+X9TVBJWdz50dtDDFoaii6bdMnVOKj8nr5x7IjOut+eqVQ==
X-Received: by 2002:a62:6dc6:: with SMTP id
	i189mr91080963pfc.155.1558482765576; 
	Tue, 21 May 2019 16:52:45 -0700 (PDT)
Received: from localhost.localdomain ([120.57.118.207])
	by smtp.gmail.com with ESMTPSA id
	e5sm51571752pgh.35.2019.05.21.16.52.42
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 21 May 2019 16:52:44 -0700 (PDT)
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 22 May 2019 05:22:10 +0530
Message-Id: <20190521235215.31341-5-mehta.aaru20@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190521235215.31341-1-mehta.aaru20@gmail.com>
References: <20190521235215.31341-1-mehta.aaru20@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [RFC PATCH 4/9] stubs: add aio interface stubs for
 io_uring
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
Cc: saket.sinha89@gmail.com, Julia Suvorova <jusual@mail.ru>,
	qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
	Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
---
 stubs/Makefile.objs |  1 +
 stubs/io_uring.c    | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)
 create mode 100644 stubs/io_uring.c

diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index 269dfa5832..86ceca5c4e 100644
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

