Received: from eggs.gnu.org ([2001:4830:134:3::10]:38005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fL7uD-0004BD-5l
	for qemu-devel@nongnu.org; Tue, 22 May 2018 10:04:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fL7uA-0005LF-0U
	for qemu-devel@nongnu.org; Tue, 22 May 2018 10:04:49 -0400
Received: from indium.canonical.com ([91.189.90.7]:46714)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fL7u9-0005Kp-Qb
	for qemu-devel@nongnu.org; Tue, 22 May 2018 10:04:45 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fL7u8-00079W-30
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 14:04:44 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 4E9442E8F47
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 13:55:18 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 May 2018 13:38:49 -0000
From: Thomas Huth <1368204@bugs.launchpad.net>
Reply-To: Bug 1368204 <1368204@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140911122344.25076.48914.malonedeb@soybean.canonical.com>
Message-Id: <152699632974.16236.4614061926014731213.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1368204] Re: WinME isn't able to detect QEMU's
 cdrom drive and other hard drives automatically
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Looking through old bug tickets... can you still reproduce this issue
with the latest version of QEMU? Or could we close this ticket nowadays?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1368204

Title:
  WinME isn't able to detect QEMU's cdrom drive and other hard drives
  automatically

Status in QEMU:
  Incomplete

Bug description:
  On a fresh installation of Windows Millennium (WinME) in qemu, Windows
  Me isn't able to find the CD-ROM drive or additional hard drives other
  than -hda at first place.

  Only if i add manually an IDE controller driver in Windows ME's device ma=
nager, the CD-ROM inserted in QEMU is found.
  Thus an IDE controller isn't found automatically either.

  This shouldn't be the case. On normal real hardware, Windows ME would
  find at least one IDE or SCSI controller.

  The command line that was used is the following:
  sudo /usr/bin/qemu-system-i386 -hda WinME_QEMU.img -cdrom drivers.iso -bo=
ot c -no-acpi -no-hpet -soundhw sb16 -net nic -cpu pentium3 -m 256 -vga cir=
rus   =


  qemu's version is:
  qemu-system-i386 --version                                               =
                                                                           =
                                                =

  QEMU emulator version 2.0.0 (Debian 2.0.0+dfsg-2ubuntu1.3), Copyright (c)=
 2003-2008 Fabrice Bellard

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1368204/+subscriptions
