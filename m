Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CAE8ECE58C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 18:11:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4445B20679
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 18:11:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4445B20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIGR6-0007ke-WD
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 14:11:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46322)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iIBvs-0002nT-SI
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 09:23:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iIBvr-0001LV-KX
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 09:23:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48242)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iIBvr-0001LQ-Cu
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 09:23:11 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A1E6E10C094D;
 Wed,  9 Oct 2019 13:23:10 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 02CF35C1D6;
 Wed,  9 Oct 2019 13:23:08 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC 3/3] acpi: cpuhp: add CPHP_GET_CPU_ID_CMD command
Date: Wed,  9 Oct 2019 09:22:52 -0400
Message-Id: <20191009132252.17860-4-imammedo@redhat.com>
In-Reply-To: <20191009132252.17860-1-imammedo@redhat.com>
References: <20191009132252.17860-1-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Wed, 09 Oct 2019 13:23:10 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Extend CPU hotplug interface to return architecture specific
identifier for current CPU (in case of x86, it's APIC ID).

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
TODO:
  * cripple it to behave old way on old machine types so that
    new firmware started on new QEMU won't see a difference
    when migrated to an old QEMU (i.e. QEMU that doesn't support
    this command)
---
 docs/specs/acpi_cpu_hotplug.txt | 10 +++++++++-
 hw/acpi/cpu.c                   | 15 +++++++++++++++
 hw/acpi/trace-events            |  1 +
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/docs/specs/acpi_cpu_hotplug.txt b/docs/specs/acpi_cpu_hotplug.txt
index 43c5a193f0..0438678249 100644
--- a/docs/specs/acpi_cpu_hotplug.txt
+++ b/docs/specs/acpi_cpu_hotplug.txt
@@ -32,7 +32,9 @@ Register block size:
 
 read access:
     offset:
-    [0x0-0x3] reserved
+    [0x0-0x3] Command data 2: (DWORD access)
+              upper 32 bit of 'Command data' if returned data value is 64 bit.
+              in case of error or unsupported command reads is 0x0
     [0x4] CPU device status fields: (1 byte access)
         bits:
            0: Device is enabled and may be used by guest
@@ -87,6 +89,8 @@ write access:
               2: stores value into OST status register, triggers
                  ACPI_DEVICE_OST QMP event from QEMU to external applications
                  with current values of OST event and status registers.
+              3: OSPM reads architecture specific value identifying CPU
+                 (x86: APIC ID)
             other values: reserved
 
 Selecting CPU device beyond possible range has no effect on platform:
@@ -115,3 +119,7 @@ Typical usecases:
      5.2 if 'Command data' register has not changed, there is not CPU
          corresponding to iterator value and the last valid iterator value
          equals to 'max_cpus' + 1
+   - Get architecture specific id for a CPU
+     1. pick a CPU to read from using 'CPU selector' register
+     2. write 0x3 int0 'Command field' register
+     3. read architecture specific id from 'Command data' register
diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
index 87f30a31d7..701542d860 100644
--- a/hw/acpi/cpu.c
+++ b/hw/acpi/cpu.c
@@ -12,11 +12,13 @@
 #define ACPI_CPU_FLAGS_OFFSET_RW 4
 #define ACPI_CPU_CMD_OFFSET_WR 5
 #define ACPI_CPU_CMD_DATA_OFFSET_RW 8
+#define ACPI_CPU_CMD_DATA2_OFFSET_RW 0
 
 enum {
     CPHP_GET_NEXT_CPU_WITH_EVENT_CMD = 0,
     CPHP_OST_EVENT_CMD = 1,
     CPHP_OST_STATUS_CMD = 2,
+    CPHP_GET_CPU_ID_CMD = 3,
     CPHP_CMD_MAX
 };
 
@@ -74,11 +76,24 @@ static uint64_t cpu_hotplug_rd(void *opaque, hwaddr addr, unsigned size)
         case CPHP_GET_NEXT_CPU_WITH_EVENT_CMD:
            val = cpu_st->selector;
            break;
+        case CPHP_GET_CPU_ID_CMD:
+           val = cpu_to_le64(cdev->arch_id) & 0xFFFFFFFF;
+           break;
         default:
            break;
         }
         trace_cpuhp_acpi_read_cmd_data(cpu_st->selector, val);
         break;
+    case ACPI_CPU_CMD_DATA2_OFFSET_RW:
+        switch (cpu_st->command) {
+        case CPHP_GET_CPU_ID_CMD:
+           val = cpu_to_le64(cdev->arch_id) >> 32;
+           break;
+        default:
+           break;
+        }
+        trace_cpuhp_acpi_read_cmd_data2(cpu_st->selector, val);
+        break;
     default:
         break;
     }
diff --git a/hw/acpi/trace-events b/hw/acpi/trace-events
index 96b8273297..afbc77de1c 100644
--- a/hw/acpi/trace-events
+++ b/hw/acpi/trace-events
@@ -23,6 +23,7 @@ cpuhp_acpi_read_flags(uint32_t idx, uint8_t flags) "idx[0x%"PRIx32"] flags: 0x%"
 cpuhp_acpi_write_idx(uint32_t idx) "set active cpu idx: 0x%"PRIx32
 cpuhp_acpi_write_cmd(uint32_t idx, uint8_t cmd) "idx[0x%"PRIx32"] cmd: 0x%"PRIx8
 cpuhp_acpi_read_cmd_data(uint32_t idx, uint32_t data) "idx[0x%"PRIx32"] data: 0x%"PRIx32
+cpuhp_acpi_read_cmd_data2(uint32_t idx, uint32_t data) "idx[0x%"PRIx32"] data: 0x%"PRIx32
 cpuhp_acpi_cpu_has_events(uint32_t idx, bool ins, bool rm) "idx[0x%"PRIx32"] inserting: %d, removing: %d"
 cpuhp_acpi_clear_inserting_evt(uint32_t idx) "idx[0x%"PRIx32"]"
 cpuhp_acpi_clear_remove_evt(uint32_t idx) "idx[0x%"PRIx32"]"
-- 
2.18.1


