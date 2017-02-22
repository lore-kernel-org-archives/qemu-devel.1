Received: from eggs.gnu.org ([2001:4830:134:3::10]:60090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <xzhou@redhat.com>) id 1cgXOd-0003Gz-3w
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 08:55:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <xzhou@redhat.com>) id 1cgXOa-0005Rc-0u
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 08:55:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56584)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <xzhou@redhat.com>) id 1cgXOZ-0005RX-OT
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 08:55:51 -0500
Date: Wed, 22 Feb 2017 21:55:49 +0800
From: Xiong Zhou <xzhou@redhat.com>
Message-ID: <20170222135549.xhogxcxnibamzvor@XZHOUW.usersys.redhat.com>
References: <20170222015243.bzcnin2xbygak4wl@XZHOUW.usersys.redhat.com>
	<e59d5584-fa25-a925-65b8-7394f51c0390@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <e59d5584-fa25-a925-65b8-7394f51c0390@redhat.com>
Subject: Re: [Qemu-devel] Starting kvm/qemu guest crash kernel linux-next
 0221 tree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Xiong Zhou <xzhou@redhat.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-next@vger.kernel.org

On Wed, Feb 22, 2017 at 09:28:21AM +0100, Paolo Bonzini wrote:
>=20
>=20
> On 22/02/2017 02:52, Xiong Zhou wrote:
> > Hi,
> >=20
> > Starting a guest begin to crash kernel on 0221 -next tree.
> >=20
> > It's fine on 0220 tree.

I reproduced only once. Now it's hard to reproduce.
>=20
> Can you try commits a26d553400b30b6e0389f5c723c0fc6f7ea473da (0221) and

With above commit reverted by git revert -m 1, no panic so far.
But it's hard to reproduce.


> b95234c840045b7c72380fd14c59416af28fcb02 (0220)?
>=20
> What is the guest and the QEMU command line?

It's a RHEL-7.3 guest on a RHEL-7.3+ host

cmdline:
    /usr/libexec/qemu-kvm -name 73h -S -machine pc-i440fx-rhel7.0.0,accel=
=3Dkvm,usb=3Doff,dump-guest-core=3Doff -cpu Haswell,-hle,-rtm -m 8000 -real=
time mlock=3Doff -smp 8,sockets=3D8,cores=3D1,threads=3D1 -uuid aab09e0f-d4=
8a-4223-9b81-35d4718d59fc -no-user-config -nodefaults -chardev socket,id=3D=
charmonitor,path=3D/var/lib/libvirt/qemu/domain-2-73h/monitor.sock,server,n=
owait -mon chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol -rtc base=3Dut=
c,driftfix=3Dslew -global kvm-pit.lost_tick_policy=3Ddelay -no-hpet -no-shu=
tdown -global PIIX4_PM.disable_s3=3D1 -global PIIX4_PM.disable_s4=3D1 -boot=
 strict=3Don -device ich9-usb-ehci1,id=3Dusb,bus=3Dpci.0,addr=3D0x6.0x7 -de=
vice ich9-usb-uhci1,masterbus=3Dusb.0,firstport=3D0,bus=3Dpci.0,multifuncti=
on=3Don,addr=3D0x6 -device ich9-usb-uhci2,masterbus=3Dusb.0,firstport=3D2,b=
us=3Dpci.0,addr=3D0x6.0x1 -device ich9-usb-uhci3,masterbus=3Dusb.0,firstpor=
t=3D4,bus=3Dpci.0,addr=3D0x6.0x2 -device virtio-serial-pci,id=3Dvirtio-seri=
al0,bus=3Dpci.0,addr=3D0x5 -drive file=3D/var/lib/libvirt/images/rhel73.qco=
w2,format=3Dqcow2,if=3Dnone,id=3Ddrive-ide0-0-0 -device ide-hd,bus=3Dide.0,=
unit=3D0,drive=3Ddrive-ide0-0-0,id=3Dide0-0-0,bootindex=3D1 -drive file=3D/=
var/lib/libvirt/images/73h.qcow2,format=3Dqcow2,if=3Dnone,id=3Ddrive-ide0-0=
-1 -device ide-hd,bus=3Dide.0,unit=3D1,drive=3Ddrive-ide0-0-1,id=3Dide0-0-1=
 -drive file=3D/root/RHEL-7.2-20151030.0-Server-x86_64-dvd1.iso,format=3Dra=
w,if=3Dnone,id=3Ddrive-ide0-1-0,readonly=3Don -device ide-cd,bus=3Dide.1,un=
it=3D0,drive=3Ddrive-ide0-1-0,id=3Dide0-1-0,bootindex=3D2 -netdev tap,fd=3D=
25,id=3Dhostnet0 -device rtl8139,netdev=3Dhostnet0,id=3Dnet0,mac=3D52:54:00=
:83:12:7b,bus=3Dpci.0,addr=3D0x3 -chardev pty,id=3Dcharserial0 -device isa-=
serial,chardev=3Dcharserial0,id=3Dserial0 -chardev spicevmc,id=3Dcharchanne=
l0,name=3Dvdagent -device virtserialport,bus=3Dvirtio-serial0.0,nr=3D1,char=
dev=3Dcharchannel0,id=3Dchannel0,name=3Dcom.redhat.spice.0 -spice port=3D59=
00,addr=3D127.0.0.1,disable-ticketing,image-compression=3Doff,seamless-migr=
ation=3Don -vga qxl -global qxl-vga.ram_size=3D67108864 -global qxl-vga.vra=
m_size=3D67108864 -global qxl-vga.vgamem_mb=3D16 -device intel-hda,id=3Dsou=
nd0,bus=3Dpci.0,addr=3D0x4 -device hda-duplex,id=3Dsound0-codec0,bus=3Dsoun=
d0.0,cad=3D0 -chardev spicevmc,id=3Dcharredir0,name=3Dusbredir -device usb-=
redir,chardev=3Dcharredir0,id=3Dredir0,bus=3Dusb.0,port=3D1 -chardev spicev=
mc,id=3Dcharredir1,name=3Dusbredir -device usb-redir,chardev=3Dcharredir1,i=
d=3Dredir1,bus=3Dusb.0,port=3D2 -device virtio-balloon-pci,id=3Dballoon0,bu=
s=3Dpci.0,addr=3D0x7 -msg timestamp=3Don

Thanks,
Xiong

>=20
> Paolo
