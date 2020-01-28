Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B93C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:17:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D62A522522
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZ0rXPbU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D62A522522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwWMa-00087C-0l
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 14:17:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35046)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV6z-0002Uy-GX
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:57:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV6x-00069o-AG
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:57:17 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:39955)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV6x-00066V-2p
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:57:15 -0500
Received: by mail-wr1-x42b.google.com with SMTP id j104so1202751wrj.7
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7aIMW1QMu792fc0IP0o5Rz7fA+mnNR+upQe0yVfUqxI=;
 b=lZ0rXPbULjz+F7mpm2OYmGhCcfmKwRhQzZgGoYDng+3V/OPbDpoWTgkI4f3qlEVLM3
 fOiSKf8jVZObYnUrT5xeKvO7YeQd1xqlD4hJNdmnaUtRBWXfEMzfTtspnGhIRlKbE/zB
 fnk2e2QmClQkbxo3wW4abl+SVEDUMPt0r4IPd2sfzv8ha62W8u3X6yjIY7MoU9aHMqtg
 aKamwKXgvnmp8LtVR2nmII7Vbb2gH0vCGksWSxjaw8+yjcCKti1P9g+DU/ajul+TclSG
 DfB/gIjrLp6IiyUboJfQqbQW3ueCfpKsd12ILoyppXDN0eb+M4IR1Kb0cuGYVCItopGq
 QsNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=7aIMW1QMu792fc0IP0o5Rz7fA+mnNR+upQe0yVfUqxI=;
 b=T5GzsMBeHhTI5mn4QD2ylpmDxvI03CyWQ591zWhRouhUhIpYkKohvftR7h2CIR80pP
 fFbD+8wm2RVJlq9TpvZcJhIKzqBP6WKQhEfQa1rognmrWB/qk1EgTuHV191IMRm6AVKp
 nDIHORulnC0CsuQk5yEg9VBbwZ3V7kF099JrJv/i6nMmsPRNILVLCDbl/WpMGtJ/C7CW
 14nIf2BI7Yum8oJX6sZWWq5/sBOWkOxmcPoMn3v6II6L9Icvb21lGsl5gcduQN64xMGs
 EJmijhav23XeCLD+Rovkva4utt9mFk168jwWtCxu9PM7wzvgJf8kTochCtkLCuX44m4E
 GPtA==
X-Gm-Message-State: APjAAAUeeDFBPSh2QsECiSTk/hsd8DsKLf/IqSR61kXX5fa6bWhmjMFx
 KLMcwOxCCJyHMFjVseGFUWvHjWsc
X-Google-Smtp-Source: APXvYqy37x1u8LCpygrLUbo4wkNqJuX5iCrR6AKGdT0wSk9lyaWasFOnbYVD/SVanO5lqcN0wQ/muQ==
X-Received: by 2002:a5d:6144:: with SMTP id y4mr29252625wrt.15.1580234233959; 
 Tue, 28 Jan 2020 09:57:13 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.57.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:57:13 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 087/142] meson: convert hw/pci-bridge
Date: Tue, 28 Jan 2020 18:52:47 +0100
Message-Id: <20200128175342.9066-88-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42b
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
 hw/Makefile.objs            |  1 -
 hw/meson.build              |  1 +
 hw/pci-bridge/Makefile.objs | 10 ----------
 hw/pci-bridge/meson.build   | 14 ++++++++++++++
 4 files changed, 15 insertions(+), 11 deletions(-)
 delete mode 100644 hw/pci-bridge/Makefile.objs
 create mode 100644 hw/pci-bridge/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index ef4c5e503e..d8833d54d1 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -22,7 +22,6 @@ devices-dirs-y += net/
 devices-dirs-y += rdma/
 devices-dirs-y += nvram/
 devices-dirs-y += pci/
-devices-dirs-$(CONFIG_PCI) += pci-bridge/
 endif
 
 common-obj-y += $(devices-dirs-y)
diff --git a/hw/meson.build b/hw/meson.build
index ca36e486e7..a7301f21e8 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -1,6 +1,7 @@
 subdir('core')
 subdir('mem')
 subdir('nubus')
+subdir('pci-bridge')
 subdir('pci-host')
 subdir('pcmcia')
 subdir('rtc')
diff --git a/hw/pci-bridge/Makefile.objs b/hw/pci-bridge/Makefile.objs
deleted file mode 100644
index 47065f87d9..0000000000
--- a/hw/pci-bridge/Makefile.objs
+++ /dev/null
@@ -1,10 +0,0 @@
-common-obj-y += pci_bridge_dev.o
-common-obj-$(CONFIG_PCIE_PORT) += pcie_root_port.o gen_pcie_root_port.o pcie_pci_bridge.o
-common-obj-$(CONFIG_PXB) += pci_expander_bridge.o
-common-obj-$(CONFIG_XIO3130) += xio3130_upstream.o xio3130_downstream.o
-common-obj-$(CONFIG_IOH3420) += ioh3420.o
-common-obj-$(CONFIG_I82801B11) += i82801b11.o
-# NewWorld PowerMac
-common-obj-$(CONFIG_DEC_PCI) += dec.o
-# Sun4u
-common-obj-$(CONFIG_SIMBA) += simba.o
diff --git a/hw/pci-bridge/meson.build b/hw/pci-bridge/meson.build
new file mode 100644
index 0000000000..daab8acf2a
--- /dev/null
+++ b/hw/pci-bridge/meson.build
@@ -0,0 +1,14 @@
+pci_ss = ss.source_set()
+pci_ss.add(files('pci_bridge_dev.c'))
+pci_ss.add(when: 'CONFIG_I82801B11', if_true: files('i82801b11.c'))
+pci_ss.add(when: 'CONFIG_IOH3420', if_true: files('ioh3420.c'))
+pci_ss.add(when: 'CONFIG_PCIE_PORT', if_true: files('pcie_root_port.c', 'gen_pcie_root_port.c', 'pcie_pci_bridge.c'))
+pci_ss.add(when: 'CONFIG_PXB', if_true: files('pci_expander_bridge.c'))
+pci_ss.add(when: 'CONFIG_XIO3130', if_true: files('xio3130_upstream.c', 'xio3130_downstream.c'))
+
+# NewWorld PowerMac
+pci_ss.add(when: 'CONFIG_DEC_PCI', if_true: files('dec.c'))
+# Sun4u
+pci_ss.add(when: 'CONFIG_SIMBA', if_true: files('simba.c'))
+
+softmmu_ss.add_all(when: 'CONFIG_PCI', if_true: pci_ss)
-- 
2.21.0



