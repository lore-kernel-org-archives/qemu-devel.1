Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA523C76186
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 17:37:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C8AD2190F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 17:37:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C8AD2190F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpyIN-0001Qf-Qp
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 13:09:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43539)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1hpyBl-00010V-NG
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 13:02:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1hpyBi-0006YL-6a
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 13:02:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51234
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1hpyBY-00064K-68; Tue, 23 Jul 2019 13:02:47 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x6NH23HI077495; Tue, 23 Jul 2019 13:02:14 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2tx60r8nrr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jul 2019 13:02:13 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x6NH2BWa078279;
 Tue, 23 Jul 2019 13:02:11 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com
 [169.55.85.253])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2tx60r8myv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jul 2019 13:02:11 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
 by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x6NH0KRQ029969;
 Tue, 23 Jul 2019 17:01:28 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by ppma01wdc.us.ibm.com with ESMTP id 2tx61mr2et-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jul 2019 17:01:28 +0000
Received: from b03ledav005.gho.boulder.ibm.com
 (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x6NH1RFn51642666
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jul 2019 17:01:27 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 87D33BE05A;
 Tue, 23 Jul 2019 17:01:27 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6B23CBE051;
 Tue, 23 Jul 2019 17:01:27 +0000 (GMT)
Received: from localhost (unknown [9.53.179.212])
 by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
 Tue, 23 Jul 2019 17:01:27 +0000 (GMT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Date: Tue, 23 Jul 2019 12:00:32 -0500
Message-Id: <20190723170104.4327-5-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190723170104.4327-1-mdroth@linux.vnet.ibm.com>
References: <20190723170104.4327-1-mdroth@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-07-23_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=881 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907230170
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: [Qemu-devel] [PATCH 04/36] pcie: set link state inactive/active
 after hot unplug/plug
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
Cc: Wang Haibin <wanghaibin.wang@huawei.com>,
 Zheng Xiang <zhengxiang9@huawei.com>, Zheng Xiang <xiang.zheng@linaro.org>,
 qemu-stable@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Zheng Xiang <zhengxiang9@huawei.com>

When VM boots from the latest version of linux kernel, after
hot-unpluging virtio-blk disks which are hotplugged into
pcie-root-port, the VM's dmesg log shows:

[  151.046242] pciehp 0000:00:05.0:pcie004: pending interrupts 0x0001 from Slot Status
[  151.046365] pciehp 0000:00:05.0:pcie004: Slot(0-3): Attention button pressed
[  151.046369] pciehp 0000:00:05.0:pcie004: Slot(0-3): Powering off due to button press
[  151.046420] pciehp 0000:00:05.0:pcie004: pending interrupts 0x0010 from Slot Status
[  151.046425] pciehp 0000:00:05.0:pcie004: pciehp_green_led_blink: SLOTCTRL a8 write cmd 200
[  151.046464] pciehp 0000:00:05.0:pcie004: pending interrupts 0x0010 from Slot Status
[  151.046468] pciehp 0000:00:05.0:pcie004: pciehp_set_attention_status: SLOTCTRL a8 write cmd c0
[  156.163421] pciehp 0000:00:05.0:pcie004: pciehp_get_power_status: SLOTCTRL a8 value read 2f1
[  156.163427] pciehp 0000:00:05.0:pcie004: pciehp_unconfigure_device: domain:bus:dev = 0000:06:00
[  156.198736] pciehp 0000:00:05.0:pcie004: pending interrupts 0x0010 from Slot Status
[  156.198772] pciehp 0000:00:05.0:pcie004: pciehp_power_off_slot: SLOTCTRL a8 write cmd 400
[  157.224124] pciehp 0000:00:05.0:pcie004: pending interrupts 0x0018 from Slot Status
[  157.224194] pciehp 0000:00:05.0:pcie004: pciehp_green_led_off: SLOTCTRL a8 write cmd 300
[  157.224220] pciehp 0000:00:05.0:pcie004: pciehp_check_link_active: lnk_status = 2011
[  157.224223] pciehp 0000:00:05.0:pcie004: Slot(0-3): Link Up
[  157.224233] pciehp 0000:00:05.0:pcie004: pciehp_get_power_status: SLOTCTRL a8 value read 7f1
[  157.224281] pciehp 0000:00:05.0:pcie004: pending interrupts 0x0010 from Slot Status
[  157.224285] pciehp 0000:00:05.0:pcie004: pciehp_power_on_slot: SLOTCTRL a8 write cmd 0
[  157.224300] pciehp 0000:00:05.0:pcie004: __pciehp_link_set: lnk_ctrl = 0
[  157.224336] pciehp 0000:00:05.0:pcie004: pending interrupts 0x0010 from Slot Status
[  157.224339] pciehp 0000:00:05.0:pcie004: pciehp_green_led_blink: SLOTCTRL a8 write cmd 200
[  159.739294] pci 0000:06:00.0 id reading try 50 times with interval 20 ms to get ffffffff
[  159.739315] pciehp 0000:00:05.0:pcie004: pciehp_check_link_status: lnk_status = 2011
[  159.739318] pciehp 0000:00:05.0:pcie004: Failed to check link status
[  159.739371] pciehp 0000:00:05.0:pcie004: pending interrupts 0x0010 from Slot Status
[  159.739394] pciehp 0000:00:05.0:pcie004: pciehp_power_off_slot: SLOTCTRL a8 write cmd 400
[  160.771426] pciehp 0000:00:05.0:pcie004: pending interrupts 0x0010 from Slot Status
[  160.771452] pciehp 0000:00:05.0:pcie004: pciehp_green_led_off: SLOTCTRL a8 write cmd 300
[  160.771495] pciehp 0000:00:05.0:pcie004: pending interrupts 0x0010 from Slot Status
[  160.771499] pciehp 0000:00:05.0:pcie004: pciehp_set_attention_status: SLOTCTRL a8 write cmd 40
[  160.771535] pciehp 0000:00:05.0:pcie004: pending interrupts 0x0010 from Slot Status
[  160.771539] pciehp 0000:00:05.0:pcie004: pciehp_green_led_off: SLOTCTRL a8 write cmd 300

After analyzing the log information, it seems that qemu doesn't
change the Link Status from active to inactive after hot-unplug.
This results in the abnormal log after the linux kernel commit
d331710ea78fea merged.

Furthermore, If I hotplug the same virtio-blk disk after hot-unplug,
the virtio-blk would turn on and then back off.

So this patch set the Link Status inactive after hot-unplug and
active after hot-plug.

Signed-off-by: Zheng Xiang <zhengxiang9@huawei.com>
Signed-off-by: Zheng Xiang <xiang.zheng@linaro.org>
Cc: Wang Haibin <wanghaibin.wang@huawei.com>
Cc: qemu-stable@nongnu.org
Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit 2f2b18f60bf17453b4c01197a9316615a3c1f1de)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/pci/pcie.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 6c91bd44a0..66b73b87c8 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -345,6 +345,10 @@ void pcie_cap_slot_hotplug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
     if (!dev->hotplugged) {
         pci_word_test_and_set_mask(exp_cap + PCI_EXP_SLTSTA,
                                    PCI_EXP_SLTSTA_PDS);
+        if (pci_dev->cap_present & QEMU_PCIE_LNKSTA_DLLLA) {
+            pci_word_test_and_set_mask(exp_cap + PCI_EXP_LNKSTA,
+                                       PCI_EXP_LNKSTA_DLLLA);
+        }
         return;
     }
 
@@ -355,6 +359,10 @@ void pcie_cap_slot_hotplug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
     if (pci_get_function_0(pci_dev)) {
         pci_word_test_and_set_mask(exp_cap + PCI_EXP_SLTSTA,
                                    PCI_EXP_SLTSTA_PDS);
+        if (pci_dev->cap_present & QEMU_PCIE_LNKSTA_DLLLA) {
+            pci_word_test_and_set_mask(exp_cap + PCI_EXP_LNKSTA,
+                                       PCI_EXP_LNKSTA_DLLLA);
+        }
         pcie_cap_slot_event(PCI_DEVICE(hotplug_dev),
                             PCI_EXP_HP_EV_PDC | PCI_EXP_HP_EV_ABP);
     }
@@ -531,6 +539,10 @@ void pcie_cap_slot_write_config(PCIDevice *dev,
 
         pci_word_test_and_clear_mask(exp_cap + PCI_EXP_SLTSTA,
                                      PCI_EXP_SLTSTA_PDS);
+        if (dev->cap_present & QEMU_PCIE_LNKSTA_DLLLA) {
+            pci_word_test_and_clear_mask(exp_cap + PCI_EXP_LNKSTA,
+                                         PCI_EXP_LNKSTA_DLLLA);
+        }
         pci_word_test_and_set_mask(exp_cap + PCI_EXP_SLTSTA,
                                        PCI_EXP_SLTSTA_PDC);
     }
-- 
2.17.1


