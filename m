Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08154C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 07:03:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F92820720
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 07:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SXFtPziu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F92820720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTJmD-0000sx-TA
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 03:03:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56934)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1kTJcR-0007ji-FW
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 02:53:39 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:56239)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1kTJcP-0000bF-Gv
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 02:53:39 -0400
Received: by mail-pj1-x1044.google.com with SMTP id ds1so838882pjb.5
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2020 23:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OY9FgndC5NCT/kJU4s296hBSZjcokEukKyx3eYnf/rg=;
 b=SXFtPziuKZjAdYJrraEiIZfesjbW6JMw8aRY1Yx1WYB8MpuuFpzq7htubgZ7O353z+
 D/S04/Bipjk0pWd9PES7c08QbLuV+Q0jpxF6nKE2+A4KYqMDWNvvJTq/1RneUa55S9+r
 38NJMYB82lP1JBWv7VpXt59tAynpCRYHwkYniF4ZZsUJ5gEu7jCsZd3gL+fm6Kw4o4Qo
 yf7QJlIIXTM1mWlAwpejO0dcpSYPLOoRhCSOasEuVv2NjiGZQZSiMQN5AP9kPZEqNlMo
 RZGeu1M/ptH6CeNIgZR7d6S1cSMDG1YD9qQfTb3CrS5RECkj34lh2bLF5GCIE+5F85lc
 cWwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OY9FgndC5NCT/kJU4s296hBSZjcokEukKyx3eYnf/rg=;
 b=qBNWZcxC1tcrSFhiSULlmIn+YrqXolKWK1dgMCejajika9z9v6t5AAR2nZGvCRNkNX
 yLEC3/fm5oD95kHx42MbMs/kID8fvBsnUC38zWVGHiJUnA1dze6UGOL5hj3zmCaZUFSU
 q5PoIfo82SvNzJ0FTX3nVB8Bd8d4rxSyMuKYwxpmo1qiG/wih7rfq+6IZWN8kHm3zVnj
 F5l5EsLcotY7xqFiu20exlXIfZSzjf+V2okGzd4VoVA7s45m9Q4Wt4irRAswSm1RF4s7
 3dOL2PyfLbejl/JRtDb82KqZNj1UZV6EPawJiIRdLL0gzpTVNrhxE4kJUyQQWHwHA1ix
 P+yg==
X-Gm-Message-State: AOAM531U0550fvUt1XYkf5/1zDfXKxoTw+R57V8RUIPwpFgW2iPxs0iA
 K2tOsxEEMV2DdwSrQQ/deQY=
X-Google-Smtp-Source: ABdhPJyZ4Qh+01ZREVS+K9byAWg/Vc3xGXqo5PzU3yGMzrs787kj54sG+X3ocsu46bH4YCpFFHG/+w==
X-Received: by 2002:a17:90a:19db:: with SMTP id
 27mr2584553pjj.110.1602831215116; 
 Thu, 15 Oct 2020 23:53:35 -0700 (PDT)
Received: from software.domain.org ([45.77.13.216])
 by smtp.gmail.com with ESMTPSA id v21sm1552200pjg.44.2020.10.15.23.53.31
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 15 Oct 2020 23:53:34 -0700 (PDT)
From: Huacai Chen <zltjiangshi@gmail.com>
X-Google-Original-From: Huacai Chen <chenhc@lemote.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Subject: [PATCH V14 5/8] hw/mips: Implement fw_cfg_arch_key_name()
Date: Fri, 16 Oct 2020 14:51:57 +0800
Message-Id: <1602831120-3377-6-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1602831120-3377-1-git-send-email-chenhc@lemote.com>
References: <1602831120-3377-1-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=zltjiangshi@gmail.com; helo=mail-pj1-x1044.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
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


