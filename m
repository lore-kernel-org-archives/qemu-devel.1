Received: from eggs.gnu.org ([2001:4830:134:3::10]:56432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1flqwU-00035o-6z
	for qemu-devel@nongnu.org; Sat, 04 Aug 2018 03:25:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1flqwQ-0002dW-Vp
	for qemu-devel@nongnu.org; Sat, 04 Aug 2018 03:25:38 -0400
Received: from indium.canonical.com ([91.189.90.7]:38872)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1flqwQ-0002cn-LH
	for qemu-devel@nongnu.org; Sat, 04 Aug 2018 03:25:34 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1flqwP-0005hn-Dp
	for <qemu-devel@nongnu.org>; Sat, 04 Aug 2018 07:25:33 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 5B8EC2E80C0
	for <qemu-devel@nongnu.org>; Sat,  4 Aug 2018 07:25:33 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 04 Aug 2018 07:17:22 -0000
From: changlimin <changlimin@h3c.com>
Reply-To: Bug 1785197 <1785197@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <153328835680.29549.10888277891028750813.malonedeb@chaenomeles.canonical.com>
Message-Id: <153336704250.31942.14522934786706415550.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1785197] Re: qemu 2.12.0 crash during install
 windows 10 with vga
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This commit has fixed it.
https://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3Da89fe6c3297

** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1785197

Title:
  qemu 2.12.0 crash during install windows 10 with vga

Status in QEMU:
  Fix Released

Bug description:
  Same issue as https://www.qubes-os.org/doc/windows-vm/ , it's not easy to=
 reproduced.
  cpu_physical_memory_snapshot_get_dirty: Assertion `start + length <=3D sn=
ap->end=E2=80=99 failed

  Qemu version is 2.12.0. =

  (gdb) bt
  #0  0x00007f504ed6fc37 in raise () from /lib/x86_64-linux-gnu/libc.so.6
  #1  0x00007f504ed73028 in abort () from /lib/x86_64-linux-gnu/libc.so.6
  #2  0x00007f504ed68bf6 in ?? () from /lib/x86_64-linux-gnu/libc.so.6
  #3  0x00007f504ed68ca2 in __assert_fail () from /lib/x86_64-linux-gnu/lib=
c.so.6
  #4  0x00005585bbdc9641 in cpu_physical_memory_snapshot_get_dirty (snap=3D=
snap@entry=3D0x5585bfdc2ff0, start=3D<optimized out>, length=3D<optimized o=
ut>)
      at /qemu-2.12/exec.c:1264
  #5  0x00005585bbe2b4de in memory_region_snapshot_get_dirty (mr=3Dmr@entry=
=3D0x5585c06e3d10, snap=3Dsnap@entry=3D0x5585bfdc2ff0, addr=3D<optimized ou=
t>,
      size=3D<optimized out>) at /qemu-2.12/memory.c:1997
  #6  0x00005585bbe552a4 in vga_draw_graphic (full_update=3D0, s=3D0x5585c0=
6e3d00) at /qemu-2.12/hw/display/vga.c:1671
  #7  vga_update_display (opaque=3D0x5585c06e3d00) at /qemu-2.12/hw/display=
/vga.c:1767
  #8  0x00005585bc0d9a8f in qemu_spice_display_refresh (ssd=3D0x5585c06e393=
0) at /qemu-2.12/ui/spice-display.c:478
  #9  0x00005585bc0ced72 in dpy_refresh (s=3D0x5585c081b2a0) at /qemu-2.12/=
ui/console.c:1629
  #10 gui_update (opaque=3D0x5585c081b2a0) at /qemu-2.12/ui/console.c:203
  #11 0x00005585bc1d333c in timerlist_run_timers (timer_list=3D0x5585bee1f9=
50) at /qemu-2.12/util/qemu-timer.c:536
  #12 0x00005585bc1d35a3 in qemu_clock_run_timers (type=3DQEMU_CLOCK_REALTI=
ME) at /qemu-2.12/util/qemu-timer.c:547
  #13 qemu_clock_run_all_timers () at /qemu-2.12/util/qemu-timer.c:674
  #14 0x00005585bc1d3aa4 in main_loop_wait (nonblocking=3D<optimized out>) =
at /qemu-2.12/util/main-loop.c:528
  #15 0x00005585bbdc2f8a in main_loop () at /qemu-2.12/vl.c:1973
  #16 main (argc=3D<optimized out>, argv=3D<optimized out>, envp=3D<optimiz=
ed out>) at /qemu-2.12/vl.c:4804 =


  (gdb) frame 5
  (gdb) p/x *snap
  $1 =3D {start =3D 0x1000c0000, end =3D 0x1000c0000, dirty =3D 0x5585bfdc3=
000}

  Here the snap->start is identical to snap->end , I think something is wro=
ng. =

  In function vga_draw_graphic, the snap is allocated from region_start/reg=
ion_end.
          snap =3D memory_region_snapshot_and_clear_dirty(&s->vram, region_=
start,
                                                        region_end - region=
_start,
                                                        DIRTY_MEMORY_VGA);
  Is that possible for region_start=3D=3D region_end ? =


  Commandline:
  /usr/bin/kvm -name guest=3Dwin10-2,debug-threads=3Don -S -object secret,i=
d=3DmasterKey0,format=3Draw,file=3D/run/lib/libvirt/qemu/domain-51-win10-2/=
master-key.aes -machine pc-i440fx-2.12,accel=3Dkvm,usb=3Doff,system=3Dwindo=
ws,dump-guest-core=3Doff -cpu qemu64,hv_time,hv_relaxed,hv_spinlocks=3D0x20=
00 -m size=3D4194304k,slots=3D10,maxmem=3D34359738368k -realtime mlock=3Dof=
f -smp 2,maxcpus=3D24,sockets=3D24,cores=3D1,threads=3D1 -numa node,nodeid=
=3D0,cpus=3D0-23,mem=3D4096 -uuid cb871760-e684-4926-8f0b-270f7ff35539 -no-=
user-config -nodefaults -chardev socket,id=3Dcharmonitor,path=3D/run/lib/li=
bvirt/qemu/domain-51-win10-2/monitor.sock,server,nowait -mon chardev=3Dchar=
monitor,id=3Dmonitor,mode=3Dcontrol -chardev socket,id=3Dcharmonitor_cas,pa=
th=3D/run/lib/libvirt/qemu/domain-51-win10-2/monitor.sock.cas,server,nowait=
 -mon chardev=3Dcharmonitor_cas,id=3Dmonitor_cas,mode=3Dcontrol -rtc base=
=3Dlocaltime,clock=3Dvm,driftfix=3Dslew -no-hpet -no-shutdown -global PIIX4=
_PM.disable_s3=3D1 -global PIIX4_PM.disable_s4=3D1 -boot strict=3Don -devic=
e piix3-usb-uhci,id=3Dusb,bus=3Dpci.0,addr=3D0x1.0x2 -device usb-ehci,id=3D=
usb1,bus=3Dpci.0,addr=3D0x4 -device nec-usb-xhci,id=3Dusb2,bus=3Dpci.0,addr=
=3D0x5 -device virtio-scsi-pci,id=3Dscsi1,bus=3Dpci.0,addr=3D0x6 -device vi=
rtio-serial-pci,id=3Dvirtio-serial0,bus=3Dpci.0,addr=3D0x7 -device usb-hub,=
id=3Dhub0,bus=3Dusb.0,port=3D1 -drive file=3D/vms/images/win10-2,format=3Dq=
cow2,if=3Dnone,id=3Ddrive-virtio-disk0,cache=3Ddirectsync,aio=3Dnative -dev=
ice virtio-blk-pci,scsi=3Doff,bus=3Dpci.0,addr=3D0x8,pci_hotpluggable=3Don,=
drive=3Ddrive-virtio-disk0,id=3Dvirtio-disk0,bootindex=3D1 -drive file=3D/v=
ms/isos/virtio-win10.vfd,format=3Draw,if=3Dnone,id=3Ddrive-fdc0-0-0,readonl=
y=3Don,cache=3Ddirectsync,aio=3Dnative -global isa-fdc.driveA=3Ddrive-fdc0-=
0-0 -global isa-fdc.bootindexA=3D4 -drive file=3D/vms/nfs/windows_msdn_iso/=
cn_windows_10_multi-edition_version_1709_updated_sept_2017_x64_dvd_10009080=
4.iso,format=3Draw,if=3Dnone,id=3Ddrive-ide0-0-0,readonly=3Don -device ide-=
cd,bus=3Dide.0,unit=3D0,drive=3Ddrive-ide0-0-0,id=3Dide0-0-0,bootindex=3D2 =
-netdev tap,fd=3D62,id=3Dhostnet0,vhost=3Don,vhostfd=3D63 -device virtio-ne=
t-pci,pci_hotpluggable=3Don,netdev=3Dhostnet0,id=3Dnet0,mac=3D0c:da:41:1d:1=
1:5b,bus=3Dpci.0,addr=3D0x3,bootindex=3D3 -chardev pty,id=3Dcharserial0 -de=
vice isa-serial,chardev=3Dcharserial0,id=3Dserial0 -chardev socket,id=3Dcha=
rchannel0,path=3D/var/lib/libvirt/qemu/win10-2.agent,server,nowait -device =
virtserialport,bus=3Dvirtio-serial0.0,nr=3D1,chardev=3Dcharchannel0,id=3Dch=
annel0,name=3Dorg.qemu.guest_agent.0 -device usb-tablet,id=3Dinput0,bus=3Du=
sb.0,port=3D2 -vnc 0.0.0.0:0 -spice port=3D5901,tls-port=3D5902,addr=3D0.0.=
0.0,disable-ticketing,x509-dir=3D/etc/pki/libvirt-spice,seamless-migration=
=3Don -device qxl-vga,id=3Dvideo0,ram_size=3D67108864,vram_size=3D16777216,=
vram64_size_mb=3D0,vgamem_mb=3D16,bus=3Dpci.0,addr=3D0x2 -device virtio-bal=
loon-pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x9 -msg timestamp=3Don

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1785197/+subscriptions
