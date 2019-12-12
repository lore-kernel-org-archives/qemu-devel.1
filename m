Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553A3C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:57:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BD6921655
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vKq6NAPZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BD6921655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifOyE-0006lC-Uz
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 08:57:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42817)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNzC-0004pG-Ha
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:54:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNzB-0008Jj-5i
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:54:30 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:50827)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifNzA-0008IJ-V9
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:54:29 -0500
Received: by mail-wm1-x32a.google.com with SMTP id a5so2260892wmb.0
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 04:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Y1eC1US5t9rCGASLFzWBCNStyznZMB9jdOkTWcqcyvc=;
 b=vKq6NAPZGuuDdyc33e92L7mFmjhoaCp4i/GqwgcBGTRQazxA0zOWhvqaS1DBJwgybj
 LBh0L21lcMTp6iJ7XYT08Nwpw5LuFmXllBRhTBMAKWeiTNpPsMsdA69jUeNr+6NhLs8a
 62PVpg2RvoingaHx0bR26QadxezaK0YfMNxAqf0KF7piNR4oeycRgJn8gONenPLX3LNy
 jAnQ3SPjt5DQtnRgeC42Qr8elEYp0s6c4Z4IOaF4rTXn4xueeRbc+kkD6u0ykPQzg2+m
 PgjhpmvwogYKDQXhbspNseI0Sq/aYqZrhvc7ZK70EQrxSnNhrXmj7w72Gvv/0tgLYGZG
 0HLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Y1eC1US5t9rCGASLFzWBCNStyznZMB9jdOkTWcqcyvc=;
 b=ce+au6IjCFHdBm41aL9EExa8Hqao17/+RfgBwuWT+zTOaScZ0FpeSa4Bfs7vguTOG/
 cwGoPuZRlVt5iW1+EczNQaJEQQtX6xrsqssrQQVk1bQXY52Jn8aBCDOQWUqi9uoPmc8M
 a1R77p1OBlyntx5qkAm4EdlqApUgZfmnkhaTmrURcey5WxfTXpVujRQkbiTzQr2wylVm
 q/qNBJBXKifcRLGOEBPeOhfOsL6T81yJ3JI9pv7T/WN/SaIT0LIWj4PX3m5ij5wmBqXq
 IUxCCU7j1aSz12I25L7jv6HGHNttEcoCliI+YMz9opR6XQ4vj+H4Ps6gLt/EXE022EKZ
 zxvg==
X-Gm-Message-State: APjAAAVEF0sw9RyDudj6N2dfCiwLILQl0bi3zZ8B7H8xJ5SIQUjjvxIk
 HsJVv5kuRPtO97q4yWODyr1gXlwj
X-Google-Smtp-Source: APXvYqwswPsBmraVAo8WeCOvx6A9MbfcpMcV01ndEKFvSm64N+NLRynq8VGN+bSLUeiBGDL7vFKD7w==
X-Received: by 2002:a1c:286:: with SMTP id 128mr6209106wmc.176.1576155267803; 
 Thu, 12 Dec 2019 04:54:27 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n189sm5193825wme.33.2019.12.12.04.54.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 04:54:27 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 090/132] meson: convert hw/ide
Date: Thu, 12 Dec 2019 13:52:14 +0100
Message-Id: <1576155176-2464-91-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32a
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
 hw/Makefile.objs     |  1 -
 hw/ide/Makefile.objs | 14 --------------
 hw/ide/meson.build   | 14 ++++++++++++++
 hw/meson.build       |  1 +
 4 files changed, 15 insertions(+), 15 deletions(-)
 delete mode 100644 hw/ide/Makefile.objs
 create mode 100644 hw/ide/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index c99f7e3..b75e027 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -12,7 +12,6 @@ devices-dirs-y += dma/
 devices-dirs-y += gpio/
 devices-dirs-$(CONFIG_HYPERV) += hyperv/
 devices-dirs-$(CONFIG_I2C) += i2c/
-devices-dirs-y += ide/
 endif
 
 common-obj-y += $(devices-dirs-y)
diff --git a/hw/ide/Makefile.objs b/hw/ide/Makefile.objs
deleted file mode 100644
index faf04e0..0000000
--- a/hw/ide/Makefile.objs
+++ /dev/null
@@ -1,14 +0,0 @@
-common-obj-$(CONFIG_IDE_CORE) += core.o atapi.o
-common-obj-$(CONFIG_IDE_QDEV) += qdev.o
-common-obj-$(CONFIG_IDE_PCI) += pci.o
-common-obj-$(CONFIG_IDE_ISA) += isa.o ioport.o
-common-obj-$(CONFIG_IDE_PIIX) += piix.o ioport.o
-common-obj-$(CONFIG_IDE_CMD646) += cmd646.o
-common-obj-$(CONFIG_IDE_MACIO) += macio.o
-common-obj-$(CONFIG_IDE_MMIO) += mmio.o
-common-obj-$(CONFIG_IDE_VIA) += via.o
-common-obj-$(CONFIG_MICRODRIVE) += microdrive.o
-common-obj-$(CONFIG_AHCI) += ahci.o
-common-obj-$(CONFIG_AHCI_ICH9) += ich.o
-common-obj-$(CONFIG_ALLWINNER_A10) += ahci-allwinner.o
-common-obj-$(CONFIG_IDE_SII3112) += sii3112.o
diff --git a/hw/ide/meson.build b/hw/ide/meson.build
new file mode 100644
index 0000000..ddcb3b2
--- /dev/null
+++ b/hw/ide/meson.build
@@ -0,0 +1,14 @@
+softmmu_ss.add(when: 'CONFIG_AHCI', if_true: files('ahci.c'))
+softmmu_ss.add(when: 'CONFIG_AHCI_ICH9', if_true: files('ich.c'))
+softmmu_ss.add(when: 'CONFIG_ALLWINNER_A10', if_true: files('ahci-allwinner.c'))
+softmmu_ss.add(when: 'CONFIG_IDE_CMD646', if_true: files('cmd646.c'))
+softmmu_ss.add(when: 'CONFIG_IDE_CORE', if_true: files('core.c', 'atapi.c'))
+softmmu_ss.add(when: 'CONFIG_IDE_ISA', if_true: files('isa.c', 'ioport.c'))
+softmmu_ss.add(when: 'CONFIG_IDE_MACIO', if_true: files('macio.c'))
+softmmu_ss.add(when: 'CONFIG_IDE_MMIO', if_true: files('mmio.c'))
+softmmu_ss.add(when: 'CONFIG_IDE_PCI', if_true: files('pci.c'))
+softmmu_ss.add(when: 'CONFIG_IDE_PIIX', if_true: files('piix.c', 'ioport.c'))
+softmmu_ss.add(when: 'CONFIG_IDE_QDEV', if_true: files('qdev.c'))
+softmmu_ss.add(when: 'CONFIG_IDE_SII3112', if_true: files('sii3112.c'))
+softmmu_ss.add(when: 'CONFIG_IDE_VIA', if_true: files('via.c'))
+softmmu_ss.add(when: 'CONFIG_MICRODRIVE', if_true: files('microdrive.c'))
diff --git a/hw/meson.build b/hw/meson.build
index a85ec93..848736d 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -1,4 +1,5 @@
 subdir('core')
+subdir('ide')
 subdir('input')
 subdir('intc')
 subdir('ipack')
-- 
1.8.3.1



