Received: from eggs.gnu.org ([2001:4830:134:3::10]:48586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eEgzu-0004nt-OQ
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 14:35:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eEgzt-0005LV-QF
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 14:35:50 -0500
References: <20171114180128.17076-1-mreitz@redhat.com>
	<20171114180128.17076-7-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0e5f02a3-6482-a49d-5e3c-cc51868056dc@redhat.com>
Date: Tue, 14 Nov 2017 13:35:37 -0600
MIME-Version: 1.0
In-Reply-To: <20171114180128.17076-7-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="avXQp28fuveKio2k1ne5K4Q6sr0aWxUR9"
Subject: Re: [Qemu-devel] [PATCH for-2.11? v7 6/6] tests: Add check-qobject
 for equality tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--avXQp28fuveKio2k1ne5K4Q6sr0aWxUR9
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <0e5f02a3-6482-a49d-5e3c-cc51868056dc@redhat.com>
Subject: Re: [PATCH for-2.11? v7 6/6] tests: Add check-qobject for equality
 tests
References: <20171114180128.17076-1-mreitz@redhat.com>
 <20171114180128.17076-7-mreitz@redhat.com>
In-Reply-To: <20171114180128.17076-7-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/14/2017 12:01 PM, Max Reitz wrote:
> Add a new test file (check-qobject.c) for unit tests that concern
> QObjects as a whole.
>=20
> Its only purpose for now is to test the qobject_is_equal() function.
>=20

> + * Note that qobject_is_equal() is not really an equivalence relation,=

> + * so this function may not be used for all objects (reflexivity is
> + * not guaranteed, e.g. in the case of a QNum containing NaN).
> + *
> + * The @_ argument is required because a boolean may not be the last
> + * argument before a variadic argument list (C11 7.16.1.4 para. 4).

C99 7.15.1.4 (did C11 add a section? /me goes and looks... Oh, it did.)

Okay, so it's not a typo after all.  Ignore my comment in the cover
letter, and

Reviewed-by: Eric Blake <eblake@redhat.com>

(And soon, I'll have to start quoting C17 instead of C99 or C11...)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--avXQp28fuveKio2k1ne5K4Q6sr0aWxUR9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloLRYkACgkQp6FrSiUn
Q2p2+QgAre17mqAaWfnL05kaNqI5UK5xTCdfqRPcv/lvZyz8kx253/RZZqAELC+K
1lq/uiNtQubFzswXaJRvTjnJwFRZwMmDhw+V6v5b0EgeHJki1F5EQmP52jLvg5zy
oRRfyIKCTSZzljhyrLprNcc0SNZqXuZkRPOJagZE6i8bnDO8ptoAOpmwXosH9GXj
B20ehp2wq6+/8qhtzM8N8iUrlkNWDKPXKgnxrmWhxqSQ1R0fdiY39bdYcGPCgDiH
aKuGY+n0rEukgrTJTlu7LMfa98Exa17wlU+yLooa+c9RS6EbbAHwwsB/0yttx1Oz
wj3K4EyiLdy4/nkU3G83NVcGbbcCdA==
=d7bp
-----END PGP SIGNATURE-----

--avXQp28fuveKio2k1ne5K4Q6sr0aWxUR9--
