Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27EA9C433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 10:47:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD31520775
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 10:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rQbPvDP7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD31520775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDmm0-000069-00
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 06:47:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55304)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kDmfx-00069g-8A; Thu, 03 Sep 2020 06:41:05 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:37926)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kDmfv-0002Hh-7d; Thu, 03 Sep 2020 06:41:04 -0400
Received: by mail-pj1-x1043.google.com with SMTP id ls14so1267367pjb.3;
 Thu, 03 Sep 2020 03:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=tu0atc0QVqkObDFB/8D8Fwge3UArGpjBnQ7mD77F3Sk=;
 b=rQbPvDP73DP6TA74RcYFhjSNHYq5tejkM1mDO9DgyxX1s9R6Sqb5FXFz1JIlEiRdrv
 dgv2ceU5kvT/pNMbqLmhLJljZjhSZIzldKcNoa5eHbklqdU4iV9+E+8EeGhC3GJDOiQb
 5eQzy8taV49NWUlkLVsyIm1+n76vnPkTjLCmBYZbCJjrlFIUki1D28mqQzzDXJV4t48S
 bo1bQErZm4bW8AA6l9d/kHQypM8Yj9i/oK8dFAFxDeZH47ZapaO0z+ZZJpoT5lHOjGMY
 SVEwKayJJYOnj6zuj5CBnTQvqO0TVYPCmfyJ2SHn9roh3nZ0+TD0b7HwL8SxGsHGTadw
 giNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=tu0atc0QVqkObDFB/8D8Fwge3UArGpjBnQ7mD77F3Sk=;
 b=McP7vjYpulO66NjQLAO/XAIaVJ3AEJfX+ZbskvF6Lz9yYUO3DcjDkyeVu+Vij89x/e
 fhmT98H3cTVaDBP6PQYcPuKgqRFQwmo9YPqohoCyRCvGAOxHPiy7NqsUUsCNuEyKcR5+
 vO4hHqzpu7PV4UdIO/1zGV6HzLa9dD0tXGfXGubEo+3ZGQGzvna4ZEIjoNc+8URUP+0V
 1VgUldkhPL6uoTcbL/ZZTaGrRgcrL8pv2RpVoViyHGYsMd+TY+3yvx+qB3e6FGi4Aodu
 eFnKi3SuPncDEmRU/VDjHV0+3nK9O7M6T5uyTjeLZlTj9glqPCxmoMlxGL5rAsGF4Rsy
 1LQg==
X-Gm-Message-State: AOAM532jAWM4mCcEauxOFLIV6LTcB6+uhgyGi+M6VztoRY3CQUDte3B+
 KFep08YDPmqlpvBPKpJ1djk=
X-Google-Smtp-Source: ABdhPJw9vSjbXYlp/n+brmxuqm3nAWOXKXarotRIu7PzH7pnZbMEOlNKLBHeqcVBuHTS1iPbWdBfiQ==
X-Received: by 2002:a17:90a:ed8e:: with SMTP id
 k14mr2745994pjy.178.1599129661654; 
 Thu, 03 Sep 2020 03:41:01 -0700 (PDT)
Received: from pek-vx-bsp2.wrs.com (unknown-146-144.windriver.com.
 [147.11.146.144])
 by smtp.gmail.com with ESMTPSA id b18sm2137098pjq.3.2020.09.03.03.40.59
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 03 Sep 2020 03:41:01 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH 09/12] hw/riscv: Move sifive_test model to hw/misc
Date: Thu,  3 Sep 2020 18:40:20 +0800
Message-Id: <1599129623-68957-10-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599129623-68957-1-git-send-email-bmeng.cn@gmail.com>
References: <1599129623-68957-1-git-send-email-bmeng.cn@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pj1-x1043.google.com
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
Cc: Bin Meng <bin.meng@windriver.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

This is an effort to clean up the hw/riscv directory. Ideally it
should only contain the RISC-V SoC / machine codes plus generic
codes. Let's move sifive_test model to hw/misc directory.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
---

 include/hw/{riscv => misc}/sifive_test.h | 0
 hw/{riscv => misc}/sifive_test.c         | 2 +-
 hw/riscv/virt.c                          | 2 +-
 hw/misc/Kconfig                          | 3 +++
 hw/misc/meson.build                      | 1 +
 hw/riscv/Kconfig                         | 1 +
 hw/riscv/meson.build                     | 1 -
 7 files changed, 7 insertions(+), 3 deletions(-)
 rename include/hw/{riscv => misc}/sifive_test.h (100%)
 rename hw/{riscv => misc}/sifive_test.c (98%)

diff --git a/include/hw/riscv/sifive_test.h b/include/hw/misc/sifive_test.h
similarity index 100%
rename from include/hw/riscv/sifive_test.h
rename to include/hw/misc/sifive_test.h
diff --git a/hw/riscv/sifive_test.c b/hw/misc/sifive_test.c
similarity index 98%
rename from hw/riscv/sifive_test.c
rename to hw/misc/sifive_test.c
index 0c78fb2..45d9399 100644
--- a/hw/riscv/sifive_test.c
+++ b/hw/misc/sifive_test.c
@@ -25,7 +25,7 @@
 #include "qemu/module.h"
 #include "sysemu/runstate.h"
 #include "hw/hw.h"
-#include "hw/riscv/sifive_test.h"
+#include "hw/misc/sifive_test.h"
 
 static uint64_t sifive_test_read(void *opaque, hwaddr addr, unsigned int size)
 {
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 0caab8e..41bd2f3 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -30,12 +30,12 @@
 #include "hw/char/serial.h"
 #include "target/riscv/cpu.h"
 #include "hw/riscv/riscv_hart.h"
-#include "hw/riscv/sifive_test.h"
 #include "hw/riscv/virt.h"
 #include "hw/riscv/boot.h"
 #include "hw/riscv/numa.h"
 #include "hw/intc/sifive_clint.h"
 #include "hw/intc/sifive_plic.h"
+#include "hw/misc/sifive_test.h"
 #include "chardev/char.h"
 #include "sysemu/arch_init.h"
 #include "sysemu/device_tree.h"
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index fa3d0f4..3185456 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -134,6 +134,9 @@ config MAC_VIA
 config AVR_POWER
     bool
 
+config SIFIVE_TEST
+    bool
+
 config SIFIVE_E_PRCI
     bool
 
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 018a88c..bd24132 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -22,6 +22,7 @@ softmmu_ss.add(when: 'CONFIG_ARM11SCU', if_true: files('arm11scu.c'))
 softmmu_ss.add(when: 'CONFIG_MOS6522', if_true: files('mos6522.c'))
 
 # RISC-V devices
+softmmu_ss.add(when: 'CONFIG_SIFIVE_TEST', if_true: files('sifive_test.c'))
 softmmu_ss.add(when: 'CONFIG_SIFIVE_E_PRCI', if_true: files('sifive_e_prci.c'))
 softmmu_ss.add(when: 'CONFIG_SIFIVE_U_OTP', if_true: files('sifive_u_otp.c'))
 softmmu_ss.add(when: 'CONFIG_SIFIVE_U_PRCI', if_true: files('sifive_u_prci.c'))
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index a046157..8e07100 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -61,6 +61,7 @@ config RISCV_VIRT
     select SIFIVE
     select SIFIVE_CLINT
     select SIFIVE_PLIC
+    select SIFIVE_TEST
 
 config MICROCHIP_PFSOC
     bool
diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
index da32148..3cf9380 100644
--- a/hw/riscv/meson.build
+++ b/hw/riscv/meson.build
@@ -4,7 +4,6 @@ riscv_ss.add(files('numa.c'))
 riscv_ss.add(when: 'CONFIG_HART', if_true: files('riscv_hart.c'))
 riscv_ss.add(when: 'CONFIG_OPENTITAN', if_true: files('opentitan.c'))
 riscv_ss.add(when: 'CONFIG_RISCV_VIRT', if_true: files('virt.c'))
-riscv_ss.add(when: 'CONFIG_SIFIVE', if_true: files('sifive_test.c'))
 riscv_ss.add(when: 'CONFIG_SIFIVE_E', if_true: files('sifive_e.c'))
 riscv_ss.add(when: 'CONFIG_SIFIVE_U', if_true: files('sifive_u.c'))
 riscv_ss.add(when: 'CONFIG_SPIKE', if_true: files('spike.c'))
-- 
2.7.4


