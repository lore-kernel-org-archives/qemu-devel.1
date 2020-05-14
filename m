Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F368C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:39:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E6C1205CB
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HQY6ZRW/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E6C1205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZF1R-000376-Hu
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 10:39:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39594)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZEkV-0003VE-Sv
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:22:14 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:45764)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZEkR-0005l5-Ss
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:22:11 -0400
Received: by mail-wr1-x443.google.com with SMTP id v12so4315520wrp.12
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 07:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=fnV23OpPxCoSIZpEIyS3Xorm1PSAB8juwD7uMO6vdoo=;
 b=HQY6ZRW/frko9i4nrT6ffiBsFjKcV3owfRlU3zWi/YPPSBrwTs2KIXhoFWfLdnYoMt
 8UPUnUgjpocDR6PbjCWrDXASGRidzp7q4Da9DoDnUutYs7O0KoAAWLAIW7SKFoKhOgsh
 j2CuwUH6ufH1YBsHiQk6UtgdpbpPVIkgkRXoMRtvFmgRX2MJlbg2dPCQPJ7IyvMezLWl
 34NUDEVrOOgG8UW5agjx76tBQP02f5g7q67demYAsDmEBmLSPelW3uFwI23gP9ejFfv4
 hn9qobuC3AbyVQZ6td8tquUYfqElWNA+BswFJtp58wllmwQo1FH6VYJ0MJdLUA76SE/V
 Pm7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fnV23OpPxCoSIZpEIyS3Xorm1PSAB8juwD7uMO6vdoo=;
 b=Y2o19xh/SWL5WeCbZujiDNXH4hqDVpfD+em2EQpAvDVdCmJIQwZ9XqjfKxp+HpnN+O
 bCZrCprr0lTSStFa2XcA5tApDnAfuGQux/MsJOo3LQbQooQFUOKxlggh02mSItr4x3G2
 uFf2Zri84kbW7Dj6k6SEJ+N0eYbIsneWade/M4LosXPPnIbqVNSMXE3acRDypPjN+aAv
 su+LckNMYTHr5zMBTX9vFwGQ9R9vU9tKFs3a0FVfP4M6gY9qaYU5PXwenA+hMvosNFxu
 +dufnBubNeQlBHQBKyxx9r2ytwofmt3086tAXOtBvu1Mc5nDYfZpjGz2pXDpLlAoP3Oh
 TFWw==
X-Gm-Message-State: AOAM532jo9L+3yhIsV8By7Fw48hzw+okh5xVJ4uqk9U4qPJ7PnYNcP6D
 c8zs2bf/bMxqDqviifwMQvk3VhumnuN24g==
X-Google-Smtp-Source: ABdhPJwlhyb9H2mHjp6qr+b6g+4GLqR36EDCRTz7FuptSx7pg2c4xrt4JqpcxWnGjxQj3Rs2x0N0eQ==
X-Received: by 2002:adf:afdb:: with SMTP id y27mr5463944wrd.323.1589466126197; 
 Thu, 14 May 2020 07:22:06 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 88sm4077443wrq.77.2020.05.14.07.22.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2020 07:22:05 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/45] acpi: nvdimm: change NVDIMM_UUID_LE to a common macro
Date: Thu, 14 May 2020 15:21:12 +0100
Message-Id: <20200514142138.20875-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514142138.20875-1-peter.maydell@linaro.org>
References: <20200514142138.20875-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x443.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Dongjiu Geng <gengdongjiu@huawei.com>

The little end UUID is used in many places, so make
NVDIMM_UUID_LE to a common macro to convert the UUID
to a little end array.

Reviewed-by: Xiang Zheng <zhengxiang9@huawei.com>
Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
Message-id: 20200512030609.19593-2-gengdongjiu@huawei.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/qemu/uuid.h | 27 +++++++++++++++++++++++++++
 hw/acpi/nvdimm.c    | 10 +++-------
 2 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/include/qemu/uuid.h b/include/qemu/uuid.h
index 129c45f2c5e..9925febfa54 100644
--- a/include/qemu/uuid.h
+++ b/include/qemu/uuid.h
@@ -34,6 +34,33 @@ typedef struct {
     };
 } QemuUUID;
 
+/**
+ * UUID_LE - converts the fields of UUID to little-endian array,
+ * each of parameters is the filed of UUID.
+ *
+ * @time_low: The low field of the timestamp
+ * @time_mid: The middle field of the timestamp
+ * @time_hi_and_version: The high field of the timestamp
+ *                       multiplexed with the version number
+ * @clock_seq_hi_and_reserved: The high field of the clock
+ *                             sequence multiplexed with the variant
+ * @clock_seq_low: The low field of the clock sequence
+ * @node0: The spatially unique node0 identifier
+ * @node1: The spatially unique node1 identifier
+ * @node2: The spatially unique node2 identifier
+ * @node3: The spatially unique node3 identifier
+ * @node4: The spatially unique node4 identifier
+ * @node5: The spatially unique node5 identifier
+ */
+#define UUID_LE(time_low, time_mid, time_hi_and_version,                    \
+  clock_seq_hi_and_reserved, clock_seq_low, node0, node1, node2,            \
+  node3, node4, node5)                                                      \
+  { (time_low) & 0xff, ((time_low) >> 8) & 0xff, ((time_low) >> 16) & 0xff, \
+    ((time_low) >> 24) & 0xff, (time_mid) & 0xff, ((time_mid) >> 8) & 0xff, \
+    (time_hi_and_version) & 0xff, ((time_hi_and_version) >> 8) & 0xff,      \
+    (clock_seq_hi_and_reserved), (clock_seq_low), (node0), (node1), (node2),\
+    (node3), (node4), (node5) }
+
 #define UUID_FMT "%02hhx%02hhx%02hhx%02hhx-" \
                  "%02hhx%02hhx-%02hhx%02hhx-" \
                  "%02hhx%02hhx-" \
diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
index fa7bf8b5075..9316d12b702 100644
--- a/hw/acpi/nvdimm.c
+++ b/hw/acpi/nvdimm.c
@@ -27,6 +27,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/uuid.h"
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/aml-build.h"
 #include "hw/acpi/bios-linker-loader.h"
@@ -34,18 +35,13 @@
 #include "hw/mem/nvdimm.h"
 #include "qemu/nvdimm-utils.h"
 
-#define NVDIMM_UUID_LE(a, b, c, d0, d1, d2, d3, d4, d5, d6, d7)             \
-   { (a) & 0xff, ((a) >> 8) & 0xff, ((a) >> 16) & 0xff, ((a) >> 24) & 0xff, \
-     (b) & 0xff, ((b) >> 8) & 0xff, (c) & 0xff, ((c) >> 8) & 0xff,          \
-     (d0), (d1), (d2), (d3), (d4), (d5), (d6), (d7) }
-
 /*
  * define Byte Addressable Persistent Memory (PM) Region according to
  * ACPI 6.0: 5.2.25.1 System Physical Address Range Structure.
  */
 static const uint8_t nvdimm_nfit_spa_uuid[] =
-      NVDIMM_UUID_LE(0x66f0d379, 0xb4f3, 0x4074, 0xac, 0x43, 0x0d, 0x33,
-                     0x18, 0xb7, 0x8c, 0xdb);
+      UUID_LE(0x66f0d379, 0xb4f3, 0x4074, 0xac, 0x43, 0x0d, 0x33,
+              0x18, 0xb7, 0x8c, 0xdb);
 
 /*
  * NVDIMM Firmware Interface Table
-- 
2.20.1


