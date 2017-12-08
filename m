Received: from eggs.gnu.org ([2001:4830:134:3::10]:49535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eNPIV-0000k1-32
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 15:31:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eNPIR-000087-42
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 15:31:03 -0500
Received: from indium.canonical.com ([91.189.90.7]:58290)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eNPIQ-00007d-TJ
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 15:30:59 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eNPIO-0000Xh-51
	for <qemu-devel@nongnu.org>; Fri, 08 Dec 2017 20:30:56 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id D55962E80C7
	for <qemu-devel@nongnu.org>; Fri,  8 Dec 2017 20:30:54 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 Dec 2017 20:21:55 -0000
From: John Arbuckle <programmingkidx@gmail.com>
Reply-To: Bug 1737194 <1737194@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <151274735709.11243.12332071284435970530.malonedeb@soybean.canonical.com>
	<151275851958.3366.9615429136508573832.malone@gac.canonical.com>
Message-Id: <AF765F5C-8233-49E7-A485-A7E73DB09316@gmail.com>
Errors-To: bounces@canonical.com
Subject: Re: [Qemu-devel] [Bug 1737194] Re: Windows NT 4.0 fails to boot
 from qcow2 installation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

> On Dec 8, 2017, at 1:41 PM, John Snow <1737194@bugs.launchpad.net> wrote:
> =

> If you do two identical installs with qcow2 and raw, do you see any
> differences with qemu-img compare afterwards that might indicate what
> could possibly have gone wrong?

I think what you want is for me to compare a broken qcow2 file with a
working qcow file. I'm not sure how to do that but if you sent me
directions I can send you the results.

I did try using the broken qcow2 file in a Windows XP VM. When I try to
open the "Program Files" folder I see this error message: "D:\Program
Files is not accessible. The file or directory is corrupted and
unreadable". The WINNT folder does open.

I tried checking the disk with Windows XP's disk repair utility. It
failed to complete and displayed this error message: "Windows was unable
to complete the disk check".

> =

> -- =

> You received this bug notification because you are subscribed to the bug
> report.
> https://bugs.launchpad.net/bugs/1737194
> =

> Title:
>  Windows NT 4.0 fails to boot from qcow2 installation
> =

> Status in QEMU:
>  New
> =

> Bug description:
>  Windows NT 4.0 will not boot from an installation more than once if
>  installed in a qcow2 image file. A quick fix to this problem is to use
>  the qcow format instead.
> =

>  Steps to reproduce this issue:
> =

>  Create the image file:
>  qemu-img create -f qcow2 winnt4.qcow2 1G
> =

>  Boot from a Windows NT 4.0 Workstation CD:
>  qemu-system-i386 -hda winnt4.qcow2 -cdrom /dev/cdrom -boot d -m 128 -cpu=
 pentium -vga cirrus
> =

>  During the installation process you have the choise between FAT and
>  NTFS. You can pick anyone.
> =

>  After finishing the installation the guest will reboot to install
>  additional items. Once this is done the guest will be bootable. Eject
>  any CD media from QEMU and reboot. You will then see Windows NT 4.0
>  booting up to the desktop. Go to "Start->Shut down" to shut down. Then
>  when Windows is ready quit QEMU.
> =

>  Now try to boot using this command:
>  qemu-system-i386 -hda winnt4.qcow2 -boot c -m 128 -cpu pentium -vga cirr=
us =

> =

>  The BIOS screen will display an error message:
> =

>  For NTFS: =

>  Booting from Hard Disk...
>  A disk read error occurred.
>  Insert a system diskette and restart
>  the system.
> =

>  For FAT:
>  No bootable device.
> =

>  Additional information:
>  qemu-system-i386 version: 2.10.1
>  qemu-img version: 2.10.92 (v2.11.0-rc4-dirty)
> =

>  If you don't have a Windows NT 4.0 Workstation installation CD, you may =
download one from here:
>  https://winworldpc.com/product/windows-nt-40/40
> =

> To manage notifications about this bug go to:
> https://bugs.launchpad.net/qemu/+bug/1737194/+subscriptions

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
