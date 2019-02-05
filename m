Received: from eggs.gnu.org ([209.51.188.92]:41429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gqvGX-0006Dw-Me
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 02:35:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gqvGV-0004EJ-NB
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 02:35:33 -0500
Received: from indium.canonical.com ([91.189.90.7]:54180)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gqvGR-0004Br-NQ
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 02:35:29 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gqvGO-0000tT-KE
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 07:35:24 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 92E092E80C7
	for <qemu-devel@nongnu.org>; Tue,  5 Feb 2019 07:35:24 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 05 Feb 2019 07:22:41 -0000
From: Thomas Huth <1547012@bugs.launchpad.net>
Reply-To: Bug 1547012 <1547012@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160218130432.32646.62868.malonedeb@gac.canonical.com>
Message-Id: <154935136114.26163.7767317247673588895.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1547012] Re: qemu instances crashes with certain
 spice clients
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
https://bugs.launchpad.net/bugs/1547012

Title:
  qemu instances crashes with certain spice clients

Status in QEMU:
  Incomplete

Bug description:
  It's possible to make qemu instances crash when using certain browsers
  connected as spice-clients.

  my environment:

  - OpenStack Kilo installed from ubuntu-cloud archive (qemu-system-x86 2.2=
+dfsg-5expubuntu9.6~cloud0)
  - Using spice for web-console access

  How to reproduce:

  1. Start a VM on openstack
  2. access the OpenStack dashboard using iceweasel 43.0.4 =

  3. Open the spice-console
  4. Leave the console open for few minutes
  5. The VM will crash on the hypervisor

  The content of qemu log-files for this particular VM:

  2016-02-18 07:25:23.655+0000: starting up
  LC_ALL=3DC PATH=3D/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/sbin:/sbin=
:/bin QEMU_AUDIO_DRV=3Dspice /usr/bin/qemu-system-x86_64 -name instance-000=
0188f -S -machine pc-i440fx-utopic,accel=3Dkvm,usb=3Doff -cpu SandyBridge,+=
erms,+smep,+fsgsbase,+pdpe1gb,+rdrand,+f16c,+osxsave,+dca,+pcid,+pdcm,+xtpr=
,+tm2,+est,+smx,+vmx,+ds_cpl,+monitor,+dtes64,+pbe,+tm,+ht,+ss,+acpi,+ds,+v=
me -m 4096 -realtime mlock=3Doff -smp 1,sockets=3D1,cores=3D1,threads=3D1 -=
uuid cb04ff25-056f-4f82-a2e8-1fbb762bc29e -smbios type=3D1,manufacturer=3DO=
penStack Foundation,product=3DOpenStack Nova,version=3D2015.1.2,serial=3D00=
000000-0000-0000-0000-0cc47a45f5e8,uuid=3Dcb04ff25-056f-4f82-a2e8-1fbb762bc=
29e -no-user-config -nodefaults -chardev socket,id=3Dcharmonitor,path=3D/va=
r/lib/libvirt/qemu/instance-0000188f.monitor,server,nowait -mon chardev=3Dc=
harmonitor,id=3Dmonitor,mode=3Dcontrol -rtc base=3Dutc,driftfix=3Dslew -glo=
bal kvm-pit.lost_tick_policy=3Ddiscard -no-hpet -no-shutdown -boot strict=
=3Don -device piix3-usb-uhci,id=3Dusb,bus=3Dpci.0,addr=3D0x1.0x2 -device vi=
rtio-serial-pci,id=3Dvirtio-serial0,bus=3Dpci.0,addr=3D0x4 -drive file=3Drb=
d:libvirt/cb04ff25-056f-4f82-a2e8-1fbb762bc29e_disk:id=3Dcinder:key=3DAQBYm=
dBUCDq7IBAA/7tLevRjdF3Bo7522xkFqA=3D=3D:auth_supported=3Dcephx\;none:mon_ho=
st=3Dxxx.xxx.xxx.xxx\:6789\;xxx.xxx.xxx.xxx\:6789\;xxx.xxx.xxx.xxx\:6789\;x=
xx.xxx.xxx.xxx\:6789\;xxx.xxx.xxx.xxx\:6789,if=3Dnone,id=3Ddrive-virtio-dis=
k0,format=3Draw,cache=3Dwriteback -device virtio-blk-pci,scsi=3Doff,bus=3Dp=
ci.0,addr=3D0x5,drive=3Ddrive-virtio-disk0,id=3Dvirtio-disk0,bootindex=3D1 =
-netdev tap,fd=3D55,id=3Dhostnet0,vhost=3Don,vhostfd=3D58 -device virtio-ne=
t-pci,netdev=3Dhostnet0,id=3Dnet0,mac=3Dfa:16:3e:a4:74:3b,bus=3Dpci.0,addr=
=3D0x3 -chardev file,id=3Dcharserial0,path=3D/var/lib/nova/instances/cb04ff=
25-056f-4f82-a2e8-1fbb762bc29e/console.log -device isa-serial,chardev=3Dcha=
rserial0,id=3Dserial0 -chardev pty,id=3Dcharserial1 -device isa-serial,char=
dev=3Dcharserial1,id=3Dserial1 -chardev pty,id=3Dcharchannel0 -device virts=
erialport,bus=3Dvirtio-serial0.0,nr=3D1,chardev=3Dcharchannel0,id=3Dchannel=
0,name=3Dcom.redhat.spice.0 -spice port=3D5929,addr=3D172.24.1.30,disable-t=
icketing,seamless-migration=3Don -k fr-ch -device qxl-vga,id=3Dvideo0,ram_s=
ize=3D67108864,vram_size=3D67108864,vgamem_mb=3D16,bus=3Dpci.0,addr=3D0x2 -=
device virtio-balloon-pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x6 -msg timesta=
mp=3Don
  char device redirected to /dev/pts/64 (label charserial1)
  char device redirected to /dev/pts/65 (label charchannel0)
  main_channel_link: add main channel client
  main_channel_handle_parsed: net test: latency 44.136000 ms, bitrate 15753=
8461538 bps (150240.384615 Mbps)
  inputs_connect: inputs channel client create
  red_dispatcher_set_cursor_peer:
  ((null):18188): SpiceWorker-CRITICAL **: red_worker.c:1629:common_alloc_r=
ecv_buf: unexpected message size 214862 (max is 1024)
  2016-02-18 07:30:47.008+0000: shutting down

  It's funny because this error only occurs with certain browser
  versions, in my case with Iceweasel 43.0.4 and 44. 0 but it works well
  with Chrome 48.0.256482 and Firefox 44.0.2.

  Marking this a potential security issue as it could maybe lead to a
  denial-of-service if a user sends crafted packets.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1547012/+subscriptions
