Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC28C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:53:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AF882467E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PR1UVUL6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AF882467E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwVzV-0006LL-Ed
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 13:53:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36266)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV7X-0003DI-Ak
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:57:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV7W-0007W1-3H
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:57:51 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:45418)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV7V-0007Qt-SA
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:57:50 -0500
Received: by mail-wr1-x433.google.com with SMTP id a6so2509842wrx.12
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LzHvcXhHqxz4BlJdedh4/3e5PmkuBe+KInP2ViD+Wx4=;
 b=PR1UVUL6AE5r0pvb6lr2x18dMtl/a5DZpS5GpqB67b/Wwl70v6UpQ/Eu2b9XDAxXDk
 0OypqPqV+Artka4EHEz56d8N8yAEdx0E4DWzQVxnK1tr7r1bEp8r10uVK+xIPtdJf15I
 OYJfJo7W2csuJA046KKKqte8Hm3wojicmByALRZXd4f0E2TidlRdqvK9H1adJWMn5WgA
 ObOK+rw8iytD9PvKapFiGb1smhsJsBfrMSJ+cGsNeenjYyMXyd7lC4+Paeyfvp6Ju7a6
 45X5E5ksyiqrGLowSKD1Wl/KkCsu9EtNCENUtkQe/vdT8B0gsOdrvy2i2UrO/ExlJiYO
 iw4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=LzHvcXhHqxz4BlJdedh4/3e5PmkuBe+KInP2ViD+Wx4=;
 b=VK2GTm7eqPZ8sLdudRd5WUQdilhhrDvP17ssrm/p0kGjHeYriwiu/PwsKYbE+7BLmn
 cX6sAV+fJX1vsDJ5R5rRl0SAyqKKILcI/XHlyo8mlJgkk4TDTPQwP85Qw7x0+9P9Lyrv
 0+6v9Hr6+V+OuUfb+JD0bvCKW4OxCdP7BO6tXb0MEeem8YGMmj7a5u/5fcQ896UuU5SS
 aAlZpxLVcWb3ubcaVF0CItuMA+MXc7/Gc/mApxNRUTtOmsAcyfUmuMxn0UwbDS9cIhTz
 qU7gXhrZi5AwPHCyseQlPqY1V3DjwfetMWPfNv3QeJ5T3HadUfKEFgW3W1wV+NLdwcAc
 dP4w==
X-Gm-Message-State: APjAAAX3HUhPb9UpW8eNSqQawGaNKZHVpa8AOr32fFwMwyiLVv5Rmk23
 +au7cjNt79I2KQWWqsBSAWj+vuRW
X-Google-Smtp-Source: APXvYqxwwd2Zbq2GQnY5DlN8BbUXf8BVHLDxg7suZ289nsN0x5i063Pjv9onryIwlMWfEIfikGJdOw==
X-Received: by 2002:a5d:4a91:: with SMTP id o17mr28496969wrq.232.1580234267779; 
 Tue, 28 Jan 2020 09:57:47 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.57.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:57:47 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 102/142] meson: convert hw/dma
Date: Tue, 28 Jan 2020 18:53:02 +0100
Message-Id: <20200128175342.9066-103-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::433
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/Makefile.objs     |  1 -
 hw/dma/Makefile.objs | 16 ----------------
 hw/dma/meson.build   | 16 ++++++++++++++++
 hw/meson.build       |  1 +
 4 files changed, 17 insertions(+), 17 deletions(-)
 delete mode 100644 hw/dma/Makefile.objs
 create mode 100644 hw/dma/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index d9b7d6b912..1f946ee6f3 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -7,7 +7,6 @@ devices-dirs-y += block/
 devices-dirs-y += char/
 devices-dirs-y += cpu/
 devices-dirs-y += display/
-devices-dirs-y += dma/
 endif
 
 common-obj-y += $(devices-dirs-y)
diff --git a/hw/dma/Makefile.objs b/hw/dma/Makefile.objs
deleted file mode 100644
index b672e7a522..0000000000
--- a/hw/dma/Makefile.objs
+++ /dev/null
@@ -1,16 +0,0 @@
-common-obj-$(CONFIG_PUV3) += puv3_dma.o
-common-obj-$(CONFIG_RC4030) += rc4030.o
-common-obj-$(CONFIG_PL080) += pl080.o
-common-obj-$(CONFIG_PL330) += pl330.o
-common-obj-$(CONFIG_I82374) += i82374.o
-common-obj-$(CONFIG_I8257) += i8257.o
-common-obj-$(CONFIG_XILINX_AXI) += xilinx_axidma.o
-common-obj-$(CONFIG_ZYNQ_DEVCFG) += xlnx-zynq-devcfg.o
-common-obj-$(CONFIG_ETRAXFS) += etraxfs_dma.o
-common-obj-$(CONFIG_STP2000) += sparc32_dma.o
-obj-$(CONFIG_XLNX_ZYNQMP_ARM) += xlnx_dpdma.o
-common-obj-$(CONFIG_XLNX_ZYNQMP_ARM) += xlnx-zdma.o
-
-obj-$(CONFIG_OMAP) += omap_dma.o soc_dma.o
-obj-$(CONFIG_PXA2XX) += pxa2xx_dma.o
-common-obj-$(CONFIG_RASPI) += bcm2835_dma.o
diff --git a/hw/dma/meson.build b/hw/dma/meson.build
new file mode 100644
index 0000000000..84677ad7f0
--- /dev/null
+++ b/hw/dma/meson.build
@@ -0,0 +1,16 @@
+softmmu_ss.add(when: 'CONFIG_PUV3', if_true: files('puv3_dma.c'))
+softmmu_ss.add(when: 'CONFIG_RC4030', if_true: files('rc4030.c'))
+softmmu_ss.add(when: 'CONFIG_PL080', if_true: files('pl080.c'))
+softmmu_ss.add(when: 'CONFIG_PL330', if_true: files('pl330.c'))
+softmmu_ss.add(when: 'CONFIG_I82374', if_true: files('i82374.c'))
+softmmu_ss.add(when: 'CONFIG_I8257', if_true: files('i8257.c'))
+softmmu_ss.add(when: 'CONFIG_XILINX_AXI', if_true: files('xilinx_axidma.c'))
+softmmu_ss.add(when: 'CONFIG_ZYNQ_DEVCFG', if_true: files('xlnx-zynq-devcfg.c'))
+softmmu_ss.add(when: 'CONFIG_ETRAXFS', if_true: files('etraxfs_dma.c'))
+softmmu_ss.add(when: 'CONFIG_STP2000', if_true: files('sparc32_dma.c'))
+specific_ss.add(when: 'CONFIG_XLNX_ZYNQMP_ARM', if_true: files('xlnx_dpdma.c'))
+softmmu_ss.add(when: 'CONFIG_XLNX_ZYNQMP_ARM', if_true: files('xlnx-zdma.c'))
+
+specific_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_dma.c', 'soc_dma.c'))
+specific_ss.add(when: 'CONFIG_PXA2XX', if_true: files('pxa2xx_dma.c'))
+softmmu_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_dma.c'))
diff --git a/hw/meson.build b/hw/meson.build
index 52577c3205..96da0bba7e 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -1,4 +1,5 @@
 subdir('core')
+subdir('dma')
 subdir('gpio')
 subdir('hyperv')
 subdir('i2c')
-- 
2.21.0



