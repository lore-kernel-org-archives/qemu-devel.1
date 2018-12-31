Received: from eggs.gnu.org ([208.118.235.92]:50610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gdykf-0000dK-EC
	for qemu-devel@nongnu.org; Mon, 31 Dec 2018 09:41:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gdykY-0005pL-L0
	for qemu-devel@nongnu.org; Mon, 31 Dec 2018 09:41:07 -0500
Received: from mail-eopbgr750125.outbound.protection.outlook.com
	([40.107.75.125]:23787
	helo=NAM02-BL2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gdykU-0005cl-P1
	for qemu-devel@nongnu.org; Mon, 31 Dec 2018 09:40:59 -0500
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Mon, 31 Dec 2018 14:40:44 +0000
Message-ID: <BN6PR2201MB1251EB3052B10C95BE09D99DC6B20@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <20181217200444.14812-1-aleksandar.markovic@rt-rk.com>,
	<BN6PR2201MB1251D10E47C4B6103334BF3CC6B60@BN6PR2201MB1251.namprd22.prod.outlook.com>
In-Reply-To: <BN6PR2201MB1251D10E47C4B6103334BF3CC6B60@BN6PR2201MB1251.namprd22.prod.outlook.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 0/6] target/mips: Amend MXU support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "jancraig@amazon.com" <jancraig@amazon.com>, Stefan Markovic <smarkovic@wavecomp.com>

> From: Aleksandar Markovic
> Subject: Re: [PATCH 0/6] target/mips: Amend MXU support
>=20
> > From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
> > Subject: [PATCH 0/6] target/mips: Amend MXU support
> >
> > From: Aleksandar Markovic <amarkovic@wavecomp.com>
> >
> > Various updates to MXU ASE support.
> >
> > Aleksandar Markovic (6):
> >  target/mips: MXU: Add missing opcodes/decoding for LX* instructions
> >  target/mips: MXU: Add generic naming for optn2 constants
> >  target/mips: MXU: Improve textual description
> >  target/mips: MXU: Add handlers for logic instructions
> >  target/mips: MXU: Add handlers for max/min instructions
> >  target/mips: MXU: Add handlers for an align instruction
>=20
> If there is no objection, to get things going a little, I am going to int=
egrate patches 1, 2, and 3 into next MIPS > pull request (scheduled shortly=
), while it looks other patches need more time for review.
>=20
> (patch 1 is about "pool 17", issues around "pool 16" will be covered in a=
 separate patch in v2)
>=20

I was told that comparing test runs on hardware and emulation
didn't point to any issue other than those mentioned in previous
responses (by Craig). I may try to integrate remaining three
patches too (with fixes for discovered issues).

> Thanks to everyone,
> Aleksandar
