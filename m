Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E53C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 14:32:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D6842067C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 14:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZOWkH2CQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D6842067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifPWQ-0007WK-6f
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 09:32:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58662)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifPU8-0005in-6k
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 09:30:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifPU3-0008Cn-Fi
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 09:30:31 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:50518)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifPU2-00088S-RT
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 09:30:27 -0500
Received: by mail-wm1-x342.google.com with SMTP id a5so2607814wmb.0
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 06:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=cGzZu1dSkbhVKoFntviesvbXQbdj2irYdhRwr8yxjKc=;
 b=ZOWkH2CQmQMBxQHWk9zvVoAujN9eJJsdpN+M0Pjiunrz1QXzlHRICpAzWVsLZvCv0G
 tLpFovrIFGKQEht6yabTeE1bj4upzR93j/UPT+MwoJAHlom0EXWIVhN9xRmJKykzTlW/
 uribn+pt2vgcHed4fMPcArzaJgBPo9+yJ2tRqv+LNRlAETktD/rGJKwSfqJl3+4mj+V5
 IsMvsCF8ZjDrCsxt38Tn/c0cbjq55RF9I2AJ2Syt8UqINaQFoDtB0vsw2D6FrV3jsz2+
 eOOk84MNuhfUc4U9UAG67nBrLXLh1/y31BvRXFVTiGUajqMmorN2mInD64ieBIpJilY6
 +s+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=cGzZu1dSkbhVKoFntviesvbXQbdj2irYdhRwr8yxjKc=;
 b=WsexdFkbcMfq+JSasDaGF9LjHp1UpIVSFsFQc4Pl2eoArNOV7KDbNF4U/YNMdtHZRj
 tKpyvwLdoO7DOQ4gkioH6yqrFcebt0cGk4Loy7w1o3xLnRpTXAIpL/WRLnfnn6olRtZW
 /WjLC6A22L9KXCDZm+1X2PNjInsJKFQBcUHkFTR0r/t29YPsgKfL6sJAOE01Dn+/ZN+B
 US6m63yEfhOC3mOv5sFB7ci139lgqdsHwzVWs3cVM2N8318aAYcdTt9gAgVYK0Td16nr
 A182r004xdv1DctC/wuuV/jS3hT5OsRy8/EsO9uX7pI/T5k2p/Ze5uKw1167jREvEUE9
 KlPQ==
X-Gm-Message-State: APjAAAXWhh6HhHbkVPmsp8cDaDXhzczKCKbzT8bNOF4SCSvn6HcMuN7K
 A0os0f/f0OtWEfDpGU+YZQiZdSM3
X-Google-Smtp-Source: APXvYqzK+d/zM3ghtrRoDTvNVorju97mNAzn2qkm68KRW7asP5s7yBnXF1ebfYML5XDGWOt9tpjI9A==
X-Received: by 2002:a05:600c:d7:: with SMTP id
 u23mr6595335wmm.145.1576161024238; 
 Thu, 12 Dec 2019 06:30:24 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id c9sm6140505wmc.47.2019.12.12.06.30.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 06:30:23 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/5] i386: conditionally compile more files
Date: Thu, 12 Dec 2019 15:30:17 +0100
Message-Id: <1576161021-5359-2-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576161021-5359-1-git-send-email-pbonzini@redhat.com>
References: <1576161021-5359-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/Makefile.objs     | 6 +++---
 hw/i386/kvm/Makefile.objs | 6 +++++-
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/hw/i386/Makefile.objs b/hw/i386/Makefile.objs
index 0d195b5..01ae202 100644
--- a/hw/i386/Makefile.objs
+++ b/hw/i386/Makefile.objs
@@ -1,11 +1,11 @@
 obj-$(CONFIG_KVM) += kvm/
 obj-y += e820_memory_layout.o multiboot.o
 obj-y += x86.o
-obj-y += pc.o
+obj-$(CONFIG_PC) += pc.o pc_sysfw.o
 obj-$(CONFIG_I440FX) += pc_piix.o
 obj-$(CONFIG_Q35) += pc_q35.o
 obj-$(CONFIG_MICROVM) += microvm.o
-obj-y += fw_cfg.o pc_sysfw.o
+obj-y += fw_cfg.o
 obj-y += x86-iommu.o
 obj-$(CONFIG_VTD) += intel_iommu.o
 obj-$(CONFIG_AMD_IOMMU) += amd_iommu.o
@@ -14,4 +14,4 @@ obj-$(CONFIG_VMPORT) += vmport.o
 obj-$(CONFIG_VMMOUSE) += vmmouse.o
 
 obj-y += kvmvapic.o
-obj-y += acpi-build.o
+obj-$(CONFIG_PC) += acpi-build.o
diff --git a/hw/i386/kvm/Makefile.objs b/hw/i386/kvm/Makefile.objs
index 4224ed9..0c8d5f2 100644
--- a/hw/i386/kvm/Makefile.objs
+++ b/hw/i386/kvm/Makefile.objs
@@ -1 +1,5 @@
-obj-y += clock.o apic.o i8259.o ioapic.o i8254.o
+obj-y += clock.o
+obj-$(CONFIG_APIC) += apic.o
+obj-$(CONFIG_IOAPIC) += ioapic.o
+obj-$(CONFIG_I8254) += i8254.o
+obj-$(CONFIG_I8259) += i8259.o
-- 
1.8.3.1



