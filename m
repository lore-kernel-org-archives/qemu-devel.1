Received: from eggs.gnu.org ([209.51.188.92]:38346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.bobek@gmail.com>) id 1hElEP-0007Iz-7Q
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 21:43:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.bobek@gmail.com>) id 1hElEO-0007NJ-86
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 21:43:53 -0400
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:44105)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hElEN-0007Mc-Rt
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 21:43:52 -0400
Received: by mail-yb1-xb41.google.com with SMTP id u187so3004062ybg.11
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 18:43:51 -0700 (PDT)
References: <20190408182748.1238-1-jan.bobek@gmail.com>
	<e38bf007-440c-9d6d-c837-e1e52b661075@linaro.org>
From: Jan Bobek <jan.bobek@gmail.com>
Message-ID: <a82ec99d-8b5e-6898-c0a7-a3de8e2be07f@gmail.com>
Date: Thu, 11 Apr 2019 21:43:37 -0400
MIME-Version: 1.0
In-Reply-To: <e38bf007-440c-9d6d-c837-e1e52b661075@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="5J3APSNVcDpwGuNTMrRsTGN2nMU98mdUJ"
Subject: Re: [Qemu-devel] [RISU PATCH 0/5] Fix RISU build for i386
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5J3APSNVcDpwGuNTMrRsTGN2nMU98mdUJ
From: Jan Bobek <jan.bobek@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <a82ec99d-8b5e-6898-c0a7-a3de8e2be07f@gmail.com>
Subject: Re: [RISU PATCH 0/5] Fix RISU build for i386
References: <20190408182748.1238-1-jan.bobek@gmail.com>
 <e38bf007-440c-9d6d-c837-e1e52b661075@linaro.org>
In-Reply-To: <e38bf007-440c-9d6d-c837-e1e52b661075@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Sorry for the delayed reply, the U.S. tax deadline has caught up with
me, so I spent the last two evenings doing my taxes. (Yuck!)

Anyway...

On 4/8/19 6:18 PM, Richard Henderson wrote:
> On 4/8/19 8:27 AM, Jan Bobek wrote:
>> 2. Note the '-std=3Dc99' switch in the command-line above; without it,=

>>    GCC defines the symbol 'i386' to 1 and the preprocessor magic for
>>    including arch-specific headers in risu.h breaks. Does anyone have
>>    an idea how to fix this in a more robust way?
>=20
> Adding -U$(ARCH) to the command line is probably as good a fix as any.

I didn't know about -U, nice!

>> 3. gas (the GNU assembler) chokes on the syntax of test_i386.s; that's=

>>    why I'm using nasm as the assembler above. Is that intentional? I
>>    haven't found the nasm dependency mentioned anywhere.
>=20
> I think rewriting to not require nasm is better.

Agreed.

>>    Also, nasm will happily emit the UD1 opcode (0F B9) with no
>>    operands (see test_i386.s). That's a bit surprising to me, since
>>    Intel's Software Developer's Manual says UD1 has two operands; I'd
>>    expect at least a follow-up ModR/M byte. gas refuses to assemble
>>    UD1 with no operands, and gdb's disassembler gets confused when I
>>    load up the nasm's binary into risu. Is there something obvious
>>    that I'm missing?
>=20
> You are not missing anything -- ud1 should require a modrm byte.
>=20
> My suggestion is to use only UD1 as the "break" insn, with the differen=
t OP_*
> codes encoded into the modrm byte.

I had to laugh when I read this; this is *exactly* what I had in mind,
but then I found out there was no ModR/M byte.

>> P.S. This is my first time using git send-email, so please bear with
>>      me if something goes wrong and/or let me know how I can improve
>>      my future submissions. Thank you!
>=20
> You've done well with git send-email.  ;-)

Thanks a lot! :)

-Jan


--5J3APSNVcDpwGuNTMrRsTGN2nMU98mdUJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEESPYOqtMR3qRZrEutZeg2ldrjNs8FAlyv7UoACgkQZeg2ldrj
Ns8oUw//ZFBOn8+Wq3jnR0e7j/WjQ/MsWrQpmY3N0dnvtnm4O8nxYbbcusyLztr1
ImHrSMu9KL17O6i6hwbGDqrBhoaZdNGMwUPVRi1fGaA0mkacHxOBUnQInPxgMpgB
Wz7pl0zfMBcMhJhuJ0AHqU0FOBbdPY2cd0+zSOC20KDlmN8tN+4SAM7oW/OaHC1Q
XNzIlgX3GQHYUPzfQAA2TNya0dH8A3RN4QvHItl5PrIWhtw9gFTsJCsyzAQmRhx/
xt5FFeGJ+63W3PMR7jR4uWtjPPbSstjbZFDxjB++nqNSagu3UyeOMMNMxe0Wq7aB
hxLx7PSy6ju7kmV/nXbHDNzbNwyrJ1TVip4bC6y0nnayoduh6BrbSUfsocGzlHxD
XZdz2t3LggGODuIiY6LacnSdYJhKCEjexq7b5rfLJyzqcEngTdmTbhiq8g21fSo4
vGIXXU6OLJee3ifHw+94oTj8+1FM40LAi365+TXWKsVkGsrtLeimQjZSOCjt/1lc
NR7G3Gf1FLyAmK7XnpW/z0w9hMmX06Vc4bLBGB6pqo64zrP3Ieo6eeP8OLSi8MFf
aTPY3J2pwqbWGHrpc7lETWxo1U1u1IKhw4BNJmGnJIojaui7jwITmDu3FR4hDajG
yEjk54WN1nGI77nIIS6awT4irqOMPAkQRXPiXukWBQU87/MNr70=
=/PBZ
-----END PGP SIGNATURE-----

--5J3APSNVcDpwGuNTMrRsTGN2nMU98mdUJ--
