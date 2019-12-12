Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D654AC2D0C9
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 18:07:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACE38214AF
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 18:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="idO6K8oE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACE38214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifSrh-00056Q-3C
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 13:07:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57720)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifSHB-0005GP-Ov
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 12:29:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifSHA-0003zQ-L8
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 12:29:21 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34355)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifSHA-0003y5-EC
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 12:29:20 -0500
Received: by mail-wr1-x444.google.com with SMTP id t2so3661225wrr.1
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 09:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=HsUH1afV9fTj6bRLKgdy/ZlBd4ecIN0MQZ09ZAA7vd4=;
 b=idO6K8oEq0v5KusymRCXOxJUpNKHvhxHyB8Wo/Dj/XNm7RxnV34dDqu/Ox8NiqpLbP
 7ocyutPEiJzZDZXua2vGHh2sZKKZPD1z8qYYoddzWTTAFxYRwcdid+Og06CPC+9eBWWT
 jGElRk/Hz1mSfCFcsxjD7D+V1XILnewZM5XkZtYKE7JBBk1JW20Hub3SW18XOTKhj+BY
 Y4HZFciQNYJIKGC+nRR/Fc5O+JKrn1M+lxHZy9g01gvExImQ0oAJRO8dgYiHWZbUkGbG
 nJNSseqaUZVUTkGiVfao7BhAEH8jqAwi4jxpnq64q/QmSaKuGWWRPxAsg3BK7pAva2Dp
 NDqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=HsUH1afV9fTj6bRLKgdy/ZlBd4ecIN0MQZ09ZAA7vd4=;
 b=Sj0jOrG4Cnu/j/RPUwc+IQFOWgYnCayQyfZ+hNYlqpyHoEFi6O51EMgFjTG0hvMFMl
 dcrVB0D1jH7WODr0SRhLEu5VVCRf4KgROYKPF9IG6xGNKh3L6ptbBbPDi5uM4IQ/ba6J
 ILIXP1VjXWnaNFdETtNGyaR+8PctHDcJEeYa75jG0IGU7FjZW3d28E0AN3enyuCI9B6U
 jNo0GyNtRnODPYxli4hN2fLInbV3xOlI1WxgqPAOmlh9zZBwsG8U42SAJyjHqBWg1Bpk
 CAJbBoUtlxAOL4MgQ/zAxKRCLWxhN1QycNpLc5Q9q4xL7HAISzsIWnw7kiDPKAQy8NIc
 qCAg==
X-Gm-Message-State: APjAAAWmDcz7frmkbTowJQLtITnAQ8hz5t4+wDhD7Lpy5oF0cjJMqLgk
 6s5Q1geAIpQqNvDRYJWd7w7ygwXS
X-Google-Smtp-Source: APXvYqz5rT5jTJZ6KnBGysaCC+7ysy1uq/6+3SW5zeg0y6e+Wy3yzwZaZ8C68T9CZRGb3oqfB42tdA==
X-Received: by 2002:adf:f103:: with SMTP id r3mr7342824wro.295.1576171759139; 
 Thu, 12 Dec 2019 09:29:19 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id 2sm6810130wrq.31.2019.12.12.09.29.18
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 09:29:18 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/8] fw_cfg: allow building without other devices
Date: Thu, 12 Dec 2019 18:29:08 +0100
Message-Id: <1576171754-45138-3-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576171754-45138-1-git-send-email-pbonzini@redhat.com>
References: <1576171754-45138-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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



