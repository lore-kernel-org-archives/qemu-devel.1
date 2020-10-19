Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19BCEC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 11:08:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DA7121741
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 11:08:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DA7121741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUpVa-00036d-5q
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 07:08:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49462)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ganqixin@huawei.com>)
 id 1kUpRH-0006xf-Qd; Tue, 20 Oct 2020 07:04:23 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:45562 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ganqixin@huawei.com>)
 id 1kUpRE-0006sl-Cb; Tue, 20 Oct 2020 07:04:23 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 990A0A079AE851536F90;
 Tue, 20 Oct 2020 19:04:15 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Tue, 20 Oct 2020
 19:03:49 +0800
From: Gan Qixin <ganqixin@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-trivial@nongnu.org>
Subject: [PATCH 09/10] hw/input/:split some lines containing more than 80
 characters
Date: Tue, 20 Oct 2020 04:30:22 +0800
Message-ID: <20201019203023.658555-10-ganqixin@huawei.com>
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

By using scripts/checkpatch.pl, it is found that many files in hw/input/
contain lines with more than 80 characters.

Signed-off-by: Gan Qixin <ganqixin@huawei.com>
---
 hw/input/hid.c               |  3 ++-
 hw/input/milkymist-softusb.c | 16 ++++++++++------
 hw/input/pxa2xx_keypad.c     |  3 ++-
 hw/input/virtio-input.c      |  3 ++-
 4 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/hw/input/hid.c b/hw/input/hid.c
index 89239b5634..f3074e3b07 100644
--- a/hw/input/hid.c
+++ b/hw/input/hid.c
@@ -100,7 +100,8 @@ void hid_set_next_idle(HIDState *hs)
         uint64_t expire_time = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
                                NANOSECONDS_PER_SECOND * hs->idle * 4 / 1000;
         if (!hs->idle_timer) {
-            hs->idle_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, hid_idle_timer, hs);
+            hs->idle_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, hid_idle_timer,
+                                          hs);
         }
         timer_mod_ns(hs->idle_timer, expire_time);
     } else {
diff --git a/hw/input/milkymist-softusb.c b/hw/input/milkymist-softusb.c
index 5acd7a6f7d..7f7a87be28 100644
--- a/hw/input/milkymist-softusb.c
+++ b/hw/input/milkymist-softusb.c
@@ -259,13 +259,15 @@ static void milkymist_softusb_realize(DeviceState *dev, Error **errp)
     sysbus_init_mmio(sbd, &s->regs_region);
 
     /* register pmem and dmem */
-    memory_region_init_ram_nomigrate(&s->pmem, OBJECT(s), "milkymist-softusb.pmem",
-                           s->pmem_size, &error_fatal);
+    memory_region_init_ram_nomigrate(&s->pmem, OBJECT(s),
+                                     "milkymist-softusb.pmem", s->pmem_size,
+                                     &error_fatal);
     vmstate_register_ram_global(&s->pmem);
     s->pmem_ptr = memory_region_get_ram_ptr(&s->pmem);
     sysbus_init_mmio(sbd, &s->pmem);
-    memory_region_init_ram_nomigrate(&s->dmem, OBJECT(s), "milkymist-softusb.dmem",
-                           s->dmem_size, &error_fatal);
+    memory_region_init_ram_nomigrate(&s->dmem, OBJECT(s),
+                                     "milkymist-softusb.dmem", s->dmem_size,
+                                     &error_fatal);
     vmstate_register_ram_global(&s->dmem);
     s->dmem_ptr = memory_region_get_ram_ptr(&s->dmem);
     sysbus_init_mmio(sbd, &s->dmem);
@@ -289,8 +291,10 @@ static const VMStateDescription vmstate_milkymist_softusb = {
 };
 
 static Property milkymist_softusb_properties[] = {
-    DEFINE_PROP_UINT32("pmem_size", MilkymistSoftUsbState, pmem_size, 0x00001000),
-    DEFINE_PROP_UINT32("dmem_size", MilkymistSoftUsbState, dmem_size, 0x00002000),
+    DEFINE_PROP_UINT32("pmem_size", MilkymistSoftUsbState,
+                       pmem_size, 0x00001000),
+    DEFINE_PROP_UINT32("dmem_size", MilkymistSoftUsbState,
+                       dmem_size, 0x00002000),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/input/pxa2xx_keypad.c b/hw/input/pxa2xx_keypad.c
index 7f2f739fb3..7999fc2430 100644
--- a/hw/input/pxa2xx_keypad.c
+++ b/hw/input/pxa2xx_keypad.c
@@ -101,7 +101,8 @@ struct PXA2xxKeyPadState {
     uint32_t    kpkdi;
 };
 
-static void pxa27x_keypad_find_pressed_key(PXA2xxKeyPadState *kp, int *row, int *col)
+static void pxa27x_keypad_find_pressed_key(PXA2xxKeyPadState *kp, int *row,
+                                           int *col)
 {
     int i;
     for (i = 0; i < 4; i++)
diff --git a/hw/input/virtio-input.c b/hw/input/virtio-input.c
index 54bcb46c74..c7fa659e92 100644
--- a/hw/input/virtio-input.c
+++ b/hw/input/virtio-input.c
@@ -61,7 +61,8 @@ void virtio_input_send(VirtIOInput *vinput, virtio_input_event *event)
     for (i = 0; i < vinput->qindex; i++) {
         elem = vinput->queue[i].elem;
         len = iov_from_buf(elem->in_sg, elem->in_num,
-                           0, &vinput->queue[i].event, sizeof(virtio_input_event));
+                           0, &vinput->queue[i].event,
+                           sizeof(virtio_input_event));
         virtqueue_push(vinput->evt, elem, len);
         g_free(elem);
     }
-- 
2.23.0


