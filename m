Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50364C76195
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 22:16:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B4F62173B
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 22:16:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B4F62173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnVkc-0007Ci-5e
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 18:16:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41593)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hnVkG-0006A2-MU
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 18:16:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hnVkF-0002MY-H5
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 18:16:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55504)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hnVkD-0002Jj-5j; Tue, 16 Jul 2019 18:16:21 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7A11E8553A;
 Tue, 16 Jul 2019 22:16:20 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-58.brq.redhat.com [10.40.204.58])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3C5BC5DAA4;
 Tue, 16 Jul 2019 22:16:14 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 17 Jul 2019 00:15:52 +0200
Message-Id: <20190716221555.11145-3-philmd@redhat.com>
In-Reply-To: <20190716221555.11145-1-philmd@redhat.com>
References: <20190716221555.11145-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Tue, 16 Jul 2019 22:16:20 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH-for-4.1 v6 2/5] hw/block/pflash_cfi01: Document
 use of non-CFI compliant command '0x00'
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

The command 0x00 is used by this model since its origin (commit
05ee37ebf630). In this commit the command is described with a
amusing '/* ??? */' comment, probably meaning 'FIXME'.

        switch (cmd) {
        case 0x00: /* ??? */
            ...

This comment survived 12 years because the 0x00 value is indeed
not specified by the CFI open standard (as of this commit).

The 'cmd' field is transfered during migration. To keep the
migration feature working with older QEMU version, we have to
take a lot of care with migrated field. We figured out it is
too late to remove a non-specified value from this model
(this would make migration review very complex). It is however
not too late to improve the documentation.

Add few comments to remember this is a special value related
to QEMU, and we won't find information about it on the CFI
spec.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
v6: new patch
---
 hw/block/pflash_cfi01.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index a9529957f8..6838e8a1ab 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -277,9 +277,13 @@ static uint32_t pflash_read(PFlashCFI01 *pfl, hwaddr=
 offset,
         /* This should never happen : reset state & treat it as a read *=
/
         DPRINTF("%s: unknown command state: %x\n", __func__, pfl->cmd);
         pfl->wcycle =3D 0;
-        pfl->cmd =3D 0;
+        /*
+         * The command 0x00 is not assigned by the CFI open standard,
+         * but QEMU historically uses it for the READ_ARRAY command (0xf=
f).
+         */
+        pfl->cmd =3D 0x00;
         /* fall through to read code */
-    case 0x00:
+    case 0x00: /* This model reset value for READ_ARRAY (not CFI complia=
nt) */
         /* Flash area read */
         ret =3D pflash_data_read(pfl, offset, width, be);
         break;
@@ -448,7 +452,7 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr off=
set,
     case 0:
         /* read mode */
         switch (cmd) {
-        case 0x00: /* ??? */
+        case 0x00: /* This model reset value for READ_ARRAY (not CFI) */
             goto reset_flash;
         case 0x10: /* Single Byte Program */
         case 0x40: /* Single Byte Program */
@@ -645,7 +649,7 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr off=
set,
     trace_pflash_reset();
     memory_region_rom_device_set_romd(&pfl->mem, true);
     pfl->wcycle =3D 0;
-    pfl->cmd =3D 0;
+    pfl->cmd =3D 0x00; /* This model reset value for READ_ARRAY (not CFI=
) */
 }
=20
=20
@@ -761,7 +765,11 @@ static void pflash_cfi01_realize(DeviceState *dev, E=
rror **errp)
     }
=20
     pfl->wcycle =3D 0;
-    pfl->cmd =3D 0;
+    /*
+     * The command 0x00 is not assigned by the CFI open standard,
+     * but QEMU historically uses it for the READ_ARRAY command (0xff).
+     */
+    pfl->cmd =3D 0x00;
     pfl->status =3D 0x80; /* WSM ready */
     /* Hardcoded CFI table */
     /* Standard "QRY" string */
--=20
2.20.1


