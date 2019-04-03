Received: from eggs.gnu.org ([209.51.188.92]:34101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hBckK-0007RR-Ec
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 06:03:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hBckJ-0007ly-Er
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 06:03:52 -0400
Received: from mail-eopbgr790107.outbound.protection.outlook.com
	([40.107.79.107]:22070
	helo=NAM03-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1hBckI-0007hZ-Rg
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 06:03:51 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Wed, 3 Apr 2019 10:03:45 +0000
Message-ID: <BN6PR2201MB125175A8B01F351B6299E26AC6570@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1554218121-26766-1-git-send-email-mateja.marjanovic@rt-rk.com>
	<1554218121-26766-3-git-send-email-mateja.marjanovic@rt-rk.com>
	<CAL1e-=hG_3htcguRp11NGx3pZP5QY8V6r1kYONYxbcE+NkmQ8Q@mail.gmail.com>,
	<451d1a6d-1b81-7e81-b9ae-2152544ec165@rt-rk.com>
In-Reply-To: <451d1a6d-1b81-7e81-b9ae-2152544ec165@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v5 2/2] target/mips: Optimize
 ILVEV.<B|H|W|D> MSA instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>, Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "richard.henderson@linaro.org" <richard.henderson@linaro.org>, "aurelien@aurel32.net" <aurelien@aurel32.net>, Aleksandar Rikalo <arikalo@wavecomp.com>

> > From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>
> > Subject: Re: [Qemu-devel] [PATCH v5 2/2] target/mips: Optimize ILVEV.<B=
|H|W|D> MSA > > instructions
> >=20
> >=20
> > On 3.4.19. 01:25, Aleksandar Markovic wrote:
> >=20
> > On Apr 2, 2019 5:20 PM, "Mateja Marjanovic" <mateja.marjanovic@rt-rk.co=
m<> > mailto:mateja.marjanovic@rt-rk.com>> wrote:
> > >
> > > From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com<> > mailto:Matej=
a.Marjanovic@rt-rk.com>>
> > >
> > > Optimize set of MSA instructions ILVEV
> > >
> > > ...
> >=20
> > The byte and halfword cases of this patch most likely produce highly un=
optimized code > > for cases:
> >=20
> > wd =3D=3D wt =3D=3D ws
> > wd =3D=3D wt !=3D ws
> > wd !=3D ws =3D=3D wt
> > wd =3D=3D ws !=3D wt
> >=20
> > Please take these cases into account.
> >=20
> > The same for patch 1/2.
>=20
> Maybe, but if I put if statements asking are the registers the same,
> it would affect the performance significantly in all cases. If some
> registers were equal, it would be faster, but if not, just those if state=
ments
> would slow things down.

Mateja,

It won't affect the performance significantly at all. Distinguish between
the code executed in translate time (rarely) and execute time (often).
If statement you mention are executed in translate time.

Thanks,
Aleksandar=
