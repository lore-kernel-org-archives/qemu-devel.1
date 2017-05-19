Received: from eggs.gnu.org ([2001:4830:134:3::10]:36663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dBfQ0-0000oL-D8
	for qemu-devel@nongnu.org; Fri, 19 May 2017 06:46:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dBfPz-0003l1-9t
	for qemu-devel@nongnu.org; Fri, 19 May 2017 06:46:00 -0400
Received: from indium.canonical.com ([91.189.90.7]:50060)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dBfPz-0003kl-2L
	for qemu-devel@nongnu.org; Fri, 19 May 2017 06:45:59 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dBfPx-0002iM-1J
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 10:45:57 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 276342E806B
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 10:45:56 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 May 2017 10:31:30 -0000
From: Thomas Huth <1255303@bugs.launchpad.net>
Reply-To: Bug 1255303 <1255303@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20131126203906.17117.92053.malonedeb@soybean.canonical.com>
Message-Id: <149518988993.11552.9562936251826353234.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1255303] Re: ALSA underruns occurr when using QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Triaging old bug tickets ... can you still reproduce this issue with the
latest version of QEMU (currently v2.9)?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1255303

Title:
  ALSA underruns occurr when using QEMU

Status in QEMU:
  Incomplete

Bug description:
  I'm running QEMU 1.6.1 on a 64-bit Gentoo Linux system. The guest
  operating system is Windows 7 32-bit. I get multiple identical warning
  messages when using the ac97 or hda sound cards:

  > ALSA lib /var/tmp/portage/media-libs/alsa-lib-1.0.27.2/work/alsa-
  lib-1.0.27.2/src/pcm/pcm.c:7843:(snd_pcm_recover) underrun occurred

  The difference between ac97 and hda is that the former works well,
  while the latter causes the sound to be garbled.

  /var/tmp/portage is the directory where Portage, the Gentoo package
  manager, builds programs. I don't know why it is mentioned in the
  error message.

  I also don't know if this is an ALSA problem or a QEMU problem.

  The command I use is:

  > qemu-system-i386 -cpu host -m 1G -k it -drive
  file=3D~/QEMU/Windows_7_Privato.qcow2,media=3Ddisk,index=3D0 -vga std -net
  nic -net user -enable-kvm -display sdl -soundhw ac97 -device usb-
  ehci,id=3Dehci -usb -rtc base=3Dlocaltime -usbdevice tablet

  My real sound card is an Intel HD Audio:

  > lspci | grep "Audio device"

  > 00:1b.0 Audio device: Intel Corporation 82801I (ICH9 Family) HD
  Audio Controller (rev 02)

  Please tell me if you need other informations.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1255303/+subscriptions
