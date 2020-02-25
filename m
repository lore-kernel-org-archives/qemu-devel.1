Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF3DCC35E01
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:06:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 748DA222C2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZtrMbXU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 748DA222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Yyx-00013X-Hh
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:06:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49263)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YkR-0000WT-CJ
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YkM-0006LM-LZ
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:35 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:40717)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6YkM-0006Gh-Cs
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:30 -0500
Received: by mail-wm1-x335.google.com with SMTP id t14so2834923wmi.5
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SqGH5UVJUY+AYsjLLLoFT/qFOANPsA6TdRit/hNJTY8=;
 b=IZtrMbXU2wiin/UeAyaPv1Jdeg4k5PlJNBAmmpz1BhPk0AcQYcmR1H9QOzztEz9/LP
 g9rc8J+/cwizyvbOOT7uHIh4/gzNkN50iirUAt0BYtIWKtAtVK8LkRWcpA5nO0WABarU
 rQ2bgXlTdVwM12yRdadlnloBAKORDP8Kdq/++OkPKRk5s4FQphH6nJe0Z5EPhHPc+2Dz
 waeahZ8YB4zaWapCLNsoxvgU0CzXXLeeMh44ydgfWeZtvA5FpiDRmAR+Aq/Nbssy9GPx
 G+TWey24njxI+udyXUFMpdJnYF+EmfzE9Rbf1N+f+ltnWdOsKT7EOjRTXiXUz0Ia6RnJ
 PK1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=SqGH5UVJUY+AYsjLLLoFT/qFOANPsA6TdRit/hNJTY8=;
 b=r03cmsxkYW3ZzM/fx6twqUC6auvVWUyo9LU50F/R3ErQGHrFfrXhkUcXCNcOi3RnEW
 5hCZC+ESBJ0sDRJVyAkUUEKwodgKTd1g4lUTasdl1i2ZnX3ADu63yvW0Mn7ub4aIxKeI
 gZOS5cQCyvzAc5bDAMkLSGzmuhQ5TPFWhkC4B+lo6Zcg62C9tDq0Sg4jaSY4wvkHMgEk
 D3U0FtW+TO2Nc7VAZhpjN7qJVt9rdn4YI0aHy2u96Yg8tj0XQ00TsbjvInTHi08NClBX
 6hUdfDSpme/zaEBVxTg4JCBC5AK4PxptDFaKWyN+2UwNQ7Gn3LyQzWcSf5uZAkHGFSVh
 uiMw==
X-Gm-Message-State: APjAAAViofAulWsALE4vcee9n+bBHFHS757wx5zge4Mfzyz+4XSdnrKt
 1zspaWCCtbp5KCzCx4brALs8CYeC
X-Google-Smtp-Source: APXvYqyZ5K07uVxkfe5B5WTw2v8hwLxcO31wS5div1SOKgzz9p2BZ0l7gxu1dk/X22QLNTMgzNUzVQ==
X-Received: by 2002:a05:600c:3d1:: with SMTP id
 z17mr5150560wmd.90.1582631488293; 
 Tue, 25 Feb 2020 03:51:28 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.51.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:51:27 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 023/136] arm/mps2: use memdev for RAM
Date: Tue, 25 Feb 2020 12:49:13 +0100
Message-Id: <1582631466-13880-23-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::335
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

memory_region_allocate_system_memory() API is going away, so
replace it with memdev allocated MemoryRegion. The later is
initialized by generic code, so board only needs to opt in
to memdev scheme by providing
  MachineClass::default_ram_id
and using MachineState::ram instead of manually initializing
RAM memory region.

PS:
 while at it add check for user supplied RAM size and error
 out if it mismatches board expected value.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200219160953.13771-24-imammedo@redhat.com>
---
 hw/arm/mps2.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index d002b12..f246213 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -24,6 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/units.h"
+#include "qemu/cutils.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "hw/arm/boot.h"
@@ -55,7 +56,6 @@ typedef struct {
     MachineState parent;
 
     ARMv7MState armv7m;
-    MemoryRegion psram;
     MemoryRegion ssram1;
     MemoryRegion ssram1_m;
     MemoryRegion ssram23;
@@ -118,6 +118,13 @@ static void mps2_common_init(MachineState *machine)
         exit(1);
     }
 
+    if (machine->ram_size != mc->default_ram_size) {
+        char *sz = size_to_str(mc->default_ram_size);
+        error_report("Invalid RAM size, should be %s", sz);
+        g_free(sz);
+        exit(EXIT_FAILURE);
+    }
+
     /* The FPGA images have an odd combination of different RAMs,
      * because in hardware they are different implementations and
      * connected to different buses, giving varying performance/size
@@ -146,9 +153,7 @@ static void mps2_common_init(MachineState *machine)
      * This is of no use for QEMU so we don't implement it (as if
      * zbt_boot_ctrl is always zero).
      */
-    memory_region_allocate_system_memory(&mms->psram,
-                                         NULL, "mps.ram", 16 * MiB);
-    memory_region_add_subregion(system_memory, 0x21000000, &mms->psram);
+    memory_region_add_subregion(system_memory, 0x21000000, machine->ram);
 
     switch (mmc->fpga_type) {
     case FPGA_AN385:
@@ -338,6 +343,8 @@ static void mps2_class_init(ObjectClass *oc, void *data)
 
     mc->init = mps2_common_init;
     mc->max_cpus = 1;
+    mc->default_ram_size = 16 * MiB;
+    mc->default_ram_id = "mps.ram";
 }
 
 static void mps2_an385_class_init(ObjectClass *oc, void *data)
-- 
1.8.3.1



