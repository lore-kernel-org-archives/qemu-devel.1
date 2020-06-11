Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FE2C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:00:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F33052073E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UZTWv9tc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F33052073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjTNh-0005Sy-4o
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 16:00:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54610)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjT8l-0007nD-2a
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:45:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38966
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjT8h-0000yu-DV
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:45:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591904726;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o7ERHdN4iEb7/q9LObdRVPQ2Shiyg7n3Z4Gh4J1WRik=;
 b=UZTWv9tcVi5aSr0hzw23BAYU/ykizPBOmI8IG/ArObr+kq0j1KztSpzD+gI/z1Qzp5LsdP
 GWLBhzfLIstvA+ezNvrCfOnty3TYHQSfGG/jCXyUgRjE4R3S7i57aBK37u4yMHYrxamLwc
 4B9UpbsGPp4SV25tmmYnfESHt2FY6Hg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-i5SUaUhzOGGz5r6xZeG47A-1; Thu, 11 Jun 2020 15:45:24 -0400
X-MC-Unique: i5SUaUhzOGGz5r6xZeG47A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 73A448018A5;
 Thu, 11 Jun 2020 19:45:22 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E4E9E7BA1A;
 Thu, 11 Jun 2020 19:45:20 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 032/115] hw/i386/vmport: Define enum for all commands
Date: Thu, 11 Jun 2020 15:43:26 -0400
Message-Id: <20200611194449.31468-33-pbonzini@redhat.com>
In-Reply-To: <20200611194449.31468-1-pbonzini@redhat.com>
References: <20200611194449.31468-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 14:52:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Liran Alon <liran.alon@oracle.com>,
 Nikita Leshenko <nikita.leshchenko@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Liran Alon <liran.alon@oracle.com>

No functional change.

Defining an enum for all VMPort commands have the following advantages:
* It gets rid of the error-prone requirement to update VMPORT_ENTRIES
when new VMPort commands are added to QEMU.
* It makes it clear to know by looking at one place at the source, what
are all the VMPort commands supported by QEMU.

Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200312165431.82118-9-liran.alon@oracle.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/vmmouse.c        | 18 ++++++------------
 hw/i386/vmport.c         | 11 ++---------
 include/hw/i386/vmport.h | 11 ++++++++++-
 3 files changed, 18 insertions(+), 22 deletions(-)

diff --git a/hw/i386/vmmouse.c b/hw/i386/vmmouse.c
index b73f076753..ba5c987bd2 100644
--- a/hw/i386/vmmouse.c
+++ b/hw/i386/vmmouse.c
@@ -34,12 +34,6 @@
 /* debug only vmmouse */
 //#define DEBUG_VMMOUSE
 
-/* VMMouse Commands */
-#define VMMOUSE_GETVERSION	10
-#define VMMOUSE_DATA		39
-#define VMMOUSE_STATUS		40
-#define VMMOUSE_COMMAND		41
-
 #define VMMOUSE_READ_ID			0x45414552
 #define VMMOUSE_DISABLE			0x000000f5
 #define VMMOUSE_REQUEST_RELATIVE	0x4c455252
@@ -217,10 +211,10 @@ static uint32_t vmmouse_ioport_read(void *opaque, uint32_t addr)
     command = data[2] & 0xFFFF;
 
     switch (command) {
-    case VMMOUSE_STATUS:
+    case VMPORT_CMD_VMMOUSE_STATUS:
         data[0] = vmmouse_get_status(s);
         break;
-    case VMMOUSE_COMMAND:
+    case VMPORT_CMD_VMMOUSE_COMMAND:
         switch (data[1]) {
         case VMMOUSE_DISABLE:
             vmmouse_disable(s);
@@ -239,7 +233,7 @@ static uint32_t vmmouse_ioport_read(void *opaque, uint32_t addr)
             break;
         }
         break;
-    case VMMOUSE_DATA:
+    case VMPORT_CMD_VMMOUSE_DATA:
         vmmouse_data(s, data, data[1]);
         break;
     default:
@@ -296,9 +290,9 @@ static void vmmouse_realizefn(DeviceState *dev, Error **errp)
         return;
     }
 
-    vmport_register(VMMOUSE_STATUS, vmmouse_ioport_read, s);
-    vmport_register(VMMOUSE_COMMAND, vmmouse_ioport_read, s);
-    vmport_register(VMMOUSE_DATA, vmmouse_ioport_read, s);
+    vmport_register(VMPORT_CMD_VMMOUSE_STATUS, vmmouse_ioport_read, s);
+    vmport_register(VMPORT_CMD_VMMOUSE_COMMAND, vmmouse_ioport_read, s);
+    vmport_register(VMPORT_CMD_VMMOUSE_DATA, vmmouse_ioport_read, s);
 }
 
 static Property vmmouse_properties[] = {
diff --git a/hw/i386/vmport.c b/hw/i386/vmport.c
index e6d169566d..359cdef1e0 100644
--- a/hw/i386/vmport.c
+++ b/hw/i386/vmport.c
@@ -37,10 +37,6 @@
 #include "cpu.h"
 #include "trace.h"
 
-#define VMPORT_CMD_GETVERSION 0x0a
-#define VMPORT_CMD_GETRAMSIZE 0x14
-
-#define VMPORT_ENTRIES 0x2c
 #define VMPORT_MAGIC   0x564D5868
 
 /* Compatibility flags for migration */
@@ -71,12 +67,9 @@ typedef struct VMPortState {
 
 static VMPortState *port_state;
 
-void vmport_register(unsigned char command, VMPortReadFunc *func, void *opaque)
+void vmport_register(VMPortCommand command, VMPortReadFunc *func, void *opaque)
 {
-    if (command >= VMPORT_ENTRIES) {
-        return;
-    }
-
+    assert(command < VMPORT_ENTRIES);
     trace_vmport_register(command, func, opaque);
     port_state->func[command] = func;
     port_state->opaque[command] = opaque;
diff --git a/include/hw/i386/vmport.h b/include/hw/i386/vmport.h
index efbe3e0e3f..bbe2c58bf9 100644
--- a/include/hw/i386/vmport.h
+++ b/include/hw/i386/vmport.h
@@ -6,11 +6,20 @@
 #define TYPE_VMPORT "vmport"
 typedef uint32_t (VMPortReadFunc)(void *opaque, uint32_t address);
 
+typedef enum {
+    VMPORT_CMD_GETVERSION       = 10,
+    VMPORT_CMD_GETRAMSIZE       = 20,
+    VMPORT_CMD_VMMOUSE_DATA     = 39,
+    VMPORT_CMD_VMMOUSE_STATUS   = 40,
+    VMPORT_CMD_VMMOUSE_COMMAND  = 41,
+    VMPORT_ENTRIES
+} VMPortCommand;
+
 static inline void vmport_init(ISABus *bus)
 {
     isa_create_simple(bus, TYPE_VMPORT);
 }
 
-void vmport_register(unsigned char command, VMPortReadFunc *func, void *opaque);
+void vmport_register(VMPortCommand command, VMPortReadFunc *func, void *opaque);
 
 #endif
-- 
2.26.2



