Received: from eggs.gnu.org ([209.51.188.92]:57419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hBNYe-0008QN-7w
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 13:50:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hBNYc-0007DG-KI
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 13:50:48 -0400
Received: from indium.canonical.com ([91.189.90.7]:41954)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hBNYc-0007CC-62
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 13:50:46 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hBNYa-0006y4-0v
	for <qemu-devel@nongnu.org>; Tue, 02 Apr 2019 17:50:44 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 65F812E817B
	for <qemu-devel@nongnu.org>; Tue,  2 Apr 2019 17:50:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Apr 2019 17:38:08 -0000
From: Daniel Berrange <1815889@bugs.launchpad.net>
Reply-To: Bug 1815889 <1815889@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <155014036044.634.15252078016929169795.malonedeb@gac.canonical.com>
Message-Id: <155422668873.21090.14194628601898762658.malone@chaenomeles.canonical.com>
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

FYI the QEMU change merged in the following pull request changed to
return an EPERM errno for the thread affinity syscalls:

commit 12f067cc14b90aef60b2b7d03e1df74cc50a0459
Merge: 84bdc58c06 035121d23a
Author: Peter Maydell <peter.maydell@linaro.org>
Date:   Thu Mar 28 12:04:52 2019 +0000

    Merge remote-tracking branch 'remotes/otubo/tags/pull-seccomp-20190327'=
 into staging
    =

    pull-seccomp-20190327
    =

    # gpg: Signature made Wed 27 Mar 2019 12:12:39 GMT
    # gpg:                using RSA key DF32E7C0F0FFF9A2
    # gpg: Good signature from "Eduardo Otubo (Senior Software Engineer) <o=
tubo@redhat.com>" [full]
    # Primary key fingerprint: D67E 1B50 9374 86B4 0723  DBAB DF32 E7C0 F0F=
F F9A2
    =

    * remotes/otubo/tags/pull-seccomp-20190327:
      seccomp: report more useful errors from seccomp
      seccomp: don't kill process for resource control syscalls
    =

    Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

IOW, mesa's usage of this syscalls will still be blocked, but it will no
longer kill the process.

** Changed in: qemu
       Status: New =3D> Fix Committed

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
  Triaged
Status in mesa source package in Disco:
  Fix Released

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
