Received: from eggs.gnu.org ([2001:4830:134:3::10]:40673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1d1r6j-0002rw-As
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 05:13:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1d1r6f-0006fD-Bf
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 05:13:33 -0400
Received: from chuckie.co.uk ([82.165.15.123]:53582
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1d1r6f-0006eh-3s
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 05:13:29 -0400
References: <5a275226-bce0-4c8f-a708-063245cfe8f2@Spark>
	<583d86e4-dc32-ca67-6157-2b4c1654a758@ilande.co.uk>
	<1492680594151.52017@epfl.ch>
	<9d55b0bb-3d76-4b63-52d3-9f7df1003806@ilande.co.uk>
	<1492787538720.44490@epfl.ch>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <c8006ea5-9a10-9edd-7bfd-04359bfbd235@ilande.co.uk>
Date: Sat, 22 Apr 2017 10:12:51 +0100
MIME-Version: 1.0
In-Reply-To: <1492787538720.44490@epfl.ch>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] Help needed: Sparc 64, kernel panic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ajallooiean Hossein <hossein.ajallooiean@epfl.ch>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On 21/04/17 16:12, Ajallooiean Hossein wrote:

> Thanks for the files and the notes.
> 
> I am attaching my config-host file for you. I'm on x86_64, running Linux 64, Ubuntu 16.04.2 LTS
> 
> so, i can also boot like you do - this worked before as well. btw, if you try to install that to a disk, itll not be able to as youll need to define memory for it.
> 
> The problem is after i install the iso on the qcow2 disk and then try to boot qemu-system-sparc64.
> 
> so here is the steps to reproduce the issue:
> 1- create a qcow2 image : debian-9.0-sparc64-NETINST-1.qcow2
> 2- download debian image: debian-9.0-sparc64-NETINST-1.iso
> 3- install the OS on dIsk
> i use the below command line to do it:
> 
> ./qemu-system-sparc64 -cdrom /home/nihosa/Downloads/debian-9.0-sparc64-NETINST-1.iso -hda /home/nihosa/Downloads/debian-sparc.qcow2 -nographic -boot d -L pc-bios -m 200
> 
> i guess i dont have to define a kernel in the above code???
> 
> 4- installation goes all well.
> 5- i try to run the new disk image: - here i add kernel as if i dont add it ill get the below:
> 
> https://pastebin.com/cFwrX9E9

I've just done a test install with
https://people.debian.org/~glaubitz/debian-cd/2017-03-24/debian-9.0-sparc64-NETINST-1.iso
and I didn't see any errors similar to the ones you mention (although I
did have to blacklist the bochs_drm module upon boot).

The resulting qcow2 image can be found temporarily at
https://www.ilande.co.uk/tmp/qemu/sparc64-kernel/deb90.qcow2.xz and you
can launch it with:

./qemu-system-sparc64 -hda deb90.qcow2 -m 256 -nographic

Username and password are both root.


ATB,

Mark.
