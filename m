Received: from eggs.gnu.org ([209.51.188.92]:55065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gt294-0006jQ-I8
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 22:20:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gt26M-0006wB-Cd
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 22:17:48 -0500
Date: Mon, 11 Feb 2019 11:17:25 +0800
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190211031725.GB18083@stefanha-x1.localdomain>
References: <CABdb7377U9SpZno1kU6+TuARUmqfMMcC2uuwXTHqSZpLsqB7Gw@mail.gmail.com>
	<1498199343.2815.0@smtp-mail.outlook.com>
	<VI1PR1001MB13731EF256C1E7380E1D657AB7D90@VI1PR1001MB1373.EURPRD10.PROD.OUTLOOK.COM>
	<VI1PR0602MB324559765BFE372F75D52E57A4910@VI1PR0602MB3245.eurprd06.prod.outlook.com>
	<20190201054849.GH23131@stefanha-x1.localdomain>
	<VI1PR0602MB32452A8FD128F63FFAC0CEADA4920@VI1PR0602MB3245.eurprd06.prod.outlook.com>
	<20190204060636.GF29758@stefanha-x1.localdomain>
	<AM5PR0602MB32368CB5ADDEC05F42D8BC8FA46D0@AM5PR0602MB3236.eurprd06.prod.outlook.com>
	<AM5PR0602MB32368CB5ADDEC05F42D8BC8FA46D0@AM5PR0602MB3236.eurprd06.prod.outlo>
	<VI1PR0602MB3245FD0A939EC3E28CA0F740A46F0@VI1PR0602MB3245.eurprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8P1HSweYDcXXzwPJ"
Content-Disposition: inline
In-Reply-To: <VI1PR0602MB3245FD0A939EC3E28CA0F740A46F0@VI1PR0602MB3245.eurprd06.prod.outlook.com>
Subject: Re: [Qemu-devel] [Qemu-block] Guest unresponsive after Virtqueue
 size exceeded error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fernando Casas =?iso-8859-1?Q?Sch=F6ssow?= <casasfernando@outlook.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>


--8P1HSweYDcXXzwPJ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 06, 2019 at 04:47:19PM +0000, Fernando Casas Sch=F6ssow wrote:
> I could also repro the same with virtio-scsi on the same guest a couple o=
f hours later:
>=20
> 2019-02-06 07:10:37.672+0000: starting up libvirt version: 4.10.0, qemu v=
ersion: 3.1.0, kernel: 4.19.18-0-vanilla, hostname: vmsvr01.homenet.local
> LC_ALL=3DC PATH=3D/bin:/sbin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/bin:/usr/=
sbin:/usr/local/bin:/usr/local/sbin HOME=3D/root USER=3Droot QEMU_AUDIO_DRV=
=3Dspice /home/fernando/qemu-system-x86_64 -name guest=3DDOCKER01,debug-thr=
eads=3Don -S -object secret,id=3DmasterKey0,format=3Draw,file=3D/var/lib/li=
bvirt/qemu/domain-32-DOCKER01/master-key.aes -machine pc-i440fx-3.1,accel=
=3Dkvm,usb=3Doff,dump-guest-core=3Doff -cpu IvyBridge,ss=3Don,vmx=3Don,pcid=
=3Don,hypervisor=3Don,arat=3Don,tsc_adjust=3Don,umip=3Don,xsaveopt=3Don -dr=
ive file=3D/usr/share/edk2.git/ovmf-x64/OVMF_CODE-pure-efi.fd,if=3Dpflash,f=
ormat=3Draw,unit=3D0,readonly=3Don -drive file=3D/var/lib/libvirt/qemu/nvra=
m/DOCKER01_VARS.fd,if=3Dpflash,format=3Draw,unit=3D1 -m 2048 -realtime mloc=
k=3Doff -smp 2,sockets=3D2,cores=3D1,threads=3D1 -uuid 4705b146-3b14-4c20-9=
23c-42105d47e7fc -no-user-config -nodefaults -chardev socket,id=3Dcharmonit=
or,fd=3D46,server,nowait -mon chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcon=
trol -rtc base=3Dutc,driftfix=3Dslew -global kvm-pit.lost_tick_policy=3Ddel=
ay -no-hpet -no-shutdown -global PIIX4_PM.disable_s3=3D1 -global PIIX4_PM.d=
isable_s4=3D1 -boot strict=3Don -device ich9-usb-ehci1,id=3Dusb,bus=3Dpci.0=
,addr=3D0x4.0x7 -device ich9-usb-uhci1,masterbus=3Dusb.0,firstport=3D0,bus=
=3Dpci.0,multifunction=3Don,addr=3D0x4 -device ich9-usb-uhci2,masterbus=3Du=
sb.0,firstport=3D2,bus=3Dpci.0,addr=3D0x4.0x1 -device ich9-usb-uhci3,master=
bus=3Dusb.0,firstport=3D4,bus=3Dpci.0,addr=3D0x4.0x2 -device virtio-scsi-pc=
i,id=3Dscsi0,bus=3Dpci.0,addr=3D0x6 -device virtio-serial-pci,id=3Dvirtio-s=
erial0,bus=3Dpci.0,addr=3D0x5 -drive file=3D/storage/storage-ssd-vms/virtua=
l_machines_ssd/docker01.qcow2,format=3Dqcow2,if=3Dnone,id=3Ddrive-scsi0-0-0=
-0,cache=3Dnone,aio=3Dthreads -device scsi-hd,bus=3Dscsi0.0,channel=3D0,scs=
i-id=3D0,lun=3D0,drive=3Ddrive-scsi0-0-0-0,id=3Dscsi0-0-0-0,bootindex=3D1,w=
rite-cache=3Don -netdev tap,fd=3D48,id=3Dhostnet0,vhost=3Don,vhostfd=3D50 -=
device virtio-net-pci,netdev=3Dhostnet0,id=3Dnet0,mac=3D52:54:00:1c:af:ce,b=
us=3Dpci.0,addr=3D0x3 -chardev pty,id=3Dcharserial0 -device isa-serial,char=
dev=3Dcharserial0,id=3Dserial0 -chardev socket,id=3Dcharchannel0,fd=3D51,se=
rver,nowait -device virtserialport,bus=3Dvirtio-serial0.0,nr=3D1,chardev=3D=
charchannel0,id=3Dchannel0,name=3Dorg.qemu.guest_agent.0 -chardev spicevmc,=
id=3Dcharchannel1,name=3Dvdagent -device virtserialport,bus=3Dvirtio-serial=
0.0,nr=3D2,chardev=3Dcharchannel1,id=3Dchannel1,name=3Dcom.redhat.spice.0 -=
spice port=3D5904,addr=3D127.0.0.1,disable-ticketing,seamless-migration=3Do=
n -device qxl-vga,id=3Dvideo0,ram_size=3D67108864,vram_size=3D67108864,vram=
64_size_mb=3D0,vgamem_mb=3D16,max_outputs=3D1,bus=3Dpci.0,addr=3D0x2 -chard=
ev spicevmc,id=3Dcharredir0,name=3Dusbredir -device usb-redir,chardev=3Dcha=
rredir0,id=3Dredir0,bus=3Dusb.0,port=3D2 -chardev spicevmc,id=3Dcharredir1,=
name=3Dusbredir -device usb-redir,chardev=3Dcharredir1,id=3Dredir1,bus=3Dus=
b.0,port=3D3 -device virtio-balloon-pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x=
7 -object rng-random,id=3Dobjrng0,filename=3D/dev/random -device virtio-rng=
-pci,rng=3Dobjrng0,id=3Drng0,bus=3Dpci.0,addr=3D0x8 -sandbox on,obsolete=3D=
deny,elevateprivileges=3Ddeny,spawn=3Ddeny,resourcecontrol=3Ddeny -msg time=
stamp=3Don
> 2019-02-06 07:10:37.672+0000: Domain id=3D32 is tainted: high-privileges
> char device redirected to /dev/pts/5 (label charserial0)
> vdev 0x5585456ef6b0 ("virtio-scsi")
> vq 0x5585456f90a0 (idx 2)
> inuse 128 vring.num 128
> 2019-02-06T13:00:46.942424Z qemu-system-x86_64: Virtqueue size exceeded
>=20
>=20
> I'm open to any tests or suggestions that can move the investigation forw=
ard and find the cause of this issue.

Thanks for collecting the data!

The fact that both virtio-blk and virtio-scsi failed suggests it's not a
virtqueue element leak in the virtio-blk or virtio-scsi device emulation
code.

The hung task error messages from inside the guest are a consequence of
QEMU hitting the "Virtqueue size exceeded" error.  QEMU refuses to
process further requests after the error, causing tasks inside the guest
to get stuck on I/O.

I don't have a good theory regarding the root cause.  Two ideas:
1. The guest is corrupting the vring or submitting more requests than
   will fit into the ring.  Somewhat unlikely because it happens with
   both Windows and Linux guests.
2. QEMU's virtqueue code is buggy, maybe the memory region cache which
   is used for fast guest RAM accesses.

Here is an expanded version of the debug patch which might help identify
which of these scenarios is likely.  Sorry, it requires running the
guest again!

This time let's make QEMU dump core so both QEMU state and guest RAM are
captured for further debugging.  That way it will be possible to extract
more information using gdb without rerunning.

Stefan
---
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index a1ff647a66..28d89fcbcb 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -866,6 +866,7 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)
         return NULL;
     }
     rcu_read_lock();
+    uint16_t old_shadow_avail_idx =3D vq->shadow_avail_idx;
     if (virtio_queue_empty_rcu(vq)) {
         goto done;
     }
@@ -879,6 +880,12 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)
     max =3D vq->vring.num;

     if (vq->inuse >=3D vq->vring.num) {
+        fprintf(stderr, "vdev %p (\"%s\")\n", vdev, vdev->name);
+        fprintf(stderr, "vq %p (idx %u)\n", vq, (unsigned int)(vq - vdev->=
vq));
+        fprintf(stderr, "inuse %u vring.num %u\n", vq->inuse, vq->vring.nu=
m);
+        fprintf(stderr, "old_shadow_avail_idx %u last_avail_idx %u avail_i=
dx %u\n", old_shadow_avail_idx, vq->last_avail_idx, vq->shadow_avail_idx);
+        fprintf(stderr, "avail %#" HWADDR_PRIx " avail_idx (cache bypassed=
) %u\n", vq->vring.avail, virtio_lduw_phys(vdev, vq->vring.avail + offsetof=
(VRingAvail, idx)));
+        fprintf(stderr, "used_idx %u\n", vq->used_idx);
+        abort(); /* <--- core dump! */
         virtio_error(vdev, "Virtqueue size exceeded");
         goto done;
     }


--8P1HSweYDcXXzwPJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcYOlFAAoJEJykq7OBq3PIPXkIAKeDa79rLLw6GMjH5CIGjGmP
Ma4zAw+eg6uK6wQRQrmcgPif/Sbb7hHtSFoPbleDZJ1HlHt4IYJ2kgLkkACVqovQ
RK2At65Yvhhs+P9h4mzhHPt66LZKpqukqLlZEJkDQ47Dbqq5phH8ba1IvrSg9dwC
ruTjF7WfUx54+XB/D2vKgkCFHkfYZ3F9yGg/Ym5oQ4aaG29y/3HFqQYKd49m/uDz
SboUes+dwEOO5v5xInbeZZPKsndW1oXiVosNw70pDASkd9Y6RZtQJ5OSheEnT5n1
sl7jG1QPNUp2cTo6n2Mt137tLji12I/7AloxXUG1g4gVcQfTWM/2RatB5IhD+uk=
=8Kfd
-----END PGP SIGNATURE-----

--8P1HSweYDcXXzwPJ--
