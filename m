Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC131C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 17:02:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96A3F206D7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 17:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KYm1I0r6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96A3F206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igtlX-00047D-Aj
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 12:02:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57356)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtFd-0005td-MN
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtFc-0000JX-HE
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:41 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:47013)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1igtFc-0000IL-B1
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:40 -0500
Received: by mail-wr1-x42c.google.com with SMTP id z7so7995433wrl.13
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 08:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references;
 bh=bCglA2xU8XIovJ5evRIXUQsgqKR2GztUSfl273PP6MA=;
 b=KYm1I0r6XVfiQJ9CiAaCZJ3gN0FsrHaRIsHJ6tP8GhS5xybKNgjM3+aHsBvxjUfVlE
 KDnJkxGVdPH8IsMYst3mz4V2Qwct/bPOZgIZdu00RfjZhIsRM0spj2O9sTX3y7f0xcDK
 PW1u/QZ+9aj5UvuQXQArV8qZw5y5XPS6Ehrm1StPyuCDfaC2cWaRHcfHCfvokirFKtvx
 8I7zKDdKFSzvfqvMZTxJ5u6VzG2QEMBgNBQmYNRRnq0lQJXWMO/OArBqK379pdICYbJj
 8kKr1iE6E38E2cOQCrBRMmRm78W7irWiVePu43fg7dgxCOGVqmBgKAD7K6rfX+Ozpldc
 FTsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references;
 bh=bCglA2xU8XIovJ5evRIXUQsgqKR2GztUSfl273PP6MA=;
 b=LB9rpGNv+1UPJP9pMokgcdQvGmvc399Uhm9J7qoyQii7aQNd1nh5f0c5C8Qg73pPhy
 9omkLY2YJ8F/kF/5kjrPO9ttgHTLcP0DDSoZ/+vTfS4h6ngw8o5koTjhDfooNVHXI8U2
 4JCDaj4+JAE7znJ7fXQrPbQb/pAYnLfOLQCJFfKWWnxBAk3x4pViAvubX6UjAl2jRwqs
 Bjt7CvYhZNh5CI4OXaUAI9WeoxTxgt+uIZt/VTdmrYNy0Ai7yQbWfThyf5sULZMFYs/w
 ANq6pt4ZgW0jq5yc3UD2CCQfPEp3iTyqMiTjJA+qBRXo4ak1py59vuVgWTRz10NfKSF8
 LLSA==
X-Gm-Message-State: APjAAAW7KHZ/Y8uAtSfHP7qKyEfStJ7MGoLDhs+inqgnff8gB4wJ6GRx
 nRei5CnQnpYzpovTDl5JEjxlIrbC
X-Google-Smtp-Source: APXvYqzI81c+u2qUPq4x1Y0z/xjBFlZDd7BteBUZd8hx9HyMyhMXAeGc1Y0jO8+wsMhcgqTavoNSzA==
X-Received: by 2002:adf:ef92:: with SMTP id d18mr30256974wro.234.1576513779155; 
 Mon, 16 Dec 2019 08:29:39 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id q68sm19962334wme.14.2019.12.16.08.29.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Dec 2019 08:29:38 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 51/62] acpi: move PC stubs out of stubs/
Date: Mon, 16 Dec 2019 17:28:35 +0100
Message-Id: <1576513726-53700-52-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
References: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42c
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



