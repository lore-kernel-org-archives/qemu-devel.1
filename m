Received: from eggs.gnu.org ([2001:4830:134:3::10]:33312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f3mxU-0004n4-J0
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 14:16:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f3mxT-0003vt-IU
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 14:16:32 -0400
References: <20180403110810.25624-1-kwolf@redhat.com>
	<d1633a50-2aad-af64-081c-bfac72b89e12@redhat.com>
	<20180404154141.GS38016@angien.pipo.sk>
	<20180404155420.GG4482@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <98cbcf10-6dd4-3373-5b08-f5c73691fa73@redhat.com>
Date: Wed, 4 Apr 2018 13:16:15 -0500
MIME-Version: 1.0
In-Reply-To: <20180404155420.GG4482@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="G8BpqsSxnQN7QaalA4r5Gkc3THTQDIOXk"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH for-2.12] gluster: Fix
 blockdev-add with server.N.type=unix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>
Cc: qemu-block@nongnu.org, Thomas Huth <thuth@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org, mreitz@redhat.com, prasanna.kalever@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--G8BpqsSxnQN7QaalA4r5Gkc3THTQDIOXk
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>
Cc: qemu-block@nongnu.org, Thomas Huth <thuth@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org,
 mreitz@redhat.com, prasanna.kalever@redhat.com
Message-ID: <98cbcf10-6dd4-3373-5b08-f5c73691fa73@redhat.com>
Subject: Re: [Qemu-block] [PATCH for-2.12] gluster: Fix blockdev-add with
 server.N.type=unix
References: <20180403110810.25624-1-kwolf@redhat.com>
 <d1633a50-2aad-af64-081c-bfac72b89e12@redhat.com>
 <20180404154141.GS38016@angien.pipo.sk>
 <20180404155420.GG4482@localhost.localdomain>
In-Reply-To: <20180404155420.GG4482@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/04/2018 10:54 AM, Kevin Wolf wrote:

>>> Should we also add a deprecation warning for 'socket' and update the
>>> deprecation documentation, so we can start the clock ticking on getti=
ng
>>> rid of maintaining the back-compat glue forever?
>>
>> Well, that won't be as easy. Since there is at least one qemu release
>> which declared this in the QAPI schema but did not support using it it=
's
>> hard for libvirt to detect that this was fixed, and thus we can't infe=
r
>> a capability which would be used to switch to the new-syntax only.
>=20
> Markus wanted to add some way to declare capabilities for a command in
> the schema that could be queried with schema introspection and would
> cover such cases. I think we even discussed this with you at KVM Forum?=

>=20
> Eric, do you happen to know if there were any patches on the list
> related to this?

I don't recall seeing any patches from Markus before his leave, and
doubt anyone else has tackled anything along these lines.  It's too late
for 2.12, at any rate, so even if we had such a feature implemented in
time for 2.13, it won't help introspecting the 2.12 release.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--G8BpqsSxnQN7QaalA4r5Gkc3THTQDIOXk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrFFm8ACgkQp6FrSiUn
Q2qPdgf/bQS1whZnQn6ifRkflhSxkEGzrVIxjOW4vhEkF4VNfgjcbeODd+oFNLiV
wMi3Lg74e1zxocbsTQhIRa3cKMu7ynBuqFsgwz8TsDcfp9v/EWNzy9euntsJjZOh
dEjN8N7n7AXSKoQ4MsRAdiSefhh+HAN4Oh5+YsqY4NX1iZVtwKkajhtubjYGyzcj
mGaJLclHNLfwAZCVhpN6WMTo2x2KJGr8UdCpKL6qQoLzzfbR/L8qyUl0d0QteUkz
ZWG0w8a3j+w7Hs1Lqebws1DBYRTDYejNXytRcmrDtNnq538tG4xCnKkt2Uvfaa2+
3dHamZuYRzYTAWOV53sQGXJyRr5eRA==
=0TUq
-----END PGP SIGNATURE-----

--G8BpqsSxnQN7QaalA4r5Gkc3THTQDIOXk--
