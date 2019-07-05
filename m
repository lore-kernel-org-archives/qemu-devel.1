Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC58C0650E
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 01:09:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F52821850
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 01:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZqwrMzqT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F52821850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjCip-0002cH-77
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 21:09:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44301)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <marcel.apfelbaum@gmail.com>) id 1hjCi9-000209-Uf
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 21:08:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcel.apfelbaum@gmail.com>) id 1hjCi4-0005IP-V1
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 21:08:25 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42831)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
 id 1hjCi4-0005He-M4
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 21:08:20 -0400
Received: by mail-wr1-x444.google.com with SMTP id a10so7068311wrp.9
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2019 18:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=7VWaydvmEr5vgsNAU9NcQFy/TVwhpNurHQ4Uy2fRjOg=;
 b=ZqwrMzqTO059NRoLV93lNIU/sr9BTMnR4LvBLIFgPhyfsbNrGahI5u0mPolA3BsOrS
 5gncaqvF16YZwSCBPDpmD3OpBy0RZnybFBsyeXJpE5UJqN85Qb/FdcqSOYn17eXArbaR
 PS3GfhBNsO853wO+czzG5lBca+rCWtD/WqDdudrBt2LaWMrX/TLWWVCOqXJUcUDu/HMt
 MbmbwRFnX8af+eF3nIdvn2kF2/p2skOCbBQmXruhQ2wKA/PYhz64Mtht0VX1ap60YO15
 jcTwpornJNIBA01K5s5g4xZB8n9/UaU9QMOIs8dX31krrGtgIg/oTK3htIekCDYBnQr+
 AhDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=7VWaydvmEr5vgsNAU9NcQFy/TVwhpNurHQ4Uy2fRjOg=;
 b=s8dcCbNtsOnjPvDuNJyihTuUNcQq2D7uuzxlOQ9213O0eU96kYugfSL2EJ0IhDtQmJ
 xG1oOd3JF9WWF5jV/SpOCBfRZ2edsBoCPD6IpBI6eTnkrk3eJh6ARUbXjF1IAcyvNvc/
 bjT4EqrasdIBxC1oa+C8qy/wosgywxaZbmRGYLG9wwRcOr+ySd/Lj6YbOdFIhZLEszc0
 MtJPAV7sjjFCtdLVPRhWNXxwzjVsfrWa/QWxiIQbu/1+2AnHkbx8d7D7VmOs1KZG80+j
 ceP9pEUA1JjxlAuOsufqdIdPmI6BSUpXdDWdasmX5N9yOPa+iRwZQ19w4AkEoENyhRHY
 xkkg==
X-Gm-Message-State: APjAAAV96keGMKRRporWwRipElBhv8jlc4j34wjYoUI9Jb7iKeHf8aUt
 8dAqmWG7wbrqlbpPbTB6fauqDvTU
X-Google-Smtp-Source: APXvYqzyH/vq6ZgD3LZOp8e1s6dqWatWR30aX+9ej1l9j4OA49v4i0AZ8ha0Bdq/Qmfj3K5qxDAzMQ==
X-Received: by 2002:adf:ef8d:: with SMTP id d13mr739717wro.60.1562288898908;
 Thu, 04 Jul 2019 18:08:18 -0700 (PDT)
Received: from localhost.localdomain ([37.142.144.12])
 by smtp.gmail.com with ESMTPSA id z2sm6375742wrt.41.2019.07.04.18.08.17
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 04 Jul 2019 18:08:18 -0700 (PDT)
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
To: qemu-devel@nongnu.org,
	dmitry.fleytman@gmail.com
Date: Fri,  5 Jul 2019 04:07:11 +0300
Message-Id: <20190705010711.23277-1-marcel.apfelbaum@gmail.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel]  [PATCH] hw/net: fix vmxnet3 live migration
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
Cc: skrtbhtngr@gmail.com, dgilbert@redhat.com, yuval.shaia@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

At some point vmxnet3 live migration stopped working and git-bisect
didn't help finding a working version.
The issue is the PCI configuration space is not being migrated
successfully and MSIX remains masked at destination.

Remove the migration differentiation between PCI and PCIe since
the logic resides now inside VMSTATE_PCI_DEVICE.
Remove also the VMXNET3_COMPAT_FLAG_DISABLE_PCIE based differentiation
since at 'realize' time is decided if the device is PCI or PCIe,
then the above macro is enough.

Use the opportunity to move to the standard VMSTATE_MSIX
instead of the deprecated SaveVMHandlers.

Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
---
 hw/net/vmxnet3.c | 52 ++----------------------------------------------
 1 file changed, 2 insertions(+), 50 deletions(-)

diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
index 10d01d0058..8b17548b02 100644
--- a/hw/net/vmxnet3.c
+++ b/hw/net/vmxnet3.c
@@ -2141,21 +2141,6 @@ vmxnet3_cleanup_msi(VMXNET3State *s)
     msi_uninit(d);
 }
 
-static void
-vmxnet3_msix_save(QEMUFile *f, void *opaque)
-{
-    PCIDevice *d = PCI_DEVICE(opaque);
-    msix_save(d, f);
-}
-
-static int
-vmxnet3_msix_load(QEMUFile *f, void *opaque, int version_id)
-{
-    PCIDevice *d = PCI_DEVICE(opaque);
-    msix_load(d, f);
-    return 0;
-}
-
 static const MemoryRegionOps b0_ops = {
     .read = vmxnet3_io_bar0_read,
     .write = vmxnet3_io_bar0_write,
@@ -2176,11 +2161,6 @@ static const MemoryRegionOps b1_ops = {
     },
 };
 
-static SaveVMHandlers savevm_vmxnet3_msix = {
-    .save_state = vmxnet3_msix_save,
-    .load_state = vmxnet3_msix_load,
-};
-
 static uint64_t vmxnet3_device_serial_num(VMXNET3State *s)
 {
     uint64_t dsn_payload;
@@ -2203,7 +2183,6 @@ static uint64_t vmxnet3_device_serial_num(VMXNET3State *s)
 
 static void vmxnet3_pci_realize(PCIDevice *pci_dev, Error **errp)
 {
-    DeviceState *dev = DEVICE(pci_dev);
     VMXNET3State *s = VMXNET3(pci_dev);
     int ret;
 
@@ -2249,8 +2228,6 @@ static void vmxnet3_pci_realize(PCIDevice *pci_dev, Error **errp)
         pcie_dev_ser_num_init(pci_dev, VMXNET3_DSN_OFFSET,
                               vmxnet3_device_serial_num(s));
     }
-
-    register_savevm_live(dev, "vmxnet3-msix", -1, 1, &savevm_vmxnet3_msix, s);
 }
 
 static void vmxnet3_instance_init(Object *obj)
@@ -2440,29 +2417,6 @@ static const VMStateDescription vmstate_vmxnet3_int_state = {
     }
 };
 
-static bool vmxnet3_vmstate_need_pcie_device(void *opaque)
-{
-    VMXNET3State *s = VMXNET3(opaque);
-
-    return !(s->compat_flags & VMXNET3_COMPAT_FLAG_DISABLE_PCIE);
-}
-
-static bool vmxnet3_vmstate_test_pci_device(void *opaque, int version_id)
-{
-    return !vmxnet3_vmstate_need_pcie_device(opaque);
-}
-
-static const VMStateDescription vmstate_vmxnet3_pcie_device = {
-    .name = "vmxnet3/pcie",
-    .version_id = 1,
-    .minimum_version_id = 1,
-    .needed = vmxnet3_vmstate_need_pcie_device,
-    .fields = (VMStateField[]) {
-        VMSTATE_PCI_DEVICE(parent_obj, VMXNET3State),
-        VMSTATE_END_OF_LIST()
-    }
-};
-
 static const VMStateDescription vmstate_vmxnet3 = {
     .name = "vmxnet3",
     .version_id = 1,
@@ -2470,9 +2424,8 @@ static const VMStateDescription vmstate_vmxnet3 = {
     .pre_save = vmxnet3_pre_save,
     .post_load = vmxnet3_post_load,
     .fields = (VMStateField[]) {
-            VMSTATE_STRUCT_TEST(parent_obj, VMXNET3State,
-                                vmxnet3_vmstate_test_pci_device, 0,
-                                vmstate_pci_device, PCIDevice),
+            VMSTATE_PCI_DEVICE(parent_obj, VMXNET3State),
+            VMSTATE_MSIX(parent_obj, VMXNET3State),
             VMSTATE_BOOL(rx_packets_compound, VMXNET3State),
             VMSTATE_BOOL(rx_vlan_stripping, VMXNET3State),
             VMSTATE_BOOL(lro_supported, VMXNET3State),
@@ -2508,7 +2461,6 @@ static const VMStateDescription vmstate_vmxnet3 = {
     },
     .subsections = (const VMStateDescription*[]) {
         &vmxstate_vmxnet3_mcast_list,
-        &vmstate_vmxnet3_pcie_device,
         NULL
     }
 };
-- 
2.17.1


