Received: from eggs.gnu.org ([2001:4830:134:3::10]:59439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dmM5z-0000wq-53
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 11:37:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dmM5u-0006RP-W3
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 11:36:59 -0400
References: <1503916557-1292-1-git-send-email-thuth@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <facb59b4-6992-b7a5-7d63-bead2ff29f8a@redhat.com>
Date: Mon, 28 Aug 2017 10:36:51 -0500
MIME-Version: 1.0
In-Reply-To: <1503916557-1292-1-git-send-email-thuth@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="TpvhGFtdWxow6geKGk5CpoJIlSbXLjq6d"
Subject: Re: [Qemu-devel] [PATCH] tests/libqtest: Use a proper error message
 if QTEST_QEMU_BINARY is missing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TpvhGFtdWxow6geKGk5CpoJIlSbXLjq6d
From: Eric Blake <eblake@redhat.com>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>
Message-ID: <facb59b4-6992-b7a5-7d63-bead2ff29f8a@redhat.com>
Subject: Re: [PATCH] tests/libqtest: Use a proper error message if
 QTEST_QEMU_BINARY is missing
References: <1503916557-1292-1-git-send-email-thuth@redhat.com>
In-Reply-To: <1503916557-1292-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/28/2017 05:35 AM, Thomas Huth wrote:
> The user can currently still cause an abort() if running certain tests
> (like the prom-env-test) without setting the QTEST_QEMU_BINARY first.
> A similar problem has been fixed with commit 7c933ad61b8f3f51337
> already, but forgot to also take care of the qtest_get_arch() function,=

> so let's introduce a proper wrapper around getenv("QTEST_QEMU_BINARY")
> that can be used in both locations now.
>=20
> Buglink: https://bugs.launchpad.net/qemu/+bug/1713434
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/libqtest.c | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--TpvhGFtdWxow6geKGk5CpoJIlSbXLjq6d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmkOJMACgkQp6FrSiUn
Q2pp5Qf/aaaROzOvc8KVAnuiZWmN2vhbP63BujduyfcaCb/DBiCrmdZudEy7/0hW
0rpn6scil7E8zaP8NvP7atIrJR+hZHy6vsk3aZjySM4okD1Ftb9VFT3Hc9XPaW8F
RmChnSqfF0P8Z6BPyvr/prJzo1NZI/vmqNbEK2gt+qqNiundHFZOAwrYDRd09pqb
1Pmm8jcS8z8yMA2EfpTFiKwLduRlUAYPOEWse+DE7hbCIMbEarMaHQS8MN/d6wdD
nx6QwqnPpj25SgHJwLc2sw9+Kt2yeKo3ejPf7WXtyMKMLbLjrGWxmHW14SXwqmvN
To9XoEN2xz8/TPEXRzjWf9mTJbS01A==
=lHWA
-----END PGP SIGNATURE-----

--TpvhGFtdWxow6geKGk5CpoJIlSbXLjq6d--
