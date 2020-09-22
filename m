Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1741CC4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 02:57:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8156D239A1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 02:57:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPW37UKJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8156D239A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKYUn-00039P-Is
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 22:57:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47914)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1kKYPh-0005mN-8N
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 22:52:17 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:50884)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1kKYPe-0002WY-KT
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 22:52:16 -0400
Received: by mail-pj1-x1042.google.com with SMTP id fa1so784799pjb.0
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 19:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=YUIHrzcMqn9UNrbIZOFvqCxooTJnO+VVGg31sZJLmPU=;
 b=dPW37UKJSQrlJIYcqcHH26/x7A1HPf/vrYHD97Co1dyrwVyZb+KUAyzznEKas8lwbr
 xjyTzuNhSOQxxGbD431JVwu1vSUZr7b+hJ48FZu7e/kwZLcj29L7uCVSJr7xuRei1hdJ
 uInkrcOe3uwTAR4oiUFvV3ZNK8YsyzSGYAeRNq5XhaVJWDHYw5mI1Jrcl/jA+i3UHNXJ
 9kuzboMN2IiWFQnPG8SfZMWc7FI9lXwHTj2v+jXwtlvKp6fNfirk8BfdUa4Xs9a9BFbh
 K+M5EcAAevP9ryHRzl1usNyRVFmgvfpNhwkIi01JskdoNGESU0NcCH5CPAwgtMqZJWHC
 qH1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=YUIHrzcMqn9UNrbIZOFvqCxooTJnO+VVGg31sZJLmPU=;
 b=QxdaDLhTcyC4TM89hzjJK6FTIE7IbhVIncSAWMiXvTVS01hdeq7PtwUMp6fUsa2h2Z
 bkUpXfYjdj6a9yOXKhUPk8/cbNhpQ3ERQ9hBAGfNpo8sm7309eOgGJzZJHm2Z92RxtuD
 29kLYhi0zKvydDKpPXBs8mzrEThQEk0/1saALaF/NmbHmWeQCMzD/tctESxL1sHB6VoE
 L0mUXYRINSd4F514jnK8u+hnynnyAHrh4edheFZN7gEq+TKz2wKuQCHnM3NlOiQcUl3J
 8ehPG397diGdUdxtG7kDrSpjg0lPB5DEnuDJrRqxl1fdA3ky8iXhudPFYiM4AmTrzxrA
 VBSA==
X-Gm-Message-State: AOAM531j3cS03DeuI2w9tWCjuCc/UwL2WFDSgVmyaez2wSoF+8imNs1N
 Sj9qb3eK/M7FpyjKkcm42zo=
X-Google-Smtp-Source: ABdhPJw/gpg05bB2Cszgd5AhUuO6luH2oA4KSp96J16Q6uAeJxtZpU+ANLqx15YG0GlKCbmG8QIOYg==
X-Received: by 2002:a17:90b:164e:: with SMTP id
 il14mr1871974pjb.5.1600743131346; 
 Mon, 21 Sep 2020 19:52:11 -0700 (PDT)
Received: from software.domain.org ([45.77.13.216])
 by smtp.gmail.com with ESMTPSA id q4sm13263677pfs.193.2020.09.21.19.52.07
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 21 Sep 2020 19:52:10 -0700 (PDT)
From: Huacai Chen <zltjiangshi@gmail.com>
X-Google-Original-From: Huacai Chen <chenhc@lemote.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Subject: [PATCH V10 6/8] hw/mips: Implement fw_cfg_arch_key_name()
Date: Tue, 22 Sep 2020 10:49:25 +0800
Message-Id: <1600742967-12933-7-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1600742967-12933-1-git-send-email-chenhc@lemote.com>
References: <1600742967-12933-1-git-send-email-chenhc@lemote.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=zltjiangshi@gmail.com; helo=mail-pj1-x1042.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Huacai Chen <chenhuacai@gmail.com>, qemu-devel@nongnu.org,
 Huacai Chen <chenhc@lemote.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Implement fw_cfg_arch_key_name(), which returns the name of a
mips-specific key.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 hw/mips/fw_cfg.c    | 35 +++++++++++++++++++++++++++++++++++
 hw/mips/fw_cfg.h    | 19 +++++++++++++++++++
 hw/mips/meson.build |  2 +-
 3 files changed, 55 insertions(+), 1 deletion(-)
 create mode 100644 hw/mips/fw_cfg.c
 create mode 100644 hw/mips/fw_cfg.h

diff --git a/hw/mips/fw_cfg.c b/hw/mips/fw_cfg.c
new file mode 100644
index 0000000000..67c4a74f4b
--- /dev/null
+++ b/hw/mips/fw_cfg.c
@@ -0,0 +1,35 @@
+/*
+ * QEMU fw_cfg helpers (MIPS specific)
+ *
+ * Copyright (c) 2020 Lemote, Inc.
+ *
+ * Author:
+ *   Huacai Chen (chenhc@lemote.com)
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/mips/fw_cfg.h"
+#include "hw/nvram/fw_cfg.h"
+
+const char *fw_cfg_arch_key_name(uint16_t key)
+{
+    static const struct {
+        uint16_t key;
+        const char *name;
+    } fw_cfg_arch_wellknown_keys[] = {
+        {FW_CFG_MACHINE_VERSION, "machine_version"},
+        {FW_CFG_CPU_FREQ, "cpu_frequency"},
+    };
+
+    for (size_t i = 0; i < ARRAY_SIZE(fw_cfg_arch_wellknown_keys); i++) {
+        if (fw_cfg_arch_wellknown_keys[i].key == key) {
+            return fw_cfg_arch_wellknown_keys[i].name;
+        }
+    }
+    return NULL;
+}
diff --git a/hw/mips/fw_cfg.h b/hw/mips/fw_cfg.h
new file mode 100644
index 0000000000..e317d5b9a3
--- /dev/null
+++ b/hw/mips/fw_cfg.h
@@ -0,0 +1,19 @@
+/*
+ * QEMU fw_cfg helpers (MIPS specific)
+ *
+ * Copyright (c) 2020 Huacai Chen
+ *
+ * SPDX-License-Identifier: MIT
+ */
+
+#ifndef HW_MIPS_FW_CFG_H
+#define HW_MIPS_FW_CFG_H
+
+#include "hw/boards.h"
+#include "hw/nvram/fw_cfg.h"
+
+/* Data for BIOS to identify machine */
+#define FW_CFG_MACHINE_VERSION  (FW_CFG_ARCH_LOCAL + 0)
+#define FW_CFG_CPU_FREQ         (FW_CFG_ARCH_LOCAL + 1)
+
+#endif
diff --git a/hw/mips/meson.build b/hw/mips/meson.build
index 46294b7382..c98391ce99 100644
--- a/hw/mips/meson.build
+++ b/hw/mips/meson.build
@@ -1,5 +1,5 @@
 mips_ss = ss.source_set()
-mips_ss.add(files('addr.c', 'mips_int.c'))
+mips_ss.add(files('addr.c', 'mips_int.c', 'fw_cfg.c'))
 mips_ss.add(when: 'CONFIG_FULOONG', if_true: files('fuloong2e.c'))
 mips_ss.add(when: 'CONFIG_JAZZ', if_true: files('jazz.c'))
 mips_ss.add(when: 'CONFIG_MALTA', if_true: files('gt64xxx_pci.c', 'malta.c'))
-- 
2.17.2


