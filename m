Received: from eggs.gnu.org ([2001:4830:134:3::10]:43086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVKQG-00041q-58
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 12:23:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVKQF-0005Oc-A0
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 12:23:32 -0400
References: <1499864249-26305-1-git-send-email-kwolf@redhat.com>
	<1499864249-26305-10-git-send-email-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <21ed5d4f-63e9-8de4-d854-c02d284fef10@redhat.com>
Date: Wed, 12 Jul 2017 11:23:22 -0500
MIME-Version: 1.0
In-Reply-To: <1499864249-26305-10-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="oGW4pkN38nAbuHuMRMHw2Vq9J9G6KQlua"
Subject: Re: [Qemu-devel] [PATCH 9/9] qemu-iotests: Test unplug of -device
 without drive
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, jsnow@redhat.com, pbonzini@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oGW4pkN38nAbuHuMRMHw2Vq9J9G6KQlua
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, jsnow@redhat.com, pbonzini@redhat.com,
 armbru@redhat.com, qemu-devel@nongnu.org
Message-ID: <21ed5d4f-63e9-8de4-d854-c02d284fef10@redhat.com>
Subject: Re: [PATCH 9/9] qemu-iotests: Test unplug of -device without drive
References: <1499864249-26305-1-git-send-email-kwolf@redhat.com>
 <1499864249-26305-10-git-send-email-kwolf@redhat.com>
In-Reply-To: <1499864249-26305-10-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/12/2017 07:57 AM, Kevin Wolf wrote:
> This caused an assertion failure until recently because the BlockBacken=
d
> would be detached on unplug, but was in fact never attached in the firs=
t
> place. Add a regression test.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qemu-iotests/067     | 13 +++++++++++++
>  tests/qemu-iotests/067.out | 39 ++++++++++++++++++++++++++++++++++++++=
+
>  2 files changed, 52 insertions(+)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--oGW4pkN38nAbuHuMRMHw2Vq9J9G6KQlua
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZZkz6AAoJEKeha0olJ0Nq6LcIAJgbplDp5K1j13Y4u+dIr9UI
we5pzyd+l/GJGU2aHnUD/zro6S5hdEIWjzleJYMFXiHP2s2VwmGLIT9FXqip5LhO
IKJerve7hIO3xE1PL4Np3H3norvUMln20Y+sS3sWhb29rTIOX/qa1CwyxZ0bheAd
JGTRZ4kjCvr9+jKfHcyrPfwDybHn7AwMN0+u7mC2AoihSFtyHJKXmGLtFhFSa24y
rmejKqRfYzW7+9HI1VcB0hJ++FfJ41NaJ+Iyvf5UeuSh/noEYzIirnMTtNevyTp5
abXstUpyR0JZyZXypmXayBxTS9/RXG78dAwrGupFf/fSeJa0ggMz5CLCaHwyCYM=
=A1uM
-----END PGP SIGNATURE-----

--oGW4pkN38nAbuHuMRMHw2Vq9J9G6KQlua--
