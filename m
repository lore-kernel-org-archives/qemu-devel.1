Received: from eggs.gnu.org ([2001:4830:134:3::10]:39926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1csALo-0002Ns-PD
	for qemu-devel@nongnu.org; Sun, 26 Mar 2017 11:45:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1csALl-0006eg-Ln
	for qemu-devel@nongnu.org; Sun, 26 Mar 2017 11:45:04 -0400
Received: from indium.canonical.com ([91.189.90.7]:60144)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1csALl-0006eQ-G7
	for qemu-devel@nongnu.org; Sun, 26 Mar 2017 11:45:01 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1csALk-0008Nm-7A
	for <qemu-devel@nongnu.org>; Sun, 26 Mar 2017 15:45:00 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 259602E80C2
	for <qemu-devel@nongnu.org>; Sun, 26 Mar 2017 15:45:00 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 26 Mar 2017 15:30:13 -0000
From: milasudril <milasudril@gmail.com>
Reply-To: Bug 1295587 <1295587@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140321093246.9788.71300.malonedeb@soybean.canonical.com>
Message-Id: <20170326153013.30419.50510.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1295587] Re: Temporal freeze and slowdown while
 using emulated sb16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On Windows 98 SE:

 * SB16: System hangs as described in this bug report
 * ES1370: Causes system freeze with back screen at boot time
 * AC97 (as suggested here: https://smcv.pseudorandom.co.uk/2015/discworldn=
oir/): BSODs during the installation
 * GUS: Device is not even detected

Conclusion: At the moment, there is no way to get audio output from
Windows 98 se VM.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1295587

Title:
  Temporal freeze and slowdown while using emulated sb16

Status in QEMU:
  New

Bug description:
  I have been carrying around this bug since previous versions and on
  different machines: When I use the -soundhw sb16 option, while playing
  any sound on the virtual machine it temporally freezes the emulated
  machine and loops the last bit of such sound effect for 1-2 minutes,
  then goes back to normal speed (until a new sound is played).

  Console shows:

  =C2=A0sb16: warning: command 0xf9,1 is not truly understood yet
  =C2=A0sb16: warning: command 0xf9,1 is not truly understood yet
  (...)
  main-loop: WARNING: I/O thread spun for 1000 iterations

  -One of my emulated machines is Windows 3.11: I managed to overrun
  this bug by switching from the local 1.5 version of the sound blaster
  driver to the 1.0, although since I updated qemu it freezes that
  machine, so I can't test if it still works.

  I am using the 1.7.90 version, but I suffered this bug for over one
  year (confirmed in version 2.0.0-rc0 too)

  this bug happens anytime I use the -soundhw sb16 switch, but the full
  command I am using in this specific case is:

  qemu-system-i386 -localtime -cpu pentium -m 32 -display sdl -vga
  cirrus -hda c.img -cdrom win95stuff.iso -net nic,model=3Dne2k_pci -net
  user -soundhw sb16

  This bug appears on all my machines: Pentium III running Slackware
  13.0 and freeBSD 10; Dual core T2400, both in Arch, Gentoo and
  Slackware 14.1 (all 32 bits), and a Dual core T4400 64 bits with
  Gentoo and Slackware. Same problem in all of those systems after
  compiling instead of using the distro packages....

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1295587/+subscriptions
