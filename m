Received: from eggs.gnu.org ([2001:4830:134:3::10]:59452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cKe0p-0001K8-57
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:32:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cKe0n-0000gB-MH
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:32:51 -0500
Received: from indium.canonical.com ([91.189.90.7]:41561)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cKe0n-0000g5-Gw
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:32:49 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cKe0m-0003BX-D0
	for <qemu-devel@nongnu.org>; Sat, 24 Dec 2016 04:32:48 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 393942E8223
	for <qemu-devel@nongnu.org>; Sat, 24 Dec 2016 04:32:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Dec 2016 04:17:27 -0000
From: Launchpad Bug Tracker <1469924@bugs.launchpad.net>
Reply-To: Bug 1469924 <1469924@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150630020822.15284.41556.malonedeb@wampee.canonical.com>
Message-Id: <20161224041727.24507.89425.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1469924] Re: qemu-kvm crash when guest os is
 booting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1469924

Title:
  qemu-kvm crash when guest os is booting

Status in QEMU:
  Expired

Bug description:
  this is the command line of qemu.

  =

  2015-06-30 01:52:59.508+0000: starting up
  LC_ALL=3DC PATH=3D/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin QEMU_=
AUDIO_DRV=3Dnone /usr/bin/qemu-kvm -name rhel7 -S -machine pc-i440fx-2.1,ac=
cel=3Dkvm,usb=3Doff -cpu SandyBridge -m 2048 -realtime mlock=3Doff -smp 1,s=
ockets=3D1,cores=3D1,threads=3D1 -uuid 2a3f1d8a-850d-4e37-aecd-65cbf1e4e415=
 -no-user-config -nodefaults -chardev socket,id=3Dcharmonitor,path=3D/var/l=
ib/libvirt/qemu/rhel7.monitor,server,nowait -mon chardev=3Dcharmonitor,id=
=3Dmonitor,mode=3Dcontrol -rtc base=3Dutc,driftfix=3Dslew -global kvm-pit.l=
ost_tick_policy=3Ddiscard -no-hpet -no-shutdown -global PIIX4_PM.disable_s3=
=3D1 -global PIIX4_PM.disable_s4=3D1 -boot menu=3Don,strict=3Don -device ic=
h9-usb-ehci1,id=3Dusb,bus=3Dpci.0,addr=3D0x5.0x7 -device ich9-usb-uhci1,mas=
terbus=3Dusb.0,firstport=3D0,bus=3Dpci.0,multifunction=3Don,addr=3D0x5 -dev=
ice ich9-usb-uhci2,masterbus=3Dusb.0,firstport=3D2,bus=3Dpci.0,addr=3D0x5.0=
x1 -device ich9-usb-uhci3,masterbus=3Dusb.0,firstport=3D4,bus=3Dpci.0,addr=
=3D0x5.0x2 -device lsi,id=3Dscsi0,bus=3Dpci.0,addr=3D0x6 -device virtio-ser=
ial-pci,id=3Dvirtio-serial0,bus=3Dpci.0,addr=3D0x3 -drive file=3D/var/lib/l=
ibvirt/images/rhel7.qcow2,if=3Dnone,id=3Ddrive-ide0-0-0,format=3Dqcow2 -dev=
ice ide-hd,bus=3Dide.0,unit=3D0,drive=3Ddrive-ide0-0-0,id=3Dide0-0-0,bootin=
dex=3D1 -drive file=3D/home/jemmy/Downloads/rhel-server-7.1-x86_64-dvd.iso,=
if=3Dnone,id=3Ddrive-ide0-0-1,readonly=3Don,format=3Draw -device ide-cd,bus=
=3Dide.0,unit=3D1,drive=3Ddrive-ide0-0-1,id=3Dide0-0-1,bootindex=3D2 -netde=
v tap,fd=3D23,id=3Dhostnet0,vhost=3Don,vhostfd=3D24 -device virtio-net-pci,=
netdev=3Dhostnet0,id=3Dnet0,mac=3D52:54:00:b4:7b:bb,bus=3Dpci.0,addr=3D0x8 =
-chardev socket,id=3Dcharserial0,host=3D127.0.0.1,port=3D4555,telnet,server=
,nowait -device isa-serial,chardev=3Dcharserial0,id=3Dserial0 -chardev file=
,id=3Dcharserial1,path=3D/tmp/log.txt -device isa-serial,chardev=3Dcharseri=
al1,id=3Dserial1 -chardev pty,id=3Dcharconsole0 -device virtconsole,chardev=
=3Dcharconsole0,id=3Dconsole0 -vnc 127.0.0.1:0 -device qxl-vga,id=3Dvideo0,=
ram_size=3D67108864,vram_size=3D67108864,bus=3Dpci.0,addr=3D0x2 -device int=
el-hda,id=3Dsound0,bus=3Dpci.0,addr=3D0x4 -device hda-duplex,id=3Dsound0-co=
dec0,bus=3Dsound0.0,cad=3D0 -device virtio-balloon-pci,id=3Dballoon0,bus=3D=
pci.0,addr=3D0x7 -msg timestamp=3Don
  char device redirected to /dev/pts/2 (label charconsole0)

  =

  this is the error log of qemu when crash.

  id 0, group 0, virt start 0, virt end ffffffffffffffff, generation 0, del=
ta 0
  id 1, group 1, virt start 7fbe20000000, virt end 7fbe23ffe000, generation=
 0, delta 7fbe20000000
  id 2, group 1, virt start 7fbe1c000000, virt end 7fbe20000000, generation=
 0, delta 7fbe1c000000
  ((null):16237): Spice-CRITICAL **: red_memslots.c:69:validate_virt: virtu=
al address out of range
      virt=3D0x0+0x18 slot_id=3D0 group_id=3D1
      slot=3D0x0-0x0 delta=3D0x0
  Thread 4 (Thread 0x7fbeb3a32700 (LWP 16278)):
  #0  0x00007fbec182d407 in ioctl () at /lib64/libc.so.6
  #1  0x00007fbecc80e565 in kvm_vcpu_ioctl ()
  #2  0x00007fbecc80e61c in kvm_cpu_exec ()
  #3  0x00007fbecc7fd0a2 in qemu_kvm_cpu_thread_fn ()
  #4  0x00007fbecb2f652a in start_thread () at /lib64/libpthread.so.0
  #5  0x00007fbec183722d in clone () at /lib64/libc.so.6
  Thread 3 (Thread 0x7fbeb15ff700 (LWP 16287)):
  #0  0x00007fbecb2fe1cd in read () at /lib64/libpthread.so.0
  #1  0x00007fbec2a50499 in spice_backtrace_gstack () at /lib64/libspice-se=
rver.so.1
  #2  0x00007fbec2a57dae in spice_logv () at /lib64/libspice-server.so.1
  #3  0x00007fbec2a57f05 in spice_log () at /lib64/libspice-server.so.1
  #4  0x00007fbec2a177ff in validate_virt () at /lib64/libspice-server.so.1
  #5  0x00007fbec2a1791e in get_virt () at /lib64/libspice-server.so.1
  #6  0x00007fbec2a17fb9 in red_get_clip_rects () at /lib64/libspice-server=
.so.1
  #7  0x00007fbec2a1976f in red_get_drawable () at /lib64/libspice-server.s=
o.1
  #8  0x00007fbec2a30332 in red_process_commands.constprop () at /lib64/lib=
spice-server.so.1
  #9  0x00007fbec2a3638a in red_worker_main () at /lib64/libspice-server.so=
.1
  #10 0x00007fbecb2f652a in start_thread () at /lib64/libpthread.so.0
  #11 0x00007fbec183722d in clone () at /lib64/libc.so.6
  Thread 2 (Thread 0x7fbeb0bff700 (LWP 16289)):
  #0  0x00007fbecb2fb590 in pthread_cond_wait@@GLIBC_2.3.2 () at /lib64/lib=
pthread.so.0
  #1  0x00007fbecca954c9 in qemu_cond_wait ()
  #2  0x00007fbecca3bfe3 in vnc_worker_thread_loop ()
  #3  0x00007fbecca3c3c8 in vnc_worker_thread ()
  #4  0x00007fbecb2f652a in start_thread () at /lib64/libpthread.so.0
  #5  0x00007fbec183722d in clone () at /lib64/libc.so.6
  Thread 1 (Thread 0x7fbeccd2ca80 (LWP 16237)):
  #0  0x00007fbec182bd51 in ppoll () at /lib64/libc.so.6
  #1  0x00007fbecca4d2ec in qemu_poll_ns ()
  #2  0x00007fbecca4ca94 in main_loop_wait ()
  #3  0x00007fbecc7d58dd in main ()

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1469924/+subscriptions
