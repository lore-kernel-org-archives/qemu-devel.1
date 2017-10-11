Received: from eggs.gnu.org ([2001:4830:134:3::10]:43832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e2EXF-0007p8-U7
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 06:46:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e2EXA-0007GM-7P
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 06:46:45 -0400
Received: from indium.canonical.com ([91.189.90.7]:50554)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e2EXA-0007Ep-0K
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 06:46:40 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e2EX7-0003M2-3U
	for <qemu-devel@nongnu.org>; Wed, 11 Oct 2017 10:46:37 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id D6CAB2E80D8
	for <qemu-devel@nongnu.org>; Wed, 11 Oct 2017 10:46:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Oct 2017 10:30:55 -0000
From: R Naveen Kumar <raju.naveenkumar.s@gmail.com>
Reply-To: Bug 1719870 <1719870@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150651491208.6275.5437921155583182268.malonedeb@soybean.canonical.com>
Message-Id: <150771785579.15429.7236243943711348750.malone@soybean.canonical.com>
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

Bug is reproducible with setting VHDX Fixed Logicalsectorsize to 4096bytes
>10G image created reflects as 1.2G virtual size in Qemu-img
PS F:\> new-vhd -path test.vhdx -BlockSizeBytes 134217728 -SizeBytes 107374=
18240 -Fixed -LogicalSectorSizeBytes 4096
ComputerName            : XXXX
Path                    : F:\test.vhdx
VhdFormat               : VHDX
VhdType                 : Fixed
FileSize                : 10741612544
Size                    : 10737418240
MinimumSize             :
LogicalSectorSize       : 4096
PhysicalSectorSize      : 4096
BlockSize               : 0
ParentPath              :
DiskIdentifier          : dfa84293-86f2-4ddf-aaff-14c04dae5df9
FragmentationPercentage : 0
Alignment               : 1
Attached                : False
DiskNumber              :
Key                     :
IsDeleted               : False
Number                  :
PS F:\> C:\temp\qemu-img\qemu-img.exe info .\test.vhdx
image: .\test.vhdx
file format: vhdx
virtual size: 1.2G (1342177280 bytes)
disk size: 10G
cluster_size: 134217728

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
