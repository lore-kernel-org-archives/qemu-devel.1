Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE3AC38A24
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 15:23:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9842207DD
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 15:23:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9842207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWiNP-0006hn-T3
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 11:23:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43652)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jWhXu-0007tk-Ut
 for qemu-devel@nongnu.org; Thu, 07 May 2020 10:30:42 -0400
Received: from indium.canonical.com ([91.189.90.7]:55628)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jWhXt-0000XR-Qs
 for qemu-devel@nongnu.org; Thu, 07 May 2020 10:30:42 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jWhXr-00057T-Cr
 for <qemu-devel@nongnu.org>; Thu, 07 May 2020 14:30:39 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 47B5C2E8106
 for <qemu-devel@nongnu.org>; Thu,  7 May 2020 14:30:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 07 May 2020 14:17:02 -0000
From: Fishface60 <richard.maw@gmail.com>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: richard-maw
X-Launchpad-Bug-Reporter: Fishface60 (richard-maw)
X-Launchpad-Bug-Modifier: Fishface60 (richard-maw)
Message-Id: <158886102295.5250.16201751310283363946.malonedeb@chaenomeles.canonical.com>
Subject: [Bug 1877384] [NEW] 9pfs file create with mapped-xattr can fail on
 overlayfs
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="fbdff7602bd10fb883bf7e2ddcc7fd5a16f60398";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: df1808d04f00aed0ea81bd9b188437c590e32478
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 10:30:40
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -55
X-Spam_score: -5.6
X-Spam_bar: -----
X-Spam_report: (-5.6 / 5.0 requ) BAYES_00=-1.9, DKIM_ADSP_CUSTOM_MED=0.001,
 FORGED_GMAIL_RCVD=1, FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 07 May 2020 11:22:47 -0400
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
Reply-To: Bug 1877384 <1877384@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

QEMU Version: 3.1.0 as packaged in debian buster, but the code appears to d=
o the same in master.
qemu command-line: qemu-system-x86_64 -m 1G -nographic -nic "user,model=3Dv=
irtio-net-pci,tftp=3D$(pwd),net=3D10.0.2.0/24,host=3D10.0.2.2" -fsdev local=
,id=3Dfs,path=3D$thisdir/..,security_model=3Dmapped-xattr -device virtio-9p=
-pci,fsdev=3Dfs,mount_tag=3Dfs -drive "file=3D$rootdisk,if=3Dvirtio,format=
=3Draw" -kernel "$kernel" -initrd "$initrd" -append "$append"


I'm using CI that runs in a Docker container and runs a qemu VM with code a=
nd results shared via virtio 9p.
The 9p fsdev is configured with security_model=3Dmapped-xattr
When the test code attempts to create a log file in an existing directory, =
open with O_CREAT fails with -ENOENT.

The relevant strace excerpt is:

28791 openat(11, ".", O_RDONLY|O_NOFOLLOW|O_PATH|O_DIRECTORY) =3D 20
28791 openat(20, "src", O_RDONLY|O_NOCTTY|O_NONBLOCK|O_NOFOLLOW|O_DIRECTORY=
) =3D 21
28791 fcntl(21, F_SETFL, O_RDONLY|O_DIRECTORY) =3D 0
28791 close(20)                         =3D 0
28791 openat(21, "client.log", O_WRONLY|O_CREAT|O_NOCTTY|O_NONBLOCK|O_NOFOL=
LOW, 0600) =3D 20
28791 fcntl(20, F_SETFL, O_WRONLY|O_CREAT|O_NONBLOCK|O_NOFOLLOW) =3D 0
28791 lsetxattr("/proc/self/fd/21/client.log", "user.virtfs.uid", "\0\0\0",=
 4, 0) =3D -1 ENOENT (No such file or directory)

My hypothesis for what's going wrong is since the Docker container's
overlayfs copies-up on writes, when it opens the file it's created a new
version of the `src` directory containing a `client.log`, but this new
src directory isn't accessible by file descriptor 20 and the lsetxattr
call is instead attempting to set attributes on the path in the old
`src` directory.

Looking at the code, a fix would be to change `hw/9pfs/9p-local.c` and
change `local_open2` to instead of calling `local_set_xattrat` to set
the xattrs by directory file descriptor and file name, to have a version
of local_set_xattrat` which uses `fsetxattr` to set the virtfs
attributes instead of the `fsetxattrat_nofollow` helper.

This reliably happened for me in CI, but I don't have access to the CI
host or the time to strip the test down to make a minimal test case, and
had difficulty reproducing the error on other machines.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1877384

Title:
  9pfs file create with mapped-xattr can fail on overlayfs

Status in QEMU:
  New

Bug description:
  QEMU Version: 3.1.0 as packaged in debian buster, but the code appears to=
 do the same in master.
  qemu command-line: qemu-system-x86_64 -m 1G -nographic -nic "user,model=
=3Dvirtio-net-pci,tftp=3D$(pwd),net=3D10.0.2.0/24,host=3D10.0.2.2" -fsdev l=
ocal,id=3Dfs,path=3D$thisdir/..,security_model=3Dmapped-xattr -device virti=
o-9p-pci,fsdev=3Dfs,mount_tag=3Dfs -drive "file=3D$rootdisk,if=3Dvirtio,for=
mat=3Draw" -kernel "$kernel" -initrd "$initrd" -append "$append"

  =

  I'm using CI that runs in a Docker container and runs a qemu VM with code=
 and results shared via virtio 9p.
  The 9p fsdev is configured with security_model=3Dmapped-xattr
  When the test code attempts to create a log file in an existing directory=
, open with O_CREAT fails with -ENOENT.

  The relevant strace excerpt is:

  28791 openat(11, ".", O_RDONLY|O_NOFOLLOW|O_PATH|O_DIRECTORY) =3D 20
  28791 openat(20, "src", O_RDONLY|O_NOCTTY|O_NONBLOCK|O_NOFOLLOW|O_DIRECTO=
RY) =3D 21
  28791 fcntl(21, F_SETFL, O_RDONLY|O_DIRECTORY) =3D 0
  28791 close(20)                         =3D 0
  28791 openat(21, "client.log", O_WRONLY|O_CREAT|O_NOCTTY|O_NONBLOCK|O_NOF=
OLLOW, 0600) =3D 20
  28791 fcntl(20, F_SETFL, O_WRONLY|O_CREAT|O_NONBLOCK|O_NOFOLLOW) =3D 0
  28791 lsetxattr("/proc/self/fd/21/client.log", "user.virtfs.uid", "\0\0\0=
", 4, 0) =3D -1 ENOENT (No such file or directory)

  My hypothesis for what's going wrong is since the Docker container's
  overlayfs copies-up on writes, when it opens the file it's created a
  new version of the `src` directory containing a `client.log`, but this
  new src directory isn't accessible by file descriptor 20 and the
  lsetxattr call is instead attempting to set attributes on the path in
  the old `src` directory.

  Looking at the code, a fix would be to change `hw/9pfs/9p-local.c` and
  change `local_open2` to instead of calling `local_set_xattrat` to set
  the xattrs by directory file descriptor and file name, to have a
  version of local_set_xattrat` which uses `fsetxattr` to set the virtfs
  attributes instead of the `fsetxattrat_nofollow` helper.

  This reliably happened for me in CI, but I don't have access to the CI
  host or the time to strip the test down to make a minimal test case,
  and had difficulty reproducing the error on other machines.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1877384/+subscriptions

