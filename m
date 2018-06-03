Received: from eggs.gnu.org ([2001:4830:134:3::10]:45832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fPQkq-0006xr-Ex
	for qemu-devel@nongnu.org; Sun, 03 Jun 2018 07:00:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fPQkn-0001LZ-Dr
	for qemu-devel@nongnu.org; Sun, 03 Jun 2018 07:00:56 -0400
Received: from indium.canonical.com ([91.189.90.7]:37544)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fPQkn-0001LT-7K
	for qemu-devel@nongnu.org; Sun, 03 Jun 2018 07:00:53 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fPQkl-0005Kz-Ty
	for <qemu-devel@nongnu.org>; Sun, 03 Jun 2018 11:00:51 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id E17C02E80C7
	for <qemu-devel@nongnu.org>; Sun,  3 Jun 2018 11:00:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 03 Jun 2018 10:51:49 -0000
From: tsiros <1774853@bugs.launchpad.net>
Reply-To: Bug 1774853 <1774853@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <152802310962.26200.2575137842813128178.malonedeb@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1774853] [NEW] claims temp file is used by
 another process
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

QEMU emulator version 2.12.50 (v2.12.0-12378-g99a34dc4d2-dirty)

"c:\Program Files\qemu\qemu-system-x86_64.exe" -net none -parallel none -bi=
os OVMF.fd -L . -hda fat:rw:image
vvfat image chs 1024,16,63
c:\Program Files\qemu\qemu-system-x86_64.exe: -hda fat:rw:image: Could not =
open 'C:\Users\tsiros\AppData\Local\Temp\qem5B92.tmp': The process cannot a=
ccess the file because it is being used by another process.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1774853

Title:
  claims temp file is used by another process

Status in QEMU:
  New

Bug description:
  QEMU emulator version 2.12.50 (v2.12.0-12378-g99a34dc4d2-dirty)

  "c:\Program Files\qemu\qemu-system-x86_64.exe" -net none -parallel none -=
bios OVMF.fd -L . -hda fat:rw:image
  vvfat image chs 1024,16,63
  c:\Program Files\qemu\qemu-system-x86_64.exe: -hda fat:rw:image: Could no=
t open 'C:\Users\tsiros\AppData\Local\Temp\qem5B92.tmp': The process cannot=
 access the file because it is being used by another process.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1774853/+subscriptions
