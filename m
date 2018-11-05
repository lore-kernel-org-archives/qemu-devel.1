Received: from eggs.gnu.org ([2001:4830:134:3::10]:50863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gJacN-0004rP-43
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 03:52:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gJaN0-0002ZZ-3F
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 03:36:34 -0500
Received: from indium.canonical.com ([91.189.90.7]:56890)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gJaMr-0001Iq-Tw
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 03:36:22 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gJaMo-0005PZ-JR
	for <qemu-devel@nongnu.org>; Mon, 05 Nov 2018 08:36:14 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 91F042E8079
	for <qemu-devel@nongnu.org>; Mon,  5 Nov 2018 08:36:14 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Nov 2018 08:28:57 -0000
From: Frank Heimes <1801674@bugs.launchpad.net>
Reply-To: Bug 1801674 <1801674@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154140596861.29232.16478222334275868563.malonedeb@soybean.canonical.com>
Message-Id: <154140653789.20342.16098994417567459339.launchpad@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1801674] Re: Ubuntu16.04 LTS - PCI Pass Through
 in Ubuntu KVM 16.04.x must use QEMU with DDW support from PPA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Also affects: qemu
   Importance: Undecided
       Status: New

** No longer affects: qemu

** Also affects: ubuntu-power-systems
   Importance: Undecided
       Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1801674

Title:
  Ubuntu16.04 LTS - PCI Pass Through in Ubuntu KVM 16.04.x must use QEMU
  with DDW support from PPA

Status in The Ubuntu-power-systems project:
  New
Status in qemu package in Ubuntu:
  New

Bug description:
  =3D=3D Comment: #0 - Siraj M. Ismail <siraji@us.ibm.com> - 2016-10-05 11:=
35:38 =3D=3D
  ---Problem Description---

  Customer running PCI pass through with 16.04.1 KVM and with the stock QEM=
U packages will hit a DI if they do not update to the QEMU packages with DD=
W support. The packages are in PPA for customers to download, and test has =
verified the fix. The details are in Bugzilla 144123. =

   =

  ---uname output---
  Ubuntu 16.04.1 with 4.4.0 Kernel
   =

  Machine Type =3D 8247-22L =

   =

  ---Debugger---
  A debugger is not configured
   =

  ---Steps to Reproduce---
   Run guest with adapters assigned via PCI PT, The guest will start having=
 DI issues as soon as I/O started on the Pass Through adapter. =

   =

  Contact Information =3D siraji@us.ibm.com =

   =

  ---Patches Installed---
  QEMU was updated from 2.5 version to 2.6.1 with patches for DDW support, =
can be found at PPA location : =

  https://launchpad.net/~ibmpackages/+archive/ubuntu/ddw
   =

  Userspace tool common name: QEMU =

   =

  Documentation version: N/A =

   =

  The userspace tool has the following bit modes: N/A =


  Userspace rpm: N/A

  Userspace tool obtained from project website:  na =

   =

  *Additional Instructions for siraji@us.ibm.com: =

  -Post a private note with access information to the machine that the bug =
is occuring on.
  -Attach ltrace and strace of userspace application.

  =3D=3D Comment: #5 - Leonardo Augusto Guimaraes Garcia <lagarcia@br.ibm.c=
om> - 2017-04-25 16:23:57 =3D=3D
  I would rephrase to:

  -------------------------------

  Under KVM recommendations

  PCI passthrough recommendations

  If you are running PCI passthrough with 16.04.x KVM and with the stock
  QEMU package, update to the QEMU package that have DDW support. If you
  do not update the package, you will hit data integrity issues as soon
  as I/O is started on the adapter.

  The package is available at:
  https://launchpad.net/~ibmpackages/+archive/ubuntu/ddw

  -------------------------------

To manage notifications about this bug go to:
https://bugs.launchpad.net/ubuntu-power-systems/+bug/1801674/+subscriptions
