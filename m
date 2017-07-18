Received: from eggs.gnu.org ([2001:4830:134:3::10]:49415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXUBV-0000Rn-QU
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 11:13:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXUBU-0006do-IV
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 11:13:13 -0400
References: <1500385286-21142-1-git-send-email-armbru@redhat.com>
	<1500385286-21142-5-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ff50d192-2dbf-b990-1f9a-c1bb9aa79cac@redhat.com>
Date: Tue, 18 Jul 2017 10:13:03 -0500
MIME-Version: 1.0
In-Reply-To: <1500385286-21142-5-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="gPPapGBSFTso4R7v1MQleanUB4REpdAC4"
Subject: Re: [Qemu-devel] [PATCH for-2.10 04/10]
 tests/test-qobject-input-visitor: Drop redundant test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, quintela@redhat.com, dgilbert@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gPPapGBSFTso4R7v1MQleanUB4REpdAC4
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, kwolf@redhat.com, mreitz@redhat.com,
 qemu-block@nongnu.org, quintela@redhat.com, dgilbert@redhat.com
Message-ID: <ff50d192-2dbf-b990-1f9a-c1bb9aa79cac@redhat.com>
Subject: Re: [PATCH for-2.10 04/10] tests/test-qobject-input-visitor: Drop
 redundant test
References: <1500385286-21142-1-git-send-email-armbru@redhat.com>
 <1500385286-21142-5-git-send-email-armbru@redhat.com>
In-Reply-To: <1500385286-21142-5-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/18/2017 08:41 AM, Markus Armbruster wrote:
> test_visitor_in_alternate() tests UserDefAlternate with inadmissible
> input.  test_visitor_in_fail_alternate() does basically the same.
> Drop the former, keep the latter.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  tests/test-qobject-input-visitor.c | 6 ------
>  1 file changed, 6 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--gPPapGBSFTso4R7v1MQleanUB4REpdAC4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlluJYAACgkQp6FrSiUn
Q2q5FQf+P7Yhu1I1yryJO3dFufqdcVzJyXorpCSNkAv8jUjEGD5G2H9ZTj81qJcd
4h/O1fUpqVd7XlSAZU6z7ZOK3F/4nH5x9ZV09ZYPU3YQW65hMkTR+SXjL1M+TI2j
22hFzzqoJ6UN4+OFgxQCVh8DTJYGQYuMwPSEa67z95fLlL1E9RNqk/fiE3oJ679s
owNpAdjhc8eM7f5al9YznMACueRjI6OzN/K3ILnF8pr9gy5/9CKk4dqWk7WrLfYr
tlrzeX1E4LP1ypkZQqoyCzx4HlCBDcqGzuru9x74I+EysPS1sF/jqKTSYQDdbu+w
6Vun/9kxL7pcOOB54j5rGtYQ5YJdGw==
=VMfW
-----END PGP SIGNATURE-----

--gPPapGBSFTso4R7v1MQleanUB4REpdAC4--
