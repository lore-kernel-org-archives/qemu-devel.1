Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A3DC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 16:58:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5574208C7
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 16:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gaoqUowT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5574208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrP15-0003Ik-1V
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 12:58:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50002)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrOx9-0004ei-Is
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:54:19 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:55512)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrOx7-0005fF-Mm
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:54:19 -0400
Received: by mail-wm1-x32b.google.com with SMTP id g75so32622636wme.5
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 09:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=EbbmXTpDnijCYEth67+ubP+o2i89Y7K6M4yUuCHERro=;
 b=gaoqUowTdPGRycBYt8EcKJzHkULzCCCQxEgsTXjhwYXS+0I7wWe4xqYnl2GAQt/1Be
 XFNed+B61WRxpPbIZh5OY/iHQshtUaFa76sxecG6DqmMRDoKBponEJaz4WW5BTRGY39G
 MB6EeCDN0TI6fKaLHfBnvH/qKMqX7CS1BTnBrUqQi4NXHZSlUMYsMAxUUox8UOypMy6k
 EjxDYDLPnu3lApm6hZv89yuLc93fKCj95y+QYLXx8UVjTBnphVjUkKssoyUIrc1Ax8ev
 xkDmII+HSm/sQiV+C7HQcB1YqSTcvooiRFP/+dre6vANTcbB729E1lSvl/Tdc11/VVQE
 PqUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EbbmXTpDnijCYEth67+ubP+o2i89Y7K6M4yUuCHERro=;
 b=cheN3MOijJtBmkNpZqfbLbQknk+PzJebgTJWZXFa5zP/5+D9vw7V44BDj/lyc3Ktyn
 xGxaxza1bat/7O4KT1tQt//GUK5ngQWED7yIAOCIiQdnehDvU7iViK0T7TcUWIiKFtT0
 c4a1abeYmirhEj6HswpLAmAnIT0Di2mrKZdKyC5c2B+ZDwkE/wH74SHmV6fftm/AQq3G
 LvR3L3bcphOzbpyLmhLmBI3to2vGZSDLjzvyZV65YlXQ4p1+VAV15TlN0oVWojoIeLrq
 DImm9Gzi2KkuvPTJo5rC69+2QgiBXQWykR2NJvKc4QHb3txwMOlW4ojcx5cegHsYV1ch
 x0dA==
X-Gm-Message-State: AOAM531dN72Z0pm1cS2Bs3iasL1I6kQL7iUFx73uW/QDqiEt1LqOZ34+
 kYebU9UZHv3qTMd4vRrWbpHeY2IfMl1emQ==
X-Google-Smtp-Source: ABdhPJwF2DUjCVq4CWYu9CoUlpXTlRUhxt3kwpQzsbAP3zRKh2obKq5qzhEnBUcZEvip/B+6kRKZtQ==
X-Received: by 2002:a05:600c:2253:: with SMTP id
 a19mr35808184wmm.136.1593795256067; 
 Fri, 03 Jul 2020 09:54:16 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j15sm5574224wrx.69.2020.07.03.09.54.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 09:54:15 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/34] hw/arm/virt: Let the virtio-iommu bypass MSIs
Date: Fri,  3 Jul 2020 17:53:39 +0100
Message-Id: <20200703165405.17672-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200703165405.17672-1-peter.maydell@linaro.org>
References: <20200703165405.17672-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

From: Eric Auger <eric.auger@redhat.com>

At the moment the virtio-iommu translates MSI transactions.
This behavior is inherited from ARM SMMU. The virt machine
code knows where the guest MSI doorbells are so we can easily
declare those regions as VIRTIO_IOMMU_RESV_MEM_T_MSI. With that
setting the guest will not map MSIs through the IOMMU and those
transactions will be simply bypassed.

Depending on which MSI controller is in use (ITS or GICV2M),
we declare either:
- the ITS interrupt translation space (ITS_base + 0x10000),
  containing the GITS_TRANSLATOR or
- The GICV2M single frame, containing the MSI_SETSP_NS register.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Message-id: 20200629070404.10969-6-eric.auger@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/virt.h |  7 +++++++
 hw/arm/virt.c         | 30 ++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 31878ddc722..a18b6b397b6 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -96,6 +96,12 @@ typedef enum VirtIOMMUType {
     VIRT_IOMMU_VIRTIO,
 } VirtIOMMUType;
 
+typedef enum VirtMSIControllerType {
+    VIRT_MSI_CTRL_NONE,
+    VIRT_MSI_CTRL_GICV2M,
+    VIRT_MSI_CTRL_ITS,
+} VirtMSIControllerType;
+
 typedef enum VirtGICType {
     VIRT_GIC_VERSION_MAX,
     VIRT_GIC_VERSION_HOST,
@@ -136,6 +142,7 @@ typedef struct {
     OnOffAuto acpi;
     VirtGICType gic_version;
     VirtIOMMUType iommu;
+    VirtMSIControllerType msi_controller;
     uint16_t virtio_iommu_bdf;
     struct arm_boot_info bootinfo;
     MemMapEntry *memmap;
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index af3050bc4bd..7922f3c23a5 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -600,6 +600,7 @@ static void create_its(VirtMachineState *vms)
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, vms->memmap[VIRT_GIC_ITS].base);
 
     fdt_add_its_gic_node(vms);
+    vms->msi_controller = VIRT_MSI_CTRL_ITS;
 }
 
 static void create_v2m(VirtMachineState *vms)
@@ -620,6 +621,7 @@ static void create_v2m(VirtMachineState *vms)
     }
 
     fdt_add_v2m_gic_node(vms);
+    vms->msi_controller = VIRT_MSI_CTRL_GICV2M;
 }
 
 static void create_gic(VirtMachineState *vms)
@@ -2198,8 +2200,36 @@ out:
 static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
                                             DeviceState *dev, Error **errp)
 {
+    VirtMachineState *vms = VIRT_MACHINE(hotplug_dev);
+
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
         virt_memory_pre_plug(hotplug_dev, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI)) {
+        hwaddr db_start = 0, db_end = 0;
+        char *resv_prop_str;
+
+        switch (vms->msi_controller) {
+        case VIRT_MSI_CTRL_NONE:
+            return;
+        case VIRT_MSI_CTRL_ITS:
+            /* GITS_TRANSLATER page */
+            db_start = base_memmap[VIRT_GIC_ITS].base + 0x10000;
+            db_end = base_memmap[VIRT_GIC_ITS].base +
+                     base_memmap[VIRT_GIC_ITS].size - 1;
+            break;
+        case VIRT_MSI_CTRL_GICV2M:
+            /* MSI_SETSPI_NS page */
+            db_start = base_memmap[VIRT_GIC_V2M].base;
+            db_end = db_start + base_memmap[VIRT_GIC_V2M].size - 1;
+            break;
+        }
+        resv_prop_str = g_strdup_printf("0x%"PRIx64":0x%"PRIx64":%u",
+                                        db_start, db_end,
+                                        VIRTIO_IOMMU_RESV_MEM_T_MSI);
+
+        qdev_prop_set_uint32(dev, "len-reserved-regions", 1);
+        qdev_prop_set_string(dev, "reserved-regions[0]", resv_prop_str);
+        g_free(resv_prop_str);
     }
 }
 
-- 
2.20.1


