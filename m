Received: from eggs.gnu.org ([2001:4830:134:3::10]:54090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d7hFS-0003LC-OC
	for qemu-devel@nongnu.org; Mon, 08 May 2017 07:54:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d7hFO-0001Hc-RK
	for qemu-devel@nongnu.org; Mon, 08 May 2017 07:54:42 -0400
Received: from indium.canonical.com ([91.189.90.7]:47149)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1d7hFO-0001HU-Lc
	for qemu-devel@nongnu.org; Mon, 08 May 2017 07:54:38 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1d7hFM-0006tc-U9
	for <qemu-devel@nongnu.org>; Mon, 08 May 2017 11:54:37 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id E17282E80C8
	for <qemu-devel@nongnu.org>; Mon,  8 May 2017 11:54:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 May 2017 11:44:59 -0000
From: Thomas Huth <822408@bugs.launchpad.net>
Reply-To: Bug 822408 <822408@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20110807201009.28795.63294.malonedeb@chaenomeles.canonical.com>
Message-Id: <20170508114459.2688.69816.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 822408] Re: Unable to access disk image on mipsel
 host
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Triaging old bug tickets ... can you still reproduce this problem with
the latest version of QEMU (currently v2.9.0)?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/822408

Title:
  Unable to access disk image on mipsel host

Status in QEMU:
  Incomplete

Bug description:
  Something is wrong with hard disk images on MIPSel host.

  The host system is mips64el (Loongson cpu, Linux 2.6.39, eglibc 2.13)
  Tried Qemu 0.14.1 and 0.15.0-rc2, both compiled with GCC 4.6.0.

  First I was trying to install WinXP (i386-softmmu).
  Starting install, create partition, format (either quick and full), seems=
 to complete, boom the error:

  "
  Setup was unable to format the partition.  The disk may be damaged.  Make=
 sure the drive is switched on and properly connected to your computer.  If=
 the disk is a SCSI disk, make sure your SCSI devices are properly terminat=
ed.  Consult your computer manual or SCSI adapter documentation for more in=
formation.

  You must select a different partition for Windows XP.
  To continue, press ENTER.
  "

  This happens with both raw and qcow2 image format.
  Tried 10Gb image, tried 16Gb one - no difference.

  On a x86 host, that formatting makes the image (qcow2) grow to about
  81 Mb by the time it reaches 100% formatted (quick), but on mipsel it
  grows to 0.8Mb at the same time and the error appears.

  I tried the same installing of Windows in Qemu on x86 host and copied ove=
r the completed image.
  In that case it starts loading, but in the middle of the animation there =
is an error:

  "
  STOP: c0000221 Unknown Hard Error
  \Systemroot\System32\ntdll.dll
  "
  (or HAL.dll)

  So, i tried linux-0.2.img.bz2 from the Qemu site, and that fails too.
  Thus it's the minimal bug reproduction thing.

  During boot there are multiple errors like:
  "
  hda: dma_intr: status=3D0x41 { DriveReady Error }
  hda: dma_intr: error=3D0x04 { DriveStatusError }
  hda: Failed opcode was: unknown
  "

  It booted and kind of worked, there were weird glitches in every program.
  Unusable.

  Summarily, that suggest some error in hard disk emulation or back
  storage, specific either to MIPSel or non-x86 hosts.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/822408/+subscriptions
