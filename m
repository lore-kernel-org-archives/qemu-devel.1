Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB39C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 18:11:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1B61214AF
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 18:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2yQVm1a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1B61214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifSwH-000394-AV
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 13:11:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58971)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifSHI-0005RC-QM
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 12:29:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifSHH-0004Bl-EW
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 12:29:28 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:34355)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifSHH-00049x-7a
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 12:29:27 -0500
Received: by mail-wr1-x441.google.com with SMTP id t2so3661609wrr.1
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 09:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=IKjPCPOU0OM2BVq1ly6IsoyhMPu7gfDfI+dPATD0bf4=;
 b=F2yQVm1asYrGfdb7DiIdz7llbEA7ccrCQ6NsU6Lcf134X96UzkaI4PsKAiXpxkk1nH
 zOBC27+uJFK5pMB1z/3vmmGNW6BCQNY6jOR7tJxsI05oJhFRnGRlGgxtZbp9D1sFtX0j
 RPr0a34RGNsFCCdWmszUi8BNdtBEDi9XO0qFaRjx/0mye1PEE9t0QKlNE0jfCSGZrsIg
 rkhPmRbtW8mYss8QeFowqS3g79Jc1THZw3F3DmK1CyIC8Ng+9WeKKENEdXh1v4BWDz9U
 nb+stuz0fL70yXtPkq3d7vOuHuMM1P95DDsMSRNTPQ4v7XswkduPBRuf2q8X96Jh8d54
 ONOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=IKjPCPOU0OM2BVq1ly6IsoyhMPu7gfDfI+dPATD0bf4=;
 b=tMu546ywJ9wMn+rmDsWqLh2EXd2f9o6LSKT8+VbggtD1DJ5BIJnF+ARiGpV7px++qm
 rXbAouDPz0pc/Gwhf99H3aufoKkR9cbJELRWdhusl5cLwSMSJCRu/c1N01frL0TDuRWh
 GUWMS+xWLc785mvkx8orsHBNbziMdcFpDlUHSbCfv8LHji/8HQUmTOsu8CNmx9ardRjX
 suCW9wNgI2iE1/u6N5eSSt52WlBXSm3h1UDw4NbWbTFH3ymIJbGPGevqgMT0npCvOO8I
 t8ZWRFZWKpmh0xfM0SIIpXNOjpdh7+/JnqYtnpu2OrBEI9cPtbKahIrWYyO9zuQUhQCY
 qxvQ==
X-Gm-Message-State: APjAAAXt5RH4gHiokXp6qbsyR/jVWLDu1d4i7ydrTGDDPWdp4d2R8iGL
 GB0r367Y3TxE5W2MR2IRsrIxLdnb
X-Google-Smtp-Source: APXvYqySLXxqjHUfiBg/FVdlrIXTMpxyLGW13v7Z/yEpc5tQePowgJ9ca9L5BXvjCDInpx0lnppifA==
X-Received: by 2002:adf:bc87:: with SMTP id g7mr7830514wrh.121.1576171765193; 
 Thu, 12 Dec 2019 09:29:25 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id 2sm6810130wrq.31.2019.12.12.09.29.24
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 09:29:24 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 8/8] pc: stubify x86 iommu
Date: Thu, 12 Dec 2019 18:29:14 +0100
Message-Id: <1576171754-45138-9-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576171754-45138-1-git-send-email-pbonzini@redhat.com>
References: <1576171754-45138-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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

Allow building microvm without x86-iommu.c and in turn hw/i386/pc.h.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/Kconfig          |  6 ++++++
 hw/i386/Makefile.objs    |  3 ++-
 hw/i386/x86-iommu-stub.c | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 42 insertions(+), 1 deletions(-)
 create mode 100644 hw/i386/x86-iommu-stub.c

diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index 5a49434..91cf584 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -103,11 +103,17 @@ config MICROVM
     select MC146818RTC
     select VIRTIO_MMIO
 
+config X86_IOMMU
+    bool
+    depends on PC
+
 config VTD
     bool
+    select X86_IOMMU
 
 config AMD_IOMMU
     bool
+    select X86_IOMMU
 
 config VMPORT
     bool
diff --git a/hw/i386/Makefile.objs b/hw/i386/Makefile.objs
index 01ae202..1236c3b 100644
--- a/hw/i386/Makefile.objs
+++ b/hw/i386/Makefile.objs
@@ -6,7 +6,8 @@ obj-$(CONFIG_I440FX) += pc_piix.o
 obj-$(CONFIG_Q35) += pc_q35.o
 obj-$(CONFIG_MICROVM) += microvm.o
 obj-y += fw_cfg.o
-obj-y += x86-iommu.o
+obj-$(CONFIG_X86_IOMMU) += x86-iommu.o
+obj-$(call lnot,$(CONFIG_X86_IOMMU)) += x86-iommu-stub.o
 obj-$(CONFIG_VTD) += intel_iommu.o
 obj-$(CONFIG_AMD_IOMMU) += amd_iommu.o
 obj-$(CONFIG_XEN) += ../xenpv/ xen/
diff --git a/hw/i386/x86-iommu-stub.c b/hw/i386/x86-iommu-stub.c
new file mode 100644
index 0000000..03576cd
--- /dev/null
+++ b/hw/i386/x86-iommu-stub.c
@@ -0,0 +1,34 @@
+/*
+ * Stubs for X86 IOMMU emulation
+ *
+ * Copyright (C) 2019 Red Hat, Inc.
+ *
+ * Author: Paolo Bonzini <pbonzini@redhat.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/i386/x86-iommu.h"
+
+void x86_iommu_iec_register_notifier(X86IOMMUState *iommu,
+                                     iec_notify_fn fn, void *data)
+{
+}
+
+X86IOMMUState *x86_iommu_get_default(void)
+{
+    return NULL;
+}
+
-- 
1.8.3.1


