Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 878BFC35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:42:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5339921556
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:42:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MFTNkrm/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5339921556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6ZXz-0003aY-Ec
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:42:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49901)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Yl8-0001QK-1P
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Yl4-0000Ia-3w
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:17 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:40412)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6Yl3-0000CA-R9
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:14 -0500
Received: by mail-wr1-x430.google.com with SMTP id t3so14353565wru.7
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=awROg0sihrj8MlohXF0L5tCYoOeGnX4c09j9x6n5rqA=;
 b=MFTNkrm/z3Az54zKcPpI0/i0ePSv5HdQLUl1/XOQaDDqCHZku5CJ4XNlVk5farFjt1
 sWJD42HWN3RHejwjbo96zXBSJ/9Qb4fZOUgFoDhUji5E6Ait6s72ItBisQv3tDmtp44x
 Qk4S0/hAcrJqZwfH1dRqoPsFbRo190snPiweM0E6OpA85copkxkbXbvQw0EXAlj6Bt+e
 nuH9seY1lbocfRjelksioldnpR5fgT4tynHDvBMZrhTQY69yaowVfqkVgXv8XIz6p156
 VP6UpswfqNOIFi19YcXE+VyNFeVh910mSLXqJUwNjLOGL20LGrWqYhoq2wH/ViTMCsF+
 hbIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=awROg0sihrj8MlohXF0L5tCYoOeGnX4c09j9x6n5rqA=;
 b=pVinjtEYAodEHkb8QqAKpJmHMhWo7EOiYgFRwQfoOZKhCrbQzKyFLqkjxVf+EhDN04
 O0osgnhzEFWE/IBIsrfhp2zX1U0irb64tAHmWVn8W4NUEkTCQ9sypg4kJcAZUnradbdv
 ZRzyeLLpEqdeVLAfK8ZQtDtqV9PgNyY9rowbMmL2R4gVXjk1KaebMJrJ7NRrxsFlz2pT
 8fGHTZWGgx5Ger+9n1OjvBoxttNCoMaYwD9+9+0/A9IAYBdwpLm+0qB2zUOxIkdHAfLv
 G6HoAzCWBkdqzw9MI1KcyNgMwpkc335Q53yLfMRsnPhzM17aKqSDfSavs8Tz4tnOGM82
 OQbw==
X-Gm-Message-State: APjAAAXnSGSN304Yphb++9BhWqlFMidCjKH+4NZ6qqTodZbze+eQFOMq
 P1zm9H1ugoh60tFkzxsrqqgPjp6b
X-Google-Smtp-Source: APXvYqzGL36V06YFzl05Q87unbHhvIzu1XzPKxN3dpNiInVH85GNdR4D32A2EVMxQjUGsgD/S1Jrsw==
X-Received: by 2002:adf:f586:: with SMTP id f6mr69866750wro.46.1582631532476; 
 Tue, 25 Feb 2020 03:52:12 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.52.11
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:52:12 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 072/136] remove no longer used
 memory_region_allocate_system_memory()
Date: Tue, 25 Feb 2020 12:50:02 +0100
Message-Id: <1582631466-13880-72-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::430
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

all boards were switched to using memdev backend for main RAM,
so we can drop no longer used memory_region_allocate_system_memory()

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200219160953.13771-73-imammedo@redhat.com>
---
 hw/core/numa.c      | 34 ----------------------------------
 include/hw/boards.h | 32 --------------------------------
 2 files changed, 66 deletions(-)

diff --git a/hw/core/numa.c b/hw/core/numa.c
index e6baf2c..316bc50 100644
--- a/hw/core/numa.c
+++ b/hw/core/numa.c
@@ -806,40 +806,6 @@ void numa_cpu_pre_plug(const CPUArchId *slot, DeviceState *dev, Error **errp)
     }
 }
 
-static void allocate_system_memory_nonnuma(MemoryRegion *mr, Object *owner,
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
-        memory_region_init_ram_nomigrate(mr, owner, name, ram_size, &error_fatal);
-    }
-    vmstate_register_ram_global(mr);
-}
-
-void memory_region_allocate_system_memory(MemoryRegion *mr, Object *owner,
-                                          const char *name,
-                                          uint64_t ram_size)
-{
-    MachineState *ms = MACHINE(qdev_get_machine());
-
-    if (ms->numa_state == NULL ||
-        ms->numa_state->num_nodes == 0 || numa_uses_legacy_mem()) {
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
     MemoryDeviceInfoList *info_list = qmp_memory_device_list();
diff --git a/include/hw/boards.h b/include/hw/boards.h
index ae2b60f..142b86d 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -12,38 +12,6 @@
 #include "qom/object.h"
 #include "hw/core/cpu.h"
 
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
- * backend the user provided using "-mem-path" or "-numa node,memdev=..."
- * if appropriate; this is typically used to cause host huge pages to be
- * used. This function should therefore be called by a board exactly once,
- * for the primary or largest RAM area it implements.
- *
- * For boards where the major RAM is split into two parts in the memory
- * map, you can deal with this by calling memory_region_allocate_system_memory()
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
 
 /* Machine class name that needs to be used for class-name-based machine
-- 
1.8.3.1



