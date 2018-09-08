Received: from eggs.gnu.org ([2001:4830:134:3::10]:35382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fyQqe-0001JC-Td
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 20:11:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fyQiY-0004zK-39
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 20:03:18 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:39891)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fyQiX-0004w8-Rb
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 20:03:14 -0400
Received: by mail-wm0-x232.google.com with SMTP id q8-v6so16091809wmq.4
	for <qemu-devel@nongnu.org>; Fri, 07 Sep 2018 17:03:13 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180707194137.GB14409@localhost.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <dde6d3cb-f2a4-e36b-69ac-8147fc5e752d@amsat.org>
Date: Fri, 7 Sep 2018 21:03:01 -0300
MIME-Version: 1.0
In-Reply-To: <20180707194137.GB14409@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="CbPhDbTYNftN9T9B71LYk8KtAYqC3IrGN"
Subject: Re: [Qemu-devel] [RFC] target/mips: Initial support for MIPS R5900
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Markovic <aleksandar.markovic@mips.com>
Cc: Fredrik Noring <noring@nocrew.org>, =?UTF-8?Q?J=c3=bcrgen_Urban?= <JuergenUrban@gmx.de>, "Maciej W. Rozycki" <macro@linux-mips.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CbPhDbTYNftN9T9B71LYk8KtAYqC3IrGN
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Markovic <aleksandar.markovic@mips.com>
Cc: Fredrik Noring <noring@nocrew.org>, =?UTF-8?Q?J=c3=bcrgen_Urban?=
 <JuergenUrban@gmx.de>, "Maciej W. Rozycki" <macro@linux-mips.org>
Message-ID: <dde6d3cb-f2a4-e36b-69ac-8147fc5e752d@amsat.org>
Subject: Re: [Qemu-devel] [RFC] target/mips: Initial support for MIPS R5900
References: <20180707194137.GB14409@localhost.localdomain>
In-Reply-To: <20180707194137.GB14409@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

On 7/7/18 4:41 PM, Fredrik Noring wrote:
[...]
> --- a/target/mips/mips-defs.h
> +++ b/target/mips/mips-defs.h
> @@ -52,6 +52,7 @@
>  #define   ASE_MSA       0x01000000
> =20
>  /* Chip specific instructions. */
> +#define		INSN_R5900	0x10000000

We have 4 bits to store the chip-specific instructions and this is the
last bit available.

Any objection to upraise CPUMIPSState.insn_flags to a uint64_t?
I'd then shift the chip-specific bits to the 32 upper bits, to keep this
flag clean.

>  #define		INSN_LOONGSON2E  0x20000000
>  #define		INSN_LOONGSON2F  0x40000000
>  #define		INSN_VR54XX	0x80000000
> @@ -62,6 +63,7 @@
>  #define		CPU_MIPS3	(CPU_MIPS2 | ISA_MIPS3)
>  #define		CPU_MIPS4	(CPU_MIPS3 | ISA_MIPS4)
>  #define		CPU_VR54XX	(CPU_MIPS4 | INSN_VR54XX)
> +#define		CPU_R5900	(CPU_MIPS4 | INSN_R5900)
>  #define		CPU_LOONGSON2E  (CPU_MIPS3 | INSN_LOONGSON2E)
>  #define		CPU_LOONGSON2F  (CPU_MIPS3 | INSN_LOONGSON2F)
[...]


--CbPhDbTYNftN9T9B71LYk8KtAYqC3IrGN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAluTEbYACgkQ4+MsLN6t
wN5hhA/+LWiUbyglR4JHUMdEpcox/xJRo7X1+QbHFib6GREcMeluAoGI9C8yCQoK
gXTb1vzA7mlZeCm4mp3u+SM6RoNO52tWxM6CRg9s0gWHxmNZTnYjacUnumqjBbPG
WyIoXFP8DMUZGuYP8u2K4OytjSMjzm4dj5QvHL4fof4x7/R4wN/VI07/+dCD52ma
9Aq80DiQTAuzCv7bsYC70x52twIRKPZsA2x+KHY3fzO3RDDCg6ySTqKJudDavq2q
FkwWOj76xX/hxL7NfC4MQhEHZNPHhMRtPF4PL+r+0Bl8nqMHir2ZmwnAgCngqNdc
ufqOsUbBaWI0QmpbA9zxcwniqBFDyXxOPKpm2ESRoi3bS5Hyd0S0AOygF/yILpAt
mBJP3BGAq+x3CBg8WSqi2jly3AhH8O3b6Vo8YM3QH+wPAqq9UtEp1G9fcdhwNQWE
xjeXLncUvTYYwwYKSSaSoN8WfiNjs2cm6e9rfH2bv+uq30vkyafImY6p4rqb/zb+
0pzGhbR+Z+mM47ic5BBDSoKQkKfS/jfnxGlE9mxA/Zu3JCC0S91wOFUZ481mMh/g
XpBP6KU+CUIuChdt7wwxSaDAl37A8lmodkZlDi5svCJuBTZ6lVgMVyl5Vd4iySFo
xTUj9huyzB+UzEMLY8HsUwQpYNFqRKAhIOtSorx2xNuUKQzzCGE=
=fhGx
-----END PGP SIGNATURE-----

--CbPhDbTYNftN9T9B71LYk8KtAYqC3IrGN--
