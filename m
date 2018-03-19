Received: from eggs.gnu.org ([2001:4830:134:3::10]:60679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1exp1T-00020g-S1
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 03:16:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1exp1Q-0007YX-Lk
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 03:15:59 -0400
Received: from indium.canonical.com ([91.189.90.7]:47826)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1exp1Q-0007XO-DX
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 03:15:56 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1exp1P-0004BL-H6
	for <qemu-devel@nongnu.org>; Mon, 19 Mar 2018 07:15:55 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 7F8372E80C7
	for <qemu-devel@nongnu.org>; Mon, 19 Mar 2018 07:15:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Mar 2018 06:56:39 -0000
From: Thomas Huth <1435359@bugs.launchpad.net>
Reply-To: Bug 1435359 <1435359@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150323144724.14969.83414.malonedeb@wampee.canonical.com>
Message-Id: <152144259964.7125.7228202459386472227.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1435359] Re: Booting kernel 3.19.2 fails most of
 the time
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Ok, thanks, so I'm closing this now.

** Changed in: qemu
       Status: Incomplete =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1435359

Title:
  Booting kernel 3.19.2 fails most of the time

Status in QEMU:
  Fix Released

Bug description:
  Host system: openSuSE 13.2 + kernel 4.0.0-rc4 + qemu 2.2.1.

  When I try to boot a virtual machine with Ubuntu 14.10 and kernel
  3.13.0 every boot succeeds. However, with kernel 3.19.2 booting fails
  most of the time. The following appears in /var/log/libvirt/qemu
  /ubuntu-vm.log when I try to boot that VM with kernel 3.19.2:

  2015-03-23 02:44:18.801+0000: starting up
  LC_ALL=3DC PATH=3D/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin=
:/bin QEMU_AUDIO_DRV=3Dspice /usr/bin/qemu-system-x86_64 -name ubuntu-vm -S=
 -machine pc-i440fx-2.1,accel=3Dkvm,usb=3Doff -cpu Haswell -m 2048 -realtim=
e mlock=3Doff -smp 4,sockets=3D4,cores=3D1,threads=3D1 -uuid 395110dc-9fbe-=
4542-8fce-4ef958f24b2c -no-user-config -nodefaults -chardev socket,id=3Dcha=
rmonitor,path=3D/var/lib/libvirt/qemu/ubuntu-vm.monitor,server,nowait -mon =
chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol -rtc base=3Dutc,driftfix=
=3Dslew -global kvm-pit.lost_tick_policy=3Ddiscard -no-hpet -no-shutdown -g=
lobal PIIX4_PM.disable_s3=3D1 -global PIIX4_PM.disable_s4=3D1 -boot strict=
=3Don -device ich9-usb-ehci1,id=3Dusb,bus=3Dpci.0,addr=3D0x5.0x7 -device ic=
h9-usb-uhci1,masterbus=3Dusb.0,firstport=3D0,bus=3Dpci.0,multifunction=3Don=
,addr=3D0x5 -device ich9-usb-uhci2,masterbus=3Dusb.0,firstport=3D2,bus=3Dpc=
i.0,addr=3D0x5.0x1 -device ich9-usb-uhci3,masterbus=3Dusb.0,firstport=3D4,b=
us=3Dpci.0,addr=3D0x5.0x2 -device virtio-serial-pci,id=3Dvirtio-serial0,bus=
=3Dpci.0,addr=3D0x4 -drive file=3D/var/lib/libvirt/images/ubuntusaucy.qcow2=
,if=3Dnone,id=3Ddrive-virtio-disk0,format=3Dqcow2 -device virtio-blk-pci,sc=
si=3Doff,bus=3Dpci.0,addr=3D0x7,drive=3Ddrive-virtio-disk0,id=3Dvirtio-disk=
0,bootindex=3D1 -drive file=3D/var/lib/libvirt/images/ubuntu-14.04-mini.iso=
,if=3Dnone,id=3Ddrive-ide0-0-0,readonly=3Don,format=3Draw -device ide-cd,bu=
s=3Dide.0,unit=3D0,drive=3Ddrive-ide0-0-0,id=3Dide0-0-0,bootindex=3D2 -netd=
ev tap,fd=3D22,id=3Dhostnet0,vhost=3Don,vhostfd=3D23 -device virtio-net-pci=
,netdev=3Dhostnet0,id=3Dnet0,mac=3D52:54:00:5e:71:5e,bus=3Dpci.0,addr=3D0x3=
 -chardev spicevmc,id=3Dcharchannel0,name=3Dvdagent -device virtserialport,=
bus=3Dvirtio-serial0.0,nr=3D1,chardev=3Dcharchannel0,id=3Dchannel0,name=3Dc=
om.redhat.spice.0 -spice port=3D5900,addr=3D127.0.0.1,disable-ticketing,sea=
mless-migration=3Don -device qxl-vga,id=3Dvideo0,ram_size=3D67108864,vram_s=
ize=3D67108864,bus=3Dpci.0,addr=3D0x2 -chardev spicevmc,id=3Dcharredir0,nam=
e=3Dusbredir -device usb-redir,chardev=3Dcharredir0,id=3Dredir0 -chardev sp=
icevmc,id=3Dcharredir1,name=3Dusbredir -device usb-redir,chardev=3Dcharredi=
r1,id=3Dredir1 -chardev spicevmc,id=3Dcharredir2,name=3Dusbredir -device us=
b-redir,chardev=3Dcharredir2,id=3Dredir2 -chardev spicevmc,id=3Dcharredir3,=
name=3Dusbredir -device usb-redir,chardev=3Dcharredir3,id=3Dredir3 -device =
virtio-balloon-pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x8 -object rng-random,=
id=3Drng0,filename=3D/dev/random -device virtio-rng-pci,rng=3Drng0,bus=3Dpc=
i.0,addr=3D0x9 -msg timestamp=3Don
  main_channel_link: add main channel client
  main_channel_handle_parsed: net test: latency 0.229000 ms, bitrate 284444=
44444 bps (27126.736111 Mbps)
  red_dispatcher_set_cursor_peer: =

  inputs_connect: inputs channel client create
  ((null):30728): SpiceWorker-ERROR **: red_worker.c:8337:red_marshall_qxl_=
drawable: invalid type
  KVM: injection failed, MSI lost (Input/output error)
  qemu-system-x86_64: /home/bart/software/qemu-2.2.1/hw/net/vhost_net.c:264=
: vhost_net_stop_one: Assertion `r >=3D 0' failed.
  2015-03-23 02:44:44.952+0000: shutting down

  That message is similar to the message reported by the older qemu
  version provided by openSuse (qemu 2.1.0 + qemu-kvm 2.1.0):

  2015-03-21 13:51:00.724+0000: starting up
  LC_ALL=3DC PATH=3D/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin=
:/bin QEMU_AUDIO_DRV=3Dspice /usr/bin/qemu-system-x86_64 -name ubuntu-vm -S=
 -machine pc-i440fx-2.1,accel=3Dkvm,usb=3Doff -cpu Haswell -m 1024 -realtim=
e mlock=3Doff -smp 4,sockets=3D4,cores=3D1,threads=3D1 -uuid 395110dc-9fbe-=
4542-8fce-4ef958f24b2c -no-user-config -nodefaults -chardev socket,id=3Dcha=
rmonitor,path=3D/var/lib/libvirt/qemu/ubuntu-vm.monitor,server,nowait -mon =
chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol -rtc base=3Dutc,driftfix=
=3Dslew -global kvm-pit.lost_tick_policy=3Ddiscard -no-hpet -no-shutdown -g=
lobal PIIX4_PM.disable_s3=3D1 -global PIIX4_PM.disable_s4=3D1 -boot strict=
=3Don -device ich9-usb-ehci1,id=3Dusb,bus=3Dpci.0,addr=3D0x5.0x7 -device ic=
h9-usb-uhci1,masterbus=3Dusb.0,firstport=3D0,bus=3Dpci.0,multifunction=3Don=
,addr
  =3D0x5 -device ich9-usb-uhci2,masterbus=3Dusb.0,firstport=3D2,bus=3Dpci.0=
,addr=3D0x5.0x1 -device ich9-usb-uhci3,masterbus=3Dusb.0,firstport=3D4,bus=
=3Dpci.0,addr=3D0x5.0x2 -device virtio-serial-pci,id=3Dvirtio-serial0,bus=
=3Dpci.0,addr=3D0x6 -drive file=3D/var/lib/libvirt/images/ubuntusaucy.qcow2=
,if=3Dnone,id=3Ddrive-virtio-disk0,format=3Dqcow2 -device virtio-blk-pci,sc=
si=3Doff,bus=3Dpci.0,addr=3D0x7,drive=3Ddrive-virtio-disk0,id=3Dvirtio-disk=
0,bootindex=3D1 -drive file=3D/var/lib/libvirt/images/ubuntu-14.04-mini.iso=
,if=3Dnone,id=3Ddrive-ide0-0-0,readonly=3Don,format=3Draw -device ide-cd,bu=
s=3Dide.0,unit=3D0,drive=3Ddrive-ide0-0-0,id
  =3Dide0-0-0,bootindex=3D2 -netdev tap,fd=3D22,id=3Dhostnet0,vhost=3Don,vh=
ostfd=3D23 -device virtio-net-pci,netdev=3Dhostnet0,id=3Dnet0,mac=3D52:54:0=
0:5e:71:5e,bus=3Dpci.0,addr=3D0x3 -chardev pty,id=3Dcharserial0 -device isa=
-serial,chardev=3Dcharserial0,id=3Dserial0 -chardev spicevmc,id=3Dcharchann=
el0,name=3Dvdagent -device virtserialport,bus=3Dvirtio-serial0.0,nr=3D1,cha=
rdev=3Dcharchannel0,id=3Dchannel0,name=3Dcom.redhat.spice.0 -spice port=3D5=
900,addr=3D127.0.0.1,disable-ticketing,seamless-migration=3Don -device qxl-=
vga,id=3Dvideo0,ram_size=3D67108864,vram_size=3D67108864,bus=3Dpci.0,addr=
=3D0x2 -device intel-hda,id=3Dsound0,bus=3Dpci.0,addr=3D0x4 -device hda-dup=
lex,id=3Dsound0-codec0,bus=3Dsound0.0,cad=3D0 -chardev spicevmc,id=3Dcharre=
dir0,name=3Dusbredir -device usb-redir,chardev=3Dcharredir0,id=3Dredir0 -ch=
ardev spicevmc,id=3Dcharredir1,
  name=3Dusbredir -device usb-redir,chardev=3Dcharredir1,id=3Dredir1 -chard=
ev spicevmc,id=3Dcharredir2,name=3Dusbredir -device usb-redir,chardev=3Dcha=
rredir2,id=3Dredir2 -chardev spicevmc,id=3Dcharredir3,name=3Dusbredir -devi=
ce usb-redir,chardev=3Dcharredir3,id=3Dredir3 -device virtio-balloon-pci,id=
=3Dballoon0,bus=3Dpci.0,addr=3D0x8 -object rng-random,id=3Drng0,filename=3D=
/dev/random -device virtio-rng-pci,rng=3Drng0,bus=3Dpci.0,addr=3D0x9 -msg t=
imestamp=3Don
  char device redirected to /dev/pts/0 (label charserial0)
  main_channel_link: add main channel client
  main_channel_handle_parsed: net test: latency 0.233000 ms, bitrate 179649=
12280 bps (17132.675438 Mbps)
  red_dispatcher_set_cursor_peer: =

  inputs_connect: inputs channel client create
  ((null):5798): SpiceWorker-ERROR **: red_worker.c:8337:red_marshall_qxl_d=
rawable: invalid type
  red_channel_client_disconnect: 0x7f90397ec0c0 (channel 0x7f903812a090 typ=
e 5 id 0)
  ((null):8349): Spice-Warning **: red_channel.c:1661:red_channel_remove_cl=
ient: channel type 5 id 0 - channel->thread_id (0x7f90362cba80) !=3D pthrea=
d_self (0x7f9011fff700).If one of the threads is !=3D io-thread && !=3D vcp=
u-thread, this might be a BUG
  snd_channel_put: sound channel freed
  red_channel_client_disconnect: 0x7f903a04c4c0 (channel 0x7f903812a230 typ=
e 6 id 0)
  ((null):8349): Spice-Warning **: red_channel.c:1661:red_channel_remove_cl=
ient: channel type 6 id 0 - channel->thread_id (0x7f90362cba80) !=3D pthrea=
d_self (0x7f9011fff700).If one of the threads is !=3D io-thread && !=3D vcp=
u-thread, this might be a BUG
  snd_channel_put: sound channel freed
  KVM: injection failed, MSI lost (Input/output error)
  qemu-system-x86_64: /home/abuild/rpmbuild/BUILD/qemu-2.1.0/hw/virtio/vhos=
t.c:1003: vhost_virtqueue_mask: Assertion `r >=3D 0' failed.
  2015-03-21 15:30:10.148+0000: shutting down

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1435359/+subscriptions
