Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82AE0C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:22:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54D3C2467E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uMwp6bKK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54D3C2467E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwWRb-0001iL-G6
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 14:22:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36707)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV7o-0003g5-Mh
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:58:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV7n-00087K-GJ
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:58:08 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:33897)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV7n-00083j-9a
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:58:07 -0500
Received: by mail-wr1-x42e.google.com with SMTP id t2so17106243wrr.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UHvLFzmHTkjHMXmJaoCxJ0YHmI8i0R5/gsXric3VkuQ=;
 b=uMwp6bKKAhuztyLDm0Jrv+IQqIqXmt6Edxg0Dx7UXbfd+zEfAdDBicLhgdbQs+wLXp
 eBRBeUiKgbbyx1VroO7U0ZCoWgkRtxzBrRQILTvenH92S4+kXUajk9kxj5pOf1ihsWzK
 AClec8/43Al+Mk97j1fcVf0sHtcz/YJSGpOtOc+GYW/rtrNNOY/x8esxb4UWTN8BCqci
 XFwPAOuETV7LfVmNa0nxlEhv7DHgU7R5khLfnCZnqixEd/bsNVf9EkSi8U4jVRq6rDLG
 PU/7rOcxjgnLu9rkiNeurj/64AOn6RPs1ni94ptg20IZF6y8nNP5tSZxRCKVKBEKChaN
 a73A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=UHvLFzmHTkjHMXmJaoCxJ0YHmI8i0R5/gsXric3VkuQ=;
 b=KPWtEEig+s20ODX5i2yv/06DvASqePrXWXtDFRC6NRlm5afkoLmYlhqgPDb+4nFLXb
 eFbmkTceI2IUX2+1ao5lfFEN9NXe/wZjGx6zojuYS6l6XeVFxOg1lsIJEwDI9/ZvEoTj
 LmJBK+oPxIvnt2oeavX3oej5jCfkL1C2myHSHpEWWbOrk7F20wl/9TaguuBLa5k2u1le
 DEWmR1mDJb0jKBlhUKLctgh64ZUBPBDJoRl7ox56LoKiroio7UWIdQEKWkWPf9Lu2Eon
 3VMmDDpayyJaK1XFArorIL5EfyCArmPYIymL3w8Sw4hUoBthNYCq9QAcBXfTjljInPTy
 3Yuw==
X-Gm-Message-State: APjAAAU8U7PD3DI3lqeIiUs7IIPnzJLWHUMK5N3arKz6HsaoZUK5oKwn
 hf6aDbGuW/eUOqIh8Gy9vJRUwSHB
X-Google-Smtp-Source: APXvYqyVBxdrfBuLu6V6JoLkOsIEGT/iyuu2kCUM/T9rskOhS33dIAG9BTIW1aCZB66QnyjORuj5Aw==
X-Received: by 2002:adf:f80b:: with SMTP id s11mr31555734wrp.12.1580234285054; 
 Tue, 28 Jan 2020 09:58:05 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.58.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:58:04 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 109/142] meson: convert hw/acpi
Date: Tue, 28 Jan 2020 18:53:09 +0100
Message-Id: <20200128175342.9066-110-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42e
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
 hw/acpi/Makefile.objs | 24 ------------------------
 hw/acpi/meson.build   | 22 ++++++++++++++++++++++
 hw/meson.build        |  1 +
 4 files changed, 23 insertions(+), 25 deletions(-)
 delete mode 100644 hw/acpi/Makefile.objs
 create mode 100644 hw/acpi/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 5823867997..3dc4decfb5 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -1,6 +1,5 @@
 ifeq ($(CONFIG_SOFTMMU), y)
 devices-dirs-$(call lor,$(CONFIG_VIRTIO_9P),$(call land,$(CONFIG_VIRTFS),$(CONFIG_XEN))) += 9pfs/
-devices-dirs-y += acpi/
 endif
 
 common-obj-y += $(devices-dirs-y)
diff --git a/hw/acpi/Makefile.objs b/hw/acpi/Makefile.objs
deleted file mode 100644
index 99253057e1..0000000000
--- a/hw/acpi/Makefile.objs
+++ /dev/null
@@ -1,24 +0,0 @@
-ifeq ($(CONFIG_ACPI),y)
-common-obj-$(CONFIG_ACPI_X86) += core.o piix4.o pcihp.o
-common-obj-$(CONFIG_ACPI_X86_ICH) += ich9.o tco.o
-common-obj-$(CONFIG_ACPI_CPU_HOTPLUG) += cpu_hotplug.o
-common-obj-$(CONFIG_ACPI_MEMORY_HOTPLUG) += memory_hotplug.o
-common-obj-$(CONFIG_ACPI_CPU_HOTPLUG) += cpu.o
-common-obj-$(CONFIG_ACPI_NVDIMM) += nvdimm.o
-common-obj-$(CONFIG_ACPI_VMGENID) += vmgenid.o
-common-obj-$(CONFIG_ACPI_HW_REDUCED) += generic_event_device.o
-common-obj-$(call lnot,$(CONFIG_ACPI_X86)) += acpi-stub.o
-common-obj-$(call lnot,$(CONFIG_PC)) += acpi-x86-stub.o
-
-common-obj-y += acpi_interface.o
-common-obj-y += bios-linker-loader.o
-common-obj-y += aml-build.o utils.o
-common-obj-$(CONFIG_ACPI_PCI) += pci.o
-common-obj-$(CONFIG_TPM) += tpm.o
-
-common-obj-$(CONFIG_IPMI) += ipmi.o
-common-obj-$(call lnot,$(CONFIG_IPMI)) += ipmi-stub.o
-else
-common-obj-y += acpi-stub.o
-endif
-common-obj-$(CONFIG_ALL) += acpi-stub.o acpi-x86-stub.o ipmi-stub.o
diff --git a/hw/acpi/meson.build b/hw/acpi/meson.build
new file mode 100644
index 0000000000..356f50705f
--- /dev/null
+++ b/hw/acpi/meson.build
@@ -0,0 +1,22 @@
+acpi_ss = ss.source_set()
+acpi_ss.add(files(
+  'acpi_interface.c',
+  'aml-build.c',
+  'bios-linker-loader.c',
+  'utils.c',
+))
+acpi_ss.add(when: 'CONFIG_ACPI_CPU_HOTPLUG', if_true: files('cpu.c'))
+acpi_ss.add(when: 'CONFIG_ACPI_CPU_HOTPLUG', if_true: files('cpu_hotplug.c'))
+acpi_ss.add(when: 'CONFIG_ACPI_MEMORY_HOTPLUG', if_true: files('memory_hotplug.c'))
+acpi_ss.add(when: 'CONFIG_ACPI_NVDIMM', if_true: files('nvdimm.c'))
+acpi_ss.add(when: 'CONFIG_ACPI_PCI', if_true: files('pci.c'))
+acpi_ss.add(when: 'CONFIG_ACPI_VMGENID', if_true: files('vmgenid.c'))
+acpi_ss.add(when: 'CONFIG_ACPI_HW_REDUCED', if_true: files('generic_event_device.c'))
+acpi_ss.add(when: 'CONFIG_ACPI_X86', if_true: files('core.c', 'piix4.c', 'pcihp.c'), if_false: files('acpi-stub.c'))
+acpi_ss.add(when: 'CONFIG_ACPI_X86_ICH', if_true: files('ich9.c', 'tco.c'))
+acpi_ss.add(when: 'CONFIG_IPMI', if_true: files('ipmi.c'), if_false: files('ipmi-stub.c'))
+acpi_ss.add(when: 'CONFIG_PC', if_false: files('acpi-x86-stub.c'))
+acpi_ss.add(when: 'CONFIG_TPM', if_true: files('tpm.c'))
+softmmu_ss.add(when: 'CONFIG_ACPI', if_false: files('acpi-stub.c'))
+softmmu_ss.add_all(when: 'CONFIG_ACPI', if_true: acpi_ss)
+softmmu_ss.add(when: 'CONFIG_ALL', if_true: files('acpi-stub.c', 'acpi-x86-stub.c', 'ipmi-stub.c'))
diff --git a/hw/meson.build b/hw/meson.build
index ffa3f06dc0..55ca2b2b61 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -1,3 +1,4 @@
+subdir('acpi')
 subdir('adc')
 subdir('audio')
 subdir('block')
-- 
2.21.0



