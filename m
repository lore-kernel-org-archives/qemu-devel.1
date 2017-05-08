Received: from eggs.gnu.org ([2001:4830:134:3::10]:60671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d7qbi-0001WH-Md
	for qemu-devel@nongnu.org; Mon, 08 May 2017 17:54:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d7qbh-0006S7-OW
	for qemu-devel@nongnu.org; Mon, 08 May 2017 17:54:18 -0400
Date: Mon, 8 May 2017 23:54:12 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170508215412.othbbicpjvz5p4fz@aurel32.net>
References: <0F376E9C-2D4B-4D79-B3D4-24F73FD61446@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <0F376E9C-2D4B-4D79-B3D4-24F73FD61446@gmail.com>
Subject: Re: [Qemu-devel] Floating point unit bugs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: G 3 <programmingkidx@gmail.com>
Cc: "qemu-ppc@nongnu.org list:PowerPC" <qemu-ppc@nongnu.org>, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>

On 2017-05-07 17:48, G 3 wrote:
> I made a diagnostic program for the floating point unit. It will test
> various PowerPC floating point instructions for compatibility with the
> PowerPC G3 processor. It was tested on a PowerPC G3 and G5 system. The
> results of the program in qemu-system-ppc were pretty bad. About every
> instruction tested is not implemented correctly.

I don't say that qemu-system-ppc is bug free, but this looks suspicious
that about every instruction is buggy. Have you tried to run your
program on a real G3 or G5 system?

[ snip=A0]

>=20
> Here is the full test results after running this program in qemu-system-p=
pc
> with a Mac OS 10.4 guest:
>=20
>=20
>=20
>=20
> fadd test failed
> expected answer: 0x3ff3333333333334
>   actual answer: 0x8200400000000024
> expected fpscr: 0x82064000
>   actual fpscr: 0x82004000

This looks highly suspicious that the actual answer match the expected
answer.

> actual FPSCR bits set:
> bit 17: FPRF - Floating-point greater than or positive
> bit 6: XX - Floating-point inexact exception
> bit 0: FX - Floating-point exception summary
>=20
> expected FPSCR bits set:
> bit 17: FPRF - Floating-point greater than or positive
> bit 14: FI - Floating-point fraction inexact
> bit 13: FR - Floating-point fraction rounded
> bit 6: XX - Floating-point inexact exception
> bit 0: FX - Floating-point exception summary
>=20
> fadds test failed
> expected answer: 0x407024d500000000
>   actual answer: 0x8200400000000024
> expected fpscr: 0x82064000
>   actual fpscr: 0x82004000

Ditto.

> actual FPSCR bits set:
> bit 17: FPRF - Floating-point greater than or positive
> bit 6: XX - Floating-point inexact exception
> bit 0: FX - Floating-point exception summary
>=20
> expected FPSCR bits set:
> bit 17: FPRF - Floating-point greater than or positive
> bit 14: FI - Floating-point fraction inexact
> bit 13: FR - Floating-point fraction rounded
> bit 6: XX - Floating-point inexact exception
> bit 0: FX - Floating-point exception summary
>=20
> fsub test passed
> fsubs test passed
> fmul test failed
> expected answer: 0x40365c28f5c28f5c
>   actual answer: 0x8200400000000024
> expected fpscr: 0x82024000
>   actual fpscr: 0x82004000

Ditto.

> actual FPSCR bits set:
> bit 17: FPRF - Floating-point greater than or positive
> bit 6: XX - Floating-point inexact exception
> bit 0: FX - Floating-point exception summary
>=20
> expected FPSCR bits set:
> bit 17: FPRF - Floating-point greater than or positive
> bit 14: FI - Floating-point fraction inexact
> bit 6: XX - Floating-point inexact exception
> bit 0: FX - Floating-point exception summary
>=20
> fmuls test failed
> expected answer: 0x412135a4a0000000
>   actual answer: 0x8200400000000024
> expected fpscr: 0x82024000
>   actual fpscr: 0x82004000
>=20
> actual FPSCR bits set:
> bit 17: FPRF - Floating-point greater than or positive
> bit 6: XX - Floating-point inexact exception
> bit 0: FX - Floating-point exception summary
>=20
> expected FPSCR bits set:
> bit 17: FPRF - Floating-point greater than or positive
> bit 14: FI - Floating-point fraction inexact
> bit 6: XX - Floating-point inexact exception
> bit 0: FX - Floating-point exception summary
>=20
> fdiv test failed
> expected answer: 0x40059f38ee13b48b
>   actual answer: 0x8200400000000024
> expected fpscr: 0x82064000
>   actual fpscr: 0x82004000

Ditto.

And so on...

--=20
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
