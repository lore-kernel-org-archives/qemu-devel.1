Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F3CC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:16:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC389205CB
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rp0/kuAo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC389205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7gsV-0007Ue-Cr
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 11:16:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41678)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gHr-0005xW-2l
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:59 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:39236)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gHp-0006JP-6S
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:58 -0400
Received: by mail-wr1-x435.google.com with SMTP id a5so15261137wrm.6
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 07:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=I5sTwjY55tIx6VkpEdnjtkbMh7zB2PQKI/MqcK86Yew=;
 b=rp0/kuAo4+PvF6pRHbTQIfXagA74XGXDvowwYWDvzJCwVB6Ou9nozPzZymnHYdi/Tp
 B/f/57IScHxW2oPOBN56yUlWgV1xXwA8DVJsC45cIbJxGBI45ntIeshktmLoOkBsNxVN
 uoz9v7CRMPd8S0qTt2qi0cPxXGqVmlfRp8DqaK8dET9jNLrY80xv1bH23iEHieO7Jiwd
 MuHs69FOSvTs3Qmt4PmVrkadXwYp9dnYytSVFMvdWgdZbqQUhmur74iAF+NL21/p6/nO
 EEKx2LThZpgfRBNWeLJu4Jmi2i9hrZ3GO4QF5HrM2DYZPWsFH6zeREPB3HsfTgzwJOIv
 3zbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=I5sTwjY55tIx6VkpEdnjtkbMh7zB2PQKI/MqcK86Yew=;
 b=IFhY1QNYIaaebrl9f8b5nHoHWh4vEVFuYvqgxrOQXm1XmVqe8Xgi3EpQqA0TbI7xx5
 oABFChK6orq9YBdoGO7Fz80q34HpUVFc/OaqGQuwDN7dfaadT1Q3jSvZerJEc/G8gfy6
 jBim4JPWsBogy2StngP1LU+33WIk6COyeFl/zshyFs6kST7oUrob+MYy0G2lgMLK9NEi
 G/ahJ0+kCj2js6snGJ0Jdgnf3FidsUZZjhNtk1SR+5XDQTU9CvFjfGU7HJNxy63gGEmQ
 Df/0i/IS4AIhCOrZ+JB5ZERdVbHupkT3G48U3D8jq8Ws3hPITGWpLiEISvamql1iR7qa
 4w7g==
X-Gm-Message-State: AOAM5318gRaSS0dH5lw5GZ0Epn4TI3lIH7BXJ+bj4QdvJ3muCBwkBLsr
 mX59l0tDybp9N4pNl/FIsqXfehzyQfk=
X-Google-Smtp-Source: ABdhPJyPNCXPGCbgmbMQHM/812CyyE1hU+gKY0dha3E9Czt7j+7Y1/FtN2E0s/xxP/AKWHAyCNOx0g==
X-Received: by 2002:adf:812a:: with SMTP id 39mr15323136wrm.137.1597675135551; 
 Mon, 17 Aug 2020 07:38:55 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:a0d1:fc42:c610:f977])
 by smtp.gmail.com with ESMTPSA id
 i22sm34966603wrb.45.2020.08.17.07.38.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 07:38:55 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 091/150] meson: convert hw/virtio
Date: Mon, 17 Aug 2020 16:36:24 +0200
Message-Id: <20200817143723.343284-92-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817143723.343284-1-pbonzini@redhat.com>
References: <20200817143723.343284-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x435.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/Makefile.objs        |  1 -
 hw/meson.build          |  1 +
 hw/virtio/Makefile.objs | 48 --------------------------------------
 hw/virtio/meson.build   | 51 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 52 insertions(+), 49 deletions(-)
 delete mode 100644 hw/virtio/Makefile.objs
 create mode 100644 hw/virtio/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 9ebd13d7cd..a1cfb99334 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -32,7 +32,6 @@ devices-dirs-y += timer/
 devices-dirs-$(CONFIG_TPM) += tpm/
 devices-dirs-y += usb/
 devices-dirs-$(CONFIG_VFIO) += vfio/
-devices-dirs-y += virtio/
 endif
 
 common-obj-y += $(devices-dirs-y)
diff --git a/hw/meson.build b/hw/meson.build
index f2209d900c..8338fc4408 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -3,5 +3,6 @@ subdir('mem')
 subdir('nubus')
 subdir('semihosting')
 subdir('smbios')
+subdir('virtio')
 subdir('watchdog')
 subdir('xen')
diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
deleted file mode 100644
index fc91719b4a..0000000000
--- a/hw/virtio/Makefile.objs
+++ /dev/null
@@ -1,48 +0,0 @@
-ifeq ($(CONFIG_VIRTIO),y)
-common-obj-y += virtio-bus.o
-obj-y += virtio.o
-
-obj-$(CONFIG_VHOST) += vhost.o vhost-backend.o
-common-obj-$(call lnot,$(CONFIG_VHOST)) += vhost-stub.o
-obj-$(CONFIG_VHOST_USER) += vhost-user.o
-obj-$(CONFIG_VHOST_VDPA) += vhost-vdpa.o
-
-common-obj-$(CONFIG_VIRTIO_RNG) += virtio-rng.o
-common-obj-$(CONFIG_VIRTIO_PCI) += virtio-pci.o
-common-obj-$(CONFIG_VIRTIO_MMIO) += virtio-mmio.o
-obj-$(CONFIG_VIRTIO_BALLOON) += virtio-balloon.o
-obj-$(CONFIG_VIRTIO_CRYPTO) += virtio-crypto.o
-obj-$(CONFIG_VHOST_USER_FS) += vhost-user-fs.o
-obj-$(call land,$(CONFIG_VIRTIO_CRYPTO),$(CONFIG_VIRTIO_PCI)) += virtio-crypto-pci.o
-obj-$(CONFIG_VIRTIO_PMEM) += virtio-pmem.o
-common-obj-$(call land,$(CONFIG_VIRTIO_PMEM),$(CONFIG_VIRTIO_PCI)) += virtio-pmem-pci.o
-obj-$(call land,$(CONFIG_VHOST_USER_FS),$(CONFIG_VIRTIO_PCI)) += vhost-user-fs-pci.o
-obj-$(CONFIG_VIRTIO_IOMMU) += virtio-iommu.o
-obj-$(CONFIG_VHOST_VSOCK) += vhost-vsock-common.o vhost-vsock.o
-obj-$(CONFIG_VHOST_USER_VSOCK) += vhost-vsock-common.o vhost-user-vsock.o
-obj-$(CONFIG_VIRTIO_MEM) += virtio-mem.o
-common-obj-$(call land,$(CONFIG_VIRTIO_MEM),$(CONFIG_VIRTIO_PCI)) += virtio-mem-pci.o
-
-ifeq ($(CONFIG_VIRTIO_PCI),y)
-obj-$(CONFIG_VHOST_VSOCK) += vhost-vsock-pci.o
-obj-$(CONFIG_VHOST_USER_VSOCK) += vhost-user-vsock-pci.o
-obj-$(CONFIG_VHOST_USER_BLK) += vhost-user-blk-pci.o
-obj-$(CONFIG_VHOST_USER_INPUT) += vhost-user-input-pci.o
-obj-$(CONFIG_VHOST_USER_SCSI) += vhost-user-scsi-pci.o
-obj-$(CONFIG_VHOST_SCSI) += vhost-scsi-pci.o
-obj-$(CONFIG_VIRTIO_INPUT_HOST) += virtio-input-host-pci.o
-obj-$(CONFIG_VIRTIO_INPUT) += virtio-input-pci.o
-obj-$(CONFIG_VIRTIO_RNG) += virtio-rng-pci.o
-obj-$(CONFIG_VIRTIO_BALLOON) += virtio-balloon-pci.o
-obj-$(CONFIG_VIRTIO_IOMMU) += virtio-iommu-pci.o
-obj-$(CONFIG_VIRTIO_9P) += virtio-9p-pci.o
-obj-$(CONFIG_VIRTIO_SCSI) += virtio-scsi-pci.o
-obj-$(CONFIG_VIRTIO_BLK) += virtio-blk-pci.o
-obj-$(CONFIG_VIRTIO_NET) += virtio-net-pci.o
-obj-$(CONFIG_VIRTIO_SERIAL) += virtio-serial-pci.o
-endif
-else
-common-obj-y += vhost-stub.o
-endif
-
-common-obj-$(CONFIG_ALL) += vhost-stub.o
diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
new file mode 100644
index 0000000000..fbff9bc9d4
--- /dev/null
+++ b/hw/virtio/meson.build
@@ -0,0 +1,51 @@
+softmmu_virtio_ss = ss.source_set()
+softmmu_virtio_ss.add(files('virtio-bus.c'))
+softmmu_virtio_ss.add(when: 'CONFIG_VIRTIO_PCI', if_true: files('virtio-pci.c'))
+softmmu_virtio_ss.add(when: 'CONFIG_VIRTIO_MMIO', if_true: files('virtio-mmio.c'))
+softmmu_virtio_ss.add(when: 'CONFIG_VHOST', if_false: files('vhost-stub.c'))
+
+softmmu_ss.add_all(when: 'CONFIG_VIRTIO', if_true: softmmu_virtio_ss)
+softmmu_ss.add(when: 'CONFIG_VIRTIO', if_false: files('vhost-stub.c'))
+
+softmmu_ss.add(when: 'CONFIG_ALL', if_true: files('vhost-stub.c'))
+
+virtio_ss = ss.source_set()
+virtio_ss.add(files('virtio.c'))
+virtio_ss.add(when: 'CONFIG_VHOST', if_true: files('vhost.c', 'vhost-backend.c'))
+virtio_ss.add(when: 'CONFIG_VHOST_USER', if_true: files('vhost-user.c'))
+virtio_ss.add(when: 'CONFIG_VHOST_VDPA', if_true: files('vhost-vdpa.c'))
+virtio_ss.add(when: 'CONFIG_VIRTIO_BALLOON', if_true: files('virtio-balloon.c'))
+virtio_ss.add(when: 'CONFIG_VIRTIO_CRYPTO', if_true: files('virtio-crypto.c'))
+virtio_ss.add(when: ['CONFIG_VIRTIO_CRYPTO', 'CONFIG_VIRTIO_PCI'], if_true: files('virtio-crypto-pci.c'))
+virtio_ss.add(when: 'CONFIG_VHOST_USER_FS', if_true: files('vhost-user-fs.c'))
+virtio_ss.add(when: ['CONFIG_VHOST_USER_FS', 'CONFIG_VIRTIO_PCI'], if_true: files('vhost-user-fs-pci.c'))
+virtio_ss.add(when: 'CONFIG_VIRTIO_PMEM', if_true: files('virtio-pmem.c'))
+virtio_ss.add(when: 'CONFIG_VHOST_VSOCK', if_true: files('vhost-vsock.c', 'vhost-vsock-common.c'))
+virtio_ss.add(when: 'CONFIG_VHOST_USER_VSOCK', if_true: files('vhost-user-vsock.c', 'vhost-vsock-common.c'))
+virtio_ss.add(when: 'CONFIG_VIRTIO_RNG', if_true: files('virtio-rng.c'))
+virtio_ss.add(when: 'CONFIG_VIRTIO_IOMMU', if_true: files('virtio-iommu.c'))
+virtio_ss.add(when: 'CONFIG_VIRTIO_MEM', if_true: files('virtio-mem.c'))
+
+virtio_pci_ss = ss.source_set()
+virtio_pci_ss.add(when: 'CONFIG_VHOST_VSOCK', if_true: files('vhost-vsock-pci.c'))
+virtio_pci_ss.add(when: 'CONFIG_VHOST_USER_VSOCK', if_true: files('vhost-user-vsock-pci.c'))
+virtio_pci_ss.add(when: 'CONFIG_VHOST_USER_BLK', if_true: files('vhost-user-blk-pci.c'))
+virtio_pci_ss.add(when: 'CONFIG_VHOST_USER_INPUT', if_true: files('vhost-user-input-pci.c'))
+virtio_pci_ss.add(when: 'CONFIG_VHOST_USER_SCSI', if_true: files('vhost-user-scsi-pci.c'))
+virtio_pci_ss.add(when: 'CONFIG_VHOST_SCSI', if_true: files('vhost-scsi-pci.c'))
+virtio_pci_ss.add(when: 'CONFIG_VIRTIO_INPUT_HOST', if_true: files('virtio-input-host-pci.c'))
+virtio_pci_ss.add(when: 'CONFIG_VIRTIO_INPUT', if_true: files('virtio-input-pci.c'))
+virtio_pci_ss.add(when: 'CONFIG_VIRTIO_RNG', if_true: files('virtio-rng-pci.c'))
+virtio_pci_ss.add(when: 'CONFIG_VIRTIO_BALLOON', if_true: files('virtio-balloon-pci.c'))
+virtio_pci_ss.add(when: 'CONFIG_VIRTIO_9P', if_true: files('virtio-9p-pci.c'))
+virtio_pci_ss.add(when: 'CONFIG_VIRTIO_SCSI', if_true: files('virtio-scsi-pci.c'))
+virtio_pci_ss.add(when: 'CONFIG_VIRTIO_BLK', if_true: files('virtio-blk-pci.c'))
+virtio_pci_ss.add(when: 'CONFIG_VIRTIO_NET', if_true: files('virtio-net-pci.c'))
+virtio_pci_ss.add(when: 'CONFIG_VIRTIO_SERIAL', if_true: files('virtio-serial-pci.c'))
+virtio_pci_ss.add(when: 'CONFIG_VIRTIO_PMEM', if_true: files('virtio-pmem-pci.c'))
+virtio_pci_ss.add(when: 'CONFIG_VIRTIO_IOMMU', if_true: files('virtio-iommu-pci.c'))
+virtio_pci_ss.add(when: 'CONFIG_VIRTIO_MEM', if_true: files('virtio-mem-pci.c'))
+
+virtio_ss.add_all(when: 'CONFIG_VIRTIO_PCI', if_true: virtio_pci_ss)
+
+specific_ss.add_all(when: 'CONFIG_VIRTIO', if_true: virtio_ss)
-- 
2.26.2



