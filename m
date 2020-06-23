Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58CD6C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 19:54:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2014B2080C
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 19:54:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RvwN7JqU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2014B2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnozc-0001sZ-C3
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 15:54:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42194)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jnojZ-0003yK-Qq
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 15:37:29 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:38307)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jnojW-0005hU-77
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 15:37:29 -0400
Received: by mail-pf1-x442.google.com with SMTP id x207so10563514pfc.5
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 12:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=HXdDbBi3bOiwXrXGTwrvFGKvOYNgFlf/lfsSkNgOuZg=;
 b=RvwN7JqUBDJu4NNvDP1Pi3tXUvQOkwbwPz6nncUYuJwgmJVsDU9zHH2Z246coIbanQ
 3An/HmpLr1VCZYjQEicbhPMsnSxrfGxgHUS6lNVsB5IrQWbAvk1LKm3iv/vPmKm5D8Wc
 txEF1MKiDrcQpZpSudoyzilhuqNoJZfTykRbXbZM3rYBIFo5dWJRBrVMTVt/wDptzu4E
 ugagcgLoB5Na8mowuVlAEIY+2KdTigxAZIU6WGScTzU1C9xb9Napsb8HK4Vt1WxXIIuE
 CfK54Mw0T7c013UOwG8fHq8KRBmRY4t8ZKYfEBg6vFABDMfCJUF38Xr+QhDwJ2ec4Xfo
 /FIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HXdDbBi3bOiwXrXGTwrvFGKvOYNgFlf/lfsSkNgOuZg=;
 b=GBWPc3J0fl63s1Or1Ld1Xbf8GhapLOAtM1WpGnr47L5E0VUcsAjGY9Sf/AZncs9dli
 6Dfp/Vx3EASk6MxAbsREzeo1dn/ktNLiCWHOgaaMwwA2rVemUsPT6xfPgbk6bCas+C1q
 lii1hBFEea91VWMNWDJziRXkRE0l1ZDl4NaPlis718nxrIvvjq8Vv7jOVer/2/Rw+G+E
 ZO+vDDdQCNMitwYjaYJaLlqwhBinZsDKMl6x6KP0viP/y5Gl4hOlks/Q+RF8pHb/eA/0
 cgc4fCTF2tknf5Fq3etQDIuR/BoEfveO0ZFtoNmmAKNL2zweo5igY7LjSlUsG9+SuuTp
 HoPw==
X-Gm-Message-State: AOAM530gRI6lijO/iLizyRd5WTGs8DlSu1OhkZaBHiK+HFyb3kGW3spN
 PPJdbhBGLeDOCw5ZsxmRpeleA+0//Fo=
X-Google-Smtp-Source: ABdhPJytNTDKXCMsnBDLwlHL+aHwsVjh5taOoYmzoYWfXwK06bDZe2HtD5Ghu8ah7EeWL/H7u9vgqA==
X-Received: by 2002:a62:1b82:: with SMTP id
 b124mr25980743pfb.172.1592941044414; 
 Tue, 23 Jun 2020 12:37:24 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id p12sm17927642pfq.69.2020.06.23.12.37.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 12:37:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 17/45] target/arm: Restrict the values of DCZID.BS under TCG
Date: Tue, 23 Jun 2020 12:36:30 -0700
Message-Id: <20200623193658.623279-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200623193658.623279-1-richard.henderson@linaro.org>
References: <20200623193658.623279-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, david.spickett@linaro.org,
 steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We can simplify our DC_ZVA if we recognize that the largest BS
that we actually use in system mode is 64.  Let us just assert
that it fits within TARGET_PAGE_SIZE.

For DC_GVA and STZGM, we want to be able to write whole bytes
of tag memory, so assert that BS is >= 2 * TAG_GRANULE, or 32.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 10677c0c23..f09efc4370 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1758,6 +1758,30 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
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


