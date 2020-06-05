Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC67C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 04:20:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB9B4206E6
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 04:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O9JjXFcZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB9B4206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh3q9-0001cd-3y
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 00:20:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39472)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jh3nb-0004Jl-RC
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 00:17:43 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:52421)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jh3nb-0000jq-3V
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 00:17:43 -0400
Received: by mail-pj1-x1043.google.com with SMTP id k2so2054748pjs.2
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 21:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OQXnnFtOsPYN4aWlItYREcPDVPLVM/BSGRYhyFhu/u4=;
 b=O9JjXFcZnzH+YSBGRYdrGc/qCUzYaB6ZiEjMWnVqQCxxz/otE7MxzOQ/JMz9Y/Vw2D
 vnZd1Y2L/BM+yysvq91YzkFaUeTm3RZEDPqDKFilOIRiQ94V9s7GUFwsglPG7EeKEJm9
 grNbCjVQzE5Gi5+40pNdAxL8GG1Nre4Zfvsj3vPNWixXe3Y/26ynnUzoo3qP5XoXVY93
 eQy+1ClaHRVdRN7oTRgBHzjarax1ikbC4EfUrtEO116zJ0B51SeZx+Oit4FBgc7hcfYW
 j6sk6brBir2LeNo0J3XYoKcb/MpT0ObBcBKdlg2ZCsZeIXUVD29MxDZWV7i60sojO8XP
 6Crw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OQXnnFtOsPYN4aWlItYREcPDVPLVM/BSGRYhyFhu/u4=;
 b=J9mM6sWiH4iEZ9OHYBSCf+nPOv1XgLUi5Mba7wfvRqyIEU1bD/5hky+S12skFlT3vi
 ytimQCArHjrgh8ONpDsynO9xr17krpOXN91U1Op3dOgq7ReNdMKIy72S4rFfQ3WnXDiJ
 lLCvUuskdTP2LRu4Pwk13xZ4bQ5hp6DH/sLA20xUjIFqwUDUKGRwJar0WAivi6X8rBDw
 eavu522OBCzFrsIRii5zqEatGUdHQT0GBL2KAKXjxzZW+OliGU134TEDZXg55smncOOJ
 PAgKzYsB/3+7OZeqgMFnCc/9cXRPbnfCn7XhnApWNdVexjWuiOo8EdGnrMWyhqpW18Nk
 x3Iw==
X-Gm-Message-State: AOAM533Z90qvyILRhlx1ddLugZ/5ZOcti6hLMfesnpMwrQeXD32WyBCX
 8wkO+A6X7zACSX7CKs66UMlN9+1vpw8=
X-Google-Smtp-Source: ABdhPJwSXiiKJeWvqegpBNqwQbkNj0W8Q4QxCR9gp4LCzP0H/5dYuNCL5mh9zt+lGnEdhr5zBtKTCg==
X-Received: by 2002:a17:90a:9604:: with SMTP id
 v4mr768386pjo.198.1591330661509; 
 Thu, 04 Jun 2020 21:17:41 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id h15sm5440902pgl.12.2020.06.04.21.17.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2020 21:17:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 05/17] bsd-user: Tidy VERIFY_READ/VERIFY_WRITE
Date: Thu,  4 Jun 2020 21:17:21 -0700
Message-Id: <20200605041733.415188-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200605041733.415188-1-richard.henderson@linaro.org>
References: <20200605041733.415188-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1043.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These constants are only ever used with access_ok, and friends.
Rather than translating them to PAGE_* bits, let them equal
the PAGE_* bits to begin.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/qemu.h | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index f8bb1e5459..4076adabd0 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -218,13 +218,12 @@ extern unsigned long x86_stack_size;
 
 /* user access */
 
-#define VERIFY_READ 0
-#define VERIFY_WRITE 1 /* implies read access */
+#define VERIFY_READ  PAGE_READ
+#define VERIFY_WRITE (PAGE_READ | PAGE_WRITE)
 
-static inline int access_ok(int type, abi_ulong addr, abi_ulong size)
+static inline bool access_ok(int type, abi_ulong addr, abi_ulong size)
 {
-    return page_check_range((target_ulong)addr, size,
-                            (type == VERIFY_READ) ? PAGE_READ : (PAGE_READ | PAGE_WRITE)) == 0;
+    return page_check_range((target_ulong)addr, size, type) == 0;
 }
 
 /* NOTE __get_user and __put_user use host pointers and don't check access. */
-- 
2.25.1


