Received: from eggs.gnu.org ([2001:4830:134:3::10]:46488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hossein.ajallooiean@epfl.ch>) id 1d6DJa-0003Ti-DG
	for qemu-devel@nongnu.org; Thu, 04 May 2017 05:44:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hossein.ajallooiean@epfl.ch>) id 1d6DJX-0003Lk-9s
	for qemu-devel@nongnu.org; Thu, 04 May 2017 05:44:50 -0400
Received: from smtp4.epfl.ch ([2001:620:618:1e0:1:80b2:e059:1]:49799)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <hossein.ajallooiean@epfl.ch>)
	id 1d6DJX-0003Kg-0y
	for qemu-devel@nongnu.org; Thu, 04 May 2017 05:44:47 -0400
From: Ajallooiean Hossein <hossein.ajallooiean@epfl.ch>
Date: Thu, 4 May 2017 09:44:42 +0000
Message-ID: <1493891084552.53481@epfl.ch>
References: <5a275226-bce0-4c8f-a708-063245cfe8f2@Spark>
	<583d86e4-dc32-ca67-6157-2b4c1654a758@ilande.co.uk>
	<1492680594151.52017@epfl.ch>
	<9d55b0bb-3d76-4b63-52d3-9f7df1003806@ilande.co.uk>
	<1492787538720.44490@epfl.ch>
	<c8006ea5-9a10-9edd-7bfd-04359bfbd235@ilande.co.uk>
	<1492904528362.73566@epfl.ch>,
	<77bc50a0-5f3a-4d6e-32af-9db38587cfb0@ilande.co.uk>
In-Reply-To: <77bc50a0-5f3a-4d6e-32af-9db38587cfb0@ilande.co.uk>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] Help needed: Sparc 64, kernel panic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Thanks a lot.=0A=
=0A=
I really appreciate this.=0A=
________________________________________=0A=
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>=0A=
Sent: Monday, May 1, 2017 9:06 PM=0A=
To: Ajallooiean Hossein; qemu-devel@nongnu.org=0A=
Subject: Re: [Qemu-devel] Help needed: Sparc 64, kernel panic=0A=
=0A=
On 23/04/17 00:42, Ajallooiean Hossein wrote:=0A=
=0A=
Hi Ajallooiean,=0A=
=0A=
> Hi Mark,=0A=
>=0A=
> Thanks a lot for this. - it did work!=0A=
>=0A=
> So, now im wondering how did you install the iso on disk?=0A=
>=0A=
> would you mind sharing your command line for the install please? and hack=
s if any=0A=
=0A=
I simply went for something along the lines of:=0A=
=0A=
./qemu-system-sparc64 -hda deb90.qcow2 -cdrom=0A=
debian-9.0-sparc64-NETINST-1.iso -boot d -nographic=0A=
=0A=
i.e. no virtio devices and using the in-built device emulation. I do=0A=
have some alpha patches that add virtio support to OpenBIOS but they are=0A=
definitely not ready for production yet.=0A=
=0A=
> i am now able to install and boot, but my boot hang after this line "[   =
22.559491] [TTM] Initializing pool allocator" - inside user space. - I did =
blacklist bochs_drm for installing as such "-append 'modprobe.blacklist=3Db=
ochs_drm'".=0A=
=0A=
Once I installed the image, I restarted QEMU as normal but this time=0A=
booting from the qcow2 image i.e.=0A=
=0A=
./qemu-system-sparc64 -hda deb90.qcow2 -cdrom=0A=
debian-9.0-sparc64-NETINST-1.iso -nographic=0A=
=0A=
Then at the SILO "boot: " prompt I typed:=0A=
=0A=
Linux modprobe.blacklist=3Dbochs_drm=0A=
=0A=
That got me to a terminal login at which point I created the following=0A=
file as /etc/modprobe.d/bochs_drm.conf:=0A=
=0A=
blacklist bochs_drm=0A=
=0A=
I then did an update-initramfs rebooted as normal, since with the module=0A=
blacklisted there is no need to enter any custom parameters at the SILO=0A=
boot prompt and I can simply hit Enter.=0A=
=0A=
> also, i have a couple of questions if you dont mind responding to them. -=
 ill appreciate this a lot:=0A=
> 1- did you use virtio for your install? i.e. not using the "-cdrom" comma=
nd and blacklisting the pata_cmd64x and also providing your own virtio devi=
ce (/dev/vdb)?=0A=
>     - i used this link for hints on how to install with virtio http://tyo=
m.blogspot.ch/2013/03/debiansparc64-wheezy-under-qemu-how-to.html=0A=
=0A=
No, I just used the slower in-built CDROM emulation.=0A=
=0A=
> 2- i see that you used ext3 for your OS install, isnt that slower than ex=
t4? -again im referencing this: http://tyom.blogspot.ch/2013/03/virtio-perf=
ormance-and-filesystems.html=0A=
=0A=
>From memory the installer insisted that /boot needed to be an ext3=0A=
partition in order to work with SILO which is why I chose it.=0A=
=0A=
> 3- also, im noticing that you didnt define root=3D/dev/sda or root=3D/dev=
/vda1 for when your running qemu. and when im running your image i have to =
do that, otherwise ill get to the initramfs only. is there a trick behind t=
his?=0A=
=0A=
No, it just seems to work for me with the inbuilt CDROM? However if you=0A=
switch to using my image with virtio then you'll have to tweak=0A=
/etc/fstab to use /dev/vda* rather than /dev/sda* devices and rebuild=0A=
the initramfs once again.=0A=
=0A=
> 4- i dont see you defining a kernel and initrd? is there a reason for thi=
s? if i just use your cmd line, ill get this: also, are you extracting the =
kernel and initrd from the image or the iso?=0A=
>=0A=
> OpenBIOS for Sparc64=0A=
> Configuration device id QEMU version 1 machine id 0=0A=
> kernel cmdline=0A=
> CPUs: 1 x SUNW,UltraSPARC-IIi=0A=
> UUID: 00000000-0000-0000-0000-000000000000=0A=
> Welcome to OpenBIOS v1.1 built on Mar 15 2017 19:37=0A=
>   Type 'help' for detailed information=0A=
> Trying disk:a...=0A=
> Not a bootable ELF image=0A=
> Loading a.out image...=0A=
> Loaded 7680 bytes=0A=
> entry point is 0x4000=0A=
> SILO Version 1.4.14=0A=
> boot:=0A=
=0A=
Right - all you need to do here is hit Enter and boot will continue.=0A=
Since I'm not using virtio I'm letting SILO do the work here. Once=0A=
you've blacklisted bochs_drm and rebuilt the initramfs with everything=0A=
setup then you should be able to copy them from the resulting image and=0A=
boot them directly in QEMU using -kernel and -initrd.=0A=
=0A=
=0A=
ATB,=0A=
=0A=
Mark.=0A=
=0A=
