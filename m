Received: from eggs.gnu.org ([2001:4830:134:3::10]:53254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dl7Uh-0001C0-92
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 01:49:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dl7Uc-0001Fw-DK
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 01:49:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56970)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dl7Uc-0001FB-2f
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 01:49:18 -0400
References: <mailman.3749.1503600836.21955.qemu-devel@nongnu.org>
	<74846968-830E-4239-9DC7-B1252A5AC946@gmail.com>
	<60e13112-931d-a517-ddb1-20c2f2de736e@redhat.com>
	<9CE89958-B59C-4D3C-91C5-ECB4B153C43D@gmail.com>
	<89d8b7b1-fb0f-a967-927e-8795c7d2b324@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <1adde8d7-762f-8e89-7192-32d370b72af6@redhat.com>
Date: Fri, 25 Aug 2017 07:49:08 +0200
MIME-Version: 1.0
In-Reply-To: <89d8b7b1-fb0f-a967-927e-8795c7d2b324@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="qj4UvQ1uDsqG9kOxCF1elqnHIVHb7U9e2"
Subject: Re: [Qemu-devel] Make test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, Programmingkid <programmingkidx@gmail.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qj4UvQ1uDsqG9kOxCF1elqnHIVHb7U9e2
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 25.08.2017 00:16, Cleber Rosa wrote:
>=20
> On 08/24/2017 05:50 PM, Programmingkid wrote:
>>
>> Thank you for the patches. I will test them. I was wondering what is t=
he point to having both 'make check' and 'make test'. It looks like every=
one is using 'make check'. Maybe we are better off removing the 'make tes=
t' target.
>>
>=20
> I think the removing the `make test` target is a good thing, if its
> tests are either absorbed by an existing `make check*` one.  Now that
> depends on what people think the tcg tests (and others) deserve... TLC?=

> Total annihilation?

Since we do not have very good test coverage for TCG yet, I'd like to
see this rather fixed than removed! Could you please CC: me on future
versions of your patch series (I missed v1)?

And I'd suggest to rename "make test" to "make check-tcg" to align it
with the other check* targets. (I remember the very first time I was
trying to run the QEMU tests and this "check" vs. "test" naming caused
really some confusion for me).

 Thomas


--qj4UvQ1uDsqG9kOxCF1elqnHIVHb7U9e2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJZn7pZAAoJEC7Z13T+cC213owP/1t8t9yVpK0N6GLphmu1dOtt
I408bqURn415z0fENOBrHPIk7GF5JJrDNLnxvXj+k24a4XbaikKPmU2FCSwwP9b/
VknQd12/SRLPJanauucX1hCIc3m6hjY0AEL386jvEuM1WteYBgsTtwoqWSKLmZwD
V2eZ1TT8LkFcFo+fc3v7Nr6YbYb0AH5CsZQZWQEI0kBU3ZDUBr7anMRC9zR/XvXc
pyVM7OfrVcsFfRQEQEXwhVnUmNyzpwnrMO+tFNJ43adTo9yFDtpSeOY/B/PDaBGb
V0RuS1yTw+8tFaPYh1IW1SCRR10OqwUeZNUtue9kJ0vsTwlX2619MfgL3nvh1WPq
IPMsyVR8mhCK4sPxYHdyFV1kKHxPihy4Sj/MUAsXFiVNYcLGWZa9GDhpriSMefo1
kcscMI+2wRAF7wtpwmHxAEUiOJ8ybn0nY/d7HAxUELh6fXxuGmFDQXOd7aAc5f7I
Q0YHNVhhpInRd3FXbij0eknth3gB6sI+wdjozR+D61q+Y7UeIk+lyus4ba1zZR0B
/cXfROTPOYrdpZ8u7CZYev4lvov2hh439iPUmzWnFH4f4PYfpsclEgv88HMFIpsh
cmlABmCcC11dRPqjg47Q2OIWLmJLkZTxmp4oudxRoTuv/3vmCTn8D6MebOAzvHJA
jf+iVylRaG0nU2PsEtsV
=8udm
-----END PGP SIGNATURE-----

--qj4UvQ1uDsqG9kOxCF1elqnHIVHb7U9e2--
