Received: from eggs.gnu.org ([2001:4830:134:3::10]:33620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1digUA-00025h-Gb
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 08:34:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1digU6-00009q-IB
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 08:34:46 -0400
Date: Fri, 18 Aug 2017 14:34:40 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <AM5P194MB0132F81D398EB4EB8EB13E22C8800@AM5P194MB0132.EURP194.PROD.OUTLOOK.COM>
Message-ID: <alpine.BSF.2.21.1708181418010.19483@zero.eik.bme.hu>
References: <cover.1502643878.git.balaton@eik.bme.hu>,
	<0362ffdbfb08b46edef0e2180387078299a9b721.1502643878.git.balaton@eik.bme.hu>
	<AM5P194MB0132F81D398EB4EB8EB13E22C8800@AM5P194MB0132.EURP194.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [Qemu-ppc] [RFC PATCH 09/12] ppc440: Add emulation
 of plb-pcix controller found in some 440 SoCs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: luigi burdo <intermediadc@hotmail.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, Francois Revol <revol@free.fr>, David Gibson <david@gibson.dropbear.id.au>

On Fri, 18 Aug 2017, luigi burdo wrote:
> hi Balaton,

Ciao Luigi,

> i can help with amigaos4 for sam .
> i can test it on P5040 book3e and on G5 quad book3s machine.

Thanks for the offer but unfortunately that would not help because these 
are different CPUs than the 460EX used in the Sam board. I'd definitely 
need logs from Sam460ex or Sam460cr, other logs are not the same and not 
help to find differences between real hardware and emulation.

> note sam for boot amigaos need a special modified version of uboot that 
> is available on acube website it is a firmware update. without modified 
> uboot will be not posdible auto boot amigaos.

I know about this and if you read the cover message (RFC PATCH 00/12) I 
link to a fixed version of that U-Boot firmware (rebuilt from source with 
the mentioned patches) which works with this emulation. (The original one 
from the updater also starts but cannot boot due to some problems which 
are fixed by these patches in my image. This is described in the cover 
message.) With that fixed firmware image it should be possible to at least 
try booting AmigaOS on the emulation and get some logs. I'd be surprised 
if it also worked at this point but I could not try it as it needs an 
appropriate AmigaOS version that runs on the Sam460. It should produce 
some logs though with -serial stdio which may help finding what is 
missing.

> idont know if is possible use standard uboot incuded in qemu for boot 
> amigaos from uboot command line. i can ask help to Enrico Vidale as my 
> FB friend but i dont know if he will be available for this kind of 
> helping.

I think it would not be possible to use the U-Boot in QEMU now as that is 
for e500 CPU but this is not needed either. See above, we are aiming to 
emulate enough of the board that it can run the original firmware which 
should be able to boot these Amiga like OSes and normal Linux images used 
on the Sam460ex. This already works but things fail after or during boot 
currently. This is what needs to be debugged. So we'd need someone who has 
a Sam460 (ex or cr) board and can test on that to get logs from OSes on 
real hardware for comparison.

Regards,
BALATON Zoltan
