Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29401C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 06:46:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00E5D20868
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 06:46:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00E5D20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49836 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hU3xo-0001ex-7j
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 02:46:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hU3ol-0002mR-R3
	for qemu-devel@nongnu.org; Fri, 24 May 2019 02:36:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hU3ok-0002qN-PD
	for qemu-devel@nongnu.org; Fri, 24 May 2019 02:36:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48490)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hU3ok-0002qB-Hu
	for qemu-devel@nongnu.org; Fri, 24 May 2019 02:36:38 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D2958307D91E;
	Fri, 24 May 2019 06:36:37 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-235.brq.redhat.com [10.40.204.235])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 638CD5B689;
	Fri, 24 May 2019 06:36:33 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 24 May 2019 08:35:37 +0200
Message-Id: <20190524063553.5339-5-philmd@redhat.com>
In-Reply-To: <20190524063553.5339-1-philmd@redhat.com>
References: <20190524063553.5339-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Fri, 24 May 2019 06:36:37 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 04/20] hw/i386/pc: Add the E820Type enum type
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Yang Zhong <yang.zhong@intel.com>, Eduardo Habkost <ehabkost@redhat.com>,
	Rob Bradford <robert.bradford@intel.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Richard Henderson <rth@twiddle.net>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Samuel Ortiz <sameo@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This ensure we won't use an incorrect value.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/i386/pc.c         | 12 +++++++-----
 include/hw/i386/pc.h | 16 ++++++++++------
 2 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 1245028dd6..ac8343c728 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -868,9 +868,10 @@ static void handle_a20_line_change(void *opaque, int=
 irq, int level)
     x86_cpu_set_a20(cpu, level);
 }
=20
-ssize_t e820_add_entry(uint64_t address, uint64_t length, uint32_t type)
+ssize_t e820_add_entry(uint64_t address, uint64_t length, E820Type type)
 {
     unsigned int index =3D le32_to_cpu(e820_reserve.count);
+    uint32_t utype =3D (uint32_t)type;
     struct e820_entry *entry;
=20
     if (type !=3D E820_RAM) {
@@ -882,7 +883,7 @@ ssize_t e820_add_entry(uint64_t address, uint64_t len=
gth, uint32_t type)
=20
         entry->address =3D cpu_to_le64(address);
         entry->length =3D cpu_to_le64(length);
-        entry->type =3D cpu_to_le32(type);
+        entry->type =3D cpu_to_le32(utype);
=20
         e820_reserve.count =3D cpu_to_le32(index);
     }
@@ -891,7 +892,7 @@ ssize_t e820_add_entry(uint64_t address, uint64_t len=
gth, uint32_t type)
     e820_table =3D g_renew(struct e820_entry, e820_table, e820_entries +=
 1);
     e820_table[e820_entries].address =3D cpu_to_le64(address);
     e820_table[e820_entries].length =3D cpu_to_le64(length);
-    e820_table[e820_entries].type =3D cpu_to_le32(type);
+    e820_table[e820_entries].type =3D cpu_to_le32(utype);
     e820_entries++;
=20
     return e820_entries;
@@ -902,10 +903,11 @@ size_t e820_get_num_entries(void)
     return e820_entries;
 }
=20
-bool e820_get_entry(unsigned int idx, uint32_t type,
+bool e820_get_entry(unsigned int idx, E820Type type,
                     uint64_t *address, uint64_t *length)
 {
-    if (idx < e820_entries && e820_table[idx].type =3D=3D cpu_to_le32(ty=
pe)) {
+    uint32_t utype =3D (uint32_t)type;
+    if (idx < e820_entries && e820_table[idx].type =3D=3D cpu_to_le32(ut=
ype)) {
         *address =3D le64_to_cpu(e820_table[idx].address);
         *length =3D le64_to_cpu(e820_table[idx].length);
         return true;
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 2bc48c03c6..10e77a40ce 100644
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


