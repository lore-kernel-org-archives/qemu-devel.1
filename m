Received: from [2001:4830:134:3::10] (port=60729 helo=eggs.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fpd1y-0007Ia-P8
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 13:22:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fpd1r-0002np-Cd
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 13:22:48 -0400
Received: from indium.canonical.com ([91.189.90.7]:44862)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fpd1r-0002lv-5n
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 13:22:47 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fpbyy-00044o-JR
	for <qemu-devel@nongnu.org>; Tue, 14 Aug 2018 16:15:44 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 9194D2E851F
	for <qemu-devel@nongnu.org>; Tue, 14 Aug 2018 16:15:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Aug 2018 16:05:35 -0000
From: Thomas Huth <1487264@bugs.launchpad.net>
Reply-To: Bug 1487264 <1487264@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150821022225.22009.40710.malonedeb@gac.canonical.com>
Message-Id: <153426273538.24449.734853307492114611.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1487264] Re: Windows 8.1/10 Crashes during
 upgrade - SYSTEM_THREAD_EXCEPTION_NOT_HANDLED
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Looking through old bug tickets... can you still reproduce this issue
with the latest version of QEMU? Or could we close this ticket nowadays?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1487264

Title:
  Windows 8.1/10 Crashes during upgrade -
  SYSTEM_THREAD_EXCEPTION_NOT_HANDLED

Status in QEMU:
  Incomplete

Bug description:
  Ever since Windows 8.x, 10 I cannot upgrade or upgrade to tech builds
  within Windows 10 without hard shutting off the VM.

  Physical hardware: Intel(R) Core(TM) i7-4910MQ CPU @ 2.90GHz [Haswell]

  QEMU 2.1-2.3.x seem all broken, I am using Q35 chipset w/ BIOS mode.

  Launch command via virt-manager/libvirt launch:

  QEMU_AUDIO_DRV=3Dspice /usr/bin/qemu-kvm -name Windows_10 -S -machine
  pc-q35-2.3,accel=3Dkvm,usb=3Doff -cpu Haswell-
  noTSX,hv_time,hv_relaxed,hv_vapic,hv_spinlocks=3D0x1fff -m 4096
  -realtime mlock=3Doff -smp 2,sockets=3D2,cores=3D1,threads=3D1 -uuid ed7e=
372b-
  ebf9-4feb-a305-869f82e6aaee -no-user-config -nodefaults -chardev
  socket,id=3Dcharmonitor,path=3D/var/lib/libvirt/qemu/Windows_10.monitor,s=
erver,nowait
  -mon chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol -rtc
  base=3Dlocaltime,driftfix=3Dslew -global kvm-pit.lost_tick_policy=3Ddisca=
rd
  -no-hpet -no-shutdown -global PIIX4_PM.disable_s3=3D1 -global
  PIIX4_PM.disable_s4=3D1 -boot menu=3Doff,strict=3Don -device
  i82801b11-bridge,id=3Dpci.1,bus=3Dpcie.0,addr=3D0x1e -device pci-
  bridge,chassis_nr=3D2,id=3Dpci.2,bus=3Dpci.1,addr=3D0x1 -device ich9-usb-
  ehci1,id=3Dusb,bus=3Dpci.2,addr=3D0x3.0x7 -device ich9-usb-
  uhci1,masterbus=3Dusb.0,firstport=3D0,bus=3Dpci.2,multifunction=3Don,addr=
=3D0x3
  -device ich9-usb-
  uhci2,masterbus=3Dusb.0,firstport=3D2,bus=3Dpci.2,addr=3D0x3.0x1 -device =
ich9
  -usb-uhci3,masterbus=3Dusb.0,firstport=3D4,bus=3Dpci.2,addr=3D0x3.0x2 -de=
vice
  virtio-serial-pci,id=3Dvirtio-serial0,bus=3Dpci.2,addr=3D0x4 -drive
  file=3D/var/lib/libvirt/images/Windows_10.qcow2,if=3Dnone,id=3Ddrive-
  sata0-0-0,format=3Dqcow2 -device ide-hd,bus=3Dide.0,drive=3Ddrive-
  sata0-0-0,id=3Dsata0-0-0,bootindex=3D1 -drive file=3D/usr/share/virtio-win
  /virtio-win-0.1.109.iso,if=3Dnone,media=3Dcdrom,id=3Ddrive-
  sata0-0-1,readonly=3Don,format=3Draw -device ide-cd,bus=3Dide.1,drive=3Dd=
rive-
  sata0-0-1,id=3Dsata0-0-1 -netdev
  tap,fd=3D22,id=3Dhostnet0,vhost=3Don,vhostfd=3D23 -device virtio-net-
  pci,netdev=3Dhostnet0,id=3Dnet0,mac=3D52:54:00:54:14:20,bus=3Dpci.2,addr=
=3D0x1
  -chardev pty,id=3Dcharserial0 -device isa-
  serial,chardev=3Dcharserial0,id=3Dserial0 -chardev
  spicevmc,id=3Dcharchannel0,name=3Dvdagent -device virtserialport,bus
  =3Dvirtio-
  serial0.0,nr=3D1,chardev=3Dcharchannel0,id=3Dchannel0,name=3Dcom.redhat.s=
pice.0
  -device usb-tablet,id=3Dinput0 -spice port=3D5900,addr=3D127.0.0.1,disabl=
e-
  ticketing,image-compression=3Doff,seamless-migration=3Don -device qxl-
  vga,id=3Dvideo0,ram_size=3D268435456,vram_size=3D268435456,vgamem_mb=3D25=
6,bus=3Dpcie.0,addr=3D0x1
  -device ich9-intel-hda,id=3Dsound0,bus=3Dpci.2,addr=3D0x2 -device hda-
  duplex,id=3Dsound0-codec0,bus=3Dsound0.0,cad=3D0 -device usb-
  host,hostbus=3D1,hostaddr=3D2,id=3Dhostdev0 -device virtio-balloon-
  pci,id=3Dballoon0,bus=3Dpci.2,addr=3D0x5 -msg timestamp=3Don

  The workaround I've been able to come up with is to set boot menu in
  virt-manager, then put in a bootable CD so I have enough time to hard
  power off the QEMU/KVM instance, when I power it back on, it continues
  upgrade/install without issue, each time it needs to restart however I
  go though same exercise.

  Anything known about this issue? The workaround is a kludge, but it
  does get it to upgrade/install Windows 8.1, and upgrade between
  Windows 10 X builds.

  Thanks,
  Shawn

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1487264/+subscriptions
