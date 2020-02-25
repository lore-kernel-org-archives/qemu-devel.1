Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B413C35DE1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 11:59:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9B282176D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 11:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="raWeujoe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9B282176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6YsW-0007QI-TJ
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 06:59:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49120)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YkF-0000Ev-Jy
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YkB-0005j6-Cn
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:23 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:54494)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6YkB-0005Tu-0m
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:19 -0500
Received: by mail-wm1-x335.google.com with SMTP id z12so2661911wmi.4
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YY43ANmrO7kgR48GobRQagfarNd+y5OAvVPvc2CleoI=;
 b=raWeujoeC2E9nXzMK47n9juzqUHGhIMz+gG1UgCnONTzLVX9YNNl9v/SxNVqTvxbe9
 G+Va6TmssZtWRv8WerudJ76P7v/7FfNLkcNgv4o1IqNkDPv/rG0iQhypZSeV+22aoVen
 qcuUHJxZXX2WaEFUaW5zt20PGIX95EQjHnYVgDbafSJO3m0MLPBc+X0IvOU+JhMthvAZ
 NVW9hUmLegkAUBjuGOcyvhv0M4S0iDQ8bIZTOMryl/IvVuzYwwlYNw8qKYg6utUhNdGU
 jIlFzLIIQAMg7jjMi/ifXTnwPcGSBnlarDztJOneAL6U5PaIeFsJljB27O/mgDAFr4bc
 dx0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=YY43ANmrO7kgR48GobRQagfarNd+y5OAvVPvc2CleoI=;
 b=QHIv8lytkC2j56XtNPXEvT/Bb2sU1Fk9VR+r5KOWcHuOS/xBmbT2DPxi/grTBWUb0L
 UiZ7cX2f3ZJ6tymAJb9Pr/zHxnFGa9vvBYwtA7k274IJyX0d5fnss6IKUywp6bnaCHIo
 tzThJD3T4ut/grFLtIHNSgYfvAvx72STcyIaKajTtPWPYBiyYr0ioqbrqHHnqFl5WlPV
 wJd6sxRGLjY74+jyNH69sJipGUqrHSPBrwIE65N/3ZxiuQManp01ppxmpM7w+e0Hgwv3
 /Ox6PKQmpgSp/D3SudyRWqlFdaSFzCsYTdQajtJHxOkS4DKu/CqSqwFnzxuQgxZavAPV
 2lfg==
X-Gm-Message-State: APjAAAWhA9gKacjHL/2Xe1r1CQHq22OgfPzGnfnCKOLmQ8jMeSGTOYv5
 wy9Ezy7UzbiO94KNEraCeSoR/h15
X-Google-Smtp-Source: APXvYqwqoXcUvw5ATI9/YJPeKONQtqSAuuUJoth8z9oDE4nb+EmIwe+iYFq1DctMcwfIv34LjLQIEw==
X-Received: by 2002:a1c:3b09:: with SMTP id i9mr4859112wma.31.1582631474950;
 Tue, 25 Feb 2020 03:51:14 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.51.13
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:51:14 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 009/136] arm/aspeed: actually check RAM size
Date: Tue, 25 Feb 2020 12:48:59 +0100
Message-Id: <1582631466-13880-9-git-send-email-pbonzini@redhat.com>
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

It's supposed that SOC will check if "-m" provided
RAM size is valid by setting "ram-size" property and
then board would read back valid (possibly corrected
value) to map RAM MemoryReging with valid size.
It isn't doing so, since check is called only
indirectly from
  aspeed_sdmc_reset()->asc->compute_conf()
or much later when guest writes to configuration
register.

So depending on "-m" value QEMU end-ups with a warning
and an invalid MemoryRegion size allocated and mapped.
(examples:
 -M ast2500-evb -m 1M
    0000000080000000-000000017ffffffe (prio 0, i/o): aspeed-ram-container
      0000000080000000-00000000800fffff (prio 0, ram): ram
      0000000080100000-00000000bfffffff (prio 0, i/o): max_ram
 -M ast2500-evb -m 3G
    0000000080000000-000000017ffffffe (prio 0, i/o): aspeed-ram-container
      0000000080000000-000000013fffffff (prio 0, ram): ram
      [DETECTED OVERFLOW!] 0000000140000000-00000000bfffffff (prio 0, i/o): max_ram
)
On top of that sdmc falls back and reports to guest
"default" size, it thinks machine should have.

This patch makes ram-size check actually work and
changes behavior from a warning later on during
machine reset to error_fatal at the moment SOC.ram-size
is set so user will have to fix RAM size on CLI
to start machine.

It also gets out of the way mutable ram-size logic,
so we could consolidate RAM allocation logic around
pre-allocated hostmem backend (supplied by user or
auto created by generic machine code depending on
supplied -m/mem-path/mem-prealloc options.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200219160953.13771-10-imammedo@redhat.com>
---
 hw/arm/aspeed.c               | 13 +++----
 hw/misc/aspeed_sdmc.c         | 83 +++++++++++++++++++++++++++++++++----------
 include/hw/misc/aspeed_sdmc.h |  1 +
 3 files changed, 70 insertions(+), 27 deletions(-)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index a17843f..805bebd 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -204,8 +204,12 @@ static void aspeed_machine_init(MachineState *machine)
 
     sc = ASPEED_SOC_GET_CLASS(&bmc->soc);
 
+    /*
+     * This will error out if isize is not supported by memory controller.
+     */
     object_property_set_uint(OBJECT(&bmc->soc), ram_size, "ram-size",
-                             &error_abort);
+                             &error_fatal);
+
     object_property_set_int(OBJECT(&bmc->soc), amc->hw_strap1, "hw-strap1",
                             &error_abort);
     object_property_set_int(OBJECT(&bmc->soc), amc->hw_strap2, "hw-strap2",
@@ -228,13 +232,6 @@ static void aspeed_machine_init(MachineState *machine)
     object_property_set_bool(OBJECT(&bmc->soc), true, "realized",
                              &error_abort);
 
-    /*
-     * Allocate RAM after the memory controller has checked the size
-     * was valid. If not, a default value is used.
-     */
-    ram_size = object_property_get_uint(OBJECT(&bmc->soc), "ram-size",
-                                        &error_abort);
-
     memory_region_allocate_system_memory(&bmc->ram, NULL, "ram", ram_size);
     memory_region_add_subregion(&bmc->ram_container, 0, &bmc->ram);
     memory_region_add_subregion(get_system_memory(),
diff --git a/hw/misc/aspeed_sdmc.c b/hw/misc/aspeed_sdmc.c
index 9c18479..7b466bf 100644
--- a/hw/misc/aspeed_sdmc.c
+++ b/hw/misc/aspeed_sdmc.c
@@ -17,6 +17,9 @@
 #include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "trace.h"
+#include "qemu/units.h"
+#include "qemu/cutils.h"
+#include "qapi/visitor.h"
 
 /* Protection Key Register */
 #define R_PROT            (0x00 / 4)
@@ -160,14 +163,9 @@ static int ast2400_rambits(AspeedSDMCState *s)
     case 512:
         return ASPEED_SDMC_DRAM_512MB;
     default:
+        g_assert_not_reached();
         break;
     }
-
-    /* use a common default */
-    warn_report("Invalid RAM size 0x%" PRIx64 ". Using default 256M",
-                s->ram_size);
-    s->ram_size = 256 << 20;
-    return ASPEED_SDMC_DRAM_256MB;
 }
 
 static int ast2500_rambits(AspeedSDMCState *s)
@@ -182,14 +180,9 @@ static int ast2500_rambits(AspeedSDMCState *s)
     case 1024:
         return ASPEED_SDMC_AST2500_1024MB;
     default:
+        g_assert_not_reached();
         break;
     }
-
-    /* use a common default */
-    warn_report("Invalid RAM size 0x%" PRIx64 ". Using default 512M",
-                s->ram_size);
-    s->ram_size = 512 << 20;
-    return ASPEED_SDMC_AST2500_512MB;
 }
 
 static int ast2600_rambits(AspeedSDMCState *s)
@@ -204,14 +197,9 @@ static int ast2600_rambits(AspeedSDMCState *s)
     case 2048:
         return ASPEED_SDMC_AST2600_2048MB;
     default:
+        g_assert_not_reached();
         break;
     }
-
-    /* use a common default */
-    warn_report("Invalid RAM size 0x%" PRIx64 ". Using default 1024M",
-                s->ram_size);
-    s->ram_size = 1024 << 20;
-    return ASPEED_SDMC_AST2600_1024MB;
 }
 
 static void aspeed_sdmc_reset(DeviceState *dev)
@@ -225,6 +213,51 @@ static void aspeed_sdmc_reset(DeviceState *dev)
     s->regs[R_CONF] = asc->compute_conf(s, 0);
 }
 
+static void aspeed_sdmc_get_ram_size(Object *obj, Visitor *v, const char *name,
+                                     void *opaque, Error **errp)
+{
+    AspeedSDMCState *s = ASPEED_SDMC(obj);
+    int64_t value = s->ram_size;
+
+    visit_type_int(v, name, &value, errp);
+}
+
+static void aspeed_sdmc_set_ram_size(Object *obj, Visitor *v, const char *name,
+                                     void *opaque, Error **errp)
+{
+    int i;
+    char *sz;
+    int64_t value;
+    Error *local_err = NULL;
+    AspeedSDMCState *s = ASPEED_SDMC(obj);
+    AspeedSDMCClass *asc = ASPEED_SDMC_GET_CLASS(s);
+
+    visit_type_int(v, name, &value, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    for (i = 0; asc->valid_ram_sizes[i]; i++) {
+        if (value == asc->valid_ram_sizes[i]) {
+            s->ram_size = value;
+            return;
+        }
+    }
+
+    sz = size_to_str(value);
+    error_setg(&local_err, "Invalid RAM size %s", sz);
+    g_free(sz);
+    error_propagate(errp, local_err);
+}
+
+static void aspeed_sdmc_initfn(Object *obj)
+{
+    object_property_add(obj, "ram-size", "int",
+                        aspeed_sdmc_get_ram_size, aspeed_sdmc_set_ram_size,
+                        NULL, NULL, NULL);
+}
+
 static void aspeed_sdmc_realize(DeviceState *dev, Error **errp)
 {
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
@@ -249,7 +282,6 @@ static const VMStateDescription vmstate_aspeed_sdmc = {
 };
 
 static Property aspeed_sdmc_properties[] = {
-    DEFINE_PROP_UINT64("ram-size", AspeedSDMCState, ram_size, 0),
     DEFINE_PROP_UINT64("max-ram-size", AspeedSDMCState, max_ram_size, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
@@ -268,6 +300,7 @@ static const TypeInfo aspeed_sdmc_info = {
     .name = TYPE_ASPEED_SDMC,
     .parent = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(AspeedSDMCState),
+    .instance_init = aspeed_sdmc_initfn,
     .class_init = aspeed_sdmc_class_init,
     .class_size = sizeof(AspeedSDMCClass),
     .abstract   = true,
@@ -298,6 +331,9 @@ static void aspeed_2400_sdmc_write(AspeedSDMCState *s, uint32_t reg,
     s->regs[reg] = data;
 }
 
+static const uint64_t
+aspeed_2400_ram_sizes[] = { 64 * MiB, 128 * MiB, 256 * MiB, 512 * MiB, 0};
+
 static void aspeed_2400_sdmc_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -307,6 +343,7 @@ static void aspeed_2400_sdmc_class_init(ObjectClass *klass, void *data)
     asc->max_ram_size = 512 << 20;
     asc->compute_conf = aspeed_2400_sdmc_compute_conf;
     asc->write = aspeed_2400_sdmc_write;
+    asc->valid_ram_sizes = aspeed_2400_ram_sizes;
 }
 
 static const TypeInfo aspeed_2400_sdmc_info = {
@@ -351,6 +388,9 @@ static void aspeed_2500_sdmc_write(AspeedSDMCState *s, uint32_t reg,
     s->regs[reg] = data;
 }
 
+static const uint64_t
+aspeed_2500_ram_sizes[] = { 128 * MiB, 256 * MiB, 512 * MiB, 1024 * MiB, 0};
+
 static void aspeed_2500_sdmc_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -360,6 +400,7 @@ static void aspeed_2500_sdmc_class_init(ObjectClass *klass, void *data)
     asc->max_ram_size = 1024 << 20;
     asc->compute_conf = aspeed_2500_sdmc_compute_conf;
     asc->write = aspeed_2500_sdmc_write;
+    asc->valid_ram_sizes = aspeed_2500_ram_sizes;
 }
 
 static const TypeInfo aspeed_2500_sdmc_info = {
@@ -404,6 +445,9 @@ static void aspeed_2600_sdmc_write(AspeedSDMCState *s, uint32_t reg,
     s->regs[reg] = data;
 }
 
+static const uint64_t
+aspeed_2600_ram_sizes[] = { 256 * MiB, 512 * MiB, 1024 * MiB, 2048 * MiB, 0};
+
 static void aspeed_2600_sdmc_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -413,6 +457,7 @@ static void aspeed_2600_sdmc_class_init(ObjectClass *klass, void *data)
     asc->max_ram_size = 2048 << 20;
     asc->compute_conf = aspeed_2600_sdmc_compute_conf;
     asc->write = aspeed_2600_sdmc_write;
+    asc->valid_ram_sizes = aspeed_2600_ram_sizes;
 }
 
 static const TypeInfo aspeed_2600_sdmc_info = {
diff --git a/include/hw/misc/aspeed_sdmc.h b/include/hw/misc/aspeed_sdmc.h
index 5dbde59..cea1e67 100644
--- a/include/hw/misc/aspeed_sdmc.h
+++ b/include/hw/misc/aspeed_sdmc.h
@@ -40,6 +40,7 @@ typedef struct AspeedSDMCClass {
     SysBusDeviceClass parent_class;
 
     uint64_t max_ram_size;
+    const uint64_t *valid_ram_sizes;
     uint32_t (*compute_conf)(AspeedSDMCState *s, uint32_t data);
     void (*write)(AspeedSDMCState *s, uint32_t reg, uint32_t data);
 } AspeedSDMCClass;
-- 
1.8.3.1



