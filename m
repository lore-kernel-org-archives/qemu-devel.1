Received: from eggs.gnu.org ([2001:4830:134:3::10]:34671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eOMhN-0002AW-2c
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 06:56:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eOMhJ-0002mJ-UY
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 06:56:41 -0500
Date: Mon, 11 Dec 2017 11:56:34 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171211115634.GI13593@stefanha-x1.localdomain>
References: <VI1PR10MB0301515CFEEA940842FDF26FB7330@VI1PR10MB0301.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VkVuOCYP9O7H3CXI"
Content-Disposition: inline
In-Reply-To: <VI1PR10MB0301515CFEEA940842FDF26FB7330@VI1PR10MB0301.EURPRD10.PROD.OUTLOOK.COM>
Subject: Re: [Qemu-devel] qemu process crash: Assertion failed:
 QLIST_EMPTY(&bs->tracked_requests)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fernando Casas =?iso-8859-1?Q?Sch=F6ssow?= <casasfernando@hotmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-block@nongnu.org, Jeff Cody <jcody@redhat.com>


--VkVuOCYP9O7H3CXI
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 07, 2017 at 10:18:52AM +0000, Fernando Casas Sch=F6ssow wrote:
> Hi there,
>=20
>=20
> Last night while doing a backup of a guest using the live snapshot mechan=
ism the qemu process for the guest seem to had crashed.
>=20
> The snapshot succeeded then the backup of the VM disk had place and also =
succeeded but the commit to the original disk after the backup seem to have=
 failed.
>=20
> The command I use in the script to take the snapshot is:
>=20
>=20
> virsh snapshot-create-as --domain $VM backup-job.qcow2 --disk-only --atom=
ic --quiesce --no-metadata
>=20
>=20
> And then to commit back is:
>=20
>=20
> virsh blockcommit $VM $TARGETDISK --base $DISKFILE --top $SNAPFILE --acti=
ve --pivot
>=20
>=20
> In the qemu log for the guest I found the following while the commit back=
 was having place:
>=20
>=20
> Assertion failed: QLIST_EMPTY(&bs->tracked_requests) (/home/buildozer/apo=
rts/main/qemu/src/qemu-2.10.1/block/mirror.c: mirror_run: 884)
>=20
> I'm running qemu 2.10.1 with libvirt 3.9.0 and kernel 4.9.65 on Alpine Li=
nux 3.7.
>=20
> This is the complete guest info from the logs:
>=20
>=20
> LC_ALL=3DC PATH=3D/bin:/sbin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/bin:/usr/=
sbin:/usr/local/bin:/usr/local/sbin HOME=3D/root USER=3Droot QEMU_AUDIO_DRV=
=3Dspice /usr/bin/qemu-system-x86_64 -name guest=3DDOCKER01,debug-threads=
=3Don -S -object secret,id=3DmasterKey0,format=3Draw,file=3D/var/lib/libvir=
t/qemu/domain-6-DOCKER01/master-key.aes -machine pc-i440fx-2.8,accel=3Dkvm,=
usb=3Doff,dump-guest-core=3Doff -cpu IvyBridge,ss=3Don,vmx=3Don,pcid=3Don,h=
ypervisor=3Don,arat=3Don,tsc_adjust=3Don,xsaveopt=3Don -drive file=3D/usr/s=
hare/edk2.git/ovmf-x64/OVMF_CODE-pure-efi.fd,if=3Dpflash,format=3Draw,unit=
=3D0,readonly=3Don -drive file=3D/var/lib/libvirt/qemu/nvram/DOCKER01_VARS.=
fd,if=3Dpflash,format=3Draw,unit=3D1 -m 2048 -realtime mlock=3Doff -smp 2,s=
ockets=3D2,cores=3D1,threads=3D1 -uuid 4705b146-3b14-4c20-923c-42105d47e7fc=
 -no-user-config -nodefaults -chardev socket,id=3Dcharmonitor,path=3D/var/l=
ib/libvirt/qemu/domain-6-DOCKER01/monitor.sock,server,nowait -mon chardev=
=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol -rtc base=3Dutc,driftfix=3Dslew =
-global kvm-pit.lost_tick_policy=3Ddelay -no-hpet -no-shutdown -global PIIX=
4_PM.disable_s3=3D1 -global PIIX4_PM.disable_s4=3D1 -boot strict=3Don -devi=
ce ich9-usb-ehci1,id=3Dusb,bus=3Dpci.0,addr=3D0x4.0x7 -device ich9-usb-uhci=
1,masterbus=3Dusb.0,firstport=3D0,bus=3Dpci.0,multifunction=3Don,addr=3D0x4=
 -device ich9-usb-uhci2,masterbus=3Dusb.0,firstport=3D2,bus=3Dpci.0,addr=3D=
0x4.0x1 -device ich9-usb-uhci3,masterbus=3Dusb.0,firstport=3D4,bus=3Dpci.0,=
addr=3D0x4.0x2 -device ahci,id=3Dsata0,bus=3Dpci.0,addr=3D0x9 -device virti=
o-serial-pci,id=3Dvirtio-serial0,bus=3Dpci.0,addr=3D0x5 -drive file=3D/stor=
age/storage-ssd-vms/virtual_machines_ssd/docker01.qcow2,format=3Dqcow2,if=
=3Dnone,id=3Ddrive-sata0-0-0,cache=3Dnone,aio=3Dthreads -device ide-hd,bus=
=3Dsata0.0,drive=3Ddrive-sata0-0-0,id=3Dsata0-0-0,bootindex=3D1 -netdev tap=
,fd=3D33,id=3Dhostnet0,vhost=3Don,vhostfd=3D35 -device virtio-net-pci,netde=
v=3Dhostnet0,id=3Dnet0,mac=3D52:54:00:1c:af:ce,bus=3Dpci.0,addr=3D0x3 -char=
dev pty,id=3Dcharserial0 -device isa-serial,chardev=3Dcharserial0,id=3Dseri=
al0 -chardev socket,id=3Dcharchannel0,path=3D/var/lib/libvirt/qemu/channel/=
target/domain-6-DOCKER01/org.qemu.guest_agent.0,server,nowait -device virts=
erialport,bus=3Dvirtio-serial0.0,nr=3D1,chardev=3Dcharchannel0,id=3Dchannel=
0,name=3Dorg.qemu.guest_agent.0 -chardev spicevmc,id=3Dcharchannel1,name=3D=
vdagent -device virtserialport,bus=3Dvirtio-serial0.0,nr=3D2,chardev=3Dchar=
channel1,id=3Dchannel1,name=3Dcom.redhat.spice.0 -spice port=3D5905,addr=3D=
127.0.0.1,disable-ticketing,seamless-migration=3Don -device qxl-vga,id=3Dvi=
deo0,ram_size=3D67108864,vram_size=3D67108864,vram64_size_mb=3D0,vgamem_mb=
=3D16,max_outputs=3D1,bus=3Dpci.0,addr=3D0x2 -chardev spicevmc,id=3Dcharred=
ir0,name=3Dusbredir -device usb-redir,chardev=3Dcharredir0,id=3Dredir0,bus=
=3Dusb.0,port=3D2 -chardev spicevmc,id=3Dcharredir1,name=3Dusbredir -device=
 usb-redir,chardev=3Dcharredir1,id=3Dredir1,bus=3Dusb.0,port=3D3 -device vi=
rtio-balloon-pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x7 -object rng-random,id=
=3Dobjrng0,filename=3D/dev/random -device virtio-rng-pci,rng=3Dobjrng0,id=
=3Drng0,bus=3Dpci.0,addr=3D0x8 -msg timestamp=3Don
>=20
>=20
>=20
> I was running on qemu 2.8.1 for months and didn't have any problems with =
the backups but yesterday I updated to qemu 2.10.1 and I hit this problem l=
ast night.
>=20
>=20
> Is this a bug? Any ideas will be appreciated.

Thanks for reporting this bug.  Can you reproduce it reliably?

Stefan

--VkVuOCYP9O7H3CXI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaLnJyAAoJEJykq7OBq3PImkUH/3PMKZHRCLyzS1Exzqs+M4n6
wp1rlUdVsaR5GxRCdMU5jIe5vPEZ039VeWQbmrOh1DdCHMr5K8CpWX+2q4fzsnrQ
2l5SbGXUDnhIWzIEhZ8NfOjwHOi4QiyQgWkyn0Yv2RE8kNFC3OItVgZdIy4rM2gD
5Md4BjrSp6I7XeXmcIGi5lTmHzJA6QFsE6YnCNywWes8QHCMWxmQXWxF5CRGcWQ8
P8FHKSD1hufnrGWjp0oZUfuw4DFRWJ3BM5Ok5XOw8iUSfMXCN5e6UZRJkAP8XVbD
8/HHxHvPn4ErDl4KA4btnRXsyZJz0HT2GIrqk7Isp2B38CIV32ok5AqRJ7DiptA=
=nORp
-----END PGP SIGNATURE-----

--VkVuOCYP9O7H3CXI--
