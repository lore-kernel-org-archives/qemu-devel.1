Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96FB6C5B578
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 03:30:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E83521479
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 03:30:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E83521479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi9V2-0001nP-O3
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 23:30:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35398)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hi7DB-0003YB-4R
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 21:03:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hi7D3-0003sU-BT
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 21:03:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58290)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hi7CN-0001lv-54; Mon, 01 Jul 2019 21:03:36 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 378A830A7C7B;
 Tue,  2 Jul 2019 01:00:48 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-21.brq.redhat.com [10.40.204.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6DB5E1001B33;
 Tue,  2 Jul 2019 01:00:44 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  1 Jul 2019 21:59:01 -0300
Message-Id: <20190702005912.15905-17-philmd@redhat.com>
In-Reply-To: <20190702005912.15905-1-philmd@redhat.com>
References: <20190702005912.15905-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Tue, 02 Jul 2019 01:00:48 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 16/27] hw/block/pflash_cfi02: Hold the PRI table
 offset in a variable
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

Manufacturers are allowed to move the PRI table, this is why the
offset is queryable via fixed offsets 0x15/0x16.
Add a variable to hold the offset, so it will be easier to later
move the PRI table.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20190627202719.17739-17-philmd@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/block/pflash_cfi02.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index f1bac480f5..23d05a6308 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -552,6 +552,7 @@ static void pflash_cfi02_realize(DeviceState *dev, Er=
ror **errp)
     pfl->status =3D 0;
=20
     /* Hardcoded CFI table (mostly from SG29 Spansion flash) */
+    const uint16_t pri_ofs =3D 0x31;
     /* Standard "QRY" string */
     pfl->cfi_table[0x10] =3D 'Q';
     pfl->cfi_table[0x11] =3D 'R';
@@ -560,8 +561,8 @@ static void pflash_cfi02_realize(DeviceState *dev, Er=
ror **errp)
     pfl->cfi_table[0x13] =3D 0x02;
     pfl->cfi_table[0x14] =3D 0x00;
     /* Primary extended table address */
-    pfl->cfi_table[0x15] =3D 0x31;
-    pfl->cfi_table[0x16] =3D 0x00;
+    pfl->cfi_table[0x15] =3D pri_ofs;
+    pfl->cfi_table[0x16] =3D pri_ofs >> 8;
     /* Alternate command set (none) */
     pfl->cfi_table[0x17] =3D 0x00;
     pfl->cfi_table[0x18] =3D 0x00;
@@ -609,32 +610,34 @@ static void pflash_cfi02_realize(DeviceState *dev, =
Error **errp)
     pfl->cfi_table[0x2E] =3D (pfl->nb_blocs - 1) >> 8;
     pfl->cfi_table[0x2F] =3D pfl->sector_len >> 8;
     pfl->cfi_table[0x30] =3D pfl->sector_len >> 16;
+    assert(0x30 < pri_ofs);
=20
     /* Extended */
-    pfl->cfi_table[0x31] =3D 'P';
-    pfl->cfi_table[0x32] =3D 'R';
-    pfl->cfi_table[0x33] =3D 'I';
+    pfl->cfi_table[0x00 + pri_ofs] =3D 'P';
+    pfl->cfi_table[0x01 + pri_ofs] =3D 'R';
+    pfl->cfi_table[0x02 + pri_ofs] =3D 'I';
=20
     /* Extended version 1.0 */
-    pfl->cfi_table[0x34] =3D '1';
-    pfl->cfi_table[0x35] =3D '0';
+    pfl->cfi_table[0x03 + pri_ofs] =3D '1';
+    pfl->cfi_table[0x04 + pri_ofs] =3D '0';
=20
     /* Address sensitive unlock required. */
-    pfl->cfi_table[0x36] =3D 0x00;
+    pfl->cfi_table[0x05 + pri_ofs] =3D 0x00;
     /* Erase suspend not supported. */
-    pfl->cfi_table[0x37] =3D 0x00;
+    pfl->cfi_table[0x06 + pri_ofs] =3D 0x00;
     /* Sector protect not supported. */
-    pfl->cfi_table[0x38] =3D 0x00;
+    pfl->cfi_table[0x07 + pri_ofs] =3D 0x00;
     /* Temporary sector unprotect not supported. */
-    pfl->cfi_table[0x39] =3D 0x00;
+    pfl->cfi_table[0x08 + pri_ofs] =3D 0x00;
=20
     /* Sector protect/unprotect scheme. */
-    pfl->cfi_table[0x3a] =3D 0x00;
+    pfl->cfi_table[0x09 + pri_ofs] =3D 0x00;
=20
     /* Simultaneous operation not supported. */
-    pfl->cfi_table[0x3b] =3D 0x00;
+    pfl->cfi_table[0x0a + pri_ofs] =3D 0x00;
     /* Burst mode not supported. */
-    pfl->cfi_table[0x3c] =3D 0x00;
+    pfl->cfi_table[0x0b + pri_ofs] =3D 0x00;
+    assert(0x0b + pri_ofs < ARRAY_SIZE(pfl->cfi_table));
 }
=20
 static Property pflash_cfi02_properties[] =3D {
--=20
2.20.1


