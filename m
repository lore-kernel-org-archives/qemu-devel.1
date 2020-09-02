Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9039DC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 20:06:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 580092071B
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 20:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XEvJacs6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 580092071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDZ1Z-0003q1-HW
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 16:06:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54486)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDYht-0004ug-UA
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 15:46:09 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e]:45788)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDYhs-0004FX-Cb
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 15:46:09 -0400
Received: by mail-pf1-x42e.google.com with SMTP id k15so202902pfc.12
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 12:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=1WaWYm3oB7aT3VJF68A31UriO/zTzOxdkd3tW5V2Vz0=;
 b=XEvJacs6jyGp7JeTOnGahASxOwAngXui0dI0WlxIfgRw6wF/ZVtZkZQPh4FLCiTwHR
 zFo7SShOxKlz9O3Wwc8CG7KT7SZy/dscWHn25SCgtDxRWCzDt78sYE13iXQYj6plq30g
 dwuUQ3LHQ8LHTpWuGcome3rEgokPObV+Q7qWDHACo4/XMVMUTSSdzHF0HC4MA+QyzcH1
 yjVo4XjlyUAZ+D7Wz2nZYz20f54MnRrMmCUNdAp+9GzjxjlTJga62L5hICFdyUoWimd6
 Z9mx9FljmlBKfFaYZSnggGUhJQzfp1/hydIfYPMBPaXcAjeIV+bjngQdZnpAbuRm+oxQ
 lgQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=1WaWYm3oB7aT3VJF68A31UriO/zTzOxdkd3tW5V2Vz0=;
 b=f84cQCAYfMtcRbzNTZafV5QKSIU3YNNEptKGt8MbvqWxdN8AYV1tMdjLsyVHlE/u42
 2fJ9iBDGawlpCCRVZmMFgXhCR3LwhiqNrRO1y5iRW/t9w3iywc/rPnxnZbLvCwbmUJqC
 0cxnuN/sKcGZWjUjFbdS9nhxwuQxKM2F3WmHEVHuRe7dOHbKix7BHqRPKAhMK8cAFqXP
 cizkuHbYnUYbk5F0K104YXWn+3x4QvMDY5JBcgdAL2hJ4uMMl/mUjV0XnJ5TNmdhkQ97
 TQ2KMdvUoFI6x6j9zCJCz7DD7U1jJbUSas9whq/iXNj2xMYng1xowNyZGUZWWFzvCGQV
 Focw==
X-Gm-Message-State: AOAM53248Pg/2oZR7NVaLi/wnH4DQWFRfOus+AdIwekfCg2sJNeMtBgU
 tt/CREHuAcz3eReOu5UH8n/WenpryybY2A==
X-Google-Smtp-Source: ABdhPJzSVLoMfu4PWz0HJ7m0mdocV4S5jzOKsl51/QTgO6SEEjzwO9ewlEOO7kTdQ+2tiMo2FCN0xQ==
X-Received: by 2002:a63:5656:: with SMTP id g22mr2546802pgm.44.1599075963116; 
 Wed, 02 Sep 2020 12:46:03 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id w66sm333320pfb.126.2020.09.02.12.46.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2020 12:46:02 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] osdep: These function are only available on Non-Win32 system.
Date: Thu,  3 Sep 2020 03:45:46 +0800
Message-Id: <20200902194546.1870-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.27.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x42e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

int qemu_lock_fd(int fd, int64_t start, int64_t len, bool exclusive);
int qemu_unlock_fd(int fd, int64_t start, int64_t len);
int qemu_lock_fd_test(int fd, int64_t start, int64_t len, bool exclusive);
bool qemu_has_ofd_lock(void);
---
 include/qemu/osdep.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 412962d91a..e80fddd1e8 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -502,11 +502,11 @@ int qemu_close(int fd);
 int qemu_unlink(const char *name);
 #ifndef _WIN32
 int qemu_dup(int fd);
-#endif
 int qemu_lock_fd(int fd, int64_t start, int64_t len, bool exclusive);
 int qemu_unlock_fd(int fd, int64_t start, int64_t len);
 int qemu_lock_fd_test(int fd, int64_t start, int64_t len, bool exclusive);
 bool qemu_has_ofd_lock(void);
+#endif
 
 #if defined(__HAIKU__) && defined(__i386__)
 #define FMT_pid "%ld"
-- 
2.27.0.windows.1


