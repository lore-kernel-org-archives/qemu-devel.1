Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2448FC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:08:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA54B20665
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:08:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R5oQvlbF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA54B20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAgB2-0002iL-27
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 17:08:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35902)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg3b-0007rY-2Y
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:00:39 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b]:44497)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg3V-0001qC-PM
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:00:38 -0400
Received: by mail-pf1-x42b.google.com with SMTP id p11so5117211pfn.11
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 14:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Vc1/n0PAMq2ruFSCbPStrg/chGbNzuC4FGRX/oeXBs0=;
 b=R5oQvlbFGAfKmjmyBRfa6J9mJ8voFzS6uaYAEiBegjF8Ybm7zmrxb++6oXBTPpUGIS
 X3rnFDOQg0svTG2ch4+QjHK/6gyOLWYsmfG+4Koe5MYmWf1onPhO+sZ0LSBbfufAQlmK
 24RS8NJiO/efhbino9FMm3xrJ4WjjwONRX3Ej+ITXCtF5O3e7nJp3HfqW4SfYDiycyu6
 OqCbMtnAWdVrv1P7hvM1zMzYz27Njk/11O2N8l1CgugTc479c+NGaeaaPttqWoVwOf6f
 Glu/WYDU3lXE9Pw6Hv6MJF6u+3RsPo+J/OxTOxYNUk/7koIS4kHYw3NaP3XboT4eYZDe
 yr1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Vc1/n0PAMq2ruFSCbPStrg/chGbNzuC4FGRX/oeXBs0=;
 b=XZ3cayprUTLALxYymjI+rkm3PdaFfhlhD/XUDD9z6Jp0Cv0f+0Otp72Q34gRMZvMv2
 dWgGJ8rSooS5xyXs4puQsKRSzaLbpRw0dbC5ZXR/T4xmnmi+RiB1CbB1AZXT8uNXzp9X
 8jCTGqx1UJw57RkDB9m9qoD/ujWKcUFIaGjFz3E31TfK18pQH/QuYTVgKHBN6sAfrfZ8
 O5qVa66krui1zmdzqkC35gwYn27Z76EYMr357vQKH6a4GkDHuXG0yBpG5cK8//kSQ724
 w4jjMP2zCJ7jEksLaGOc6o2inG+R6yH7W3LGKfaXqFG+aRcyKuku84GeOvdG245Zy4xe
 Saxg==
X-Gm-Message-State: AOAM530FD+tXWFj78v4mHem7+8puMLRnzPByirJFXOKc1a21yRO5bV6F
 M80PNdrreFOggaBpgAPs3NohQQnZQAzI4A==
X-Google-Smtp-Source: ABdhPJzwZtwd0+ohHQI0l/0Jyk+Pf+OGnFMDMuJYcaEOQUttTSHF2QXQxrf6bHyF5wWQSjsnUlc7aw==
X-Received: by 2002:a17:902:8685:: with SMTP id
 g5mr9295390plo.201.1598389231778; 
 Tue, 25 Aug 2020 14:00:31 -0700 (PDT)
Received: from localhost.localdomain
 (h216-228-167-147.bendor.dedicated.static.tds.net. [216.228.167.147])
 by smtp.gmail.com with ESMTPSA id k4sm16074pgr.87.2020.08.25.14.00.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2020 14:00:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 31/77] target/microblaze: Remove DISAS_GNU
Date: Tue, 25 Aug 2020 13:59:04 -0700
Message-Id: <20200825205950.730499-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200825205950.730499-1-richard.henderson@linaro.org>
References: <20200825205950.730499-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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
Cc: edgar.iglesias@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is never used.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/translate.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index a90e56a17f..6757720776 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -34,7 +34,6 @@
 #include "exec/log.h"
 
 
-#define DISAS_GNU 1
 #define DISAS_MB 1
 #if DISAS_MB
 #  define LOG_DIS(...) qemu_log_mask(CPU_LOG_TB_IN_ASM, ## __VA_ARGS__)
-- 
2.25.1


