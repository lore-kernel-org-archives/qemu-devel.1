Received: from eggs.gnu.org ([2001:4830:134:3::10]:37973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e7cFT-0002Hn-N8
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 03:06:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e7cFQ-0002cd-G6
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 03:06:39 -0400
Received: from indium.canonical.com ([91.189.90.7]:60188)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e7cFQ-0002cJ-AQ
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 03:06:36 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e7cFO-0007xM-Bq
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 07:06:34 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 521AC2E80C7
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 07:06:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Oct 2017 06:47:28 -0000
From: =?utf-8?q?Piotr_Gli=C5=BAniewicz?= <glizda@gmail.com>
Reply-To: Bug 1342686 <1342686@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140716121553.1821.18365.malonedeb@gac.canonical.com>
Message-Id: <150900044876.17363.16136312647227763673.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1342686] Re: Windows 95 setup hangs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I've tried the recent QEMU 2.10 (Windows build
qemu-w64-setup-20171006.exe) and the bug is still there. It hangs right
after "Getting ready to run Windows 95 for the first time..." screen.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1342686

Title:
  Windows 95 setup hangs

Status in QEMU:
  Incomplete

Bug description:
  Windows 95 (first version, not 95A or OSR2) setup hangs on QEMU version 2=
.0.0. It was compiled from the sources on Fedora 20. =

  Setup starts without problems, it goes through the first phase and then h=
angs on the "Getting ready to run Windows 95 for the first time..." screen =
(http://www.guidebookgallery.org/screenshots/win95#win95startupshutdownspla=
sh1correctaspect).

  Steps to reproduce:
  qemu-img create -f qcow2 win95.img 2G
  qemu -L . -machine isapc -cpu pentium -m 32 -vga std -soundhw sb16 -hda w=
in95.img -cdrom POLWIN95.ISO -fda BOOT95A.IMA -boot a
  after this select default options everywhere. When it asks to remove the =
boot floppy do "eject floppy0" and confirm.
  It displays the "Getting ready to run Windows 95 for the first time..." a=
nd hangs.

  The same behavior can be observed on 2.1.0-rc2. On 1.7.1 It hangs
  immediately after this screen, it hangs on displaying a underscore
  cursor.

  I managed to complete the setup on QEMU 1.6.2.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1342686/+subscriptions
