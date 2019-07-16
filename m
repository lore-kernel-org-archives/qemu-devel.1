Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F9ABC76192
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 22:17:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 674652173B
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 22:17:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 674652173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnVlC-0000wj-8x
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 18:17:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41804)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hnVke-0007eY-3o
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 18:16:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hnVkc-0002cZ-RW
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 18:16:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36206)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hnVkZ-0002a3-7v; Tue, 16 Jul 2019 18:16:43 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 441D0308FFB1;
 Tue, 16 Jul 2019 22:16:42 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-58.brq.redhat.com [10.40.204.58])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1223A5DAA4;
 Tue, 16 Jul 2019 22:16:33 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 17 Jul 2019 00:15:54 +0200
Message-Id: <20190716221555.11145-5-philmd@redhat.com>
In-Reply-To: <20190716221555.11145-1-philmd@redhat.com>
References: <20190716221555.11145-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Tue, 16 Jul 2019 22:16:42 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH-for-4.1 v6 4/5] hw/block/pflash_cfi01: Rename
 'reset_flash' label as 'mode_read_array'
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Laszlo Ersek <lersek@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>, John Snow <jsnow@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Rename the 'reset_flash' as 'mode_read_array' to make explicit we
do not reset the device, we simply set its internal state machine
in the READ_ARRAY mode. We do not reset the status register error
bits, as a device reset would do.

Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
v6: split of from previous patch to ease review
    dropped Laszlo's Regression-tested-by tag
---
 hw/block/pflash_cfi01.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index a28d0f8cc7..65afdbf3a7 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -460,7 +460,7 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr off=
set,
         /* read mode */
         switch (cmd) {
         case 0x00: /* This model reset value for READ_ARRAY (not CFI) */
-            goto reset_flash;
+            goto mode_read_array;
         case 0x10: /* Single Byte Program */
         case 0x40: /* Single Byte Program */
             DPRINTF("%s: Single Byte Program\n", __func__);
@@ -483,7 +483,7 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr off=
set,
         case 0x50: /* Clear status bits */
             DPRINTF("%s: Clear status bits\n", __func__);
             pfl->status =3D 0x0;
-            goto reset_flash;
+            goto mode_read_array;
         case 0x60: /* Block (un)lock */
             DPRINTF("%s: Block unlock\n", __func__);
             break;
@@ -508,10 +508,10 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr o=
ffset,
             break;
         case 0xf0: /* Probe for AMD flash */
             DPRINTF("%s: Probe for AMD flash\n", __func__);
-            goto reset_flash;
-        case 0xff: /* Read array mode */
+            goto mode_read_array;
+        case 0xff: /* Read Array */
             DPRINTF("%s: Read array mode\n", __func__);
-            goto reset_flash;
+            goto mode_read_array;
         default:
             goto error_flash;
         }
@@ -537,8 +537,8 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr off=
set,
             if (cmd =3D=3D 0xd0) { /* confirm */
                 pfl->wcycle =3D 0;
                 pfl->status |=3D 0x80;
-            } else if (cmd =3D=3D 0xff) { /* read array mode */
-                goto reset_flash;
+            } else if (cmd =3D=3D 0xff) { /* Read Array */
+                goto mode_read_array;
             } else
                 goto error_flash;
=20
@@ -564,16 +564,16 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr o=
ffset,
             } else if (cmd =3D=3D 0x01) {
                 pfl->wcycle =3D 0;
                 pfl->status |=3D 0x80;
-            } else if (cmd =3D=3D 0xff) {
-                goto reset_flash;
+            } else if (cmd =3D=3D 0xff) { /* Read Array */
+                goto mode_read_array;
             } else {
                 DPRINTF("%s: Unknown (un)locking command\n", __func__);
-                goto reset_flash;
+                goto mode_read_array;
             }
             break;
         case 0x98:
-            if (cmd =3D=3D 0xff) {
-                goto reset_flash;
+            if (cmd =3D=3D 0xff) { /* Read Array */
+                goto mode_read_array;
             } else {
                 DPRINTF("%s: leaving query mode\n", __func__);
             }
@@ -633,7 +633,7 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr off=
set,
                     " the data is already written to storage!\n"
                     "Flash device reset into READ mode.\n",
                     __func__);
-                goto reset_flash;
+                goto mode_read_array;
             }
             break;
         default:
@@ -643,7 +643,7 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr off=
set,
     default:
         /* Should never happen */
         DPRINTF("%s: invalid write state\n",  __func__);
-        goto reset_flash;
+        goto mode_read_array;
     }
     return;
=20
@@ -652,7 +652,7 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr off=
set,
                   "(offset " TARGET_FMT_plx ", wcycle 0x%x cmd 0x%x valu=
e 0x%x)"
                   "\n", __func__, offset, pfl->wcycle, pfl->cmd, value);
=20
- reset_flash:
+ mode_read_array:
     pflash_mode_read_array(pfl);
 }
=20
--=20
2.20.1


