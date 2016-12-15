Received: from eggs.gnu.org ([2001:4830:134:3::10]:51087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cHaPL-0005UM-Cr
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 13:05:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cHaPJ-0000ba-1D
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 13:05:31 -0500
Received: from indium.canonical.com ([91.189.90.7]:45552)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cHaPI-0000ZN-Sf
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 13:05:28 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cHaPI-0007Sg-1n
	for <qemu-devel@nongnu.org>; Thu, 15 Dec 2016 18:05:28 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 0B4B12E80C2
	for <qemu-devel@nongnu.org>; Thu, 15 Dec 2016 18:05:28 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Dec 2016 17:48:39 -0000
From: Thomas Huth <922076@bugs.launchpad.net>
Reply-To: Bug 922076 <922076@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120126133438.17636.69999.malonedeb@soybean.canonical.com>
Message-Id: <20161215174839.19766.62661.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 922076] Re: doesn't clear screen on boot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Does this problem still exist with the latest version of QEMU? Which
interface type are you using (SDL, gtk, ...)? Can you please provide
your full command line and build options?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/922076

Title:
  doesn't clear screen on boot

Status in QEMU:
  Incomplete

Bug description:
  When I start Linux in Qemu via "qemu -kernel /vmlinuz ...", Qemu
  window appears and it shows message "Starting Seabios (version
  0.5.1-2010...)", and then Linux writes messages like "Loading, please
  wait..." on top of previous message!

  For example, I can see "Loading, please wait...on 0.5.1-2010...)"

  So, Qemu doesn't clean screan before booting OS.

  Moreover, when I start Linux via "qemu /disk-image", Qemu shows
  "Starting Seabios (version 0.5.1-2010...)", then switches to graphical
  mode, shows GRUB, then switches back to text mode and shows "Starting
  Seabios" again! And again Linux prints messages on top of Seabios
  messages, and we see a mix of symbols on screen.

  Also, I found another bug! I am learning now to write kernels. And I
  see that operator "*(char *)0xb8000 =3D 0" in C code of kernel doesn't
  clean first charaster of screen in Qemu in "-curses" mode! If I want
  to real clean this charaster, I must type "*(char *)0xb8000 =3D ' '".

  I attach a kernel (x86, multiboot) with this bug. Just type "make"
  (you need gcc) and "qemu -curses -kernel kernel". You will see that
  screen is not cleared, but kernel tries to clean it. If you change 0
  to ' ', all will work!

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/922076/+subscriptions
