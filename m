Received: from eggs.gnu.org ([208.118.235.92]:34295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gcc39-0001dq-6l
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 15:14:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gcc33-0005TV-5s
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 15:14:35 -0500
Received: from mail-eopbgr680122.outbound.protection.outlook.com
	([40.107.68.122]:33088
	helo=NAM04-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gcc32-0005TJ-SG
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 15:14:29 -0500
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Thu, 27 Dec 2018 20:14:26 +0000
Message-ID: <BN6PR2201MB125131304197EB9B009B7D12C6B60@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <20181217200444.14812-1-aleksandar.markovic@rt-rk.com>
	<20181217200444.14812-6-aleksandar.markovic@rt-rk.com>
	<3d59f696-be48-d274-0995-33836eca552a@wavecomp.com>,
	<529312f2be1f48d3b7c1bd819c601db2@EX13D12UEA003.ant.amazon.com>
In-Reply-To: <529312f2be1f48d3b7c1bd819c601db2@EX13D12UEA003.ant.amazon.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 5/6] target/mips: MXU: Add handlers for
 max/min instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Janeczek, Craig" <jancraig@amazon.com>, Stefan Markovic <smarkovic@wavecomp.com>, Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

> From: Janeczek, Craig <jancraig@amazon.com>

> > +        /* return resulting byte to its original position */
> > +        tcg_gen_shri_i32(t0, t0, 24);
>=20
> Should be a shift of 16 here
> tcg_gen_shri_i32(t0, t0, 16);

You are right, for this and the next three hints. Will be fixed in v2.

Thanks,
Aleksandar=
