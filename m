Received: from eggs.gnu.org ([209.51.188.92]:40222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <casasfernando@outlook.com>) id 1gpU0q-0004zC-JO
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 03:17:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <casasfernando@outlook.com>) id 1gpU0o-0005YI-Hd
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 03:17:24 -0500
From: =?iso-8859-1?Q?Fernando_Casas_Sch=F6ssow?= <casasfernando@outlook.com>
Date: Fri, 1 Feb 2019 08:17:18 +0000
Message-ID: <VI1PR0602MB32452A8FD128F63FFAC0CEADA4920@VI1PR0602MB3245.eurprd06.prod.outlook.com>
References: <CABdb7345_Nu_kpsSDGq7OyOSuKmgtyS-DuXTafkGeaCCXzV5LQ@mail.gmail.com>
	<VI1PR1001MB1373B1F3C97D9528166E2305B7C40@VI1PR1001MB1373.EURPRD10.PROD.OUTLOOK.COM>
	<CABdb735e_NjY47LRZ58+zvKGmCRQKAmFo-HhByhsosRzQkOgxA@mail.gmail.com>
	<HE1PR1001MB1371F7874B487B0907C42A7EB7C50@HE1PR1001MB1371.EURPRD10.PROD.OUTLOOK.COM>
	<CABdb7372Pv3hR4S8C0TCV19u9XAKn=y0VmreGuZavhOjqRrypQ@mail.gmail.com>
	<VI1PR1001MB13731144A5E55914A9E414A5B7DA0@VI1PR1001MB1373.EURPRD10.PROD.OUTLOOK.COM>
	<CABdb7377U9SpZno1kU6+TuARUmqfMMcC2uuwXTHqSZpLsqB7Gw@mail.gmail.com>
	<1498199343.2815.0@smtp-mail.outlook.com>
	<VI1PR1001MB13731EF256C1E7380E1D657AB7D90@VI1PR1001MB1373.EURPRD10.PROD.OUTLOOK.COM>
	<VI1PR0602MB324559765BFE372F75D52E57A4910@VI1PR0602MB3245.eurprd06.prod.outlook.com>
	<20190201054849.GH23131@stefanha-x1.localdomain>
In-Reply-To: <20190201054849.GH23131@stefanha-x1.localdomain>
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
Cc: =?iso-8859-1?Q?Fernando_Casas_Sch=F6ssow?= <casasfernando@hotmail.com>, qemu-devel <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>

Hi Stefan,

Thanks for looking into this. Please find the requested details below.
If you need any further details (like the host storage details) just let me=
 know.

Host details:
CPU: Intel(R) Xeon(R) CPU E3-1230 V2
Memory: 32GB (ECC)
OS: Alpine 3.9
Kernel version: 4.19.18-0-vanilla
Qemu version: 3.1
Libvirt version: 4.10
Networking: openvswitch-2.10.1


Windows guest:
OS: Windows Server 2012 R2 64bit (up to date)
Virtio drivers version: 141 (stable)
Command line: /usr/bin/qemu-system-x86_64 -name guest=3DDCHOMENET02,debug-t=
hreads=3Don -S -object secret,id=3DmasterKey0,format=3Draw,file=3D/var/lib/=
libvirt/qemu/domain-17-DCHOMENET02/master-key.aes -machine pc-i440fx-3.1,ac=
cel=3Dkvm,usb=3Doff,dump-guest-core=3Doff -cpu IvyBridge,ss=3Don,vmx=3Don,p=
cid=3Don,hypervisor=3Don,arat=3Don,tsc_adjust=3Don,umip=3Don,xsaveopt=3Don,=
hv_time,hv_relaxed,hv_vapic,hv_spinlocks=3D0x1fff -drive file=3D/usr/share/=
edk2.git/ovmf-x64/OVMF_CODE-pure-efi.fd,if=3Dpflash,format=3Draw,unit=3D0,r=
eadonly=3Don -drive file=3D/var/lib/libvirt/qemu/nvram/DCHOMENET02_VARS.fd,=
if=3Dpflash,format=3Draw,unit=3D1 -m 2048 -realtime mlock=3Doff -smp 2,sock=
ets=3D2,cores=3D1,threads=3D1 -uuid 84afccf7-f164-4d0d-b9c9-c92ffab00848 -n=
o-user-config -nodefaults -chardev socket,id=3Dcharmonitor,fd=3D42,server,n=
owait -mon chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol -rtc base=3Dlo=
caltime,driftfix=3Dslew -global kvm-pit.lost_tick_policy=3Ddelay -no-hpet -=
no-shutdown -global PIIX4_PM.disable_s3=3D1 -global PIIX4_PM.disable_s4=3D1=
 -boot strict=3Don -device ich9-usb-ehci1,id=3Dusb,bus=3Dpci.0,addr=3D0x4.0=
x7 -device ich9-usb-uhci1,masterbus=3Dusb.0,firstport=3D0,bus=3Dpci.0,multi=
function=3Don,addr=3D0x4 -device ich9-usb-uhci2,masterbus=3Dusb.0,firstport=
=3D2,bus=3Dpci.0,addr=3D0x4.0x1 -device ich9-usb-uhci3,masterbus=3Dusb.0,fi=
rstport=3D4,bus=3Dpci.0,addr=3D0x4.0x2 -device virtio-scsi-pci,id=3Dscsi0,b=
us=3Dpci.0,addr=3D0x5 -device virtio-serial-pci,id=3Dvirtio-serial0,bus=3Dp=
ci.0,addr=3D0x6 -drive file=3D/storage/storage-ssd-vms/virtual_machines_ssd=
/dchomenet02.qcow2,format=3Dqcow2,if=3Dnone,id=3Ddrive-scsi0-0-0-0,cache=3D=
none,aio=3Dthreads -device scsi-hd,bus=3Dscsi0.0,channel=3D0,scsi-id=3D0,lu=
n=3D0,drive=3Ddrive-scsi0-0-0-0,id=3Dscsi0-0-0-0,bootindex=3D1,write-cache=
=3Don -drive file=3D/storage/storage-hdd-vms/virtual_machines_hdd/dchomenet=
02_storage.qcow2,format=3Dqcow2,if=3Dnone,id=3Ddrive-scsi0-0-0-1,cache=3Dno=
ne,aio=3Dthreads -device scsi-hd,bus=3Dscsi0.0,channel=3D0,scsi-id=3D0,lun=
=3D1,drive=3Ddrive-scsi0-0-0-1,id=3Dscsi0-0-0-1,write-cache=3Don -netdev ta=
p,fd=3D44,id=3Dhostnet0,vhost=3Don,vhostfd=3D45 -device virtio-net-pci,netd=
ev=3Dhostnet0,id=3Dnet0,mac=3D52:54:00:91:aa:a1,bus=3Dpci.0,addr=3D0x3 -cha=
rdev pty,id=3Dcharserial0 -device isa-serial,chardev=3Dcharserial0,id=3Dser=
ial0 -chardev spicevmc,id=3Dcharchannel0,name=3Dvdagent -device virtserialp=
ort,bus=3Dvirtio-serial0.0,nr=3D1,chardev=3Dcharchannel0,id=3Dchannel0,name=
=3Dcom.redhat.spice.0 -chardev socket,id=3Dcharchannel1,fd=3D47,server,nowa=
it -device virtserialport,bus=3Dvirtio-serial0.0,nr=3D2,chardev=3Dcharchann=
el1,id=3Dchannel1,name=3Dorg.qemu.guest_agent.0 -device usb-tablet,id=3Dinp=
ut0,bus=3Dusb.0,port=3D1 -spice port=3D5905,addr=3D127.0.0.1,disable-ticket=
ing,seamless-migration=3Don -device qxl-vga,id=3Dvideo0,ram_size=3D67108864=
,vram_size=3D67108864,vram64_size_mb=3D0,vgamem_mb=3D16,max_outputs=3D1,bus=
=3Dpci.0,addr=3D0x2 -chardev spicevmc,id=3Dcharredir0,name=3Dusbredir -devi=
ce usb-redir,chardev=3Dcharredir0,id=3Dredir0,bus=3Dusb.0,port=3D2 -chardev=
 spicevmc,id=3Dcharredir1,name=3Dusbredir -device usb-redir,chardev=3Dcharr=
edir1,id=3Dredir1,bus=3Dusb.0,port=3D3 -device virtio-balloon-pci,id=3Dball=
oon0,bus=3Dpci.0,addr=3D0x8 -sandbox on,obsolete=3Ddeny,elevateprivileges=
=3Ddeny,spawn=3Ddeny,resourcecontrol=3Ddeny -msg timestamp=3Don

Linux guest:
OS: CentOS 7.6 64bit (up to date)
Kernel version: 3.10.0-957.1.3.el7.x86_64
Command line: /usr/bin/qemu-system-x86_64 -name guest=3DDOCKER01,debug-thre=
ads=3Don -S -object secret,id=3DmasterKey0,format=3Draw,file=3D/var/lib/lib=
virt/qemu/domain-21-DOCKER01/master-key.aes -machine pc-i440fx-3.1,accel=3D=
kvm,usb=3Doff,dump-guest-core=3Doff -cpu IvyBridge,ss=3Don,vmx=3Don,pcid=3D=
on,hypervisor=3Don,arat=3Don,tsc_adjust=3Don,umip=3Don,xsaveopt=3Don -drive=
 file=3D/usr/share/edk2.git/ovmf-x64/OVMF_CODE-pure-efi.fd,if=3Dpflash,form=
at=3Draw,unit=3D0,readonly=3Don -drive file=3D/var/lib/libvirt/qemu/nvram/D=
OCKER01_VARS.fd,if=3Dpflash,format=3Draw,unit=3D1 -m 2048 -realtime mlock=
=3Doff -smp 2,sockets=3D2,cores=3D1,threads=3D1 -uuid 4705b146-3b14-4c20-92=
3c-42105d47e7fc -no-user-config -nodefaults -chardev socket,id=3Dcharmonito=
r,fd=3D44,server,nowait -mon chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcont=
rol -rtc base=3Dutc,driftfix=3Dslew -global kvm-pit.lost_tick_policy=3Ddela=
y -no-hpet -no-shutdown -global PIIX4_PM.disable_s3=3D1 -global PIIX4_PM.di=
sable_s4=3D1 -boot strict=3Don -device ich9-usb-ehci1,id=3Dusb,bus=3Dpci.0,=
addr=3D0x4.0x7 -device ich9-usb-uhci1,masterbus=3Dusb.0,firstport=3D0,bus=
=3Dpci.0,multifunction=3Don,addr=3D0x4 -device ich9-usb-uhci2,masterbus=3Du=
sb.0,firstport=3D2,bus=3Dpci.0,addr=3D0x4.0x1 -device ich9-usb-uhci3,master=
bus=3Dusb.0,firstport=3D4,bus=3Dpci.0,addr=3D0x4.0x2 -device virtio-scsi-pc=
i,id=3Dscsi0,bus=3Dpci.0,addr=3D0x6 -device virtio-serial-pci,id=3Dvirtio-s=
erial0,bus=3Dpci.0,addr=3D0x5 -drive file=3D/storage/storage-ssd-vms/virtua=
l_machines_ssd/docker01.qcow2,format=3Dqcow2,if=3Dnone,id=3Ddrive-scsi0-0-0=
-0,cache=3Dnone,aio=3Dthreads -device scsi-hd,bus=3Dscsi0.0,channel=3D0,scs=
i-id=3D0,lun=3D0,drive=3Ddrive-scsi0-0-0-0,id=3Dscsi0-0-0-0,bootindex=3D1,w=
rite-cache=3Don -netdev tap,fd=3D46,id=3Dhostnet0,vhost=3Don,vhostfd=3D48 -=
device virtio-net-pci,netdev=3Dhostnet0,id=3Dnet0,mac=3D52:54:00:1c:af:ce,b=
us=3Dpci.0,addr=3D0x3 -chardev pty,id=3Dcharserial0 -device isa-serial,char=
dev=3Dcharserial0,id=3Dserial0 -chardev socket,id=3Dcharchannel0,fd=3D49,se=
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

Thanks.
Kind regards,

Fernando

On vie, feb 1, 2019 at 6:48 AM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
On Thu, Jan 31, 2019 at 11:32:32AM +0000, Fernando Casas Sch=F6ssow wrote:
Sorry for resurrecting this thread after so long but I just upgraded the ho=
st to Qemu 3.1 and libvirt 4.10 and I'm still facing this problem. At the m=
oment I cannot use virtio disks (virtio-blk nor virtio-scsi) with my guests=
 in order to avoid this issue so as a workaround I'm using SATA emulated st=
orage which is not ideal but is perfectly stable. Do you have any suggestio=
ns on how can I progress troubleshooting? Qemu is not crashing so I don't h=
ave any dumps that can be analyzed. The guest is just "stuck" and all I can=
 do is destroy it and start it again. It's really frustrating that after al=
l this time I couldn't find the cause for this issue so any ideas are welco=
me.
Hi Fernando, Please post your QEMU command-line (ps aux | grep qemu) and th=
e details of the guest operating system and version. Stefan
