Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04735C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 22:23:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0BBC2072B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 22:23:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n/bkgiLt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0BBC2072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igylY-0001Wy-E1
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 17:23:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36771)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1igybF-00054h-8V
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 17:12:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1igybE-00079k-95
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 17:12:21 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:40699)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1igybE-00078L-43
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 17:12:20 -0500
Received: by mail-pl1-x643.google.com with SMTP id g6so5111665plp.7
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 14:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mulTmRahmIOLlqTACfJOIL2mZII2b44d4f9C0tQdiJE=;
 b=n/bkgiLtOwKptsu5Yu9ZypFXniYthcB8JwOUGpITS6/I0bEJ6z1+vRkNQXiqHRMR0Z
 yjQlWuCfd6HiW4SHebq+Adc7dmAVvvtlpabLmZ98E14xHoIALl7ZhBD5UXcBEujkSb45
 mVwkwdC4Bi91POt177JnsVWOkIVdydQZ1q5uhCHEZwpQn5Sv+giej9Ir9JGyqggOEYNT
 WaWehvRr0Q/a2EVbP7QjAUkhy7mXa+Of+51XthfKYCmK6LOoUtzI/IXb9KHiS3mboM7r
 0O7zqxQoWXPe0H956pmeKJm+fD5KUNF9FREPzFpy/bE34YnjzniRhCuiXGPRQXkSQp5Y
 B8Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mulTmRahmIOLlqTACfJOIL2mZII2b44d4f9C0tQdiJE=;
 b=AVXy/UOHE4P24NkFHAFUVl4YoAy9NpD078srq4V7wOx0si5T9MIzKsbWYo2Z7RvdDU
 sLGpyDMHAgDf7692zizGpNirN7UGbNzkPKTLB1m0GNw/f64u4SVSiOomLDvEhz2K5sgP
 YCXZPyvMJdwEG32B4yXrgYWi/dT/1RRBV81xMSYAWetH8LX1SqOGKHFoihWK9ukgAPe1
 xXM520A0ImZFCEGAORUtTHb6bvQB6VR0HXJU3GO2KQTbUBJCvIBMxa7ZhbfcX904YgPd
 lOuKVMH+l3ag0gyR13HlhVRR970saiOrzE5j9S4ku7b+qBNIB27FC6PakRD+qSj/yLWz
 r7bA==
X-Gm-Message-State: APjAAAXfQvqEu1qi3m60WTpBT1Lat0rX3gTa54tSMsBFnr/j8CeDU0+k
 YgibZhIUelge5JxfYR0nCVUuYhXFu6s=
X-Google-Smtp-Source: APXvYqxge64lkPMth3mKLN7x9Jki9FTLCZIO7p++Utw8VHYXsvPAkx0VFwwNWwHXMRmHxj3JU+/nQA==
X-Received: by 2002:a17:90a:ead5:: with SMTP id
 ev21mr1833451pjb.139.1576534338813; 
 Mon, 16 Dec 2019 14:12:18 -0800 (PST)
Received: from localhost.localdomain
 ([2605:e000:c74f:dc00:6838:d2b2:17e2:8445])
 by smtp.gmail.com with ESMTPSA id d6sm529767pjl.8.2019.12.16.14.12.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 14:12:18 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 11/28] accel/tcg: Include tcg.h in tcg-runtime.c
Date: Mon, 16 Dec 2019 12:11:41 -1000
Message-Id: <20191216221158.29572-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216221158.29572-1-richard.henderson@linaro.org>
References: <20191216221158.29572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Code movement in an upcoming patch will show that this file
was implicitly depending on tcg.h being included indirectly.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-runtime.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/accel/tcg/tcg-runtime.c b/accel/tcg/tcg-runtime.c
index 8a1e408e31..4ab2cf7f75 100644
--- a/accel/tcg/tcg-runtime.c
+++ b/accel/tcg/tcg-runtime.c
@@ -30,6 +30,7 @@
 #include "exec/tb-lookup.h"
 #include "disas/disas.h"
 #include "exec/log.h"
+#include "tcg.h"
 
 /* 32-bit helpers */
 
-- 
2.20.1


