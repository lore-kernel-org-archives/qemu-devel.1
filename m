Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 238DBC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 16:59:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E316D208C7
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 16:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y/6IMKQK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E316D208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrP1z-0005iq-32
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 12:59:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50100)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrOxF-0004rz-3H
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:54:25 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:42920)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrOxD-0005gD-8o
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:54:24 -0400
Received: by mail-wr1-x429.google.com with SMTP id o11so33439868wrv.9
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 09:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=t4lZzsSpepDD5cI4hs6XR5J1er+4ioMQ77URYxpBa+8=;
 b=Y/6IMKQKXzoF/+fEKcbdeVdW2xYF0jeP2p7X1bLZ0reDujx6u2/C7DKzKUL2NmibW0
 0JeGEPY3rvkt4EKPNDbGJ/bsJsPLbEiG849/aA/rnwH/BsMNUqVZA3ilW7SS2TLabuYk
 ZZcbqEaXbiPGYqToQgbfxN38s9u/uU1SijmHczNsS4hTvyvxrR52oUGUW2lTLAM5HLuv
 1V87M+ZyLX0ahDTwXQSIRrJO8pCDT60/5J+tzVX+2/AAE4oKGnlOzqkktDXuIZo/7ABY
 3DfcQCg86ACSHyFFCUdaNREteGOv2at8d787lU6v60n2kjZ8IWwoc67Rfe0j2GPAx02k
 ckzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=t4lZzsSpepDD5cI4hs6XR5J1er+4ioMQ77URYxpBa+8=;
 b=qFrkMVCVWsqyKTeevAbF9vjamadLpYwfg7J8J50rYZfQwPDug5+Fm5+UKVqQOhvH+F
 6W40mT5p/hk9yn8sava6wVALzh4puVfRJXpjsp8sPHlWmDr+nDTwYzZnxA7FviXvvBE1
 gcn8+EsunDJbsgPi7BoqqGBkNDH/1M6+bm6y8Nen5nrwD3jym2fxgm1X48mGqlMOd0eR
 fc0i/bWd8r3+Oj3HaJbOm3TUiCMspNG4u2yb3LyYGsmXvjdez6lDrKbm6PDKqvtqra+A
 yYPeRCiBtDB4jpHXdW5pH7HY3Dpsui2Ydh3upI9TZS1UMD3Fc9VLG9nwyCO7AD5I/V+s
 5Llg==
X-Gm-Message-State: AOAM532CgdIifFUlHu9YQ1BBBtKtlBVXt0KBQqTSYmCd6BfDjdmY9F74
 wQ5GjWzwBA9rQrrPw3O2IvT5J8I8E5ioaQ==
X-Google-Smtp-Source: ABdhPJyHlg9hGDMeds5KSzmEX4KqdBvFT9XmMloscSr/QwKVFqPA/xNZPaq9+3hwFCXrMdzHb5Z9HQ==
X-Received: by 2002:adf:dfd1:: with SMTP id q17mr35567807wrn.94.1593795261429; 
 Fri, 03 Jul 2020 09:54:21 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j15sm5574224wrx.69.2020.07.03.09.54.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 09:54:20 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/34] hw/arm/virt-acpi-build: Only expose flash on older
 machine types
Date: Fri,  3 Jul 2020 17:53:44 +0100
Message-Id: <20200703165405.17672-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200703165405.17672-1-peter.maydell@linaro.org>
References: <20200703165405.17672-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Andrew Jones <drjones@redhat.com>

The flash device is exclusively for the host-controlled firmware, so
we should not expose it to the OS. Exposing it risks the OS messing
with it, which could break firmware runtime services and surprise the
OS when all its changes disappear after reboot.

As firmware needs the device and uses DT, we leave the device exposed
there. It's up to firmware to remove the nodes from DT before sending
it on to the OS. However, there's no need to force firmware to remove
tables from ACPI (which it doesn't know how to do anyway), so we
simply don't add the tables in the first place. But, as we've been
adding the tables for quite some time and don't want to change the
default hardware exposed to versioned machines, then we only stop
exposing the flash device tables for 5.1 and later machine types.

Suggested-by: Ard Biesheuvel <ard.biesheuvel@arm.com>
Suggested-by: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Message-id: 20200629140938.17566-4-drjones@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/virt.h    | 1 +
 hw/arm/virt-acpi-build.c | 5 ++++-
 hw/arm/virt.c            | 3 +++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index a18b6b397b6..54bcf17afd3 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -125,6 +125,7 @@ typedef struct {
     bool no_highmem_ecam;
     bool no_ged;   /* Machines < 4.2 has no support for ACPI GED device */
     bool kvm_no_adjvtime;
+    bool acpi_expose_flash;
 } VirtMachineClass;
 
 typedef struct {
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 1384a2cf2ab..91f0df7b13a 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -749,6 +749,7 @@ static void build_fadt_rev5(GArray *table_data, BIOSLinker *linker,
 static void
 build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 {
+    VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
     Aml *scope, *dsdt;
     MachineState *ms = MACHINE(vms);
     const MemMapEntry *memmap = vms->memmap;
@@ -767,7 +768,9 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     acpi_dsdt_add_cpus(scope, vms->smp_cpus);
     acpi_dsdt_add_uart(scope, &memmap[VIRT_UART],
                        (irqmap[VIRT_UART] + ARM_SPI_BASE));
-    acpi_dsdt_add_flash(scope, &memmap[VIRT_FLASH]);
+    if (vmc->acpi_expose_flash) {
+        acpi_dsdt_add_flash(scope, &memmap[VIRT_FLASH]);
+    }
     acpi_dsdt_add_fw_cfg(scope, &memmap[VIRT_FW_CFG]);
     acpi_dsdt_add_virtio(scope, &memmap[VIRT_MMIO],
                     (irqmap[VIRT_MMIO] + ARM_SPI_BASE), NUM_VIRTIO_TRANSPORTS);
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 7922f3c23a5..c78972fb797 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2510,9 +2510,12 @@ DEFINE_VIRT_MACHINE_AS_LATEST(5, 1)
 
 static void virt_machine_5_0_options(MachineClass *mc)
 {
+    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
+
     virt_machine_5_1_options(mc);
     compat_props_add(mc->compat_props, hw_compat_5_0, hw_compat_5_0_len);
     mc->numa_mem_supported = true;
+    vmc->acpi_expose_flash = true;
 }
 DEFINE_VIRT_MACHINE(5, 0)
 
-- 
2.20.1


