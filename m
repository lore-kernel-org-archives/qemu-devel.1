Received: from eggs.gnu.org ([2001:4830:134:3::10]:36415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gHvjd-00069z-Pp
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 15:00:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gHvjX-0007fH-Fi
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 15:00:55 -0400
Received: from indium.canonical.com ([91.189.90.7]:56630)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gHvjX-0007a5-5L
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 15:00:51 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gHvjV-0000be-I5
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 19:00:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 301DD2E80CC
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 19:00:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 31 Oct 2018 18:47:42 -0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Reply-To: Bug 1800786 <1800786@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154097463545.29353.15792040571614234775.malonedeb@soybean.canonical.com>
Message-Id: <154101166239.24163.7946399684888804786.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1800786] Re: USB assertion `s->csw.sig ==
 cpu_to_le32(0x53425355)' failed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi,
  1.7.2 is a really old version of qemu; why are you using that?
  Does it happen with a newer version?

  When you say 'Qemu crashed after starting and stopping VM for many
times'  do you mean starting a VM   and shutting it down completely, or
do you mean some type of pause/resume?

  When it crashes, what was on the display - was it still at the BIOS or
inside the guest? Which guest OS ?

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1800786

Title:
  USB assertion `s->csw.sig =3D=3D cpu_to_le32(0x53425355)' failed

Status in QEMU:
  New

Bug description:
  Qemu crashed after starting and stopping VM for many times, and the
  final log shows below.

  qemu-system-x86_64: hw/usb/dev-storage.c:236: usb_msd_send_status: Assert=
ion `s->csw.sig =3D=3D cpu_to_le32(0x53425355)' failed.
  2018-10-05 15:33:11.261+0000: shutting down

  I got the back trace in coredump file:

  -----------------------back trace----------------------------------------
  #0 0x00007fc890e6cff9 in __GI_raise (sig=3Dsig@entry=3D6) =

      at ../nptl/sysdeps/unix/sysv/linux/raise.c:56 =

  #1 0x00007fc890e700f8 in __GI_abort () at abort.c:89 =

  #2 0x00007fc890e66216 in __assert_fail_base ( =

      fmt=3D0x7fc890f9dfc0 "%s%s%s:%u: %s%sAssertion `%s' failed.\n%n", =

      assertion=3Dassertion@entry=3D0x7fc8957cd460 "s->csw.sig =3D=3D cpu_t=
o_le32(0x53425355)", file=3Dfile@entry=3D0x7fc8957cd2d0 "hw/usb/dev-storage=
.c", =

      line=3Dline@entry=3D236, =

      function=3Dfunction@entry=3D0x7fc8957cd5e0 <__PRETTY_FUNCTION__.29765=
> "usb_msd_send_status") at assert.c:92 =

  #3 0x00007fc890e662c2 in __GI___assert_fail ( =

      assertion=3Dassertion@entry=3D0x7fc8957cd460 "s->csw.sig =3D=3D cpu_t=
o_le32(0x53425355)", file=3Dfile@entry=3D0x7fc8957cd2d0 "hw/usb/dev-storage=
.c", =

      line=3Dline@entry=3D236, =

      function=3Dfunction@entry=3D0x7fc8957cd5e0 <__PRETTY_FUNCTION__.29765=
> "usb_msd_send_status") at assert.c:101 =

  #4 0x00007fc8955dee12 in usb_msd_send_status (s=3D0x7fc8961588f0, =

      p=3D<optimized out>) at hw/usb/dev-storage.c:236 =

  #5 0x00007fc8955df092 in usb_msd_handle_data (dev=3D0x7fc8961588f0, =

      p=3D0x7fc896105260) at hw/usb/dev-storage.c:507 =

  #6 0x00007fc8955d5940 in usb_handle_packet (dev=3D<optimized out>, =

      p=3Dp@entry=3D0x7fc896105260) at hw/usb/core.c:407 =

  #7 0x00007fc8955ea8a8 in uhci_handle_td (s=3Ds@entry=3D0x7fc896133080, =

  ---Type <return> to continue, or q <return> to quit--- =

      q=3D0x7fc896197c90, q@entry=3D0x0, qh_addr=3Dqh_addr@entry=3D25394381=
0, =

      td=3Dtd@entry=3D0x7ffcc646c0e0, td_addr=3D<optimized out>, =

      int_mask=3Dint_mask@entry=3D0x7ffcc646c0cc) at hw/usb/hcd-uhci.c:911 =

  #8 0x00007fc8955eada9 in uhci_process_frame (s=3Ds@entry=3D0x7fc896133080=
) =

      at hw/usb/hcd-uhci.c:1091 =

  #9 0x00007fc8955eaff5 in uhci_frame_timer (opaque=3D0x7fc896133080) =

      at hw/usb/hcd-uhci.c:1190 =

  #10 0x00007fc895636c69 in timerlist_run_timers (timer_list=3D0x7fc896093a=
f0) =

      at qemu-timer.c:491 =

  #11 0x00007fc895636f01 in qemu_clock_run_timers (type=3D<optimized out>) =

      at qemu-timer.c:502 =

  #12 qemu_clock_run_all_timers () at qemu-timer.c:608 =

  #13 0x00007fc8955f9b0c in main_loop_wait (nonblocking=3D<optimized out>) =

      at main-loop.c:507 =

  #14 0x00007fc8954bc750 in main_loop () at vl.c:2021 =

  #15 main (argc=3D<optimized out>, argv=3D<optimized out>, envp=3D<optimiz=
ed out>) =

      at vl.c:4447 =

  -------------------------------------------------------------------------=
------

  QEMU release version: 1.7.2

  QEMU command:

  qemu-system-x86_64 -enable-kvm -name guest=3Dguest,debug-threads=3Don -S
  -object
  secret,id=3DmasterKey0,format=3Draw,file=3D/var/lib/libvirt/qemu/domain-4=
2-guest
  /master-key.aes -machine pc-i440fx-xenial,accel=3Dkvm,usb=3Doff,dump-
  guest-core=3Doff -cpu IvyBridge-
  IBRS,ss=3Don,vmx=3Don,pcid=3Don,hypervisor=3Don,arat=3Don,tsc_adjust=3Don=
,ssbd=3Don,xsaveopt=3Don
  -m 1024 -realtime mlock=3Doff -smp 1,sockets=3D1,cores=3D1,threads=3D1 -u=
uid
  f4fdccb5-8c59-441f-9a78-83d23fbc34f6 -no-user-config -nodefaults
  -chardev
  socket,id=3Dcharmonitor,path=3D/var/lib/libvirt/qemu/domain-42-guest/moni=
tor.sock,server,nowait
  -mon chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol -rtc
  base=3Dutc,driftfix=3Dslew -global kvm-pit.lost_tick_policy=3Ddelay -no-h=
pet
  -no-shutdown -global PIIX4_PM.disable_s3=3D1 -global
  PIIX4_PM.disable_s4=3D1 -boot menu=3Doff,strict=3Don -kernel
  /nfsroot/rootfs/root/bzImage -initrd /nfsroot/rootfs/root/wrlinux-
  image-initramfs-x86-64-kvm-guest.cpio.gz -device piix3-usb-
  uhci,id=3Dusb,bus=3Dpci.0,addr=3D0x1.0x2 -device
  lsi,id=3Dscsi0,bus=3Dpci.0,addr=3D0x7 -device
  ahci,id=3Dsata0,bus=3Dpci.0,addr=3D0x6 -device virtio-serial-pci,id=3Dvir=
tio-
  serial0,bus=3Dpci.0,addr=3D0x5 -drive file=3D/nfsroot/rootfs.ovp6/wrlinux-
  image-ovp-kvm-
  intel-x86-64-20181015084008.rootfs.ext3,format=3Draw,if=3Dnone,id=3Ddrive-
  usb-disk0 -device usb-storage,bus=3Dusb.0,port=3D1,drive=3Ddrive-usb-
  disk0,id=3Dusb-disk0,bootindex=3D1,removable=3Doff -netdev
  tap,fd=3D26,id=3Dhostnet0 -device
  e1000,netdev=3Dhostnet0,id=3Dnet0,mac=3D52:54:00:93:6b:0c,bus=3Dpci.0,add=
r=3D0x3
  -chardev pty,id=3Dcharserial0 -device isa-
  serial,chardev=3Dcharserial0,id=3Dserial0 -chardev
  spicevmc,id=3Dcharchannel0,name=3Dvdagent -device virtserialport,bus
  =3Dvirtio-
  serial0.0,nr=3D1,chardev=3Dcharchannel0,id=3Dchannel0,name=3Dcom.redhat.s=
pice.0
  -spice port=3D5900,addr=3D127.0.0.1,disable-ticketing,image-
  compression=3Doff,seamless-migration=3Don -device qxl-
  vga,id=3Dvideo0,ram_size=3D67108864,vram_size=3D67108864,vram64_size_mb=
=3D0,vgamem_mb=3D16,max_outputs=3D1,bus=3Dpci.0,addr=3D0x2
  -device intel-hda,id=3Dsound0,bus=3Dpci.0,addr=3D0x4 -device hda-
  duplex,id=3Dsound0-codec0,bus=3Dsound0.0,cad=3D0 -device virtio-balloon-
  pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x8 -msg timestamp=3Don

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1800786/+subscriptions
