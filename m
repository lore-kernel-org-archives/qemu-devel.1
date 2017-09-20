Received: from eggs.gnu.org ([2001:4830:134:3::10]:49768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dulOx-00067q-GH
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 16:15:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dulOu-0000cy-Au
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 16:15:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51496)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dulOu-0000c0-14
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 16:15:16 -0400
References: <20170920032555.18911-1-famz@redhat.com>
	<20170920032555.18911-8-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <642c8291-6be7-88a4-de74-31da51dcc1ef@redhat.com>
Date: Wed, 20 Sep 2017 15:15:01 -0500
MIME-Version: 1.0
In-Reply-To: <20170920032555.18911-8-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="PSInQbfe7jMQHOMLweLwN1hE13fAfmdf0"
Subject: Re: [Qemu-devel] [PATCH v10 07/13] tests: Add FreeBSD image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, pbonzini@redhat.com, Kamil Rytarowski <kamil@netbsd.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PSInQbfe7jMQHOMLweLwN1hE13fAfmdf0
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>,
 stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, pbonzini@redhat.com,
 Kamil Rytarowski <kamil@netbsd.org>
Message-ID: <642c8291-6be7-88a4-de74-31da51dcc1ef@redhat.com>
Subject: Re: [PATCH v10 07/13] tests: Add FreeBSD image
References: <20170920032555.18911-1-famz@redhat.com>
 <20170920032555.18911-8-famz@redhat.com>
In-Reply-To: <20170920032555.18911-8-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/19/2017 10:25 PM, Fam Zheng wrote:
> The image is prepared following instructions as in:
>=20
> https://wiki.qemu.org/Hosts/BSD
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  tests/vm/freebsd | 42 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100755 tests/vm/freebsd
>=20

While testing v10, I got:

$ make vm-build-freebsd
=2E..
    VM-BUILD freebsd
=2E/scripts/archive-source.sh: line 48: test: -ne: unary operator expecte=
d
ar: warning: creating libfdt/libfdt.a

At least the archive-source.sh warning is part of your series, and worth
fixing.


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--PSInQbfe7jMQHOMLweLwN1hE13fAfmdf0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnCzEYACgkQp6FrSiUn
Q2pWNgf+K6aOoYdVfkXWaSa18pLN/YPG+45ptdiFyP556iA6LHqtaEUN575CsRAU
nLvZPL9X4bLJoFwxT6wbCyTMVLcsDAnZ0TSX5kPbZorCpZ9yox6YlWszjY5tkqU1
oTeYeuNlAq2Q5cFn78p6rQzOa+iQsM5kTkVug1jKGoc4AQTxiPJduOOP2U6632AI
SEp79VDTx1aoTNQgfzZjjJthLDVtFETIt1XPmCCVu77OKK/tM01Xx6F92cY7R/hz
6A0oWO6cOTwor1kPl0kK3/19H0LC/5xHEZC7RMEYeIuqUPnFIX0tE8uzT1tc/JgS
O7UMn82CO5Ob+9iPS64pRvM0bgGNsA==
=Yh5h
-----END PGP SIGNATURE-----

--PSInQbfe7jMQHOMLweLwN1hE13fAfmdf0--
