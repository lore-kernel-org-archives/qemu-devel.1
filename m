Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F51C3A5A7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 09:10:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1724F21670
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 09:10:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1724F21670
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5RId-00028y-8y
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 05:09:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38661)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1i5R7C-0007WW-Ah
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 04:58:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1i5R7B-0007Hc-28
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 04:58:10 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2261 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1i5R78-0007Fw-0n; Wed, 04 Sep 2019 04:58:06 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 1D9BD3FCE8CBABA5053F;
 Wed,  4 Sep 2019 16:58:04 +0800 (CST)
Received: from S00345302A-PC.china.huawei.com (10.202.227.237) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.439.0; Wed, 4 Sep 2019 16:57:56 +0800
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <eric.auger@redhat.com>,
 <imammedo@redhat.com>
Date: Wed, 4 Sep 2019 09:56:27 +0100
Message-ID: <20190904085629.13872-10-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20190904085629.13872-1-shameerali.kolothum.thodi@huawei.com>
References: <20190904085629.13872-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.227.237]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.191
Subject: [Qemu-devel] [PATCH-for-4.2 v10 09/11] docs/specs: Add ACPI GED
 documentation
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
Cc: peter.maydell@linaro.org, sameo@linux.intel.com, ard.biesheuvel@linaro.org,
 linuxarm@huawei.com, xuwei5@hisilicon.com, shannon.zhaosl@gmail.com,
 sebastien.boeuf@intel.com, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Documents basic concepts of ACPI Generic Event device(GED)
and interface between QEMU and the ACPI BIOS.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
---
 docs/specs/acpi_hw_reduced_hotplug.txt | 60 ++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 docs/specs/acpi_hw_reduced_hotplug.txt

diff --git a/docs/specs/acpi_hw_reduced_hotplug.txt b/docs/specs/acpi_hw_reduced_hotplug.txt
new file mode 100644
index 0000000000..2d78c40d6a
--- /dev/null
+++ b/docs/specs/acpi_hw_reduced_hotplug.txt
@@ -0,0 +1,60 @@
+QEMU<->ACPI BIOS Generic Event Device interface
+
+The ACPI Generic Event Device (GED) is a HW reduced platform
+specific device introduced in ACPI v6.1 that handles all platform
+events, including the hotplug ones. GED is modelled as a device
+in the namespace with a _HID defined to be ACPI0013. This document
+describes the interface between QEMU and the ACPI BIOS.
+
+GED allows HW reduced platforms to handle interrupts in ACPI ASL
+statements. It follows a very similar approach like the _EVT method
+from GPIO events. All interrupts are listed in  _CRS and the handler
+is written in _EVT method. However, Qemu implementation uses a single
+interrupt for the GED device, relying on IO memory region to communicate
+the type of device affected by the interrupt. This way, we can support
+up to 32 events with a unique interrupt.
+
+Here is an example.
+
+Device (\_SB.GED)
+{
+    Name (_HID, "ACPI0013")
+    Name (_UID, Zero)
+    Name (_CRS, ResourceTemplate ()
+    {
+        Interrupt (ResourceConsumer, Edge, ActiveHigh, Exclusive, ,, )
+        {
+            0x00000029,
+        }
+    })
+    OperationRegion (EREG, SystemMemory, 0x09080000, 0x04)
+    Field (EREG, DWordAcc, NoLock, WriteAsZeros)
+    {
+        ESEL,   32
+    }
+    Method (_EVT, 1, Serialized)
+    {
+        Local0 = ESEL // ESEL = IO memory region which specifies the
+                      // device type.
+        If (((Local0 & One) == One))
+        {
+            MethodEvent1()
+        }
+        If ((Local0 & 0x2) == 0x2)
+        {
+            MethodEvent2()
+        }
+        ...
+    }
+}
+
+GED IO interface (4 byte access):
+read access:
+    [0x0-0x3] Event selector bit field(32 bit) set by Qemu.
+    bits:
+        0:  Memory hotplug event
+        1:  System power down event
+     2-31:  Reserved
+
+write_access:
+    Nothing is expected to be written into GED IO memory
-- 
2.17.1



