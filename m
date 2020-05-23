Return-Path: <SRS0=y3lU=7F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B94DC433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2020 07:24:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A3FF20723
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2020 07:24:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MzYW72E/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A3FF20723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcOWR-0006CJ-G8
	for qemu-devel@archiver.kernel.org; Sat, 23 May 2020 03:24:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59784)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jcOVt-0005nK-BU
 for qemu-devel@nongnu.org; Sat, 23 May 2020 03:24:09 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:32770)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jcOVs-0004P6-JV
 for qemu-devel@nongnu.org; Sat, 23 May 2020 03:24:08 -0400
Received: by mail-ej1-x643.google.com with SMTP id n24so15515037ejd.0
 for <qemu-devel@nongnu.org>; Sat, 23 May 2020 00:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=zfj/K0NOkayq1/NKLky/5FnpRFFc2VNC0nzV2Dfh8KY=;
 b=MzYW72E/f2VYumiK+XzCn+yON5rhdnPXwAlTj97v7TWHt5HW4ohSfo6R58nGY9kyp7
 /Y+VImxHhpOHZo1Yo//palBo6RZO4j0NNIqM+ZkSAu0xiB3H6h/+WKb+f6omMcvSBU3S
 j2fNRyN2jmKUIDK9TcQn5qQcMG25vtzcGFpeGexYXtmsve7XzgCg2Qb6G4ycnUMqeK0E
 M+fIY202wIcvSLttDaCJ7Yry35Kc5Md2wsZymb+nuM3c1W/m+0By0LUnjQyu6U5gNeNB
 lSlAQdwLrd9Qob4nhcLbasr6xZFChC/7BoU3SMzi1xlc/clm+97el60jGNtDFSrCnX/3
 N5zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=zfj/K0NOkayq1/NKLky/5FnpRFFc2VNC0nzV2Dfh8KY=;
 b=l501L8rRDX1Nd4FYUDc1yRsQeLSHMhWri0MBrIfJctZnEPSDA9qIoLtIKsChAl/NtD
 fIwO3WMOVUZJIpMOpOjuGt0vBiHMPiyO2pGwyvAzMBdwPKerox74LhtMZ/h482a6gNoR
 EDqqYW1TQxJJpk5CsGBKFVaoHzM6X77eW+eIt8L4ek5+4YHTv1TNWVOrw/2Nd3cOhH2W
 f1ThbGLw61zpqhSwJeFlpavThYKx0/qH+hpvtwjsjqywuSizW/MOZykedhmwd4ZS5XzS
 pP36oi5YiTW+9ya/AwYk72U4AQlaM+SXzTx4bsTUPlapGwH6awpgSuDIshWPu2piat8T
 CJ9Q==
X-Gm-Message-State: AOAM531q3auaF+XyQiQKjddo3SqAsWAg3oITaiU3GBa2KXMDEbBHqTl/
 M9Cig9XcwZsGUB7Q+9faaLaJn6FVDgjMw54tjKZtg/v3CDMJ4g==
X-Google-Smtp-Source: ABdhPJxCKXNVm84RLXaInaBEoNB0/2NINvIwr8c+lhQcXZx7Gh+XNudLYn8ag+H7q0HUgaWoMcK90cxsogicdJbDZgA=
X-Received: by 2002:a17:906:90c1:: with SMTP id
 v1mr10782091ejw.322.1590218646125; 
 Sat, 23 May 2020 00:24:06 -0700 (PDT)
MIME-Version: 1.0
From: David CARLIER <devnexen@gmail.com>
Date: Sat, 23 May 2020 08:23:55 +0100
Message-ID: <CA+XhMqwMsmoYwNtkrvAEG_j_-8L=+PYcXSz--1Qg622szArkRQ@mail.gmail.com>
Subject: [PATCH 1/1] util/oslib: Returns real thread identifier on FreeBSD and
 NetBSD
To: qemu-devel@nongnu.org, bauerchen@tencent.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=devnexen@gmail.com; helo=mail-ej1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

Hi this is my first contribution hope it s useful . Regards.
From ca7fcd85e0453f7173ce73732905463bc259ee32 Mon Sep 17 00:00:00 2001
From: David Carlier <devnexen@gmail.com>
Date: Sat, 23 May 2020 08:17:51 +0100
Subject: [PATCH] util/oslib: returns real thread identifier on FreeBSD and
 NetBSD

Signed-off-by: David Carlier <devnexen@gmail.com>
---
 util/oslib-posix.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 062236a1ab..4d28dfd8f5 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -48,11 +48,13 @@
 #ifdef __FreeBSD__
 #include <sys/sysctl.h>
 #include <sys/user.h>
+#include <sys/thr.h>
 #include <libutil.h>
 #endif

 #ifdef __NetBSD__
 #include <sys/sysctl.h>
+#include <lwp.h>
 #endif

 #include "qemu/mmap-alloc.h"
@@ -84,6 +86,13 @@ int qemu_get_thread_id(void)
 {
 #if defined(__linux__)
     return syscall(SYS_gettid);
+#elif defined(__FreeBSD__)
+    // thread id is up to INT_MAX
+    long tid;
+    thr_self(&tid);
+    return (int)tid;
+#elif defined(__NetBSD__)
+    return _lwp_self();
 #else
     return getpid();
 #endif
-- 
2.26.2

