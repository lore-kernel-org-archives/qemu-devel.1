Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CEB4C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:15:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDA912173E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:15:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZzuoELgP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDA912173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwWKf-0004dJ-1x
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 14:15:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34943)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV6x-0002Nj-8j
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:57:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV6w-00064h-3Y
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:57:15 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:35719)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV6v-0005zu-TQ
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:57:14 -0500
Received: by mail-wm1-x333.google.com with SMTP id b2so3598328wma.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bxrJtCRAcUaCAeENX33YYHYKJlZ9qAoaPZno4MAqgGk=;
 b=ZzuoELgP0l/mloxxs8zl2ugp09Kg1fM5+bkBuX3xvQaSF0ysXcb2R4eBe3d45AJ5hr
 nU49W9YwbmLyz1zAFVsi3xbjmUx4mXpt2P4aDcGwRlWGAeJD6Kucb8Lzb92figd49wQQ
 YznnVe5tRmwRpZrTMjGDMO2hiOOPFg89pIwmLhcEoGTE4O4tInDHKKSN6bV3hhIQzGNw
 D2xBgWi9dBYzjXd7nvpXZIR4yY4WE8r6EUtU4gl+ZSWCEb1WkButcYD9uYK3VWCxtdjz
 Df4HFX3nu8gkNI7rNkCV+W1Xoyk9mwjj1aQcAwn9F4/E0NKRNLjdvNlhUN6+G5GK1mvJ
 Fcuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=bxrJtCRAcUaCAeENX33YYHYKJlZ9qAoaPZno4MAqgGk=;
 b=QdC89cMe9z1Lu6eNbWAVZG4L6DpFQpgOKDIU5AY80u1VJPMAfZUWD+aPIdte85NMsI
 2WXBaZDGOh6g2ZxdGYobF4kpyvB/8y4XyOoAH4/hA8Y2Qp5eEtwDLrOPPBHs68j5tfGF
 yCkSZflifnRXrWbJfKv1IUbxZACCTePHdyZuQhqke86MJySD/K8uSbEK63hZKtczVymP
 YBvQdk7xaiPG+En29TGygQf+DQHWpPSEpgvsR+rAhBLQ2bod1fK3Ob+iFegMOblgue9s
 rFVcIpj9VtTTQ6SWDP4x1gqC7S5cGOtCDXb2kK+RQ4wxRuoHzNyZsf1WSJoD0zASICs/
 b2kg==
X-Gm-Message-State: APjAAAXRu5odpJXPPi71fQzAc+ROWM7afdaUySDTd0eNqBS7tU7vV9Le
 A6fL9Mf3OUR9sOPcGSWSyPEvhwUj
X-Google-Smtp-Source: APXvYqxgAllkwuqRg54qWAZ/VS/8RCndFIZC0J6W8Sr4kl6hd+wuqMJFGnvbYWbDsW7+JXaPMm9l6w==
X-Received: by 2002:a7b:c109:: with SMTP id w9mr6187753wmi.14.1580234231714;
 Tue, 28 Jan 2020 09:57:11 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.57.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:57:11 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 086/142] meson: convert hw/pci-host
Date: Tue, 28 Jan 2020 18:52:46 +0100
Message-Id: <20200128175342.9066-87-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::333
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
 hw/Makefile.objs          |  2 +-
 hw/meson.build            |  1 +
 hw/pci-host/Makefile.objs | 22 ----------------------
 hw/pci-host/meson.build   | 23 +++++++++++++++++++++++
 4 files changed, 25 insertions(+), 23 deletions(-)
 delete mode 100644 hw/pci-host/Makefile.objs
 create mode 100644 hw/pci-host/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 21d3f6045c..ef4c5e503e 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -22,7 +22,7 @@ devices-dirs-y += net/
 devices-dirs-y += rdma/
 devices-dirs-y += nvram/
 devices-dirs-y += pci/
-devices-dirs-$(CONFIG_PCI) += pci-bridge/ pci-host/
+devices-dirs-$(CONFIG_PCI) += pci-bridge/
 endif
 
 common-obj-y += $(devices-dirs-y)
diff --git a/hw/meson.build b/hw/meson.build
index ed25644237..ca36e486e7 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -1,6 +1,7 @@
 subdir('core')
 subdir('mem')
 subdir('nubus')
+subdir('pci-host')
 subdir('pcmcia')
 subdir('rtc')
 subdir('scsi')
diff --git a/hw/pci-host/Makefile.objs b/hw/pci-host/Makefile.objs
deleted file mode 100644
index 9c466fab01..0000000000
--- a/hw/pci-host/Makefile.objs
+++ /dev/null
@@ -1,22 +0,0 @@
-common-obj-$(CONFIG_PAM) += pam.o
-
-# PPC devices
-common-obj-$(CONFIG_PREP_PCI) += prep.o
-common-obj-$(CONFIG_GRACKLE_PCI) += grackle.o
-# NewWorld PowerMac
-common-obj-$(CONFIG_UNIN_PCI) += uninorth.o
-# PowerPC E500 boards
-common-obj-$(CONFIG_PPCE500_PCI) += ppce500.o
-
-# ARM devices
-common-obj-$(CONFIG_VERSATILE_PCI) += versatile.o
-
-common-obj-$(CONFIG_PCI_SABRE) += sabre.o
-common-obj-$(CONFIG_FULONG) += bonito.o
-common-obj-$(CONFIG_PCI_I440FX) += i440fx.o
-common-obj-$(CONFIG_XEN_IGD_PASSTHROUGH) += xen_igd_pt.o
-common-obj-$(CONFIG_PCI_EXPRESS_Q35) += q35.o
-common-obj-$(CONFIG_PCI_EXPRESS_GENERIC_BRIDGE) += gpex.o
-common-obj-$(CONFIG_PCI_EXPRESS_XILINX) += xilinx-pcie.o
-
-common-obj-$(CONFIG_PCI_EXPRESS_DESIGNWARE) += designware.o
diff --git a/hw/pci-host/meson.build b/hw/pci-host/meson.build
new file mode 100644
index 0000000000..ad5d8ad4e0
--- /dev/null
+++ b/hw/pci-host/meson.build
@@ -0,0 +1,23 @@
+pci_ss = ss.source_set()
+pci_ss.add(when: 'CONFIG_FULONG', if_true: files('bonito.c'))
+pci_ss.add(when: 'CONFIG_PAM', if_true: files('pam.c'))
+pci_ss.add(when: 'CONFIG_PCI_EXPRESS_DESIGNWARE', if_true: files('designware.c'))
+pci_ss.add(when: 'CONFIG_PCI_EXPRESS_GENERIC_BRIDGE', if_true: files('gpex.c'))
+pci_ss.add(when: 'CONFIG_PCI_EXPRESS_Q35', if_true: files('q35.c'))
+pci_ss.add(when: 'CONFIG_PCI_EXPRESS_XILINX', if_true: files('xilinx-pcie.c'))
+pci_ss.add(when: 'CONFIG_PCI_I440FX', if_true: files('i440fx.c'))
+pci_ss.add(when: 'CONFIG_PCI_SABRE', if_true: files('sabre.c'))
+pci_ss.add(when: 'CONFIG_XEN_IGD_PASSTHROUGH', if_true: files('xen_igd_pt.c'))
+
+# PPC devices
+pci_ss.add(when: 'CONFIG_PREP_PCI', if_true: files('prep.c'))
+pci_ss.add(when: 'CONFIG_GRACKLE_PCI', if_true: files('grackle.c'))
+# NewWorld PowerMac
+pci_ss.add(when: 'CONFIG_UNIN_PCI', if_true: files('uninorth.c'))
+# PowerPC E500 boards
+pci_ss.add(when: 'CONFIG_PPCE500_PCI', if_true: files('ppce500.c'))
+
+# ARM devices
+pci_ss.add(when: 'CONFIG_VERSATILE_PCI', if_true: files('versatile.c'))
+
+softmmu_ss.add_all(when: 'CONFIG_PCI', if_true: pci_ss)
-- 
2.21.0



