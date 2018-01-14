Received: from eggs.gnu.org ([2001:4830:134:3::10]:57067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eahQw-00076S-Dh
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 07:30:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eahQt-00045N-AA
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 07:30:42 -0500
Received: from indium.canonical.com ([91.189.90.7]:55650)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eahQt-000451-34
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 07:30:39 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eahQs-00057v-5P
	for <qemu-devel@nongnu.org>; Sun, 14 Jan 2018 12:30:38 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 1B7F12E854D
	for <qemu-devel@nongnu.org>; Sun, 14 Jan 2018 12:30:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 14 Jan 2018 12:17:30 -0000
From: MVoloshin <1743214@bugs.launchpad.net>
Reply-To: Bug 1743214 <1743214@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <151593225024.11261.9880390596143098449.malonedeb@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1743214] [NEW] OS/2 Warp 3 support broken in 2.11
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

Hello, I used to run OS/2 Warp 3 on QEMU with the following command line: q=
emu-system-i386 -vga cirrus -soundhw sb16 -hda os2warp3v2.img -boot c. It r=
uns OK on QEMU 2.10, but immediately gives TRAP 0006 (invalid opcode?) on Q=
EMU 2.11 (see screenshot).
If it is important I have Fixpack 40 and GRADD installed in OS/2.
Here is the image:
https://drive.google.com/open?id=3D15umPecy7JlPLKUP6520MB_87CfrCDWO5

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: broken i386 os2 support trap warp

** Attachment added: "trap.PNG"
   https://bugs.launchpad.net/bugs/1743214/+attachment/5036800/+files/trap.=
PNG

** Tags added: i386

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1743214

Title:
  OS/2 Warp 3 support broken in 2.11

Status in QEMU:
  New

Bug description:
  Hello, I used to run OS/2 Warp 3 on QEMU with the following command line:=
 qemu-system-i386 -vga cirrus -soundhw sb16 -hda os2warp3v2.img -boot c. It=
 runs OK on QEMU 2.10, but immediately gives TRAP 0006 (invalid opcode?) on=
 QEMU 2.11 (see screenshot).
  If it is important I have Fixpack 40 and GRADD installed in OS/2.
  Here is the image:
  https://drive.google.com/open?id=3D15umPecy7JlPLKUP6520MB_87CfrCDWO5

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1743214/+subscriptions
