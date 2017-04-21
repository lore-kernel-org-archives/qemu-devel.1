Received: from eggs.gnu.org ([2001:4830:134:3::10]:47410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1d1XIa-00089P-7H
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 08:04:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1d1XIW-000199-67
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 08:04:28 -0400
Received: from chuckie.co.uk ([82.165.15.123]:51035
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1d1XIV-00018k-Ux
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 08:04:24 -0400
References: <5a275226-bce0-4c8f-a708-063245cfe8f2@Spark>
	<583d86e4-dc32-ca67-6157-2b4c1654a758@ilande.co.uk>
	<1492680594151.52017@epfl.ch>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <9d55b0bb-3d76-4b63-52d3-9f7df1003806@ilande.co.uk>
Date: Fri, 21 Apr 2017 13:03:54 +0100
MIME-Version: 1.0
In-Reply-To: <1492680594151.52017@epfl.ch>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
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

On 20/04/17 10:29, Ajallooiean Hossein wrote:

> Thanks for getting back to me so quickly.
> 
> I can boot Sparc64  -- ONLY when using the qemu from package manager. supposedly version 2.5
> 
> but when building it myself (as i have some additions) - im getting this kernel error:
> 
> https://pastebin.com/9XjdrUat
> 
> 
> I am compiling qemu by myself and am using the following cmd to run it:
> 
> 
> /Downloads/qemu-2.9.0-rc4/sparc64-softmmu$ ./qemu-system-sparc64 -M sun4u -m 196 -kernel /home/nihosa/Downloads/kernel4.10.11.sparc64 -hda /home/nihosa/Downloads/debian-9.0-sparc64-NETINST-1.qcow2 -nographic -L pc-bios
> 
> 
> If you have it running, could you please send me your kernel/image for testing?

I've just uploaded my latest kernel build and .config here for you to test:

https://www.ilande.co.uk/tmp/qemu/sparc64-kernel/vmlinux
https://www.ilande.co.uk/tmp/qemu/sparc64-kernel/.config

Can you also confirm your host architecture and the compiler/version you
are using?


ATB,

Mark.
