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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B3AC433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 10:42:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AF5D20716
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 10:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J0hROt1I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AF5D20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDmgt-0007XT-K0
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 06:42:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55176)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kDmfg-0005dc-Tb; Thu, 03 Sep 2020 06:40:48 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:34323)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kDmff-0002B1-2E; Thu, 03 Sep 2020 06:40:48 -0400
Received: by mail-pf1-x441.google.com with SMTP id v196so2010881pfc.1;
 Thu, 03 Sep 2020 03:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=8Zj7s7kXmzr2lI2HnuVfE43cFixL7CM5rG/130yS5Ic=;
 b=J0hROt1ICD0aLJOruYu7Q1yyNWjz4OBJLkZjq/LIrJAjeSNRKrmDDkHVeSmT/i/VVM
 bF31KIQXJcleYHVDJ8E/FSmTpjwVQd9vKfsix9EnQvOyX+o7VUJ57maytuY7LSio/FXT
 ra2Qxtx1sh0GD9O1U7hBs0qcdkQTCfb7WD0njgSV21ay/JoqMwZPjv/Xknbc4I5lKPjV
 63Nrmq16BDraOxtdE2x/j2yAh41lPxFSdH2afSSOoxPBUd/9B6EwRIpeKLdxSdFciwrw
 BvWNW64ToYWZjxYVzOthLqjnCc0KlwQGt9Kq+woNo+GS833E70gCUfDAAoEKmDyxEDFY
 DRzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=8Zj7s7kXmzr2lI2HnuVfE43cFixL7CM5rG/130yS5Ic=;
 b=FeaDxyKgT6+H3bg5dz3EV8W0EvVM35L5ifU3gWlgtOYKoANyWS8L2HBENzePB62OV5
 Y+yVKiAaSmjQfHGeEHHyR1P4y4jHxmuRuxdVqYlFO5vfkL2GrcM7anMy/875zQLcw4EB
 sDH7g+XJYaYoVOl3ynexoSMsMHxQzp9wu3nTTqJq5FOOAiUXVsEhaIhjLsDQkcwtKKu2
 Ls1JME+vyXfeIedoYFzMjJOSgoB/JBCGtSmEvmenVQcPM5ckrztcdJhbNH4rYkvBzQGY
 OBQzKX+ixQE3ASzTLNjv/3uwft3cq5kLPtnRyXUlicUix+UeERNlUWR8banRTJ4hAKUX
 JCIA==
X-Gm-Message-State: AOAM5333DEiOVilzZFvH3DidIQGqNBEoGEhaNMGmjt8VGtOM/0ZNGg8k
 yhKQprL75KCrBKb5oWggPls=
X-Google-Smtp-Source: ABdhPJwbiaMobmHaTg3eucQm8X2JetEdR1wfmEZhkHmGV877kXpPhLy6BhOx0dtfvUhLxAwLQUYKdg==
X-Received: by 2002:a17:902:6bc2:: with SMTP id
 m2mr3303704plt.114.1599129644320; 
 Thu, 03 Sep 2020 03:40:44 -0700 (PDT)
Received: from pek-vx-bsp2.wrs.com (unknown-146-144.windriver.com.
 [147.11.146.144])
 by smtp.gmail.com with ESMTPSA id b18sm2137098pjq.3.2020.09.03.03.40.42
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 03 Sep 2020 03:40:43 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH 02/12] hw/riscv: Move sifive_u_prci model to hw/misc
Date: Thu,  3 Sep 2020 18:40:13 +0800
Message-Id: <1599129623-68957-3-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599129623-68957-1-git-send-email-bmeng.cn@gmail.com>
References: <1599129623-68957-1-git-send-email-bmeng.cn@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pf1-x441.google.com
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
codes. Let's move sifive_u_prci model to hw/misc directory.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
---

 include/hw/{riscv => misc}/sifive_u_prci.h | 0
 include/hw/riscv/sifive_u.h                | 2 +-
 hw/{riscv => misc}/sifive_u_prci.c         | 2 +-
 hw/misc/Kconfig                            | 3 +++
 hw/misc/meson.build                        | 1 +
 hw/riscv/Kconfig                           | 1 +
 hw/riscv/meson.build                       | 1 -
 7 files changed, 7 insertions(+), 3 deletions(-)
 rename include/hw/{riscv => misc}/sifive_u_prci.h (100%)
 rename hw/{riscv => misc}/sifive_u_prci.c (99%)

diff --git a/include/hw/riscv/sifive_u_prci.h b/include/hw/misc/sifive_u_prci.h
similarity index 100%
rename from include/hw/riscv/sifive_u_prci.h
rename to include/hw/misc/sifive_u_prci.h
diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
index 793000a..cbeb228 100644
--- a/include/hw/riscv/sifive_u.h
+++ b/include/hw/riscv/sifive_u.h
@@ -24,8 +24,8 @@
 #include "hw/riscv/riscv_hart.h"
 #include "hw/riscv/sifive_cpu.h"
 #include "hw/riscv/sifive_gpio.h"
-#include "hw/riscv/sifive_u_prci.h"
 #include "hw/riscv/sifive_u_otp.h"
+#include "hw/misc/sifive_u_prci.h"
 
 #define TYPE_RISCV_U_SOC "riscv.sifive.u.soc"
 #define RISCV_U_SOC(obj) \
diff --git a/hw/riscv/sifive_u_prci.c b/hw/misc/sifive_u_prci.c
similarity index 99%
rename from hw/riscv/sifive_u_prci.c
rename to hw/misc/sifive_u_prci.c
index 4fa590c..5d9d446 100644
--- a/hw/riscv/sifive_u_prci.c
+++ b/hw/misc/sifive_u_prci.c
@@ -22,7 +22,7 @@
 #include "hw/sysbus.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
-#include "hw/riscv/sifive_u_prci.h"
+#include "hw/misc/sifive_u_prci.h"
 
 static uint64_t sifive_u_prci_read(void *opaque, hwaddr addr, unsigned int size)
 {
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 5073986..65f3fdd 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -137,4 +137,7 @@ config AVR_POWER
 config SIFIVE_E_PRCI
     bool
 
+config SIFIVE_U_PRCI
+    bool
+
 source macio/Kconfig
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index b6b2e57..9e9550e 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -23,6 +23,7 @@ softmmu_ss.add(when: 'CONFIG_MOS6522', if_true: files('mos6522.c'))
 
 # RISC-V devices
 softmmu_ss.add(when: 'CONFIG_SIFIVE_E_PRCI', if_true: files('sifive_e_prci.c'))
+softmmu_ss.add(when: 'CONFIG_SIFIVE_U_PRCI', if_true: files('sifive_u_prci.c'))
 
 # PKUnity SoC devices
 softmmu_ss.add(when: 'CONFIG_PUV3', if_true: files('puv3_pm.c'))
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index 5855e99..109364b 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -24,6 +24,7 @@ config SIFIVE_U
     select HART
     select SIFIVE
     select SIFIVE_PDMA
+    select SIFIVE_U_PRCI
     select UNIMP
 
 config SPIKE
diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
index d73ea99..e6c8af0 100644
--- a/hw/riscv/meson.build
+++ b/hw/riscv/meson.build
@@ -12,7 +12,6 @@ riscv_ss.add(when: 'CONFIG_SIFIVE', if_true: files('sifive_uart.c'))
 riscv_ss.add(when: 'CONFIG_SIFIVE_E', if_true: files('sifive_e.c'))
 riscv_ss.add(when: 'CONFIG_SIFIVE_U', if_true: files('sifive_u.c'))
 riscv_ss.add(when: 'CONFIG_SIFIVE_U', if_true: files('sifive_u_otp.c'))
-riscv_ss.add(when: 'CONFIG_SIFIVE_U', if_true: files('sifive_u_prci.c'))
 riscv_ss.add(when: 'CONFIG_SPIKE', if_true: files('riscv_htif.c'))
 riscv_ss.add(when: 'CONFIG_SPIKE', if_true: files('spike.c'))
 riscv_ss.add(when: 'CONFIG_MICROCHIP_PFSOC', if_true: files('microchip_pfsoc.c'))
-- 
2.7.4


