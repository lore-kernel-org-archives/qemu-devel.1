Received: from eggs.gnu.org ([2001:4830:134:3::10]:53374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dCA4K-0005U7-WF
	for qemu-devel@nongnu.org; Sat, 20 May 2017 15:29:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dCA4H-0000Z4-S9
	for qemu-devel@nongnu.org; Sat, 20 May 2017 15:29:41 -0400
Received: from indium.canonical.com ([91.189.90.7]:52241)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dCA4H-0000Yw-M4
	for qemu-devel@nongnu.org; Sat, 20 May 2017 15:29:37 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dCA4G-00009F-R1
	for <qemu-devel@nongnu.org>; Sat, 20 May 2017 19:29:36 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id BE9952E8052
	for <qemu-devel@nongnu.org>; Sat, 20 May 2017 19:29:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 20 May 2017 19:20:05 -0000
From: Francesco Turco <fturco@fastmail.fm>
Reply-To: Bug 1255303 <1255303@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20131126203906.17117.92053.malonedeb@soybean.canonical.com>
Message-Id: <149530800513.12752.4278145577515313738.malone@gac.canonical.com>
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

I'm still using Gentoo Linux on the same 64-bit system, and I can still
reproduce this bug:

qemu-system-i386 -cpu host -m 1G -k it -drive file=3D~/qemu/windows-7-ultim=
ate-x86.qcow2,media=3Ddisk,index=3D0 -vga std -net nic -net user -enable-kv=
m -display sdl -soundhw ac97 -device usb-ehci,id=3Dehci -usb -rtc base=3Dlo=
caltime -usbdevice tablet
audio: Failed to create voice `ac97.pi'
audio: Failed to create voice `ac97.mc'
audio: Failed to create voice `ac97.pi'
audio: Failed to create voice `ac97.mc'
ALSA lib /var/tmp/portage/media-libs/alsa-lib-1.1.4/work/alsa-lib-1.1.4/src=
/pcm/pcm.c:8321:(snd_pcm_recover) underrun occurred

$ emerge -pv qemu alsa-lib

These are the packages that would be merged, in order:

Calculating dependencies... done!
[ebuild   R    ] media-libs/alsa-lib-1.1.4::gentoo  USE=3D"python -alisp -d=
ebug -doc" PYTHON_TARGETS=3D"python2_7" 0 KiB
[ebuild   R    ] app-emulation/qemu-2.9.0-r54::gentoo  USE=3D"aio alsa bzip=
2 curl fdt gnutls jpeg lzo ncurses nls opengl pin-upstream-blobs png python=
 sdl seccomp usb vhost-net -accessibility -bluetooth -caps -debug -filecaps=
 -glusterfs -gtk -gtk2 -infiniband -iscsi -nfs -numa -pulseaudio -rbd -sasl=
 -sdl2 (-selinux) -smartcard -snappy -spice -ssh -static -static-user -syst=
emtap -tci {-test} -usbredir -vde -virgl -virtfs -vnc -vte -xattr -xen -xfs=
" LINGUAS=3D"-bg -de_DE -fr_FR -hu -it -tr -zh_CN" PYTHON_TARGETS=3D"python=
2_7" QEMU_SOFTMMU_TARGETS=3D"i386 x86_64 -aarch64 -alpha -arm -cris -lm32 -=
m68k -microblaze -microblazeel -mips -mips64 -mips64el -mipsel -moxie -nios=
2 -or1k -ppc -ppc64 -ppcemb -s390x -sh4 -sh4eb -sparc -sparc64 -tricore -un=
icore32 -xtensa -xtensaeb" QEMU_USER_TARGETS=3D"-aarch64 -alpha -arm -armeb=
 -cris -hppa -i386 -m68k -microblaze -microblazeel -mips -mips64 -mips64el =
-mipsel -mipsn32 -mipsn32el -nios2 -or1k -ppc -ppc64 -ppc64abi32 -ppc64le -=
s390x -sh4 -sh4eb -sparc -sparc32plus -sparc64 -tilegx -x86_64" 0 KiB

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
