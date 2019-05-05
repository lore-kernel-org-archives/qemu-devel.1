Return-Path: <SRS0=Huu6=TF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FCD8C04AAC
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2019 20:08:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BED8206A3
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2019 20:08:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BED8206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45314 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNNQo-0003LH-1f
	for qemu-devel@archiver.kernel.org; Sun, 05 May 2019 16:08:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNNP6-000281-EH
	for qemu-devel@nongnu.org; Sun, 05 May 2019 16:06:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNNP5-0003Cb-Du
	for qemu-devel@nongnu.org; Sun, 05 May 2019 16:06:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39498)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>)
	id 1hNNP2-0002qE-0H; Sun, 05 May 2019 16:06:28 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 42DB43091786;
	Sun,  5 May 2019 20:06:26 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-58.brq.redhat.com [10.40.204.58])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4BEF860851;
	Sun,  5 May 2019 20:06:19 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-stable@nongnu.org
Date: Sun,  5 May 2019 22:05:58 +0200
Message-Id: <20190505200602.12412-2-philmd@redhat.com>
In-Reply-To: <20190505200602.12412-1-philmd@redhat.com>
References: <20190505200602.12412-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Sun, 05 May 2019 20:06:26 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 1/5] hw/block/pflash_cfi01: Removed an unused
 timer
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
	Stephen Checkoway <stephen.checkoway@oberlin.edu>,
	qemu-block@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
	Laszlo Ersek <lersek@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
	Wei Yang <richardw.yang@linux.intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190505200558.IaEaB_SesbkKC0Ko2VkpVxp3ySTOeknhB3qfbpIAYjQ@z>

The 'CFI01' NOR flash was introduced in commit 29133e9a0fff, with
timing modelled. One year later, the CFI02 model was introduced
(commit 05ee37ebf630) based on the CFI01 model. As noted in the
header, "It does not support timings". 12 years later, we never
had to model the device timings. Time to remove the unused timer,
we can still add it back if required.

Suggested-by: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
Yes, I plan to model those timings later. Actually I have a series
working, but I'd rather first
1/ refactor common code between the both CFI implementations,
2/ discuss on list whether or not use timings for the Virt flash.
---
 hw/block/pflash_cfi01.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index 16dfae14b80..6dc04f156a7 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -42,7 +42,6 @@
 #include "hw/block/flash.h"
 #include "sysemu/block-backend.h"
 #include "qapi/error.h"
-#include "qemu/timer.h"
 #include "qemu/bitops.h"
 #include "qemu/host-utils.h"
 #include "qemu/log.h"
@@ -86,7 +85,6 @@ struct PFlashCFI01 {
     uint8_t cfi_table[0x52];
     uint64_t counter;
     unsigned int writeblock_size;
-    QEMUTimer *timer;
     MemoryRegion mem;
     char *name;
     void *storage;
@@ -110,18 +108,6 @@ static const VMStateDescription vmstate_pflash =3D {
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
@@ -771,7 +757,6 @@ static void pflash_cfi01_realize(DeviceState *dev, Er=
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


