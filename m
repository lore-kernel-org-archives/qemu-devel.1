Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9963EC7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 11:40:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6799522BEF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 11:40:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tQDUmgzU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6799522BEF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqya7-0001Gr-JH
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 07:40:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33745)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hqyZs-0000lx-Js
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 07:40:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hqyZq-0006lc-BL
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 07:39:59 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:55604)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hqyZp-0006Xi-QK
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 07:39:58 -0400
Received: by mail-wm1-x344.google.com with SMTP id a15so47737283wmj.5
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 04:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=WaF8faNbaMC6b8sFUPqaNVrTlOLU5CmNk1/jh7X2nao=;
 b=tQDUmgzUaMP9A5e9C0SDNMu+EyGpUrTR8iZJYcp6YP+/2/i7X4CRMpTu9XR5Oj+qcT
 kcJzx520wPA3hOxdwjep26HBg74h9YqjdLGtvqkaHSCeSPtuIBHMP6WCqdlIvaWkqyGe
 qEYPyQxWqZW+QzNfmTeVKI8OyU+zj0qehTSw9yCYUkGzef3uB183gCEmQlCra+VBJIMU
 2vUSu1mVFQtHgoC4Kvdi/mIxxvWRwv3ZyOoq8NOwKSAexxTQ1rDjFSGZkH2kf/OkgItF
 7Ilnm04AL3NFAMMBq0JRe/ECV3B7FLstvnh6z6YND6kwpGisqXf2Vfi2an5hXAxoxFHI
 CNhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=WaF8faNbaMC6b8sFUPqaNVrTlOLU5CmNk1/jh7X2nao=;
 b=EcbDLGVI3sg8NfpddASD9bTbyWog5LCmZ1NEa4yGFogsBGGB0lBXn2BwLBz7aJHMqF
 ytL1cSm2tQHl8YCiR8XVdjhX6hNm/eF8CaKQeLJ1mwt61UUHqBVuC7EMuuEhJZFkIO2F
 CGcxibQqoWBm0ZN1AS8Dkdp9SJYk5tiQY3Ab+KIJxn5h9p9+3efrLd+RfJ7sKtFX5x8v
 b7Mq05D4U9/BSqoISi2xoBX7EZRdqPO7B3uZthDO96D909SjHatMUEqEt17H0TMerUOr
 MXzF4X55/4ip1app5x+k8L29EBASigmw1LpcI2xE/i7r1pJhjiYoZQsPj6PB+ujiyjxQ
 +n2A==
X-Gm-Message-State: APjAAAVtVQSlZK9uyB5ZdOpVRVEinqbf8CLQswhgh3NjZcu8or1f2F19
 XO35ZT5jW6np3Ax8l98WOBJp8E2oR+s=
X-Google-Smtp-Source: APXvYqyfbez1aKllBT3+8oJWgz8kvcx1AoNQANeGMfuYRZCi+DzwX23QXNeLsBg0uzepj+/N38o3Gw==
X-Received: by 2002:a1c:7d4e:: with SMTP id y75mr85758489wmc.169.1564141194204; 
 Fri, 26 Jul 2019 04:39:54 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id 32sm45659185wrh.76.2019.07.26.04.39.52
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 26 Jul 2019 04:39:53 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A0B4E1FF87;
 Fri, 26 Jul 2019 12:39:52 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 26 Jul 2019 12:39:50 +0100
Message-Id: <20190726113950.7499-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PATCH v5] target/arm: generate a custom MIDR for -cpu
 max
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While most features are now detected by probing the ID_* registers
kernels can (and do) use MIDR_EL1 for working out of they have to
apply errata. This can trip up warnings in the kernel as it tries to
work out if it should apply workarounds to features that don't
actually exist in the reported CPU type.

Avoid this problem by synthesising our own MIDR value.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

---
v2
  - don't leak QEMU version into ID reg
v3
  - move comment into one block
  - explicit setting of more fields
v4
  - minor reword of comment
v5
  - VARIANT->PARTNUM and extra words
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


