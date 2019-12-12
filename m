Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC274C04E30
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 04:11:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A971C222C4
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 04:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NRs1fkXA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A971C222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifFp8-00066l-9C
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 23:11:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49863)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ifFf6-0000zn-0z
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 23:01:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ifFf0-0004KN-Ox
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 23:01:11 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:34368)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ifFf0-0004IA-Cg
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 23:01:06 -0500
Received: by mail-pg1-x541.google.com with SMTP id r11so446552pgf.1
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 20:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1+xmXAmgTNTTPDSwdxL19l0lBXnRZdS0RxSiPt4HA6M=;
 b=NRs1fkXAlBlr8nhYcs2w+dG0kVzfnp0SDVQ24ZMNfJrCTKbVQWybTtRw4PEpKfgu8D
 VYIesiwvr+Sr/xnftlttJAJ7EhJgnVDHid+1slaP2oJA9gxEHpzd2nKL4lYtckrYERQo
 P9VmYzIhS3UNC9ZnotLDKxSigIQq4pDDJWBRVPGpceTHygxuryTZOefJxQR/jMSPY7q+
 2LJ8J0xO6YBImstvtj7mlKHnqCPfTdLcT4XxTHG2DtrYSSEXYnNcoVLma8Xf0PitCLg8
 OAvEhh5Rk7WaIHKNapJ/v/EaPaSlWWckjW0uolMqb/jO1ssfWuHmi3AGNCGlWUzflt78
 sbdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1+xmXAmgTNTTPDSwdxL19l0lBXnRZdS0RxSiPt4HA6M=;
 b=JQGtXQ0foLBxju6O5nPZmeY7nEaFCk2KKi3NDEA540uT353zziuqrnpGfn1nzxAKac
 7Wkt3ovgC4Z+wbIat2K3Z3w1JNv8nmUU3GxYkBC/LH06MQg/JKCEAV4UwLrkAdfM3PbN
 s3uZsebvhAuVgxi2yPBshI8K7Qn9GeqyKE3RFHwh02Fe5DGCoyJspq8r8T//POpzDYGj
 Lf9o4gLRRoF0bIV1nUM38VNJ9RHLZhgx6ChiX60upwrn3t9rhX6vQbep35HM9z+EC8Hw
 OYAmkk/i+n44bn770jWQ/ibLNzKn8DHL7IdiikldxN7T0V5dv78IWMwawPnn/YPMOeAL
 i+LQ==
X-Gm-Message-State: APjAAAVVZoGRi1Z5pFLmoXKdn4bVHP8qMJTp1AhmwqBNOPvBbQ/zxFlD
 oyfDbvue0cKaksgNPuXVCrXg4ItOzXM=
X-Google-Smtp-Source: APXvYqymx17fMNZ4Hiz4qyHVW35zmHt618if9DLhz3rjOYpK8zkFe0JvRNnxseJcPV8YqYedqtyF5A==
X-Received: by 2002:a65:4506:: with SMTP id n6mr8287558pgq.105.1576123264992; 
 Wed, 11 Dec 2019 20:01:04 -0800 (PST)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id z130sm4666391pgz.6.2019.12.11.20.01.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2019 20:01:04 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 19/28] target/microblaze: Remove MMU_MODE{0,1,2}_SUFFIX
Date: Wed, 11 Dec 2019 20:00:30 -0800
Message-Id: <20191212040039.26546-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191212040039.26546-1-richard.henderson@linaro.org>
References: <20191212040039.26546-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The functions generated by these macros are unused.

Cc: Edgar E. Iglesias <edgar.iglesias@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/cpu.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 95773089aa..32522f606b 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -328,9 +328,6 @@ int cpu_mb_signal_handler(int host_signum, void *pinfo,
 #define cpu_signal_handler cpu_mb_signal_handler
 
 /* MMU modes definitions */
-#define MMU_MODE0_SUFFIX _nommu
-#define MMU_MODE1_SUFFIX _kernel
-#define MMU_MODE2_SUFFIX _user
 #define MMU_NOMMU_IDX   0
 #define MMU_KERNEL_IDX  1
 #define MMU_USER_IDX    2
-- 
2.20.1


