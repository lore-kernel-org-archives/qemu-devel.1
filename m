Received: from eggs.gnu.org ([209.51.188.92]:41732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1h1dAF-0004SD-Di
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 15:29:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1h1dAE-0006bB-NS
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 15:29:19 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:51350)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1h1dAE-0006aJ-GE
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 15:29:18 -0500
Date: Wed, 6 Mar 2019 21:29:15 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <201903061839.16488.randrianasulu@gmail.com>
Message-ID: <alpine.BSF.2.21.9999.1903062122150.44072@zero.eik.bme.hu>
References: <201903061839.16488.randrianasulu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] PMON2000 compilation and kernel question
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Randrianasulu <randrianasulu@gmail.com>
Cc: qemu-devel@nongnu.org

On Wed, 6 Mar 2019, Andrew Randrianasulu wrote:
> It worked fine with  binary pmon_2e.bin, and not for my self-compiled version.
> Still, I'm not sure about what kind of config they used, and at that commit.
> In this sense newer pmon is more useful because it prints git commit and  build date.

Probably the binary is a release version maybe built from a stable branch 
not from the master git. But if a working firmware can be compiled from 
the git sources available that's probably good enough. To find out if the 
compiled firmware does something different with the GPU chip you can 
enable ati-vga traces with -trace enable="ati*" that should print register 
accesses (there's also a define for even more debug messages in 
ati_int.h). You could compare those to see if the binary does something 
else with the GPU.

> Provided binary talks about pmon 1.1.2 (?) in top left corner.
> I think one of my earlier self-compiled binaries behaved like this one
> (printing a lot of pci info), but yes, something still not right  at my end
> because for example DIMM size not detected correctly in my version.

What do you mean by DIMM size not detected? RAM in fulong2e is fixed at 
256 MB as I wrote before so unless you remove that from mips_fulong2e.c 
you can't have different RAM size that. With the fixed value removed I got 
pmon print in env mem=256, highmem=the_rest but don't know where to map 
highmem so it probably won't work and the highmem area just overlaps io 
space so Linux will likely crash with this.

Regards,
BALATON Zoltan
