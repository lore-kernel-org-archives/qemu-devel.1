Received: from eggs.gnu.org ([2001:4830:134:3::10]:44418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fllYo-0005jY-Q9
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 21:40:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fllYl-0005ZQ-JH
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 21:40:50 -0400
Received: from indium.canonical.com ([91.189.90.7]:44070)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fllYl-0005Y9-8W
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 21:40:47 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fllYj-0003aZ-Ty
	for <qemu-devel@nongnu.org>; Sat, 04 Aug 2018 01:40:45 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id DEDE82E8042
	for <qemu-devel@nongnu.org>; Sat,  4 Aug 2018 01:40:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 04 Aug 2018 01:35:40 -0000
From: changlimin <changlimin@h3c.com>
Reply-To: Bug 1785197 <1785197@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <153328835680.29549.10888277891028750813.malonedeb@chaenomeles.canonical.com>
Message-Id: <153334654034.3153.893174706191985121.malone@wampee.canonical.com>
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

1. Add breakpoint at vga.c:790 s->vbe_regs[VBE_DISPI_INDEX_ENABLE] =3D
val;

(gdb) b vga.c:790
Breakpoint 2 at 0x56100ad10521: file /qemu-2.12/hw/display/vga.c, line 790.

(gdb) c
Continuing.

2. When breakpoint is hited , val is 0

Thread 5 "CPU 1/KVM" hit Breakpoint 2, vbe_ioport_write_data
(opaque=3D0x56100e6e7b30, addr=3D<optimized out>, val=3D0) at
/qemu-2.12/hw/display/vga.c:790

(gdb) bt
#0  vbe_ioport_write_data (opaque=3D0x56100e6e7b30, addr=3D<optimized out>,=
 val=3D0) at /qemu-2.12/hw/display/vga.c:790
#1  0x000056100ace521b in memory_region_write_accessor (mr=3D0x56100e74e590=
, addr=3D1, value=3D<optimized out>, size=3D2, shift=3D<optimized out>, mas=
k=3D<optimized out>, attrs=3D...)
    at /qemu-2.12/memory.c:530
#2  0x000056100ace266e in access_with_adjusted_size (addr=3Daddr@entry=3D1,=
 value=3Dvalue@entry=3D0x7fb2aeffc9a8, size=3Dsize@entry=3D2, access_size_m=
in=3D<optimized out>, access_size_max=3D<optimized out>,
    access_fn=3D0x56100ace51a0 <memory_region_write_accessor>, mr=3D0x56100=
e74e590, attrs=3D...) at /qemu-2.12/memory.c:597
#3  0x000056100ace72ca in memory_region_dispatch_write (mr=3Dmr@entry=3D0x5=
6100e74e590, addr=3D1, data=3D<optimized out>, size=3Dsize@entry=3D2, attrs=
=3Dattrs@entry=3D...)
    at /qemu-2.12/memory.c:1487
#4  0x000056100ac85807 in flatview_write_continue (mr=3D0x56100e74e590, l=
=3D<optimized out>, addr1=3D<optimized out>, len=3D2, buf=3D0x7fb2bf3e2000 =
"", attrs=3D..., addr=3D463, fv=3D0x7fb2a458fea0)
    at /qemu-2.12/exec.c:3166
#5  flatview_write (fv=3D0x7fb2a458fea0, addr=3D<optimized out>, attrs=3D..=
., buf=3D<optimized out>, len=3D<optimized out>) at /qemu-2.12/exec.c:3216
#6  0x000056100ac8a2af in address_space_write (as=3D<optimized out>, addr=
=3D<optimized out>, attrs=3D..., buf=3D<optimized out>, len=3D<optimized ou=
t>)
    at /qemu-2.12/exec.c:3332
#7  0x000056100ac8a345 in address_space_rw (as=3D<optimized out>, addr=3Dad=
dr@entry=3D463, attrs=3D..., attrs@entry=3D..., buf=3Dbuf@entry=3D0x7fb2bf3=
e2000 "", len=3Dlen@entry=3D2, is_write=3Dis_write@entry=3Dtrue)
    at /qemu-2.12/exec.c:3343
#8  0x000056100acf66f2 in kvm_handle_io (count=3D1, size=3D2, direction=3D<=
optimized out>, data=3D<optimized out>, attrs=3D..., port=3D463)
    at /qemu-2.12/accel/kvm/kvm-all.c:1730
#9  kvm_cpu_exec (cpu=3Dcpu@entry=3D0x56100cecc810) at /qemu-2.12/accel/kvm=
/kvm-all.c:1970
#10 0x000056100acd0ab6 in qemu_kvm_cpu_thread_fn (arg=3D0x56100cecc810) at =
/qemu-2.12/cpus.c:1229
#11 0x00007fb2bc1dc184 in start_thread () from /lib/x86_64-linux-gnu/libpth=
read.so.0
#12 0x00007fb2bbf09bed in clone () from /lib/x86_64-linux-gnu/libc.so.6

(gdb) c
Continuing.

3. size is 0, region_start is identical to region_end

Thread 1 "kvm" hit Breakpoint 1, memory_region_snapshot_and_clear_dirty (mr=
=3Dmr@entry=3D0x56100e6e7b40, addr=3Daddr@entry=3D0, size=3Dsize@entry=3D0,=
 client=3Dclient@entry=3D0)
    at /qemu-2.12/memory.c:1986

(gdb) c
Continuing.


4. Abort

Thread 1 "kvm" received signal SIGABRT, Aborted.
0x00007fb2bbe42c37 in raise () from /lib/x86_64-linux-gnu/libc.so.6

(gdb) bt
#0  0x00007fb2bbe42c37 in raise () from /lib/x86_64-linux-gnu/libc.so.6
#1  0x00007fb2bbe46028 in abort () from /lib/x86_64-linux-gnu/libc.so.6
#2  0x00007fb2bbe3bbf6 in ?? () from /lib/x86_64-linux-gnu/libc.so.6
#3  0x00007fb2bbe3bca2 in __assert_fail () from /lib/x86_64-linux-gnu/libc.=
so.6
#4  0x000056100ac86641 in cpu_physical_memory_snapshot_get_dirty (snap=3Dsn=
ap@entry=3D0x56100d6b0de0, start=3D<optimized out>, length=3D<optimized out=
>)
    at /qemu-2.12/exec.c:1264
#5  0x000056100ace84de in memory_region_snapshot_get_dirty (mr=3Dmr@entry=
=3D0x56100e6e7b40, snap=3Dsnap@entry=3D0x56100d6b0de0, addr=3D<optimized ou=
t>, size=3D<optimized out>)
    at /qemu-2.12/memory.c:1997
#6  0x000056100ad122a4 in vga_draw_graphic (full_update=3D0, s=3D0x56100e6e=
7b30) at /qemu-2.12/hw/display/vga.c:1671
#7  vga_update_display (opaque=3D0x56100e6e7b30) at /qemu-2.12/hw/display/v=
ga.c:1767
#8  0x000056100af96a8f in qemu_spice_display_refresh (ssd=3D0x56100e6e7760)=
 at /qemu-2.12/ui/spice-display.c:478
#9  0x000056100af8bd72 in dpy_refresh (s=3D0x56100e81f0b0) at /qemu-2.12/ui=
/console.c:1629
#10 gui_update (opaque=3D0x56100e81f0b0) at /qemu-2.12/ui/console.c:203
#11 0x000056100b09033c in timerlist_run_timers (timer_list=3D0x56100cdf1c60=
) at /qemu-2.12/util/qemu-timer.c:536
#12 0x000056100b0905a3 in qemu_clock_run_timers (type=3DQEMU_CLOCK_REALTIME=
) at /qemu-2.12/util/qemu-timer.c:547
#13 qemu_clock_run_all_timers () at /qemu-2.12/util/qemu-timer.c:674
#14 0x000056100b090aa4 in main_loop_wait (nonblocking=3D<optimized out>) at=
 /qemu-2.12/util/main-loop.c:528
#15 0x000056100ac7ff8a in main_loop () at /qemu-2.12/vl.c:1973
#16 main (argc=3D<optimized out>, argv=3D<optimized out>, envp=3D<optimized=
 out>) at /qemu-2.12/vl.c:4804


5. When guest vga driver set the s->vbe_regs[VBE_DISPI_INDEX_ENABLE] to 0, =
then if the vga_draw_graphic be called , the qemu crash.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1785197

Title:
  qemu 2.12.0 crash during install windows 10 with vga

Status in QEMU:
  New

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
