Received: from eggs.gnu.org ([2001:4830:134:3::10]:51075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ciRHE-00016T-VV
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 14:48:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ciRHD-00007n-OY
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 14:48:09 -0500
References: <87bmukmlau.fsf@dusky.pond.sub.org>
	<87poi4c4jd.fsf@dusky.pond.sub.org>
	<20170227105704.GB6356@noname.redhat.com>
	<87innvhi1j.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <97fd5714-e51b-5786-9576-47614e7a4351@redhat.com>
Date: Mon, 27 Feb 2017 13:47:59 -0600
MIME-Version: 1.0
In-Reply-To: <87innvhi1j.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="T5JLrWjnBExAWHebNoO1u5wp4INiEWCc9"
Subject: Re: [Qemu-devel] Non-flat command line option argument syntax
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: Peter Krempa <pkrempa@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--T5JLrWjnBExAWHebNoO1u5wp4INiEWCc9
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: Peter Krempa <pkrempa@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Message-ID: <97fd5714-e51b-5786-9576-47614e7a4351@redhat.com>
Subject: Re: [Qemu-devel] Non-flat command line option argument syntax
References: <87bmukmlau.fsf@dusky.pond.sub.org>
 <87poi4c4jd.fsf@dusky.pond.sub.org> <20170227105704.GB6356@noname.redhat.com>
 <87innvhi1j.fsf@dusky.pond.sub.org>
In-Reply-To: <87innvhi1j.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/27/2017 07:36 AM, Markus Armbruster wrote:

>=20
>>                  Maybe just 'foo.array[]' (without any =3D) for an emp=
ty
>> array or something like that.
>=20
> Yes, that should do.  Likewise foo.object{} for empty object.
>=20
> {} doesn't even need quoting.  [] may.

[contents] needs quoting, but [] does NOT need shell quoting (no shells
treat it as a glob), for the same reason that 'if [ -e "$file" ];' needs
no quoting around the [ or ] (the shell only requires quotes for [ if
the rest of the shell word can look like a valid glob, but globs require
intermediate content before the ]).

>> Before we introduce anything like this, do we actually need it?
>=20
> I don't know whether anything needs optional, present and empty.  But
> even if the answer is "no" today, it need not remain "no".
>=20
> Anyone running into a case of "yes", will have to fall back to the JSON=

> form of -blockdev.  Strengthens my belief that providing JSON there is =
a
> good idea.
>=20
> The insufficient generality of dotted keys bugs me a bit.  Not sure
> whether it justifies more syntax now.  But we should document it.

I agree that documenting it as a shortcoming of dotted form and pointing
to JSON form is okay.  I also like that we are leaving the door open for
future expansion, if needed, and think that is better than inventing the
syntax now, especially for what we are trying to get into 2.9.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--T5JLrWjnBExAWHebNoO1u5wp4INiEWCc9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYtIJvAAoJEKeha0olJ0NqwIMIAKHVGQFemE85Ekjcky+UKbl2
ZodaHv5Q3hBMN1RrhLHsXnjdBy//9szp+aJey7wQyRpq5UWROvfOnTtRXeyh4Q1r
iusFHmJqBLA6WZRNGqhMaDNOSku/4ijVlmdtUa+AzObPyyTJx0z7LSt+3FE4eaLU
3Ic7rZFVDql82TqgJbUBzTk44wgA1YAfx6JlNZEQ5SQ36/gACpZH/fnyEwPvx+1S
LByHxrUl+6n3m0CjPz7S9cbScG7pHi8u1BySVhfnfebtJZiXNH1edX6IBs+xLIux
igSxN82RpW9gk/KzZhriUbEM10UC01G2YdKVv/kpHnegbstXNzx/xwxXTTpc4pk=
=z+Y+
-----END PGP SIGNATURE-----

--T5JLrWjnBExAWHebNoO1u5wp4INiEWCc9--
