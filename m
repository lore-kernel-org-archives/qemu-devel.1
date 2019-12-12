Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF86C2D0C9
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:53:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C9F021655
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ihs6R6RV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C9F021655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifOua-0001hE-PI
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 08:53:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41057)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNz0-0004V6-LE
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:54:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNyz-000803-Cd
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:54:18 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:56060)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifNyz-0007yU-5W
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:54:17 -0500
Received: by mail-wm1-x32c.google.com with SMTP id q9so2239157wmj.5
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 04:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=R77k2Mbztn4q8/5DxwujzSso8bXI5Kuue23snjdJl60=;
 b=ihs6R6RVw93NdSxyJz1hpBRqm2fDW1x1n7zly75lVY2ahry9q9mVIQjpCPCzUj4oqh
 /WhzfDqL6b6riXHad+kE/FzR6g4l/ka19TfA0uQvaFq9nJtSxzL6gLXQI0Jn2+TIaw4v
 D94PR69U5ltZmW3e3RtyzApJXdbMcnK7jmw/UAyPV6laaQIZC4dR/YQMLQYppCe6uJAL
 gOakeQHrhWULgYwfWRK1yDP2re3mV1hEcAFrNSskM9Yi/SktIsawxdnq8+6m+DgX6mrW
 /5EiilICRnCWYu5c9hZq+wMfnGx9XfNn5W6u20GeP8fAB5x2GWh/FBnjwkTQece2IcQc
 8BYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=R77k2Mbztn4q8/5DxwujzSso8bXI5Kuue23snjdJl60=;
 b=YYoMWCU6pLYufe9POrnRl3KMmP9Aks5nP3Fa+jgGhFmVVQHR9JnEGAAhoU2icyJcQw
 wfZ4ZliVTn+XnlAJmT2uSHideVQeVy0SmgZsJQzsNmN/Wk3fvK56b5ZDZ6Z/Q0gm0xBI
 Uvn8pwn2h48SBEKD0RVx2axtCXlEn6RF+qoVE+zufQnDub0fRr/mIuJquVN3deKCpTHz
 Xt9XOGum5wX+rvVZGJR4BauOqxZVbSvTcum8LotGX+wDrc5Q6Ms9mUEIFtJwLbgdY08y
 xDg5GdKxYQznoce00QNpWxJWFqtaYA9s1LbiM4qmBxiA37sDcwmFPHnopEoW86lY+SGw
 e1IQ==
X-Gm-Message-State: APjAAAVDblrAgKuj8ZdzCGLhbBoWaANzci85gLLybqI+aV7IlIDi8R+S
 IoUlC9hyuABgYKxIWb0PXZv0/9zm
X-Google-Smtp-Source: APXvYqyU9m8lDHsudgRuPs2/y8iNHNwLvBF+NTbwmIWH+Llw1v3BWXnnrU1V+2FhNwFNRfjLNQssAA==
X-Received: by 2002:a7b:ce19:: with SMTP id m25mr6122964wmc.83.1576155255921; 
 Thu, 12 Dec 2019 04:54:15 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n189sm5193825wme.33.2019.12.12.04.54.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 04:54:15 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 078/132] meson: convert hw/pci-host
Date: Thu, 12 Dec 2019 13:52:02 +0100
Message-Id: <1576155176-2464-79-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32c
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
 hw/Makefile.objs          |  2 +-
 hw/meson.build            |  1 +
 hw/pci-host/Makefile.objs | 21 ---------------------
 hw/pci-host/meson.build   | 22 ++++++++++++++++++++++
 4 files changed, 24 insertions(+), 22 deletions(-)
 delete mode 100644 hw/pci-host/Makefile.objs
 create mode 100644 hw/pci-host/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index bfa305f..1f76ce1 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -23,7 +23,7 @@ devices-dirs-y += net/
 devices-dirs-y += rdma/
 devices-dirs-y += nvram/
 devices-dirs-y += pci/
-devices-dirs-$(CONFIG_PCI) += pci-bridge/ pci-host/
+devices-dirs-$(CONFIG_PCI) += pci-bridge/
 endif
 
 common-obj-y += $(devices-dirs-y)
diff --git a/hw/meson.build b/hw/meson.build
index 2356eda..b93a496 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -1,5 +1,6 @@
 subdir('core')
 subdir('mem')
+subdir('pci-host')
 subdir('pcmcia')
 subdir('scsi')
 subdir('sd')
diff --git a/hw/pci-host/Makefile.objs b/hw/pci-host/Makefile.objs
deleted file mode 100644
index a9cd3e0..0000000
--- a/hw/pci-host/Makefile.objs
+++ /dev/null
@@ -1,21 +0,0 @@
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
-common-obj-$(CONFIG_PCI_PIIX) += piix.o
-common-obj-$(CONFIG_PCI_EXPRESS_Q35) += q35.o
-common-obj-$(CONFIG_PCI_EXPRESS_GENERIC_BRIDGE) += gpex.o
-common-obj-$(CONFIG_PCI_EXPRESS_XILINX) += xilinx-pcie.o
-
-common-obj-$(CONFIG_PCI_EXPRESS_DESIGNWARE) += designware.o
diff --git a/hw/pci-host/meson.build b/hw/pci-host/meson.build
new file mode 100644
index 0000000..4938826
--- /dev/null
+++ b/hw/pci-host/meson.build
@@ -0,0 +1,22 @@
+pci_ss = ss.source_set()
+pci_ss.add(when: 'CONFIG_FULONG', if_true: files('bonito.c'))
+pci_ss.add(when: 'CONFIG_PAM', if_true: files('pam.c'))
+pci_ss.add(when: 'CONFIG_PCI_EXPRESS_DESIGNWARE', if_true: files('designware.c'))
+pci_ss.add(when: 'CONFIG_PCI_EXPRESS_GENERIC_BRIDGE', if_true: files('gpex.c'))
+pci_ss.add(when: 'CONFIG_PCI_EXPRESS_Q35', if_true: files('q35.c'))
+pci_ss.add(when: 'CONFIG_PCI_EXPRESS_XILINX', if_true: files('xilinx-pcie.c'))
+pci_ss.add(when: 'CONFIG_PCI_PIIX', if_true: files('piix.c'))
+pci_ss.add(when: 'CONFIG_PCI_SABRE', if_true: files('sabre.c'))
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
1.8.3.1



