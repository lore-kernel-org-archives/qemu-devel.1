Received: from eggs.gnu.org ([2001:4830:134:3::10]:46678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f1CTh-00039Z-06
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 10:55:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f1CTd-00013f-4q
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 10:55:05 -0400
Received: from indium.canonical.com ([91.189.90.7]:41552)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1f1CTc-00013J-VD
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 10:55:01 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1f1CTb-0007pr-K6
	for <qemu-devel@nongnu.org>; Wed, 28 Mar 2018 14:54:59 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 972852E8042
	for <qemu-devel@nongnu.org>; Wed, 28 Mar 2018 14:54:59 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Mar 2018 14:36:25 -0000
From: "mike@papersolve.com" <mike@papersolve.com>
Reply-To: Bug 1539940 <1539940@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160130164153.25136.87723.malonedeb@soybean.canonical.com>
Message-Id: <152224778516.20696.6474124526328492710.malone@chaenomeles.canonical.com>
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

This is no longer a problem (for sure in latest git, probably further
back than that, as I installed Solaris 9/SPARC on SS-20 a few months
ago):

Type the number of your choice and press Return: 3
syslog service starting.
savecore: no dump device configured
Running in command line mode

Please wait while the system information is loaded... /



Welcome to the Web Start Solaris Command Line installation!

The following questions will gather information about this system.
This information will be used to configure:

	Network
	Kerberos Security
	Name Service
	Date and Time
	Root Password
	Power Management

   <Press Return to continue>


This can be resolved.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1539940

Title:
  Qemu 2.5 Solaris 8 and 9 sparc hang after terminal type menu

Status in QEMU:
  New

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
