Received: from eggs.gnu.org ([2001:4830:134:3::10]:53065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dhcnO-0002Su-AV
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 10:26:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dhcnN-00027M-B1
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 10:26:14 -0400
References: <20170815130740.31229-1-famz@redhat.com>
	<20170815130740.31229-5-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c3b68551-4683-2564-f3f4-12e2049c05ba@redhat.com>
Date: Tue, 15 Aug 2017 09:26:03 -0500
MIME-Version: 1.0
In-Reply-To: <20170815130740.31229-5-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="LnVxcFPAqWp3GN6SwUT6In5LAKeu3DwiH"
Subject: Re: [Qemu-devel] [PATCH for-2.10 v2 4/4] iotests: Add non-shared
 storage migration case 192
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, stefanha@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LnVxcFPAqWp3GN6SwUT6In5LAKeu3DwiH
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 stefanha@redhat.com
Message-ID: <c3b68551-4683-2564-f3f4-12e2049c05ba@redhat.com>
Subject: Re: [PATCH for-2.10 v2 4/4] iotests: Add non-shared storage migration
 case 192
References: <20170815130740.31229-1-famz@redhat.com>
 <20170815130740.31229-5-famz@redhat.com>
In-Reply-To: <20170815130740.31229-5-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/15/2017 08:07 AM, Fam Zheng wrote:
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  tests/qemu-iotests/192     | 63 ++++++++++++++++++++++++++++++++++++++=
++++++++
>  tests/qemu-iotests/192.out |  7 ++++++
>  tests/qemu-iotests/group   |  1 +
>  3 files changed, 71 insertions(+)
>  create mode 100755 tests/qemu-iotests/192
>  create mode 100644 tests/qemu-iotests/192.out

I tested that this catches the changes made in both 2/4 (+Block node is
read-only) and 3/4 (+Conflicts with use by drive0 as 'root', which does
not allow 'write' on #block121) - so it looks like we've solved the issue=
=2E

Tested-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>

I'll take this series through my NBD tree, and send a pull request
shortly in time for -rc3

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--LnVxcFPAqWp3GN6SwUT6In5LAKeu3DwiH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmTBHsACgkQp6FrSiUn
Q2rC3Af/UZQKtoaPhaHmC4nLqZePt2AYVS9V65d+OfRYA9DhZtUW/pRbwvcUmpUD
Bfkr1lTDwFburAMeKDVJUMq9lHyhzADj7vLJmnjtGU5mr0sxRQRhl1Ks3woQFZNv
p6fusiho64Yg4vll3/+olpY3vMJYLE5zjhCAWz9kbjD/VFWe2jH5bzaXGn68UqSe
Q9XrpI5zEYidtmphfQhsfXfOQS6hAKkjQXikJ7Ic2yjf1Aw+I9km6Sm+RZHhFzwO
JD7iiedHnIx2fEzdGQGBsSAsByipTO5Po9cvl65L8/KoPCTnaeixFHGPKoU5NHHo
CfzI9QnyBwKkkW0k6pGXZAoZKFK0hQ==
=g9W8
-----END PGP SIGNATURE-----

--LnVxcFPAqWp3GN6SwUT6In5LAKeu3DwiH--
