Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3507BC35DE1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 11:56:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00F1A218AC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 11:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JznjNKOl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00F1A218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6You-0000eQ-19
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 06:56:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49037)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YkB-0000Cd-0M
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Yk4-0005LL-A0
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:18 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:46182)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6Yk4-0005JL-16
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:12 -0500
Received: by mail-wr1-x42a.google.com with SMTP id j7so1842690wrp.13
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=sm9s4fIJclBGqO01+rsBfXVbeX0LbLxkuz63t0RjXW4=;
 b=JznjNKOl2wlHOBAVngK2XZiwVT3bGn3EA1pEZwZEFN4qaSlPcdr4DZSZ/YAi//9BFy
 GMI2rIhWFHRdpZSY8KDsuH4gng8Frycb4HcMwtD/UIshHj3Z4xZp/QQOIhiTZPr7+X4y
 FxB3o6l531NjvRqvVQdOy0FNxCdYCnJh91cWEBMhAFkjOHkQcqpQvPYBueaZ13rF/Bda
 2UFZXQ1PfnjeFDO1t3luVXYcBYpTtcMiLq6yzz9M/pyQ3IgFRUccUw914N29MfkNps1P
 qXz3pYf3EtKHiw2e2O6O7UDcWWYFtz06XcYqpWTn5khLKNmAPXiKL68c/JeH436Pfsgx
 7DdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=sm9s4fIJclBGqO01+rsBfXVbeX0LbLxkuz63t0RjXW4=;
 b=bPkszIQaJ3BmdDGDlWuGbAXuDyu1wVAgsi/ko7SuUKfos7DnrDdNnolzbVicnmSxY7
 GDBz1nhVLmrEehgoFnd8bxY6MElkreMkcwr1Qd/LyjkBJ2KoRsq5lSOyOrrJ+izoCUNf
 /ahYLpAs5tSxRXchLbAPk0q8e2TT336iZuLgxmVMCFFP1D9qC8rD0kZY3hAb1A6RFzUX
 PaWZec04LedmTnpxP4oCs8QxYONyFiS6OYMtl1EU9D9pH6LQOS/KmXm9DKtTS/QowdJW
 pqPuR/2dh9iJxQ4q/ttHJbW1UUcX34zBrWb7aDxWCAa42qT4NwOmUbL5CHnTa3f8c7RF
 X+Rg==
X-Gm-Message-State: APjAAAWYs0+p87tJvL2sQaGlrk9Vjk4HzRmdVbXbtquDQFGMCPRA0J3n
 9pMgVdZtj28wwW09Ax1MuFPobwSc
X-Google-Smtp-Source: APXvYqyPJTXrICb4vzqO3jOgGMleox6sLDo65Br91tjnjNf1C2Qclrl3oR57yoWlKI7FTPptBTGTiQ==
X-Received: by 2002:a5d:67c7:: with SMTP id n7mr71978863wrw.319.1582631470412; 
 Tue, 25 Feb 2020 03:51:10 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.51.09
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:51:09 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 004/136] machine: introduce convenience MachineState::ram
Date: Tue, 25 Feb 2020 12:48:54 +0100
Message-Id: <1582631466-13880-4-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42a
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
Cc: Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Igor Mammedov <imammedo@redhat.com>

the new field will be used by boards to get access to main
RAM memory region and will help to save boiler plate in
boards which often introduce a field or variable just for
this purpose.

Memory region will be equivalent to what currently used
memory_region_allocate_system_memory() is returning apart
from that it will come from hostmem backend.
Followup patches will incrementally switch boards to using
RAM from MachineState::ram.

Patch takes care of non-NUMA case and follow up patch will
initialize MachineState::ram for NUMA case.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200219160953.13771-5-imammedo@redhat.com>
---
 hw/core/machine.c   | 24 ++++++++++++++++++++++++
 hw/core/numa.c      | 14 +-------------
 include/hw/boards.h | 12 +++++++++++-
 3 files changed, 36 insertions(+), 14 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 1a6e485..c8d361b 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -26,6 +26,7 @@
 #include "sysemu/qtest.h"
 #include "hw/pci/pci.h"
 #include "hw/mem/nvdimm.h"
+#include "migration/vmstate.h"
 
 GlobalProperty hw_compat_4_2[] = {
     { "virtio-blk-device", "x-enable-wce-if-config-wce", "off" },
@@ -1059,10 +1060,33 @@ static void machine_numa_finish_cpu_init(MachineState *machine)
     g_string_free(s, true);
 }
 
+MemoryRegion *machine_consume_memdev(MachineState *machine,
+                                     HostMemoryBackend *backend)
+{
+    MemoryRegion *ret = host_memory_backend_get_memory(backend);
+
+    if (memory_region_is_mapped(ret)) {
+        char *path = object_get_canonical_path_component(OBJECT(backend));
+        error_report("memory backend %s can't be used multiple times.", path);
+        g_free(path);
+        exit(EXIT_FAILURE);
+    }
+    host_memory_backend_set_mapped(backend, true);
+    vmstate_register_ram_global(ret);
+    return ret;
+}
+
 void machine_run_board_init(MachineState *machine)
 {
     MachineClass *machine_class = MACHINE_GET_CLASS(machine);
 
+    if (machine->ram_memdev_id) {
+        Object *o;
+        o = object_resolve_path_type(machine->ram_memdev_id,
+                                     TYPE_MEMORY_BACKEND, NULL);
+        machine->ram = machine_consume_memdev(machine, MEMORY_BACKEND(o));
+    }
+
     if (machine->numa_state) {
         numa_complete_configuration(machine);
         if (machine->numa_state->num_nodes) {
diff --git a/hw/core/numa.c b/hw/core/numa.c
index 840e685..8264336 100644
--- a/hw/core/numa.c
+++ b/hw/core/numa.c
@@ -817,20 +817,8 @@ void memory_region_allocate_system_memory(MemoryRegion *mr, Object *owner,
         if (!backend) {
             continue;
         }
-        MemoryRegion *seg = host_memory_backend_get_memory(backend);
-
-        if (memory_region_is_mapped(seg)) {
-            char *path = object_get_canonical_path_component(OBJECT(backend));
-            error_report("memory backend %s is used multiple times. Each "
-                         "-numa option must use a different memdev value.",
-                         path);
-            g_free(path);
-            exit(1);
-        }
-
-        host_memory_backend_set_mapped(backend, true);
+        MemoryRegion *seg = machine_consume_memdev(ms, backend);
         memory_region_add_subregion(mr, addr, seg);
-        vmstate_register_ram_global(seg);
         addr += size;
     }
 }
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 8e536ca..ae2b60f 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -73,7 +73,12 @@ void machine_set_cpu_numa_node(MachineState *machine,
                                Error **errp);
 
 void machine_class_allow_dynamic_sysbus_dev(MachineClass *mc, const char *type);
-
+/*
+ * Checks that backend isn't used, preps it for exclusive usage and
+ * returns migratable MemoryRegion provided by backend.
+ */
+MemoryRegion *machine_consume_memdev(MachineState *machine,
+                                     HostMemoryBackend *backend);
 
 /**
  * CPUArchId:
@@ -295,6 +300,11 @@ struct MachineState {
     bool enable_graphics;
     char *memory_encryption;
     char *ram_memdev_id;
+    /*
+     * convenience alias to ram_memdev_id backend memory region
+     * or to numa container memory region
+     */
+    MemoryRegion *ram;
     DeviceMemoryState *device_memory;
 
     ram_addr_t ram_size;
-- 
1.8.3.1



