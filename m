Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9193FC31E49
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 15:56:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E08220851
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 15:56:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E08220851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41196 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbS5U-0001PU-NQ
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 11:56:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42621)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hbQpj-0001cd-Gl
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 10:36:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hbQpg-0001YQ-3d
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 10:36:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38184)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hbQpf-00017y-L0
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 10:36:03 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AA27030BC599;
 Thu, 13 Jun 2019 14:35:37 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.141])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6A4F51001B16;
 Thu, 13 Jun 2019 14:35:32 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 13 Jun 2019 16:34:30 +0200
Message-Id: <20190613143446.23937-5-philmd@redhat.com>
In-Reply-To: <20190613143446.23937-1-philmd@redhat.com>
References: <20190613143446.23937-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Thu, 13 Jun 2019 14:35:37 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 04/20] hw/i386/pc: Add the E820Type enum type
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
Cc: Yang Zhong <yang.zhong@intel.com>, Eduardo Habkost <ehabkost@redhat.com>,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Rob Bradford <robert.bradford@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Samuel Ortiz <sameo@linux.intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This ensure we won't use an incorrect value.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
v2: Do not cast the enum (Li)
---
 hw/i386/pc.c         |  4 ++--
 include/hw/i386/pc.h | 16 ++++++++++------
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 5a7cffbb1a..86ba554439 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -872,7 +872,7 @@ static void handle_a20_line_change(void *opaque, int =
irq, int level)
     x86_cpu_set_a20(cpu, level);
 }
=20
-ssize_t e820_add_entry(uint64_t address, uint64_t length, uint32_t type)
+ssize_t e820_add_entry(uint64_t address, uint64_t length, E820Type type)
 {
     unsigned int index =3D le32_to_cpu(e820_reserve.count);
     struct e820_entry *entry;
@@ -906,7 +906,7 @@ size_t e820_get_num_entries(void)
     return e820_entries;
 }
=20
-bool e820_get_entry(unsigned int idx, uint32_t type,
+bool e820_get_entry(unsigned int idx, E820Type type,
                     uint64_t *address, uint64_t *length)
 {
     if (idx < e820_entries && e820_table[idx].type =3D=3D cpu_to_le32(ty=
pe)) {
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index c56116e6f6..7c07185dd5 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -282,12 +282,16 @@ void pc_system_firmware_init(PCMachineState *pcms, =
MemoryRegion *rom_memory);
 void pc_madt_cpu_entry(AcpiDeviceIf *adev, int uid,
                        const CPUArchIdList *apic_ids, GArray *entry);
=20
-/* e820 types */
-#define E820_RAM        1
-#define E820_RESERVED   2
-#define E820_ACPI       3
-#define E820_NVS        4
-#define E820_UNUSABLE   5
+/**
+ * E820Type: Type of the e820 address range.
+ */
+typedef enum {
+    E820_RAM        =3D 1,
+    E820_RESERVED   =3D 2,
+    E820_ACPI       =3D 3,
+    E820_NVS        =3D 4,
+    E820_UNUSABLE   =3D 5
+} E820Type;
=20
 ssize_t e820_add_entry(uint64_t, uint64_t, uint32_t);
 size_t e820_get_num_entries(void);
--=20
2.20.1


