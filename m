Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9037C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 14:32:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5A4A20663
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 14:32:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5tTkX/o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5A4A20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifPWG-0007Pw-2F
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 09:32:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58826)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifPU9-0005iq-4M
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 09:30:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifPU8-0008H1-2T
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 09:30:33 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33098)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifPU3-0008A5-CO
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 09:30:27 -0500
Received: by mail-wr1-x443.google.com with SMTP id b6so3006660wrq.0
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 06:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=d+fGHQicJfMCQVgermELgoy5/7QyWO3sNl/PPGYy11M=;
 b=f5tTkX/oBJRJtlTblwCIZzYIT++yb58irrw25E2QFk4JLqbF49FH5IXpGevUhLchGb
 rlxzpdz8fdBmE454YXG3MwjlWgmgEL9txWYqMD+bjIvTDIsZhyG8/qLUWVVAyHnm+Bzo
 RJ8ZQXXUQoLX7D0lbakZlbRVQiiJU9DooYjUnme1sv6IBDoq3EcthBx5c8CyMVaEyoPQ
 MfoQTqhZ8WNZlwviKwIjFUt1vafKCrFdhO7Aqy5E1eWQlahvLznTirFAgHPM8pJ7tEhy
 ejbV3xp5s7pkf6K4D885T2GLmCQHIIVt5cDQhYkMzI/w3u4lwR31a55jcce9UT5Ns855
 XIFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=d+fGHQicJfMCQVgermELgoy5/7QyWO3sNl/PPGYy11M=;
 b=TSwxu/bUvMHQw++Z+xrg//QCUpaXEUtfQdNachSdWSLSFmbt4DI1k1Aa3hhIMtsTBh
 bb1HhrQItxKzAAbHjKLcyZcTb0/NraGMiRPcuP/ZtFrET1uTEZeOi9tV1U6jvKZo8AYD
 I/rf0ffeOpMocsW4KxpyyTKuJbiJyRf5TvTCzCm6I1uiGKTlDAwjrvx+w6bCCyBsA56+
 U5T7yh6tHAIvfY56n3VaVYd8EM7d1QT49yhtG2teBYvxL72w6jo1W9AUed3Vx4XuBE9N
 zAcT/eWeiImNoXM8nGfMrE7Klcz/L1fRPANOjd40lPt/9IES7H4O3lMmti56YNx3hAta
 wY6g==
X-Gm-Message-State: APjAAAVtJ94d7QL8CK9NRXtth3EEOTgvI5f2dqWqlnxH4Eh0vWopohyh
 ZQPh12Xx4Bf9Ie3+4212tuYg7Bn0
X-Google-Smtp-Source: APXvYqwHhdPgXiqODZlFJx1LRu/DKz4P1XH0oZGppQNuBKCsyhKA1THPVZ8W5VXF3gLRju9jbBBegg==
X-Received: by 2002:adf:fe0e:: with SMTP id n14mr6682043wrr.116.1576161025181; 
 Thu, 12 Dec 2019 06:30:25 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id c9sm6140505wmc.47.2019.12.12.06.30.24
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 06:30:24 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/5] fw_cfg: allow building without other devices
Date: Thu, 12 Dec 2019 15:30:18 +0100
Message-Id: <1576161021-5359-3-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576161021-5359-1-git-send-email-pbonzini@redhat.com>
References: <1576161021-5359-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: philmd@redhat.com, slp@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The microvm machine type uses fw_cfg but lacks SMBIOS and ACPI.  Do not include
the files if the symbol is not present in QEMU and remove dependencies on
machine-specific files.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/fw_cfg.c | 7 +++++++
 hw/i386/pc.c     | 2 --
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
index 39b6bc6..326e33e 100644
--- a/hw/i386/fw_cfg.c
+++ b/hw/i386/fw_cfg.c
@@ -22,6 +22,9 @@
 #include "hw/nvram/fw_cfg.h"
 #include "e820_memory_layout.h"
 #include "kvm_i386.h"
+#include "config-devices.h"
+
+struct hpet_fw_config hpet_cfg = {.count = UINT8_MAX};
 
 const char *fw_cfg_arch_key_name(uint16_t key)
 {
@@ -46,6 +49,7 @@ const char *fw_cfg_arch_key_name(uint16_t key)
 
 void fw_cfg_build_smbios(MachineState *ms, FWCfgState *fw_cfg)
 {
+#ifdef CONFIG_SMBIOS
     uint8_t *smbios_tables, *smbios_anchor;
     size_t smbios_tables_len, smbios_anchor_len;
     struct smbios_phys_mem_area *mem_array;
@@ -83,6 +87,7 @@ void fw_cfg_build_smbios(MachineState *ms, FWCfgState *fw_cfg)
         fw_cfg_add_file(fw_cfg, "etc/smbios/smbios-anchor",
                         smbios_anchor, smbios_anchor_len);
     }
+#endif
 }
 
 FWCfgState *fw_cfg_arch_create(MachineState *ms,
@@ -114,8 +119,10 @@ FWCfgState *fw_cfg_arch_create(MachineState *ms,
      */
     fw_cfg_add_i16(fw_cfg, FW_CFG_MAX_CPUS, apic_id_limit);
     fw_cfg_add_i64(fw_cfg, FW_CFG_RAM_SIZE, (uint64_t)ram_size);
+#ifdef CONFIG_ACPI
     fw_cfg_add_bytes(fw_cfg, FW_CFG_ACPI_TABLES,
                      acpi_tables, acpi_tables_len);
+#endif
     fw_cfg_add_i32(fw_cfg, FW_CFG_IRQ0_OVERRIDE, kvm_allows_irq0_override());
 
     fw_cfg_add_bytes(fw_cfg, FW_CFG_E820_TABLE,
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index b9f3b38..3d2c5d8 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -101,8 +101,6 @@
 #define DPRINTF(fmt, ...)
 #endif
 
-struct hpet_fw_config hpet_cfg = {.count = UINT8_MAX};
-
 GlobalProperty pc_compat_4_1[] = {};
 const size_t pc_compat_4_1_len = G_N_ELEMENTS(pc_compat_4_1);
 
-- 
1.8.3.1



