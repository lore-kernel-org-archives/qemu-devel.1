Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AFF4C606C7
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 19:11:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17D21216FD
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 19:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDbeBTfe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17D21216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkZ32-00018K-F3
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 15:11:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60738)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <marcel.apfelbaum@gmail.com>) id 1hkZ28-0000jZ-1k
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 15:10:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcel.apfelbaum@gmail.com>) id 1hkZ26-0005db-Un
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 15:10:39 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:54988)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
 id 1hkZ26-0005dG-MI
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 15:10:38 -0400
Received: by mail-wm1-x342.google.com with SMTP id p74so595560wme.4
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2019 12:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=BUG3HHgfp9mEv1rHSH3XaWu+sqpOJ8uU5ix3qYXxYT0=;
 b=cDbeBTfewFbMB2pW7cLpwF00SJCcgwEpN8wKebKq27z4OTkq7o7yLafgiZIafLL6Hr
 HQEWDWKyvqRT5naKapCt4m+dz5y4NXZ8m1svFFI92rOrImbmIk8dxIUlmBsBqAuyiZI9
 zWovpB3nIQHhggoMKajJ6nnJpabFj0S4bW7nzIhxHnwjrnzcCNqc+ls/xXL5bcwRh2QB
 sBkGLZMF/97K+6ZkJEOxs9s4onlFRSsJOITpM1m3mHepJQLvlZvzuBzsFalrvBIn26st
 AxyUK95O1cDmuihLXyjSoW9zz3k/GZk4a0IETE85iLaqc/6+AL1RwyqCKz1RbSKY6VB+
 Ozng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=BUG3HHgfp9mEv1rHSH3XaWu+sqpOJ8uU5ix3qYXxYT0=;
 b=P1OWQrPIfJNNfEG/Aw16T4C4ihVd2GpLSvlQDyJ8QMsJOaYr7riUPmfpNcqstA+sWC
 y8Ec3vUFzc6p3AGOjBwE7NZy/tmNpfdVfP+jOAZW61NlOzaAXRQzSursXKaN++oQ6PVL
 DZ6TKnBUiysJGxyUpMthvIdAHRn4AXK61Ndh993nHFabvi67BBjxNeF7HutSq2iz6uVC
 pnJnXs9KWCw3yB5qj50XppQ9+A0XLTybVbfLYBd7GZCwF1DUVs+Tua/wyhzrpRHb/AaA
 QbiH6jzs422Gw/pfYwd+68Hqqnk5oehKJfKnx5V1Fg6gJxrOmMFOcGOWGtg03u6KUQ61
 ShCg==
X-Gm-Message-State: APjAAAVWNM8dsDAnCsAKN0i9a4tXDMREzQdxaX8oFdvYjL62TdcXWISQ
 Q6HW8OD3Mb/aClPmq56WO/+KRqj9
X-Google-Smtp-Source: APXvYqyKk12FQqwGDP9D/iSwGsSn6yaFqNecOd7HYfIddjLSh9UrSs3Hsh3kBZ0om1aj8Fwm+aAcPA==
X-Received: by 2002:a7b:cc0c:: with SMTP id f12mr17745831wmh.100.1562613037105; 
 Mon, 08 Jul 2019 12:10:37 -0700 (PDT)
Received: from localhost.localdomain ([37.142.144.12])
 by smtp.gmail.com with ESMTPSA id c78sm444304wmd.16.2019.07.08.12.10.35
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 08 Jul 2019 12:10:36 -0700 (PDT)
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
To: qemu-devel@nongnu.org,
	dmitry.fleytman@gmail.com,
	dgilbert@redhat.com
Date: Mon,  8 Jul 2019 22:09:30 +0300
Message-Id: <20190708190930.16642-1-marcel.apfelbaum@gmail.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel]  [PATCH V2] hw/net: fix vmxnet3 live migration
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
Cc: skrtbhtngr@gmail.com, yuval.shaia@oracle.com
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
Tested-by: Sukrit Bhatnagar <skrtbhtngr@gmail.com>
Reviewed-by: Dmitry Fleytman <dmitry.fleytman@gmail.com>
---

V1 -> V2:
  - Bump migration version (Dave)

 hw/net/vmxnet3.c | 56 ++++--------------------------------------------
 1 file changed, 4 insertions(+), 52 deletions(-)

diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
index 10d01d0058..eec364f604 100644
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
@@ -2440,39 +2417,15 @@ static const VMStateDescription vmstate_vmxnet3_int_state = {
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
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
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


