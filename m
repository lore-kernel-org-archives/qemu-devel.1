Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E8EC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 11:11:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8522421741
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 11:11:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8522421741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUpXp-0006ez-HC
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 07:11:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49464)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ganqixin@huawei.com>)
 id 1kUpRJ-00071K-5L; Tue, 20 Oct 2020 07:04:25 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:45564 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ganqixin@huawei.com>)
 id 1kUpRE-0006sk-Fp; Tue, 20 Oct 2020 07:04:24 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id A031EA5BB60AC3ECDB7A;
 Tue, 20 Oct 2020 19:04:15 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Tue, 20 Oct 2020
 19:03:50 +0800
From: Gan Qixin <ganqixin@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-trivial@nongnu.org>
Subject: [PATCH 10/10] hw/riscv/:split some lines containing more than 80
 characters
Date: Tue, 20 Oct 2020 04:30:23 +0800
Message-ID: <20201019203023.658555-11-ganqixin@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20201019203023.658555-1-ganqixin@huawei.com>
References: <20201019203023.658555-1-ganqixin@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.32; envelope-from=ganqixin@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 07:04:17
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: lvivier@redhat.com, peter.maydell@linaro.org,
 zhang.zhanghailiang@huawei.com, mst@redhat.com, f4bug@amsat.org,
 alistair.francis@wdc.com, Gan Qixin <ganqixin@huawei.com>,
 kuhn.chenqun@huawei.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

By using scripts/checkpatch.pl, it is found that many files in hw/riscv/
contain lines with more than 80 characters.

Signed-off-by: Gan Qixin <ganqixin@huawei.com>
---
 hw/riscv/opentitan.c |  6 ++++--
 hw/riscv/sifive_e.c  |  6 ++++--
 hw/riscv/sifive_u.c  | 12 ++++++++----
 3 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/hw/riscv/opentitan.c b/hw/riscv/opentitan.c
index 0531bd879b..f587d5993e 100644
--- a/hw/riscv/opentitan.c
+++ b/hw/riscv/opentitan.c
@@ -121,7 +121,8 @@ static void lowrisc_ibex_soc_realize(DeviceState *dev_soc, Error **errp)
         memmap[IBEX_DEV_ROM].base, &s->rom);
 
     /* Flash memory */
-    memory_region_init_rom(&s->flash_mem, OBJECT(dev_soc), "riscv.lowrisc.ibex.flash",
+    memory_region_init_rom(&s->flash_mem, OBJECT(dev_soc),
+                           "riscv.lowrisc.ibex.flash",
                            memmap[IBEX_DEV_FLASH].size, &error_fatal);
     memory_region_add_subregion(sys_mem, memmap[IBEX_DEV_FLASH].base,
                                 &s->flash_mem);
@@ -172,7 +173,8 @@ static void lowrisc_ibex_soc_realize(DeviceState *dev_soc, Error **errp)
     create_unimplemented_device("riscv.lowrisc.ibex.pinmux",
         memmap[IBEX_DEV_PINMUX].base, memmap[IBEX_DEV_PINMUX].size);
     create_unimplemented_device("riscv.lowrisc.ibex.alert_handler",
-        memmap[IBEX_DEV_ALERT_HANDLER].base, memmap[IBEX_DEV_ALERT_HANDLER].size);
+        memmap[IBEX_DEV_ALERT_HANDLER].base,
+        memmap[IBEX_DEV_ALERT_HANDLER].size);
     create_unimplemented_device("riscv.lowrisc.ibex.nmi_gen",
         memmap[IBEX_DEV_NMI_GEN].base, memmap[IBEX_DEV_NMI_GEN].size);
     create_unimplemented_device("riscv.lowrisc.ibex.usbdev",
diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index fcfac16816..80ef2f857e 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -111,7 +111,8 @@ static void sifive_e_machine_init(MachineState *machine)
         reset_vec[i] = cpu_to_le32(reset_vec[i]);
     }
     rom_add_blob_fixed_as("mrom.reset", reset_vec, sizeof(reset_vec),
-                          memmap[SIFIVE_E_DEV_MROM].base, &address_space_memory);
+                          memmap[SIFIVE_E_DEV_MROM].base,
+                          &address_space_memory);
 
     if (machine->kernel_filename) {
         riscv_load_kernel(machine->kernel_filename, NULL);
@@ -227,7 +228,8 @@ static void sifive_e_soc_realize(DeviceState *dev, Error **errp)
     }
 
     /* Map GPIO registers */
-    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpio), 0, memmap[SIFIVE_E_DEV_GPIO0].base);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpio), 0,
+                    memmap[SIFIVE_E_DEV_GPIO0].base);
 
     /* Pass all GPIOs to the SOC layer so they are available to the board */
     qdev_pass_gpios(DEVICE(&s->gpio), dev, NULL);
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 6ad975d692..2c06d1a319 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -528,7 +528,8 @@ static void sifive_u_machine_init(MachineState *machine)
         reset_vec[i] = cpu_to_le32(reset_vec[i]);
     }
     rom_add_blob_fixed_as("mrom.reset", reset_vec, sizeof(reset_vec),
-                          memmap[SIFIVE_U_DEV_MROM].base, &address_space_memory);
+                          memmap[SIFIVE_U_DEV_MROM].base,
+                          &address_space_memory);
 
     riscv_rom_copy_firmware_info(memmap[SIFIVE_U_DEV_MROM].base,
                                  memmap[SIFIVE_U_DEV_MROM].size,
@@ -542,7 +543,8 @@ static bool sifive_u_machine_get_start_in_flash(Object *obj, Error **errp)
     return s->start_in_flash;
 }
 
-static void sifive_u_machine_set_start_in_flash(Object *obj, bool value, Error **errp)
+static void sifive_u_machine_set_start_in_flash(Object *obj, bool value,
+                                                Error **errp)
 {
     SiFiveUState *s = RISCV_U_MACHINE(obj);
 
@@ -731,13 +733,15 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->prci), errp)) {
         return;
     }
-    sysbus_mmio_map(SYS_BUS_DEVICE(&s->prci), 0, memmap[SIFIVE_U_DEV_PRCI].base);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->prci), 0,
+                    memmap[SIFIVE_U_DEV_PRCI].base);
 
     qdev_prop_set_uint32(DEVICE(&s->gpio), "ngpio", 16);
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio), errp)) {
         return;
     }
-    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpio), 0, memmap[SIFIVE_U_DEV_GPIO].base);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpio), 0,
+                    memmap[SIFIVE_U_DEV_GPIO].base);
 
     /* Pass all GPIOs to the SOC layer so they are available to the board */
     qdev_pass_gpios(DEVICE(&s->gpio), dev, NULL);
-- 
2.23.0


