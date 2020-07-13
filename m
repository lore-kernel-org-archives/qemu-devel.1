Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CCB7C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:24:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0768B205CB
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sh9zk5+N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0768B205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juzNs-0004Q1-8c
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 10:24:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35258)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1juzB1-0005Te-79
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:11:27 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:55186)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1juzAz-0006eW-Ci
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:11:26 -0400
Received: by mail-wm1-x341.google.com with SMTP id o8so13448174wmh.4
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 07:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=K8fsXAlUe8iXr9rVybQcSfsHKZEMrPOLeJ9Iej3RshE=;
 b=Sh9zk5+NhZUUfu5oWQF3CR0CIDoHfeKDEFhqHTA4Ufqy4UFMwwoiETBHdr086HXj0U
 +KlkNjvgBY93gS0cZE9iYCwzvXjoI1laMyOI/LZFhQoww9XvDBbec2psd13DrYP6uNCV
 ZeC9fE1jhOSm9/tofYl4shbRjI8pcjC97213cRR5/SZTVgXEWPlAQJpjDmz4z6RdebEj
 H/Jx9RU1m2sNnWzeeUK5sWWHYIa5yHLX4maPvwnO96HRd3N6wQwzb+hvEAcfLRnVzU82
 5VamQLS+yaoFdPPW8ITzYvIeDyFFnt7j+kmLkftvrRXvudnKXOt5pyn8ZnRHav4VplNV
 BlUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=K8fsXAlUe8iXr9rVybQcSfsHKZEMrPOLeJ9Iej3RshE=;
 b=Dk4ZJwVYZ7q2huankpsU34HmsFOCp3ybieCdcfwq6Puo1NIyVX/geQWbDgOlxqZkqB
 +1nzEYQUuzS5LzCP43FGt33iQF219az3FBt6Q9gdOFgl4fCEw6liXhM6TSlU44TuQL83
 fwqlssncRQ6b0FC1hkXnSnGzK9IgdTDVVBAZ0uWLjLQ6VfMpvjVFQ+yHXgs6vucnosC2
 6xmMNr9OZAUE5QfbskqTFuCPHV4a8vLPzIcyhcApnNmdRltTIoqP6O+D+7juA3kdtFGe
 M4ZmEpc7EGy93xRBacaTHNMRVcKHvl4S7VRXWHkYu5B9O9dtrek4kqq44GnYo423oqXK
 k+gQ==
X-Gm-Message-State: AOAM5333rZnfgIPKNgmUUoXWrbgTieZrA3BZYbxm443CXeeu6SPKqZFT
 QhRzKl4+l00EEZPPz9+/OVlvGIHz5p+ogA==
X-Google-Smtp-Source: ABdhPJwBBG8TwmzwiG1m9OUH7LN4gu+5RU4umE8uxvTRTph98RMcBhmA3EfwReDKKcgrbq8LosK6EA==
X-Received: by 2002:a1c:bb89:: with SMTP id l131mr119568wmf.125.1594649483762; 
 Mon, 13 Jul 2020 07:11:23 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c136sm24031297wmd.10.2020.07.13.07.11.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2020 07:11:23 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/25] util/oslib-posix.c: Implement qemu_init_exec_dir() for
 Haiku
Date: Mon, 13 Jul 2020 15:10:54 +0100
Message-Id: <20200713141104.5139-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200713141104.5139-1-peter.maydell@linaro.org>
References: <20200713141104.5139-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The qemu_init_exec_dir() function is inherently non-portable;
provide an implementation for Haiku hosts.

Signed-off-by: David Carlier <devnexen@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20200703145614.16684-9-peter.maydell@linaro.org
[PMM: Expanded commit message]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 util/oslib-posix.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 7ad9195c445..72907d4d7fe 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -60,6 +60,10 @@
 #include <mach-o/dyld.h>
 #endif
 
+#ifdef __HAIKU__
+#include <kernel/image.h>
+#endif
+
 #include "qemu/mmap-alloc.h"
 
 #ifdef CONFIG_DEBUG_STACK_USAGE
@@ -389,6 +393,21 @@ void qemu_init_exec_dir(const char *argv0)
             }
         }
     }
+#elif defined(__HAIKU__)
+    {
+        image_info ii;
+        int32_t c = 0;
+
+        *buf = '\0';
+        while (get_next_image_info(0, &c, &ii) == B_OK) {
+            if (ii.type == B_APP_IMAGE) {
+                strncpy(buf, ii.name, sizeof(buf));
+                buf[sizeof(buf) - 1] = 0;
+                p = buf;
+                break;
+            }
+        }
+    }
 #endif
     /* If we don't have any way of figuring out the actual executable
        location then try argv[0].  */
-- 
2.20.1


