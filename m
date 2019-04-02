Received: from eggs.gnu.org ([209.51.188.92]:39318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hBQMu-0002gK-Rd
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 16:50:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hBQMt-0005bx-V0
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 16:50:52 -0400
Received: from mail-eopbgr820118.outbound.protection.outlook.com
	([40.107.82.118]:41568
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1hBQMt-0005aN-HF
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 16:50:51 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Tue, 2 Apr 2019 20:50:47 +0000
Message-ID: <BN6PR2201MB12517DB6F0F0B64C4A2CD62CC6560@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1554212605-16457-1-git-send-email-mateja.marjanovic@rt-rk.com>,
	<1554212605-16457-6-git-send-email-mateja.marjanovic@rt-rk.com>
In-Reply-To: <1554212605-16457-6-git-send-email-mateja.marjanovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v4 5/5] target/mips: Refactor and fix
 INSERT.<B|H|W|D> instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>, Aleksandar Rikalo <arikalo@wavecomp.com>

> From: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
> Subject: [PATCH v4 5/5] target/mips: Refactor and fix INSERT.<B|H|W|D> in=
structions
>=20
> From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>
>=20
> The old version of the helper for the INSERT.<B|H|W|D> MSA instructions
> has been replaced with four helpers that don't use switch, and change
> the endianness of the given index, when executed on a big endian host.
>=20
> Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
> ---

...


> +    n %=3D 16;

Mateja, could you just clarify what is the purpose of this line (and
similar three lines involving "%=3D")? It looks to me that n is already
limited here to be between 0 and 15, isn't it? (that follows from the
source code of gen_msa_elm().) What made you insert this line,
as it stands?

Thanks,
Aleksandar
