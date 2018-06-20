Received: from eggs.gnu.org ([2001:4830:134:3::10]:33280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fVdPF-0003g8-Mm
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 09:44:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fVdPC-0003XW-LL
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 09:44:17 -0400
Received: from 20.mo5.mail-out.ovh.net ([91.121.55.239]:55142)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fVdPC-0003Wu-Es
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 09:44:14 -0400
Received: from player693.ha.ovh.net (unknown [10.109.108.4])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 8A0411C363B
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 15:44:12 +0200 (CEST)
References: <20180612065716.10587-1-clg@kaod.org>
	<CAFEAcA9KJVw0fuuXY_Ya_F6ELrp-MmgTit4oHU_e0xM+VTdnWA@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <63e6fc9d-3c14-b5b6-4434-bf226a241ab4@kaod.org>
Date: Wed, 20 Jun 2018 15:43:59 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9KJVw0fuuXY_Ya_F6ELrp-MmgTit4oHU_e0xM+VTdnWA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/3] aspeed/smc: small fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alistair Francis <alistair@alistair23.me>, Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>

On 06/20/2018 03:40 PM, Peter Maydell wrote:
> On 12 June 2018 at 07:57, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>> Hello,
>>
>> Here is a short series of cleanups and fixes for issues in the Aspeed
>> SMC controller model discovered when experimenting with the MMIO exec
>> feature and also from tests under a QEMU PowerNV machine.
>>
>> Indeed, the OPAL/skiboot firmware accesses the Aspeed SoC address
>> space using the iLPC->AHB bridge of the SuperIO controller and drives
>> the SPI controller to access the PNOR.
>=20
> Is there anybody familiar with the aspeed SoC who'd like to
> review? The patches don't look particularly wrong, but I'm
> not really in a position to be able to review...

Adding Andrew and Joel as I should have.

Thanks,

C.
