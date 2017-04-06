Received: from eggs.gnu.org ([2001:4830:134:3::10]:46539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cwAwG-0003Dz-3L
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 13:11:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cwAwC-0005jl-RG
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 13:11:16 -0400
Received: from indium.canonical.com ([91.189.90.7]:60365)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cwAwC-0005h1-Ib
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 13:11:12 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cwAw9-0005Q9-KT
	for <qemu-devel@nongnu.org>; Thu, 06 Apr 2017 17:11:09 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id ACF572E80C3
	for <qemu-devel@nongnu.org>; Thu,  6 Apr 2017 17:11:08 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Apr 2017 17:02:24 -0000
From: rubenvb <1635339@bugs.launchpad.net>
Reply-To: Bug 1635339 <1635339@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20161020160532.23339.63373.malonedeb@soybean.canonical.com>
Message-Id: <20170406170224.12541.40916.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1635339] Re: qxl_pre_save assertion failure on vm
 "save"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I'm running into this issue as well:
Arch Linux
Qemu 2.8.0
spice guest tools: 0.132
QXL driver version (as reported by Windows Device Manager): 10.0.0.15000

Everything else works great. It would save me a lot of rebooting if this co=
uld get fixed.
If there is anything I can do or try, I'll be glad to help.

Relevant log of VM boot and crash on selecting suspend action in virt-
manager:

2017-04-06 16:59:24.681+0000: starting up libvirt version: 3.1.0, qemu vers=
ion: 2.8.0, hostname: arch-vaio.localdomain
LC_ALL=3DC PATH=3D/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin QEMU_AU=
DIO_DRV=3Dspice /usr/bin/qemu-system-x86_64 -name guest=3DWindows,debug-thr=
eads=3Don -S -object secret,id=3DmasterKey0,format=3Draw,file=3D/var/lib/li=
bvirt/qemu/domain-9-Windows/master-key.aes -machine pc-i440fx-2.7,accel=3Dk=
vm,usb=3Doff,vmport=3Doff,dump-guest-core=3Doff -cpu core2duo,hv_time,hv_re=
laxed,hv_vapic,hv_spinlocks=3D0x1fff -m 2048 -realtime mlock=3Doff -smp 2,s=
ockets=3D1,cores=3D2,threads=3D1 -uuid f14684d3-5f81-4743-8512-e516d85ca2c9=
 -no-user-config -nodefaults -chardev socket,id=3Dcharmonitor,path=3D/var/l=
ib/libvirt/qemu/domain-9-Windows/monitor.sock,server,nowait -mon chardev=3D=
charmonitor,id=3Dmonitor,mode=3Dcontrol -rtc base=3Dlocaltime,driftfix=3Dsl=
ew -global kvm-pit.lost_tick_policy=3Ddelay -no-hpet -no-shutdown -global P=
IIX4_PM.disable_s3=3D1 -global PIIX4_PM.disable_s4=3D1 -boot strict=3Don -d=
evice ich9-usb-ehci1,id=3Dusb,bus=3Dpci.0,addr=3D0x6.0x7 -device ich9-usb-u=
hci1,masterbus=3Dusb.0,firstport=3D0,bus=3Dpci.0,multifunction=3Don,addr=3D=
0x6 -device ich9-usb-uhci2,masterbus=3Dusb.0,firstport=3D2,bus=3Dpci.0,addr=
=3D0x6.0x1 -device ich9-usb-uhci3,masterbus=3Dusb.0,firstport=3D4,bus=3Dpci=
.0,addr=3D0x6.0x2 -device virtio-serial-pci,id=3Dvirtio-serial0,bus=3Dpci.0=
,addr=3D0x5 -drive file=3D/mnt/media/Qemu/windows10.qcow2,format=3Dqcow2,if=
=3Dnone,id=3Ddrive-virtio-disk0 -device virtio-blk-pci,scsi=3Doff,bus=3Dpci=
.0,addr=3D0x7,drive=3Ddrive-virtio-disk0,id=3Dvirtio-disk0,bootindex=3D1 -d=
rive file=3D/usr/share/spice-guest-tools/spice-guest-tools.iso,format=3Draw=
,if=3Dnone,id=3Ddrive-ide0-0-1,readonly=3Don -device ide-cd,bus=3Dide.0,uni=
t=3D1,drive=3Ddrive-ide0-0-1,id=3Dide0-0-1 -netdev user,id=3Dhostnet0 -devi=
ce rtl8139,netdev=3Dhostnet0,id=3Dnet0,mac=3D52:54:00:44:08:31,bus=3Dpci.0,=
addr=3D0x3 -chardev pty,id=3Dcharserial0 -device isa-serial,chardev=3Dchars=
erial0,id=3Dserial0 -chardev spicevmc,id=3Dcharchannel0,name=3Dvdagent -dev=
ice virtserialport,bus=3Dvirtio-serial0.0,nr=3D1,chardev=3Dcharchannel0,id=
=3Dchannel0,name=3Dcom.redhat.spice.0 -device usb-tablet,id=3Dinput2,bus=3D=
usb.0,port=3D3 -spice port=3D5900,addr=3D127.0.0.1,disable-ticketing,image-=
compression=3Doff,seamless-migration=3Don -device qxl-vga,id=3Dvideo0,ram_s=
ize=3D67108864,vram_size=3D67108864,vram64_size_mb=3D0,vgamem_mb=3D16,max_o=
utputs=3D1,bus=3Dpci.0,addr=3D0x2 -device intel-hda,id=3Dsound0,bus=3Dpci.0=
,addr=3D0x4 -device hda-duplex,id=3Dsound0-codec0,bus=3Dsound0.0,cad=3D0 -c=
hardev spicevmc,id=3Dcharredir0,name=3Dusbredir -device usb-redir,chardev=
=3Dcharredir0,id=3Dredir0,bus=3Dusb.0,port=3D1 -chardev spicevmc,id=3Dcharr=
edir1,name=3Dusbredir -device usb-redir,chardev=3Dcharredir1,id=3Dredir1,bu=
s=3Dusb.0,port=3D2 -device virtio-balloon-pci,id=3Dballoon0,bus=3Dpci.0,add=
r=3D0x8 -msg timestamp=3Don
char device redirected to /dev/pts/6 (label charserial0)
main_channel_link: add main channel client
red_dispatcher_set_cursor_peer: =

inputs_connect: inputs channel client create
main_channel_handle_parsed: agent start
ehci warning: guest updated active QH
qemu-system-x86_64: /build/qemu/src/qemu-2.8.0/hw/display/qxl.c:2173: qxl_p=
re_save: Assertion `d->last_release_offset < d->vga.vram_size' failed.
2017-04-06 17:00:32.819+0000: shutting down, reason=3Dcrashed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1635339

Title:
  qxl_pre_save assertion failure on vm "save"

Status in QEMU:
  New

Bug description:
  When I try and save my Windows 10 VM, I see an assertion failure, and
  the machine is shut down.

  I see the following in the log:

  main_channel_handle_parsed: agent start
  qemu-system-x86_64: /build/qemu-Zwynhi/qemu-2.5+dfsg/hw/display/qxl.c:210=
1: qxl_pre_save: Assertion `d->last_release_offset < d->vga.vram_size' fail=
ed.
  2016-10-20 11:52:42.713+0000: shutting down

  Please let me know what other information would be relevant!

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1635339/+subscriptions
