Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F4FDC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 11:40:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CA6220724
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 11:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J4xoYTT8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CA6220724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnhI4-00045F-C7
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 07:40:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43750)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnhGh-0002Gh-Tq
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 07:39:11 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:33273)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnhGg-00034F-D2
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 07:39:11 -0400
Received: by mail-wm1-x335.google.com with SMTP id a6so2054015wmm.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 04:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=e266PxlxI12WIYe2b81DHcJwXbjmet15CRZzovOJKkQ=;
 b=J4xoYTT80RBlY5T0MCRlP3aAe884iA1hWTOX8NckEEk5skPw5XVJ2yH/A8o9cuzCrN
 BsOfxxoVTDwQ7jLQeGRaRJWVtB9/IhyINRDxldb1Tzzb5azk+nrd71d+KkpnIEXvnfMG
 D2G466I3n2TpVHYtOEb3iJ0P9K4on4egQK1jNZhDR4i/WQPVV2y2L07CyykQvB637X8j
 nIrgoKtpUYIM+RdSYPLJe6FhF5DRqVzAzlXeaeVRRROb3/uoopJ50qCbOr64g4eDxOLm
 U4vXg8LKqAWHw70OMJAazkrUNzkw5CNnuffBmP3OwqtZ9UTeAatRI573em3nO+PdeLfk
 o7nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=e266PxlxI12WIYe2b81DHcJwXbjmet15CRZzovOJKkQ=;
 b=BLcHSMV6K+T0ejT3kKbh2JGOUkA9EWZrTX/hE447gZzdf4Wl9oVXJYQ0SNyBLIuUO8
 3yMimxBz06XA14sctCY/WUEyPzpNIHAXgw9kxsLVNxGCc1k22TC8jQAbHCBDJKfMQVWx
 5xgE4opXYqy8VS9QJuvnnoakQb1iiyobv3eyfvrKgqh7RhpLYISILh6UMsR1g5tSiVzy
 5wAnGbKGZnj5UwLPIwwwEOlBvqAevHZzmOgvdFfHC1M91Z7vWQgO8wVEtESXS7c/htOc
 dvI01tpEi0oUsPfgmpf0CEtI8dxyQfzlxqSOmJvo5g4MiDJdNAdb7QIBhNXS9PqLa52h
 iJYw==
X-Gm-Message-State: AOAM531VMSYYWsgXlME9FC5A8gDm/ntMZ3KEzr73fqAyInrzmNy32xSq
 Hxxf0dAAJL3870qB3ZoIOGw/wxYLgst5Qw==
X-Google-Smtp-Source: ABdhPJyI0c+Rhc2M5a2pdRs+oP/rdDLkVkaPCX4Zl/0SQQCDZcCe9fN5/Y+7ItNGGfCG6+A+P68TCQ==
X-Received: by 2002:a7b:cd90:: with SMTP id y16mr16341769wmj.20.1592912348879; 
 Tue, 23 Jun 2020 04:39:08 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id m10sm4022177wru.4.2020.06.23.04.39.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 04:39:08 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/42] util/oslib-posix : qemu_init_exec_dir implementation for
 Mac
Date: Tue, 23 Jun 2020 12:38:24 +0100
Message-Id: <20200623113904.28805-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200623113904.28805-1-peter.maydell@linaro.org>
References: <20200623113904.28805-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: David CARLIER <devnexen@gmail.com>

From 3025a0ce3fdf7d3559fc35a52c659f635f5c750c Mon Sep 17 00:00:00 2001
From: David Carlier <devnexen@gmail.com>
Date: Tue, 26 May 2020 21:35:27 +0100
Subject: [PATCH] util/oslib-posix : qemu_init_exec_dir implementation for Mac

Using dyld API to get the full path of the current process.

Signed-off-by: David Carlier <devnexen@gmail.com>
Message-id: CA+XhMqxwC10XHVs4Z-JfE0-WLAU3ztDuU9QKVi31mjr59HWCxg@mail.gmail.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 util/oslib-posix.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 916f1be2243..39ddc77c85b 100644
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
@@ -375,6 +379,17 @@ void qemu_init_exec_dir(const char *argv0)
             p = buf;
         }
     }
+#elif defined(__APPLE__)
+    {
+        char fpath[PATH_MAX];
+        uint32_t len = sizeof(fpath);
+        if (_NSGetExecutablePath(fpath, &len) == 0) {
+            p = realpath(fpath, buf);
+            if (!p) {
+                return;
+            }
+        }
+    }
 #endif
     /* If we don't have any way of figuring out the actual executable
        location then try argv[0].  */
-- 
2.20.1


