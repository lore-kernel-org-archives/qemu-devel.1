Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E410AC4CEC4
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 09:24:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA7CB214AF
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 09:24:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA7CB214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAWCT-0001dh-Sy
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 05:24:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55660)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dovgaluk@ispras.ru>) id 1iAWAa-0000Hd-Ax
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 05:22:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dovgaluk@ispras.ru>) id 1iAWAZ-0006Jo-1r
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 05:22:40 -0400
Received: from mail.ispras.ru ([83.149.199.45]:55034)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <dovgaluk@ispras.ru>) id 1iAWAY-0006HM-My
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 05:22:39 -0400
Received: from PASHAISP (unknown [85.142.117.226])
 by mail.ispras.ru (Postfix) with ESMTPSA id 5D15854015D;
 Wed, 18 Sep 2019 12:22:35 +0300 (MSK)
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
To: "'Kevin Wolf'" <kwolf@redhat.com>,
 "'Pavel Dovgalyuk'" <pavel.dovgaluk@gmail.com>
References: <156872146565.1757.3033215873677512474.stgit@pasha-Precision-3630-Tower>
 <156872148244.1757.2888672921697745021.stgit@pasha-Precision-3630-Tower>
 <20190918091831.GD5207@localhost.localdomain>
In-Reply-To: <20190918091831.GD5207@localhost.localdomain>
Date: Wed, 18 Sep 2019 12:22:38 +0300
Message-ID: <001201d56e02$9d88b5f0$d89a21d0$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AdVuAhGBSLIt3dTuSbKdDg3TtxJgXwAADKug
Content-Language: ru
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 83.149.199.45
Subject: Re: [Qemu-devel] [for-4.2 PATCH 3/6] replay: update docs for
 record/replay with block devices
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
Cc: peter.maydell@linaro.org, pavel.dovgaluk@ispras.ru, quintela@redhat.com,
 ciro.santilli@gmail.com, jasowang@redhat.com, crosthwaite.peter@gmail.com,
 qemu-devel@nongnu.org, armbru@redhat.com, alex.bennee@linaro.org,
 maria.klimushenkova@ispras.ru, mst@redhat.com, kraxel@redhat.com,
 boost.lists@gmail.com, thomas.dullien@googlemail.com, pbonzini@redhat.com,
 mreitz@redhat.com, artem.k.pisarenko@gmail.com, dgilbert@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> From: Kevin Wolf [mailto:kwolf@redhat.com]
> Am 17.09.2019 um 13:58 hat Pavel Dovgalyuk geschrieben:
> > From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> >
> > This patch updates the description of the command lines for using
> > record/replay with attached block devices.
> >
> > Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> > ---
> >  docs/replay.txt |   12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git a/docs/replay.txt b/docs/replay.txt
> > index ee6aee9861..ce97c3f72f 100644
> > --- a/docs/replay.txt
> > +++ b/docs/replay.txt
> > @@ -27,7 +27,7 @@ Usage of the record/replay:
> >   * First, record the execution with the following command line:
> >      qemu-system-i386 \
> >       -icount shift=7,rr=record,rrfile=replay.bin \
> > -     -drive file=disk.qcow2,if=none,id=img-direct \
> > +     -drive file=disk.qcow2,if=none,snapshot,id=img-direct \
> >       -drive driver=blkreplay,if=none,image=img-direct,id=img-blkreplay \
> >       -device ide-hd,drive=img-blkreplay \
> >       -netdev user,id=net1 -device rtl8139,netdev=net1 \
> > @@ -35,7 +35,7 @@ Usage of the record/replay:
> >   * After recording, you can replay it by using another command line:
> >      qemu-system-i386 \
> >       -icount shift=7,rr=replay,rrfile=replay.bin \
> > -     -drive file=disk.qcow2,if=none,id=img-direct \
> > +     -drive file=disk.qcow2,if=none,snapshot,id=img-direct \
> >       -drive driver=blkreplay,if=none,image=img-direct,id=img-blkreplay \
> >       -device ide-hd,drive=img-blkreplay \
> >       -netdev user,id=net1 -device rtl8139,netdev=net1 \
> > @@ -223,7 +223,7 @@ Block devices record/replay module intercepts calls of
> >  bdrv coroutine functions at the top of block drivers stack.
> >  To record and replay block operations the drive must be configured
> >  as following:
> > - -drive file=disk.qcow2,if=none,id=img-direct
> > + -drive file=disk.qcow2,if=none,snapshot,id=img-direct
> >   -drive driver=blkreplay,if=none,image=img-direct,id=img-blkreplay
> >   -device ide-hd,drive=img-blkreplay
> >
> > @@ -252,6 +252,12 @@ This snapshot is created at start of recording and restored at start
> >  of replaying. It also can be loaded while replaying to roll back
> >  the execution.
> >
> > +'snapshot' flag of the disk image must be removed to save the snapshots
> > +in the overlay (or original image) instead of using the temporary overlay.
> > + -drive file=disk.ovl,if=none,id=img-direct
> > + -drive driver=blkreplay,if=none,image=img-direct,id=img-blkreplay
> > + -device ide-hd,drive=img-blkreplay
> 
> Wait, didn't patch 2 just make -snapshot unconditionally incompatible
> with replay? So isn't saving the snapshot in the original image the only
> supported mode now?

There are two ways to run record/replay:
1. Disk with snapshot option and any image to make it unchanged
2. Disk with overlay without snapshot option to save VM snapshots on it

Pavel Dovgalyuk


