Return-Path: <SRS0=2u83=X7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A160AC10F14
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Oct 2019 20:34:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 766A92080F
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Oct 2019 20:34:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 766A92080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHDEy-00063y-Le
	for qemu-devel@archiver.kernel.org; Sun, 06 Oct 2019 16:34:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35730)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1iHDCM-0004TM-5I
 for qemu-devel@nongnu.org; Sun, 06 Oct 2019 16:32:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1iHDCK-0007aP-Th
 for qemu-devel@nongnu.org; Sun, 06 Oct 2019 16:32:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52224)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1iHDCG-0007XO-WB; Sun, 06 Oct 2019 16:32:05 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AA52A18C8916;
 Sun,  6 Oct 2019 20:31:58 +0000 (UTC)
Received: from probe.redhat.com (ovpn-120-66.rdu2.redhat.com [10.10.120.66])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ABACA19C6A;
 Sun,  6 Oct 2019 20:31:57 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/1] IDE: deprecate ide-drive
Date: Sun,  6 Oct 2019 16:31:50 -0400
Message-Id: <20191006203150.13054-2-jsnow@redhat.com>
In-Reply-To: <20191006203150.13054-1-jsnow@redhat.com>
References: <20191006203150.13054-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.70]); Sun, 06 Oct 2019 20:31:58 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: libvir-list@redhat.com, Kevin Wolf <kwolf@redhat.com>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It's an old compatibility shim that just delegates to ide-cd or ide-hd.
I'd like to refactor these some day, and getting rid of the super-object
will make that easier.

Either way, we don't need this.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qemu-deprecated.texi          | 5 +++++
 hw/ide/qdev.c                 | 3 +++
 tests/qemu-iotests/051.pc.out | 6 ++++--
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index 01245e0b1c4..f802d83983e 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -247,6 +247,11 @@ quite a bit. It will be removed without replacement =
unless some users speaks
 up at the @email{qemu-devel@@nongnu.org} mailing list with information a=
bout
 their usecases.
=20
+@subsection ide-drive (since 4.2)
+
+The 'ide-drive' device is deprecated. Users should use 'ide-hd' or
+'ide-cd' as appropriate to get an IDE hard disk or CDROM as needed.
+
 @section System emulator machines
=20
 @subsection pc-0.12, pc-0.13, pc-0.14 and pc-0.15 (since 4.0)
diff --git a/hw/ide/qdev.c b/hw/ide/qdev.c
index 6fba6b62b87..9ecee4da074 100644
--- a/hw/ide/qdev.c
+++ b/hw/ide/qdev.c
@@ -279,6 +279,9 @@ static void ide_drive_realize(IDEDevice *dev, Error *=
*errp)
 {
     DriveInfo *dinfo =3D NULL;
=20
+    warn_report("The 'ide-drive' device is deprecated. "
+                "Use 'ide-hd' or 'ide-cd' instead");
+
     if (dev->conf.blk) {
         dinfo =3D blk_legacy_dinfo(dev->conf.blk);
     }
diff --git a/tests/qemu-iotests/051.pc.out b/tests/qemu-iotests/051.pc.ou=
t
index 000557c7c83..93b9a1f82ca 100644
--- a/tests/qemu-iotests/051.pc.out
+++ b/tests/qemu-iotests/051.pc.out
@@ -158,7 +158,8 @@ QEMU X.Y.Z monitor - type 'help' for more information
=20
 Testing: -drive if=3Dnone,id=3Ddisk -device ide-drive,drive=3Ddisk
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) QEMU_PROG: -device ide-drive,drive=3Ddisk: Device needs media, bu=
t drive is empty
+(qemu) QEMU_PROG: -device ide-drive,drive=3Ddisk: warning: The 'ide-driv=
e' device is deprecated. Use 'ide-hd' or 'ide-cd' instead
+QEMU_PROG: -device ide-drive,drive=3Ddisk: Device needs media, but drive=
 is empty
=20
 Testing: -drive if=3Dnone,id=3Ddisk -device ide-hd,drive=3Ddisk
 QEMU X.Y.Z monitor - type 'help' for more information
@@ -228,7 +229,8 @@ QEMU X.Y.Z monitor - type 'help' for more information
=20
 Testing: -drive file=3DTEST_DIR/t.qcow2,if=3Dnone,id=3Ddisk,readonly=3Do=
n -device ide-drive,drive=3Ddisk
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) QEMU_PROG: -device ide-drive,drive=3Ddisk: Block node is read-onl=
y
+(qemu) QEMU_PROG: -device ide-drive,drive=3Ddisk: warning: The 'ide-driv=
e' device is deprecated. Use 'ide-hd' or 'ide-cd' instead
+QEMU_PROG: -device ide-drive,drive=3Ddisk: Block node is read-only
=20
 Testing: -drive file=3DTEST_DIR/t.qcow2,if=3Dnone,id=3Ddisk,readonly=3Do=
n -device ide-hd,drive=3Ddisk
 QEMU X.Y.Z monitor - type 'help' for more information
--=20
2.21.0


