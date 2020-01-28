Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C775C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:58:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 188642467E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cZnkI3Pw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 188642467E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwW4d-0005js-8G
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 13:58:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34691)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV6r-0002DE-OR
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:57:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV6q-0005oA-Ih
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:57:09 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37473)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV6q-0005l9-B1
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:57:08 -0500
Received: by mail-wr1-x441.google.com with SMTP id w15so17144557wru.4
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+YLYidGMDJSpAJoRDMmmwUCffvmcDaDumLHo/sgB8Dc=;
 b=cZnkI3PwcskpYlNWdhGYk3W0jigJuPbT5ChHa2anLHsdj+QpBG7kY2p7+lGC5B4d4H
 7c7pqb7DZBE5dxN0Zzrv09iyhUVVhQUmXaVznCR8LqK4z8RFRQQeNra6FjgVNk03erJf
 KpQD1SPpePdglYsf9D2Wa0v1eB35XgNVJDSbJIjtOSzcoPBSs9U7FtRPV9IN6lTrs6eo
 2cHX5WNc/ge2P0PnQ+Yl70wcT3J4u1ThCYGRBpd0Eyf1BZvGWxaITuRSxEXaoda/IXXH
 jVTcLT7ue8O2ZYJz/4UWPfNGIYg5uWNWn0Lkp8sjdbadomhTETQu8fi6KIF2I4aJzR59
 Ekvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=+YLYidGMDJSpAJoRDMmmwUCffvmcDaDumLHo/sgB8Dc=;
 b=pF5LbS/c9U8ubgj3+b6WuC9uzaRApDZRW/1maxKGVNABGfgK2jpZItV/TlXJ2OI9G1
 mN/uypwcPVqMoudMdOiK5N0IVWi5cOKgPCHhb9MPX2uDc4TNyBCuoa3ePyLuakFsKOAM
 iNZ/44qo3QopQdyz6p0dW/t+ZOcJ+Kt1TrZFab7YKLtrP21EBuFVaNs5CD9MBnPl4DA4
 4XDQ4FKpOOcMX3yU5SYPJMJJoCIZdE7nKZctLRaXt2i79905IX1k4u/mjMjvuNem+vJN
 WMWv/qA+daAK4lqLRVNMkquz/TH3fi6vZuVvLWNpRtNgJwCMsmAbUFCyf4PdZ+k3gSsN
 JpIQ==
X-Gm-Message-State: APjAAAWXvFtcuX1MqmRPphlrBpVTzkyK7/HKtz+mrlubnIpLIw6NmH7T
 91Gn16/ukUkDrMUPxaxdTaO975rg
X-Google-Smtp-Source: APXvYqymwbJKgG+nFKX+DiPr6nsTVeUBnO4YgnSm9P3Bk6QruiRTnoSnUNXskMaglQhL4rI4qa8xcQ==
X-Received: by 2002:adf:c746:: with SMTP id b6mr29682152wrh.298.1580234227237; 
 Tue, 28 Jan 2020 09:57:07 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.57.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:57:06 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 084/142] meson: convert hw/scsi
Date: Tue, 28 Jan 2020 18:52:44 +0100
Message-Id: <20200128175342.9066-85-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
 hw/Makefile.objs      |  1 -
 hw/meson.build        |  1 +
 hw/scsi/Makefile.objs | 15 ---------------
 hw/scsi/meson.build   | 26 ++++++++++++++++++++++++++
 4 files changed, 27 insertions(+), 16 deletions(-)
 delete mode 100644 hw/scsi/Makefile.objs
 create mode 100644 hw/scsi/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index a72fa7895c..027ae24c29 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -24,7 +24,6 @@ devices-dirs-y += nvram/
 devices-dirs-y += pci/
 devices-dirs-$(CONFIG_PCI) += pci-bridge/ pci-host/
 devices-dirs-y += pcmcia/
-devices-dirs-$(CONFIG_SCSI) += scsi/
 endif
 
 common-obj-y += $(devices-dirs-y)
diff --git a/hw/meson.build b/hw/meson.build
index a73f4aebde..d4abb67715 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -2,6 +2,7 @@ subdir('core')
 subdir('mem')
 subdir('nubus')
 subdir('rtc')
+subdir('scsi')
 subdir('sd')
 subdir('semihosting')
 subdir('smbios')
diff --git a/hw/scsi/Makefile.objs b/hw/scsi/Makefile.objs
deleted file mode 100644
index 54b36ed8b1..0000000000
--- a/hw/scsi/Makefile.objs
+++ /dev/null
@@ -1,15 +0,0 @@
-common-obj-y += scsi-disk.o emulation.o
-common-obj-y += scsi-generic.o scsi-bus.o
-common-obj-$(CONFIG_LSI_SCSI_PCI) += lsi53c895a.o
-common-obj-$(CONFIG_MPTSAS_SCSI_PCI) += mptsas.o mptconfig.o mptendian.o
-common-obj-$(CONFIG_MEGASAS_SCSI_PCI) += megasas.o
-common-obj-$(CONFIG_VMW_PVSCSI_SCSI_PCI) += vmw_pvscsi.o
-common-obj-$(CONFIG_ESP) += esp.o
-common-obj-$(CONFIG_ESP_PCI) += esp-pci.o
-obj-$(CONFIG_SPAPR_VSCSI) += spapr_vscsi.o
-
-ifeq ($(CONFIG_VIRTIO_SCSI),y)
-obj-y += virtio-scsi.o virtio-scsi-dataplane.o
-obj-$(CONFIG_VHOST_SCSI) += vhost-scsi-common.o vhost-scsi.o
-obj-$(CONFIG_VHOST_USER_SCSI) += vhost-scsi-common.o vhost-user-scsi.o
-endif
diff --git a/hw/scsi/meson.build b/hw/scsi/meson.build
new file mode 100644
index 0000000000..923a34f344
--- /dev/null
+++ b/hw/scsi/meson.build
@@ -0,0 +1,26 @@
+scsi_ss = ss.source_set()
+scsi_ss.add(files(
+  'emulation.c',
+  'scsi-bus.c',
+  'scsi-disk.c',
+  'scsi-generic.c',
+))
+scsi_ss.add(when: 'CONFIG_ESP', if_true: files('esp.c'))
+scsi_ss.add(when: 'CONFIG_ESP_PCI', if_true: files('esp-pci.c'))
+scsi_ss.add(when: 'CONFIG_LSI_SCSI_PCI', if_true: files('lsi53c895a.c'))
+scsi_ss.add(when: 'CONFIG_MEGASAS_SCSI_PCI', if_true: files('megasas.c'))
+scsi_ss.add(when: 'CONFIG_MPTSAS_SCSI_PCI', if_true: files('mptsas.c', 'mptconfig.c', 'mptendian.c'))
+scsi_ss.add(when: 'CONFIG_VMW_PVSCSI_SCSI_PCI', if_true: files('vmw_pvscsi.c'))
+softmmu_ss.add_all(when: 'CONFIG_SCSI', if_true: scsi_ss)
+
+specific_scsi_ss = ss.source_set()
+
+virtio_scsi_ss = ss.source_set()
+virtio_scsi_ss.add(files('virtio-scsi.c', 'virtio-scsi-dataplane.c'))
+virtio_scsi_ss.add(when: 'CONFIG_VHOST_SCSI', if_true: files('vhost-scsi-common.c', 'vhost-scsi.c'))
+virtio_scsi_ss.add(when: 'CONFIG_VHOST_USER_SCSI', if_true: files('vhost-scsi-common.c', 'vhost-user-scsi.c'))
+specific_scsi_ss.add_all(when: 'CONFIG_VIRTIO_SCSI', if_true: virtio_scsi_ss)
+
+specific_scsi_ss.add(when: 'CONFIG_SPAPR_VSCSI', if_true: files('spapr_vscsi.c'))
+
+specific_ss.add_all(when: 'CONFIG_SCSI', if_true: specific_scsi_ss)
-- 
2.21.0



