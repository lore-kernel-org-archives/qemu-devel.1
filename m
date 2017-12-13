Received: from eggs.gnu.org ([2001:4830:134:3::10]:37180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1eP0Od-00074z-1t
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 01:19:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1eP0OZ-0007vM-Sd
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 01:19:58 -0500
Received: from iserv.reactos.org ([2a01:4f8:221:4c5::3]:53351)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hpoussin@reactos.org>)
	id 1eP0OZ-0007p6-2X
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 01:19:55 -0500
References: <20171026064635.7179-1-aik@ozlabs.ru>
	<13277057-669f-cd77-95f1-f0e54f7ae222@redhat.com>
	<7e694888-43ce-6653-92a0-c0b4c235d4ca@ozlabs.ru>
	<e6a81bdc-a961-d55f-85c4-55149c878988@redhat.com>
From: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Message-ID: <df85e8f4-23ae-6404-26b8-b45cc7896bbc@reactos.org>
Date: Wed, 13 Dec 2017 07:19:43 +0100
MIME-Version: 1.0
In-Reply-To: <e6a81bdc-a961-d55f-85c4-55149c878988@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH qemu] fdc: Exit if ISA controller does not
 support DMA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

Le 08/12/2017 à 22:29, John Snow a écrit :
[...]
> 
> It looks like Herve was working on decoupling floppies from i8257, but
> perhaps didn't get all the way through -- I'm not actually clear on what
> work remains to be done here, maybe he can chime in if he's still
> interested in the project?
> 

Indeed, I worked on decoupling floppies (and other ISA devices) from i8257, for three reasons:
1) having a working floppy on MIPS Magnum machine. fdc is PC-compatible, but DMA controller is not i8257-compatible.
2) reimplement another ISA bus with a somewhat i8257-compatible DMA
3) for fun, support multiple ISA buses on a same machine but on different PCI bridges.

I failed on point 1), mostly due to lack of documentation.
I succeeded on point 2), by having locally some patches for a ISAPNP bus, where IO/IRQ/DMA addresses of ISA devices can change dynamically, and devices can be discovered by operating system.
About point 3, most of the patches are ready, but some details are still to be fixed.

Regards,

Hervé
