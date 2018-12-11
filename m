Received: from eggs.gnu.org ([2001:4830:134:3::10]:53582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gWZi4-0000Jw-IU
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 23:31:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gWZhz-00009N-Ke
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 23:31:52 -0500
Received: from indium.canonical.com ([91.189.90.7]:48382)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gWZhz-00008f-EU
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 23:31:47 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gWZhw-0001ba-6P
	for <qemu-devel@nongnu.org>; Tue, 11 Dec 2018 04:31:44 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 275C42E8DBD
	for <qemu-devel@nongnu.org>; Tue, 11 Dec 2018 04:31:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 11 Dec 2018 04:17:30 -0000
From: Launchpad Bug Tracker <1368204@bugs.launchpad.net>
Reply-To: Bug 1368204 <1368204@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140911122344.25076.48914.malonedeb@soybean.canonical.com>
Message-Id: <154450185055.29389.2259238816084040202.malone@loganberry.canonical.com>
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

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1368204

Title:
  WinME isn't able to detect QEMU's cdrom drive and other hard drives
  automatically

Status in QEMU:
  Expired

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
