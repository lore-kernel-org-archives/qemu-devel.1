Return-Path: <SRS0=CqNf=4L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 669EFC35673
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Feb 2020 23:12:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31F9720880
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Feb 2020 23:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TZjCgpG/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31F9720880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j60Ps-0002wg-Ca
	for qemu-devel@archiver.kernel.org; Sun, 23 Feb 2020 18:12:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36675)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j60Ol-0001IN-EU
 for qemu-devel@nongnu.org; Sun, 23 Feb 2020 18:10:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j60Ok-0008BC-57
 for qemu-devel@nongnu.org; Sun, 23 Feb 2020 18:10:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58451
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j60Ok-0008AY-26
 for qemu-devel@nongnu.org; Sun, 23 Feb 2020 18:10:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582499453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7m6D+UrMt1IvB4PUHC/tuVd2KyfKwnkwiyt52tzSse4=;
 b=TZjCgpG/p4wB1mYkZePbgu/4OM97U+qEg0E0M6FzVyghCMHbzd5BGgSiVMP83c6temyjkk
 BSzpDNDmE06RbuJQGK8sRrQa0vFmKVs3dRz0RskHVasTSzyGC9mBv8D5ca0mhhAQVV965X
 g248yI3frZ3XZoT2hZRCMRnSuS2tnXo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-GNtXY_WGMH2hZw64LuoL7A-1; Sun, 23 Feb 2020 18:10:51 -0500
X-MC-Unique: GNtXY_WGMH2hZw64LuoL7A-1
Received: by mail-wr1-f72.google.com with SMTP id o9so4642691wrw.14
 for <qemu-devel@nongnu.org>; Sun, 23 Feb 2020 15:10:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nW/Qaa/Svz2Hcu9Y8ptDu3UYVgh8gHcT0yFJ/Hvj13s=;
 b=oDY6m4n+FCmgF3d+iLb3kYV1Q7X2AWgycsTUDZES8s/b3jGyEpxOWicgWrpUWMDlWl
 VFEUiXRlcClOTg6ymXgj6z81XZWTHZDSaRemGpSj/WUt7j9bcvk6mCe3tG6f9nz8DhWt
 vGAHBjfLZeQE9Wc02w3+booUIGgD5eGShQN2Yp/zvpsWgd1ZthBmpCASWjC+ZzFqZpgS
 wyOWTe+6lHVCMZ4PhhLlEPsyk02ZNsXxGLIReo6YKs6kuYrXxCGFWtvmSE39MzAxHsRf
 XL/o9iwvrN8sbp8Vr+kzdZ3WnlIhMm+VhdAVV0PrcsgYsiRTRr+/hQJXk4eSb2NxO7mV
 HxwA==
X-Gm-Message-State: APjAAAUZqA4LJDKY+jLwuFYJU2LGq5zjDYssoQKXFKwB4wrBT3wHW7Vs
 ocVKt+tzJxZ0V6cW4Kz/3RjSC81Kk1FS6lecZQ3935VRP6fIDr1a9anoCn1KkorHK9y3iRHmvH/
 XAfXu0J4s6W/wSzQ=
X-Received: by 2002:adf:ffc5:: with SMTP id x5mr63988506wrs.92.1582499450479; 
 Sun, 23 Feb 2020 15:10:50 -0800 (PST)
X-Google-Smtp-Source: APXvYqzE74xSqP5DvVkbDnITnE/XN24jM+0QL4BBDLSQMAhZ9OOjtn06SjQ2AUlqKiT+dWS25wx0Aw==
X-Received: by 2002:adf:ffc5:: with SMTP id x5mr63988493wrs.92.1582499450277; 
 Sun, 23 Feb 2020 15:10:50 -0800 (PST)
Received: from localhost.localdomain (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id r6sm15777598wrp.95.2020.02.23.15.10.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Feb 2020 15:10:49 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] hw/arm/gumstix: Use the IEC binary prefix definitions
Date: Mon, 24 Feb 2020 00:10:44 +0100
Message-Id: <20200223231044.8003-3-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200223231044.8003-1-philmd@redhat.com>
References: <20200223231044.8003-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

IEC binary prefixes ease code review: the unit is explicit.

Add a comment describing the Connex uses a Numonyx RC28F128J3F75
flash, and the Verdex uses a Micron RC28F256P30TFA.

Correct the Verdex machine description (we model the 'Pro' board).

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 hw/arm/gumstix.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/hw/arm/gumstix.c b/hw/arm/gumstix.c
index 94904d717b..ca918fda0c 100644
--- a/hw/arm/gumstix.c
+++ b/hw/arm/gumstix.c
@@ -35,6 +35,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "qemu/error-report.h"
 #include "hw/arm/pxa.h"
 #include "net/net.h"
@@ -45,18 +46,14 @@
 #include "sysemu/qtest.h"
 #include "cpu.h"
=20
-static const int sector_len =3D 128 * 1024;
+static const int sector_len =3D 128 * KiB;
=20
 static void connex_init(MachineState *machine)
 {
     PXA2xxState *cpu;
     DriveInfo *dinfo;
-    MemoryRegion *address_space_mem =3D get_system_memory();
=20
-    uint32_t connex_rom =3D 0x01000000;
-    uint32_t connex_ram =3D 0x04000000;
-
-    cpu =3D pxa255_init(address_space_mem, connex_ram);
+    cpu =3D pxa255_init(get_system_memory(), 64 * MiB);
=20
     dinfo =3D drive_get(IF_PFLASH, 0, 0);
     if (!dinfo && !qtest_enabled()) {
@@ -65,7 +62,8 @@ static void connex_init(MachineState *machine)
         exit(1);
     }
=20
-    if (!pflash_cfi01_register(0x00000000, "connext.rom", connex_rom,
+    /* Numonyx RC28F128J3F75 */
+    if (!pflash_cfi01_register(0x00000000, "connext.rom", 16 * MiB,
                                dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
                                sector_len, 2, 0, 0, 0, 0, 0)) {
         error_report("Error registering flash memory");
@@ -81,12 +79,8 @@ static void verdex_init(MachineState *machine)
 {
     PXA2xxState *cpu;
     DriveInfo *dinfo;
-    MemoryRegion *address_space_mem =3D get_system_memory();
=20
-    uint32_t verdex_rom =3D 0x02000000;
-    uint32_t verdex_ram =3D 0x10000000;
-
-    cpu =3D pxa270_init(address_space_mem, verdex_ram, machine->cpu_type);
+    cpu =3D pxa270_init(get_system_memory(), 256 * MiB, machine->cpu_type)=
;
=20
     dinfo =3D drive_get(IF_PFLASH, 0, 0);
     if (!dinfo && !qtest_enabled()) {
@@ -95,7 +89,8 @@ static void verdex_init(MachineState *machine)
         exit(1);
     }
=20
-    if (!pflash_cfi01_register(0x00000000, "verdex.rom", verdex_rom,
+    /* Micron RC28F256P30TFA */
+    if (!pflash_cfi01_register(0x00000000, "verdex.rom", 32 * MiB,
                                dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
                                sector_len, 2, 0, 0, 0, 0, 0)) {
         error_report("Error registering flash memory");
@@ -126,7 +121,7 @@ static void verdex_class_init(ObjectClass *oc, void *da=
ta)
 {
     MachineClass *mc =3D MACHINE_CLASS(oc);
=20
-    mc->desc =3D "Gumstix Verdex (PXA270)";
+    mc->desc =3D "Gumstix Verdex Pro XL6P COMs (PXA270)";
     mc->init =3D verdex_init;
     mc->ignore_memory_transaction_failures =3D true;
     mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("pxa270-c0");
--=20
2.21.1


