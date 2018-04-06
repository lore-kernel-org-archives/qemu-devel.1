Received: from eggs.gnu.org ([2001:4830:134:3::10]:38203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f4TJt-00059B-Q2
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 11:30:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f4TJs-00026m-RP
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 11:30:29 -0400
References: <20180406151731.4285-1-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <af728288-9d73-4a78-8fd1-40e93f566eaf@redhat.com>
Date: Fri, 6 Apr 2018 10:30:17 -0500
MIME-Version: 1.0
In-Reply-To: <20180406151731.4285-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="rGlyx1rZDjpDVA0zfpkgIvhPs23o63Ygg"
Subject: Re: [Qemu-devel] [PATCH 0/2 for-2.12?] iotests: Skip 181 and 201
 without userfaultfd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rGlyx1rZDjpDVA0zfpkgIvhPs23o63Ygg
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Message-ID: <af728288-9d73-4a78-8fd1-40e93f566eaf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/2 for-2.12?] iotests: Skip 181 and 201
 without userfaultfd
References: <20180406151731.4285-1-mreitz@redhat.com>
In-Reply-To: <20180406151731.4285-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/06/2018 10:17 AM, Max Reitz wrote:
> My non-Fedora testing system does not have a kernel with userfaultfd
> support which causes 181 and 201 to fail.  That is annoying.  This
> series makes those tests recognize the issue and convert it into a
> _notrun.

As this is just testsuite fixes, is this worth including in 2.12?  Then
again, as we are now building for -rc3, missing the release merely means
tests fail, and not a broken binary.

>=20
>=20
> Max Reitz (2):
>   iotests: Add failure matching to common.qemu
>   iotests: Skip 181 and 201 without userfaultfd
>=20
>  tests/qemu-iotests/181         | 13 ++++++++++
>  tests/qemu-iotests/201         | 13 ++++++++++
>  tests/qemu-iotests/common.qemu | 58 ++++++++++++++++++++++++++++++++++=
+++-----
>  3 files changed, 77 insertions(+), 7 deletions(-)
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--rGlyx1rZDjpDVA0zfpkgIvhPs23o63Ygg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrHkokACgkQp6FrSiUn
Q2r0+Qf/d5B4pOliRW4caHsP9MrHBWjEnTSerbTGB4tbnPslkPu/Knv4d3zUYt99
q4Fb5ylj86tIylkRUUhwn0X9x3VTOr1wD81gEBC7yPjKl2IsdNFihX45Dk7OHe+N
7FAIbUeLwvsSh8SqcFZ0iIvPkdDhaG2L0c/7LnoE4+LwnhoVwmZ/XBSeMyJU5LgH
3eoOGyJ0FlG1IVC0+3W6Fn18taWq8ltScT2tuNWpWS4Nezm4LtGmigOdeV8UNT8X
X9szOVRkYrKHciVKULytXPDxnSt2IkgVNaSuUOwcWqij2fo46I5jvNzndVs/ZmPW
mqrMC7O2JLpttnwGIrHPQ0EXJGKXig==
=lv9Z
-----END PGP SIGNATURE-----

--rGlyx1rZDjpDVA0zfpkgIvhPs23o63Ygg--
