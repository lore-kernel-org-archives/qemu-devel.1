Received: from eggs.gnu.org ([209.51.188.92]:33991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hB186-0005fc-24
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 13:53:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hB184-0007gt-C3
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 13:53:53 -0400
Received: from mail-eopbgr720101.outbound.protection.outlook.com
	([40.107.72.101]:53593
	helo=NAM05-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1hB183-0007gO-VK
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 13:53:52 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Mon, 1 Apr 2019 17:53:48 +0000
Message-ID: <CY4PR2201MB125406EDB6C28B4F84C6A5F7C6550@CY4PR2201MB1254.namprd22.prod.outlook.com>
References: <1553845000-6537-1-git-send-email-mateja.marjanovic@rt-rk.com>
In-Reply-To: <1553845000-6537-1-git-send-email-mateja.marjanovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 0/5] Add support for MSA instructions on
 a big endian host
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
> Subject: [PATCH v3 0/5] Add support for MSA instructions on a big endian =
host

"Add" -> "Fix"

Big endian host support should have worked from the moment MSA
support is added to QEMU.

>
> From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>
>=20
> Add support for MSA instructions while executing QEMU on a
> machine that uses big endian MIPS CPU. Also change the
> implementation of helpers for MSA instructions
> ST.<B|H|W|D>, LD.<B|H|W|D>, INSERT.<B|H|W> (and D on MIPS64),
> COPY_S.<B|H|W> (and D on MIPS64) and COPY_U.<B|H> (and W
> on MIPS64). Instead of using a switch in a helper, which is
> called many times, put a switch in translate.c file, which
> is called only a few times.
>=20

This paragraph suggests that there are essentially two independent
changes in this series (one for big endian host, another for refactoring
helpers), while in reality they are closely related. You should have
started the second sentence with "This is achieved by changing the
implementation of helpers for...".

> v3:
>  - Unroll loops in ST.<B|H|W|D> and LD.<B|H|W|D>
>    instructions.
>  - Eliminate macro that generates the helpers for
>    the ST.<B|H|W|D> and LD.<B|H|W|D> instructions,
>    and add four helpers for each (for byte,
>    halfword, word and doubleword).
>  - Eliminate the helpers for INSERT.<B|H|W|D>,
>    COPY_S.<B|H|W|D> and COPY_U.<B|H|W> and add
>    four (three in case of COPY_U) helpers for
>    each one.
>=20

The cover letter should contain the complete series history.

Thanks,
Aleksandar

> Mateja Marjanovic (5):
>   target/mips: MSA instructions ld, big endian host fix
>   target/mips: MSA instructions st, big endian host fix
>   target/mips: Different approach toward COPY_S MSA instr. and big
>     endian fix
>   target/mips: Different approach toward COPY_U MSA instr. and big
>     endian fix
>   target/mips: Different approach toward INSERT MSA instr. and big
>     endian fix
