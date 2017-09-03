Received: from eggs.gnu.org ([2001:4830:134:3::10]:41878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1doa3o-0008Pr-Ap
	for qemu-devel@nongnu.org; Sun, 03 Sep 2017 14:56:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1doa3i-00056r-Gi
	for qemu-devel@nongnu.org; Sun, 03 Sep 2017 14:55:56 -0400
Received: from indium.canonical.com ([91.189.90.7]:37990)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1doa3i-00056S-9z
	for qemu-devel@nongnu.org; Sun, 03 Sep 2017 14:55:50 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1doa3g-0005MS-4e
	for <qemu-devel@nongnu.org>; Sun, 03 Sep 2017 18:55:48 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id B3E452E80CD
	for <qemu-devel@nongnu.org>; Sun,  3 Sep 2017 18:55:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 03 Sep 2017 18:49:45 -0000
From: Chris Unsworth <1714331@bugs.launchpad.net>
Reply-To: Bug 1714331 <1714331@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150420685550.8035.5310753798215250364.malonedeb@soybean.canonical.com>
Message-Id: <150446458513.18943.6528705905028620261.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1714331] Re: Virtual machines not working anymore
 on 2.10
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I am also unable to boot Windows 10 64 bit since updating to 2.10.0.  I
was previously using 2.8.0 which worked perfectly.  Windows gets stuck
at the big Windows logo with the spinning dots underneath and QEMU uses
100% CPU of 1 core.  I am using kernel 4.11.9 and the following command
line:

qemu-system-x86_64 =

-serial none =

-parallel none =

-balloon none =

-enable-kvm =

-name Windows10 =

-display none =

-M q35,accel=3Dkvm,mem-merge=3Doff =

-m 10240 =

-cpu host,kvm=3Doff,hv_relaxed,hv_spinlocks=3D0x1fff,hv_vapic,hv_time,hv_ve=
ndor_id=3Dwhatever =

-smp 4,sockets=3D1,cores=3D4,threads=3D1 =

-realtime mlock=3Don =

-vga none =

-device ioh3420,bus=3Dpcie.0,addr=3D1c.0,multifunction=3Don,port=3D1,chassi=
s=3D1,id=3Droot.1 =

-device vfio-pci,host=3D01:00.0,bus=3Droot.1,addr=3D00.0,multifunction=3Don =

-device vfio-pci,host=3D01:00.1,bus=3Droot.1,addr=3D00.1 =

-drive if=3Dpflash,format=3Draw,readonly,file=3D/usr/share/ovmf/OVMF_CODE-p=
ure-efi.fd =

-drive if=3Dpflash,format=3Draw,file=3D/usr/share/ovmf/OVMF_VARS-pure-efi.f=
d =

-drive if=3Dnone,id=3Ddrive0,cache=3Ddirectsync,aio=3Dnative,format=3Draw,f=
ile=3D/dev/mint-vg/windows =

-object iothread,id=3Diothread0 =

-device virtio-blk-pci,drive=3Ddrive0,scsi=3Doff,iothread=3Diothread0 =

-drive if=3Dnone,id=3Ddrive1,cache=3Ddirectsync,aio=3Dnative,format=3Draw,f=
ile=3D/dev/evo-vg/windows2 =

-object iothread,id=3Diothread1 -device virtio-blk-pci,drive=3Ddrive1,scsi=
=3Doff,iothread=3Diothread1 =

-net nic,model=3Dvirtio =

-net bridge,br=3Dbr0 =

-rtc base=3Dlocaltime,clock=3Dhost =

-usb =

-device usb-host,bus=3Dusb-bus.0,vendorid=3D0x1b1c,productid=3D0x1b22 =

-device usb-host,bus=3Dusb-bus.0,vendorid=3D0x1b1c,productid=3D0x1b15

I have now rolled back to 2.8.0 and it is working again.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1714331

Title:
  Virtual machines not working anymore on 2.10

Status in QEMU:
  New

Bug description:
  Using 2.10, my virtual machine(s) don't work anymore. This happens
  100% of the times.

  -----

  I use QEMU compiling it from source, on Ubuntu 16.04 amd64. This is
  the configure command:

      configure --target-list=3Dx86_64-softmmu --enable-debug --enable-gtk
  --enable-spice --audio-drv-list=3Dpa

  I have one virtual disk, with a Windows 10 64-bit, which I launch in
  two different ways; both work perfectly on 2.9 (and used to do on 2.8,
  but I haven't used it for a long time).

  This is the first way:

      qemu-system-x86_64
        -drive if=3Dpflash,format=3Draw,readonly,file=3D/path/to/OVMF_CODE.=
fd
        -drive if=3Dpflash,format=3Draw,file=3D/tmp/OVMF_VARS.fd.tmp
        -enable-kvm
        -machine q35,accel=3Dkvm,mem-merge=3Doff
        -cpu host,kvm=3Doff,hv_vendor_id=3Dvgaptrocks,hv_relaxed,hv_spinloc=
ks=3D0x1fff,hv_vapic,hv_time
        -smp 4,cores=3D4,sockets=3D1,threads=3D1
        -m 4096
        -display gtk
        -vga qxl
        -rtc base=3Dlocaltime
        -serial none
        -parallel none
        -usb
        -device usb-host,vendorid=3D0xNNNN,productid=3D0xNNNN
        -device usb-host,vendorid=3D0xNNNN,productid=3D0xNNNN
        -device usb-host,vendorid=3D0xNNNN,productid=3D0xNNNN
        -device usb-host,vendorid=3D0xNNNN,productid=3D0xNNNN
        -device virtio-scsi-pci,id=3Dscsi
        -drive file=3D/path/to/image-diff.img,id=3Dhdd1,format=3Dqcow2,if=
=3Dnone,cache=3Dwriteback
        -device scsi-hd,drive=3Dhdd1
        -net nic,model=3Dvirtio
        -net user

  On QEMU 2.10, I get the `Recovery - Your PC/Device needs to be
  repaired` windows screen; on 2.9, it boots regularly.

  This is the second way:

      qemu-system-x86_64
        -drive if=3Dpflash,format=3Draw,readonly,file=3D/path/to/OVMF_CODE.=
fd
        -drive if=3Dpflash,format=3Draw,file=3D/tmp/OVMF_VARS.fd.tmp
        -enable-kvm
        -machine q35,accel=3Dkvm,mem-merge=3Doff
        -cpu host,kvm=3Doff,hv_vendor_id=3Dvgaptrocks,hv_relaxed,hv_spinloc=
ks=3D0x1fff,hv_vapic,hv_time
        -smp 4,cores=3D4,sockets=3D1,threads=3D1
        -m 10240
        -vga none
        -rtc base=3Dlocaltime
        -serial none
        -parallel none
        -usb
        -device vfio-pci,host=3D01:00.0,multifunction=3Don
        -device vfio-pci,host=3D01:00.1
        -device usb-host,vendorid=3D0xNNNN,productid=3D0xNNNN
        -device usb-host,vendorid=3D0xNNNN,productid=3D0xNNNN
        -device usb-host,vendorid=3D0xNNNN,productid=3D0xNNNN
        -device usb-host,vendorid=3D0xNNNN,productid=3D0xNNNN
        -device usb-host,vendorid=3D0xNNNN,productid=3D0xNNNN
        -device usb-host,vendorid=3D0xNNNN,productid=3D0xNNNN
        -device virtio-scsi-pci,id=3Dscsi
        -drive file=3D/path/to/image-diff.img,id=3Dhdd1,format=3Dqcow2,if=
=3Dnone,cache=3Dwriteback
        -device scsi-hd,drive=3Dhdd1
        -net nic,model=3Dvirtio
        -net user

  On QEMU 2.10, I get the debug window on the linux monitor, and blank scre=
en on VFIO one (no BIOS screen at all); after 10/20 seconds, QEMU crashes w=
ithout any message.
  On 2.9, this works perfectly.

  -----

  I am able to perform a git bisect, if that helps, but if this is the
  case, I'd need this issue to be reviewed, since bisecting is going to
  take me a lot of time.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1714331/+subscriptions
