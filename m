Received: from eggs.gnu.org ([2001:4830:134:3::10]:39292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1exeFM-0005wY-7m
	for qemu-devel@nongnu.org; Sun, 18 Mar 2018 15:45:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1exeFJ-0001bE-3g
	for qemu-devel@nongnu.org; Sun, 18 Mar 2018 15:45:36 -0400
Received: from indium.canonical.com ([91.189.90.7]:60906)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1exeFI-0001b3-Tu
	for qemu-devel@nongnu.org; Sun, 18 Mar 2018 15:45:33 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1exeFH-00013b-Tb
	for <qemu-devel@nongnu.org>; Sun, 18 Mar 2018 19:45:31 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id B2F982E80CC
	for <qemu-devel@nongnu.org>; Sun, 18 Mar 2018 19:45:31 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Mar 2018 19:39:37 -0000
From: Alexandre ARNOUD <1756728@bugs.launchpad.net>
Reply-To: Bug 1756728 <1756728@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152140081522.14638.12473231561144635050.malonedeb@chaenomeles.canonical.com>
Message-Id: <152140197779.3113.10495323457987382035.launchpad@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1756728] Re: virtio-scsi virtio-scsi-single and
 virtio-blk on raw image, games are not starting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Description changed:

- Using virtio-scsi / vitro-scsi-sing and vitro-blk on a ZFS/raw image,
+ Using virtio-scsi / vitro-scsi-single or vitro-blk on a ZFS/raw image,
  most Assassin's Creed (Origin especially) games are not starting
  (uPlay), it seems related to some check or commands applications are
  doing on the disk drive that fails to respond.
  =

  Workaround has been found by creating a VHD volume, mounting it and
  installing games on it.
  =

  On a side note, application like HDDScan, CrystalDiskInfo returns
  nothing regarding disk drives.
  =

  Guest:
- Windows 10 (build 1709) =

+ Windows 10 (build 1709)
  =

  Host:
  $ kvm --version
  QEMU emulator version 2.9.1 pve-qemu-kvm_2.9.1-9
  $ uname -a
  Linux xxxx 4.13.13-5-pve #1 SMP PVE 4.13.13-36 (Mon, 15 Jan 2018 12:36:49=
 +0100) x86_64 GNU/Linux

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1756728

Title:
  virtio-scsi virtio-scsi-single and virtio-blk on raw image, games are
  not starting

Status in QEMU:
  New

Bug description:
  Using virtio-scsi / vitro-scsi-single or vitro-blk on a ZFS/raw image,
  most Assassin's Creed (Origin especially) games are not starting
  (uPlay), it seems related to some check or commands applications are
  doing on the disk drive that fails to respond.

  Workaround has been found by creating a VHD volume, mounting it and
  installing games on it.

  On a side note, application like HDDScan, CrystalDiskInfo returns
  nothing regarding disk drives.

  Guest:
  Windows 10 (build 1709)

  Host:
  $ kvm --version
  QEMU emulator version 2.9.1 pve-qemu-kvm_2.9.1-9
  $ uname -a
  Linux xxxx 4.13.13-5-pve #1 SMP PVE 4.13.13-36 (Mon, 15 Jan 2018 12:36:49=
 +0100) x86_64 GNU/Linux

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1756728/+subscriptions
