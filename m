Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC07DC76195
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 13:36:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEB442184E
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 13:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mO/e7HSR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEB442184E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45435 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoT4E-000653-QX
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 09:36:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37868)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mehta.aaru20@gmail.com>) id 1hoT3o-0004PH-RH
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 09:36:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mehta.aaru20@gmail.com>) id 1hoT3n-0007oq-L8
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 09:36:32 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:45339)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
 id 1hoT3n-0007o7-FU; Fri, 19 Jul 2019 09:36:31 -0400
Received: by mail-pl1-x644.google.com with SMTP id y8so15649951plr.12;
 Fri, 19 Jul 2019 06:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VSkhdyNuTHd130Aa5REO4Nkkx5xHnHniJbmIfD3ng9w=;
 b=mO/e7HSRTBPGwc9gkbo7ZXpaCvJkKsZUKzL5oZamgfw61ywMKTKIRDllKsMJogK/fZ
 dTDpBZulpBnqxhAGZo6kAZUumgSMYuOAR9jrzT43LWFmU0/5uqAd/CqI2SDftCTldqfO
 IcTF6vocn+VawM8mz6sYY9BDeIQrFgelhTycTSKsvK/ZIAoQrHqeNrPMIf6wj3oqdO/4
 aqYHQ1x1tqxIt7SjgPb++YgTnPBgoFL/H8/uo1sMLfCOi/A5Y4qbYSeTCU3UckAQcQLy
 y/xIYFwhMYewXEEZwqYtvWVhaivRgTXDpHulYjuYDta+GvdUMZqVOa+1yTNk23GZLSAn
 xn9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VSkhdyNuTHd130Aa5REO4Nkkx5xHnHniJbmIfD3ng9w=;
 b=lDKnK12IgMhJfSiVw6xMLGU1lYwayGQlifT2UDo7GirDUKanHa/MBl5tYa2r+BQD7D
 IpLTFqYTGvNbTmufVo+3B7F/k2tdcqcz+zHgFxObOxC5btjOsL0cwD5INBdZHJcCekad
 tf3xAb5zdLAPVtNlakU5tv2b1zhuzw4AWL51sigpiM79Z/zbfh7Xg5eASPumrR+M3JAT
 iHeBRlXpFJb3fl16AOCrKiKdydjD+fMsTEKEjcSvOBC5+Cz9ATwjlpFaEstDApV7xpWh
 xzn9f9ttjXp3sigb5pxGMhYbg+LHvVx6nrNKrLBhjNFXc1iC+aHO4cD+KihvKlU1iDW0
 K5tw==
X-Gm-Message-State: APjAAAWCB2qynly2LA3B2bgFeuCbCMoccw0Pw5yn37rDLjuvNFd+Ztfr
 PNhmEVkCwDv2q7ZxSHtoMiZi13YF1K0=
X-Google-Smtp-Source: APXvYqwCgbk1LsuxqmvG8704YASTyBRmVxICCN20HsyvF0kL4J1n/MOwle4R5o2LZqPQhNIomsOG+Q==
X-Received: by 2002:a17:902:e30d:: with SMTP id
 cg13mr56750261plb.173.1563543389709; 
 Fri, 19 Jul 2019 06:36:29 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:433:31a4:f2fb:dab8:3a89:c056])
 by smtp.gmail.com with ESMTPSA id 11sm31895369pfw.33.2019.07.19.06.36.22
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 19 Jul 2019 06:36:29 -0700 (PDT)
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 19 Jul 2019 19:05:21 +0530
Message-Id: <20190719133530.28688-6-mehta.aaru20@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190719133530.28688-1-mehta.aaru20@gmail.com>
References: <20190719133530.28688-1-mehta.aaru20@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: [Qemu-devel] [PATCH v6 05/14] stubs: add stubs for io_uring
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
 qemu-block@nongnu.org, Sergio Lopez <slp@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 saket.sinha89@gmail.com, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
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
index 651f417f4b..b996bc3abd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2537,6 +2537,7 @@ R: Stefan Hajnoczi <stefan@redhat.com>
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


