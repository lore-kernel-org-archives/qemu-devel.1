Received: from eggs.gnu.org ([209.51.188.92]:35143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <casasfernando@outlook.com>) id 1gt8CZ-0006AG-7x
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 04:48:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <casasfernando@outlook.com>) id 1gt8CU-00041m-Us
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 04:48:34 -0500
From: =?iso-8859-1?Q?Fernando_Casas_Sch=F6ssow?= <casasfernando@outlook.com>
Date: Mon, 11 Feb 2019 09:48:21 +0000
Message-ID: <VI1PR0602MB3245A59F3549AF077F498BBDA4640@VI1PR0602MB3245.eurprd06.prod.outlook.com>
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
	<20190211031725.GB18083@stefanha-x1.localdomain>
In-Reply-To: <20190211031725.GB18083@stefanha-x1.localdomain>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
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
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>

Thanks for looking into this Stefan.

I rebuilt Qemu with the new patch and got a couple of guests running with t=
he new build. Two of them using virtio-scsi and another one using virtio-bl=
k. Now I'm waiting for any of them to crash.
I also set libvirt to include the guest memory in the qemu dumps as I under=
stood you will want to look at both (qemu dump and guest memory dump).

I will reply to this thread once I have any news.

Kind regards.

Fernando

On lun, feb 11, 2019 at 4:17 AM, Stefan Hajnoczi <stefanha@gmail.com> wrote=
:
On Wed, Feb 06, 2019 at 04:47:19PM +0000, Fernando Casas Sch=F6ssow wrote:
I could also repro the same with virtio-scsi on the same guest a couple of =
hours later: 2019-02-06 07:10:37.672+0000: starting up libvirt version: 4.1=
0.0, qemu version: 3.1.0, kernel: 4.19.18-0-vanilla, hostname: vmsvr01.home=
net.local LC_ALL=3DC PATH=3D/bin:/sbin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/b=
in:/usr/sbin:/usr/local/bin:/usr/local/sbin HOME=3D/root USER=3Droot QEMU_A=
UDIO_DRV=3Dspice /home/fernando/qemu-system-x86_64 -name guest=3DDOCKER01,d=
ebug-threads=3Don -S -object secret,id=3DmasterKey0,format=3Draw,file=3D/va=
r/lib/libvirt/qemu/domain-32-DOCKER01/master-key.aes -machine pc-i440fx-3.1=
,accel=3Dkvm,usb=3Doff,dump-guest-core=3Doff -cpu IvyBridge,ss=3Don,vmx=3Do=
n,pcid=3Don,hypervisor=3Don,arat=3Don,tsc_adjust=3Don,umip=3Don,xsaveopt=3D=
on -drive file=3D/usr/share/edk2.git/ovmf-x64/OVMF_CODE-pure-efi.fd,if=3Dpf=
lash,format=3Draw,unit=3D0,readonly=3Don -drive file=3D/var/lib/libvirt/qem=
u/nvram/DOCKER01_VARS.fd,if=3Dpflash,format=3Draw,unit=3D1 -m 2048 -realtim=
e mlock=3Doff -smp 2,sockets=3D2,cores=3D1,threads=3D1 -uuid 4705b146-3b14-=
4c20-923c-42105d47e7fc -no-user-config -nodefaults -chardev socket,id=3Dcha=
rmonitor,fd=3D46,server,nowait -mon chardev=3Dcharmonitor,id=3Dmonitor,mode=
=3Dcontrol -rtc base=3Dutc,driftfix=3Dslew -global kvm-pit.lost_tick_policy=
=3Ddelay -no-hpet -no-shutdown -global PIIX4_PM.disable_s3=3D1 -global PIIX=
4_PM.disable_s4=3D1 -boot strict=3Don -device ich9-usb-ehci1,id=3Dusb,bus=
=3Dpci.0,addr=3D0x4.0x7 -device ich9-usb-uhci1,masterbus=3Dusb.0,firstport=
=3D0,bus=3Dpci.0,multifunction=3Don,addr=3D0x4 -device ich9-usb-uhci2,maste=
rbus=3Dusb.0,firstport=3D2,bus=3Dpci.0,addr=3D0x4.0x1 -device ich9-usb-uhci=
3,masterbus=3Dusb.0,firstport=3D4,bus=3Dpci.0,addr=3D0x4.0x2 -device virtio=
-scsi-pci,id=3Dscsi0,bus=3Dpci.0,addr=3D0x6 -device virtio-serial-pci,id=3D=
virtio-serial0,bus=3Dpci.0,addr=3D0x5 -drive file=3D/storage/storage-ssd-vm=
s/virtual_machines_ssd/docker01.qcow2,format=3Dqcow2,if=3Dnone,id=3Ddrive-s=
csi0-0-0-0,cache=3Dnone,aio=3Dthreads -device scsi-hd,bus=3Dscsi0.0,channel=
=3D0,scsi-id=3D0,lun=3D0,drive=3Ddrive-scsi0-0-0-0,id=3Dscsi0-0-0-0,bootind=
ex=3D1,write-cache=3Don -netdev tap,fd=3D48,id=3Dhostnet0,vhost=3Don,vhostf=
d=3D50 -device virtio-net-pci,netdev=3Dhostnet0,id=3Dnet0,mac=3D52:54:00:1c=
:af:ce,bus=3Dpci.0,addr=3D0x3 -chardev pty,id=3Dcharserial0 -device isa-ser=
ial,chardev=3Dcharserial0,id=3Dserial0 -chardev socket,id=3Dcharchannel0,fd=
=3D51,server,nowait -device virtserialport,bus=3Dvirtio-serial0.0,nr=3D1,ch=
ardev=3Dcharchannel0,id=3Dchannel0,name=3Dorg.qemu.guest_agent.0 -chardev s=
picevmc,id=3Dcharchannel1,name=3Dvdagent -device virtserialport,bus=3Dvirti=
o-serial0.0,nr=3D2,chardev=3Dcharchannel1,id=3Dchannel1,name=3Dcom.redhat.s=
pice.0 -spice port=3D5904,addr=3D127.0.0.1,disable-ticketing,seamless-migra=
tion=3Don -device qxl-vga,id=3Dvideo0,ram_size=3D67108864,vram_size=3D67108=
864,vram64_size_mb=3D0,vgamem_mb=3D16,max_outputs=3D1,bus=3Dpci.0,addr=3D0x=
2 -chardev spicevmc,id=3Dcharredir0,name=3Dusbredir -device usb-redir,chard=
ev=3Dcharredir0,id=3Dredir0,bus=3Dusb.0,port=3D2 -chardev spicevmc,id=3Dcha=
rredir1,name=3Dusbredir -device usb-redir,chardev=3Dcharredir1,id=3Dredir1,=
bus=3Dusb.0,port=3D3 -device virtio-balloon-pci,id=3Dballoon0,bus=3Dpci.0,a=
ddr=3D0x7 -object rng-random,id=3Dobjrng0,filename=3D/dev/random -device vi=
rtio-rng-pci,rng=3Dobjrng0,id=3Drng0,bus=3Dpci.0,addr=3D0x8 -sandbox on,obs=
olete=3Ddeny,elevateprivileges=3Ddeny,spawn=3Ddeny,resourcecontrol=3Ddeny -=
msg timestamp=3Don 2019-02-06 07:10:37.672+0000: Domain id=3D32 is tainted:=
 high-privileges char device redirected to /dev/pts/5 (label charserial0) v=
dev 0x5585456ef6b0 ("virtio-scsi") vq 0x5585456f90a0 (idx 2) inuse 128 vrin=
g.num 128 2019-02-06T13:00:46.942424Z qemu-system-x86_64: Virtqueue size ex=
ceeded I'm open to any tests or suggestions that can move the investigation=
 forward and find the cause of this issue.
Thanks for collecting the data! The fact that both virtio-blk and virtio-sc=
si failed suggests it's not a virtqueue element leak in the virtio-blk or v=
irtio-scsi device emulation code. The hung task error messages from inside =
the guest are a consequence of QEMU hitting the "Virtqueue size exceeded" e=
rror. QEMU refuses to process further requests after the error, causing tas=
ks inside the guest to get stuck on I/O. I don't have a good theory regardi=
ng the root cause. Two ideas: 1. The guest is corrupting the vring or submi=
tting more requests than will fit into the ring. Somewhat unlikely because =
it happens with both Windows and Linux guests. 2. QEMU's virtqueue code is =
buggy, maybe the memory region cache which is used for fast guest RAM acces=
ses. Here is an expanded version of the debug patch which might help identi=
fy which of these scenarios is likely. Sorry, it requires running the guest=
 again! This time let's make QEMU dump core so both QEMU state and guest RA=
M are captured for further debugging. That way it will be possible to extra=
ct more information using gdb without rerunning. Stefan --- diff --git a/hw=
/virtio/virtio.c b/hw/virtio/virtio.c index a1ff647a66..28d89fcbcb 100644 -=
-- a/hw/virtio/virtio.c +++ b/hw/virtio/virtio.c @@ -866,6 +866,7 @@ void *=
virtqueue_pop(VirtQueue *vq, size_t sz) return NULL; } rcu_read_lock(); + u=
int16_t old_shadow_avail_idx =3D vq->shadow_avail_idx; if (virtio_queue_emp=
ty_rcu(vq)) { goto done; } @@ -879,6 +880,12 @@ void *virtqueue_pop(VirtQue=
ue *vq, size_t sz) max =3D vq->vring.num; if (vq->inuse >=3D vq->vring.num)=
 { + fprintf(stderr, "vdev %p (\"%s\")\n", vdev, vdev->name); + fprintf(std=
err, "vq %p (idx %u)\n", vq, (unsigned int)(vq - vdev->vq)); + fprintf(stde=
rr, "inuse %u vring.num %u\n", vq->inuse, vq->vring.num); + fprintf(stderr,=
 "old_shadow_avail_idx %u last_avail_idx %u avail_idx %u\n", old_shadow_ava=
il_idx, vq->last_avail_idx, vq->shadow_avail_idx); + fprintf(stderr, "avail=
 %#" HWADDR_PRIx " avail_idx (cache bypassed) %u\n", vq->vring.avail, virti=
o_lduw_phys(vdev, vq->vring.avail + offsetof(VRingAvail, idx))); + fprintf(=
stderr, "used_idx %u\n", vq->used_idx); + abort(); /* <--- core dump! */ vi=
rtio_error(vdev, "Virtqueue size exceeded"); goto done; }
