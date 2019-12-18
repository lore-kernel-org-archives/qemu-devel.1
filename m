Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB16FC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:34:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7303A2176D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:34:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CC+F/sAP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7303A2176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihYX4-0006ka-2U
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 07:34:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49681)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY3K-0006Y0-N6
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY3J-00019Q-DF
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:42 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:35506)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ihY3J-00017X-4O
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:41 -0500
Received: by mail-wm1-x32b.google.com with SMTP id p17so1621139wmb.0
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 04:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references;
 bh=X8qg4vC4u62X+krIpf2n1pZJRXcVq9s/dN9HuyUC68E=;
 b=CC+F/sAP858AlRVRbSe3byqpaKoSnJwT/jqPPbtHyCyLFU4SX+yuTHnKyeR7RPyPeM
 Q8JXelV/EmsQ1H3Pw2rv6COcRVxKdsoRPzYLqMcUsdJ7s9aBmwxkUygv/Zy/Md3OZuq1
 26DZB+dLiGzT73DyO1DBDYhdY2ehLfdayb4oDP6qqz9rdnJf7+oMIZJsjDmnYUAggZa3
 Ydo0aOgRAsfupHOpvOqFqw7/BiGlJ1ps2nNhpZsZcm0rhcRLEOA1tVKod6lfdTi6T+fL
 6uR639YPuOUl79bFb1cb8UEeBmV2a6HUiUGORDng6p33EC15VLu0rbJJIXIkcr2hLGw6
 g0AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references;
 bh=X8qg4vC4u62X+krIpf2n1pZJRXcVq9s/dN9HuyUC68E=;
 b=H4cYaM5ErXBv25z6/J7nnMBnSxeOnuoYHrrL0x7tGbrj5eH95cTs1PR47ldhYRD0fI
 6HZpx9S2Jyj5EU5s1vfbaRsgWzxzmheAD8See5y5j5S4+RG/cqD/SfS8Z6fucq5XkLJ0
 Bdlg0j7dRW6M80ALcSi9kQ+TcOiTmTsawb0ZfS2yKSlbD/K3inBNbML3MQYQQT/ezHIk
 OithOl2iFm/pUzwwgLXKztrgGHP9mBgc5nxbfJdWtypomoZWkBYKO1mZXTUDn+zxV+DC
 XVTQ/seGmo4ynq82U4WX3HvlxtH6AEGDK7kREYiWujH6ARNN7lCqyzGVuQHR0Zgh1N1e
 c+aA==
X-Gm-Message-State: APjAAAW0zyYjslp3kmZCGGXYdHCi5evrTQ4516m3ISo43xNds0uwjlC1
 Yxyq0KfHRPaoNWKaAbkpbWxAEFxs
X-Google-Smtp-Source: APXvYqyWEo6Ixn8GYQMsTtI7R/9TEMehZmysdbvBLJOlF3Z0A6tDKeAmok5Ye+g0CAAFKFQpmi5DRg==
X-Received: by 2002:a7b:c759:: with SMTP id w25mr2958815wmk.15.1576670618753; 
 Wed, 18 Dec 2019 04:03:38 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n67sm2236838wmf.46.2019.12.18.04.03.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 18 Dec 2019 04:03:37 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 44/87] i386: conditionally compile more files
Date: Wed, 18 Dec 2019 13:02:10 +0100
Message-Id: <1576670573-48048-45-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
References: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32b
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

Reviewed-by: Sergio Lopez <slp@redhat.com>
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



