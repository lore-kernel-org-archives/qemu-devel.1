Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B654C35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 16:12:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57D9520730
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 16:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cqSLSREB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57D9520730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz0oK-0002WP-I2
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 11:12:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38942)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iz0me-0000hM-WA
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 11:10:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iz0md-0006JU-SL
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 11:10:40 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35587)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iz0md-0006Hp-MY
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 11:10:39 -0500
Received: by mail-wr1-x444.google.com with SMTP id w12so12871750wrt.2
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2020 08:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=tVZj5PWkas+8lcb7utHknSBK8mar8lH4mTh5/qpvpIE=;
 b=cqSLSREB/SmOsC5h9q6IuwifGv7cXUPjezrzeLupfqEsriYUuW261pFi/1Yr3mhj28
 sDcKYWga83sxuHYFE2Tw+LGpdzOGLlqCrcJKSAiRkf1dJbT96I3xCgqBv6XkzZaCtvca
 wwfAUHTy6Lm+CghgCK4NBWZ2hoaNqo+ZDxc8axC0cioopQvNKWRvZfQccWrFYZ6HV2JP
 9Sbm+eC2Rw84qhQSGp8bye5RFWdTXQbkFrCqAro/YIfMe1F5HKj/qCtMbvjr86MPYMVk
 Z5OKTtOWz9YMINh00SMXmQnMsSavJ5elfy3qhkpBShsC9b2j7kLnnAAPZrv0u3bpCcfa
 ER3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=tVZj5PWkas+8lcb7utHknSBK8mar8lH4mTh5/qpvpIE=;
 b=VyBdncwPjHTNBGDMjwXr+lp9HNXs2ahi9FGQTc8UOcvWgPVSrVbdmR2tT1hBqoJCli
 Dh3Bo5FWz740B+I4rNs/LzFRWAdnk72yCNpKRBFmlrnHbLDqphMpwDjspKnH9NS6T3xL
 6XZS2IYMMJS3FGPxSDtn1St2l9i0Ck5d+0ST4fhPR13O2L/Q4BDvj5HYzFm9LXTVtp0d
 vqyBXsKnmCmMypdl0uM53OXuZXBBDRosOTxeBShGVAUyIg2dO5CVyeV+VvupdrqDcrzr
 Uk9IVheeQY4gGcCxWl8v6iRXiPDw/lG3RF3fD43X1Cl2S+QFyFIiTVJ9i3JOfgZvi/Bp
 0yJA==
X-Gm-Message-State: APjAAAXoazsRIdt35shNM5nANSi7dGdkJee7Incz+J6BNlGhiXJcugwx
 qVdszV3daEq5SMXM7+HVhCvspCdT
X-Google-Smtp-Source: APXvYqwaj5ad2GJGm4MqOKMu5F+7rP2meqCWmlUQis0iHav7O0aMaQltqTfh9Cnz4FjB9tSO3sVvLg==
X-Received: by 2002:a5d:5152:: with SMTP id u18mr22465081wrt.214.1580832638286; 
 Tue, 04 Feb 2020 08:10:38 -0800 (PST)
Received: from donizetti.redhat.com ([151.20.243.54])
 by smtp.gmail.com with ESMTPSA id 5sm28054599wrc.75.2020.02.04.08.10.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2020 08:10:37 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] exec: do not define use_icount for user-mode emulation
Date: Tue,  4 Feb 2020 17:10:36 +0100
Message-Id: <20200204161036.20889-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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

use_icount is also defined by stubs/cpu-get-icount.c, we do not need
to have a useless definition in exec.c.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 exec.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/exec.c b/exec.c
index 67e520d18e..5fc3746053 100644
--- a/exec.c
+++ b/exec.c
@@ -98,15 +98,15 @@ CPUTailQ cpus = QTAILQ_HEAD_INITIALIZER(cpus);
 /* current CPU in the current thread. It is only valid inside
    cpu_exec() */
 __thread CPUState *current_cpu;
-/* 0 = Do not count executed instructions.
-   1 = Precise instruction counting.
-   2 = Adaptive rate instruction counting.  */
-int use_icount;
 
 uintptr_t qemu_host_page_size;
 intptr_t qemu_host_page_mask;
 
 #if !defined(CONFIG_USER_ONLY)
+/* 0 = Do not count executed instructions.
+   1 = Precise instruction counting.
+   2 = Adaptive rate instruction counting.  */
+int use_icount;
 
 typedef struct PhysPageEntry PhysPageEntry;
 
-- 
2.21.0


