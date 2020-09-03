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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F74C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 10:43:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 769A320767
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 10:43:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dlnmce6f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 769A320767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDmhx-0000vH-EV
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 06:43:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55316)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kDmfz-0006Gy-NZ; Thu, 03 Sep 2020 06:41:07 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:52937)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kDmfx-0002I7-Tc; Thu, 03 Sep 2020 06:41:07 -0400
Received: by mail-pj1-x1042.google.com with SMTP id o16so1325281pjr.2;
 Thu, 03 Sep 2020 03:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=heOhgRObAJzJHkeWliYEUi9AemgHGjnTQIUCrihpc0U=;
 b=dlnmce6fUvDYynwH9IGFFnqlQ8NQzgnbQUwmnJ9oTprSXlQeLXG/blQ+Jcz+a6ym3M
 PREni1QjXSC8FUL1GNH3sJuiiOFhgxa57V/L46itz8Nu/my8XHB5KGjzcS+P+KinkOsM
 qNLe7+PqZEtXLK1CEhLNFb0oxl4ugDoLIz0e6DZaJV3Yr/Dq9jojYmEkx5yBburyjqxZ
 OaVBJC6BgN3wteqJv/s2gMY1dint8fArXpQJYtfiJgJK+RGXIizQCNIIqYaSLIYjaZbv
 cSX174hE6jcx8yJvH5qNpo+p+eNw6fpPTZ4rUbU+kVUVJ7iezD1OhuEoYSNeuiEyjeb6
 jweQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=heOhgRObAJzJHkeWliYEUi9AemgHGjnTQIUCrihpc0U=;
 b=aUmH7lsnR42p39jvdoruwWykTiWKB8JPs84s8A2rUjGCzcMmaSQozWIRA2c7kz5CX4
 g1SYSHRXlhTtZ8cHZKjULcFrAcOr1pylLRHlb4f/2px7gthy1400joMyzt6bHXCcdvWh
 Q+1PR25AouX3fbYTpfbowHe0d5NiwqD+2SEPXLKTw+OQBACqojF+AshNVRPIXI49WJHt
 eE2zB8F57uIH8PFWOdDKJHfw3JlMLeshKIvE37qDOmXqiEo8FhlLK828b1yziJbbBEvz
 jWxomJ/z/MoRKuaqPAAlr21mS/5NwiRslmU9yf+6iWNSZvBqkHOnqzm62OaADsBa+ZJG
 xHtA==
X-Gm-Message-State: AOAM530TFiH6LSlHoIE0NXUXx5C+P5Y24obRS5MvpLYeK9fm24oBs9in
 gHSI+0ARz5qtGUWGWumrPZs=
X-Google-Smtp-Source: ABdhPJwsSlk7mxvG6EV7dXC/KlWU8CC08fayx64RrfJmwJpdmDNTJ3C7uXohRpqxPnMe+mXaEquciw==
X-Received: by 2002:a17:90a:f286:: with SMTP id
 fs6mr2615596pjb.221.1599129664188; 
 Thu, 03 Sep 2020 03:41:04 -0700 (PDT)
Received: from pek-vx-bsp2.wrs.com (unknown-146-144.windriver.com.
 [147.11.146.144])
 by smtp.gmail.com with ESMTPSA id b18sm2137098pjq.3.2020.09.03.03.41.02
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 03 Sep 2020 03:41:03 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH 10/12] hw/riscv: Always build riscv_hart.c
Date: Thu,  3 Sep 2020 18:40:21 +0800
Message-Id: <1599129623-68957-11-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599129623-68957-1-git-send-email-bmeng.cn@gmail.com>
References: <1599129623-68957-1-git-send-email-bmeng.cn@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pj1-x1042.google.com
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

Every RISC-V machine needs riscv_hart hence there is no need to
have a dedicated Kconfig option for it. Drop the Kconfig option
and always build riscv_hart.c.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
---

 hw/riscv/Kconfig     | 9 ---------
 hw/riscv/meson.build | 2 +-
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index 8e07100..7d017bc 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -1,6 +1,3 @@
-config HART
-    bool
-
 config IBEX
     bool
 
@@ -10,7 +7,6 @@ config SIFIVE
 
 config SIFIVE_E
     bool
-    select HART
     select SIFIVE
     select SIFIVE_CLINT
     select SIFIVE_GPIO
@@ -22,7 +18,6 @@ config SIFIVE_E
 config SIFIVE_U
     bool
     select CADENCE
-    select HART
     select SIFIVE
     select SIFIVE_CLINT
     select SIFIVE_GPIO
@@ -35,7 +30,6 @@ config SIFIVE_U
 
 config SPIKE
     bool
-    select HART
     select HTIF
     select SIFIVE
     select SIFIVE_CLINT
@@ -44,7 +38,6 @@ config SPIKE
 config OPENTITAN
     bool
     select IBEX
-    select HART
     select UNIMP
 
 config RISCV_VIRT
@@ -52,7 +45,6 @@ config RISCV_VIRT
     imply PCI_DEVICES
     imply TEST_DEVICES
     select PCI
-    select HART
     select SERIAL
     select GOLDFISH_RTC
     select VIRTIO_MMIO
@@ -65,7 +57,6 @@ config RISCV_VIRT
 
 config MICROCHIP_PFSOC
     bool
-    select HART
     select SIFIVE
     select SIFIVE_CLINT
     select UNIMP
diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
index 3cf9380..dbedf9b 100644
--- a/hw/riscv/meson.build
+++ b/hw/riscv/meson.build
@@ -1,7 +1,7 @@
 riscv_ss = ss.source_set()
 riscv_ss.add(files('boot.c'))
 riscv_ss.add(files('numa.c'))
-riscv_ss.add(when: 'CONFIG_HART', if_true: files('riscv_hart.c'))
+riscv_ss.add(files('riscv_hart.c'))
 riscv_ss.add(when: 'CONFIG_OPENTITAN', if_true: files('opentitan.c'))
 riscv_ss.add(when: 'CONFIG_RISCV_VIRT', if_true: files('virt.c'))
 riscv_ss.add(when: 'CONFIG_SIFIVE_E', if_true: files('sifive_e.c'))
-- 
2.7.4


