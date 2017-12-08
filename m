Received: from eggs.gnu.org ([2001:4830:134:3::10]:35512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eNKqQ-0002Kk-Kt
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 10:45:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eNKqM-0001d0-Na
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 10:45:46 -0500
Received: from indium.canonical.com ([91.189.90.7]:33222)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eNKqM-0001ap-HW
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 10:45:42 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eNKqH-0003zI-TI
	for <qemu-devel@nongnu.org>; Fri, 08 Dec 2017 15:45:38 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id AAEC52E80CC
	for <qemu-devel@nongnu.org>; Fri,  8 Dec 2017 15:45:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 Dec 2017 15:35:56 -0000
From: John Arbuckle <programmingkidx@gmail.com>
Reply-To: Bug 1737194 <1737194@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <151274735709.11243.12332071284435970530.malonedeb@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1737194] [NEW] Windows NT 4.0 fails to boot from
 qcow2 installation
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

Windows NT 4.0 will not boot from an installation more than once if
installed in a qcow2 image file. A quick fix to this problem is to use
the qcow format instead.

Steps to reproduce this issue:

Create the image file:
qemu-img create -f qcow2 winnt4.qcow2 1G

Boot from a Windows NT 4.0 Workstation CD:
qemu-system-i386 -hda winnt4.qcow2 -cdrom /dev/cdrom -boot d -m 128 -cpu pe=
ntium -vga cirrus

During the installation process you have the choise between FAT and
NTFS. You can pick anyone.

After finishing the installation the guest will reboot to install
additional items. Once this is done the guest will be bootable. Eject
any CD media from QEMU and reboot. You will then see Windows NT 4.0
booting up to the desktop. Go to "Start->Shut down" to shut down. Then
when Windows is ready quit QEMU.

Now try to boot using this command:
qemu-system-i386 -hda winnt4.qcow2 -boot c -m 128 -cpu pentium -vga cirrus =

 =

The BIOS screen will display an error message:

For NTFS: =

Booting from Hard Disk...
A disk read error occurred.
Insert a system diskette and restart
the system.

For FAT:
No bootable device.

Additional information:
qemu-system-i386 version: 2.10.1
qemu-img version: 2.10.92 (v2.11.0-rc4-dirty)

If you don't have a Windows NT 4.0 Workstation installation CD, you may dow=
nload one from here:
https://winworldpc.com/product/windows-nt-40/40

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1737194

Title:
  Windows NT 4.0 fails to boot from qcow2 installation

Status in QEMU:
  New

Bug description:
  Windows NT 4.0 will not boot from an installation more than once if
  installed in a qcow2 image file. A quick fix to this problem is to use
  the qcow format instead.

  Steps to reproduce this issue:

  Create the image file:
  qemu-img create -f qcow2 winnt4.qcow2 1G

  Boot from a Windows NT 4.0 Workstation CD:
  qemu-system-i386 -hda winnt4.qcow2 -cdrom /dev/cdrom -boot d -m 128 -cpu =
pentium -vga cirrus

  During the installation process you have the choise between FAT and
  NTFS. You can pick anyone.

  After finishing the installation the guest will reboot to install
  additional items. Once this is done the guest will be bootable. Eject
  any CD media from QEMU and reboot. You will then see Windows NT 4.0
  booting up to the desktop. Go to "Start->Shut down" to shut down. Then
  when Windows is ready quit QEMU.

  Now try to boot using this command:
  qemu-system-i386 -hda winnt4.qcow2 -boot c -m 128 -cpu pentium -vga cirru=
s =

   =

  The BIOS screen will display an error message:

  For NTFS: =

  Booting from Hard Disk...
  A disk read error occurred.
  Insert a system diskette and restart
  the system.

  For FAT:
  No bootable device.

  Additional information:
  qemu-system-i386 version: 2.10.1
  qemu-img version: 2.10.92 (v2.11.0-rc4-dirty)

  If you don't have a Windows NT 4.0 Workstation installation CD, you may d=
ownload one from here:
  https://winworldpc.com/product/windows-nt-40/40

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1737194/+subscriptions
