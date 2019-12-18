Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4DAEC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:28:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EBE421582
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:28:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r1OTnd6T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EBE421582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihYR2-0006ek-F6
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 07:28:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52935)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY3a-0006vE-BN
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY3Z-0002DF-4s
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:58 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:35439)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ihY3Y-00029i-TP
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:57 -0500
Received: by mail-wr1-x430.google.com with SMTP id g17so2024596wro.2
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 04:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references;
 bh=bCglA2xU8XIovJ5evRIXUQsgqKR2GztUSfl273PP6MA=;
 b=r1OTnd6TgT0Odu3JhHL/KfCZ9Luq7IFhzSJeMIL6T4OJTeLtfn8W5jrdpLGmUTvU5+
 aFJ42fVxm1mZUbIvzbBON+WDHv6CuayWsJHeF2vSJp70gPEjJFHs//DgksAPToX2iWz5
 iCsq02SBRkJsUWH7mtbsFtKuiV+H6oWdlT8DY18avA/ZMZ372QEEEK/qaxfdMuByAPXc
 OGJc4DrMPi7UvW/6GZpnRmckrYekr/IvmTD0jYkK6Tf9ZrbqhVYQB7E/KNjZsB+Kk7iK
 bwYG8HuMLeDVtQGSmJBulWCd4VAYtZILvLAi2ylxd1s4X4E7Exl6hOvPbbwiLNzzk3vU
 s3Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references;
 bh=bCglA2xU8XIovJ5evRIXUQsgqKR2GztUSfl273PP6MA=;
 b=fjczZMsjJhxaO/wwdn2Mo6T2VlUxDeXSN9cRha8CGKa9Q4qtDWMqeEXC/YdBN85uqy
 RzdMARDRQ7xlWhHIMNoa3wGvy41uFVDJSEibgfCWQ6RLeIhrzmG5htSYRnIfeLXFMnCX
 swnLv8/HvOR8ETcMJLYRskjiAGeecajLH4BSulT1M1eMiLwb7VgAtSGizEiTv2ljjPMa
 AgHPUoOHyplT1U5Te19M/NPk2Hr53zG+4auOGzREMTA2kbjuojLXicPeH/ewOF0C3jOG
 mOlkRVVGELwHyAKu/cuYqxQerszudfl1iTy5FpEZNojQV3eNJ/wJ1VIMB22NahlH5LR+
 bsWw==
X-Gm-Message-State: APjAAAWakiCuwJ66Iujq0r4z9t95tYjUU3aUYWaWyqhxPJTtOJWqwQ95
 HSevlQMAiTi0sCxbojG1xHQgqHY5
X-Google-Smtp-Source: APXvYqzHvZ/AvLx1bHzYeyMa8Hur/16+RSPt+GGl9/GYI5FoGbiCQfD+732ird3QAgqgCH4fsiMfGg==
X-Received: by 2002:adf:c147:: with SMTP id w7mr2500529wre.389.1576670635635; 
 Wed, 18 Dec 2019 04:03:55 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n67sm2236838wmf.46.2019.12.18.04.03.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 18 Dec 2019 04:03:49 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 51/87] acpi: move PC stubs out of stubs/
Date: Wed, 18 Dec 2019 13:02:17 +0100
Message-Id: <1576670573-48048-52-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
References: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::430
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

This is a small cleanup that lets microvm build entirely without
include/hw/i386/pc.h.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/acpi/Makefile.objs                                | 3 ++-
 stubs/pc_madt_cpu_entry.c => hw/acpi/acpi-x86-stub.c | 0
 stubs/Makefile.objs                                  | 1 -
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename stubs/pc_madt_cpu_entry.c => hw/acpi/acpi-x86-stub.c (100%)

diff --git a/hw/acpi/Makefile.objs b/hw/acpi/Makefile.objs
index 655a9c1..9925305 100644
--- a/hw/acpi/Makefile.objs
+++ b/hw/acpi/Makefile.objs
@@ -8,6 +8,7 @@ common-obj-$(CONFIG_ACPI_NVDIMM) += nvdimm.o
 common-obj-$(CONFIG_ACPI_VMGENID) += vmgenid.o
 common-obj-$(CONFIG_ACPI_HW_REDUCED) += generic_event_device.o
 common-obj-$(call lnot,$(CONFIG_ACPI_X86)) += acpi-stub.o
+common-obj-$(call lnot,$(CONFIG_PC)) += acpi-x86-stub.o
 
 common-obj-y += acpi_interface.o
 common-obj-y += bios-linker-loader.o
@@ -20,4 +21,4 @@ common-obj-$(call lnot,$(CONFIG_IPMI)) += ipmi-stub.o
 else
 common-obj-y += acpi-stub.o
 endif
-common-obj-$(CONFIG_ALL) += acpi-stub.o ipmi-stub.o
+common-obj-$(CONFIG_ALL) += acpi-stub.o acpi-x86-stub.o ipmi-stub.o
diff --git a/stubs/pc_madt_cpu_entry.c b/hw/acpi/acpi-x86-stub.c
similarity index 100%
rename from stubs/pc_madt_cpu_entry.c
rename to hw/acpi/acpi-x86-stub.c
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index 4a50e95..8b0ff25 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -33,7 +33,6 @@ stub-obj-y += fd-register.o
 stub-obj-y += qmp_memory_device.o
 stub-obj-y += target-monitor-defs.o
 stub-obj-y += target-get-monitor-def.o
-stub-obj-y += pc_madt_cpu_entry.o
 stub-obj-y += vmgenid.o
 stub-obj-y += xen-common.o
 stub-obj-y += xen-hvm.o
-- 
1.8.3.1



