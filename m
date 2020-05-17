Return-Path: <SRS0=EQsI=67=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE17C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 11:39:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3564C2070A
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 11:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hwjo/7Dg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3564C2070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaHe6-0005mz-AN
	for qemu-devel@archiver.kernel.org; Sun, 17 May 2020 07:39:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48882)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jaHcS-0004XN-Nq
 for qemu-devel@nongnu.org; Sun, 17 May 2020 07:38:14 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34344)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jaHcS-0001HE-5h
 for qemu-devel@nongnu.org; Sun, 17 May 2020 07:38:12 -0400
Received: by mail-wr1-x444.google.com with SMTP id y3so8519700wrt.1
 for <qemu-devel@nongnu.org>; Sun, 17 May 2020 04:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jdDbc6yPkbc/CrlTCOnabVx1wZ4fVwIoxaLDJHM44JU=;
 b=hwjo/7Dg32uRxQMnzoxAAVSlmOUbw0bT/PqAd9AfajmIASvEn8i4TmAP6c/I10ZS4D
 lIjUFjnb/G3VcHg2O6gONSJrSq1Y/pC5HsT0gNuHI6Hcc8y8D7DSgNd5CPRUqKhtqiQK
 htLq8ZkuD9gYNPIhAWZGe6zDQRvKKSahZXTFiCpDNS0D5w7U8s4l633V7BsIhhh9TknL
 BGjXUOrrFgc4AwiGy8FNp4+VeY5WwTlXTnO5ASTkfoaej+xllCPNk3tSb1sQXskg7vtH
 93SYGnXgtwNNiwBh/O6f9sFl9FoPy02FYwBClTcNHhixhkQhCUDn5tzRV+CLZtHFq88O
 9RFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=jdDbc6yPkbc/CrlTCOnabVx1wZ4fVwIoxaLDJHM44JU=;
 b=TlbGhQhC4yW2erfeKGInUEeiyBzBB9xPeSXH1lyfMxpmqn3J9LIh/VXD9qbV1hBbBk
 0FBqWbGvpZ1xdyvoP3JaeFrT0I334hpjdZ1aYjMRhEqsHWbggPA8QvbWr6RuXOQUcEC3
 98bw0G2Q/8RUe+cfNd2vOYnXMFdwKylFlyncxC9yRyauVppja+HK6taCwqEwvmgx+FnX
 AHMr3l4rSP8Jan4qybb6nU4XT2sARonlrVAIeZb0FX9OSY36RbMGU5R695O9GA1WYPdJ
 XcLkgdovJXepb4tO0H1tBe5qpnGIBsrDWhCFyTghF5j7ewJHjRD5bJq4zj7TZnQ+L2c8
 0rnQ==
X-Gm-Message-State: AOAM533hiAu2k7Xcrr+2jIZjBr+wOZLhDB4qzFIwV/UBqHGdOT4bTLNI
 22Mx0tyzmqCUWtPClmsJur4GySdR2w8=
X-Google-Smtp-Source: ABdhPJzwxMIAf6A/FNrwZ1+ntIC2QvC/quX6UNipYWLrBscJsflhDvvmWCC8a+Oqun3EfDTmCZKtvg==
X-Received: by 2002:adf:a3c5:: with SMTP id m5mr14944249wrb.390.1589715490429; 
 Sun, 17 May 2020 04:38:10 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id u10sm11660451wmc.31.2020.05.17.04.38.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2020 04:38:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 1/2] exec: Let memory_access_size() consider minimum valid
 access size
Date: Sun, 17 May 2020 13:38:03 +0200
Message-Id: <20200517113804.9063-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200517113804.9063-1-f4bug@amsat.org>
References: <20200517113804.9063-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Li Zhijian <lizhijian@cn.fujitsu.com>, Tony Nguyen <tony.nguyen@bt.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, Julia Suvorova <jusual@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Peter Xu <peterx@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As it is illegal to access a device with less that its
minimum valid size, also check for access_size_min.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 exec.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/exec.c b/exec.c
index 5162f0d12f..d3ec30f995 100644
--- a/exec.c
+++ b/exec.c
@@ -3066,10 +3066,14 @@ void memory_region_flush_rom_device(MemoryRegion *mr, hwaddr addr, hwaddr size)
 
 static int memory_access_size(MemoryRegion *mr, unsigned l, hwaddr addr)
 {
+    unsigned access_size_min = mr->ops->valid.min_access_size;
     unsigned access_size_max = mr->ops->valid.max_access_size;
 
     /* Regions are assumed to support 1-4 byte accesses unless
        otherwise specified.  */
+    if (access_size_min == 0) {
+        access_size_min = 1;
+    }
     if (access_size_max == 0) {
         access_size_max = 4;
     }
@@ -3082,11 +3086,14 @@ static int memory_access_size(MemoryRegion *mr, unsigned l, hwaddr addr)
         }
     }
 
-    /* Don't attempt accesses larger than the maximum.  */
-    if (l > access_size_max) {
+    /* Don't attempt accesses not in the minimum/maximum range.  */
+    if (l < access_size_min) {
+        l = access_size_min;
+    } else if (l > access_size_max) {
         l = access_size_max;
+    } else {
+        l = pow2floor(l);
     }
-    l = pow2floor(l);
 
     return l;
 }
-- 
2.21.3


