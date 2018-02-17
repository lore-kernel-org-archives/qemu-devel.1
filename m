Received: from eggs.gnu.org ([2001:4830:134:3::10]:46247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1enCDZ-0003Ie-AU
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 18:48:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1enCDW-0005ZQ-8W
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 18:48:33 -0500
Date: Sun, 18 Feb 2018 00:48:27 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <alpine.BSF.2.21.1802161143460.98686@zero.eik.bme.hu>
Message-ID: <alpine.BSF.2.21.1802180044120.3331@zero.eik.bme.hu>
References: <cover.1518730026.git.balaton@eik.bme.hu>
	<0d6dd5c0e5279896b29b140b198f2a9f6b2d87ba.1518730026.git.balaton@eik.bme.hu>
	<20180216031014.GD2074@umbus.fritz.box>
	<alpine.BSF.2.21.1802161143460.98686@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2 3/3] ppc: Add aCube Sam460ex
 board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Francois Revol <revol@free.fr>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Fri, 16 Feb 2018, BALATON Zoltan wrote:
> On Fri, 16 Feb 2018, David Gibson wrote:
>> On Thu, Feb 15, 2018 at 10:27:06PM +0100, BALATON Zoltan wrote:
>>> Add emulation of aCube Sam460ex board based on AMCC 460EX embedded So=
C.
>>> This is not a complete implementation yet with a lot of components
>>> still missing but enough for the U-Boot firmware to start and to boot
>>> a Linux kernel or AROS.
>>>=20
>>> Signed-off-by: Fran=E7ois Revol <revol@free.fr>
>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>> ---
>>>=20
>>> v2:
>>> - Rebased to latest changes on master
>>> - Replaced printfs with error_report
>>=20
>> This has a conflict in hw/ppc/Makefile.objs.  Looks like it was based
>> on some other patch that added ppc440_pcix.o.  That's not there
>> upstream.
>
> That's patch 2/3 of this series. Have you missed that?

I've sent a v3 for this patch (3/3) now:

http://lists.nongnu.org/archive/html/qemu-devel/2018-02/msg04774.html

which includes the dts and dtb as well (I'll send a separate patch for th=
e=20
firmware after we agree on how to best do that). The missing 2/3 of the v=
2=20
series is still valid and needed before this new patch:

http://lists.nongnu.org/archive/html/qemu-devel/2018-02/msg04259.html

The v3 is only replacing 3/3 of the previous series. Hope this is not too=
=20
confusing.

Regards,
BALATON Zoltan
