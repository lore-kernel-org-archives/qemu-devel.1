Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E26C3A59F
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 13:19:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6697420644
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 13:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TBQBwkWy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6697420644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyc98-000580-4e
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 09:19:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35122)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1hyc6i-0003Jo-IC
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:17:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hyc6g-0005KT-73
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:17:28 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44788)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hyc6e-0005Il-NS
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:17:24 -0400
Received: by mail-wr1-x443.google.com with SMTP id p17so1512037wrf.11
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2019 06:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=0ZnJsA94N8X7Cu7kfm4dOD2XBmDpwblF2KvIbDAt0vg=;
 b=TBQBwkWyuT6Stlizt1gHqQss/m5pVzDpeiWCTYtt/+L479Z1DkG+SdwtCM/DGxmg2Z
 vHTAuSYhijfBwHtcPEGqk2a6t3biEGyw8sjfPXXduoxB1GdldBAOdEtClXRdECr42cEH
 QQNCjxITB5r6ohTAWkW8lCQh+UZR0QvvYExaxMb6BRYfsLTqLSkuTdKmbVzFxYWbBvRG
 957ggFtXni9KfqTiq3MjRrZiIE0XRY9BxKe87nndLOo7jGjfTV1u61CrqECd6YtY6Fzq
 wWCJlJIPw4/V6Gxm9gj+gS1laY2jHlIyshHLFtdLjW/+Vvlbj00t/fXJMsgC5OeCL5Ip
 4BaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0ZnJsA94N8X7Cu7kfm4dOD2XBmDpwblF2KvIbDAt0vg=;
 b=JUHMarBuAiRmKMqrPzAs2OucAxhKTHHwmKKmo9pWzi5Uw8Vz3l8vzaK+7slaTWv3ip
 BJjrxitGTtU+Pz3vp+CX9YwGCfxv2X3/Ob46GbM5FbLoYHHszMAta0kmDNNdncpa7Al7
 uEgz84+Xt8Il33inrov8yt2PRIadWie6yQpv1VbH57DxGvYN7L7FhnNgz4ILXp9flO/v
 strMFb53FvgRMldaWw5UvTSFUZPn7j2p7Jb0knyv7AvBIw6eNb0EWkCe5kwSZ3S6Wv6+
 +/gJBZ+DIiUrYy7eQUtE0H34dZAOm3cTEcTj/VmKT0VVRscESPdy1YqOgJiDuDk0bqsC
 clUA==
X-Gm-Message-State: APjAAAV7980IWsQGhn89NQBygFExozNnNmsUvYq8Xuin7+r4WibJc0QU
 7pM+dDWOKMGFwbSi5AyYRZ2ZbKEArU/0hA==
X-Google-Smtp-Source: APXvYqyKqvPa1VJSPpgsSl6OFFleDEiFJGFezepRpT1QF7So9mhrR6JM0ElSwdmZa0+7aUQ1YV8W1Q==
X-Received: by 2002:a5d:518d:: with SMTP id k13mr11384527wrv.349.1565961442809; 
 Fri, 16 Aug 2019 06:17:22 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 4sm8705796wro.78.2019.08.16.06.17.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2019 06:17:21 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 16 Aug 2019 14:16:51 +0100
Message-Id: <20190816131719.28244-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190816131719.28244-1-peter.maydell@linaro.org>
References: <20190816131719.28244-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PULL 01/29] target/arm: generate a custom MIDR for
 -cpu max
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

From: Alex Bennée <alex.bennee@linaro.org>

While most features are now detected by probing the ID_* registers
kernels can (and do) use MIDR_EL1 for working out of they have to
apply errata. This can trip up warnings in the kernel as it tries to
work out if it should apply workarounds to features that don't
actually exist in the reported CPU type.

Avoid this problem by synthesising our own MIDR value.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190726113950.7499-1-alex.bennee@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h   |  6 ++++++
 target/arm/cpu64.c | 19 +++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 94c990cddbd..67f2af0e169 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1611,6 +1611,12 @@ FIELD(V7M_FPCCR, ASPEN, 31, 1)
 /*
  * System register ID fields.
  */
+FIELD(MIDR_EL1, REVISION, 0, 4)
+FIELD(MIDR_EL1, PARTNUM, 4, 12)
+FIELD(MIDR_EL1, ARCHITECTURE, 16, 4)
+FIELD(MIDR_EL1, VARIANT, 20, 4)
+FIELD(MIDR_EL1, IMPLEMENTER, 24, 8)
+
 FIELD(ID_ISAR0, SWAP, 0, 4)
 FIELD(ID_ISAR0, BITCOUNT, 4, 4)
 FIELD(ID_ISAR0, BITFIELD, 8, 4)
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 1901997a064..ee55237a9b2 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -296,6 +296,25 @@ static void aarch64_max_initfn(Object *obj)
         uint32_t u;
         aarch64_a57_initfn(obj);
 
+        /*
+         * Reset MIDR so the guest doesn't mistake our 'max' CPU type for a real
+         * one and try to apply errata workarounds or use impdef features we
+         * don't provide.
+         * An IMPLEMENTER field of 0 means "reserved for software use";
+         * ARCHITECTURE must be 0xf indicating "v7 or later, check ID registers
+         * to see which features are present";
+         * the VARIANT, PARTNUM and REVISION fields are all implementation
+         * defined and we choose to define PARTNUM just in case guest
+         * code needs to distinguish this QEMU CPU from other software
+         * implementations, though this shouldn't be needed.
+         */
+        t = FIELD_DP64(0, MIDR_EL1, IMPLEMENTER, 0);
+        t = FIELD_DP64(t, MIDR_EL1, ARCHITECTURE, 0xf);
+        t = FIELD_DP64(t, MIDR_EL1, PARTNUM, 'Q');
+        t = FIELD_DP64(t, MIDR_EL1, VARIANT, 0);
+        t = FIELD_DP64(t, MIDR_EL1, REVISION, 0);
+        cpu->midr = t;
+
         t = cpu->isar.id_aa64isar0;
         t = FIELD_DP64(t, ID_AA64ISAR0, AES, 2); /* AES + PMULL */
         t = FIELD_DP64(t, ID_AA64ISAR0, SHA1, 1);
-- 
2.20.1


