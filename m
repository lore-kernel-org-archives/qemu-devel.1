Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D08CC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 11:59:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBECE2073B
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 11:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dn19oVHR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBECE2073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVZkr-00048J-SM
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 07:59:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51886)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jVZie-0001r4-AC; Mon, 04 May 2020 07:57:08 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35673)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jVZid-0001G2-Cm; Mon, 04 May 2020 07:57:08 -0400
Received: by mail-wm1-x342.google.com with SMTP id r26so8716515wmh.0;
 Mon, 04 May 2020 04:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=obSCKk2me/00cEpyiCftGc/OOp6WIYGJzAVVhOdRcgM=;
 b=Dn19oVHRhyI9z8SLrPicRhninDKG8BnO9a0o/KM9ulRZdhfRSNjJSm0Rc+j61SaZTE
 o0o5XLi4KhPXAyEDkz0l0JXLN/neIM+mUbHue4v2oCsmxr6szKEABQ1Tl9+ArDy4to0Z
 LafyZ3+HAYn5wellh+HdsKZqBzKoCeXac3HAtt26sXDMzSicHMq+9NJDfCfCPNaOoG8I
 0D1yHcIQO+YiHHTrzChP4knCLUNbCaN2lYJTh4/qQwnxCtkcrRqa7Z8URQ8AHuO5q2re
 nXxyCPI6C/6bz7XZ7YYAo17GuUNx5Wwd32G7Q4G1vCsqlYOV9m/BOghU+b5+2dsh0xdP
 mLdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=obSCKk2me/00cEpyiCftGc/OOp6WIYGJzAVVhOdRcgM=;
 b=phl18hdeLjBNdpSuewW1E/y4xof2fM3AAIiIsu438/E6/knqHaycEmaZRIsl5Zfk/g
 bEcbUbDOfX3XfKjxKxIZPrHjdwt8hqSsC0kgmKtJFF6Qn08E63gUHVL6Cs1vQQRy7+n8
 6P68zhkbWkWkMAuj/wo+H/f3Z8AvEtNg5xUSiI8ks2fyo+tpVZoGwXeuYIYiTtDP0Qkd
 KgQIMKk0gZ3mzLg8xj1iJjPU1EKS6owMSCYFjoOuNNJqjdpe1GqJaAFY6Z4GoFl3pzz/
 Dj8jepHcQ1Z3pVJWiYZ0xD6OWZkG3HVH8mDwFeJxQXmR6PS5tfJEyEAb94JLYlEYIgM7
 cAew==
X-Gm-Message-State: AGi0PuYNgHAmOjSbzR1OiOBd3dMxyuh370bONttgecpqOCFU4B44HThK
 n/jqTL4S+VSSyELaim9xf2wdjh07
X-Google-Smtp-Source: APiQypI+rAq8eJ5GbY9KHUvJk/iDG3foPZfD8mGwmlHLDVneOMhV7voMAqRB7qOnNxNLTeynmHBomg==
X-Received: by 2002:a1c:bad4:: with SMTP id k203mr14006080wmf.15.1588593421110; 
 Mon, 04 May 2020 04:57:01 -0700 (PDT)
Received: from x1w.redhat.com (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id n12sm5660984wrj.95.2020.05.04.04.57.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 04:57:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/3] io/task: Move 'qom/object.h' header to source
Date: Mon,  4 May 2020 13:56:55 +0200
Message-Id: <20200504115656.6045-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200504115656.6045-1-f4bug@amsat.org>
References: <20200504115656.6045-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We need "qom/object.h" to call object_ref()/object_unref(),
and to test the TYPE_DUMMY.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
v2: Add missing header in tests/test-io-task.c (patchew)
---
 include/io/task.h    | 2 --
 io/task.c            | 1 +
 tests/test-io-task.c | 1 +
 3 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/io/task.h b/include/io/task.h
index 1abbfb8b65..6818dfedd0 100644
--- a/include/io/task.h
+++ b/include/io/task.h
@@ -21,8 +21,6 @@
 #ifndef QIO_TASK_H
 #define QIO_TASK_H
 
-#include "qom/object.h"
-
 typedef struct QIOTask QIOTask;
 
 typedef void (*QIOTaskFunc)(QIOTask *task,
diff --git a/io/task.c b/io/task.c
index 1ae7b86488..53c0bed686 100644
--- a/io/task.c
+++ b/io/task.c
@@ -22,6 +22,7 @@
 #include "io/task.h"
 #include "qapi/error.h"
 #include "qemu/thread.h"
+#include "qom/object.h"
 #include "trace.h"
 
 struct QIOTaskThreadData {
diff --git a/tests/test-io-task.c b/tests/test-io-task.c
index aa8b653bfa..c8a3813d49 100644
--- a/tests/test-io-task.c
+++ b/tests/test-io-task.c
@@ -20,6 +20,7 @@
 
 #include "qemu/osdep.h"
 
+#include "qom/object.h"
 #include "io/task.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
-- 
2.21.3


