Return-Path: <SRS0=+z+v=72=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833D8C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2020 17:57:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AEEE20789
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2020 17:57:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AEEE20789
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkAPm-00025s-KL
	for qemu-devel@archiver.kernel.org; Sat, 13 Jun 2020 13:57:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41500)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jkAP5-0001ZO-1o; Sat, 13 Jun 2020 13:57:15 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:54340)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jkAP2-0005sH-CE; Sat, 13 Jun 2020 13:57:14 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 34363746331;
 Sat, 13 Jun 2020 19:57:01 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 17BF3746307; Sat, 13 Jun 2020 19:57:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 166EC7456F8;
 Sat, 13 Jun 2020 19:57:01 +0200 (CEST)
Date: Sat, 13 Jun 2020 19:57:01 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Subject: [PATCH v3] mac_oldworld: Add machine ID register
Message-ID: <alpine.BSF.2.22.395.2006131955490.82630@zero.eik.bme.hu>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: David Gibson <david@gibson.dropbear.id.au>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Howard Spoelstra <hsp.cat7@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The G3 beige machine has a machine ID register that is accessed by the
firmware to deternine the board config. Add basic emulation of it.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
v3: add empty write function in case anything tries to write reg

hw/ppc/mac_oldworld.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index 3812adc441..acaf468458 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -80,6 +80,22 @@ static void ppc_heathrow_reset(void *opaque)
     cpu_reset(CPU(cpu));
 }

+static uint64_t machine_id_read(void *opaque, hwaddr addr, unsigned size)
+{
+    return (addr == 0 && size == 2 ? 0x3d8c : 0);
+}
+
+static void machine_id_write(void *opaque, hwaddr addr,
+                             uint64_t val, unsigned size)
+{
+    return;
+}
+
+const MemoryRegionOps machine_id_reg_ops = {
+    .read = machine_id_read,
+    .write = machine_id_write,
+};
+
 static void ppc_heathrow_init(MachineState *machine)
 {
     ram_addr_t ram_size = machine->ram_size;
@@ -93,6 +109,7 @@ static void ppc_heathrow_init(MachineState *machine)
     char *filename;
     int linux_boot, i;
     MemoryRegion *bios = g_new(MemoryRegion, 1);
+    MemoryRegion *machine_id = g_new(MemoryRegion, 1);
     uint32_t kernel_base, initrd_base, cmdline_base = 0;
     int32_t kernel_size, initrd_size;
     PCIBus *pci_bus;
@@ -227,6 +244,10 @@ static void ppc_heathrow_init(MachineState *machine)
         }
     }

+    memory_region_init_io(machine_id, OBJECT(machine), &machine_id_reg_ops,
+                          NULL, "machine_id", 2);
+    memory_region_add_subregion(get_system_memory(), 0xff000004, machine_id);
+
     /* XXX: we register only 1 output pin for heathrow PIC */
     pic_dev = qdev_create(NULL, TYPE_HEATHROW);
     qdev_init_nofail(pic_dev);
-- 
2.21.3



