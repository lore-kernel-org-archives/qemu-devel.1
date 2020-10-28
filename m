Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CEF5C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 09:02:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD21E2240C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 09:02:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CAsGSlju"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD21E2240C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXhLY-0008Lq-I8
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 05:02:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45492)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maxim.uvarov@linaro.org>)
 id 1kXhJ1-0007Nz-Ul
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 04:59:43 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:46431)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <maxim.uvarov@linaro.org>)
 id 1kXhIz-0008Ml-Te
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 04:59:43 -0400
Received: by mail-lj1-x242.google.com with SMTP id 2so5127413ljj.13
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2020 01:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9KzxZphh5qorAZCm7OOtB/tI3KN6E0kQQ+xEwkJpWxM=;
 b=CAsGSljuJw3uvCLpvtA92Xycjxof9qcDxt2mv6LrlQ5QWNxzi0rwe7GoLD7Z9RQeoI
 ge2CRd518VBBe704wYLGYwW/VvnbQqh+Pknt/sFcL7Mf8iSQVpTfindehsgJK98i4Cf5
 9l3uUNMMTBbAyy91UbDGTLo2rviLZE8P7ZmnLL9/p4aMxBOf+kfHKKCU9PvGulYGA6z/
 wII+T1b5U/LdlCXwzZAS5DevaIoThhTpI+6GbLTu0Dx/4p68NeAFaupCWUFLWQKJM6yz
 htamPTcxkhAhDHqnpiy5akCEdfo8hpl5yGiM2FVz/ZMkRLfB7wkVSUB1AUcahA7BcW7e
 205A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9KzxZphh5qorAZCm7OOtB/tI3KN6E0kQQ+xEwkJpWxM=;
 b=bO9Y96hoqhuWej5GN3/H4VtZnECrSMB2db9UImSXRpD6z5Lp8oqDmVbiy2nkU+kDPv
 JsMnprYG3RRDJWPpHtrYDwIkQtAxSrKZhW3wGAuwcZ2gCphV+P43t5DP+9Sq1ppuwpVE
 kXR80m33K3q8QFwTYBaQOH/Skj6x2RyvF8SIkGDB49cX4mwiZR4cF0CUj1c1kj31mxhL
 Z4TaHBYjYGll3Le27pjciI7sFvDIF6FzAkSRKZj115dClRvrCXoRXH8DPbC16BS98s42
 41r6Pw/OZRoKrOaFZyxenuRGo1xKNAXOlZpWOhzLdrnXokOZ81RH8EsrCnAWO/f8B62A
 liWg==
X-Gm-Message-State: AOAM532hyukduvbPYqYourAdNX4Qt9kY+LVqQEjV3+2JSYtZ2RtvRrQC
 KV/1ho1M80OZYRv6apyJVE+HZw==
X-Google-Smtp-Source: ABdhPJzWJrosHWaikvLP3KEh9e3UgnNGGsB3BhffeaUV0l4ZFay1uHHlUhy0/+IDIr9YQcIBzF2kdg==
X-Received: by 2002:a2e:884d:: with SMTP id z13mr597254ljj.413.1603875578430; 
 Wed, 28 Oct 2020 01:59:38 -0700 (PDT)
Received: from localhost.localdomain (37-145-124-43.broadband.corbina.ru.
 [37.145.124.43])
 by smtp.gmail.com with ESMTPSA id l3sm521719lji.36.2020.10.28.01.59.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2020 01:59:37 -0700 (PDT)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: qemu-arm@nongnu.org
Subject: [RFC PATCH] hw/arm/virt: use sbsa-ec for reboot and poweroff in
 secure mode
Date: Wed, 28 Oct 2020 11:59:18 +0300
Message-Id: <20201028085918.14580-1-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::242;
 envelope-from=maxim.uvarov@linaro.org; helo=mail-lj1-x242.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org, francois.ozog@linaro.org, qemu-devel@nongnu.org,
 Maxim Uvarov <maxim.uvarov@linaro.org>, tf-a@lists.trustedfirmware.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If we're emulating EL3 then the EL3 guest firmware is responsible for
providing the PSCI ABI, including reboot, core power down, etc.
sbsa-ref machine has an embedded controller to do reboot, poweroff. Machine
virt,secure=on can reuse this code to do reboot inside ATF.

Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
---
 Hello,

 This patch implements reboot for the secure machine inside ATF firmware. I.e. current qemu
 patch should be used with [1] ATF patch. It looks like that Embedded Controller qemu
 driver (sbsa-ec) can be common and widely used for other emulated machines. While if
 there are plans to extend sbsa-ec then we might find some other solution.

 So for the long term it looks like machine virt was used as an initial playground for secure
 firmware.  While the original intent was a runner for kvm guests. Relation between kvm guest
 and firmware  is not very clear now. If everyone agree it might be good solution to move secure
 firmware things from virt machine to bsa-ref and make this machine reference for secure boot,
 firmware updates  etc.

 [1] https://github.com/muvarov/arm-trusted-firmware/commit/6d3339a0081f6f2b45d99bd7e1b67bcbce8f4e0e

 Best regards,
 Maxim.

 hw/arm/virt.c         | 9 +++++++++
 include/hw/arm/virt.h | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index e465a988d6..6b77912f02 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -152,6 +152,7 @@ static const MemMapEntry base_memmap[] = {
     [VIRT_ACPI_GED] =           { 0x09080000, ACPI_GED_EVT_SEL_LEN },
     [VIRT_NVDIMM_ACPI] =        { 0x09090000, NVDIMM_ACPI_IO_LEN},
     [VIRT_PVTIME] =             { 0x090a0000, 0x00010000 },
+    [VIRT_EC] =                 { 0x090c0000, 0x00001000 },
     [VIRT_MMIO] =               { 0x0a000000, 0x00000200 },
     /* ...repeating for a total of NUM_VIRTIO_TRANSPORTS, each of that size */
     [VIRT_PLATFORM_BUS] =       { 0x0c000000, 0x02000000 },
@@ -1729,6 +1730,13 @@ static void virt_cpu_post_init(VirtMachineState *vms, int max_cpus,
     }
 }
 
+static void init_ec_controller(VirtMachineState *vms)
+{
+    vms->ec = qdev_new("sbsa-ec");
+
+    sysbus_mmio_map(SYS_BUS_DEVICE(vms->ec), 0, vms->memmap[VIRT_EC].base);
+}
+
 static void machvirt_init(MachineState *machine)
 {
     VirtMachineState *vms = VIRT_MACHINE(machine);
@@ -1797,6 +1805,7 @@ static void machvirt_init(MachineState *machine)
      */
     if (vms->secure && firmware_loaded) {
         vms->psci_conduit = QEMU_PSCI_CONDUIT_DISABLED;
+        init_ec_controller(vms);
     } else if (vms->virt) {
         vms->psci_conduit = QEMU_PSCI_CONDUIT_SMC;
     } else {
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index aad6d69841..6f2ce4e4ff 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -85,6 +85,7 @@ enum {
     VIRT_ACPI_GED,
     VIRT_NVDIMM_ACPI,
     VIRT_PVTIME,
+    VIRT_EC,
     VIRT_LOWMEMMAP_LAST,
 };
 
@@ -163,6 +164,7 @@ struct VirtMachineState {
     DeviceState *gic;
     DeviceState *acpi_dev;
     Notifier powerdown_notifier;
+    DeviceState *ec;
 };
 
 #define VIRT_ECAM_ID(high) (high ? VIRT_HIGH_PCIE_ECAM : VIRT_PCIE_ECAM)
-- 
2.17.1


