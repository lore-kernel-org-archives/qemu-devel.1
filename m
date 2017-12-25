Received: from eggs.gnu.org ([2001:4830:134:3::10]:45184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eTKPb-0008R2-OL
	for qemu-devel@nongnu.org; Sun, 24 Dec 2017 23:30:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eTKPY-0003V5-Fu
	for qemu-devel@nongnu.org; Sun, 24 Dec 2017 23:30:51 -0500
Received: from indium.canonical.com ([91.189.90.7]:55556)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eTKPY-0003UE-9h
	for qemu-devel@nongnu.org; Sun, 24 Dec 2017 23:30:48 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eTKPW-0007NY-DY
	for <qemu-devel@nongnu.org>; Mon, 25 Dec 2017 04:30:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id E97712E80D5
	for <qemu-devel@nongnu.org>; Mon, 25 Dec 2017 04:30:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 Dec 2017 04:17:37 -0000
From: Launchpad Bug Tracker <1290370@bugs.launchpad.net>
Reply-To: Bug 1290370 <1290370@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140310134632.8138.95419.malonedeb@soybean.canonical.com>
Message-Id: <151417545798.5133.10240357873176860986.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1290370] Re: FreeBSD 9.2 shell crashes when run
 with -smp 4 option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1290370

Title:
  FreeBSD 9.2 shell crashes when run with -smp 4 option

Status in QEMU:
  Expired

Bug description:
  This is a bug that i have noticed in qemu 1.7.50 as well as 1.1.50. It
  was the latter that forced me to clone the repository to check if this
  is the case with the resent version as well . The latest commit on
  which the bug is found is f53f3d0a00b6df39ce8dfca942608e5b6a9a4f71 on
  qemu.git

  qemu 1.7.50 configured with target list i386-softmmu.

  =

  OS: FreeBSD 9.2 Text Install ISO (ftp://ftp.freebsd.org/pub/FreeBSD/relea=
ses/i386/i386/ISO-IMAGES/9.2/FreeBSD-9.2-RELEASE-i386-disc1.iso)
  Installed it to a qcow2 format image.

  Command to run QEMU::
  ./i386-softmmu/qemu-system-i386 -hda <bsd-image> -m 2G -smp 4 -net nic -n=
et user -monitor stdio

  (boot into multi-user mode)->(login to root account)

  I have the filebench benchmark installed on the image and when i run it t=
he default root shell (csh) crashes with the error.
  [pid xxxx (csh) sigreturn eflag =3D 0xXXXX]
  Here is the piece of kernel code that is getting executed (i think) http:=
//svnweb.freebsd.org/base/release/9.2.0/sys/i386/i386/machdep.c?view=3Dmark=
up#l1095

  Here is a related bug
  https://www.virtualbox.org/ticket/458

  The crash happens randomly. It is not just related with filebench.
  Here are a few scenarios:
  * When i run fileserver workload of filebench
  * After i issue the shutdown -h now shutdown -r now commands
  * Issuing mount -t linprocfs proc /proc

  Moreover it is not guaranteed that the above scenarios will reproduce it =
(reliably).
  The bug manifests after running some commands and getting the CPU and the=
 kernel worked up.

  NOTE: This bug does not occur in qemu-kvm [X]
  EDIT: Confirmed. This happens on qemu-kvm as well.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1290370/+subscriptions
