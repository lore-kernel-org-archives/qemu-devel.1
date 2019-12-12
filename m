Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C53C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 18:21:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF9622073B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 18:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kFR7NGw/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF9622073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifT5b-0006Xv-Ub
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 13:21:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58641)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifSHH-0005OI-1k
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 12:29:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifSHF-00048W-QK
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 12:29:26 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:40912)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifSHF-000473-JT
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 12:29:25 -0500
Received: by mail-wr1-x432.google.com with SMTP id c14so3620990wrn.7
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 09:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=vWWgH5pcpTYoxVZTGFL4hsaj2N4wlcdSO1zlmQtykhQ=;
 b=kFR7NGw//Vjykkf4Q6mTfyYPasVVQroIQF38d2V77Iacq8dJcXmnipxw6SUxDNDGLd
 KvAjDStUawP1/CUWwhQ35GuVbSXUlcnzCMvBnGMEz+exSV9MDwe9YvdRuIeylAGSjOH3
 FyG3yS2vwsrS/lVMR29JOcHRS3ebcQupfi0aecESOW0cxI9Z4oUEDHRaXC828p4A0UR0
 vNX4NZFmShlnkdJIJrtetgeUflIRSNDgziNTxMUyI98dcKwL5J7EDkM+RCfe0RP/Ilic
 TVwbaOk5NIdNm96868NWdw9Xit3548LG0b6340nl0mMZfjaIkfLIFvS317+5vklznSCl
 pPlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=vWWgH5pcpTYoxVZTGFL4hsaj2N4wlcdSO1zlmQtykhQ=;
 b=hlan74uM9NhDzDX8avMaH9Q39v0VgS2JvBkDSQG118PGVs3Pb7a7MnFynaFbB7crY2
 szB4c0JhOgmyTdYpu4trqYi/K0xcvtAev8FA7CH5gTzvrJsMaSxqwqEh+6NgDDw1jqsS
 RdPrNlZKW1m9EKja7i1mop0hl2NGz5DaQED7RBG6Jqk4Ewq/k7gHqpaVJRDdhvilevwK
 WqNBXHCYWGHz9Rr/vyoKjckEl+f/oJI4sQMWehbZyzQadgASDpJ+eQuG2MpevkZM0edy
 7RI67oMcjz5XfT//MtpTPG+d0bombtqf2Ee9AugCQy3qmUgDxmPA044h3EILOnfhev0C
 Bgxw==
X-Gm-Message-State: APjAAAWPZIZE3/S437beiR00imU8jYZNZFPM2W0sDD7BR44bQai3RGIq
 qntk7PvvS1gDZFEdbESGkQfgSJY9
X-Google-Smtp-Source: APXvYqx7BgmEU1kZG5G4gs29lbLLF6RLFDwo7LimWEVdMTUwudIUVs3P45UzrGV8ulq6YC5p/1xupg==
X-Received: by 2002:adf:f98c:: with SMTP id f12mr7290728wrr.138.1576171764320; 
 Thu, 12 Dec 2019 09:29:24 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id 2sm6810130wrq.31.2019.12.12.09.29.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 09:29:23 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 7/8] acpi: move PC stubs out of stubs/
Date: Thu, 12 Dec 2019 18:29:13 +0100
Message-Id: <1576171754-45138-8-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576171754-45138-1-git-send-email-pbonzini@redhat.com>
References: <1576171754-45138-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::432
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

This is a small cleanup that lets libqemuutil build without
include/hw/i386/pc.h.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/acpi/Makefile.objs                                | 1 +
 stubs/pc_madt_cpu_entry.c => hw/acpi/acpi-x86-stub.c | 0
 stubs/Makefile.objs                                  | 1 -
 3 files changed, 1 insertion(+), 1 deletion(-)
 rename stubs/pc_madt_cpu_entry.c => hw/acpi/acpi-x86-stub.c (100%)

diff --git a/hw/acpi/Makefile.objs b/hw/acpi/Makefile.objs
index 655a9c1..e772e89 100644
--- a/hw/acpi/Makefile.objs
+++ b/hw/acpi/Makefile.objs
@@ -8,6 +8,7 @@ common-obj-$(CONFIG_ACPI_NVDIMM) += nvdimm.o
 common-obj-$(CONFIG_ACPI_VMGENID) += vmgenid.o
 common-obj-$(CONFIG_ACPI_HW_REDUCED) += generic_event_device.o
 common-obj-$(call lnot,$(CONFIG_ACPI_X86)) += acpi-stub.o
+common-obj-$(call lnot,$(CONFIG_PC)) += acpi-x86-stub.o
 
 common-obj-y += acpi_interface.o
 common-obj-y += bios-linker-loader.o
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




