Received: from eggs.gnu.org ([2001:4830:134:3::10]:37954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dkWbh-0007ga-PL
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 10:26:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dkWbg-0001Pw-Qe
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 10:26:09 -0400
References: <20170821161539.11066-1-stefanha@redhat.com>
	<CAJSP0QWVGVn=vZWZy9isTemndDQrnzUAMO=A7T6W6Oe93ST2DQ@mail.gmail.com>
	<2217cc17-2638-c7ac-3ac0-6202bb2e4f4f@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <aa8ea653-0ec1-90bb-f8ef-71511dab0a9a@redhat.com>
Date: Wed, 23 Aug 2017 09:25:55 -0500
MIME-Version: 1.0
In-Reply-To: <2217cc17-2638-c7ac-3ac0-6202bb2e4f4f@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="HVOot58lo6nhtGP9EiDt6HugEoNNcpTrJ"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] nbd-client: fix hang after
 server closes connection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HVOot58lo6nhtGP9EiDt6HugEoNNcpTrJ
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 qemu block <qemu-block@nongnu.org>
Message-ID: <aa8ea653-0ec1-90bb-f8ef-71511dab0a9a@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] nbd-client: fix hang after
 server closes connection
References: <20170821161539.11066-1-stefanha@redhat.com>
 <CAJSP0QWVGVn=vZWZy9isTemndDQrnzUAMO=A7T6W6Oe93ST2DQ@mail.gmail.com>
 <2217cc17-2638-c7ac-3ac0-6202bb2e4f4f@redhat.com>
In-Reply-To: <2217cc17-2638-c7ac-3ac0-6202bb2e4f4f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/21/2017 02:01 PM, Eric Blake wrote:
> On 08/21/2017 11:27 AM, Stefan Hajnoczi wrote:
>> On Mon, Aug 21, 2017 at 5:15 PM, Stefan Hajnoczi <stefanha@redhat.com>=
 wrote:
>>>   (qemu) quit
>>>   ...hang...
>>
>> By the way, the same issue is present in QEMU 2.9.  This is not a 2.10=

>> regression.
>=20
> Most likely, though, it IS a regression introduced in 2.9 and not
> present in 2.8.  I'll add this to my list of 2.11 NBD patches.

Since it looks like we're doing -rc4 and including other NBD patches for
that, I'm adding this to my 2.10 NBD queue, and will send a pull request
shortly...

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--HVOot58lo6nhtGP9EiDt6HugEoNNcpTrJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmdkHQACgkQp6FrSiUn
Q2od/AgAl66fd4AJ7LrkOnqwWJsfP8u+rxp7pDiRKI1CWOFiwEF7c18PFouk34i5
YBdX8QhbTXtaZYl0pqBLp79krHw5p+IMNDi5wiASy5d3m4nZO5PUevidbV+oRE+E
pjiWOA/coXBO24JhbwM+/t/xrFrsDfIrSFwEYhddinn6BNL5Qh/fCONLnI05jrAd
GgKQxm3cHo96h1bWYFrgJASoq/sPrR97fcikzXvfpPohSgXE6SsIbCP17WOmzCLG
6CTznBKvNghXiXstXDah8Wg/62XmZBDYBEUfD8MVIAAbpDBK/ia0AX8IyMd3D3po
PSQR/7PVEb5NBOm84ZCq8FAO8ep/dA==
=04fJ
-----END PGP SIGNATURE-----

--HVOot58lo6nhtGP9EiDt6HugEoNNcpTrJ--
