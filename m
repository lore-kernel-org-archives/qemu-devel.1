Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB727C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 16:58:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6E90206D7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 16:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ToglyDLv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6E90206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igthN-0007dy-1v
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 11:58:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57243)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtFX-0005iq-35
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtFW-0008VP-0f
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:34 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:34495)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1igtFV-0008Sq-Pm
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:33 -0500
Received: by mail-wr1-x42e.google.com with SMTP id t2so8069419wrr.1
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 08:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references;
 bh=YIFk3nLn1up5bs2Pnh4sUVsBh4ywarhEIRO1n8e1Ra0=;
 b=ToglyDLviv8ut4pycCfRcnhZV6srBqSuS1Qh3Z9MaKPtuuZfefMN6Ff7J/mvF471wX
 Qp85ssxYf2yzQFSuzqecGbgdHgA2ws5t+IyD7qmgGEd92qkTg/t/j644dau17PNRzBFc
 pikVmu+R7i+IbQ9TuV5S9wSUXAoK/17YqGiumW+Ois61mYOxWnsGuoialDgcAt+srmAB
 PQjzN1lFw//lYbqpssexNx4AWp944HEwSk86YvVJC76OjKDKnkYWILGd4nkdSkqDblT1
 zRr4geKYPAQPNyrsuQKm14n8VM4pamx5B6apT8w/MJ66L7PyvQBSw7yn2Qv/exBWLCrE
 Krxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references;
 bh=YIFk3nLn1up5bs2Pnh4sUVsBh4ywarhEIRO1n8e1Ra0=;
 b=hcqhYBwinxK6mbq5n0DHt0EpeAw1qM44OaMaOs4t2EajwjM6H1QKNN3Wj6ZaT5SRaA
 stQlzXtQO86nBCuzgCrvNJ9WJ08uZIjZEn3KpJgC2uUtsVwJiWPTP1PgVlaaJ0BT6E3T
 ChLeED5Ya3TeU2RfeX6SaDFl40S2qZ4sGkybYwu7PvBlmwcEArvVjptWygUtPL0U6/ot
 gdMQkDo+mncv81ycDmdhNZSG/B+MC/wexsbVuDu2/OJ/MX/wWEGS2kELLWPYC+LJM03Y
 yh/WbB/CeH9P409wGnXQbDEMxYSQ4PSu1B4ghaUSAiWwP+VJeFfNWTQYMFzgLphqDPAw
 RgLw==
X-Gm-Message-State: APjAAAUh9ZgI5MaKKXXx9nYSlMwheMvkyV05CtbtgVaaDAq6Ekum2JEM
 HU4g5t4H/ycXjlHuuY8HsqRiTgZo
X-Google-Smtp-Source: APXvYqz8pNI+wz3MdLuL0t1qZt17wPQf+w7b6KfaLCJjNWlWuY5bOOH4hnMnMI1Yi1YWmGppv9EhXw==
X-Received: by 2002:adf:fd87:: with SMTP id d7mr31458807wrr.226.1576513772469; 
 Mon, 16 Dec 2019 08:29:32 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id q68sm19962334wme.14.2019.12.16.08.29.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Dec 2019 08:29:31 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 45/62] fw_cfg: allow building without other devices
Date: Mon, 16 Dec 2019 17:28:29 +0100
Message-Id: <1576513726-53700-46-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
References: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
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
index ac08e63..ab90ee3 100644
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



