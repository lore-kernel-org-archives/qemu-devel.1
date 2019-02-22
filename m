Received: from eggs.gnu.org ([209.51.188.92]:36193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brogers@suse.com>) id 1gxGbD-0000bM-En
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 14:35:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brogers@suse.com>) id 1gxGbC-0000D5-8K
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 14:35:07 -0500
Received: from prv-mh.provo.novell.com ([137.65.248.74]:59428)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brogers@suse.com>) id 1gxGbB-0008T6-Sk
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 14:35:06 -0500
Message-Id: <5C704EE6020000480009762E@prv-mh.provo.novell.com>
Date: Fri, 22 Feb 2019 12:35:02 -0700
From: "Bruce Rogers" <brogers@suse.com>
References: <154833838504.19548.14915901097039330455.malonedeb@gac.canonical.com>
	<155085420337.11803.15680355453597063606.malone@gac.canonical.com>
In-Reply-To: <155085420337.11803.15680355453597063606.malone@gac.canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: Re: [Qemu-devel] [Bug 1813165] Re: KVM internal error. Suberror: 1
 emulation failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 1813165@bugs.launchpad.net, qemu-devel@nongnu.org

>>> On 2/22/2019 at 9:50 AM, Vitaly Kuznetsov <1813165@bugs.launchpad.net> =
wrote:
> I sent a patch which is supposed to fix the issue:
> https://marc.info/?l=3Dkvm&m=3D155085391830663&w=3D2=20
>=20
> it would be great if someone could give it a spin!
>=20

I've been trying to get down to the bottom of this.
It looks like you've got it.
I can confirm that this fixes the issue for me. Thanks!

Tested-by: Bruce Rogers <brogers@suse.com>


> --=20
> You received this bug notification because you are a member of qemu-
> devel-ml, which is subscribed to QEMU.
> https://bugs.launchpad.net/bugs/1813165=20
>=20
> Title:
>   KVM internal error. Suberror: 1 emulation failure
>=20
> Status in QEMU:
>   New
>=20
> Bug description:
>   Hello Devs.
>=20
>   Having problems getting VM to run with qemu 3.1.0. I should mention
>   it's a nested configuration.
>=20
>   2019-01-24 13:46:08.648+0000: starting up libvirt version: 4.10.0, =
qemu=20
> version: 3.1.0, kernel: 4.14.94, hostname: one....
>   LC_ALL=3DC=20
> PATH=3D/bin:/sbin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/bin:/usr/sbin:/usr/l=
ocal/b
> in:/usr/local/sbin:/opt/bin HOME=3D/root USER=3Droot QEMU_AUDIO_DRV=3Dnon=
e=20
> /usr/bin/kvm -name guest=3Done-266,debug-threads=3Don -S -object=20
> secret,id=3DmasterKey0,format=3Draw,file=3D/var/lib/libvirt/qemu/domain-1=
-one-266/m
> aster-key.aes -machine pc-i440fx-2.9,accel=3Dkvm,usb=3Doff,dump-guest-cor=
e=3Doff=20
> -cpu=20
> Skylake-Client-IBRS,ss=3Don,hypervisor=3Don,tsc_adjust=3Don,clflushopt=3D=
on,ssbd=3Don,x
> saves=3Don,pdpe1gb=3Don -m 1024 -realtime mlock=3Doff -smp=20
> 2,sockets=3D2,cores=3D1,threads=3D1 -uuid b219b45d-a2f0-4128-a948-8673a7a=
bf968=20
> -no-user-config -nodefaults -chardev=20
> socket,id=3Dcharmonitor,fd=3D21,server,nowait -mon=20
> chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol -rtc base=3Dutc =
-no-shutdown -boot=20
> strict=3Don -device piix3-usb-uhci,id=3Dusb,bus=3Dpci.0,addr=3D0x1.0x2 =
-drive=20
> file=3D/var/lib/one//datastores/0/266/disk.0,format=3Dqcow2,if=3Dnone,id=
=3Ddrive-virt
> io-disk0,cache=3Dnone -device=20
> virtio-blk-pci,scsi=3Doff,bus=3Dpci.0,addr=3D0x4,drive=3Ddrive-virtio-dis=
k0,id=3Dvirtio
> -disk0,bootindex=3D1,write-cache=3Don -drive=20
> file=3D/var/lib/one//datastores/0/266/disk.1,format=3Draw,if=3Dnone,id=3D=
drive-ide0-0
> -0,readonly=3Don -device=20
> ide-cd,bus=3Dide.0,unit=3D0,drive=3Ddrive-ide0-0-0,id=3Dide0-0-0 =
-netdev=20
> tap,fd=3D23,id=3Dhostnet0 -device=20
> rtl8139,netdev=3Dhostnet0,id=3Dnet0,mac=3D02:00:00:76:69:85,bus=3Dpci.0,a=
ddr=3D0x3=20
> -chardev pty,id=3Dcharserial0 -device isa-serial,chardev=3Dcharserial0,id=
=3Dserial0=20
> -vnc 0.0.0.0:266 -device cirrus-vga,id=3Dvideo0,bus=3Dpci.0,addr=3D0x2 =
-device=20
> virtio-balloon-pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x5 -sandbox=20
> on,obsolete=3Ddeny,elevateprivileges=3Ddeny,spawn=3Ddeny,resourcecontrol=
=3Ddeny -msg=20
> timestamp=3Don
>   char device redirected to /dev/pts/1 (label charserial0)
>   KVM internal error. Suberror: 1
>   emulation failure
>   EAX=3D00000001 EBX=3D000f7c2c ECX=3D00000001 EDX=3D00000001
>   ESI=3D00006a26 EDI=3D3ffbdc48 EBP=3D000069e6 ESP=3D000a8000
>   EIP=3D000fd057 EFL=3D00010016 [----AP-] CPL=3D0 II=3D0 A20=3D1 SMM=3D1 =
HLT=3D0
>   ES =3D0010 00000000 ffffffff 00c09300
>   CS =3D0000 00000000 00000fff 00809b00
>   SS =3D0010 00000000 ffffffff 00c09300
>   DS =3D0010 00000000 ffffffff 00c09300
>   FS =3D0010 00000000 ffffffff 00c09300
>   GS =3D0010 00000000 ffffffff 00c09300
>   LDT=3D0000 00000000 0000ffff 00008200
>   TR =3D0000 00000000 0000ffff 00008b00
>   GDT=3D     10387cfe 0000fe6c
>   IDT=3D     0010387c 00003810
>   CR0=3D00000010 CR2=3D00000000 CR3=3D00000000 CR4=3D00000000
>   DR0=3D0000000000000000 DR1=3D0000000000000000 DR2=3D0000000000000000=20=

> DR3=3D0000000000000000
>   DR6=3D00000000fffecffc DR7=3D000000000e1e0400
>   EFER=3D0000000000000000
>   Code=3Dcb 66 ba 4d d0 0f 00 e9 c8 fe bc 00 80 0a 00 e8 31 3a ff ff =
<0f> aa fa=20
> fc 66 ba 66 d0 0f 00 e9 b1 fe f3 90 f0 0f ba 2d ac 3b 0f 00 00 72 f3 8b =
25 a8=20
> 3b
>   2019-01-24T13:47:39.383366Z kvm: terminating on signal 15 from pid =
2708=20
> (/usr/sbin/libvirtd)
>=20
>   Someone has an idea whats going wrong here?
>=20
>   thanks and cheers
>   t.
>=20
> To manage notifications about this bug go to:
> https://bugs.launchpad.net/qemu/+bug/1813165/+subscriptions=20
