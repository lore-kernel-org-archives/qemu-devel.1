Received: from eggs.gnu.org ([209.51.188.92]:47839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1h0oZ8-0004WC-1n
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 09:27:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1h0oZ6-0002Aw-1x
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 09:27:37 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:11300)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1h0oZ4-00025c-3E
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 09:27:35 -0500
Date: Mon, 4 Mar 2019 15:27:27 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <BN6PR2201MB1251959BC139F153BD5760A2C6710@BN6PR2201MB1251.namprd22.prod.outlook.com>
Message-ID: <alpine.BSF.2.21.9999.1903041514430.72040@zero.eik.bme.hu>
References: <cover.1550491301.git.balaton@eik.bme.hu>
	<BN6PR2201MB1251959BC139F153BD5760A2C6710@BN6PR2201MB1251.namprd22.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [PATCH v2 0/3] Misc MIPS fulong2e improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>, Huacai Chen <zltjiangshi@gmail.com>, "philmd@redhat.com" <philmd@redhat.com>

On Mon, 4 Mar 2019, Aleksandar Markovic wrote:
>> From: BALATON Zoltan <balaton@eik.bme.hu>
>> v2 of http://lists.nongnu.org/archive/html/qemu-devel/2019-02/msg02477.html
>> Addressed review comments and removed last patch (sending it
>> separately) to make this series not depend on my ati-vga patch so it
>> can be applied independently.
>
> I plan to add bin file (that you mentioned) used for Fulong 2E tests into our
> tree (in pc-bios directory, with an appropriate comment in pc-bios/README).
> Please let me know if you this I should not do that, of if I should perhaps include
> more files, or different files, etc.

I think you cannot do that because distributing binary also requires to 
provide sources to comply with GPL. Therefore you should include source in 
roms and build binary from that like done for sam460ex for example (see: 
git log roms/u-boot-sam460ex). Problem is you have to figure out which 
sources and config was used to build that binary with the original 
lemote.com site mentioned in a comment in mips_fulong2e.c that used to 
host the source seemingly gone. So you probably will need to find a mirror 
and figure out how to build the pmon binary from that. The comment in 
source mentions that pmon is under BSD licence in which case it may be 
distributed without source but including random binaries may not be the 
best way even if it would be allowed by licence so building a firmware 
from source is the best way if possible.

Regards,
BALATON Zoltan
