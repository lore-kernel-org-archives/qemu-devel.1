Received: from eggs.gnu.org ([2001:4830:134:3::10]:39856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cKNVv-0001cY-Mw
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 05:55:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cKNVs-0003c0-Ic
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 05:55:51 -0500
Received: from indium.canonical.com ([91.189.90.7]:39972)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cKNVs-0003bl-CM
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 05:55:48 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cKNVq-0000hF-Fg
	for <qemu-devel@nongnu.org>; Fri, 23 Dec 2016 10:55:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 8A7D62E80CB
	for <qemu-devel@nongnu.org>; Fri, 23 Dec 2016 10:55:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Dec 2016 10:46:11 -0000
From: LPNow <77777@tutanota.de>
Reply-To: Bug 1649040 <1649040@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20161211031531.25603.88090.malonedeb@gac.canonical.com>
Message-Id: <20161223104611.2913.11365.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1649040] Re: Ubuntu 16.04.1 Grub Splash Doesn't
 Appear
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

It's the same in 2.8.0 but I will test it again when I get some time for
vmware.

I used vmware because it offers better resolution.

After posting this issue I have learned a little about virtio and for a
few times I was able to boot it with -vag virtio and this was really
nice. I was able to resize and qemu will fill the screen to fit.

But now when I boot with -vga virtio it just sits there and won't start
Ubuntu.

These are the options I'm using;

qemu-system-x86_64 -drive if=3Dnone,id=3Ddrive0,cache=3Dnone,aio=3Dthreads,=
format=3Draw,file=3Dubuntu.img,index=3D0 \
-object iothread,id=3Diothread0 \
-machine type=3Dq35,accel=3Dkvm,kernel_irqchip=3Don \
-device virtio-blk-pci,drive=3Ddrive0,scsi=3Doff,config-wce=3Doff,iothread=
=3Diothread0 \
-cpu host \
--enable-kvm \
-smp 2 \
-m 4096 \
-vga virtio \
-soundhw ac97 \
-usbdevice tablet \
-rtc base=3Dlocaltime

I do not understand how QEMU boots options just fine for a few times,
then another time you go back and try and nothing works...

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1649040

Title:
  Ubuntu 16.04.1 Grub Splash Doesn't Appear

Status in QEMU:
  New

Bug description:
  My Specs:

  Slackware 14.2 x86_64 > Host
  QEMU 2.7.0

  Ubuntu 16.04.1 x86_64 > Guest

  Start options for Ubuntu:

  qemu-system-x86_64 -drive format=3Draw,file=3Dubuntu.img \
  -cpu host \
  --enable-kvm \
  -smp 2 \
  -m 4096 \
  -vga vmware \
  -soundhw ac97 \
  -usbdevice tablet \
  -rtc base=3Dlocaltime \
  -usbdevice host:0781:5575

  I've started Ubuntu around 6-8 times, and I have only see the Grub
  Boot Splash appear twice, so pretty much without fail it typically
  boots past the grub splash and automatically boots...

  These are the /etc/default/grub settings; (I only changed these
  options GRUB_TIMEOUT=3D15 and GRUB_GFXMODE=3D1440x900)

  # If you change this file, run 'update-grub' afterwards to update
  # /boot/grub/grub.cfg.
  # For full documentation of the options in this file, see:
  #   info -f grub -n 'Simple configuration'

  GRUB_DEFAULT=3D0
  GRUB_HIDDEN_TIMEOUT=3D0
  GRUB_HIDDEN_TIMEOUT_QUIET=3Dtrue
  GRUB_TIMEOUT=3D15
  GRUB_DISTRIBUTOR=3D`lsb_release -i -s 2> /dev/null || echo Debian`
  GRUB_CMDLINE_LINUX_DEFAULT=3D"quiet splash"
  GRUB_CMDLINE_LINUX=3D""

  # Uncomment to enable BadRAM filtering, modify to suit your needs
  # This works with Linux (no patch required) and with any kernel that obta=
ins
  # the memory map information from GRUB (GNU Mach, kernel of FreeBSD ...)
  #GRUB_BADRAM=3D"0x01234567,0xfefefefe,0x89abcdef,0xefefefef"

  # Uncomment to disable graphical terminal (grub-pc only)
  #GRUB_TERMINAL=3Dconsole

  # The resolution used on graphical terminal
  # note that you can use only modes which your graphic card supports via V=
BE
  # you can see them in real GRUB with the command `vbeinfo'
  GRUB_GFXMODE=3D1440x900

  # Uncomment if you don't want GRUB to pass "root=3DUUID=3Dxxx" parameter =
to Linux
  #GRUB_DISABLE_LINUX_UUID=3Dtrue

  # Uncomment to disable generation of recovery mode menu entries
  #GRUB_DISABLE_RECOVERY=3D"true"

  # Uncomment to get a beep at grub start
  #GRUB_INIT_TUNE=3D"480 440 1"

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1649040/+subscriptions
