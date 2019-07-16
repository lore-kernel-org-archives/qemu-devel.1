Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E44A5C76188
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 08:13:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B085720665
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 08:13:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OKUVPUgK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B085720665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnIaR-0007NU-DZ
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 04:13:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59916)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hnIYd-0008Gc-O9
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 04:11:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hnIYb-0003FV-E4
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 04:11:30 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:46512)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hnIYb-0003Ez-7X
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 04:11:29 -0400
Received: by mail-wr1-x435.google.com with SMTP id z1so19805401wru.13
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 01:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=/JvRa5GldjixJBnlluCiYqlWEcL01lxJeEtUkaaqEzk=;
 b=OKUVPUgKZTo4u1BWebllav6gIIhEBKN6Yya9Dv2JPx1uJUuOD8aMHIvua667orrbW9
 GLQSWUq9XWKgNhEMSv8Vz5zgUwRyc4DRxrGwZQ53vEJkPZne7esLpg8tm4p50XZJx39e
 xkdvHnJW6zDbWy2HwjKIqUg7H2nXpYzUeAcDx4hOIcxZwY6U3vRXdpDTADuvYAdxAkbx
 qSeFkbLiK/6EOfzCQuiZRFr0zb46W4zbaT7CYjYhaPPz4N3ZY3koAGDOw4gX6AlD5QHO
 rvHz1D6BKSU2iBSaKI2oO0yaxB32NHaKGLpN923Vvq8WrEnQrO93JvxmeHsyf/hgxrxV
 /HuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=/JvRa5GldjixJBnlluCiYqlWEcL01lxJeEtUkaaqEzk=;
 b=Ryf0cNOBpFjV5iGt7dMxF+x4roArUVPEraYdoYSBCafvFHTwutKm0EORsoQW7PIq93
 RuyjvpzP+tuw04tdLlSgywgrXq6ssOEkxh4yRluTblVtJXDg7B+lUU6tp+ltOrJ7rNnj
 8eKU1YYyWcEJag4Ya2gACC9VKYwdeD8AmA0JgJ/haGxxN88r0ebfnbjGUHvwA8hwpWea
 VUypXosRbgpm7Q9+k+k0d+OVjk/LHQLxjelcA/PJbHIIv6ehFCbw3ZcHPC1Es8ZSjWtp
 KO4f20h19oOTe7cf61hIE6QqgZbr5GX8N+z9b0edCKfj2FPEC9TO/OeRcWwLySd0nkpx
 u/2A==
X-Gm-Message-State: APjAAAV3C3giiNunNv+Dy0zcvuoSuPZNZVqM2st2es/orvY0ZN+q72ph
 IhlmjglsZm180r+ScojFrq7Kvt15RiY=
X-Google-Smtp-Source: APXvYqys2ogiTSny6pr60z+BWmAdxkzpcMNJPTtrmor7E1OyFDu9A49FopB7plNbrDAdqMTgr1SKFw==
X-Received: by 2002:adf:c003:: with SMTP id z3mr13448564wre.243.1563264687917; 
 Tue, 16 Jul 2019 01:11:27 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id c1sm37723879wrh.1.2019.07.16.01.11.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 16 Jul 2019 01:11:27 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 16 Jul 2019 10:11:06 +0200
Message-Id: <1563264677-39718-9-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1563264677-39718-1-git-send-email-pbonzini@redhat.com>
References: <1563264677-39718-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::435
Subject: [Qemu-devel] [PULL 08/19] hw/i386: turn off vmport if CONFIG_VMPORT
 is disabled
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
Cc: Julio Montes <julio.montes@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Julio Montes <julio.montes@intel.com>

vmport device is not included when CONFIG_VMPORT is disabled, hence
QEMU fails with the following error:

`Unknown device 'vmport' for bus 'ISA': unknown.`

v2: imply VMPORT (Paolo Bonzini )

Signed-off-by: Julio Montes <julio.montes@intel.com>
Message-Id: <20190712160257.18270-1-julio.montes@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/Kconfig | 4 ++--
 hw/i386/pc.c    | 5 +++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index 4ddf2a9..b9c96ac 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -51,6 +51,7 @@ config PC_ACPI
 config I440FX
     bool
     imply E1000_PCI
+    imply VMPORT
     select PC_PCI
     select PC_ACPI
     select ACPI_SMBUS
@@ -58,7 +59,6 @@ config I440FX
     select IDE_PIIX
     select DIMM
     select SMBIOS
-    select VMPORT
     select VMMOUSE
     select FW_CFG_DMA
 
@@ -77,6 +77,7 @@ config Q35
     imply VTD
     imply AMD_IOMMU
     imply E1000E_PCI_EXPRESS
+    imply VMPORT
     select PC_PCI
     select PC_ACPI
     select PCI_EXPRESS_Q35
@@ -84,7 +85,6 @@ config Q35
     select AHCI_ICH9
     select DIMM
     select SMBIOS
-    select VMPORT
     select VMMOUSE
     select FW_CFG_DMA
 
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index c33ce47..549c437 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -83,6 +83,7 @@
 #include "hw/mem/memory-device.h"
 #include "sysemu/replay.h"
 #include "qapi/qmp/qerror.h"
+#include "config-devices.h"
 
 /* debug PC/ISA interrupts */
 //#define DEBUG_IRQ
@@ -2793,7 +2794,11 @@ static void pc_machine_initfn(Object *obj)
 
     pcms->max_ram_below_4g = 0; /* use default */
     pcms->smm = ON_OFF_AUTO_AUTO;
+#ifdef CONFIG_VMPORT
     pcms->vmport = ON_OFF_AUTO_AUTO;
+#else
+    pcms->vmport = ON_OFF_AUTO_OFF;
+#endif /* CONFIG_VMPORT */
     /* acpi build is enabled by default if machine supports it */
     pcms->acpi_build_enabled = PC_MACHINE_GET_CLASS(pcms)->has_acpi_build;
     pcms->smbus_enabled = true;
-- 
1.8.3.1



