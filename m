Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E32C35DEE
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 03:13:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 870DD206E6
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 03:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rd9NMi9o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 870DD206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Qeo-0001xP-QB
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 22:13:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46177)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j6Qe4-0000st-ST
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 22:12:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j6Qe3-0004ix-Ni
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 22:12:28 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:33170)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j6Qe3-0004ih-IO
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 22:12:27 -0500
Received: by mail-pf1-x444.google.com with SMTP id n7so6431656pfn.0
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2020 19:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=d8Ly0VNJpFv/+M9S/VrUvn0S3jXRNy+PHg7sk7apA00=;
 b=Rd9NMi9oUWRVQxlAOTEgLYHme8Hu6L3UN6UD2TjY62tP8sDkMTTBGIw9OiaU6MLqhZ
 xYR4+BZvYxQohUThPJsPrkHw8IfpQUybJJOIdIJhqNaFRzzLB9PWdHZk1cjDRwIdzNps
 0bc6xjHoPgtAbhJfKZNwDbIqXgavmOlDF4syKarQ153gEp9yjyPVhXQAHy+HB9l1v+4G
 YX8KZthxfwC+C85lgtK7f0JBcNxKmmG5ysp6PU0PNBWlLC6MI7TKUD8FCrnY8JU6l/2k
 ZtSR7fbJkvV/jqgLtUi2d+9pUuf3UPlfrfmTzpMbBWCNWD/AKxWD5QRpc2hKXSVHXTxI
 jXZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=d8Ly0VNJpFv/+M9S/VrUvn0S3jXRNy+PHg7sk7apA00=;
 b=Y0oV3DfgZhxPmwVz3zZIj2IVUT5uX48TjxcjpJMNU8o9yRv3RQIsmhGKGVLoZtD1i4
 r3TKFoXqHTJxZ3InWlSKK1IK1aZnBGTQbKCJMyQEHLZwX8jvmrv/uw5x72+/cC4bEIoG
 bR14+aPI3KZnXrhYkWpc/IIRHdruxuQbUi4+Z1pcfam0Zc9sC+5c7ACNQz0znk3O2smw
 fbZvfO1RSWynzmq/lu5Wdc+uDGPXL3pfxn0SRW9RmKxsPE2VvGHx4yVSy1hkiSWUPeI9
 +ikxLQhaR3GmipJzTV5gNWyo1gXW3pX64YUBswbo6DKPo+R3ycuUMc4Exz/2I54POmLN
 PMqw==
X-Gm-Message-State: APjAAAWmbK0+W2sPyZJBNnwE5DA3XVpF4NK8dDDd0su6QbmAFYQE64VU
 z4sFQP7LtBqxo0BX/Z7fg4GDEuLnPgM=
X-Google-Smtp-Source: APXvYqyh6wmEEB43c68etCej1tPor5LLbDhekIxqmSJWqWOsOzyysC/jDFpZXO6WtmsobkDxnmpDkQ==
X-Received: by 2002:a63:d18:: with SMTP id c24mr56127799pgl.218.1582600346167; 
 Mon, 24 Feb 2020 19:12:26 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id gc1sm884747pjb.20.2020.02.24.19.12.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2020 19:12:25 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/8] target/arm: Replicate TBI/TBID bits for single range
 regimes
Date: Mon, 24 Feb 2020 19:12:11 -0800
Message-Id: <20200225031222.15434-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200225031222.15434-1-richard.henderson@linaro.org>
References: <20200225031222.15434-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Replicate the single TBI bit from TCR_EL2 and TCR_EL3 so that
we can unconditionally use pointer bit 55 to index into our
composite TBI1:TBI0 field.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 79db169e04..c1dae83700 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -10297,7 +10297,8 @@ static int aa64_va_parameter_tbi(uint64_t tcr, ARMMMUIdx mmu_idx)
     } else if (mmu_idx == ARMMMUIdx_Stage2) {
         return 0; /* VTCR_EL2 */
     } else {
-        return extract32(tcr, 20, 1);
+        /* Replicate the single TBI bit so we always have 2 bits.  */
+        return extract32(tcr, 20, 1) * 3;
     }
 }
 
@@ -10308,7 +10309,8 @@ static int aa64_va_parameter_tbid(uint64_t tcr, ARMMMUIdx mmu_idx)
     } else if (mmu_idx == ARMMMUIdx_Stage2) {
         return 0; /* VTCR_EL2 */
     } else {
-        return extract32(tcr, 29, 1);
+        /* Replicate the single TBID bit so we always have 2 bits.  */
+        return extract32(tcr, 29, 1) * 3;
     }
 }
 
-- 
2.20.1


