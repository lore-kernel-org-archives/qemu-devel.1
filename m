Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7383C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:10:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54BAF20708
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:10:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t043FL1c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54BAF20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwWFz-00059N-E0
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 14:10:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35951)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV7P-0002zL-TW
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:57:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV7N-00079T-1d
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:57:43 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:38276)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV7L-00073N-Ki
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:57:40 -0500
Received: by mail-wr1-x433.google.com with SMTP id y17so17113298wrh.5
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=opplYY2OR8Ra5A7Uw+5gUoNt1YQ9TY649PlQgkkOCII=;
 b=t043FL1cLTzkhjHY33HdtcydFPMiJVmXWIxpRmbxNybj37R+6/XeBbg0WxVD/6QF0N
 G4rPtTkBVh0pHt0iqIjwbAQipnbFe/QcNysTWzOa/t/m3fEpQ+3D32s4uIKrW5+qjmbY
 UV4IUh7UluwxfKzeUYWbykXwjEDLdc5O8JaasUuRP8VoYx/LZV7aNlgWc10lNuajnM3Z
 z21qFVrrsvHRyPXTikPfIcZqye8Tsp6YAfbkgKPtcgJSegPA+pLwTpiiefrEbdsJ05O0
 isEdFr+fuIZ7fu/QWVZG5NNFsMsGuSitJO2ZwMBP+CKi5CsgeqxYsZyzqBO0mdM9AfR7
 ImiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=opplYY2OR8Ra5A7Uw+5gUoNt1YQ9TY649PlQgkkOCII=;
 b=k1FT2XtMQVFOFIKWnKUAkluT01fGf6IK1cy9xR1FmmnIo9rcmKa2yTm1VTiPvGMB3U
 wOmYrek5lWLwAkeNl7VcCkBvlCVaDBPLGldSwGysQ0Ulom5r5ohynDQ8EuMlzE65cZYX
 1cje0mL7W3WkdB9t4iEnfTusMopFzzcF4Lk0TLhNESJvrsdEjStgeRK3yrOXbdGbtgTE
 H8TSRaoqiJG9wNA/0lwGztMvWoRv1LA/BuEamKDR8epAq4IBXZP4d+irEId32xpsfo0s
 XBNx40irIMjTsEmVls8CR5S6HwyQskFVECblm4Kl+MuCqrUW3jeDfXToTBWa1QRMz3Zk
 X6FQ==
X-Gm-Message-State: APjAAAXgEDoqfNQimlzhJuq+eJw+vNSrY6IlxOr0w+yZS9CsrM37I6Z6
 IZN18eI5viXS5TZPIEzmARf7GWUg
X-Google-Smtp-Source: APXvYqwB/UNg61ZGkuOjxlhVPKjrqjZ18fkB53fRv4LWdYsHIzM48SDyqqLIuSxtox4kWiNsyIse6g==
X-Received: by 2002:adf:fc4b:: with SMTP id e11mr31055382wrs.326.1580234257833; 
 Tue, 28 Jan 2020 09:57:37 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.57.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:57:37 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 098/142] meson: convert hw/ide
Date: Tue, 28 Jan 2020 18:52:58 +0100
Message-Id: <20200128175342.9066-99-pbonzini@redhat.com>
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
 hw/ide/Makefile.objs | 14 --------------
 hw/ide/meson.build   | 14 ++++++++++++++
 hw/meson.build       |  1 +
 4 files changed, 15 insertions(+), 15 deletions(-)
 delete mode 100644 hw/ide/Makefile.objs
 create mode 100644 hw/ide/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 52a99a8760..545d7440b5 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -11,7 +11,6 @@ devices-dirs-y += dma/
 devices-dirs-y += gpio/
 devices-dirs-$(CONFIG_HYPERV) += hyperv/
 devices-dirs-$(CONFIG_I2C) += i2c/
-devices-dirs-y += ide/
 endif
 
 common-obj-y += $(devices-dirs-y)
diff --git a/hw/ide/Makefile.objs b/hw/ide/Makefile.objs
deleted file mode 100644
index faf04e0209..0000000000
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
index 0000000000..ddcb3b28d2
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
index b15c8d0970..4d7c31c652 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -1,4 +1,5 @@
 subdir('core')
+subdir('ide')
 subdir('input')
 subdir('intc')
 subdir('ipack')
-- 
2.21.0



