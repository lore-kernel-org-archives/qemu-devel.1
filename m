Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33311C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:42:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F176E2077B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cfd/51Iz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F176E2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifOjT-0006Ai-2F
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 08:42:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39453)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNyq-0004GD-Ot
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:54:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNyp-0007iZ-KI
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:54:08 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:37687)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifNyp-0007h6-CD
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:54:07 -0500
Received: by mail-wr1-x42d.google.com with SMTP id w15so2626991wru.4
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 04:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3XqOWTo9pEMflQmMyCPRoR+VpJ9UjXCtKVT4pIPgki4=;
 b=Cfd/51IzSLtuKpzYG0eSmIdjgu0myFRXyn1muYhV1WDBT6cxKnplHaeXlvhgk9iCke
 fTpyc9LUpQv39StB0k56JOIDS6jAMDCIU/UnWDahjFrI4m3xMwtFIXUc599RSo33POnu
 v2XKcXlwWnn8p2MfuZEvdHzZOCCXYwxwho491zplWqPdhrFxnV4I8o3iXm1Mewya2IuG
 usciPSmeP8YBuFBuEcrBZBy7kXw2oVgrPNEeirQPnTE4zrKlcEuSuCTS0rHbofn7wQD2
 ZTUCHXbHHS8FMxZ9wL+g4HdpZVnKPSTj7gZ+eY/pQ1SppNAMNMeJChbkxcqaKgo5iaPG
 73zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=3XqOWTo9pEMflQmMyCPRoR+VpJ9UjXCtKVT4pIPgki4=;
 b=ILMVOp+i3dD0m5ImABsZJaM6b/VziQYQgiN5Vlg96R5jauegGVH2n0dXTgjRAaUDE9
 oXbqCW0KaekKeRcz77wbVUeqehmrQ3o+86+5HV3hVpIeIGCkx9t9iDVYAdUETf8WleP5
 LMOfLne47Mq82Y9UC7rzjVrm5iNl/rsY/fo4eXC1Fkq+1JYIyN/Ycv1rV8Mr46Dxvoya
 gG4bGREhUpJbdWIM625P30QRmhBCRAUgpPqFO/eTg0ZUk3rZ0ReWjIOTDIetumyaNLdv
 XBFB+oL2BDWe9HW61+kdVfd7dRzWMLFONaFD1eUl+XSSUGk7O7L5QL3iz8SCqRBe1RCX
 eP6g==
X-Gm-Message-State: APjAAAWCVc1Q2/5TiNZEnlFxBqmq3gBB+tTis1FcvPcH2rlFPfRohLZt
 OHzgzjpQ0MNEgG/eRFQjNOyba0h1
X-Google-Smtp-Source: APXvYqw4YDZHPTYPm4Sg+IzzKLhQpVmQDkFKiitQQ7frtG7R5E+vAEiTWbI6mKWHbvNq3Nv0iF3swQ==
X-Received: by 2002:adf:a141:: with SMTP id r1mr6259370wrr.285.1576155246088; 
 Thu, 12 Dec 2019 04:54:06 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n189sm5193825wme.33.2019.12.12.04.54.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 04:54:05 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 068/132] meson: convert hw/watchdog
Date: Thu, 12 Dec 2019 13:51:52 +0100
Message-Id: <1576155176-2464-69-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42d
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/Makefile.objs          | 1 -
 hw/meson.build            | 1 +
 hw/watchdog/Makefile.objs | 6 ------
 hw/watchdog/meson.build   | 6 ++++++
 4 files changed, 7 insertions(+), 7 deletions(-)
 delete mode 100644 hw/watchdog/Makefile.objs
 create mode 100644 hw/watchdog/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index b91472b..a1d3f07 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -33,7 +33,6 @@ devices-dirs-$(CONFIG_TPM) += tpm/
 devices-dirs-y += usb/
 devices-dirs-$(CONFIG_VFIO) += vfio/
 devices-dirs-y += virtio/
-devices-dirs-y += watchdog/
 endif
 
 common-obj-y += $(devices-dirs-y)
diff --git a/hw/meson.build b/hw/meson.build
index d788be4..376dbef 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -2,4 +2,5 @@ subdir('core')
 subdir('mem')
 subdir('semihosting')
 subdir('smbios')
+subdir('watchdog')
 subdir('xen')
diff --git a/hw/watchdog/Makefile.objs b/hw/watchdog/Makefile.objs
deleted file mode 100644
index 3f536d1..0000000
--- a/hw/watchdog/Makefile.objs
+++ /dev/null
@@ -1,6 +0,0 @@
-common-obj-y += watchdog.o
-common-obj-$(CONFIG_CMSDK_APB_WATCHDOG) += cmsdk-apb-watchdog.o
-common-obj-$(CONFIG_WDT_IB6300ESB) += wdt_i6300esb.o
-common-obj-$(CONFIG_WDT_IB700) += wdt_ib700.o
-common-obj-$(CONFIG_WDT_DIAG288) += wdt_diag288.o
-common-obj-$(CONFIG_ASPEED_SOC) += wdt_aspeed.o
diff --git a/hw/watchdog/meson.build b/hw/watchdog/meson.build
new file mode 100644
index 0000000..eafb57b
--- /dev/null
+++ b/hw/watchdog/meson.build
@@ -0,0 +1,6 @@
+softmmu_ss.add(files('watchdog.c'))
+softmmu_ss.add(when: 'CONFIG_CMSDK_APB_WATCHDOG', if_true: files('cmsdk-apb-watchdog.c'))
+softmmu_ss.add(when: 'CONFIG_WDT_IB6300ESB', if_true: files('wdt_i6300esb.c'))
+softmmu_ss.add(when: 'CONFIG_WDT_IB700', if_true: files('wdt_ib700.c'))
+softmmu_ss.add(when: 'CONFIG_WDT_DIAG288', if_true: files('wdt_diag288.c'))
+softmmu_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('wdt_aspeed.c'))
-- 
1.8.3.1



