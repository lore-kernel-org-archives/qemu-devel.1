Received: from eggs.gnu.org ([2001:4830:134:3::10]:58892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cTSWc-0006Ig-ST
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 07:06:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cTSWX-0001NA-Pi
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 07:06:06 -0500
Received: from indium.canonical.com ([91.189.90.7]:43384)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cTSWX-0001My-KH
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 07:06:01 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cTSWW-0001xw-Ko
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 12:06:00 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 992CA2E80AE
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 12:06:00 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Jan 2017 11:45:36 -0000
From: Thomas Huth <1623276@bugs.launchpad.net>
Reply-To: Bug 1623276 <1623276@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160914004324.1924.17597.malonedeb@chaenomeles.canonical.com>
Message-Id: <20170117114536.14243.42763.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1623276] Re: qemu 2.7 / iPXE crash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Commit 423f7cf233fe262 has been released with QEMU v2.8

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1623276

Title:
  qemu 2.7 / iPXE crash

Status in QEMU:
  Fix Released

Bug description:
  I am running Arch linux

  vanilla 4.7.2 kernel
  qemu 2.7
  libvirt 2.2.0
  virt-manager 1.4.0

  =

  Since the upgrade from qemu 2.6.1 to 2.7 a few days ago. I'm no longer
  able to PXE boot at all. Everything else appears to function normally.
  Non PXE booting and everything else is perfect. Obviously have
  restarted everying etc. Have tried the various network drivers also.

  This occurs on domains created with 2.6.1 or with 2.7

  When I choose PXE boot, the machine moves to a paused state (crashed)
  immediately after the 'starting PXE rom execution...' message appears.

  Reverting to qemu 2.6.1 package corrects the issue.

  The qemu.log snippet follows below.

  I'm not sure how to troubleshoot this problem to determine if it's a
  packaging error by the distribution or a problem with qemu/kvm/kernel?

  Any help would be much appreciated - Thanks,
  Greg

  --- qemu.log:

  =

  2016-09-12 16:36:33.867+0000: starting up libvirt version: 2.2.0, qemu
  version: 2.7.0, hostname: seneca
  LC_ALL=3DC PATH=3D/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin
  QEMU_AUDIO_DRV=3Dspice /usr/sbin/qemu-system-x86_64 -name guest=3Dc,debug-
  threads=3Don -S -object
  secret,id=3DmasterKey0,format=3Draw,file=3D/var/lib/libvirt/qemu/domain-6-
  c/master-key.aes -machine pc-i440fx-2.7,accel=3Dkvm,usb=3Doff,vmport=3Doff
  -cpu Nehalem -m 2048 -realtime mlock=3Doff -smp
  1,sockets=3D1,cores=3D1,threads=3D1 -uuid 348009be-26d5-4dc7-b515-
  e8b45f5117ac -no-user-config -nodefaults -chardev
  socket,id=3Dcharmonitor,path=3D/var/lib/libvirt/qemu/domain-6-
  c/monitor.sock,server,nowait -mon
  chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol -rtc base=3Dutc,driftfi=
x=3Dslew
  -global kvm-pit.lost_tick_policy=3Ddiscard -no-hpet -no-shutdown -global
  PIIX4_PM.disable_s3=3D1 -global PIIX4_PM.disable_s4=3D1 -boot
  menu=3Don,strict=3Don -device ich9-usb-ehci1,id=3Dusb,bus=3Dpci.0,addr=3D=
0x6.0x7
  -device ich9-usb-
  uhci1,masterbus=3Dusb.0,firstport=3D0,bus=3Dpci.0,multifunction=3Don,addr=
=3D0x6
  -device ich9-usb-
  uhci2,masterbus=3Dusb.0,firstport=3D2,bus=3Dpci.0,addr=3D0x6.0x1 -device =
ich9-
  usb-uhci3,masterbus=3Dusb.0,firstport=3D4,bus=3Dpci.0,addr=3D0x6.0x2 -dev=
ice
  virtio-serial-pci,id=3Dvirtio-serial0,bus=3Dpci.0,addr=3D0x5 -drive
  file=3D/var/lib/libvirt/images/c.qcow2,format=3Dqcow2,if=3Dnone,id=3Ddriv=
e-
  virtio-disk0 -device virtio-blk-
  pci,scsi=3Doff,bus=3Dpci.0,addr=3D0x7,drive=3Ddrive-virtio-disk0,id=3Dvir=
tio-
  disk0,bootindex=3D1 -netdev tap,fd=3D28,id=3Dhostnet0 -device
  rtl8139,netdev=3Dhostnet0,id=3Dnet0,mac=3D52:54:00:a0:95:7c,bus=3Dpci.0,a=
ddr=3D0x
  3 -chardev pty,id=3Dcharserial0 -device isa-
  serial,chardev=3Dcharserial0,id=3Dserial0 -chardev
  socket,id=3Dcharchannel0,path=3D/var/lib/libvirt/qemu/channel/target/doma=
in
  -6-c/org.qemu.guest_agent.0,server,nowait -device
  virtserialport,bus=3Dvirtio-
  serial0.0,nr=3D1,chardev=3Dcharchannel0,id=3Dchannel0,name=3Dorg.qemu.gue=
st_age
  nt.0 -chardev spicevmc,id=3Dcharchannel1,name=3Dvdagent -device
  virtserialport,bus=3Dvirtio-
  serial0.0,nr=3D2,chardev=3Dcharchannel1,id=3Dchannel1,name=3Dcom.redhat.s=
pice.0
  -device usb-tablet,id=3Dinput0,bus=3Dusb.0,port=3D1 -spice
  port=3D5901,addr=3D127.0.0.1,disable-ticketing,image-
  compression=3Doff,seamless-migration=3Don -device qxl-
  vga,id=3Dvideo0,ram_size=3D67108864,vram_size=3D67108864,vram64_size_mb=
=3D0,vga
  mem_mb=3D16,max_outputs=3D1,bus=3Dpci.0,addr=3D0x2 -device intel-
  hda,id=3Dsound0,bus=3Dpci.0,addr=3D0x4 -device hda-duplex,id=3Dsound0-
  codec0,bus=3Dsound0.0,cad=3D0 -chardev spicevmc,id=3Dcharredir0,name=3Dus=
bredir
  -device usb-redir,chardev=3Dcharredir0,id=3Dredir0,bus=3Dusb.0,port=3D2
  -chardev spicevmc,id=3Dcharredir1,name=3Dusbredir -device usb-
  redir,chardev=3Dcharredir1,id=3Dredir1,bus=3Dusb.0,port=3D3 -device virti=
o-
  balloon-pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x8 -msg timestamp=3Don
  char device redirected to /dev/pts/0 (label charserial0)
  main_channel_link: add main channel client
  red_dispatcher_set_cursor_peer: =

  inputs_connect: inputs channel client create
  KVM internal error. Suberror: 1
  emulation failure
  EAX=3D801a8d00 EBX=3D000000a0 ECX=3D00002e20 EDX=3D0009d5e8
  ESI=3D7ffa3c00 EDI=3D7fef4000 EBP=3Dffffffff ESP=3D00007b92
  EIP=3D000006ab EFL=3D00000087 [--S--PC] CPL=3D0 II=3D0 A20=3D1 SMM=3D0 HL=
T=3D0
  ES =3D0000 00000000 ffffffff 00c09300
  CS =3D9c4c 0009c4c0 ffffffff 00809b00
  SS =3D0000 00000000 ffffffff 00809300
  DS =3D9cd0 0009cd00 ffffffff 00c09300
  FS =3D0000 00000000 ffffffff 00c09300
  GS =3D0000 00000000 ffffffff 00c09300
  LDT=3D0000 00000000 0000ffff 00008200
  TR =3D0000 00000000 0000ffff 00008b00
  GDT=3D     00000000 00000000
  IDT=3D     00000000 000003ff
  CR0=3D00000010 CR2=3D00000000 CR3=3D00000000 CR4=3D00000000
  DR0=3D0000000000000000 DR1=3D0000000000000000 DR2=3D0000000000000000
  DR3=3D0000000000000000 =

  DR6=3D00000000ffff0ff0 DR7=3D0000000000000400
  EFER=3D0000000000000000
  Code=3D00 16 66 9c 66 60 0f a8 0f a0 06 1e 16 0e fa 2e 8e 1e 90 06 <0f>
  ae 06 d0 1c 0f 01 0e c6 1c 0f 01 06 c0 1c fc 66 b9 38 00 00 00 66 ba 10
  02 00 00 66 68

  =

  --- /proc/cpuinfo
  processor       : 0
  vendor_id       : GenuineIntel
  cpu family      : 6
  model           : 26
  model name      : Intel(R) Core(TM) i7 CPU         950  @ 3.07GHz
  stepping        : 5
  microcode       : 0x11
  cpu MHz         : 3066.648
  cache size      : 8192 KB
  physical id     : 0
  siblings        : 8
  core id         : 0
  cpu cores       : 4
  apicid          : 0
  initial apicid  : 0
  fpu             : yes
  fpu_exception   : yes
  cpuid level     : 11
  wp              : yes
  flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr
  pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
  syscall nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl
  xtopology nonstop_tsc aperfmperf eagerfpu pni dtes64 monitor ds_cpl vmx
  est tm2 ssse3 cx16 xtpr pdcm sse4_1 sse4_2 popcnt lahf_lm tpr_shadow
  vnmi flexpriority ept vpid dtherm
  bugs            :
  bogomips        : 6135.85
  clflush size    : 64
  cache_alignment : 64
  address sizes   : 36 bits physical, 48 bits virtual
  power management:

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1623276/+subscriptions
