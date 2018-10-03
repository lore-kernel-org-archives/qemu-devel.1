Received: from eggs.gnu.org ([2001:4830:134:3::10]:53786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1g7dZV-0002V0-ES
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 05:35:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1g7dZQ-0006j5-Ls
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 05:35:57 -0400
Received: from indium.canonical.com ([91.189.90.7]:40048)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1g7dZQ-0006gm-Ex
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 05:35:52 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1g7dZN-0006Nn-5T
	for <qemu-devel@nongnu.org>; Wed, 03 Oct 2018 09:35:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id D62A02E80E4
	for <qemu-devel@nongnu.org>; Wed,  3 Oct 2018 09:35:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Oct 2018 09:26:21 -0000
From: 1448412 <uli_rgbg@gmx.de>
Reply-To: Bug 1795799 <1795799@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <153854876970.8093.8281977753870845379.malonedeb@soybean.canonical.com>
Message-Id: <153855878153.8093.5008874868022710513.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1795799] Re: Cirrus video, graphical corruption,
 bad fonts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Here's what Suse62 does.

I started this system by

uli_r@DESKTOP-I4GHL3R /cygdrive/h/programme/qemu
$ ./qemu-system-i386 -serial stdio -hda suse62.ima -vga cirrus
WARNING: Image format was not specified for 'suse62.ima' and probing guesse=
d raw.
         Automatically detecting the format is dangerous for raw images, wr=
ite operations on block 0 will be restricted.
         Specify the 'raw' format explicitly to remove the restrictions.

I configured X using the old sax (Suse Advanced X-Configurator) to use
the SVGA server. Video memory is autodetected at only 64k, so I manually
overwrote it to be 2048k, all other values I left as autodetected. I
ordered it to start up in 1024x768@16bpp.

Attached images show, what it does.

It's the same host system with the same qemu version as above...



** Attachment added: "Cirrus graphics failures with SVGA Xfree Server."
   https://bugs.launchpad.net/qemu/+bug/1795799/+attachment/5196499/+files/=
2018-10-03%2010_51_37-QEMU_suse62_kde1_fail.png

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1795799

Title:
  Cirrus video, graphical corruption, bad fonts

Status in QEMU:
  New

Bug description:
  The error
  =3D=3D=3D

  I started qemu by

  `shell
  $ ./qemu-system-i386 -serial stdio -cdrom /dev/cdrom -vga cirrus
  S1111111111S1111111111S1111111111S1111111111=E2=96=92*n*n*n*n
  `

  with the original suse7.0 cd 1 in the cdrom drive (I think
  https://archive.org/details/suse-7.0_release_i386 has the image).
  After some console output (that uses a vga framebuffer which seems to
  work fine) the suse installer is started. It is displayed mostly
  correct, but several text passages are completely garbled.

  I noticed the same type of corruption when trying to run an old XF86
  SVGA Server on a SuSE 6.2 System using the `-vga cirrus` option.

  Therefore I think that the cirrus emulation might not work as intended
  any more.

  Qemu version
  =3D=3D=3D

  I used  qemu-w64-setup-20180815.exe provided by
  https://qemu.weilnetz.de/w64/

  ./qemu-system-i386 -version
  QEMU emulator version 3.0.0 (v3.0.0-11723-ge2ddcc5879-dirty)
  Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers

  Hope you can fix it.

  Best regards!

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1795799/+subscriptions
