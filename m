Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C719C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:33:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 105D92176D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mb+Z6AvE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 105D92176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihYVe-0004BY-Hr
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 07:32:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50543)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY3O-0006da-M4
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY3N-0001Rg-EK
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:46 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:35435)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ihY3N-0001NW-1d
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:45 -0500
Received: by mail-wr1-x42e.google.com with SMTP id g17so2023908wro.2
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 04:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references;
 bh=eYZEgxMO6lxQ1qaiC5oqX7/XxqB0vnO44sAssJEBGz4=;
 b=mb+Z6AvEo88e6YDdEeL2qMVOG4+xk7lKoRAG98JXno3VpivbHU5XDVUvBu463BetiS
 Jsygywx0pE/4aWrULEyw0bwSTzF6yLMLBZGepfV1y6GBAaLXe85SdFsoFR9MJ/VAQFEe
 4q3te6xqk5vLv/TIZIkrMGZ+TU5rtLfUxrDI2uEbamBk1yUSC2/Ow+JZJt1Al7s5icwp
 b9F+ZgnybuNauqUgdKI6sJCAD7Xkjzf7UKAzs3ltAyv0k19K3T6FrS6K6F+X3g3gwW05
 i9VPk8HiI/B0Eq0qOE5uDE+mZa/dhfwdyDBOcRVGfTaGxRBOQQNo9aAM7X19GjdmrJ4D
 wO8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references;
 bh=eYZEgxMO6lxQ1qaiC5oqX7/XxqB0vnO44sAssJEBGz4=;
 b=WQXkPbNsEUmbuebHBfUEn8+ol/5REYEpdzUjGKoiOQKrrZRibfRQr/BUrHcBOmg4LK
 sN0XhBi9Ui6gX47zGb7aItnI95pF8w1odZ2nYlRQxapd5iXkJWZU4NC9w5fjFKaU5Yex
 n+0Ka4atF+RhLimwFws6YOkGouvH/xncbSyZH09gK4bzOjUZqUxXWqhUMdelwmoI2aRa
 LFhKODUMxPFxMwCXq95d9OcyvmLKGrLaLMrkzJCWnyntH67LSr7DgkdkIcz0YY1zfplV
 oA2qHLjkEDyajb2xci+VIsmMbAkV5D2kqxvst1vqNh0wXSsdYhCUI1gJDfGdaCePHnGY
 G1fA==
X-Gm-Message-State: APjAAAXqwJudeelA6kufi7/GLcRD5jRNnlxP5aA3C0azDdmcksW9GIqW
 Pel9OLpLTlSildEzp/5/R4dWXje3
X-Google-Smtp-Source: APXvYqzLm2/FPRP12mjfkm1gfrX5wr6dMoqndKgP3gzAiAkb7sya9zYe7nVSFQYUC6MpD4KjpeGS6A==
X-Received: by 2002:a05:6000:f:: with SMTP id h15mr2362853wrx.90.1576670623822; 
 Wed, 18 Dec 2019 04:03:43 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n67sm2236838wmf.46.2019.12.18.04.03.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 18 Dec 2019 04:03:38 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 45/87] fw_cfg: allow building without other devices
Date: Wed, 18 Dec 2019 13:02:11 +0100
Message-Id: <1576670573-48048-46-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
References: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42e
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

The microvm machine type uses fw_cfg but lacks SMBIOS and ACPI.  Do not
include the files if the symbol is not present in QEMU and remove
dependencies on machine-specific files.

Reviewed-by: Sergio Lopez <slp@redhat.com>
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
index 58867f9..4bb1710 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -101,8 +101,6 @@
 #define DPRINTF(fmt, ...)
 #endif
 
-struct hpet_fw_config hpet_cfg = {.count = UINT8_MAX};
-
 GlobalProperty pc_compat_4_2[] = {};
 const size_t pc_compat_4_2_len = G_N_ELEMENTS(pc_compat_4_2);
 
-- 
1.8.3.1



