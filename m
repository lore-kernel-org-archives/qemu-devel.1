Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D250C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 13:03:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D93AC218AC
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 13:03:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dn7qkoTm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D93AC218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihYzR-0004u4-Fm
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 08:03:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57817)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY3z-0007U5-ST
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:04:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY3y-0003u3-FP
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:04:23 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:37406)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ihY3y-0003qW-5T
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:04:22 -0500
Received: by mail-wr1-x42b.google.com with SMTP id w15so2021378wru.4
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 04:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9X2hwIcj1HfDRf0oxNBJGWqhVs/TtZghOe20kMkyMnU=;
 b=Dn7qkoTmDoUzeKuFtsG+cWcMUN6DDzC1jO2ABvt5EOX15rOezvx7A5am6XK+/rUgVl
 btsUHy5SuPcaKHi2cNitTyNiR65L8sYEzAHA2gNsni6JE0KfzW/Tw8dhSscpkTvtTO2O
 yOO/YLSj64btK+L7jwkcuMRr+KhJxQxobz86eYlkSFFmKWOGd/bje8lXYt58ZB/H9h+Z
 bkyUeEHRlvYFV4sNqBxWZIuwjoJFjB0hm4aRNXiQavxe/otwCFF0+UzEsy20l7tf+uEo
 dQ1yxI7tdarJkNi3L8MMOReMzs1EI5lpid3LhNNGB9f4o7l9pkPDUVyx3L3gwC2jV64O
 +WiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=9X2hwIcj1HfDRf0oxNBJGWqhVs/TtZghOe20kMkyMnU=;
 b=b0m4ESc6jo9zFI/qWJrjeMQVhfDJkf5HAGGEqgFihBWZiTrwosIzHaNCLdmiIknXMS
 cmNkx7HufW7nfwTIM/q0EMnpuM2ondjIRNlcDwiKZU4OQ0/vWBmM+cjkwhT+49ChQ+TL
 GzPgq/hCkDvhHGhlX1eqtg8o/23mSXyuA78ckuLFidukMOkulhijnoGdvUmZ+v44I+5J
 13iOuWUia8Q0dY9piwwUYMNWn3d3UCBtP77PjQFX+wNdiyBIXlPqW7vCjHazH2pidU3I
 RO0uAnQ5k2qdyRzD2n+IrbOMqz0C/teF11v0pZSFRtmykBD6flR4XpzhntDMicDTrMbe
 Qtyw==
X-Gm-Message-State: APjAAAWDdyXFuDlkU1lC+uDRiZjSiPFw2zF8QxC5Vtr+sOtTNtLCK32V
 TF170bt4xaiPIVSyc+IuPcSPm4Jo
X-Google-Smtp-Source: APXvYqxdmywXKDo9QTvLUgq3fSKIBzUWEKXbb2M59mu5EPlveScqCXneyGGp19EPOuuq/3JBzds82A==
X-Received: by 2002:adf:e984:: with SMTP id h4mr2385793wrm.275.1576670660909; 
 Wed, 18 Dec 2019 04:04:20 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n67sm2236838wmf.46.2019.12.18.04.04.20
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 18 Dec 2019 04:04:20 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 78/87] hw/pci-host/i440fx: Extract PCII440FXState to
 "hw/pci-host/i440fx.h"
Date: Wed, 18 Dec 2019 13:02:44 +0100
Message-Id: <1576670573-48048-79-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
References: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42b
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Make the PCII440FXState structure public, so it can be used out of
this source file. This will allow us to extract the IGD Passthrough
Host Bridge, which is a children of the TYPE_I440FX_PCI_DEVICE.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20191209095002.32194-3-philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/pci-host/i440fx.c         | 18 ------------------
 include/hw/pci-host/i440fx.h | 19 +++++++++++++++++--
 2 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/hw/pci-host/i440fx.c b/hw/pci-host/i440fx.c
index 3fc9442..fbdc563 100644
--- a/hw/pci-host/i440fx.c
+++ b/hw/pci-host/i440fx.c
@@ -31,7 +31,6 @@
 #include "hw/sysbus.h"
 #include "qapi/error.h"
 #include "migration/vmstate.h"
-#include "hw/pci-host/pam.h"
 #include "qapi/visitor.h"
 #include "qemu/error-report.h"
 
@@ -51,23 +50,6 @@ typedef struct I440FXState {
     uint32_t short_root_bus;
 } I440FXState;
 
-#define I440FX_PCI_DEVICE(obj) \
-    OBJECT_CHECK(PCII440FXState, (obj), TYPE_I440FX_PCI_DEVICE)
-
-struct PCII440FXState {
-    /*< private >*/
-    PCIDevice parent_obj;
-    /*< public >*/
-
-    MemoryRegion *system_memory;
-    MemoryRegion *pci_address_space;
-    MemoryRegion *ram_memory;
-    PAMMemoryRegion pam_regions[13];
-    MemoryRegion smram_region;
-    MemoryRegion smram, low_smram;
-};
-
-
 #define I440FX_PAM      0x59
 #define I440FX_PAM_SIZE 7
 #define I440FX_SMRAM    0x72
diff --git a/include/hw/pci-host/i440fx.h b/include/hw/pci-host/i440fx.h
index f54e646..cc58d82 100644
--- a/include/hw/pci-host/i440fx.h
+++ b/include/hw/pci-host/i440fx.h
@@ -13,12 +13,27 @@
 
 #include "hw/hw.h"
 #include "hw/pci/pci_bus.h"
-
-typedef struct PCII440FXState PCII440FXState;
+#include "hw/pci-host/pam.h"
 
 #define TYPE_I440FX_PCI_HOST_BRIDGE "i440FX-pcihost"
 #define TYPE_I440FX_PCI_DEVICE "i440FX"
 
+#define I440FX_PCI_DEVICE(obj) \
+    OBJECT_CHECK(PCII440FXState, (obj), TYPE_I440FX_PCI_DEVICE)
+
+typedef struct PCII440FXState {
+    /*< private >*/
+    PCIDevice parent_obj;
+    /*< public >*/
+
+    MemoryRegion *system_memory;
+    MemoryRegion *pci_address_space;
+    MemoryRegion *ram_memory;
+    PAMMemoryRegion pam_regions[13];
+    MemoryRegion smram_region;
+    MemoryRegion smram, low_smram;
+} PCII440FXState;
+
 #define TYPE_IGD_PASSTHROUGH_I440FX_PCI_DEVICE "igd-passthrough-i440FX"
 
 PCIBus *i440fx_init(const char *host_type, const char *pci_type,
-- 
1.8.3.1



