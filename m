Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3012FC2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 13:46:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 053B621741
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 13:46:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 053B621741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izhUQ-0000zx-6Z
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 08:46:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34270)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1izhTe-0000Dq-EL
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 08:45:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1izhTc-000125-TW
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 08:45:54 -0500
Received: from indium.canonical.com ([91.189.90.7]:58958)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1izhTc-0000v8-NB
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 08:45:52 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1izhTa-0005pf-D8
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 13:45:50 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 200AF2E80CE
 for <qemu-devel@nongnu.org>; Thu,  6 Feb 2020 13:45:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Feb 2020 13:34:48 -0000
From: Philippe Vaucher <philippe.vaucher@gmail.com>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: linux-user syscall-abi
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: dflogeras2 liuke marcin-konarski+u1
 philippe-vaucher pmaydell schneiderit
X-Launchpad-Bug-Reporter: Kan Li (liuke)
X-Launchpad-Bug-Modifier: Philippe Vaucher (philippe-vaucher)
References: <154353638253.10384.17899256838547579767.malonedeb@chaenomeles.canonical.com>
Message-Id: <158099608820.30510.13310001336699880559.malone@gac.canonical.com>
Subject: [Bug 1805913] Re: readdir() returns NULL (errno=EOVERFLOW) for 32-bit
 user-static qemu on 64-bit host
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="0a62c17273454a1313f81a74a2198ec30b44c7b6";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 16d1d20ecba31107299f3347971a779b1f651ce0
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
Reply-To: Bug 1805913 <1805913@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thanks Marcin. I tested your solution but by me it still gets stuck at
the same point. Here's what I did:

$ tune2fs -O ^dir_index /dev/sda1
$ tune2fs -l /dev/sda1
tune2fs 1.44.2 (14-May-2018)
Filesystem volume name:   <none>
Last mounted on:          /
Filesystem UUID:          c8fee0cb-a610-4fa5-aab8-c5c765678133
Filesystem magic number:  0xEF53
Filesystem revision #:    1 (dynamic)
Filesystem features:      has_journal ext_attr resize_inode filetype needs_=
recovery extent 64bit flex_bg sparse_super large_file huge_file dir_nlink e=
xtra_isize metadata_csum
Filesystem flags:         signed_directory_hash =

Default mount options:    user_xattr acl
Filesystem state:         clean
(snip)

But then my build still get stuck on:

clock_gettime(CLOCK_REALTIME, {tv_sec=3D1580996038, tv_nsec=3D781126598}) =
=3D 0
getdents64(5, /* 0 entries */, 2048)    =3D 0
lseek(5, 0, SEEK_SET)                   =3D 0
getdents64(5, /* 5 entries */, 2048)    =3D 144
tgkill(29974, 29977, SIGRT_2)           =3D -1 EAGAIN (Resource temporarily=
 unavailable)
clock_gettime(CLOCK_REALTIME, {tv_sec=3D1580996038, tv_nsec=3D781461434}) =
=3D 0
getdents64(5, /* 0 entries */, 2048)    =3D 0
lseek(5, 0, SEEK_SET)                   =3D 0
getdents64(5, /* 5 entries */, 2048)    =3D 144
tgkill(29974, 29977, SIGRT_2)           =3D -1 EAGAIN (Resource temporarily=
 unavailable

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1805913

Title:
  readdir() returns NULL (errno=3DEOVERFLOW) for 32-bit user-static qemu
  on 64-bit host

Status in QEMU:
  New

Bug description:
  This can be simply reproduced by compiling and running the attached C
  code (readdir-bug.c) under 32-bit user-static qemu, such as qemu-arm-
  static:

  # Setup docker for user-static binfmt
  docker run --rm --privileged multiarch/qemu-user-static:register --reset
  # Compile the code and run (readdir for / is fine, so create a new direct=
ory /test).
  docker run -v /path/to/qemu-arm-static:/usr/bin/qemu-arm-static -v /path/=
to/readdir-bug.c:/tmp/readdir-bug.c -it --rm arm32v7/ubuntu:18.10 bash -c '=
{ apt update && apt install -y gcc; } >&/dev/null && mkdir -p /test && cd /=
test && gcc /tmp/readdir-bug.c && ./a.out'
  dir=3D0xff5b4150
  readdir(dir)=3D(nil)
  errno=3D75: Value too large for defined data type

  Do remember to replace the /path/to/qemu-arm-static and /path/to
  /readdir-bug.c to the actual paths of the files.

  The root cause is in glibc:
  https://sourceware.org/git/?p=3Dglibc.git;a=3Dblob;f=3Dsysdeps/unix/sysv/=
linux/getdents.c;h=3D6d09a5be7057e2792be9150d3a2c7b293cf6fc34;hb=3Da5275ba5=
378c9256d18e582572b4315e8edfcbfb#l87

  By C standard, the return type of readdir() is DIR*, in which the
  inode number and offset are 32-bit integers, therefore, glibc calls
  getdents64() and check if the inode number and offset fits the 32-bit
  range, and reports EOVERFLOW if not.

  The problem here is for 32-bit user-static qemu running on 64-bit
  host, getdents64 simply passing through the inode number and offset
  from underlying getdents64 syscall (from 64-bit kernel), which is very
  likely to not fit into 32-bit range. On real hardware, the 32-bit
  kernel creates 32-bit inode numbers, therefore works properly.

  The glibc code makes sense to do the check to be conformant with C
  standard, therefore ideally it should be a fix on qemu side. I admit
  this is difficult because qemu has to maintain a mapping between
  underlying 64-bit inode numbers and 32-bit inode numbers, which would
  severely hurt the performance. I don't expect this could be fix
  anytime soon (or even there would be a fix), but it would be
  worthwhile to surface this issue.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1805913/+subscriptions

