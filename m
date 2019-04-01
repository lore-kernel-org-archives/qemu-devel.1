Received: from eggs.gnu.org ([209.51.188.92]:60607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hB0xt-0001Wn-Gb
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 13:43:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hB0xs-0000Dy-Ih
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 13:43:21 -0400
Received: from mail-eopbgr700128.outbound.protection.outlook.com
	([40.107.70.128]:31681
	helo=NAM04-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1hB0xs-0000BQ-Aw
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 13:43:20 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Mon, 1 Apr 2019 17:43:16 +0000
Message-ID: <CY4PR2201MB1254B9E68F5103DE4ECBD140C6550@CY4PR2201MB1254.namprd22.prod.outlook.com>
References: <1554129501-27175-1-git-send-email-mateja.marjanovic@rt-rk.com>
In-Reply-To: <1554129501-27175-1-git-send-email-mateja.marjanovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 0/2] target/mips: Integer division by zero
 in MSA insturctions
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
> Subject: [PATCH 0/2] target/mips: Integer division by zero in MSA insturc=
tions
>

The title look incomplete and uninformative: it mentions "the division by z=
ero"
- but what is done in this case? Is this an implementation of that case? Or=
 fix?
Or something else?

The title should clearly and in a condensed form explain what is done in th=
e
series.

> From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>
>
> Integer division by zero in MSA insturctions results in unpredictable
> behaviour, but according to the hardware, it depends on the sign of
> the dividend, or always returns the same value.
>=20

This is a very unclear sentence.

A sentence that says that the series makes the behavior of QEMU
and the reference hardware the same in cases of division and modulus
operations with zero divisor is missing.

> Mateja Marjanovic (2):
>  target/mips: DIV_<U|S>.<B|H|W|D> MSA insturctions fixed
>  target/mips: MOD_<U|S>.<B|H|W|D> MSA insturctions fixed
>
> target/mips/msa_helper.c | 11 +++++++----
> 1 file changed, 7 insertions(+), 4 deletions(-)

Check spelling.

Thanks,
Aleksandar=
