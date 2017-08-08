Received: from eggs.gnu.org ([2001:4830:134:3::10]:56148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1df5Rl-0004MP-Ld
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 10:25:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1df5Rg-0003tc-NR
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 10:25:25 -0400
Received: from indium.canonical.com ([91.189.90.7]:55789)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1df5Rg-0003sf-IE
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 10:25:20 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1df5Re-0003BA-Qy
	for <qemu-devel@nongnu.org>; Tue, 08 Aug 2017 14:25:18 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id C13322E80C8
	for <qemu-devel@nongnu.org>; Tue,  8 Aug 2017 14:25:18 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Aug 2017 14:08:59 -0000
From: Thomas Huth <1223477@bugs.launchpad.net>
Reply-To: Bug 1223477 <1223477@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130910171549.9427.14452.malonedeb@wampee.canonical.com>
Message-Id: <150220133976.11063.14719008080179416927.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1223477] Re: Unable to read USB filesystems with
 EFI Bios
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Triaging old bug tickets... can you still reproduce this issue with the
latest version of QEMU? Or could we close this ticket nowadays?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1223477

Title:
  Unable to read USB filesystems with EFI Bios

Status in QEMU:
  Incomplete

Bug description:
  Preamble and version:
  With respect to my fix for using USB devices as -hda mentioned in bug 122=
3467
  Using Qemu 1.6.0 with OVMF r11337-alpha (Qemu is built from Source, OVMF =
is pre built)

  Command:
  qemu-system-i386.exe -m 1024 -hda \\.\PhysicalDrive1 -L ovmf-ia32

  Fault:
  The EFI Shell is able to detect the hda block device, report its capacity=
 and usage; =

  but it sees no files or directories on the device.

  Similar commands:
  I have also seen the same with =

  qemu-system-x86_64.exe -m 1024 -hda \\.\PhysicalDrive1 -L ovmf-ia32
  and
  qemu-system-x86_64.exe -m 1024 -hda \\.\PhysicalDrive1 -L ovmf-x64

  Investigations:
  I tried very small (500MB) and very large (32 GB) USB devices with no dif=
ference.
  I re-built several versions of Qemu in an identical build environment, an=
d found that: =

  Qemu 1.2.2 and before, all the above commands work and the EFI boot loade=
r is called.
  Qemu 1.3.0-rc0 and after do not work and the USB device appears blank.
  I'm reporting the bug here and not with OVMF because older versions of Qe=
mu with the same OVMF bios work perfectly. =


  In all cases using '-L pc-bios' works perfectly.
  In all cases using an image of the USB device works.

  Thanks

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1223477/+subscriptions
