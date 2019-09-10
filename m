Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBDEBECDE27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 08:35:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D06A21479
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 08:35:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D06A21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7y5v-0001BE-1H
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 04:35:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57040)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1i7xvk-0007RU-4J
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 04:24:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1i7xvj-0006Qz-2E
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 04:24:47 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41405)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1i7xvi-0006Qi-Sr
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 04:24:47 -0400
Received: by mail-wr1-f68.google.com with SMTP id h7so22432693wrw.8
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 01:24:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=92TyKMJVZqYJ1sG0e0fGsni//VQCxIEBuXE2vZnuLSU=;
 b=tf2gYoCIx+auhtNM2Z2s3qcSRii/p70Qgc94BpjqwvYiYZEQaIS7OmM3+N5wiASiD9
 vmQVmgDVIjHLEDSPeWynnGz5+7Y8jqTqs5zdMiTqVjgz3yG+DkW4Xhna87DTnirc8FF4
 GCwamqhcbu58i8tGe5ylefR2SHwgiuvg6l4PLabbViuX9lOgJHRNMpi33CBJDreyjwk5
 HXIYi/9ukkmtg4WZtVk8spZc47g3nMoYFbr4zu1+R7oNtqv0opqrmSdcH8+5onHb3aED
 swxHjTDq67e2lNNVYXnoOd/F3PTTVMpkHFAo0OtDqJDaSn819HGqKF1F1ria7U9lHPFa
 16DQ==
X-Gm-Message-State: APjAAAUm5McloETjzqcc7pnAQP3jOb273ZiFv7dyWx9B8kHxJw3Fnd6f
 luY5qgVqgZXRj8sgqrH7D+930Q==
X-Google-Smtp-Source: APXvYqwDK11TTw79/z98st8PiM//6SWGwXKKfruRtjYHVssroUDTejAIHpN4CLSF/ik7ILJtsJMl1A==
X-Received: by 2002:adf:dcc4:: with SMTP id x4mr21464894wrm.221.1568190285688; 
 Wed, 11 Sep 2019 01:24:45 -0700 (PDT)
Received: from localhost ([148.69.85.38])
 by smtp.gmail.com with ESMTPSA id c132sm2301142wme.27.2019.09.11.01.24.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2019 01:24:45 -0700 (PDT)
Date: Tue, 10 Sep 2019 12:04:34 -0700
Message-Id: <20190910190513.21160-9-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190910190513.21160-1-palmer@sifive.com>
References: <20190910190513.21160-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: [Qemu-devel] [PULL 08/47] target/riscv: Update the Hypervisor CSRs
 to v0.4
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
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alistair Francis <alistair.francis@wdc.com>

Update the Hypervisor CSR addresses to match the v0.4 spec.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/cpu_bits.h | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 11f971ad5d..e99834856c 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -173,6 +173,24 @@
 #define CSR_SPTBR           0x180
 #define CSR_SATP            0x180
 
+/* Hpervisor CSRs */
+#define CSR_HSTATUS         0x600
+#define CSR_HEDELEG         0x602
+#define CSR_HIDELEG         0x603
+#define CSR_HCOUNTERNEN     0x606
+#define CSR_HGATP           0x680
+
+#if defined(TARGET_RISCV32)
+#define HGATP_MODE           SATP32_MODE
+#define HGATP_VMID           SATP32_ASID
+#define HGATP_PPN            SATP32_PPN
+#endif
+#if defined(TARGET_RISCV64)
+#define HGATP_MODE           SATP64_MODE
+#define HGATP_VMID           SATP64_ASID
+#define HGATP_PPN            SATP64_PPN
+#endif
+
 /* Physical Memory Protection */
 #define CSR_PMPCFG0         0x3a0
 #define CSR_PMPCFG1         0x3a1
@@ -206,23 +224,6 @@
 #define CSR_DPC             0x7b1
 #define CSR_DSCRATCH        0x7b2
 
-/* Hpervisor CSRs */
-#define CSR_HSTATUS         0xa00
-#define CSR_HEDELEG         0xa02
-#define CSR_HIDELEG         0xa03
-#define CSR_HGATP           0xa80
-
-#if defined(TARGET_RISCV32)
-#define HGATP_MODE           SATP32_MODE
-#define HGATP_ASID           SATP32_ASID
-#define HGATP_PPN            SATP32_PPN
-#endif
-#if defined(TARGET_RISCV64)
-#define HGATP_MODE           SATP64_MODE
-#define HGATP_ASID           SATP64_ASID
-#define HGATP_PPN            SATP64_PPN
-#endif
-
 /* Performance Counters */
 #define CSR_MHPMCOUNTER3    0xb03
 #define CSR_MHPMCOUNTER4    0xb04
-- 
2.21.0


