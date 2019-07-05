Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29379C4649E
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 16:02:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0019021670
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 16:02:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0019021670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjQfT-000119-Cu
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 12:02:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36705)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hjQQw-0003Vl-UT
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 11:47:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hjQQt-0007jC-0E
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 11:47:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51118)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hjQQm-00077o-U6; Fri, 05 Jul 2019 11:47:25 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4104030C1AEA;
 Fri,  5 Jul 2019 15:47:22 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-45.brq.redhat.com [10.40.204.45])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2DFED1001B30;
 Fri,  5 Jul 2019 15:47:19 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri,  5 Jul 2019 17:46:39 +0200
Message-Id: <20190705154639.16591-10-philmd@redhat.com>
In-Reply-To: <20190705154639.16591-1-philmd@redhat.com>
References: <20190705154639.16591-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Fri, 05 Jul 2019 15:47:22 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 9/9] hw/block/pflash_cfi01: Hold the PRI
 table offset in a variable
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 John Snow <jsnow@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Manufacturers are allowed to move the PRI table, this is why the
offset is queryable via fixed offsets 0x15/0x16.
Add a variable to hold the offset, so it will be easier to later
move the PRI table.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Regression-tested-by: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/block/pflash_cfi01.c | 41 ++++++++++++++++++++++++++---------------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index ab72af22a7..67e714b32d 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -761,6 +761,7 @@ static void pflash_cfi01_realize(DeviceState *dev, Er=
ror **errp)
     }
=20
     /* Hardcoded CFI table */
+    const uint16_t pri_ofs =3D 0x31;
     /* Standard "QRY" string */
     pfl->cfi_table[0x10] =3D 'Q';
     pfl->cfi_table[0x11] =3D 'R';
@@ -769,14 +770,17 @@ static void pflash_cfi01_realize(DeviceState *dev, =
Error **errp)
     pfl->cfi_table[0x13] =3D 0x01;
     pfl->cfi_table[0x14] =3D 0x00;
     /* Primary extended table address (none) */
-    pfl->cfi_table[0x15] =3D 0x31;
-    pfl->cfi_table[0x16] =3D 0x00;
+    pfl->cfi_table[0x15] =3D pri_ofs;
+    pfl->cfi_table[0x16] =3D pri_ofs >> 8;
     /* Alternate command set (none) */
     pfl->cfi_table[0x17] =3D 0x00;
     pfl->cfi_table[0x18] =3D 0x00;
     /* Alternate extended table (none) */
     pfl->cfi_table[0x19] =3D 0x00;
     pfl->cfi_table[0x1A] =3D 0x00;
+
+    /* CFI: System Interface Information */
+
     /* Vcc min */
     pfl->cfi_table[0x1B] =3D 0x45;
     /* Vcc max */
@@ -801,6 +805,9 @@ static void pflash_cfi01_realize(DeviceState *dev, Er=
ror **errp)
     pfl->cfi_table[0x25] =3D 0x04;
     /* Max timeout for chip erase */
     pfl->cfi_table[0x26] =3D 0x00;
+
+    /* CFI: Device Geometry Definition */
+
     /* Device size */
     pfl->cfi_table[0x27] =3D ctz32(device_len); /* + 1; */
     /* Flash device interface (8 & 16 bits) */
@@ -825,26 +832,30 @@ static void pflash_cfi01_realize(DeviceState *dev, =
Error **errp)
     pfl->cfi_table[0x2E] =3D (blocks_per_device - 1) >> 8;
     pfl->cfi_table[0x2F] =3D sector_len_per_device >> 8;
     pfl->cfi_table[0x30] =3D sector_len_per_device >> 16;
+    assert(0x30 < pri_ofs);
+
+    /* CFI: Primary-Vendor Specific */
=20
     /* Extended */
-    pfl->cfi_table[0x31] =3D 'P';
-    pfl->cfi_table[0x32] =3D 'R';
-    pfl->cfi_table[0x33] =3D 'I';
+    pfl->cfi_table[0x00 + pri_ofs] =3D 'P';
+    pfl->cfi_table[0x01 + pri_ofs] =3D 'R';
+    pfl->cfi_table[0x02 + pri_ofs] =3D 'I';
=20
-    pfl->cfi_table[0x34] =3D '1';
-    pfl->cfi_table[0x35] =3D '0';
+    pfl->cfi_table[0x03 + pri_ofs] =3D '1';
+    pfl->cfi_table[0x04 + pri_ofs] =3D '0';
=20
-    pfl->cfi_table[0x36] =3D 0x00;
-    pfl->cfi_table[0x37] =3D 0x00;
-    pfl->cfi_table[0x38] =3D 0x00;
-    pfl->cfi_table[0x39] =3D 0x00;
+    pfl->cfi_table[0x05 + pri_ofs] =3D 0x00; /* Optional features */
+    pfl->cfi_table[0x06 + pri_ofs] =3D 0x00;
+    pfl->cfi_table[0x07 + pri_ofs] =3D 0x00;
+    pfl->cfi_table[0x08 + pri_ofs] =3D 0x00;
=20
-    pfl->cfi_table[0x3a] =3D 0x00;
+    pfl->cfi_table[0x09 + pri_ofs] =3D 0x00; /* Func. supported after su=
spend */
=20
-    pfl->cfi_table[0x3b] =3D 0x00;
-    pfl->cfi_table[0x3c] =3D 0x00;
+    pfl->cfi_table[0x0a + pri_ofs] =3D 0x00; /* Block status register ma=
sk */
+    pfl->cfi_table[0x0b + pri_ofs] =3D 0x00;
=20
-    pfl->cfi_table[0x3f] =3D 0x01; /* Number of protection fields */
+    pfl->cfi_table[0x0e + pri_ofs] =3D 0x01; /* Number of protection fie=
lds */
+    assert(0x0e + pri_ofs < ARRAY_SIZE(pfl->cfi_table));
 }
=20
 static void pflash_cfi01_system_reset(DeviceState *dev)
--=20
2.20.1


