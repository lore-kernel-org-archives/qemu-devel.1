Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F2FC06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 03:10:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F008206A2
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 03:10:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F008206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi9C0-0001io-Oz
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 23:10:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34593)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hi79a-0002xm-NK
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 21:00:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hi79Q-0001TG-3S
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 21:00:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37764)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hi794-0001Ak-2r; Mon, 01 Jul 2019 20:59:42 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 845C5FA8CD;
 Tue,  2 Jul 2019 00:59:40 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-21.brq.redhat.com [10.40.204.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 99CCC1001B2D;
 Tue,  2 Jul 2019 00:59:36 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  1 Jul 2019 21:58:49 -0300
Message-Id: <20190702005912.15905-5-philmd@redhat.com>
In-Reply-To: <20190702005912.15905-1-philmd@redhat.com>
References: <20190702005912.15905-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Tue, 02 Jul 2019 00:59:40 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 04/27] hw/block/pflash_cfi02: Fix debug format
 string
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Stephen Checkoway <stephen.checkoway@oberlin.edu>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Always compile the debug code to prevent format string to bitrot.
Delete dead code.

Signed-off-by: Stephen Checkoway <stephen.checkoway@oberlin.edu>
Message-Id: <20190426162624.55977-3-stephen.checkoway@oberlin.edu>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
[PMD: Extracted from bigger patch, use PRIx32]
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/block/pflash_cfi02.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index 6cdfc85264..43796e551a 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -47,15 +47,13 @@
 #include "hw/sysbus.h"
 #include "trace.h"
=20
-//#define PFLASH_DEBUG
-#ifdef PFLASH_DEBUG
+#define PFLASH_DEBUG false
 #define DPRINTF(fmt, ...)                                  \
 do {                                                       \
-    fprintf(stderr, "PFLASH: " fmt , ## __VA_ARGS__);       \
+    if (PFLASH_DEBUG) {                                    \
+        fprintf(stderr, "PFLASH: " fmt, ## __VA_ARGS__);   \
+    }                                                      \
 } while (0)
-#else
-#define DPRINTF(fmt, ...) do { } while (0)
-#endif
=20
 #define PFLASH_LAZY_ROMD_THRESHOLD 42
=20
@@ -218,14 +216,14 @@ static uint32_t pflash_read(PFlashCFI02 *pfl, hwadd=
r offset,
         default:
             goto flash_read;
         }
-        DPRINTF("%s: ID " TARGET_FMT_plx " %x\n", __func__, boff, ret);
+        DPRINTF("%s: ID " TARGET_FMT_plx " %" PRIx32 "\n", __func__, bof=
f, ret);
         break;
     case 0xA0:
     case 0x10:
     case 0x30:
         /* Status register read */
         ret =3D pfl->status;
-        DPRINTF("%s: status %x\n", __func__, ret);
+        DPRINTF("%s: status %" PRIx32 "\n", __func__, ret);
         /* Toggle bit 6 */
         pfl->status ^=3D 0x40;
         break;
@@ -268,10 +266,6 @@ static void pflash_write(PFlashCFI02 *pfl, hwaddr of=
fset,
     trace_pflash_io_write(offset, width, width << 1, value, pfl->wcycle)=
;
     cmd =3D value;
     if (pfl->cmd !=3D 0xA0 && cmd =3D=3D 0xF0) {
-#if 0
-        DPRINTF("%s: flash reset asked (%02x %02x)\n",
-                __func__, pfl->cmd, cmd);
-#endif
         goto reset_flash;
     }
     offset &=3D pfl->chip_len - 1;
--=20
2.20.1


