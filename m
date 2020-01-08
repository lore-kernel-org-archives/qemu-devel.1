Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E41C282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 12:43:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FB132067D
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 12:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJ8wURPg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FB132067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipAgb-000257-AY
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 07:43:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60383)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ipAWR-0003qm-C0
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ipAWQ-0004MB-52
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:15 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:44174)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ipAWP-0004Le-VZ
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:14 -0500
Received: by mail-wr1-x431.google.com with SMTP id q10so3145191wrm.11
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 04:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EKgddJUC32edGpEYyVtkWbvCn6HqFnHHNoZScg8SMCE=;
 b=ZJ8wURPg+5wY7IrRf60rQD0o9JtsQmMHUNCq9krbpCrnn1sSOWmuSd1qecFxrklLSc
 2/n0zJtpxvrgpLfUaYT+JFyLLDasoATVCfCU3OeItLc0y0PdRmt0PoSQ33u6XLS9QGDU
 zMzJmdTVikUvBaaoGRMUsO8zlWENb+jdZnYFUvnKPZvV7lkmSD8H9w9pWXHKFJAh+xMD
 HpXBhMldbe7tnIwdJzX6BRyDJUa8ercEJKDxQ/j4nPE4bhHadGc9Ur5OjngcG7cn3whj
 7lBWxEA1Pc8XstxE8UBanjzswN/UwHWkUKjjdcb+RVnFYRJioFZaYFlKdjhsCNrwUU7g
 L9pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=EKgddJUC32edGpEYyVtkWbvCn6HqFnHHNoZScg8SMCE=;
 b=bSlWvJppUMrYkMQL9D/2alYel7WNbreVEm5vVA+xyL3R56Y+pPxcZn39BRDwcMLEbX
 8I543qjBNlS3qtzCWW5u/LuWPtsGzWLSSppy0tw59ylDnHwv2Ef7dd2dvJ0XQVfoYbEK
 yHePQwhNJ2ItCB62/28QEasnGv01lTP01/rR08/XUqgO+Nz3p7/RPlYQAEpA1xnDV9zu
 XMD1jdiu+OUGuYqniYMhF3TSQxwryARsRjwSOqiIS3JArRHxJ4xNFJHD3AhsYO5EfpF6
 sgjezsIWLxgn6IGG800XXfSwA0de4PGhkLaGr5Soy7wct6Jv3EQD7xsTzpJCQ/OdO79H
 cdeA==
X-Gm-Message-State: APjAAAXypRlu8S1ru0hfTnIhQFv9QA0kwX0AZ3EbmX1in30Y1ucKb5Sp
 1aec9O+GaAm/os2rBa2wFVHzkcnR
X-Google-Smtp-Source: APXvYqx340DkaCSIciOZeVwEvQHOhFj2xPHa7dAx8KDCHz1WBRxC+fKB1o2sUMr/HzJ34gjKmwFtUA==
X-Received: by 2002:adf:ec4c:: with SMTP id w12mr4227592wrn.124.1578486792780; 
 Wed, 08 Jan 2020 04:33:12 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id o4sm4037750wrw.97.2020.01.08.04.33.11
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 08 Jan 2020 04:33:11 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 16/38] hw/ppc/Kconfig: Only select fw_cfg with machines using
 OpenBIOS
Date: Wed,  8 Jan 2020 13:32:33 +0100
Message-Id: <1578486775-52247-17-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1578486775-52247-1-git-send-email-pbonzini@redhat.com>
References: <1578486775-52247-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::431
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

The fw_cfg helpers are only used by machines using OpenBIOS.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20191231183216.6781-11-philmd@redhat.com>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/ppc/Kconfig       | 6 ++++++
 hw/ppc/Makefile.objs | 3 ++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
index d8482a5..e4ca920 100644
--- a/hw/ppc/Kconfig
+++ b/hw/ppc/Kconfig
@@ -72,6 +72,7 @@ config PREP
     select M48T59
     select PC87312
     select RS6000_MC
+    select FW_CFG_PPC
 
 config RS6000_MC
     bool
@@ -85,6 +86,7 @@ config MAC_OLDWORLD
     select GRACKLE_PCI
     select HEATHROW_PIC
     select MACIO
+    select FW_CFG_PPC
 
 config MAC_NEWWORLD
     bool
@@ -96,6 +98,7 @@ config MAC_NEWWORLD
     select MACIO_GPIO
     select MAC_PMU
     select UNIN_PCI
+    select FW_CFG_PPC
 
 config E500
     bool
@@ -130,3 +133,6 @@ config XIVE_KVM
     bool
     default y
     depends on XIVE_SPAPR && KVM
+
+config FW_CFG_PPC
+    bool
diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
index 79adf06..5c46c68 100644
--- a/hw/ppc/Makefile.objs
+++ b/hw/ppc/Makefile.objs
@@ -1,5 +1,6 @@
 # shared objects
-obj-y += ppc.o ppc_booke.o fdt.o fw_cfg.o
+obj-y += ppc.o ppc_booke.o fdt.o
+obj-$(CONFIG_FW_CFG_PPC) += fw_cfg.o
 # IBM pSeries (sPAPR)
 obj-$(CONFIG_PSERIES) += spapr.o spapr_caps.o spapr_vio.o spapr_events.o
 obj-$(CONFIG_PSERIES) += spapr_hcall.o spapr_iommu.o spapr_rtas.o
-- 
1.8.3.1



