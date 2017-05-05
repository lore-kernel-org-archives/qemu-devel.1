Received: from eggs.gnu.org ([2001:4830:134:3::10]:51112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d6jbG-00051F-Ai
	for qemu-devel@nongnu.org; Fri, 05 May 2017 16:13:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d6jbF-0002e9-7Q
	for qemu-devel@nongnu.org; Fri, 05 May 2017 16:13:14 -0400
References: <20170504030755.1001-1-eblake@redhat.com>
	<20170504030755.1001-3-eblake@redhat.com>
	<53789feb-7a2d-09ae-cc03-8cde0b1b85e4@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c81a7c3e-5eae-5740-a600-53729fe8c6e7@redhat.com>
Date: Fri, 5 May 2017 15:13:04 -0500
MIME-Version: 1.0
In-Reply-To: <53789feb-7a2d-09ae-cc03-8cde0b1b85e4@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="CERWLmdnS8510MlSBfuFm3urpwqLaVfqI"
Subject: Re: [Qemu-devel] [PATCH v12 02/10] block: Update comments on
 BDRV_BLOCK_* meanings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CERWLmdnS8510MlSBfuFm3urpwqLaVfqI
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com
Message-ID: <c81a7c3e-5eae-5740-a600-53729fe8c6e7@redhat.com>
Subject: Re: [PATCH v12 02/10] block: Update comments on BDRV_BLOCK_* meanings
References: <20170504030755.1001-1-eblake@redhat.com>
 <20170504030755.1001-3-eblake@redhat.com>
 <53789feb-7a2d-09ae-cc03-8cde0b1b85e4@redhat.com>
In-Reply-To: <53789feb-7a2d-09ae-cc03-8cde0b1b85e4@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/05/2017 03:06 PM, Max Reitz wrote:
> On 04.05.2017 05:07, Eric Blake wrote:
>> We had some conflicting documentation: a nice 8-way table that
>> described all possible combinations of DATA, ZERO, and
>> OFFSET_VALID, contrasted with text that implied that OFFSET_VALID
>> always meant raw data could be read directly.  Furthermore, the
>> text refers a lot to bs->file, even though the interface was
>> updated back in 67a0fd2a to let the driver pass back which BDS (not
>> necessarily bs->file).
>=20
> Not sure about my English skills here, but is this missing a verb? ("to=

> pass back which BDS...")

maybe s/which/a specific/

>=20
>>                         As the 8-way table is the intended
>> semantics, simplify the rest of the text to get rid of the
>> confusion.
>>
>> ALLOCATED is always set by the block layer for convenience (drivers
>> do not have to worry about it). RAW is used only internally, but
>=20
> Just one space after the period? How inconsistent! :-)

But do commit messages really count?  :)


>> + * Internal flag:
>> + * BDRV_BLOCK_RAW: used internally to indicate that the request was
>> + *                 answered by a passthrough driver such as raw and t=
hat the
>=20
> s/passthrough/filter/? But I'm not even sure myself. Well, "passthrough=
"
> is a safe bet, so let's just go with it.

Calling 'raw' a filter driver is a bit weird - but in one sense, it is a
no-op filter (filter the protocol layer into the format layer by doing
nothing).  Meanwhile 'commit' certainly sounds like more of a filter
than a passthrough.  I could go either way, and filter is slightly
shorter.  If there's a real reason to respin the series, 'filter' seems
reasonable if we're worried about line length, otherwise I'm just as
inclined to leave it alone.

>=20
> With the commit message fixed or a =E2=80=9Cno it's fine=E2=80=9D:
>=20
> Reviewed-by: Max Reitz <mreitz@redhat.com>
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--CERWLmdnS8510MlSBfuFm3urpwqLaVfqI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZDNzQAAoJEKeha0olJ0NqUbQIAK8hRMN+Lcx9VUUlTLNEEZYQ
p8n1g1LkfaHuC82XKbPj22vkAMYBBkpiob3F5dVd1TabH9aO0K3MOomDitUul0Mv
suVPPP+47j8Vk4FOrayUxe1aYbEKoLmK0KjgpA5LDnepE7zKW9s/o07axTGglOfs
Ix5zxXaqWDU+VdJOV8HzonY9/UhaMc9dofi6aPWYck/5FZnoNJl5UsNx2aq2INMY
Ja2J8jN74dimr9n+If2smjPm8e9pfmZZrWB6wSOO3wod33PAvyjuPrXJJq9aTajt
vC7Zmm4zfs/0MlM9WAvo8DSAFefRvuBzS53bnJ8cJ/iEcN8pUq3noN03HHS6YKU=
=FUMC
-----END PGP SIGNATURE-----

--CERWLmdnS8510MlSBfuFm3urpwqLaVfqI--
