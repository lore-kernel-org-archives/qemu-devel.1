Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0334BC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 17:05:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C440620899
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 17:05:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XZ6oMUt8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C440620899
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrP7j-0004sl-TN
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 13:05:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50082)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrOxD-0004p4-SZ
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:54:23 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:34158)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrOxC-0005fw-3X
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:54:23 -0400
Received: by mail-wr1-x42d.google.com with SMTP id f7so30413038wrw.1
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 09:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=W1X/QFKetqy4Cccjm+5hRIiHrC/Te/v1h263Fqb3yTg=;
 b=XZ6oMUt82NR/6x98+Unfy/x/28+AIltZsqU+UyGjszIwnwTGPuy5GIMT2dBi3Uh+rN
 NEvny0x3+Knlb9vM1gxD/iyyc8fYiVkUsRaza6aUst6ROCxYE/sq0Rq3QNa/zwYw6E2B
 aaLPZYhRIuVz2AU7j8yESBWliCTGMn5BVNTz2WwuzLOcvTP73JQY2bU2cP8/jBzTLmjJ
 UNr8ilwTv5tJjjWXfq3JBYfVkOK6n2Uaon+xfNseS1EOWLIZNQA7eKeKK6ZATBhQR3xz
 EfV3wTjPjlD3eSSBKV4WdcQUWg+4Iyv1NiFHVkqIv1DpKaqMUIdcK1ZvoKOKrzfQJaIq
 BuZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=W1X/QFKetqy4Cccjm+5hRIiHrC/Te/v1h263Fqb3yTg=;
 b=Wv7w2hEuBRofkHcRPy6k9qTvibWmmBb1dUa6dASltmpHhlLUU4zMuUefk9GIXd6lfL
 wSR+yYWoYg/IHZg4zOhLb8GHLYwIpy2DyDSWYyzw9omi1io2irGjTBusrhmBXP/FR3LU
 Ecly6mecxbhVwG2/ZTl1XltgK0EFeqgbiCzfnWtEEIrSBi2BvZBrEa3gOP084VOE/IIO
 5V3fMwrmLaWTiW58EAEkSa+VWKv3E0s+sIW9qSZsexgd2eLNLF89xGQ1EBjlBxhmahKT
 QDD9Y0oBxlY219xZ2PE8Ad8L270N3o04YtUrwePfR7Wk3zEx3Ui0clOQxKce0gxwIrKS
 BpBw==
X-Gm-Message-State: AOAM530KRQFTSTl6aIVGbYfFQ7dT695NBu9CjKF1g001DQAfRvmvh+vz
 6cN8c6G9gRUWaIsInS7pOI9ts8D+JPR9zA==
X-Google-Smtp-Source: ABdhPJwO+ihx/pIPQgvLfymxiNriQOL1SlM4VfI1jX7aB7GeAAtBCBbCqpS3+uDeIhm7dl+APpzgoQ==
X-Received: by 2002:adf:de8d:: with SMTP id w13mr37058191wrl.129.1593795260370; 
 Fri, 03 Jul 2020 09:54:20 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j15sm5574224wrx.69.2020.07.03.09.54.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 09:54:19 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/34] tests/acpi: virt: allow DSDT acpi table changes
Date: Fri,  3 Jul 2020 17:53:43 +0100
Message-Id: <20200703165405.17672-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200703165405.17672-1-peter.maydell@linaro.org>
References: <20200703165405.17672-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

From: Andrew Jones <drjones@redhat.com>

Signed-off-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Message-id: 20200629140938.17566-3-drjones@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8bf..32a401ae35f 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,4 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/virt/DSDT",
+"tests/data/acpi/virt/DSDT.memhp",
+"tests/data/acpi/virt/DSDT.numamem",
-- 
2.20.1


