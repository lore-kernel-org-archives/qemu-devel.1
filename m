Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75DF5C11D3D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 15:41:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C33524697
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 15:41:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C33524697
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7LIG-0003xP-CU
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 10:41:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60501)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1j7LHM-00035d-O9
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 10:40:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1j7LHL-00037C-6X
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 10:40:48 -0500
Received: from indium.canonical.com ([91.189.90.7]:38258)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1j7LHL-00036u-0u
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 10:40:47 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1j7LHJ-0003yx-Oh
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 15:40:45 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 92C592E80D1
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 15:40:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Feb 2020 15:33:56 -0000
From: Olaf Seibert <1865048@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: oseibert-sys11
X-Launchpad-Bug-Reporter: Olaf Seibert (oseibert-sys11)
X-Launchpad-Bug-Modifier: Olaf Seibert (oseibert-sys11)
Message-Id: <158281763694.13572.4793000469968260846.malonedeb@gac.canonical.com>
Subject: [Bug 1865048] [NEW] qemu-img --force-share does not disable file
 locking
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="9eff1c37c1740693bdcba94d8f8c608164af5689";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 06a78918ce62722dea9fc1b63d29d874428c5695
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1865048 <1865048@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

The new option "--force-share" for qemu-img does not disable file
locking.

I tried it with version qemu-img version 2.11.1(Debian 1:2.11+dfsg-
1ubuntu7.21~cloud0) and I traced the source code of the current git
trunk.

Sample to demonstrate:

# strace qemu-img info --force-share testfile.qcow2   2>&1 | grep F_RDLCK
fcntl(11, F_OFD_SETLK, {l_type=3DF_RDLCK, l_whence=3DSEEK_SET, l_start=3D10=
0, l_len=3D1}) =3D 0
fcntl(11, F_OFD_SETLK, {l_type=3DF_RDLCK, l_whence=3DSEEK_SET, l_start=3D10=
0, l_len=3D1}) =3D 0
fcntl(11, F_OFD_SETLK, {l_type=3DF_RDLCK, l_whence=3DSEEK_SET, l_start=3D10=
0, l_len=3D1}) =3D 0
fcntl(11, F_OFD_SETLK, {l_type=3DF_RDLCK, l_whence=3DSEEK_SET, l_start=3D10=
0, l_len=3D1}) =3D 0
fcntl(11, F_OFD_SETLK, {l_type=3DF_RDLCK, l_whence=3DSEEK_SET, l_start=3D10=
0, l_len=3D1}) =3D 0
fcntl(11, F_OFD_SETLK, {l_type=3DF_RDLCK, l_whence=3DSEEK_SET, l_start=3D10=
0, l_len=3D1}) =3D 0
fcntl(11, F_OFD_SETLK, {l_type=3DF_RDLCK, l_whence=3DSEEK_SET, l_start=3D10=
0, l_len=3D1}) =3D 0
fcntl(11, F_OFD_SETLK, {l_type=3DF_RDLCK, l_whence=3DSEEK_SET, l_start=3D10=
0, l_len=3D1}) =3D 0
fcntl(11, F_OFD_SETLK, {l_type=3DF_RDLCK, l_whence=3DSEEK_SET, l_start=3D10=
0, l_len=3D1}) =3D 0

I traced the passing of the --force-share option through the source code
(I used commit 6c599282f8 as of Mon Feb 17 13:32:25 2020 +0000)

qemu-img.c:img_info()
        force_share =3D true;
qemu-img.c:collect_image_info_list(force_share)
qemu-img.c:img_open(force_share)
qemu-img.c:img_open_file(force_share)
        qdict_put_bool(options, BDRV_OPT_FORCE_SHARE, true);
block/block-backend.c:blk_new_open(options)
block.c:bdrv_open(options)
block.c:bdrv_open_inheritoptions()
block.c:bdrv_open_common(options)
        bs->force_share =3D qemu_opt_get_bool(opts, BDRV_OPT_FORCE_SHARE, f=
alse);
block.c:bdrv_open_driver(bs)
include/block/block_int.h:int (*bdrv_file_open)(BlockDriverState *bs, QDict=
 *options, int flags,
block/file-posix.c:.bdrv_file_open =3D raw_open,
block/file-posix.c:raw_open_common(bs)
        locking =3D qapi_enum_parse(&OnOffAuto_lookup,
                              qemu_opt_get(opts, "locking"),
                              ON_OFF_AUTO_AUTO, &local_err);
        ignoring bs->force_share

At the end, bs->force_share is ignored in determining the locking value.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1865048

Title:
  qemu-img --force-share does not disable file locking

Status in QEMU:
  New

Bug description:
  The new option "--force-share" for qemu-img does not disable file
  locking.

  I tried it with version qemu-img version 2.11.1(Debian 1:2.11+dfsg-
  1ubuntu7.21~cloud0) and I traced the source code of the current git
  trunk.

  Sample to demonstrate:

  # strace qemu-img info --force-share testfile.qcow2   2>&1 | grep F_RDLCK
  fcntl(11, F_OFD_SETLK, {l_type=3DF_RDLCK, l_whence=3DSEEK_SET, l_start=3D=
100, l_len=3D1}) =3D 0
  fcntl(11, F_OFD_SETLK, {l_type=3DF_RDLCK, l_whence=3DSEEK_SET, l_start=3D=
100, l_len=3D1}) =3D 0
  fcntl(11, F_OFD_SETLK, {l_type=3DF_RDLCK, l_whence=3DSEEK_SET, l_start=3D=
100, l_len=3D1}) =3D 0
  fcntl(11, F_OFD_SETLK, {l_type=3DF_RDLCK, l_whence=3DSEEK_SET, l_start=3D=
100, l_len=3D1}) =3D 0
  fcntl(11, F_OFD_SETLK, {l_type=3DF_RDLCK, l_whence=3DSEEK_SET, l_start=3D=
100, l_len=3D1}) =3D 0
  fcntl(11, F_OFD_SETLK, {l_type=3DF_RDLCK, l_whence=3DSEEK_SET, l_start=3D=
100, l_len=3D1}) =3D 0
  fcntl(11, F_OFD_SETLK, {l_type=3DF_RDLCK, l_whence=3DSEEK_SET, l_start=3D=
100, l_len=3D1}) =3D 0
  fcntl(11, F_OFD_SETLK, {l_type=3DF_RDLCK, l_whence=3DSEEK_SET, l_start=3D=
100, l_len=3D1}) =3D 0
  fcntl(11, F_OFD_SETLK, {l_type=3DF_RDLCK, l_whence=3DSEEK_SET, l_start=3D=
100, l_len=3D1}) =3D 0

  I traced the passing of the --force-share option through the source
  code (I used commit 6c599282f8 as of Mon Feb 17 13:32:25 2020 +0000)

  qemu-img.c:img_info()
          force_share =3D true;
  qemu-img.c:collect_image_info_list(force_share)
  qemu-img.c:img_open(force_share)
  qemu-img.c:img_open_file(force_share)
          qdict_put_bool(options, BDRV_OPT_FORCE_SHARE, true);
  block/block-backend.c:blk_new_open(options)
  block.c:bdrv_open(options)
  block.c:bdrv_open_inheritoptions()
  block.c:bdrv_open_common(options)
          bs->force_share =3D qemu_opt_get_bool(opts, BDRV_OPT_FORCE_SHARE,=
 false);
  block.c:bdrv_open_driver(bs)
  include/block/block_int.h:int (*bdrv_file_open)(BlockDriverState *bs, QDi=
ct *options, int flags,
  block/file-posix.c:.bdrv_file_open =3D raw_open,
  block/file-posix.c:raw_open_common(bs)
          locking =3D qapi_enum_parse(&OnOffAuto_lookup,
                                qemu_opt_get(opts, "locking"),
                                ON_OFF_AUTO_AUTO, &local_err);
          ignoring bs->force_share

  At the end, bs->force_share is ignored in determining the locking
  value.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1865048/+subscriptions

