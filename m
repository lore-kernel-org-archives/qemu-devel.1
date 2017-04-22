Received: from eggs.gnu.org ([2001:4830:134:3::10]:41726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hossein.ajallooiean@epfl.ch>) id 1d255P-0005kV-2L
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 20:09:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hossein.ajallooiean@epfl.ch>) id 1d255K-0007yT-3y
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 20:09:07 -0400
Received: from smtp5.epfl.ch ([2001:620:618:1e0:1:80b2:e034:1]:40480)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <hossein.ajallooiean@epfl.ch>)
	id 1d255J-0007w8-QF
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 20:09:02 -0400
From: Ajallooiean Hossein <hossein.ajallooiean@epfl.ch>
Date: Sat, 22 Apr 2017 23:42:08 +0000
Message-ID: <1492904528362.73566@epfl.ch>
References: <5a275226-bce0-4c8f-a708-063245cfe8f2@Spark>
	<583d86e4-dc32-ca67-6157-2b4c1654a758@ilande.co.uk>
	<1492680594151.52017@epfl.ch>
	<9d55b0bb-3d76-4b63-52d3-9f7df1003806@ilande.co.uk>
	<1492787538720.44490@epfl.ch>,
	<c8006ea5-9a10-9edd-7bfd-04359bfbd235@ilande.co.uk>
In-Reply-To: <c8006ea5-9a10-9edd-7bfd-04359bfbd235@ilande.co.uk>
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
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Hi Mark,=0A=
=0A=
Thanks a lot for this. - it did work! =0A=
=0A=
So, now im wondering how did you install the iso on disk?=0A=
=0A=
would you mind sharing your command line for the install please? and hacks =
if any=0A=
=0A=
i am now able to install and boot, but my boot hang after this line "[   22=
.559491] [TTM] Initializing pool allocator" - inside user space. - I did bl=
acklist bochs_drm for installing as such "-append 'modprobe.blacklist=3Dboc=
hs_drm'".=0A=
=0A=
also, i have a couple of questions if you dont mind responding to them. - i=
ll appreciate this a lot:=0A=
1- did you use virtio for your install? i.e. not using the "-cdrom" command=
 and blacklisting the pata_cmd64x and also providing your own virtio device=
 (/dev/vdb)?=0A=
    - i used this link for hints on how to install with virtio http://tyom.=
blogspot.ch/2013/03/debiansparc64-wheezy-under-qemu-how-to.html=0A=
=0A=
2- i see that you used ext3 for your OS install, isnt that slower than ext4=
? -again im referencing this: http://tyom.blogspot.ch/2013/03/virtio-perfor=
mance-and-filesystems.html=0A=
=0A=
3- also, im noticing that you didnt define root=3D/dev/sda or root=3D/dev/v=
da1 for when your running qemu. and when im running your image i have to do=
 that, otherwise ill get to the initramfs only. is there a trick behind thi=
s?=0A=
=0A=
4- i dont see you defining a kernel and initrd? is there a reason for this?=
 if i just use your cmd line, ill get this: also, are you extracting the ke=
rnel and initrd from the image or the iso?=0A=
=0A=
OpenBIOS for Sparc64=0A=
Configuration device id QEMU version 1 machine id 0=0A=
kernel cmdline =0A=
CPUs: 1 x SUNW,UltraSPARC-IIi=0A=
UUID: 00000000-0000-0000-0000-000000000000=0A=
Welcome to OpenBIOS v1.1 built on Mar 15 2017 19:37=0A=
  Type 'help' for detailed information=0A=
Trying disk:a...=0A=
Not a bootable ELF image=0A=
Loading a.out image...=0A=
Loaded 7680 bytes=0A=
entry point is 0x4000=0A=
SILO Version 1.4.14=0A=
boot: =0A=
=0A=
Thanks a lot in advance for your help.=0A=
=0A=
Cheers=0A=
Hoss=0A=
________________________________________=0A=
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>=0A=
Sent: Saturday, April 22, 2017 11:12 AM=0A=
To: Ajallooiean Hossein; qemu-devel@nongnu.org=0A=
Subject: Re: [Qemu-devel] Help needed: Sparc 64, kernel panic=0A=
=0A=
On 21/04/17 16:12, Ajallooiean Hossein wrote:=0A=
=0A=
> Thanks for the files and the notes.=0A=
>=0A=
> I am attaching my config-host file for you. I'm on x86_64, running Linux =
64, Ubuntu 16.04.2 LTS=0A=
>=0A=
> so, i can also boot like you do - this worked before as well. btw, if you=
 try to install that to a disk, itll not be able to as youll need to define=
 memory for it.=0A=
>=0A=
> The problem is after i install the iso on the qcow2 disk and then try to =
boot qemu-system-sparc64.=0A=
>=0A=
> so here is the steps to reproduce the issue:=0A=
> 1- create a qcow2 image : debian-9.0-sparc64-NETINST-1.qcow2=0A=
> 2- download debian image: debian-9.0-sparc64-NETINST-1.iso=0A=
> 3- install the OS on dIsk=0A=
> i use the below command line to do it:=0A=
>=0A=
> ./qemu-system-sparc64 -cdrom /home/nihosa/Downloads/debian-9.0-sparc64-NE=
TINST-1.iso -hda /home/nihosa/Downloads/debian-sparc.qcow2 -nographic -boot=
 d -L pc-bios -m 200=0A=
>=0A=
> i guess i dont have to define a kernel in the above code???=0A=
>=0A=
> 4- installation goes all well.=0A=
> 5- i try to run the new disk image: - here i add kernel as if i dont add =
it ill get the below:=0A=
>=0A=
> https://pastebin.com/cFwrX9E9=0A=
=0A=
I've just done a test install with=0A=
https://people.debian.org/~glaubitz/debian-cd/2017-03-24/debian-9.0-sparc64=
-NETINST-1.iso=0A=
and I didn't see any errors similar to the ones you mention (although I=0A=
did have to blacklist the bochs_drm module upon boot).=0A=
=0A=
The resulting qcow2 image can be found temporarily at=0A=
https://www.ilande.co.uk/tmp/qemu/sparc64-kernel/deb90.qcow2.xz and you=0A=
can launch it with:=0A=
=0A=
./qemu-system-sparc64 -hda deb90.qcow2 -m 256 -nographic=0A=
=0A=
Username and password are both root.=0A=
=0A=
=0A=
ATB,=0A=
=0A=
Mark.=0A=
=0A=
