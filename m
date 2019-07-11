Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD7CC74A35
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 15:58:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E625B20644
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 15:58:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E625B20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlbSz-0000iZ-90
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 11:58:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33488)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hlbS3-00056l-Uj
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 11:57:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hlbS1-0006iN-Ir
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 11:57:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59946)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hlbRy-0006f9-Qi; Thu, 11 Jul 2019 11:57:39 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BAC2BBB10;
 Thu, 11 Jul 2019 15:57:36 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-150.brq.redhat.com [10.40.204.150])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5B04E5D9CC;
 Thu, 11 Jul 2019 15:57:33 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
	qemu-devel@nongnu.org
Date: Thu, 11 Jul 2019 17:57:03 +0200
Message-Id: <20190711155703.15627-6-philmd@redhat.com>
In-Reply-To: <20190711155703.15627-1-philmd@redhat.com>
References: <20190711155703.15627-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Thu, 11 Jul 2019 15:57:36 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH-for-4.1 v4 5/5] hw/block/pflash_cfi01: Add the
 DeviceReset() handler
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
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>, Max Reitz <mreitz@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A "system reset" sets the device state machine in READ_ARRAY mode
and, after some delay, set the SR.7 READY bit.

We do not model timings, so we set the SR.7 bit directly.

The TYPE_DEVICE interface provides a DeviceReset handler.
This pflash device is a subclass of TYPE_SYS_BUS_DEVICE (which
is a subclass of TYPE_DEVICE).
SYS_BUS devices are automatically plugged into the 'main system
bus', which is the root of the qbus tree.
Devices in the qbus tree are guaranteed to have their reset()
handler called after realize() and before we try to run the guest.

To avoid incoherent states when the machine resets (see but report
below), factor out the reset code into pflash_cfi01_system_reset,
and register the method as a device reset callback.

Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1678713
Reported-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Regression-tested-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
v3: reword description
---
 hw/block/pflash_cfi01.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index aa2126f6dc..dd2ace92a8 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -795,8 +795,6 @@ static void pflash_cfi01_realize(DeviceState *dev, Er=
ror **errp)
         pfl->max_device_width =3D pfl->device_width;
     }
=20
-    pflash_mode_read_array(pfl);
-    pfl->status =3D 0x80; /* WSM ready */
     /* Hardcoded CFI table */
     /* Standard "QRY" string */
     pfl->cfi_table[0x10] =3D 'Q';
@@ -884,6 +882,18 @@ static void pflash_cfi01_realize(DeviceState *dev, E=
rror **errp)
     pfl->cfi_table[0x3f] =3D 0x01; /* Number of protection fields */
 }
=20
+static void pflash_cfi01_system_reset(DeviceState *dev)
+{
+    PFlashCFI01 *pfl =3D PFLASH_CFI01(dev);
+
+    pflash_mode_read_array(pfl);
+    /*
+     * The WSM ready timer occurs at most 150ns after system reset.
+     * This model deliberately ignores this delay.
+     */
+    pfl->status =3D 0x80;
+}
+
 static Property pflash_cfi01_properties[] =3D {
     DEFINE_PROP_DRIVE("drive", PFlashCFI01, blk),
     /* num-blocks is the number of blocks actually visible to the guest,
@@ -928,6 +938,7 @@ static void pflash_cfi01_class_init(ObjectClass *klas=
s, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
=20
+    dc->reset =3D pflash_cfi01_system_reset;
     dc->realize =3D pflash_cfi01_realize;
     dc->props =3D pflash_cfi01_properties;
     dc->vmsd =3D &vmstate_pflash;
--=20
2.20.1


