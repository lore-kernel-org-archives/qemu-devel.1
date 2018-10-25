Received: from eggs.gnu.org ([2001:4830:134:3::10]:60732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gFcad-0006bc-BK
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 06:10:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gFcMa-00060f-7L
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 05:55:41 -0400
Received: from indium.canonical.com ([91.189.90.7]:37044)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gFcMY-0005z1-Fq
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 05:55:34 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gFcMV-0005OP-Dn
	for <qemu-devel@nongnu.org>; Thu, 25 Oct 2018 09:55:31 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 640752E8052
	for <qemu-devel@nongnu.org>; Thu, 25 Oct 2018 09:55:31 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Oct 2018 09:47:41 -0000
From: =?utf-8?b?SGlib3U1N8KgKFlhbm5pY2vCoER1Y2jDqm5lKQ==?=
	<yannick_duchene@yahoo.fr>
Reply-To: Bug 1799919 <1799919@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <154046086166.20410.16328785764794651694.malonedeb@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1799919] [NEW] IDE HDD emulation random
 read/write errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

I unfortunately can=E2=80=99t give more tracks other than how to reproduce =
the
bug, especially that the bug occurs randomly.

Basically, I=E2=80=99m trying to install DOS 6.22 on an emulated ISA machin=
e,
and it fails, DOS complaining about read or write error on drive C.
Repeating the operation multiple time, I see it occurs at random stage,
sometime even before it partitions the drive, sometime when it formats
the drive, sometime when it copies the files from the floppy to the
drive.

To test it, unpack the attached archive and execute `./run` from the
extracted directory. The archive contains three raw floppy images for
installing DOS 6.22, and a Bourne Shell script which invokes QEmu. Just
press enter at any installation stage, the bug may occurs at any stage.

I tried with `cache=3Dnone` to be sure it=E2=80=99s not a cache issue, but =
its the
same whatever the cache policy is.

Version and environment: using QEmu 3.0 on Ubuntu 16.04 on a 32 bits
DELL Inspiron 9400 (not an emulation, that=E2=80=99s my real laptop).

For why I=E2=80=99m using QEmu for this: the installation proceeds with not
error in VirtualBox, but I wanted to use QEmu to have a serial mouse
which is not available with QEmu and to have finer control over the
machine configuration ; VirtualBox although good, is more limited in
that regard.

** Affects: qemu
     Importance: Undecided
         Status: New

** Attachment added: "Material to reproduce the bug"
   https://bugs.launchpad.net/bugs/1799919/+attachment/5205307/+files/bug.t=
ar.xz

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1799919

Title:
  IDE HDD emulation random read/write errors

Status in QEMU:
  New

Bug description:
  I unfortunately can=E2=80=99t give more tracks other than how to reproduc=
e the
  bug, especially that the bug occurs randomly.

  Basically, I=E2=80=99m trying to install DOS 6.22 on an emulated ISA mach=
ine,
  and it fails, DOS complaining about read or write error on drive C.
  Repeating the operation multiple time, I see it occurs at random
  stage, sometime even before it partitions the drive, sometime when it
  formats the drive, sometime when it copies the files from the floppy
  to the drive.

  To test it, unpack the attached archive and execute `./run` from the
  extracted directory. The archive contains three raw floppy images for
  installing DOS 6.22, and a Bourne Shell script which invokes QEmu.
  Just press enter at any installation stage, the bug may occurs at any
  stage.

  I tried with `cache=3Dnone` to be sure it=E2=80=99s not a cache issue, bu=
t its
  the same whatever the cache policy is.

  Version and environment: using QEmu 3.0 on Ubuntu 16.04 on a 32 bits
  DELL Inspiron 9400 (not an emulation, that=E2=80=99s my real laptop).

  For why I=E2=80=99m using QEmu for this: the installation proceeds with n=
ot
  error in VirtualBox, but I wanted to use QEmu to have a serial mouse
  which is not available with QEmu and to have finer control over the
  machine configuration ; VirtualBox although good, is more limited in
  that regard.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1799919/+subscriptions
