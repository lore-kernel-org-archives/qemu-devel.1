Received: from eggs.gnu.org ([2001:4830:134:3::10]:39892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e8UOU-0002vi-8y
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 12:55:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e8UOQ-00041G-BN
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 12:55:34 -0400
Received: from indium.canonical.com ([91.189.90.7]:52592)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e8UOP-0003zK-Pw
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 12:55:30 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e8UOO-0004r3-Aa
	for <qemu-devel@nongnu.org>; Sat, 28 Oct 2017 16:55:28 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 4E5462E80C9
	for <qemu-devel@nongnu.org>; Sat, 28 Oct 2017 16:55:28 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 28 Oct 2017 16:42:54 -0000
From: Thomas Huth <1338591@bugs.launchpad.net>
Reply-To: Bug 1338591 <1338591@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140707141907.27349.18846.malonedeb@gac.canonical.com>
Message-Id: <150920897590.3741.17732506688242860902.launchpad@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1338591] Re: Cursor jumps on shape change with
 vmware vga
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Changed in: qemu
       Status: Incomplete =3D> Triaged

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1338591

Title:
  Cursor jumps on shape change with vmware vga

Status in QEMU:
  Triaged

Bug description:
  I launch QEMU with the following command line:

  qemu-system-i386 /home/ruslan/iso/Windoze/qemuxp.img -m 512 -display
  sdl -vga vmware -enable-kvm

  The guest OS is Windows XP. To reproduce the problem, do this:

  0. Make sure guest is WinXP (don't know if it's really necessary), use vm=
ware VGA
  1. Set mouse cursor theme to default black&white theme, i.e. that without=
 any translucency etc.
  2. Open a text editor, e.g. built-in notepad
  3. Move the cursor inside text entry widget
  4. See the cursor jumping away. You basically can't enter the cursor ther=
e.

  This also reproduces with MS Word 2003 even with oxy-white cursor
  theme (i.e. that with translucency) =E2=80=94 seems Word uses its plain
  black&transparent cursor for I-beam cursor.

  This doesn't happen with other VGAs, i.e. cirrus and std.

  I used qemu git master to test this. qemu-system-i386 --version
  reports version 2.0.90, git describe says v2.1.0-rc0-1-g9d9de25. This
  also happened in earlier QEMU versions, like 1.5.x and older.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1338591/+subscriptions
