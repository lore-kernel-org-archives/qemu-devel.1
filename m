Received: from eggs.gnu.org ([2001:4830:134:3::10]:56282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ciIGw-0008Uy-TC
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 05:11:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ciIGr-00035P-Py
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 05:11:14 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:33820)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1ciIGr-00034o-Go
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 05:11:09 -0500
Received: by mail-wm0-x241.google.com with SMTP id m70so12596697wma.1
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 02:11:07 -0800 (PST)
Date: Mon, 27 Feb 2017 10:11:04 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170227101104.GB28403@stefanha-x1.localdomain>
References: <20170227094050.ia6nrkvtvzmg7b2q@XZHOUW.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WYTEVAkct0FjGQmd"
Content-Disposition: inline
In-Reply-To: <20170227094050.ia6nrkvtvzmg7b2q@XZHOUW.usersys.redhat.com>
Subject: Re: [Qemu-devel] Fail to start 2nd guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Xiong Zhou <xzhou@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org


--WYTEVAkct0FjGQmd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 27, 2017 at 05:40:50PM +0800, Xiong Zhou wrote:
> It worked fine on Linus tree commit:
>   7bb0338 Merge tag 'rodata-v4.11-rc1' of git://git.kernel.org/pub/scm/..
>=20
> failed to start 2nd domain on this commit:
> 37c8596 Merge tag 'tty-4.11-rc1' of git://git.kernel.org/pub/scm/..
> (this commit probably is not the first bad, i didn't do the bisecting)
>=20
>=20
> sh-4.2# uname -r
> 4.10.0-master-37c8596+
> sh-4.2# rpm -qv qemu
> qemu-2.0.0-1.el7.6.x86_64
> sh-4.2# ps ajxf | grep qemu
> 11441 11462 11461 10972 pts/0    11461 S+       0   0:00              \_ =
grep qemu
>     1 11065 11064 11064 ?           -1 Sl     107   2:03 /usr/libexec/qem=
u-kvm -name 73h -S -machine pc-i440fx-rhel7.0.0,accel=3Dkvm,usb=3Doff,dump-=
guest-core=3Doff -cpu Haswell,-hle,-rtm -m 8000 -realtime mlock=3Doff -smp =
8,sockets=3D8,cores=3D1,threads=3D1 -uuid aab09e0f-d48a-4223-9b81-35d4718d5=
9fc -no-user-config -nodefaults -chardev socket,id=3Dcharmonitor,path=3D/va=
r/lib/libvirt/qemu/domain-1-73h/monitor.sock,server,nowait -mon chardev=3Dc=
harmonitor,id=3Dmonitor,mode=3Dcontrol -rtc base=3Dutc,driftfix=3Dslew -glo=
bal kvm-pit.lost_tick_policy=3Ddelay -no-hpet -no-shutdown -global PIIX4_PM=
=2Edisable_s3=3D1 -global PIIX4_PM.disable_s4=3D1 -boot strict=3Don -device=
 ich9-usb-ehci1,id=3Dusb,bus=3Dpci.0,addr=3D0x6.0x7 -device ich9-usb-uhci1,=
masterbus=3Dusb.0,firstport=3D0,bus=3Dpci.0,multifunction=3Don,addr=3D0x6 -=
device ich9-usb-uhci2,masterbus=3Dusb.0,firstport=3D2,bus=3Dpci.0,addr=3D0x=
6.0x1 -device ich9-usb-uhci3,masterbus=3Dusb.0,firstport=3D4,bus=3Dpci.0,ad=
dr=3D0x6.0x2 -device virtio-serial-pci,id=3Dvirtio-serial0,bus=3Dpci.0,addr=
=3D0x5 -drive file=3D/var/lib/libvirt/images/rhel73.qcow2,format=3Dqcow2,if=
=3Dnone,id=3Ddrive-ide0-0-0 -device ide-hd,bus=3Dide.0,unit=3D0,drive=3Ddri=
ve-ide0-0-0,id=3Dide0-0-0,bootindex=3D1 -drive file=3D/var/lib/libvirt/imag=
es/73h.qcow2,format=3Dqcow2,if=3Dnone,id=3Ddrive-ide0-0-1 -device ide-hd,bu=
s=3Dide.0,unit=3D1,drive=3Ddrive-ide0-0-1,id=3Dide0-0-1 -drive file=3D/root=
/RHEL-7.2-20151030.0-Server-x86_64-dvd1.iso,format=3Draw,if=3Dnone,id=3Ddri=
ve-ide0-1-0,readonly=3Don -device ide-cd,bus=3Dide.1,unit=3D0,drive=3Ddrive=
-ide0-1-0,id=3Dide0-1-0,bootindex=3D2 -netdev tap,fd=3D25,id=3Dhostnet0 -de=
vice rtl8139,netdev=3Dhostnet0,id=3Dnet0,mac=3D52:54:00:83:12:7b,bus=3Dpci.=
0,addr=3D0x3 -chardev pty,id=3Dcharserial0 -device isa-serial,chardev=3Dcha=
rserial0,id=3Dserial0 -chardev spicevmc,id=3Dcharchannel0,name=3Dvdagent -d=
evice virtserialport,bus=3Dvirtio-serial0.0,nr=3D1,chardev=3Dcharchannel0,i=
d=3Dchannel0,name=3Dcom.redhat.spice.0 -spice port=3D5900,addr=3D127.0.0.1,=
disable-ticketing,image-compression=3Doff,seamless-migration=3Don -vga qxl =
-global qxl-vga.ram_size=3D67108864 -global qxl-vga.vram_size=3D67108864 -g=
lobal qxl-vga.vgamem_mb=3D16 -device intel-hda,id=3Dsound0,bus=3Dpci.0,addr=
=3D0x4 -device hda-duplex,id=3Dsound0-codec0,bus=3Dsound0.0,cad=3D0 -charde=
v spicevmc,id=3Dcharredir0,name=3Dusbredir -device usb-redir,chardev=3Dchar=
redir0,id=3Dredir0,bus=3Dusb.0,port=3D1 -chardev spicevmc,id=3Dcharredir1,n=
ame=3Dusbredir -device usb-redir,chardev=3Dcharredir1,id=3Dredir1,bus=3Dusb=
=2E0,port=3D2 -device virtio-balloon-pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0=
x7 -msg timestamp=3Don
> sh-4.2# virsh list
>  Id    Name                           State
> ----------------------------------------------------
>  1     73h                            running
>=20
> sh-4.2# virsh start 73us
> error: Failed to start domain 73us
> error: internal error: qemu unexpectedly closed the monitor: ((null):1149=
7): Spice-Warning **: reds.c:2499:reds_init_socket: listen: Address already=
 in use
> 2017-02-27T09:33:42.335708Z qemu-kvm: failed to initialize spice server

The error message says that the spice remote desktop cannot listen on
-spice port=3D5900,addr=3D127.0.0.1.

Did you hardcode port 5900 in the domain XML?  That could explain why
the second guest fails to launch - you need to use unique port numbers
or let libvirt automatically assign them.  Check the domain XML:

  <graphics type=3D'spice' port=3D'-1' tlsPort=3D'-1' autoport=3D'yes'>

Another possibility is that a process running on the host is already
using port 5900.  Perhaps a guest or VNC server that was launched
outside of libvirt?  You can check this with:

  netstat -alpn | grep 5900

Stefan

--WYTEVAkct0FjGQmd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYs/s4AAoJEJykq7OBq3PIFKQIAJb/HHBfl8AWs/RK1gU99sHW
3UEHL2Y8bSdGYbJK16rQlKRa/6r4DbOJXcMIWKl57SQPM591wmzzSYw/w3vs/mbb
umkOu/m7ozBYJB5khJxw1eoDMXhwJlu/0HhdY2YvEBWU5nKibXJllogOiH0sMkm3
fSPUE3OzS2tzZakkjELsrRnm5zR/nG8gpM4YZGY9rjIFQCtAMF79gJmd1GBLwHOp
b0OBNmIlhDS1vfadLQWP86Bg6N/f18w6gTYmPgcsq2dBIbMB7j4pEyM71+ktmC1B
hzeC8kXXdcLGZqBzxg1iL000hUrzkDwRpW5BGJ4VEk3MjHeWEHZ1KO3Xi7ubmFc=
=c3wg
-----END PGP SIGNATURE-----

--WYTEVAkct0FjGQmd--
