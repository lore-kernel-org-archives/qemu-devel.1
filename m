Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C87FECE587
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:11:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12CFA20854
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:11:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12CFA20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK2wU-0004RB-O0
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 12:11:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36379)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iK2pC-0002rR-TB
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:04:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iK2pB-0006Sp-Kq
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:03:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53316)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1iK2p9-0006OL-3c; Mon, 14 Oct 2019 12:03:55 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 542212102;
 Mon, 14 Oct 2019 16:03:54 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.36.118.40])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 496CA5C1D4;
 Mon, 14 Oct 2019 16:03:53 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 04/15] replay: update docs for record/replay with block devices
Date: Mon, 14 Oct 2019 18:03:38 +0200
Message-Id: <20191014160343.8211-5-kwolf@redhat.com>
In-Reply-To: <20191014160343.8211-1-kwolf@redhat.com>
References: <20191014160343.8211-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.71]); Mon, 14 Oct 2019 16:03:54 +0000 (UTC)
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

This patch updates the description of the command lines for using
record/replay with attached block devices.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 docs/replay.txt | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/docs/replay.txt b/docs/replay.txt
index ee6aee9861..ce97c3f72f 100644
--- a/docs/replay.txt
+++ b/docs/replay.txt
@@ -27,7 +27,7 @@ Usage of the record/replay:
  * First, record the execution with the following command line:
     qemu-system-i386 \
      -icount shift=3D7,rr=3Drecord,rrfile=3Dreplay.bin \
-     -drive file=3Ddisk.qcow2,if=3Dnone,id=3Dimg-direct \
+     -drive file=3Ddisk.qcow2,if=3Dnone,snapshot,id=3Dimg-direct \
      -drive driver=3Dblkreplay,if=3Dnone,image=3Dimg-direct,id=3Dimg-blk=
replay \
      -device ide-hd,drive=3Dimg-blkreplay \
      -netdev user,id=3Dnet1 -device rtl8139,netdev=3Dnet1 \
@@ -35,7 +35,7 @@ Usage of the record/replay:
  * After recording, you can replay it by using another command line:
     qemu-system-i386 \
      -icount shift=3D7,rr=3Dreplay,rrfile=3Dreplay.bin \
-     -drive file=3Ddisk.qcow2,if=3Dnone,id=3Dimg-direct \
+     -drive file=3Ddisk.qcow2,if=3Dnone,snapshot,id=3Dimg-direct \
      -drive driver=3Dblkreplay,if=3Dnone,image=3Dimg-direct,id=3Dimg-blk=
replay \
      -device ide-hd,drive=3Dimg-blkreplay \
      -netdev user,id=3Dnet1 -device rtl8139,netdev=3Dnet1 \
@@ -223,7 +223,7 @@ Block devices record/replay module intercepts calls o=
f
 bdrv coroutine functions at the top of block drivers stack.
 To record and replay block operations the drive must be configured
 as following:
- -drive file=3Ddisk.qcow2,if=3Dnone,id=3Dimg-direct
+ -drive file=3Ddisk.qcow2,if=3Dnone,snapshot,id=3Dimg-direct
  -drive driver=3Dblkreplay,if=3Dnone,image=3Dimg-direct,id=3Dimg-blkrepl=
ay
  -device ide-hd,drive=3Dimg-blkreplay
=20
@@ -252,6 +252,12 @@ This snapshot is created at start of recording and r=
estored at start
 of replaying. It also can be loaded while replaying to roll back
 the execution.
=20
+'snapshot' flag of the disk image must be removed to save the snapshots
+in the overlay (or original image) instead of using the temporary overla=
y.
+ -drive file=3Ddisk.ovl,if=3Dnone,id=3Dimg-direct
+ -drive driver=3Dblkreplay,if=3Dnone,image=3Dimg-direct,id=3Dimg-blkrepl=
ay
+ -device ide-hd,drive=3Dimg-blkreplay
+
 Use QEMU monitor to create additional snapshots. 'savevm <name>' command
 created the snapshot and 'loadvm <name>' restores it. To prevent corrupt=
ion
 of the original disk image, use overlay files linked to the original ima=
ges.
--=20
2.20.1


