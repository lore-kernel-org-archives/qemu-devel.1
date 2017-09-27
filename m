Received: from eggs.gnu.org ([2001:4830:134:3::10]:47523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dxEvm-00024O-Jz
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 12:11:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dxEvh-0003qa-KU
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 12:11:26 -0400
Received: from indium.canonical.com ([91.189.90.7]:53682)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dxEvh-0003q1-Co
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 12:11:21 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1dxEve-00061Q-Kg
	for <qemu-devel@nongnu.org>; Wed, 27 Sep 2017 16:11:18 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 928102E8490
	for <qemu-devel@nongnu.org>; Wed, 27 Sep 2017 16:11:18 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 Sep 2017 16:03:46 -0000
From: R Naveen Kumar <raju.naveenkumar.s@gmail.com>
Reply-To: Bug 1719870 <1719870@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150651491208.6275.5437921155583182268.malonedeb@soybean.canonical.com>
Message-Id: <150652822713.6013.15351949598650883048.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1719870] Re: Converting 100G VHDX fixed image to
 QCOW2 fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

PS > Get-VHD .\VM.vhdx
ComputerName            : Server1
Path                    : \VM.vhdx
VhdFormat               : VHDX
VhdType                 : Fixed
FileSize                : 107378376704
Size                    : 107374182400
MinimumSize             : 107374182400
LogicalSectorSize       : 4096
PhysicalSectorSize      : 4096
BlockSize               : 0
ParentPath              :
DiskIdentifier          : 53fd4aa7-562e-4bed-bc1c-2db71222e07e
FragmentationPercentage : 0
Alignment               : 1
Attached                : False
DiskNumber              :
Key                     :
IsDeleted               : False
Number                  :
PS > & 'C:\Program Files\qemu\qemu-img.exe' convert -O qcow2 .\VM.vhdx .\VM=
.qcow2
Assertion failed!
Program: C:\Program Files\qemu\qemu-img.exe
File: /home/stefan/src/qemu/repo.or.cz/qemu/ar7/block/io.c, Line 1034
Expression: !qiov || bytes =3D=3D qiov->size
PS > & 'C:\Program Files\qemu\qemu-img.exe' info .\VM.qcow2
image: .\VM.qcow2
file format: qcow2
virtual size: 13G (13421772800 bytes)
disk size: 1.4G
cluster_size: 65536
Format specific information:
    compat: 1.1
    lazy refcounts: false
    refcount bits: 16
    corrupt: false

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1719870

Title:
  Converting 100G VHDX fixed image to QCOW2 fails

Status in QEMU:
  New

Bug description:
  Virtual Size recognized incorrectly for VHDX fixed disk and conversion
  fails with error Expression: !qiov || bytes =3D=3D qiov->size


  PS > & 'C:\Program Files\qemu\qemu-img.exe' --version
  qemu-img version 2.10.0 (v2.10.0-11669-g579e69bd5b-dirty)
  Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1719870/+subscriptions
