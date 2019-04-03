Received: from eggs.gnu.org ([209.51.188.92]:36617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hBet9-0001od-Jk
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 08:21:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hBet8-0006SL-Ce
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 08:21:07 -0400
Received: from indium.canonical.com ([91.189.90.7]:56986)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hBet7-0006Ol-7K
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 08:21:05 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hBet3-0001bs-IR
	for <qemu-devel@nongnu.org>; Wed, 03 Apr 2019 12:21:01 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 860C12E8060
	for <qemu-devel@nongnu.org>; Wed,  3 Apr 2019 12:21:01 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Apr 2019 12:09:34 -0000
From: =?utf-8?q?Christian_Ehrhardt_=EE=83=BF?= <1815889@bugs.launchpad.net>
Reply-To: Bug 1815889 <1815889@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <155014036044.634.15252078016929169795.malonedeb@gac.canonical.com>
Message-Id: <155429337410.21052.15834820694648906690.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1815889] Re: qemu-system-x86_64 crashed with
 signal 31 in __pthread_setaffinity_new()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Thank you Daniel,
we will most likely keep Disco as-is for now and merge this in 19.10 where =
then mesa can drop the revert. I tagged it for 19.10 to be revisited.

** Tags added: qemu-19.10

** Also affects: mesa (Ubuntu Ee-series)
   Importance: Undecided
       Status: New

** Also affects: qemu (Ubuntu Ee-series)
   Importance: Undecided
       Status: New

** Changed in: qemu (Ubuntu Ee-series)
       Status: New =3D> Triaged

** Changed in: qemu (Ubuntu)
       Status: Triaged =3D> Won't Fix

** Changed in: qemu (Ubuntu)
       Status: Won't Fix =3D> Invalid

** Changed in: mesa (Ubuntu Ee-series)
       Status: New =3D> Triaged

** Changed in: qemu (Ubuntu Ee-series)
     Assignee: (unassigned) =3D> Christian Ehrhardt =EE=83=BF (paelzer)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1815889

Title:
  qemu-system-x86_64 crashed with signal 31 in
  __pthread_setaffinity_new()

Status in Mesa:
  Confirmed
Status in QEMU:
  Fix Committed
Status in mesa package in Ubuntu:
  Fix Released
Status in qemu package in Ubuntu:
  Invalid
Status in mesa source package in Disco:
  Fix Released
Status in mesa source package in EE-Series:
  Triaged
Status in qemu source package in EE-Series:
  Triaged

Bug description:
  Unable to launch Default Fedora 29 images in gnome-boxes

  ProblemType: Crash
  DistroRelease: Ubuntu 19.04
  Package: qemu-system-x86 1:3.1+dfsg-2ubuntu1
  ProcVersionSignature: Ubuntu 4.19.0-12.13-generic 4.19.18
  Uname: Linux 4.19.0-12-generic x86_64
  ApportVersion: 2.20.10-0ubuntu20
  Architecture: amd64
  Date: Thu Feb 14 11:00:45 2019
  ExecutablePath: /usr/bin/qemu-system-x86_64
  KvmCmdLine: COMMAND         STAT  EUID  RUID   PID  PPID %CPU COMMAND
  MachineType: Dell Inc. Precision T3610
  ProcEnviron: PATH=3D(custom, user)
  ProcKernelCmdLine: BOOT_IMAGE=3D/boot/vmlinuz-4.19.0-12-generic root=3DUU=
ID=3D939b509b-d627-4642-a655-979b44972d17 ro splash quiet vt.handoff=3D1
  Signal: 31
  SourcePackage: qemu
  StacktraceTop:
   __pthread_setaffinity_new (th=3D<optimized out>, cpusetsize=3D128, cpuse=
t=3D0x7f5771fbf680) at ../sysdeps/unix/sysv/linux/pthread_setaffinity.c:34
   () at /usr/lib/x86_64-linux-gnu/dri/radeonsi_dri.so
   () at /usr/lib/x86_64-linux-gnu/dri/radeonsi_dri.so
   start_thread (arg=3D<optimized out>) at pthread_create.c:486
   clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:95
  Title: qemu-system-x86_64 crashed with signal 31 in __pthread_setaffinity=
_new()
  UpgradeStatus: Upgraded to disco on 2018-11-14 (91 days ago)
  UserGroups: adm cdrom dip lpadmin plugdev sambashare sudo video
  dmi.bios.date: 11/14/2018
  dmi.bios.vendor: Dell Inc.
  dmi.bios.version: A18
  dmi.board.name: 09M8Y8
  dmi.board.vendor: Dell Inc.
  dmi.board.version: A01
  dmi.chassis.type: 7
  dmi.chassis.vendor: Dell Inc.
  dmi.modalias: dmi:bvnDellInc.:bvrA18:bd11/14/2018:svnDellInc.:pnPrecision=
T3610:pvr00:rvnDellInc.:rn09M8Y8:rvrA01:cvnDellInc.:ct7:cvr:
  dmi.product.name: Precision T3610
  dmi.product.sku: 05D2
  dmi.product.version: 00
  dmi.sys.vendor: Dell Inc.

To manage notifications about this bug go to:
https://bugs.launchpad.net/mesa/+bug/1815889/+subscriptions
