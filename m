Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAAA5C47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 06:11:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C17CF2196E
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 06:11:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C17CF2196E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIo9I-0003IU-Tm
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 02:11:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50805)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dovgaluk@ispras.ru>) id 1iIo8G-0002am-Ua
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 02:10:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dovgaluk@ispras.ru>) id 1iIo8F-0003w2-Gy
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 02:10:32 -0400
Received: from mail.ispras.ru ([83.149.199.45]:56642)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <dovgaluk@ispras.ru>) id 1iIo8F-0003uj-5o
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 02:10:31 -0400
Received: from PASHAISP (unknown [85.142.117.226])
 by mail.ispras.ru (Postfix) with ESMTPSA id 3F39E54006A;
 Fri, 11 Oct 2019 09:10:27 +0300 (MSK)
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
To: "'Kevin Wolf'" <kwolf@redhat.com>
References: <20190918094436.GG5207@localhost.localdomain>
 <001501d56e06$bbd7aa30$3386fe90$@ru>
 <20190919085302.GA10163@localhost.localdomain>
 <001901d56ec9$620ae260$2620a720$@ru>
 <20190919112702.GC10163@localhost.localdomain>
 <001a01d56ee3$4354a530$c9fdef90$@ru>
 <20190919130005.GF10163@localhost.localdomain>
 <002401d56f84$83900e40$8ab02ac0$@ru>
 <20190920100150.GD5458@localhost.localdomain>
 <001601d57380$002b3f20$0081bd60$@ru>
 <20191010152830.GF7616@localhost.localdomain>
In-Reply-To: <20191010152830.GF7616@localhost.localdomain>
Subject: RE: [for-4.2 PATCH 3/6] replay: update docs for record/replay with
 block devices
Date: Fri, 11 Oct 2019 09:10:24 +0300
Message-ID: <002401d57ffa$927ffab0$b77ff010$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AdV/f2Y6+SShHM08RyCUBXimHJwn0wAeknuw
Content-Language: ru
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 83.149.199.45
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
> Am 25.09.2019 um 11:02 hat Pavel Dovgalyuk geschrieben:
> > > From: Kevin Wolf [mailto:kwolf@redhat.com]
> > > Am 20.09.2019 um 09:25 hat Pavel Dovgalyuk geschrieben:
> > > > > From: Kevin Wolf [mailto:kwolf@redhat.com]
> > > > > Am 19.09.2019 um 14:10 hat Pavel Dovgalyuk geschrieben:
> > > > > > > From: Kevin Wolf [mailto:kwolf@redhat.com]
> > > > > > > diff --git a/block/block-backend.c b/block/block-backend.c
> > > > > > > index 1c605d5444..c57d3d9fdf 100644
> > > > > > > --- a/block/block-backend.c
> > > > > > > +++ b/block/block-backend.c
> > > > > > > @@ -17,6 +17,7 @@
> > > > > > >  #include "block/throttle-groups.h"
> > > > > > >  #include "hw/qdev-core.h"
> > > > > > >  #include "sysemu/blockdev.h"
> > > > > > > +#include "sysemu/replay.h"
> > > > > > >  #include "sysemu/runstate.h"
> > > > > > >  #include "qapi/error.h"
> > > > > > >  #include "qapi/qapi-events-block.h"
> > > > > > > @@ -808,6 +809,12 @@ void blk_remove_bs(BlockBackend *blk)
> > > > > > >  int blk_insert_bs(BlockBackend *blk, BlockDriverState *bs, Error **errp)
> > > > > > >  {
> > > > > > >      ThrottleGroupMember *tgm = &blk->public.throttle_group_member;
> > > > > > > +
> > > > > > > +    if (replay_mode != REPLAY_MODE_NONE && bs->drv != &bdrv_blkreplay) {
> > > > > > > +        error_setg(errp, "Root node must be blkreplay");
> > > > > > > +        return -ENOTSUP;
> > > > > > > +    }
> > > > > >
> > > > > > I guess this is opposite direction - bs->drv is bdrv_file.
> > > > > > And we should check its parent.
> > > > >
> > > > > If bs->drv is bdrv_file, you want this to fail because only
> > > > > bdrv_blkreplay should be able to be attached to devices.
> > > >
> > > > There was a regular rr invocation (as described in docs).
> > > > And bs->drv always was a pointer to bdrv_file: for original image,
> > > > and for temporary snapshot.
> > >
> > > Hm, what was the actual command line you used? I can see that you have a
> > > separate -drive for the qcow2 file, so I can see how you get an unused
> > > BlockBackend for the qcow2 node, but I don't see how it would be a file
> > > node.
> > >
> > > Anyway, this leaves us two options: Either change the recommended
> > > command line to use -blockdev for the qcow2 file so that no BlockBackend
> > > is created for it (I think this might be preferable), or restrict the
> > > error to when the BlockBackend is used.
> >
> > I started playing with -blockdev: added new blockdev for blkreplay and
> > constructed the following command line:
> >
> > -blockdev driver=file,filename=disk.img,node-name=hd0
> > -blockdev driver=blkreplay,file=hd0,node-name=hd0-rr
> > -device virtio-blk-device,drive=hd0-rr
> >
> > However, I get an error: "Could not open 'disk.img': Permission denied"
> > Everything works when I use this file in '-drive' parameter.
> > What am I doing wrong?
> 
> The reason why I didn't reply immediately is because I don't see
> anything wrong in the options you used.
> 
> Just to confirm, do you still get the same error when you use only the
> first -blockdev option and no other options at all?

Ok, I tried again and got different error, which was caused by incorrect
QAPI schema for blkreplay.
Now it seems ok, but I still can't boot.

> I've now tried out the options you gave, and it does fail for me, but
> with a different error:
> 
>     qemu-system-x86_64: -blockdev driver=blkreplay,file=hd0,node-name=hd0-rr: Invalid
> parameter 'blkreplay'
> 
> This one is because the QAPI schema doesn't know blkreplay and should
> easily be fixed by adding a blkreplay field to BlockdevOptions.

Right, I added the following schema:

--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2832,8 +2832,8 @@
 # Since: 2.9
 ##
 { 'enum': 'BlockdevDriver',
-  'data': [ 'blkdebug', 'blklogwrites', 'blkverify', 'bochs', 'cloop',
-            'copy-on-read', 'dmg', 'file', 'ftp', 'ftps', 'gluster',
+  'data': [ 'blkdebug', 'blklogwrites', 'blkreplay', 'blkverify', 'bochs',
+            'cloop', 'copy-on-read', 'dmg', 'file', 'ftp', 'ftps', 'gluster',
             'host_cdrom', 'host_device', 'http', 'https', 'iscsi', 'luks',
             'nbd', 'nfs', 'null-aio', 'null-co', 'nvme', 'parallels', 'qcow',
             'qcow2', 'qed', 'quorum', 'raw', 'rbd',
@@ -3446,6 +3446,18 @@
   'data': { 'test': 'BlockdevRef',
             'raw': 'BlockdevRef' } }
 
+##
+# @BlockdevOptionsBlkreplay:
+#
+# Driver specific block device options for blkreplay.
+#
+# @image:     disk image which should be controlled with blkreplay
+#
+# Since: 4.2
+##
+{ 'struct': 'BlockdevOptionsBlkreplay',
+  'data': { 'image': 'BlockdevRef' } }
+
 ##
 # @QuorumReadPattern:
 #
@@ -3973,6 +3985,7 @@
       'blkdebug':   'BlockdevOptionsBlkdebug',
       'blklogwrites':'BlockdevOptionsBlklogwrites',
       'blkverify':  'BlockdevOptionsBlkverify',
+      'blkreplay':  'BlockdevOptionsBlkreplay',
       'bochs':      'BlockdevOptionsGenericFormat',
       'cloop':      'BlockdevOptionsGenericFormat',
       'copy-on-read':'BlockdevOptionsGenericFormat',

> As soft freeze is coming closer, I'm considering taking this series as
> it is (it's wrong in parts, but the old state is probably even more
> wrong) and letting you fix up these checks on top. What do you think?

That sounds reasonable.

Pavel Dovgalyuk


