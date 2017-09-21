Received: from eggs.gnu.org ([2001:4830:134:3::10]:32795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dv1eP-0005zx-DN
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 09:36:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dv1eM-0005ZQ-Ag
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 09:36:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60958)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dv1eM-0005Yy-0v
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 09:36:18 -0400
References: <20170920032555.18911-1-famz@redhat.com>
	<20170920032555.18911-4-famz@redhat.com>
	<91d27127-b1ba-0922-7d08-44782d277501@redhat.com>
	<20170921004534.GC13703@lemon.lan>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cdab43d5-642a-b7fc-fdcc-ef00ba2582ff@redhat.com>
Date: Thu, 21 Sep 2017 08:36:07 -0500
MIME-Version: 1.0
In-Reply-To: <20170921004534.GC13703@lemon.lan>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="gxNqojfu7CKDhifuwpwFpwIKaEcMQ9fRA"
Subject: Re: [Qemu-devel] [PATCH v10 03/13] scripts: Add archive-source.sh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, pbonzini@redhat.com, Kamil Rytarowski <kamil@netbsd.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gxNqojfu7CKDhifuwpwFpwIKaEcMQ9fRA
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Peter Maydell <peter.maydell@linaro.org>, stefanha@redhat.com,
 Cleber Rosa <crosa@redhat.com>, pbonzini@redhat.com,
 Kamil Rytarowski <kamil@netbsd.org>
Message-ID: <cdab43d5-642a-b7fc-fdcc-ef00ba2582ff@redhat.com>
Subject: Re: [PATCH v10 03/13] scripts: Add archive-source.sh
References: <20170920032555.18911-1-famz@redhat.com>
 <20170920032555.18911-4-famz@redhat.com>
 <91d27127-b1ba-0922-7d08-44782d277501@redhat.com>
 <20170921004534.GC13703@lemon.lan>
In-Reply-To: <20170921004534.GC13703@lemon.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/20/2017 07:45 PM, Fam Zheng wrote:
>>
>> has a flaw that $? is no longer what you want, at which point you woul=
d
>> have to introduce a temporary variable.  But we're using bash, so you
>> can instead write this as:
>>
>> if test "${PIPESTATUS[@]}" !=3D "0 0"; then
>=20
> Hmm, with exactly this line here I get something like:
>=20
> ./scripts/archive-source.sh: line 36: test: too many arguments

D'oh - [@] causes word splitting (same as "$@"); we want [*] instead:

if test "${PIPESTATUS[*]}" !=3D "0 0";

>=20
> But with
>=20
>     if test "${PIPESTATUS[0]} ${PIPESTATUS[1]}" !=3D "0 0"; then

or that's a manual way of spelling the auto-array-concatenation that you
get with [*].

>=20
> it seems to work fine. What is the magic here?
>=20
> Fam
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--gxNqojfu7CKDhifuwpwFpwIKaEcMQ9fRA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEyBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnDwEcACgkQp6FrSiUn
Q2rzgQf2MTv0Zv5T+Xo+BNEPpSV5oNBpNNaR3UUzbYzM4OEBHi8vkkvPJL5HTSD7
wg3sZ0ILmtOhresL9hCbH52Ju1bsoWCWU7EvMAoLiR3IXKCuEbgBHUp1KJDSv8yb
iNx5SOYmqnFjkT9p1NWMhUZ5MkWaaEiNHgqF0DETYwALMQuYAdWAFNoqRBAROuu6
i2QDGj81jeuTWRmKz+qSUrsTdTBn5JZNFo9xr++TT+Ta9WH4qbacnCchGTurrrwc
AGLg7/VDPtCiwlvtA+HPNnPLbgA/OoSs/8Vru8pWJFQM6Q+4thNsAnzPqoqCFGld
x5e6XzlEmL4tZAl4HhjzJ71xqLdn
=InLw
-----END PGP SIGNATURE-----

--gxNqojfu7CKDhifuwpwFpwIKaEcMQ9fRA--
