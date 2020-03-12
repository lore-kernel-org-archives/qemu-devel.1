Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27BD2C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 19:51:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB1FD20637
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 19:51:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Abh9nIy3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB1FD20637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCTrZ-0005YK-51
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 15:51:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45519)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jCTjI-0005bn-2w
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:42:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jCTjF-000299-RR
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:42:51 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:37866)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jCTjF-00027R-LA
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:42:49 -0400
Received: by mail-pj1-x1043.google.com with SMTP id ca13so3080240pjb.2
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 12:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JBLvmRkIs5r/ZixfpsDU17HkY1c+JR6WvLvqW6Jbx1o=;
 b=Abh9nIy34f4vrATLK4BTPz6BBAZvbS71pZ5ZszSqUMR27+Qc+okyzXmeb35xH02mDm
 isUnSqL+4kG17rO50PX5Z2GXhA2X4OOz004+7zZqQfqKHOFlpfwN+5toDXg49+ywI9Lt
 2Lf65hgUU0z2akxJqgWWoEDPy6Ld9/SjjJsBnLonFDs0DWsIf3uNAq0goz1rv8ZNBgg+
 /c3VEgp1rl2vpNggfl5y7shTAidH+T/9Ef/bz8X7vF4nn2m/rH8jfHtyG8fPjDXa/np0
 BqKBS40NlrQL1NM+TTo6nyfXhPUbk0owGVveadB+iBxqXi0WnwTsp9x/VAOb3EKsaaaR
 whRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JBLvmRkIs5r/ZixfpsDU17HkY1c+JR6WvLvqW6Jbx1o=;
 b=pyWeyMcnCtyOswB0IsUF6PGy1qrd5O7/IXqtRub8fWk7vAZW2L/C262CIXylRT65L8
 ZTCxUGthegXMC5jq284MIqvgxRbWLOskPgKmjWRfTraujUhUgLv/HfobnLqMQjGeb93G
 K0mbHVkfbN0lHMcs2oFQi6qfc0RMlIIRiXvLgai/b7N45sWJjcc3Z3pM6kKKhxwiH5za
 2h0WthoLBz0DycI9ylzIGJLjjPervLyKFWyUuLGiwM6l687W6HEN2URUsc3hanwKE0se
 f4Q4qPrSN68L1B1oMj+B2iNNxK/H/D/iyx0cc/Fym750HIHz6QeNbSrAoZghAPVECvo5
 j8dw==
X-Gm-Message-State: ANhLgQ1zMyKVZGSXnT4f1lq1X49PIxcPj2e+IXH6v6xmx3Um7/HcJJxy
 CjARi38MDQy6XTOaEB+xyeN1i864tPE=
X-Google-Smtp-Source: ADFU+vuwmAcOJBVmF2P+40EMXgJNif9lwvugy9SmbpXCqxsh2KUTrwL1NMf3Eq1W0poT/qunLc7F+g==
X-Received: by 2002:a17:902:7d94:: with SMTP id
 a20mr9927958plm.307.1584042163358; 
 Thu, 12 Mar 2020 12:42:43 -0700 (PDT)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id g69sm6824842pje.34.2020.03.12.12.42.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 12:42:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 17/42] target/arm: Restrict the values of DCZID.BS under TCG
Date: Thu, 12 Mar 2020 12:41:54 -0700
Message-Id: <20200312194219.24406-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312194219.24406-1-richard.henderson@linaro.org>
References: <20200312194219.24406-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1043
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
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
index cb3c3fe8c2..96c20317ad 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1807,6 +1807,30 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
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
2.20.1


