Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4927DC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 01:20:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A60920734
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 01:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AkB3uzpT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A60920734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgI5R-0000sv-6X
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 21:20:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48744)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgHyW-00042o-7C
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 21:13:48 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:33271)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgHyR-0003a2-5M
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 21:13:47 -0400
Received: by mail-pl1-x641.google.com with SMTP id t7so209481plr.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 18:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=C4qDuL752EiiSk3nsMH6iLKPjyLVOQMWVDOC2KEux/s=;
 b=AkB3uzpTGuxEieVSjMGtHxWwJlZmAJJoRb0uBkEqwza+LNGxNHjYgyjCmUNVa0gd6t
 iSKf+2SNR57eagpHllanngZWVqzWfV0cRdc91jOJZt529NQFne0GYs2+0oyqWA9K5wz9
 P0KZ6zE0EXyOJu5kCzNc/aJ/DyJ6avuxVcLBQZOpX3iYW5qqKGc4qC/nO3wIbpsmzx1W
 IGxzJK0uYMPZl3Y8AmsHqoxsmxLOeD0FAt5lGq5QYQQyCZVlaCMxt5aTMOmmyUDbAUkn
 DkanfPaCxZRqTS2Mc05PSHwKll2yGR3r80uJpQqCIKSPk8IzrML90PzwP+seXFevG7fa
 Na8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=C4qDuL752EiiSk3nsMH6iLKPjyLVOQMWVDOC2KEux/s=;
 b=SREb6Ry3pcDxmIdd3ndAYx5baiVUZN8Px/gTEUnw/tyfsDi+DwDahaYYgC4BnhRzcH
 BVQlHMSb6pPdiU1xebubxFmfMw45kvhh6tZgYhSqfpi9RZgWJkMQpO/pRFG26Mf8y8F6
 7uD5YlpXjTIhM3+mZ9J22QmFHZc2LNGeL4XlUiK2i1ENhAcFSVtf1GpEfKfCa3A8mWH2
 iLCYgm207Vvzmp+64aWR9jm0wbaurj5NpRPLNyyksgl8+gvJZKBjDHEkhFIM0slHh+LT
 3GiYpXc/eoclmF7QruHoGcruRMKFDBmvLwnaCb1HMg1TCWxkRfPr/cVRGSBTAnX3HyPH
 kung==
X-Gm-Message-State: AOAM530lj3HWzjpVIxDZhwBWE6N6aA+KtH3QohPRrHAhOrmOuG7PbsRk
 kH3Whdt/vYMAUtty0TDE4SxPpRpleC8=
X-Google-Smtp-Source: ABdhPJzq3aRvsMe/AuyWTP1GVS8eAGgFaoJUHNKyA9W0QeZpYUt1m+ocdMZ/tBrv/wlUhEV6P9aT/Q==
X-Received: by 2002:a17:902:9a43:: with SMTP id
 x3mr27532907plv.332.1591146820716; 
 Tue, 02 Jun 2020 18:13:40 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id 3sm290067pfe.85.2020.06.02.18.13.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2020 18:13:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 17/42] target/arm: Restrict the values of DCZID.BS under TCG
Date: Tue,  2 Jun 2020 18:12:52 -0700
Message-Id: <20200603011317.473934-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200603011317.473934-1-richard.henderson@linaro.org>
References: <20200603011317.473934-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x641.google.com
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

We can simplify our DC_ZVA if we recognize that the largest BS
that we actually use in system mode is 64.  Let us just assert
that it fits within TARGET_PAGE_SIZE.

For DC_GVA and STZGM, we want to be able to write whole bytes
of tag memory, so assert that BS is >= 2 * TAG_GRANULE, or 32.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 0f1a46f531..8e6d4371cb 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1754,6 +1754,30 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
     }
 #endif
 
+    if (tcg_enabled()) {
+        int dcz_blocklen = 4 << cpu->dcz_blocksize;
+
+        /*
+         * We only support DCZ blocklen that fits on one page.
+         *
+         * Architectually this is always true.  However TARGET_PAGE_SIZE
+         * is variable and, for compatibility with -machine virt-2.7,
+         * is only 1KiB, as an artifact of legacy ARMv5 subpage support.
+         * But even then, while the largest architectural DCZ blocklen
+         * is 2KiB, no cpu actually uses such a large blocklen.
+         */
+        assert(dcz_blocklen <= TARGET_PAGE_SIZE);
+
+        /*
+         * We only support DCZ blocksize >= 2*TAG_GRANULE, which is to say
+         * both nibbles of each byte storing tag data may be written at once.
+         * Since TAG_GRANULE is 16, this means that blocklen must be >= 32.
+         */
+        if (cpu_isar_feature(aa64_mte, cpu)) {
+            assert(dcz_blocklen >= 2 * TAG_GRANULE);
+        }
+    }
+
     qemu_init_vcpu(cs);
     cpu_reset(cs);
 
-- 
2.25.1


