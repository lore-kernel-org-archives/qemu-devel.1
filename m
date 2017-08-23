Received: from eggs.gnu.org ([2001:4830:134:3::10]:38855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dkWeW-0000tB-OR
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 10:29:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dkWeV-0004FG-Rd
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 10:29:04 -0400
References: <20170821161539.11066-1-stefanha@redhat.com>
	<CAJSP0QWVGVn=vZWZy9isTemndDQrnzUAMO=A7T6W6Oe93ST2DQ@mail.gmail.com>
	<2217cc17-2638-c7ac-3ac0-6202bb2e4f4f@redhat.com>
	<aa8ea653-0ec1-90bb-f8ef-71511dab0a9a@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <63c24596-1f48-5f43-6b4d-8709b5c40036@redhat.com>
Date: Wed, 23 Aug 2017 09:28:53 -0500
MIME-Version: 1.0
In-Reply-To: <aa8ea653-0ec1-90bb-f8ef-71511dab0a9a@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="v9qvwXbh3P1pILhvN5eUGFcpRN7dsD2bp"
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
--v9qvwXbh3P1pILhvN5eUGFcpRN7dsD2bp
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 qemu block <qemu-block@nongnu.org>
Message-ID: <63c24596-1f48-5f43-6b4d-8709b5c40036@redhat.com>
Subject: Re: [Qemu-block] [Qemu-devel] [PATCH] nbd-client: fix hang after
 server closes connection
References: <20170821161539.11066-1-stefanha@redhat.com>
 <CAJSP0QWVGVn=vZWZy9isTemndDQrnzUAMO=A7T6W6Oe93ST2DQ@mail.gmail.com>
 <2217cc17-2638-c7ac-3ac0-6202bb2e4f4f@redhat.com>
 <aa8ea653-0ec1-90bb-f8ef-71511dab0a9a@redhat.com>
In-Reply-To: <aa8ea653-0ec1-90bb-f8ef-71511dab0a9a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/23/2017 09:25 AM, Eric Blake wrote:
> On 08/21/2017 02:01 PM, Eric Blake wrote:
>> On 08/21/2017 11:27 AM, Stefan Hajnoczi wrote:
>>> On Mon, Aug 21, 2017 at 5:15 PM, Stefan Hajnoczi <stefanha@redhat.com=
> wrote:
>>>>   (qemu) quit
>>>>   ...hang...
>>>
>>> By the way, the same issue is present in QEMU 2.9.  This is not a 2.1=
0
>>> regression.
>>
>> Most likely, though, it IS a regression introduced in 2.9 and not
>> present in 2.8.  I'll add this to my list of 2.11 NBD patches.
>=20
> Since it looks like we're doing -rc4 and including other NBD patches fo=
r
> that, I'm adding this to my 2.10 NBD queue,

On IRC, Stefan informed me that 'nbd-client: avoid spurious
qio_channel_yield() re-entry' obsoletes this one.

> and will send a pull request
> shortly...

This part is still true

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--v9qvwXbh3P1pILhvN5eUGFcpRN7dsD2bp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmdkSUACgkQp6FrSiUn
Q2o89Af/RHYKssdCBxmjjaDh8cEHQULfME+qzh81nTCscDipL2WFOx8wNT4XRJ1j
3lva2y8Kn0PsLt5ERh0elnQgkAsW2wzj9IsfrrVdONa8U06tjuN0T0MLP/bWRyKs
ERREOoeXCWRpudFcBNrn1lm3SyqpTeswT06x27ATeFSlhcm3hC3sycjpiUSZbRje
bQW49a1PPfh+u+RWibn1xyVEkJ92o84AcAqUCuVTV1MUFHrgQ4vm5qXnCprhQY9m
eATjs/c4nmoecNcXc3vBTBeAhAXQL5yEe8lRDXpVE5Znc/pKnBAx64u1e7UFGCHz
VC1cpkl8iiDyMC72nzkVZqBdulEAXQ==
=1AEe
-----END PGP SIGNATURE-----

--v9qvwXbh3P1pILhvN5eUGFcpRN7dsD2bp--
