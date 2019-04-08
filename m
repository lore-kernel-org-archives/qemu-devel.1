Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF35C282CE
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 04:34:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3603E20880
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 04:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Y4X9scnW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3603E20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47176 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDLzT-00083B-5I
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 00:34:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hDLuR-0004R3-UT
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 00:29:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hDLuP-0007dI-Vc
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 00:29:27 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:54505 helo=ozlabs.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hDLuO-0007aR-NA; Mon, 08 Apr 2019 00:29:25 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 44cy9g28H9z9sRX; Mon,  8 Apr 2019 14:29:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1554697751;
	bh=7bNTVfd/vz/CaUz0K8qS2PZ7Ylf6G+exU4u8ASBCvZg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y4X9scnW/P7O2X8VnBgAbI3My08rDkMqxWBoKqKtyAyeoSeqwFRv2px/Qv8s6DRKn
	mtirsBqiT2RcaLUy5hCnFQ99NqgVNCE021AEdPzPuhPnF5hZc/VS+4/FmPuIkv7Hec
	qaIY2RQbEMUfHJ7wDs3HD7Ib0nUi+6EHWx0b95gY=
Date: Mon, 8 Apr 2019 13:54:32 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Sergei Trofimovich <slyfox@gentoo.org>
Message-ID: <20190408035432.GF16627@umbus.fritz.box>
References: <20190323222412.9825-1-slyfox@gentoo.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="z+pzSjdB7cqptWpS"
Content-Disposition: inline
In-Reply-To: <20190323222412.9825-1-slyfox@gentoo.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH] powerpc: fix denorm float->double
 conversion
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408035432.Va_uH01Vx6zMw4MjPV0lINUNLi5Q8RdhvX4J6SysDhY@z>


--z+pzSjdB7cqptWpS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 23, 2019 at 10:24:11PM +0000, Sergei Trofimovich wrote:
> The bug is initially discovered in GHC test suite. Here is minimal reprod=
ucer:
>=20
> ```c
>=20
> int main() {
>     volatile float f;
>     volatile double d;
>=20
>     *(volatile uint32_t*)&f =3D 0xc0de;
>     d =3D f;
>     printf("f  =3D %#x\n", *(volatile uint32_t*)&f);
>     printf("d  =3D %#llx (expect 0x37981bc000000000)\n",
>         *(volatile uint64_t*)&d);
>     printf("d  =3D %e\n", d);
>     f =3D d;
>     printf("f  =3D %#x\n", *(volatile uint32_t*)&f);
> }
> ```
>=20
> ```
> $ powerpc-unknown-linux-gnu-gcc -O2 a.c -Wall -o a \
>     -fno-strict-aliasing -static && qemu-ppc ./a
> f  =3D 0xc0de
> d  =3D 0x37a00000000c0de0 (expect 0x37981bc000000000)
> d  =3D 9.183550e-41
> f  =3D 0x10000
> ```
>=20
> Here denormalization conversion has a few bugs:
> - significand (abs_arg) has 32-bit unsigned wraparound in
>     ret |=3D abs_arg << (shift + 29);
> - significand does not drop explicit leading '1' in denorm
>   'float' when converting to normalized 'double'
> - significand had an off-by-one shift
>=20
> CC: Richard Henderson <richard.henderson@linaro.org>
> CC: David Gibson <david@gibson.dropbear.id.au>
> CC: qemu-ppc@nongnu.org
> CC: qemu-devel@nongnu.org
> Bug: https://bugs.launchpad.net/qemu/+bug/1821444
> Signed-off-by: Sergei Trofimovich <slyfox@gentoo.org>

LGTM, but I don't know much about floating point.

Richard, can you review this?

> ---
>  target/ppc/fpu_helper.c | 32 +++++++++++++++++++++++++++-----
>  1 file changed, 27 insertions(+), 5 deletions(-)
>=20
> diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
> index 2ed4f42275..1e8b014890 100644
> --- a/target/ppc/fpu_helper.c
> +++ b/target/ppc/fpu_helper.c
> @@ -64,13 +64,35 @@ uint64_t helper_todouble(uint32_t arg)
>          ret |=3D (uint64_t)extract32(arg, 0, 30) << 29;
>      } else {
>          /* Zero or Denormalized operand.  */
> -        ret =3D (uint64_t)extract32(arg, 31, 1) << 63;
> +
> +        /*
> +         * Conversion mechanics:
> +         * float denorm (2^(-126) - biased):
> +         *    [ sign (1 bit) | exp32 (8 bits)  | sign32 (23 bits) ]
> +         *                 s                0    0001abc...def
> +         * double norm (2^(-1023) - biased):
> +         *    [ sign (1 bit) | exp64 (11 bits) | sign64 (52 bits) ]
> +         *                 s              exp    abc...def 00..0
> +         * Thus we are performing the following conversion steps:
> +         * 1. preserve the sign
> +         * 2. normalize denorm sign32:
> +         *   2a. drop explicit leading '1' as normalized numbers
> +         *       don't contain it
> +         *   2b. calculate the bit-shift needed to match implicit '1'
> +         * 3. calculate 'exp64' as bias delta plus denorm offset
> +         * 4. put calculated 'sign64' into new location
> +         */
> +        ret =3D (uint64_t)extract32(arg, 31, 1) << 63; /* [1.] */
>          if (unlikely(abs_arg !=3D 0)) {
>              /* Denormalized operand.  */
> -            int shift =3D clz32(abs_arg) - 9;
> -            int exp =3D -126 - shift + 1023;
> -            ret |=3D (uint64_t)exp << 52;
> -            ret |=3D abs_arg << (shift + 29);
> +            int lz =3D clz32(abs_arg);
> +            abs_arg &=3D ~(1 << (31 - lz)); /* [2a.] */
> +
> +            /* shift within sign32 includeing leading '1' */
> +            int shift =3D lz + 1 - (32 - 23);
> +            int exp =3D -126 + 1023 - shift; /* [2b]. */
> +            ret |=3D (uint64_t)exp << 52; /* [3.] */
> +            ret |=3D (uint64_t)abs_arg << (52 - 23 + shift); /* [4.] */
>          }
>      }
>      return ret;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--z+pzSjdB7cqptWpS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlyqxfcACgkQbDjKyiDZ
s5Lg0xAA2FC6W8b/yo/APnIhSLkiuGPdqUwQ7x1B++3QBBHDAVmzWnZ30FgYgelM
IwKyDi2tmJY16xzvJ4GLWgPwCLKoCQrmVjCGsfHaQ3UnyN4jYUFNMC5/Lo0b3g00
NVnN5T3+s7s2kXalk8TQWRRv8Qtf0H567qxYyqEs0qQtK2URAgb0ElpjSLAvtXqr
ypT/vx+c6j1i8nASOe8g5sNj+9fYDgcQ+d6z6XOroixZjYcD0ttnS0mkzqZF3iNC
EQ+jdmvLJjjGHTje6ywnpEoSQb62iiqkB/ULTcTFBnPLUtonHIR2wAvImAINYmwd
7Zfedn7Pu4lP9qERNXNQoPlO/7mdZKtoA9nMmJUB8mEp0nt5WTY/s4HGAdmrA6Nl
yBb89oLhpJAe9qY01lGbvbBD5dkGo5ryR+AOOk1ds7rZBGLxk390lwx7wiiSi0CI
7nCoeSLWKwzgq/EhkgnBkwWq2nuh/7oOFp3EEzUXzL7lT5hyTqdT0Ed33bwvA765
nWgEDoAtM3jK5B7Yt92hBppwREXHxH+wc8+njWmMIdKuIM9BN/yGu1Ogm0uPwCoo
ice5O1PziV4ggne46CKCz+VXmVLRf0zwTLJlRPZ12qIHFxYV/gMKQ8dyKcL8vgC6
HNGdX/OIY1EEwgtOAg2xic2euKzVJBfq9VB4eCVP5p8AJkEgUK4=
=X249
-----END PGP SIGNATURE-----

--z+pzSjdB7cqptWpS--

