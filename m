Received: from eggs.gnu.org ([2001:4830:134:3::10]:41154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eHNhQ-0005Ef-LO
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 00:35:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eHNhN-0001y6-Hr
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 00:35:52 -0500
Received: from indium.canonical.com ([91.189.90.7]:37732)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eHNhN-0001xm-B5
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 00:35:49 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eHNhL-0001Vo-M4
	for <qemu-devel@nongnu.org>; Wed, 22 Nov 2017 05:35:47 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 763D02E80E0
	for <qemu-devel@nongnu.org>; Wed, 22 Nov 2017 05:35:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Nov 2017 05:28:51 -0000
From: Ken Dickey <Ken.Dickey@whidbey.com>
Reply-To: Bug 1733720 <1733720@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <151130882565.18495.10192043724404737327.malonedeb@gac.canonical.com>
Message-Id: <151132853148.8081.9028419079901926132.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1733720] Re: raspi2 with multiple CPU's #1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Sorry again, "MPIDR"

Gotta learn to type!

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1733720

Title:
  raspi2 with multiple CPU's #1

Status in QEMU:
  Invalid

Bug description:
  Greetings,

  I am running a small program for raspi2 (from
  http://wiki.osdev.org/ARM_RaspberryPi_Tutorial_C).

  This code writes "Hello World", but the output ir repeated 4 times.

  My thought was that this is emulating a 4 cpu core system.

  However, when I check the MPIDR registed for CPU number, it always
  returns 1.

  I git cloned github.com/qemu/qemu.git, made & installed on Acer ARM
  CB5-311 under Crouton/ubuntu.

  =

  ./qemu.sh =

  1111

  Linux:armv7l: ~/Downloads/RaspiTest/BareBones >>> uname -a
  Linux localhost 3.10.18 #1 SMP Mon Nov 13 16:34:10 PST 2017 armv7l armv7l=
 armv7l GNU/Linux

  Linux:armv7l: ~/Downloads/RaspiTest/BareBones >>> qemu-system-arm --versi=
on
  QEMU emulator version 2.10.91 (v2.11.0-rc1-dirty)
  Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers

  =3D=3D=3D=3D=3D
  static inline uint32_t read_mpdir(void)
  {
    uint32_t id;
    =

    asm volatile("mrc p15, 0, %[id], c0, c0, 0 @ read MIDR\n\t"
  	       : [id] "=3Dr" (id));
    return id;
  }
  =3D=3D=3D=3D=3D=3D
  void kernel_main(uint32_t r0, uint32_t r1, uint32_t atags)
  {
  	// Declare as unused
  	(void) r0;
  	(void) r1;
  	(void) atags;

          uint32_t cpu_id;

          cpu_id =3D read_mpdir() & 0x03;

          uart_putc( "01234"[cpu_id] ); /* output is "1111" */

          if (cpu_id =3D=3D 0) { /* code never executes 8^( */ }

  =3D=3D=3D=3D=3D=3D qemu.sh
  qemu-system-arm -m 256 -M raspi2 -no-reboot -serial stdio  -kernel myos.e=
lf

  Thanks much,
  -KenD

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1733720/+subscriptions
