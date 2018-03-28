Received: from eggs.gnu.org ([2001:4830:134:3::10]:52594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f1Cs6-0004Tv-Hb
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 11:20:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f1Cs1-0000bW-Kn
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 11:20:18 -0400
Received: from indium.canonical.com ([91.189.90.7]:49646)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1f1Cs1-0000aq-Af
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 11:20:13 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1f1Cs0-0003vW-94
	for <qemu-devel@nongnu.org>; Wed, 28 Mar 2018 15:20:12 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 418E52E8050
	for <qemu-devel@nongnu.org>; Wed, 28 Mar 2018 15:20:12 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Mar 2018 15:08:48 -0000
From: Zhen Ning Lim <limzn88@gmail.com>
Reply-To: Bug 1539940 <1539940@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160130164153.25136.87723.malonedeb@soybean.canonical.com>
Message-Id: <152224972878.30094.2567895219211313411.launchpad@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1539940] Re: Qemu 2.5 Solaris 8 and 9 sparc hang
 after terminal type menu
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
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1539940

Title:
  Qemu 2.5 Solaris 8 and 9 sparc hang after terminal type menu

Status in QEMU:
  Fix Released

Bug description:
  Qemu command:
  qemu-system-sparc -nographic -monitor null -serial mon:telnet:localhost:3=
000,server -bios ../../Downloads/ss20_v2.25_rom -M SS-20 -hda ./solsparc -m=
 512 -cdrom ./sol-9-905hw-ga-sparc-dvd.iso -boot d -cpu "TI SuperSparc 60" =
-net nic,vlan=3D1,macaddr=3D52:54:0:12:34:56

  =

  when i do disk2:d, the system loads until the terminal type menu.

  What type of terminal are you using?
  1) ANSI Standard CRT
  2) DEC VT52
  3) DEC VT100
  4) Heathkit 19
  5) Lear Siegler ADM31
  6) PC Console
  7) Sun Command Tool
  8) Sun Workstation
  9) Televideo 910
  10) Televideo 925
  11) Wyse Model 50
  12) X Terminal Emulator (xterms)
  13) CDE Terminal Emulator (dtterm)
  14) Other
  Type the number of your choice and press Return: 3
  syslog service starting.
  savecore: no dump device configured
  Running in command line mode

  And nothing happens after that. Anyone encountered this issue?

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1539940/+subscriptions
