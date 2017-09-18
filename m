Received: from eggs.gnu.org ([2001:4830:134:3::10]:38095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1du4kL-0005m7-9R
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 18:42:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1du4kK-0003T4-Ce
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 18:42:33 -0400
References: <20170918214649.17550-1-eblake@redhat.com>
	<dfe4dc28-4011-e7a7-aa1f-54e340f091d2@amsat.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <53ea39b4-7926-d29b-fb28-3f2295dc394d@redhat.com>
Date: Mon, 18 Sep 2017 17:42:24 -0500
MIME-Version: 1.0
In-Reply-To: <dfe4dc28-4011-e7a7-aa1f-54e340f091d2@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="4Eh3EOPhaqWlCGewO0wwru9vwWILP27lJ"
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] nbd-client: Use correct
 macro parenthesization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4Eh3EOPhaqWlCGewO0wwru9vwWILP27lJ
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Message-ID: <53ea39b4-7926-d29b-fb28-3f2295dc394d@redhat.com>
Subject: Re: [Qemu-trivial] [PATCH] nbd-client: Use correct macro
 parenthesization
References: <20170918214649.17550-1-eblake@redhat.com>
 <dfe4dc28-4011-e7a7-aa1f-54e340f091d2@amsat.org>
In-Reply-To: <dfe4dc28-4011-e7a7-aa1f-54e340f091d2@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/18/2017 05:13 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Eric,
>=20
> On 09/18/2017 06:46 PM, Eric Blake wrote:
>> If 'bs' is a complex expression, we were only casting the front half
>> rather than the full expression.=C2=A0 Luckily, none of the callers we=
re
>> passing bad arguments, but it's better to be robust up front.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>=20
> Any magic cocci script to verify there aren't no more?

I don't know if cocci can do it; checkpatch tries to check whether macro
arguments are parenthesized, but even that's prone to missing things.  I
just spotted this particular one while reviewing a related patch.


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--4Eh3EOPhaqWlCGewO0wwru9vwWILP27lJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnAS9AACgkQp6FrSiUn
Q2qFxAf/Q1ah6f0PV8Uw3EdDiquMLz2JkJmPyNuS7nERrbtFptfNieRg45YlQxSK
l51mFEbzDEXiAA7irm+lEDp4JSLc9kgNm+QmgPA4Oyci4DKS3pXUJX73eLjab+wb
+wGUW4eWLLV5haf2CzurXxlB5L0oP0pvIKMX+fHgHR1a2nXC5gc6skP8Xb2q5uSs
hcYIGSsPZ9S/3otEPFH/TQLqWCh1gqFaV7yZDz+UOIuXQy9aI52Ka5dS9iL6DviL
tu8nrji8lfrf3b64IIZzRUCo4i4C/RpqPd03eFwdF8XTF41X27re6fJ9Qojcjz1F
wSo/3GiA9ZT8OSvgHLjWR1BFhjMC3A==
=S7lL
-----END PGP SIGNATURE-----

--4Eh3EOPhaqWlCGewO0wwru9vwWILP27lJ--
