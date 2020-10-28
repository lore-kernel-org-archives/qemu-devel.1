Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED337C388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 04:21:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CFF52076C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 04:21:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GFLEkcWq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CFF52076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXcxI-0003Cp-C4
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 00:21:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43404)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1kXcvF-0001JI-4P
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 00:18:53 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:35520)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1kXcvD-0007VQ-AB
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 00:18:52 -0400
Received: by mail-pg1-x544.google.com with SMTP id f38so2032510pgm.2
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 21:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7be69Z9NET5kIBJ2AmfgWFxcd4F4ui4S0AZTNTd2Vu4=;
 b=GFLEkcWqvIhCfftJhAYIocmUKkn5HXtoFRC5Jk+PVOes60Qa4Sw/ez3ieTqwL1P8xx
 icHQ0bZJwFtMNsIQERJZSOJnJUZwyG7xfBlKAIRuuWv64OujX2PzbzJo5ClI/efq17bH
 6E3OvIUXHObx85ZDKTNLXLFgADO3IVIyJ5WO1kgnDJ2bnpmzsy2Rn9b+NmvslUlyswg6
 kqUqX79eqFtx6iPIqm1F1gj23oIQcV9dgGhaK8t3Hsuo3oC++aDYpqztDRUhxCQay382
 qg9RhkarjOWrOghx8tbUkzN1NXSxWhYGCRH3Yry+/xXpstA3Kt3OQXeePEHHPfVMAlh+
 fTqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7be69Z9NET5kIBJ2AmfgWFxcd4F4ui4S0AZTNTd2Vu4=;
 b=KGwGIyV2UE61zJIo0fBQuZq+/RYabHUq702aRtVLi1Ff/odEcLJi/p+9PwES9WuljT
 2pnktbcUF3QMYFIeJ4LzLC8z+XJ0vgnxRburI01zmdsTxK6o/vbZwRtgSyko9Ngmoezv
 jFMEjO3ZEt0EHyY5VdsRSFRvOR7OqUxcmHS3AL2HUHObNQf+DSNWCR1dQvDzgQFsffPJ
 dtOYEC98wiMBH5xNVqWRcP/sCBWeHhftebeq6Olfbx9l5mh85B1RvhwRzTRIjZagio4x
 mmGtpo83KI4/qlQJCNJRl9QQvlL0EC16fVUzf/rkyY4duw0urkC/nXNHGLbYRnQz62Gh
 pPAA==
X-Gm-Message-State: AOAM530USv6OOdmhOFok7V/aspnxO9r1Q+pctHy5oPJJQFsm52Er24Gx
 wv48hkMIZBRN3P/Z2RqBBMk=
X-Google-Smtp-Source: ABdhPJyhch0wDGFlmeg8QTVNZ6Wi6BdteWX4snUQowdEJwsOWOJB0QItPLi71DNiSp75rEJLrO2PpA==
X-Received: by 2002:aa7:9a44:0:b029:155:8201:c61c with SMTP id
 x4-20020aa79a440000b02901558201c61cmr5612727pfj.31.1603858729946; 
 Tue, 27 Oct 2020 21:18:49 -0700 (PDT)
Received: from software.domain.org ([45.77.13.216])
 by smtp.gmail.com with ESMTPSA id x10sm3882040pfc.88.2020.10.27.21.18.46
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 27 Oct 2020 21:18:49 -0700 (PDT)
From: Huacai Chen <zltjiangshi@gmail.com>
X-Google-Original-From: Huacai Chen <chenhc@lemote.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Subject: [PATCH V15 3/6] hw/mips: Implement fw_cfg_arch_key_name()
Date: Wed, 28 Oct 2020 12:18:01 +0800
Message-Id: <1603858685-30701-4-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1603858685-30701-1-git-send-email-chenhc@lemote.com>
References: <1603858685-30701-1-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=zltjiangshi@gmail.com; helo=mail-pg1-x544.google.com
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


