Received: from eggs.gnu.org ([209.51.188.92]:45499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gml6I-0008Kw-D9
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 14:55:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gml6D-0006fp-Fq
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 14:55:46 -0500
References: <20190102140535.11512-1-cfergeau@redhat.com>
	<20190102180158.GA6015@natto.ory.fergeau.eu>
	<4ff5eb04-e1e0-7126-c08d-58d1f28b4f27@redhat.com>
	<87o98sii5b.fsf@dusky.pond.sub.org> <87munqieiv.fsf@dusky.pond.sub.org>
	<f16734e0-1ec3-15e7-5a06-7b2c804c80a9@redhat.com>
	<87tvhxaozd.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <55ba8425-dba8-7875-969b-f5115afac1a9@redhat.com>
Date: Thu, 24 Jan 2019 13:55:34 -0600
MIME-Version: 1.0
In-Reply-To: <87tvhxaozd.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="fUAMt25POz7Yy044KhlEqnT90RzOrVWcr"
Subject: Re: [Qemu-devel] [PATCH] json: Fix % handling when not interpolating
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Christophe Fergeau <cfergeau@redhat.com>, "Richard W. M. Jones" <rjones@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org, qemu-stable@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fUAMt25POz7Yy044KhlEqnT90RzOrVWcr
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Christophe Fergeau <cfergeau@redhat.com>,
 "Richard W. M. Jones" <rjones@redhat.com>, Max Reitz <mreitz@redhat.com>,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
Message-ID: <55ba8425-dba8-7875-969b-f5115afac1a9@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] json: Fix % handling when not interpolating
References: <20190102140535.11512-1-cfergeau@redhat.com>
 <20190102180158.GA6015@natto.ory.fergeau.eu>
 <4ff5eb04-e1e0-7126-c08d-58d1f28b4f27@redhat.com>
 <87o98sii5b.fsf@dusky.pond.sub.org> <87munqieiv.fsf@dusky.pond.sub.org>
 <f16734e0-1ec3-15e7-5a06-7b2c804c80a9@redhat.com>
 <87tvhxaozd.fsf@dusky.pond.sub.org>
In-Reply-To: <87tvhxaozd.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/24/19 12:29 PM, Markus Armbruster wrote:

>>>       - block.c: JSON pseudo-filenames starting with "json:"
>>>
>>>         Reproducer: https://bugzilla.redhat.com/show_bug.cgi?id=3D166=
8244#c3
>>>
>>>       - block/rbd.c: JSON key pairs
>>>
>>>         Pseudo-filenames starting with "rbd:".
>>>
>>
>> Missed curl as being impacted. You'd have to do a v2 pull request to
>> mention it now...
>>
>> https://bugzilla.redhat.com/show_bug.cgi?id=3D1668244
>=20
> Isn't that an instance of 'JSON pseudo-filenames starting with "json:"'=
?

Indeed - and I even linked to the same BZ without realizing it.  Nothing
further to see here, I'll go back to hiding in the corner...

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--fUAMt25POz7Yy044KhlEqnT90RzOrVWcr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxKGDYACgkQp6FrSiUn
Q2pR9Af/TnlYR53LAvXa6m0r3Yv4mqlyxwaUbdXC54PUpjThLywI4R4tCO0vwdym
uTPuoFTtLMoP3ZGF6LAlWsXzkqm5gvQ6pd/THOvq6LZLkIlWpekJBH676QCM0zRn
2gA2pAD+AKAQ0uS6cOShsJJXP9yo/Y7wEA3+xoqNIGzrl1PdgPPJyYuUPA9aEQYo
X+RD0MT4bG+Mqk+UNYGfXxVR4BduS0nyshWgBSFn4t0luMCJobRYokGgLtATvIGe
IALc77fZgsqeo6xbjaTEP5S5/nYHs4BHMBQjHhg29iH+ZP1KI+BG/3ZTcCSf8MSD
cdGSpzA0gQHA3K0oq8uiwqpgh9itOw==
=Wh7u
-----END PGP SIGNATURE-----

--fUAMt25POz7Yy044KhlEqnT90RzOrVWcr--
