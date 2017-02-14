Received: from eggs.gnu.org ([2001:4830:134:3::10]:55181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cdUlZ-0003QL-4d
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 23:31:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cdUlW-0001JG-1G
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 23:31:01 -0500
Received: from indium.canonical.com ([91.189.90.7]:57843)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cdUlV-0001IQ-S5
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 23:30:57 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cdUlT-00041G-UD
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 04:30:55 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id ED7392E80E1
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 04:30:54 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Feb 2017 04:17:45 -0000
From: Launchpad Bug Tracker <912983@bugs.launchpad.net>
Reply-To: Bug 912983 <912983@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120107001840.28403.64805.malonedeb@gac.canonical.com>
Message-Id: <20170214041745.28611.13704.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 912983] Re: Unable to install OS/2 Warp v3 past
 disk 2
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
https://bugs.launchpad.net/bugs/912983

Title:
  Unable to install OS/2 Warp v3 past disk 2

Status in QEMU:
  Expired

Bug description:
  To whom it may concern,

  As you may (or may not) be aware, QEMU is currently unable to readily
  install OS/2 Warp v3 (OS2W3) when asked for Installation Diskette 2
  (http://www.claunia.com/qemu/objectManager.php?sClass=3Dversion&iId=3D132=
&iTestingId=3D138).

  QEMU 0.8.2 is the last known (to me) release to successfully install
  OS2W3. QEMU version 1.0 and the latest development version (as of
  2012-01-05) have been verified not to work.

  A 'git bisect' reveals the issue was introduced during a migration to
  new removable media handling prior to the QEMU 0.9.0 release:

  	There are only 'skip'ped commits left to test.
  	The first bad commit could be any of:
  	66c6ef7678939f2119eb649074babf5d5b2666f6
  	ea185bbda732dae6b6a5a44699f90c83e21f1494
  	19cb37389f4641d48803f0c5d72708749cbcf318
  	We cannot bisect more!

  For testing, the 'qcow' hard drive format was chosen due to QEMU 0.8.2
  not having 'qcow2':

          $ qemu -M isapc -m 8 -localtime -soundhw sb16 -hda os2.qcow
  -fda install.img -boot a

  Of note, the ISA-only PC (isapc) was needed for QEMU 0.8.2 to 0.9.0.
  Otherwise QEMU hangs on start-up. Later versions of QEMU, segmentation
  fault when attempting to use '-M isapc' though boot correctly when
  using the default PC machine.

  =

  The currently preferred method to install OS2W3 is to use another applica=
tion (such as VirtualBox or VMWare), using a QEMU compatible disk image for=
mat. Once installed, QEMU can then run OS2W3; which it does phenomenally we=
ll.

  However, I've identified a way to install OS2W3 exclusively with QEMU,
  which may also shed additional light on the issue.

  1. Using a relatively new QEMU (I'm on 0.11.1), install OS2W3 as you norm=
ally would on to a 'qcow2' hard drive.
  2. When Installation Diskette 2 is reached, save a VM snapshot.
  3. Quit QEMU and re-run, loading the VM state *with* the Installation Dis=
kette 2 image in the floppy drive.
  	$ qemu -m 8 -localtime -soundhw sb16 -hda os2.qcow2 -fda disk2.img -load=
vm install =

  The installation process will then continue as normal.

  This same method can be used once OS2W3 continues installing from it's
  GUI. Installation Diskette 7 experiences the same issue of not being
  recognised when inserted.

  Of note, as an unrelated issue, I was unable to save VM snapshots in
  QEMU 1.0 or later.

  =

  Thank you for a fantastic emulator.

  =

  cheers,
  multitude

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/912983/+subscriptions
