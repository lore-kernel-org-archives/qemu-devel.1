Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95BAFC2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:27:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 643312467E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b1spwden"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 643312467E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwWWf-0003xq-Hd
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 14:27:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38473)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV8b-0005Cp-T4
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:58:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV8a-0001fD-KK
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:58:57 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:40200)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV8a-0001cW-CI
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:58:56 -0500
Received: by mail-wm1-x32a.google.com with SMTP id t14so3553553wmi.5
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+6LrB4p/7+2niYri4fOgK5UHmuuztp867wBvGY2t3Mw=;
 b=b1spwdenBj9jOJd6U5NcS9nBWN50hXKrfZkccng3lYPtbuoyNuuEgDIG9pSS1wVWtl
 2DG6fyljVFUBwb4Dj1Xfi06fEAGm2pOy5zWtimyhBZe9LmHRbTyh2rs4AKPUIfbOHKCz
 b2kbuarmJjK0p55vafk9x22DaylOQ9NIsmaI8r53o0LgA8n2dvcW55pMOmF/ZjwNGGcT
 9UXtrLzJEICP4/QEYslUpCAJqDk2txoIR6JP7h/Aha6crI/n/ITQ7QNoOUFZCABfVUQp
 uMCchcU3RcpkUkrPXHgFV660c4CcD/u2Q7ZuX+Po1K2vY1DATFoSqcs+eLSlFqiX8VB8
 E+Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=+6LrB4p/7+2niYri4fOgK5UHmuuztp867wBvGY2t3Mw=;
 b=OGw4bd6h8cSUtR3OigxAEOEmu9zzTZyIilTPHVnIef62bkqKvzR04pZ6lLIKTrq6V0
 IESK1ytgMTGGtCffINLfPR6dvrCiVbTCykWaXBJ4zqreoZBrW4eXm+VfKmJmCyVSM76o
 +DvBxsR69XeKvziJW7jOGa9YDyRLVpaV3WmLE3U1wVE7AX3SqEb3b7VBq0BxmdPrfYpL
 4cMrHnHX/sB23lGNjwlIFm4GmgudikM5h5gyiXwBmVYHux7+X7Un7V7r1r/0/DJkCU8o
 sZUSryk43w7LAZgXQYGeRIwfPeBv0zD0kjf7ltb8PWD3Rhp03Zh5+sjUIuZ4Efs9jOj2
 7hMQ==
X-Gm-Message-State: APjAAAXJS3rT7giCAplSR9qyDUQhQWz4DEltSKzyOyni/6+So8gCtfSw
 saWxIPB9dkTBcJVS1gRTj8xN1w1x
X-Google-Smtp-Source: APXvYqxhao7Fbesu5CC6UAsJhGxpMTxF4Ow9q1voR5ro0hRSrSZh79pCQMh4f2jC7H5k1p13JYOEUQ==
X-Received: by 2002:a7b:cab1:: with SMTP id r17mr6295766wml.116.1580234333954; 
 Tue, 28 Jan 2020 09:58:53 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.58.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:58:53 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 129/142] meson: install blobs
Date: Tue, 28 Jan 2020 18:53:29 +0100
Message-Id: <20200128175342.9066-130-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 Makefile            | 29 ---------------------
 pc-bios/meson.build | 62 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+), 29 deletions(-)

diff --git a/Makefile b/Makefile
index e4b3470b36..af635a3939 100644
--- a/Makefile
+++ b/Makefile
@@ -220,33 +220,9 @@ de-ch  es     fo  fr-ca  hu     ja  mk  pt  sl     tr \
 bepo    cz
 
 ifdef INSTALL_BLOBS
-BLOBS=bios.bin bios-256k.bin bios-microvm.bin sgabios.bin vgabios.bin vgabios-cirrus.bin \
-vgabios-stdvga.bin vgabios-vmware.bin vgabios-qxl.bin vgabios-virtio.bin \
-vgabios-ramfb.bin vgabios-bochs-display.bin vgabios-ati.bin \
-ppc_rom.bin openbios-sparc32 openbios-sparc64 openbios-ppc QEMU,tcx.bin QEMU,cgthree.bin \
-pxe-e1000.rom pxe-eepro100.rom pxe-ne2k_pci.rom \
-pxe-pcnet.rom pxe-rtl8139.rom pxe-virtio.rom \
-efi-e1000.rom efi-eepro100.rom efi-ne2k_pci.rom \
-efi-pcnet.rom efi-rtl8139.rom efi-virtio.rom \
-efi-e1000e.rom efi-vmxnet3.rom \
-qemu-nsis.bmp \
-bamboo.dtb canyonlands.dtb petalogix-s3adsp1800.dtb petalogix-ml605.dtb \
-multiboot.bin linuxboot.bin linuxboot_dma.bin kvmvapic.bin pvh.bin \
-s390-ccw.img s390-netboot.img \
-slof.bin skiboot.lid \
-palcode-clipper \
-u-boot.e500 u-boot-sam460-20100605.bin \
-qemu_vga.ndrv \
-edk2-licenses.txt \
-hppa-firmware.img \
-opensbi-riscv32-virt-fw_jump.bin \
-opensbi-riscv64-sifive_u-fw_jump.bin opensbi-riscv64-virt-fw_jump.bin
-
-
 DESCS=50-edk2-i386-secure.json 50-edk2-x86_64-secure.json \
 60-edk2-aarch64.json 60-edk2-arm.json 60-edk2-i386.json 60-edk2-x86_64.json
 else
-BLOBS=
 DESCS=
 endif
 
@@ -263,11 +239,6 @@ endif
 ICON_SIZES=16x16 24x24 32x32 48x48 64x64 128x128 256x256 512x512
 
 install: all install-datadir install-localstatedir
-ifneq ($(BLOBS),)
-	set -e; for x in $(BLOBS); do \
-		$(INSTALL_DATA) $(SRC_PATH)/pc-bios/$$x "$(DESTDIR)$(qemu_datadir)"; \
-	done
-endif
 ifneq ($(DESCS),)
 	$(INSTALL_DIR) "$(DESTDIR)$(qemu_datadir)/firmware"
 	set -e; tmpf=$$(mktemp); trap 'rm -f -- "$$tmpf"' EXIT; \
diff --git a/pc-bios/meson.build b/pc-bios/meson.build
index 792679d396..6988c81f51 100644
--- a/pc-bios/meson.build
+++ b/pc-bios/meson.build
@@ -24,3 +24,65 @@ if 'DECOMPRESS_EDK2_BLOBS' in config_host
                   command: [ bzip2, '-dc', '@INPUT0@' ])
   endforeach
 endif
+
+blobs = files(
+  'QEMU,cgthree.bin',
+  'QEMU,tcx.bin',
+  'bamboo.dtb',
+  'bios-256k.bin',
+  'bios.bin',
+  'bios-microvm.bin',
+  'canyonlands.dtb',
+  'edk2-licenses.txt',
+  'efi-e1000.rom',
+  'efi-e1000e.rom',
+  'efi-eepro100.rom',
+  'efi-ne2k_pci.rom',
+  'efi-pcnet.rom',
+  'efi-rtl8139.rom',
+  'efi-virtio.rom',
+  'efi-vmxnet3.rom',
+  'hppa-firmware.img',
+  'kvmvapic.bin',
+  'linuxboot.bin',
+  'linuxboot_dma.bin',
+  'multiboot.bin',
+  'openbios-ppc',
+  'openbios-sparc32',
+  'openbios-sparc64',
+  'opensbi-riscv32-virt-fw_jump.bin',
+  'opensbi-riscv64-sifive_u-fw_jump.bin',
+  'opensbi-riscv64-virt-fw_jump.bin',
+  'palcode-clipper',
+  'petalogix-ml605.dtb',
+  'petalogix-s3adsp1800.dtb',
+  'ppc_rom.bin',
+  'pvh.bin',
+  'pxe-e1000.rom',
+  'pxe-eepro100.rom',
+  'pxe-ne2k_pci.rom',
+  'pxe-pcnet.rom',
+  'pxe-rtl8139.rom',
+  'pxe-virtio.rom',
+  'qemu-nsis.bmp',
+  'qemu_vga.ndrv',
+  's390-ccw.img',
+  's390-netboot.img',
+  'sgabios.bin',
+  'skiboot.lid',
+  'slof.bin',
+  'u-boot-sam460-20100605.bin',
+  'u-boot.e500',
+  'vgabios-ati.bin',
+  'vgabios-bochs-display.bin',
+  'vgabios-cirrus.bin',
+  'vgabios-qxl.bin',
+  'vgabios-ramfb.bin',
+  'vgabios-stdvga.bin',
+  'vgabios-virtio.bin',
+  'vgabios-vmware.bin',
+)
+
+if install_blobs
+  install_data(blobs, install_dir: config_host['qemu_datadir'])
+endif
-- 
2.21.0



