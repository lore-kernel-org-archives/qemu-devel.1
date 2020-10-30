Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9717C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 10:31:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09EAC20704
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 10:31:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FY57G7+e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09EAC20704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYRgu-0005YE-Q5
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 06:31:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48788)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1kYRdI-0000zw-Fi
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 06:27:44 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431]:42840)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1kYRdG-0001dq-Kh
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 06:27:44 -0400
Received: by mail-pf1-x431.google.com with SMTP id x13so4858471pfa.9
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 03:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7be69Z9NET5kIBJ2AmfgWFxcd4F4ui4S0AZTNTd2Vu4=;
 b=FY57G7+elJDLYBn5QT5mCYZcEgMM5ex8cHzWCx7Z8fn5jQpNyAdUsZXX5Vi0Wzw2kD
 owcjFTtfJW7j+5VMT/0cXSBZG2RlecvY3tUne7f8xoGJnl7KNpzYU3iomRvpeE6550Pk
 HzId4Ig1ISYo6MIFVRutHK7crWCM5MF0tRth5XQXdltcPIKPuSv4RcSlwRtevPTyBD+4
 5WEZQOCAgAnayXbLPPm10wKYYWsWR4hLjD0XtPmsOX2sj2fEcegrpY84lsrd2t9KrBcA
 WdAtcmvr9xzGAIO+271yiVxKGJS+AB5zPksRHbMmgPXqcBP4sgUIzOApSnp0uMEtpAgX
 i0yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7be69Z9NET5kIBJ2AmfgWFxcd4F4ui4S0AZTNTd2Vu4=;
 b=Zz0R3mqduuEMTwHUO7rfPRmB/P2y8Fz6ehBwe2NhHEc9RkKB/4tq+qYq4M4yzHyEbq
 R3XwK72kV1NnmVXANkuemvOiZlKeAJDAgnGtILqW+Jne7Cbqt6YTEiydOh3zsgYFTSAb
 sysk3hWWkLcyGTPddyLiUH8Ttm9lU9nlg/s5Gu9/2LAuf3nwcIi4bpCp5er1IbUVQJRk
 v1M1otCECpa8xlmTEsCwrlDPws+6WYu5M0d4bdQJ60VSc0XKNEPEe9WKHpfoCQ/RraE8
 hi1lxJBvaR0L19yeRI2jba7N+mKCUBHZIk3otZlWTnwB9kuJqiTnip2BuvRKohGSXF+9
 /BRA==
X-Gm-Message-State: AOAM533ntFBIkTmoTIWPdtP2711lt3iqk7HTABnOs5FGV0676W0zqkhm
 Y03OelFCOw9e8uHZU/JS+48=
X-Google-Smtp-Source: ABdhPJzRHxVEvTJ6/zddijLQVuQmKe48K4E3FtHPIkXg6oYntDforWzVsFdMcbo5sRnYf6LJv7d1Kw==
X-Received: by 2002:a63:f40a:: with SMTP id g10mr1623037pgi.66.1604053661199; 
 Fri, 30 Oct 2020 03:27:41 -0700 (PDT)
Received: from software.domain.org ([45.77.13.216])
 by smtp.gmail.com with ESMTPSA id v79sm6062146pfc.197.2020.10.30.03.27.37
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 30 Oct 2020 03:27:40 -0700 (PDT)
From: Huacai Chen <zltjiangshi@gmail.com>
X-Google-Original-From: Huacai Chen <chenhc@lemote.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Subject: [PATCH V16 3/6] hw/mips: Implement fw_cfg_arch_key_name()
Date: Fri, 30 Oct 2020 18:25:38 +0800
Message-Id: <1604053541-27822-4-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1604053541-27822-1-git-send-email-chenhc@lemote.com>
References: <1604053541-27822-1-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=zltjiangshi@gmail.com; helo=mail-pf1-x431.google.com
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
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhc@lemote.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Implement fw_cfg_arch_key_name(), which returns the name of a
mips-specific key.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Huacai Chen <chenhc@lemote.com>
Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 hw/mips/fw_cfg.c    | 35 +++++++++++++++++++++++++++++++++++
 hw/mips/fw_cfg.h    | 19 +++++++++++++++++++
 hw/mips/meson.build |  2 +-
 3 files changed, 55 insertions(+), 1 deletion(-)
 create mode 100644 hw/mips/fw_cfg.c
 create mode 100644 hw/mips/fw_cfg.h

diff --git a/hw/mips/fw_cfg.c b/hw/mips/fw_cfg.c
new file mode 100644
index 0000000..67c4a74
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
index 0000000..e317d5b
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
index 46294b7..c98391c 100644
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
2.7.0


