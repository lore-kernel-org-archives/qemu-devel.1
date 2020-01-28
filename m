Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F72C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:22:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E8052467E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pMTDknbw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E8052467E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwWRt-0002Uv-FK
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 14:22:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35432)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV77-0002k4-Ub
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:57:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV76-0006cR-6N
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:57:25 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:43655)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV75-0006Yv-U2
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:57:24 -0500
Received: by mail-wr1-x436.google.com with SMTP id d16so17103726wre.10
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xj75gozY8WWu3paBGxKL2HvIAmaV+6/hcJd12RC2vvI=;
 b=pMTDknbwFwsagPqHJQJUVNca/W8BdiwoXgq/5jPpEkMG+FsADcN0mkZRXyQA2Eu9YH
 HiO3XiTl6KKCl3OxBErdUhTU3UoXyfJbtU6uNBYsCmYa9yKZkjOeXm0qtXO4YVcMcmFb
 aabAQlcTiK+FUxcSz3qsS2J4Gj24WPmEVu8+Ss63Q/ZCWiAwMu3vq9shjMPaidq4mpUH
 PUUbfLcNyw/HT1R+/8xMuP5XMOrWuV71xf1mipNpchiHNmWNyhQBNyxHDCc9wehBcIFS
 9zn4kh8rwi6wdG603+APrrg7DFbhKGiBsVErg28vMebklW7IIp13SFKvdivXvC+RW0CD
 riYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=xj75gozY8WWu3paBGxKL2HvIAmaV+6/hcJd12RC2vvI=;
 b=ow3MCeSfndxG7DXuO/U0PKXM/xf+7jWbU3Cyvd0yXgdp859gHqilADJTfG6zxI3b9k
 uLSDp13QlQH9ZKjXndiHu+lT+1GnOp4ZRXqziqT/t2+QkSuErp6DV+hBhVuQNWnr41Lh
 Nulgqi3wlLdZ7MfUE1EMfDoal6pWIMuBGbNBCPPvMxiRuwqF4zKmfd/UkoNNKeD9vSLo
 W+MIr9sVY+P+cgj0PmL1GyM06zA8caz4oCqfQr+iw4lG0TnaCuudcT8YSKIbFMBGH6Xv
 Bj26ehfSy0PKmhrES85mNCN8W6QH4lF9R2yeKfDLJC5SLU/R5g59PY5GL6a/xmTE39l6
 +AHg==
X-Gm-Message-State: APjAAAWiXzLqx71vdT8KWGV+a/XL6iiHX+yNSaBUwDHzsTQcrsbbIhmb
 CD8gDS/hwanJeA7YVjBFXbCX9jgu
X-Google-Smtp-Source: APXvYqz+T9ENCQisuekOgGCWX3P0+DQCVSK6NQ4hrdNiItN6cYy6wVXNk+hHQ5sUzsxNlP5AoV1gXQ==
X-Received: by 2002:a05:6000:11c3:: with SMTP id
 i3mr29596335wrx.244.1580234242417; 
 Tue, 28 Jan 2020 09:57:22 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.57.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:57:21 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 091/142] meson: convert hw/net
Date: Tue, 28 Jan 2020 18:52:51 +0100
Message-Id: <20200128175342.9066-92-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::436
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
 hw/Makefile.objs         |  1 -
 hw/meson.build           |  1 +
 hw/net/Makefile.objs     | 54 ----------------------------------
 hw/net/can/Makefile.objs |  4 ---
 hw/net/can/meson.build   |  4 +++
 hw/net/meson.build       | 62 ++++++++++++++++++++++++++++++++++++++++
 6 files changed, 67 insertions(+), 59 deletions(-)
 delete mode 100644 hw/net/Makefile.objs
 delete mode 100644 hw/net/can/Makefile.objs
 create mode 100644 hw/net/can/meson.build
 create mode 100644 hw/net/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index d27c8f989d..8da7540793 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -18,7 +18,6 @@ devices-dirs-$(CONFIG_IPACK) += ipack/
 devices-dirs-$(CONFIG_IPMI) += ipmi/
 devices-dirs-y += isa/
 devices-dirs-y += misc/
-devices-dirs-y += net/
 endif
 
 common-obj-y += $(devices-dirs-y)
diff --git a/hw/meson.build b/hw/meson.build
index f704e51361..1f7b2c4fb9 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -1,5 +1,6 @@
 subdir('core')
 subdir('mem')
+subdir('net')
 subdir('nubus')
 subdir('nvram')
 subdir('pci')
diff --git a/hw/net/Makefile.objs b/hw/net/Makefile.objs
deleted file mode 100644
index 7907d2c199..0000000000
--- a/hw/net/Makefile.objs
+++ /dev/null
@@ -1,54 +0,0 @@
-common-obj-$(CONFIG_DP8393X) += dp8393x.o
-common-obj-$(CONFIG_XEN) += xen_nic.o
-common-obj-$(CONFIG_NE2000_COMMON) += ne2000.o
-
-# PCI network cards
-common-obj-$(CONFIG_NE2000_PCI) += ne2000-pci.o
-common-obj-$(CONFIG_EEPRO100_PCI) += eepro100.o
-common-obj-$(CONFIG_PCNET_PCI) += pcnet-pci.o
-common-obj-$(CONFIG_PCNET_COMMON) += pcnet.o
-common-obj-$(CONFIG_E1000_PCI) += e1000.o e1000x_common.o
-common-obj-$(CONFIG_E1000E_PCI_EXPRESS) += net_tx_pkt.o net_rx_pkt.o
-common-obj-$(CONFIG_E1000E_PCI_EXPRESS) += e1000e.o e1000e_core.o e1000x_common.o
-common-obj-$(CONFIG_RTL8139_PCI) += rtl8139.o
-common-obj-$(CONFIG_VMXNET3_PCI) += net_tx_pkt.o net_rx_pkt.o
-common-obj-$(CONFIG_VMXNET3_PCI) += vmxnet3.o
-common-obj-$(CONFIG_TULIP) += tulip.o
-
-common-obj-$(CONFIG_SMC91C111) += smc91c111.o
-common-obj-$(CONFIG_LAN9118) += lan9118.o
-common-obj-$(CONFIG_NE2000_ISA) += ne2000-isa.o
-common-obj-$(CONFIG_OPENCORES_ETH) += opencores_eth.o
-common-obj-$(CONFIG_XGMAC) += xgmac.o
-common-obj-$(CONFIG_MIPSNET) += mipsnet.o
-common-obj-$(CONFIG_XILINX_AXI) += xilinx_axienet.o
-common-obj-$(CONFIG_ALLWINNER_EMAC) += allwinner_emac.o
-common-obj-$(CONFIG_IMX_FEC) += imx_fec.o
-
-common-obj-$(CONFIG_CADENCE) += cadence_gem.o
-common-obj-$(CONFIG_STELLARIS_ENET) += stellaris_enet.o
-common-obj-$(CONFIG_LANCE) += lance.o
-common-obj-$(CONFIG_SUNHME) += sunhme.o
-common-obj-$(CONFIG_FTGMAC100) += ftgmac100.o
-common-obj-$(CONFIG_SUNGEM) += sungem.o
-
-obj-$(CONFIG_ETRAXFS) += etraxfs_eth.o
-obj-$(CONFIG_COLDFIRE) += mcf_fec.o
-obj-$(CONFIG_MILKYMIST) += milkymist-minimac2.o
-obj-$(CONFIG_PSERIES) += spapr_llan.o
-obj-$(CONFIG_XILINX_ETHLITE) += xilinx_ethlite.o
-
-obj-$(CONFIG_VIRTIO_NET) += virtio-net.o
-common-obj-$(call land,$(CONFIG_VIRTIO_NET),$(CONFIG_VHOST_NET)) += vhost_net.o
-common-obj-$(call lnot,$(call land,$(CONFIG_VIRTIO_NET),$(CONFIG_VHOST_NET))) += vhost_net-stub.o
-common-obj-$(CONFIG_ALL) += vhost_net-stub.o
-
-obj-$(CONFIG_ETSEC) += fsl_etsec/etsec.o fsl_etsec/registers.o \
-			fsl_etsec/rings.o fsl_etsec/miim.o
-
-common-obj-$(CONFIG_ROCKER) += rocker/rocker.o rocker/rocker_fp.o \
-                               rocker/rocker_desc.o rocker/rocker_world.o \
-                               rocker/rocker_of_dpa.o
-obj-$(call lnot,$(CONFIG_ROCKER)) += rocker/qmp-norocker.o
-
-common-obj-$(CONFIG_CAN_BUS) += can/
diff --git a/hw/net/can/Makefile.objs b/hw/net/can/Makefile.objs
deleted file mode 100644
index 9f0c4ee332..0000000000
--- a/hw/net/can/Makefile.objs
+++ /dev/null
@@ -1,4 +0,0 @@
-common-obj-$(CONFIG_CAN_SJA1000) += can_sja1000.o
-common-obj-$(CONFIG_CAN_PCI) += can_kvaser_pci.o
-common-obj-$(CONFIG_CAN_PCI) += can_pcm3680_pci.o
-common-obj-$(CONFIG_CAN_PCI) += can_mioe3680_pci.o
diff --git a/hw/net/can/meson.build b/hw/net/can/meson.build
new file mode 100644
index 0000000000..c9cfeb7954
--- /dev/null
+++ b/hw/net/can/meson.build
@@ -0,0 +1,4 @@
+softmmu_ss.add(when: 'CONFIG_CAN_SJA1000', if_true: files('can_sja1000.c'))
+softmmu_ss.add(when: 'CONFIG_CAN_PCI', if_true: files('can_kvaser_pci.c'))
+softmmu_ss.add(when: 'CONFIG_CAN_PCI', if_true: files('can_pcm3680_pci.c'))
+softmmu_ss.add(when: 'CONFIG_CAN_PCI', if_true: files('can_mioe3680_pci.c'))
diff --git a/hw/net/meson.build b/hw/net/meson.build
new file mode 100644
index 0000000000..cd19be2c43
--- /dev/null
+++ b/hw/net/meson.build
@@ -0,0 +1,62 @@
+softmmu_ss.add(when: 'CONFIG_DP8393X', if_true: files('dp8393x.c'))
+softmmu_ss.add(when: 'CONFIG_XEN', if_true: files('xen_nic.c'))
+softmmu_ss.add(when: 'CONFIG_NE2000_COMMON', if_true: files('ne2000.c'))
+
+# PCI network cards
+softmmu_ss.add(when: 'CONFIG_NE2000_PCI', if_true: files('ne2000-pci.c'))
+softmmu_ss.add(when: 'CONFIG_EEPRO100_PCI', if_true: files('eepro100.c'))
+softmmu_ss.add(when: 'CONFIG_PCNET_PCI', if_true: files('pcnet-pci.c'))
+softmmu_ss.add(when: 'CONFIG_PCNET_COMMON', if_true: files('pcnet.c'))
+softmmu_ss.add(when: 'CONFIG_E1000_PCI', if_true: files('e1000.c', 'e1000x_common.c'))
+softmmu_ss.add(when: 'CONFIG_E1000E_PCI_EXPRESS', if_true: files('net_tx_pkt.c', 'net_rx_pkt.c'))
+softmmu_ss.add(when: 'CONFIG_E1000E_PCI_EXPRESS', if_true: files('e1000e.c', 'e1000e_core.c', 'e1000x_common.c'))
+softmmu_ss.add(when: 'CONFIG_RTL8139_PCI', if_true: files('rtl8139.c'))
+softmmu_ss.add(when: 'CONFIG_TULIP', if_true: files('tulip.c'))
+softmmu_ss.add(when: 'CONFIG_VMXNET3_PCI', if_true: files('net_tx_pkt.c', 'net_rx_pkt.c'))
+softmmu_ss.add(when: 'CONFIG_VMXNET3_PCI', if_true: files('vmxnet3.c'))
+
+softmmu_ss.add(when: 'CONFIG_SMC91C111', if_true: files('smc91c111.c'))
+softmmu_ss.add(when: 'CONFIG_LAN9118', if_true: files('lan9118.c'))
+softmmu_ss.add(when: 'CONFIG_NE2000_ISA', if_true: files('ne2000-isa.c'))
+softmmu_ss.add(when: 'CONFIG_OPENCORES_ETH', if_true: files('opencores_eth.c'))
+softmmu_ss.add(when: 'CONFIG_XGMAC', if_true: files('xgmac.c'))
+softmmu_ss.add(when: 'CONFIG_MIPSNET', if_true: files('mipsnet.c'))
+softmmu_ss.add(when: 'CONFIG_XILINX_AXI', if_true: files('xilinx_axienet.c'))
+softmmu_ss.add(when: 'CONFIG_ALLWINNER_EMAC', if_true: files('allwinner_emac.c'))
+softmmu_ss.add(when: 'CONFIG_IMX_FEC', if_true: files('imx_fec.c'))
+
+softmmu_ss.add(when: 'CONFIG_CADENCE', if_true: files('cadence_gem.c'))
+softmmu_ss.add(when: 'CONFIG_STELLARIS_ENET', if_true: files('stellaris_enet.c'))
+softmmu_ss.add(when: 'CONFIG_LANCE', if_true: files('lance.c'))
+softmmu_ss.add(when: 'CONFIG_SUNHME', if_true: files('sunhme.c'))
+softmmu_ss.add(when: 'CONFIG_FTGMAC100', if_true: files('ftgmac100.c'))
+softmmu_ss.add(when: 'CONFIG_SUNGEM', if_true: files('sungem.c'))
+
+specific_ss.add(when: 'CONFIG_ETRAXFS', if_true: files('etraxfs_eth.c'))
+specific_ss.add(when: 'CONFIG_COLDFIRE', if_true: files('mcf_fec.c'))
+specific_ss.add(when: 'CONFIG_MILKYMIST', if_true: files('milkymist-minimac2.c'))
+specific_ss.add(when: 'CONFIG_PSERIES', if_true: files('spapr_llan.c'))
+specific_ss.add(when: 'CONFIG_XILINX_ETHLITE', if_true: files('xilinx_ethlite.c'))
+
+specific_ss.add(when: 'CONFIG_VIRTIO_NET', if_true: files('virtio-net.c'))
+
+softmmu_ss.add(when: ['CONFIG_VIRTIO_NET', 'CONFIG_VHOST_NET'], if_true: files('vhost_net.c'), if_false: files('vhost_net-stub.c'))
+softmmu_ss.add(when: 'CONFIG_ALL', if_true: files('vhost_net-stub.c'))
+
+specific_ss.add(when: 'CONFIG_ETSEC', if_true: files(
+  'fsl_etsec/etsec.c',
+  'fsl_etsec/miim.c',
+  'fsl_etsec/registers.c',
+  'fsl_etsec/rings.c',
+))
+
+softmmu_ss.add(when: 'CONFIG_ROCKER', if_true: files(
+  'rocker/rocker.c',
+  'rocker/rocker_desc.c',
+  'rocker/rocker_fp.c',
+  'rocker/rocker_of_dpa.c',
+  'rocker/rocker_world.c',
+), if_false: files('rocker/qmp-norocker.c'))
+softmmu_ss.add(when: 'CONFIG_ALL', if_true: files('rocker/qmp-norocker.c'))
+
+subdir('can')
-- 
2.21.0



