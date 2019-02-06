Received: from eggs.gnu.org ([209.51.188.92]:46891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <casasfernando@outlook.com>) id 1grQMJ-0005gR-Sl
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 11:47:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <casasfernando@outlook.com>) id 1grQMG-0007EG-0T
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 11:47:35 -0500
From: =?iso-8859-1?Q?Fernando_Casas_Sch=F6ssow?= <casasfernando@outlook.com>
Date: Wed, 6 Feb 2019 16:47:19 +0000
Message-ID: <VI1PR0602MB3245FD0A939EC3E28CA0F740A46F0@VI1PR0602MB3245.eurprd06.prod.outlook.com>
References: <CABdb735e_NjY47LRZ58+zvKGmCRQKAmFo-HhByhsosRzQkOgxA@mail.gmail.com>
	<HE1PR1001MB1371F7874B487B0907C42A7EB7C50@HE1PR1001MB1371.EURPRD10.PROD.OUTLOOK.COM>
	<CABdb7372Pv3hR4S8C0TCV19u9XAKn=y0VmreGuZavhOjqRrypQ@mail.gmail.com>
	<VI1PR1001MB13731144A5E55914A9E414A5B7DA0@VI1PR1001MB1373.EURPRD10.PROD.OUTLOOK.COM>
	<CABdb7377U9SpZno1kU6+TuARUmqfMMcC2uuwXTHqSZpLsqB7Gw@mail.gmail.com>
	<1498199343.2815.0@smtp-mail.outlook.com>
	<VI1PR1001MB13731EF256C1E7380E1D657AB7D90@VI1PR1001MB1373.EURPRD10.PROD.OUTLOOK.COM>
	<VI1PR0602MB324559765BFE372F75D52E57A4910@VI1PR0602MB3245.eurprd06.prod.outlook.com>
	<20190201054849.GH23131@stefanha-x1.localdomain>
	<VI1PR0602MB32452A8FD128F63FFAC0CEADA4920@VI1PR0602MB3245.eurprd06.prod.outlook.com>
	<20190204060636.GF29758@stefanha-x1.localdomain>
	<AM5PR0602MB32368CB5ADDEC05F42D8BC8FA46D0@AM5PR0602MB3236.eurprd06.prod.outlook.com>
	<AM5PR0602MB32368CB5ADDEC05F42D8BC8FA46D0@AM5PR0602MB3236.eurprd06.prod.outlo>
In-Reply-To: <VI1PR0602MB3245032D51A5DF45AF6E1952A46F0@VI1PR0602MB3245.eurprd06.prod.outlo
	ok.com>
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

I could also repro the same with virtio-scsi on the same guest a couple of =
hours later:

2019-02-06 07:10:37.672+0000: starting up libvirt version: 4.10.0, qemu ver=
sion: 3.1.0, kernel: 4.19.18-0-vanilla, hostname: vmsvr01.homenet.local
LC_ALL=3DC PATH=3D/bin:/sbin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/bin:/usr/sb=
in:/usr/local/bin:/usr/local/sbin HOME=3D/root USER=3Droot QEMU_AUDIO_DRV=
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
2019-02-06 07:10:37.672+0000: Domain id=3D32 is tainted: high-privileges
char device redirected to /dev/pts/5 (label charserial0)
vdev 0x5585456ef6b0 ("virtio-scsi")
vq 0x5585456f90a0 (idx 2)
inuse 128 vring.num 128
2019-02-06T13:00:46.942424Z qemu-system-x86_64: Virtqueue size exceeded


I'm open to any tests or suggestions that can move the investigation forwar=
d and find the cause of this issue.
Thanks.

On mi=E9, feb 6, 2019 at 8:15 AM, Fernando Casas Sch=F6ssow <casasfernando@=
outlook.com> wrote:
I can now confirm that the same happens with virtio-blk and virtio-scsi.
Please find below the qemu log enhanced with the new information added by t=
he patch provided by Stefan:

vdev 0x55d22b8e10f0 ("virtio-blk")
vq 0x55d22b8ebe40 (idx 0)
inuse 128 vring.num 128
2019-02-06T00:40:41.742552Z qemu-system-x86_64: Virtqueue size exceeded

I just changed the disk back to virtio-scsi so I can repro this again with =
the patched qemu and report back.

Thanks.

On lun, feb 4, 2019 at 8:24 AM, Fernando Casas Sch=F6ssow <casasfernando@ou=
tlook.com> wrote:

I can test again with qemu 3.1 but with previous versions yes, it was happe=
ning the same with both virtio-blk and virtio-scsi.
For 3.1 I can confirm it happens for virtio-scsi (already tested it) and I =
can test with virtio-blk again if that will add value to the investigation.
Also I'm attaching a guest console screenshot showing the errors displayed =
by the guest when it goes unresponsive in case it can help.

Thanks for the patch. I will build the custom qemu binary and reproduce the=
 issue. This may take a couple of days since I cannot reproduce it at will.=
 Sometimes it takes 12 hours sometimes 2 days until it happens.
Hopefully the code below will add more light on to this problem.

Thanks,

Fernando

On lun, feb 4, 2019 at 7:06 AM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
Are you sure this happens with both virtio-blk and virtio-scsi? The followi=
ng patch adds more debug output. You can build as follows: $ git clone http=
s://git.qemu.org/git/qemu.git $ cd qemu $ patch apply -p1 ...paste the patc=
h here... ^D # For info on build dependencies see https://wiki.qemu.org/Hos=
ts/Linux $ ./configure --target-list=3Dx86_64-softmmu $ make -j4 You can co=
nfigure a libvirt domain to use your custom QEMU binary by changing the <de=
vices><emulator> tag to the qemu/x86_64-softmmu/qemu-system-x86_64 path. --=
- diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c index 22bd1ac34e..aa=
44bffa1f 100644 --- a/hw/virtio/virtio.c +++ b/hw/virtio/virtio.c @@ -879,6=
 +879,9 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz) max =3D vq->vring.=
num; if (vq->inuse >=3D vq->vring.num) { + fprintf(stderr, "vdev %p (\"%s\"=
)\n", vdev, vdev->name); + fprintf(stderr, "vq %p (idx %u)\n", vq, (unsigne=
d int)(vq - vdev->vq)); + fprintf(stderr, "inuse %u vring.num %u\n", vq->in=
use, vq->vring.num); virtio_error(vdev, "Virtqueue size exceeded"); goto do=
ne; }
