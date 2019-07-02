Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A0BC5B578
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 03:02:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EA06216C8
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 03:02:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EA06216C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi940-0007t9-GS
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 23:02:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52695)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hi6RW-0000lx-A4
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 20:14:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hi6RR-0006jn-Hh
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 20:14:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60635)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hi6R3-0006Ku-5O; Mon, 01 Jul 2019 20:14:13 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A7C535AFE3;
 Tue,  2 Jul 2019 00:13:46 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-21.brq.redhat.com [10.40.204.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8ED601001B10;
 Tue,  2 Jul 2019 00:13:27 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  2 Jul 2019 02:12:53 +0200
Message-Id: <20190702001301.4768-2-philmd@redhat.com>
In-Reply-To: <20190702001301.4768-1-philmd@redhat.com>
References: <20190702001301.4768-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Tue, 02 Jul 2019 00:13:47 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 1/9] hw/block/pflash_cfi01: Removed an
 unused timer
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-block@nongnu.org,
 Aleksandar Rikalo <arikalo@wavecomp.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-arm@nongnu.org,
 Alistair Francis <alistair23@gmail.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Michael Walle <michael@walle.cc>,
 qemu-ppc@nongnu.org, Wei Yang <richardw.yang@linux.intel.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The 'CFI02' NOR flash was introduced in commit 29133e9a0fff, with
timing modelled. One year later, the CFI01 model was introduced
(commit 05ee37ebf630) based on the CFI02 model. As noted in the
header, "It does not support timings". 12 years later, we never
had to model the device timings. Time to remove the unused timer,
we can still add it back if required.

Suggested-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
v2: Fixed commit description (Laszlo)
---
 hw/block/pflash_cfi01.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index 35080d915f..dcc9885bf0 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -42,7 +42,6 @@
 #include "hw/block/flash.h"
 #include "sysemu/block-backend.h"
 #include "qapi/error.h"
-#include "qemu/timer.h"
 #include "qemu/bitops.h"
 #include "qemu/error-report.h"
 #include "qemu/host-utils.h"
@@ -90,7 +89,6 @@ struct PFlashCFI01 {
     uint8_t cfi_table[0x52];
     uint64_t counter;
     unsigned int writeblock_size;
-    QEMUTimer *timer;
     MemoryRegion mem;
     char *name;
     void *storage;
@@ -114,18 +112,6 @@ static const VMStateDescription vmstate_pflash =3D {
     }
 };
=20
-static void pflash_timer (void *opaque)
-{
-    PFlashCFI01 *pfl =3D opaque;
-
-    trace_pflash_timer_expired(pfl->cmd);
-    /* Reset flash */
-    pfl->status ^=3D 0x80;
-    memory_region_rom_device_set_romd(&pfl->mem, true);
-    pfl->wcycle =3D 0;
-    pfl->cmd =3D 0;
-}
-
 /* Perform a CFI query based on the bank width of the flash.
  * If this code is called we know we have a device_width set for
  * this flash.
@@ -775,7 +761,6 @@ static void pflash_cfi01_realize(DeviceState *dev, Er=
ror **errp)
         pfl->max_device_width =3D pfl->device_width;
     }
=20
-    pfl->timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, pflash_timer, pfl);
     pfl->wcycle =3D 0;
     pfl->cmd =3D 0;
     pfl->status =3D 0;
--=20
2.20.1


