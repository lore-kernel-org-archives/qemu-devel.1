Received: from eggs.gnu.org ([2001:4830:134:3::10]:41824)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYI3b-0003s4-Ei
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 16:28:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYI3a-00066r-IC
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 16:28:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59118)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dYI3a-00066c-8d
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 16:28:22 -0400
References: <20170714190827.4083-1-eblake@redhat.com>
	<20170714190827.4083-4-eblake@redhat.com>
	<87fudrmnqt.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8eb99e9b-4560-4f52-e994-65a1cfa63388@redhat.com>
Date: Thu, 20 Jul 2017 15:28:20 -0500
MIME-Version: 1.0
In-Reply-To: <87fudrmnqt.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="J1j9ERwLJ8RSvPn7bSnM6vdu56fna5nFA"
Subject: Re: [Qemu-devel] [PATCH 3/5] qapi: Visitor documentation tweak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--J1j9ERwLJ8RSvPn7bSnM6vdu56fna5nFA
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>
Message-ID: <8eb99e9b-4560-4f52-e994-65a1cfa63388@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/5] qapi: Visitor documentation tweak
References: <20170714190827.4083-1-eblake@redhat.com>
 <20170714190827.4083-4-eblake@redhat.com> <87fudrmnqt.fsf@dusky.pond.sub.org>
In-Reply-To: <87fudrmnqt.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/20/2017 05:00 AM, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
>=20
>> Make it clear that the name parameter to visit_start_struct()
>> has the same semantics as for visit_start_int().
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---

>> + * The @name parameter of visit_type_FOO() and visit_start_OBJECT()
>=20
> Our terminology is horrible:
>=20
>     JSON object / QDict   / QAPI complex type (struct or union)
>     JSON array  / QList   / QAPI array or list (used interchangeably)
>     JSON value  / QObject / QAPI I'm-not-even-sure-what
>=20
> Because of this mess, nobody knows what you mean when you say OBJECT.
>=20
> visit_start_BAR()?

Works for me.

> Reviewed-by: Markus Armbruster <armbru@redhat.com>

Since you suggested it, I'll keep your R-b when I send v2.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--J1j9ERwLJ8RSvPn7bSnM6vdu56fna5nFA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAllxEmQACgkQp6FrSiUn
Q2ryhAf+JJnaJLGauXrnnwxGm6QlJJU//d+pl9EsytmqXQFt0ZV10XgX26BpixJJ
U7AfXqvq0pHljM1MzMK1xb9t46lT6zsjZvueGqTRH+4BFEnWBnVgTmkEvkEWdqTf
9iGfeze/0PVjzoNLSbUJN2Rw+qXquzAkgh5BiRrj2lhjjfs4RZnBO7xZiG3wpI+M
7T8xgmA/+omLG1l7VXGqSTzIlceuSK4r/H/YrNuV2Y80Hzs4Lsx9XMj26ISlcP8F
9fwmGNYBqYHvwjcJC3GeHMeKWhM2Lcc6tsseNKC/phNX6bBqfUnoX6sCfpramBCP
vst15JIVE9ar6BjjobPFZRZcgOV3sg==
=BS+d
-----END PGP SIGNATURE-----

--J1j9ERwLJ8RSvPn7bSnM6vdu56fna5nFA--
