Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF2FC34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 16:45:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A7FA20578
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 16:45:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I6s8JFde"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A7FA20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4STg-000791-9C
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 11:45:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37912)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1j4Rwj-000551-D7
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:11:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1j4Rwd-0001Z6-Mu
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:11:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28569
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1j4Rwd-0001YK-GB
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:11:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582128687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DrN1+36e2QAgJL7QzbEVwA6QT+OwCgTsS8BV4nf4rXc=;
 b=I6s8JFdeW4s5638YkdWs4CZ2znSCGNzDoSvrlNKlqWxIAA1SO37G3Fyoweat2AnVAMmEpu
 o4mv9JAsKeOE0xryB01EOULTd+dOIxh7xX1OizXnKmlRIAKY6E312NsE44Q0dZG5IwH5t9
 DJfLWk/8sH/zp6z5yR1BzDHSzclr9AE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-h3ELST-kNCiKyNF7XJWtQg-1; Wed, 19 Feb 2020 11:11:20 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 730998014D0
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2020 16:11:19 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 977E748;
 Wed, 19 Feb 2020 16:11:18 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 72/79] remove no longer used
 memory_region_allocate_system_memory()
Date: Wed, 19 Feb 2020 11:09:46 -0500
Message-Id: <20200219160953.13771-73-imammedo@redhat.com>
In-Reply-To: <20200219160953.13771-1-imammedo@redhat.com>
References: <20200219160953.13771-1-imammedo@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: h3ELST-kNCiKyNF7XJWtQg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

all boards were switched to using memdev backend for main RAM,
so we can drop no longer used memory_region_allocate_system_memory()

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
CC: ehabkost@redhat.com
CC: pbonzini@redhat.com
---
 include/hw/boards.h | 32 --------------------------------
 hw/core/numa.c      | 34 ----------------------------------
 2 files changed, 66 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index ae2b60fb5e..142b86d0ae 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -12,38 +12,6 @@
 #include "qom/object.h"
 #include "hw/core/cpu.h"
=20
-/**
- * memory_region_allocate_system_memory - Allocate a board's main memory
- * @mr: the #MemoryRegion to be initialized
- * @owner: the object that tracks the region's reference count
- * @name: name of the memory region
- * @ram_size: size of the region in bytes
- *
- * This function allocates the main memory for a board model, and
- * initializes @mr appropriately. It also arranges for the memory
- * to be migrated (by calling vmstate_register_ram_global()).
- *
- * Memory allocated via this function will be backed with the memory
- * backend the user provided using "-mem-path" or "-numa node,memdev=3D...=
"
- * if appropriate; this is typically used to cause host huge pages to be
- * used. This function should therefore be called by a board exactly once,
- * for the primary or largest RAM area it implements.
- *
- * For boards where the major RAM is split into two parts in the memory
- * map, you can deal with this by calling memory_region_allocate_system_me=
mory()
- * once to get a MemoryRegion with enough RAM for both parts, and then
- * creating alias MemoryRegions via memory_region_init_alias() which
- * alias into different parts of the RAM MemoryRegion and can be mapped
- * into the memory map in the appropriate places.
- *
- * Smaller pieces of memory (display RAM, static RAMs, etc) don't need
- * to be backed via the -mem-path memory backend and can simply
- * be created via memory_region_init_ram().
- */
-void memory_region_allocate_system_memory(MemoryRegion *mr, Object *owner,
-                                          const char *name,
-                                          uint64_t ram_size);
-
 #define TYPE_MACHINE_SUFFIX "-machine"
=20
 /* Machine class name that needs to be used for class-name-based machine
diff --git a/hw/core/numa.c b/hw/core/numa.c
index e6baf2c33e..316bc50d75 100644
--- a/hw/core/numa.c
+++ b/hw/core/numa.c
@@ -806,40 +806,6 @@ void numa_cpu_pre_plug(const CPUArchId *slot, DeviceSt=
ate *dev, Error **errp)
     }
 }
=20
-static void allocate_system_memory_nonnuma(MemoryRegion *mr, Object *owner=
,
-                                           const char *name,
-                                           uint64_t ram_size)
-{
-    if (mem_path) {
-#ifdef __linux__
-        memory_region_init_ram_from_file(mr, owner, name, ram_size, 0, 0,
-                                         mem_path, &error_fatal);
-#else
-        fprintf(stderr, "-mem-path not supported on this host\n");
-        exit(1);
-#endif
-    } else {
-        memory_region_init_ram_nomigrate(mr, owner, name, ram_size, &error=
_fatal);
-    }
-    vmstate_register_ram_global(mr);
-}
-
-void memory_region_allocate_system_memory(MemoryRegion *mr, Object *owner,
-                                          const char *name,
-                                          uint64_t ram_size)
-{
-    MachineState *ms =3D MACHINE(qdev_get_machine());
-
-    if (ms->numa_state =3D=3D NULL ||
-        ms->numa_state->num_nodes =3D=3D 0 || numa_uses_legacy_mem()) {
-        allocate_system_memory_nonnuma(mr, owner, name, ram_size);
-        return;
-    }
-
-    memory_region_init(mr, owner, name, ram_size);
-    numa_init_memdev_container(ms, mr);
-}
-
 static void numa_stat_memory_devices(NumaNodeMem node_mem[])
 {
     MemoryDeviceInfoList *info_list =3D qmp_memory_device_list();
--=20
2.18.1


