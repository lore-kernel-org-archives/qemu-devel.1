Return-Path: <SRS0=CqNf=4L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 713B4C35670
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Feb 2020 23:26:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4172A206E2
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Feb 2020 23:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tf8TcZnV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4172A206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j60dp-0006p1-F3
	for qemu-devel@archiver.kernel.org; Sun, 23 Feb 2020 18:26:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37658)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j60co-0005lD-HP
 for qemu-devel@nongnu.org; Sun, 23 Feb 2020 18:25:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j60cn-0004Nj-85
 for qemu-devel@nongnu.org; Sun, 23 Feb 2020 18:25:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52250
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j60cn-0004NS-4N
 for qemu-devel@nongnu.org; Sun, 23 Feb 2020 18:25:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582500324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jQ/nivgBhDk2dNshKSoYmy6PiOFeo1QcTqHsAm3j+KM=;
 b=Tf8TcZnVejSfRIrUHOsWPBbyda5Iyn/rbmFdfiUW/8O+X23x0qSvlq0H/RI/mj4JMkZQBQ
 p4H/zT7M/9k1Ok1gkVargYmvNbkiaNJfr73Vp9tc5+ZvK4bhFjJ69gd61St7f8Gx582WdX
 NC3tfQlO9QPifsLJbEN6MxhfzIipmEg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-89-DTfyCjYZMOKCLwoDijNUpA-1; Sun, 23 Feb 2020 18:25:22 -0500
X-MC-Unique: DTfyCjYZMOKCLwoDijNUpA-1
Received: by mail-wr1-f70.google.com with SMTP id z1so993254wrs.9
 for <qemu-devel@nongnu.org>; Sun, 23 Feb 2020 15:25:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4QI6nH65BLHK26fGTFWTCKLvnsXl/KsAvAgD7fRuHX8=;
 b=EVzgcsSVmh2rG/Vp4f9BDtN6BOGH8AY8II4ajCYdhzM2iaobcj593WbHFENdp9ykW7
 28T594BDtTfjzUPi8jhuIrWSG57gOW0t81ZExC4kkvciLfe2qm+EocTy5LJ/D+zS2zDE
 9KKKtQ0+yhkrfujy1plRCgSncFDFxiCw1Bn+gwz3+izlDqXA2XxU9nXHRWFqv0itCV5+
 8/iWELq7vfhAYLdrCLv2I7xAh+pjNPqoqqAQO9qmWKS4rlD3IW4WM14kAyaXs6VAL3uJ
 Sipky91DGad5WpfdXHXttPdOv8nOQ5XHaJ5tOFFxEzTOMloGn5zyyjJnXUdL+mqeglf8
 nvYA==
X-Gm-Message-State: APjAAAVLm5EeT0qyvjo4kDi5OpghSsYFWvWvyl7R3bvWefGvAfNt0MN5
 ZnxpEAT3M8UK15eAlCGaXl+v8wuXTE0HnA6QwOY8UtRGuol9tX4eJI8XYa+edMPQTUw4DPwv4YI
 +3JTesCThz9ZmFQA=
X-Received: by 2002:a7b:ce0b:: with SMTP id m11mr18489564wmc.4.1582500321325; 
 Sun, 23 Feb 2020 15:25:21 -0800 (PST)
X-Google-Smtp-Source: APXvYqxioEjZ1zLxqP1f4x5wA8oCVlec7tjUQDVW4i5EOITvlVuIC05wBO/AAVP2YcSGZr1dIglSGA==
X-Received: by 2002:a7b:ce0b:: with SMTP id m11mr18489552wmc.4.1582500321111; 
 Sun, 23 Feb 2020 15:25:21 -0800 (PST)
Received: from localhost.localdomain (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id c9sm15671102wrq.44.2020.02.23.15.25.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Feb 2020 15:25:20 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 2/2] hw/arm/integratorcp: Map a CFI parallel flash
Date: Mon, 24 Feb 2020 00:25:16 +0100
Message-Id: <20200223232516.13802-3-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200223232516.13802-1-philmd@redhat.com>
References: <20200223232516.13802-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

The Linux kernel displays errors why trying to detect the flash:

  Linux version 4.16.0 (linus@genomnajs) (gcc version 7.2.1 20171011 (Linar=
o GCC 7.2-2017.11)) #142 PREEMPT Wed May 9 13:24:55 CEST 2018
  CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=3D00093177
  CPU: VIVT data cache, VIVT instruction cache
  OF: fdt: Machine model: ARM Integrator/CP
  ...
  of-flash 24000000.flash: Integrator/CP flash protection
  of-flash 24000000.flash: do_map_probe() failed for type cfi_probe
  of-flash 24000000.flash: do_map_probe() failed

Since we have a CFI pflash model available, wire it.
The kernel properly detects it:

  of-flash 24000000.flash: Integrator/CP flash protection
  24000000.flash: Found 1 x32 devices at 0x0 in 32-bit bank. Manufacturer I=
D 0x000000 Chip ID 0x000000
  Intel/Sharp Extended Query Table at 0x0031
  Using buffer write method

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
RFC because I have no idea of the flash model, its ID code, and which
default CFI family (1 or 2).
---
 hw/arm/integratorcp.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index 59804140cd..40cedfd55a 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -8,6 +8,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "qapi/error.h"
 #include "cpu.h"
 #include "hw/sysbus.h"
@@ -24,6 +25,7 @@
 #include "hw/char/pl011.h"
 #include "hw/hw.h"
 #include "hw/irq.h"
+#include "hw/block/flash.h"
=20
 #define TYPE_INTEGRATOR_CM "integrator_core"
 #define INTEGRATOR_CM(obj) \
@@ -589,6 +591,7 @@ static void integratorcp_init(MachineState *machine)
     MemoryRegion *ram_alias =3D g_new(MemoryRegion, 1);
     qemu_irq pic[32];
     DeviceState *dev, *sic, *icp;
+    DriveInfo *dinfo;
     int i;
=20
     cpuobj =3D object_new(machine->cpu_type);
@@ -646,6 +649,14 @@ static void integratorcp_init(MachineState *machine)
                           qdev_get_gpio_in_named(icp, ICP_GPIO_MMC_CARDIN,=
 0));
     sysbus_create_varargs("pl041", 0x1d000000, pic[25], NULL);
=20
+    dinfo =3D drive_get(IF_PFLASH, 0, 0);
+    if (!pflash_cfi01_register(0x24000000, "pflash", 16 * MiB,
+                               dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
+                               64 * KiB, 4, 0, 0, 0, 0, 0)) {
+        error_report("Error registering flash memory");
+        exit(1);
+    }
+
     if (nd_table[0].used)
         smc91c111_init(&nd_table[0], 0xc8000000, pic[27]);
=20
--=20
2.21.1


