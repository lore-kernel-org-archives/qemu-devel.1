Received: from eggs.gnu.org ([2001:4830:134:3::10]:47907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXYbE-0003BA-6E
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 15:56:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXYbD-0000as-5i
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 15:56:04 -0400
References: <1500385286-21142-1-git-send-email-armbru@redhat.com>
	<1500385286-21142-11-git-send-email-armbru@redhat.com>
	<1aa2bff6-8798-cfd4-e969-b98064dd7d4c@redhat.com>
	<87d18xk2si.fsf@dusky.pond.sub.org>
	<d1f4e349-c312-9000-6dc3-d3fa46fce903@redhat.com>
	<87vampee1s.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ce1622cf-7289-ca80-bdca-dc100a452f67@redhat.com>
Date: Tue, 18 Jul 2017 14:55:50 -0500
MIME-Version: 1.0
In-Reply-To: <87vampee1s.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="mOjV8pPm9x3EDkCgwq2loUUWSCSK9w6Vq"
Subject: Re: [Qemu-devel] [PATCH for-2.10 10/10] migration: Use JSON null
 instead of "" to reset parameter to default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: kwolf@redhat.com, qemu-block@nongnu.org, quintela@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mOjV8pPm9x3EDkCgwq2loUUWSCSK9w6Vq
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: kwolf@redhat.com, qemu-block@nongnu.org, quintela@redhat.com,
 qemu-devel@nongnu.org, dgilbert@redhat.com, mreitz@redhat.com
Message-ID: <ce1622cf-7289-ca80-bdca-dc100a452f67@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 10/10] migration: Use JSON null
 instead of "" to reset parameter to default
References: <1500385286-21142-1-git-send-email-armbru@redhat.com>
 <1500385286-21142-11-git-send-email-armbru@redhat.com>
 <1aa2bff6-8798-cfd4-e969-b98064dd7d4c@redhat.com>
 <87d18xk2si.fsf@dusky.pond.sub.org>
 <d1f4e349-c312-9000-6dc3-d3fa46fce903@redhat.com>
 <87vampee1s.fsf@dusky.pond.sub.org>
In-Reply-To: <87vampee1s.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/18/2017 02:32 PM, Markus Armbruster wrote:
> What about:
>=20
> ##
> # @StrOrNull:
> #
> # This is a string value or the explicit lack of a string (null
> # pointer in C).  Intended for cases when 'optional absent' already
> # has a different meaning.
> #
> # @s: the string value
> # @n: no string value
> #
> # Since: 2.10
> ##

Works for me.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--mOjV8pPm9x3EDkCgwq2loUUWSCSK9w6Vq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlluZ8YACgkQp6FrSiUn
Q2pA9AgAqawjKjNLUwV4uM09EE8RUeY83pU3PUoB063iRTFMEl4k7X5RwZvNWvqv
EDHLA1xhfk2t2Q8iMcB5hgs8TNZ5cYn1pzJ+FadALfWAI4qm7EfiEsrJhvzDObUl
Qhn/fWfbpnnh5IbaXib7KZ0ZtJhjliNnpek7sQgmkzoeEQRLRYiiVdZw3oG/ruBS
MN/+aw5gw01Kvj8v04wkPu0aq7WQ0b4olOcV03br8LuZL6gq2vPtc2UT9m4++PR9
/Z0rzIvcrbbe4JEs9voDn2DZgv90NenUs51z1khtxyiZ1QTYhc0twFhxyLOdCA9N
t6IbZF8q5Euh2tCizoOgKHvEsG9eLw==
=imTZ
-----END PGP SIGNATURE-----

--mOjV8pPm9x3EDkCgwq2loUUWSCSK9w6Vq--
