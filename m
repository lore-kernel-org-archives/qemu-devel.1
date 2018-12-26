Received: from eggs.gnu.org ([208.118.235.92]:47858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fziglio@redhat.com>) id 1gc8SK-0001dH-7y
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 07:38:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fziglio@redhat.com>) id 1gc8SF-0002lH-M1
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 07:38:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50104)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fziglio@redhat.com>) id 1gc8SF-0002kQ-EY
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 07:38:31 -0500
Date: Wed, 26 Dec 2018 07:38:28 -0500 (EST)
From: Frediano Ziglio <fziglio@redhat.com>
Message-ID: <254296205.54150897.1545827908434.JavaMail.zimbra@redhat.com>
In-Reply-To: <9de9afbe-fc7b-48a0-9b2d-b756f146303d@linuxsystems.it>
References: <110999ea-0ab9-49cb-915f-6d08cccdea3c@linuxsystems.it>
	<47cfb9f8-5957-7935-063b-304e3c53c268@redhat.com>
	<9de9afbe-fc7b-48a0-9b2d-b756f146303d@linuxsystems.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Spice-devel] Always get Invalid password while
 trying to connect to spice server
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Niccol=C3=B2?= Belli <darkbasic@linuxsystems.it>, armbru@redhat.com, secalert@redhat.com, mst@redhat.com
Cc: Uri Lublin <uril@redhat.com>, spice-devel@lists.freedesktop.org, qemu-devel@nongnu.org

>=20
> On marted=C3=AC 25 dicembre 2018 09:04:31 CET, Uri Lublin wrote:
> > Hi,
>=20
> Hi and thanks for your answer.
>=20
> > It's hard to tell without more details.
>=20
> I'll try to provide all the details, let me know if you need anything els=
e.
>=20
> > How do you set the password ?
>=20
> I set the password using the virt-manager interface: in the "Spice server=
"
> section I just check the "password" flag and I set a password. It used to
> work. I don't use virt-manager directly from the virtualization server
> because it doesn't have any graphical interface: I connect to it using
> virt-manager from my desktop PC (more details follow).
>=20
> > Do you use secure connections ?
>=20
> I connect to the remote libvirt server using virt-manager from my desktop=
.
> The libvirt URI is qemu+ssh://root@ip:22/system so I use ssh to connect.
>=20
> > Maybe you turned on a firewall and a rule is missing.
>=20
> There is a firewall, but it didn't change. SSH port is open (and I can
> connect to the libvirt server using virt-manager). I also opened a broad
> range of spice ports (5900-5930) and that works too because if I uncheck
> the "password" field it connects to the spice server without any issue.
>=20
> I also tried to connect directly to the spice server using virt-viewer
> instead of virt-manager:
>=20
> remote-viewer spice://ip:5906
>=20
> 5906 is the spice port. I can check which VM gets assigned to which port
> using the virt-manager interface, in the "Spice server" section.
>=20
> remote-viewer triggers the same error: wrong password.
>=20
> > What is your qemu-kvm command line ?
>=20
> LC_ALL=3DC PATH=3D/usr/local/sbin:/usr/local/bin:/usr/bin QEMU_AUDIO_DRV=
=3Dspice
> /usr/bin/qemu-system-x86_64 -name guest=3Dguild-devel,debug-threads=3Don =
-S
> -object
> secret,id=3DmasterKey0,format=3Draw,file=3D/var/lib/libvirt/qemu/domain-1=
7-guild-devel/master-key.aes
> -machine pc-q35-3.0,accel=3Dkvm,usb=3Doff,vmport=3Doff,dump-guest-core=3D=
off -cpu
> EPYC-IBPB,x2apic=3Don,tsc-deadline=3Don,hypervisor=3Don,tsc_adjust=3Don,c=
mp_legacy=3Don,perfctr_core=3Don,virt-ssbd=3Don,monitor=3Doff
> -drive
> file=3D/usr/share/ovmf/x64/OVMF_CODE.fd,if=3Dpflash,format=3Draw,unit=3D0=
,readonly=3Don
> -drive
> file=3D/var/lib/libvirt/qemu/nvram/guild-devel_VARS.fd,if=3Dpflash,format=
=3Draw,unit=3D1
> -m 4096 -realtime mlock=3Doff -smp 16,sockets=3D16,cores=3D1,threads=3D1 =
-uuid
> fd44b44b-2e22-4d2f-ae19-433934443576 -no-user-config -nodefaults -chardev
> socket,id=3Dcharmonitor,fd=3D32,server,nowait -mon
> chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol -rtc base=3Dutc,driftfi=
x=3Dslew
> -global kvm-pit.lost_tick_policy=3Ddelay -no-hpet -no-shutdown -global
> ICH9-LPC.disable_s3=3D1 -global ICH9-LPC.disable_s4=3D1 -boot strict=3Don=
 -device
> pcie-root-port,port=3D0x10,chassis=3D1,id=3Dpci.1,bus=3Dpcie.0,multifunct=
ion=3Don,addr=3D0x2
> -device pcie-root-port,port=3D0x11,chassis=3D2,id=3Dpci.2,bus=3Dpcie.0,ad=
dr=3D0x2.0x1
> -device pcie-root-port,port=3D0x12,chassis=3D3,id=3Dpci.3,bus=3Dpcie.0,ad=
dr=3D0x2.0x2
> -device pcie-root-port,port=3D0x13,chassis=3D4,id=3Dpci.4,bus=3Dpcie.0,ad=
dr=3D0x2.0x3
> -device pcie-root-port,port=3D0x14,chassis=3D5,id=3Dpci.5,bus=3Dpcie.0,ad=
dr=3D0x2.0x4
> -device pcie-root-port,port=3D0x15,chassis=3D6,id=3Dpci.6,bus=3Dpcie.0,ad=
dr=3D0x2.0x5
> -device pcie-root-port,port=3D0x16,chassis=3D7,id=3Dpci.7,bus=3Dpcie.0,ad=
dr=3D0x2.0x6
> -device qemu-xhci,p2=3D15,p3=3D15,id=3Dusb,bus=3Dpci.2,addr=3D0x0 -device
> virtio-serial-pci,id=3Dvirtio-serial0,bus=3Dpci.3,addr=3D0x0 -drive
> file=3D/var/lib/libvirt/images/Fedora-Workstation-Live-x86_64-29-1.2.iso,=
format=3Draw,if=3Dnone,id=3Ddrive-sata0-0-0,media=3Dcdrom,readonly=3Don
> -device ide-cd,bus=3Dide.0,drive=3Ddrive-sata0-0-0,id=3Dsata0-0-0,bootind=
ex=3D2
> -drive
> file=3D/var/lib/libvirt/images/guild-devel/guild-devel.qcow2,format=3Dqco=
w2,if=3Dnone,id=3Ddrive-virtio-disk0,cache=3Dwriteback,aio=3Dthreads
> -device
> virtio-blk-pci,scsi=3Doff,bus=3Dpci.4,addr=3D0x0,drive=3Ddrive-virtio-dis=
k0,id=3Dvirtio-disk0,bootindex=3D1,write-cache=3Don,werror=3Dstop,rerror=3D=
stop
> -netdev tap,fd=3D35,id=3Dhostnet0,vhost=3Don,vhostfd=3D36 -device
> virtio-net-pci,netdev=3Dhostnet0,id=3Dnet0,mac=3D52:54:00:b6:70:81,bus=3D=
pci.1,addr=3D0x0
> -chardev pty,id=3Dcharserial0 -device
> isa-serial,chardev=3Dcharserial0,id=3Dserial0 -chardev
> socket,id=3Dcharchannel0,fd=3D37,server,nowait -device
> virtserialport,bus=3Dvirtio-serial0.0,nr=3D1,chardev=3Dcharchannel0,id=3D=
channel0,name=3Dorg.qemu.guest_agent.0
> -chardev spicevmc,id=3Dcharchannel1,name=3Dvdagent -device
> virtserialport,bus=3Dvirtio-serial0.0,nr=3D2,chardev=3Dcharchannel1,id=3D=
channel1,name=3Dcom.redhat.spice.0
> -device usb-tablet,id=3Dinput0,bus=3Dusb.0,port=3D1 -spice
> port=3D5905,addr=3D0.0.0.0,seamless-migration=3Don -k en-us -device
> virtio-vga,id=3Dvideo0,virgl=3Don,max_outputs=3D1,bus=3Dpcie.0,addr=3D0x1=
 -device
> ich9-intel-hda,id=3Dsound0,bus=3Dpcie.0,addr=3D0x1b -device
> hda-duplex,id=3Dsound0-codec0,bus=3Dsound0.0,cad=3D0 -chardev
> spicevmc,id=3Dcharredir0,name=3Dusbredir -device
> usb-redir,chardev=3Dcharredir0,id=3Dredir0,bus=3Dusb.0,port=3D2 -chardev
> spicevmc,id=3Dcharredir1,name=3Dusbredir -device
> usb-redir,chardev=3Dcharredir1,id=3Dredir1,bus=3Dusb.0,port=3D3 -device
> virtio-balloon-pci,id=3Dballoon0,bus=3Dpci.5,addr=3D0x0 -object
> rng-random,id=3Dobjrng0,filename=3D/dev/urandom -device
> virtio-rng-pci,rng=3Dobjrng0,id=3Drng0,bus=3Dpci.6,addr=3D0x0 -sandbox
> on,obsolete=3Ddeny,elevateprivileges=3Ddeny,spawn=3Ddeny,resourcecontrol=
=3Ddeny
> -msg timestamp=3Don
>=20
> I just noticed that the problem looks limited to special characters.
> For example if I set "Password" as password it works, while if I set
> "Password%%" it doesn't. It's weird because both my server and my desktop
> client use the same US English layout. It's even more weird because the
> same password used to work fine before.
>=20
> I also noticed that if I set "Password%" (with one % instead of two) I ge=
t
> the following error while starting the VM:
>=20
> Errore nell'avvio del dominio: internal error: qemu unexpectedly closed t=
he
> monitor: qemu-system-x86_64:
> /build/qemu/src/qemu-3.1.0/qobject/json-parser.c:146: parse_string:
> Assertion `*ptr' failed.
>=20
> Traceback (most recent call last):
>   File "/usr/share/virt-manager/virtManager/asyncjob.py", line 75, in
> cb_wrapper
>     callback(asyncjob, *args, **kwargs)
>   File "/usr/share/virt-manager/virtManager/asyncjob.py", line 111, in
> tmpcb
>     callback(*args, **kwargs)
>   File "/usr/share/virt-manager/virtManager/libvirtobject.py", line 66, i=
n
> newfn
>     ret =3D fn(self, *args, **kwargs)
>   File "/usr/share/virt-manager/virtManager/domain.py", line 1400, in
> startup
>     self._backend.create()
>   File "/usr/lib/python3.7/site-packages/libvirt.py", line 1080, in creat=
e
>     if ret =3D=3D -1: raise libvirtError ('virDomainCreate() failed', dom=
=3Dself)
> libvirt.libvirtError: internal error: qemu unexpectedly closed the monito=
r:
> qemu-system-x86_64: /build/qemu/src/qemu-3.1.0/qobject/json-parser.c:146:
> parse_string: Assertion `*ptr' failed.
>=20
> This is very, very weird. Any idea?
>=20

Yes, this looks like a format string error in the upper (not into spice) la=
yer.

This potentially is a security problem.

The specific '%' character could be the issue, can you try others ('!', '@'=
 and
so on) ?

> > Happy Holidays,
> >     Uri.
>=20
> You too,
> Niccolo'

Frediano
