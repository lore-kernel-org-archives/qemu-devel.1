Received: from eggs.gnu.org ([2001:4830:134:3::10]:46891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eefQr-0003so-LV
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 06:11:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eefQm-0002mk-L2
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 06:11:01 -0500
Received: from indium.canonical.com ([91.189.90.7]:49114)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eefQm-0002lz-Dv
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 06:10:56 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eefQl-0005LJ-Ft
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 11:10:55 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 7336C2E854B
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 11:10:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jan 2018 11:00:50 -0000
From: FARJON <farjon.florian@gmail.com>
Reply-To: Bug 1745354 <1745354@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <151687805035.4532.9757970758658595284.malonedeb@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1745354] [NEW] CDOS ps/2 mouse problem
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

Qemu v2.10.2 (also tested with 2.11.0)
Host OS : CentOS 7 x86_64 (1708)
Guest OS : Concurrent DOS 386 3.0 (with GEM)

There is my launch command : =

/usr/local/bin/qemu-system-i386 -m 4m -cpu 486 -hda /home/my_user/HDD.img -=
vga std

When I'm launching the guest, it is not responding after focusing in the
viewer. I think this is due to the ps/2 emulation because when I add
"-usb -device usb-mouse" in my command I don't have this issue (but in
this case, mouse is not supported by CDOS).

I tested with an older version of Qemu (0.11) which uses the Bochs bios
(instead of SeaBios in newer versions), and I don't have this issue
either.

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: cdos mouse ps2

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1745354

Title:
  CDOS ps/2 mouse problem

Status in QEMU:
  New

Bug description:
  Qemu v2.10.2 (also tested with 2.11.0)
  Host OS : CentOS 7 x86_64 (1708)
  Guest OS : Concurrent DOS 386 3.0 (with GEM)

  There is my launch command : =

  /usr/local/bin/qemu-system-i386 -m 4m -cpu 486 -hda /home/my_user/HDD.img=
 -vga std

  When I'm launching the guest, it is not responding after focusing in
  the viewer. I think this is due to the ps/2 emulation because when I
  add "-usb -device usb-mouse" in my command I don't have this issue
  (but in this case, mouse is not supported by CDOS).

  I tested with an older version of Qemu (0.11) which uses the Bochs
  bios (instead of SeaBios in newer versions), and I don't have this
  issue either.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1745354/+subscriptions
