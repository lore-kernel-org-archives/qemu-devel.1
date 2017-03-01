Received: from eggs.gnu.org ([2001:4830:134:3::10]:56655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ciu9f-0004yo-RI
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 21:38:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ciu9f-0001az-0m
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 21:38:15 -0500
References: <20170228105521.1284.11059.stgit@PASHA-ISP>
	<20170228105527.1284.44425.stgit@PASHA-ISP>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3ba92606-7d69-603e-7b24-3381314463b4@redhat.com>
Date: Tue, 28 Feb 2017 20:00:19 -0600
MIME-Version: 1.0
In-Reply-To: <20170228105527.1284.44425.stgit@PASHA-ISP>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nD9kgiBH9JL2AV2PFVktc7m12gJ8GM3FR"
Subject: Re: [Qemu-devel] [PATCH v2 1/3] block: implement bdrv_snapshot_goto
 for blkreplay
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, pbonzini@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nD9kgiBH9JL2AV2PFVktc7m12gJ8GM3FR
From: Eric Blake <eblake@redhat.com>
To: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, pbonzini@redhat.com, dovgaluk@ispras.ru,
 qemu-block@nongnu.org, mreitz@redhat.com
Message-ID: <3ba92606-7d69-603e-7b24-3381314463b4@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/3] block: implement bdrv_snapshot_goto
 for blkreplay
References: <20170228105521.1284.11059.stgit@PASHA-ISP>
 <20170228105527.1284.44425.stgit@PASHA-ISP>
In-Reply-To: <20170228105527.1284.44425.stgit@PASHA-ISP>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/28/2017 04:55 AM, Pavel Dovgalyuk wrote:

[meta-comment]

> This patch enables making snapshots with blkreplay used in
> block devices.
> This function is required to make bdrv_snapshot_goto without
> calling .bdrv_open which is not implemented.
>=20
> v2: updated commit message

The v2 information...

>=20
> Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
> ---

=2E..fits best here. Anything after the --- is stripped by 'git am',
making it ideal for information that is useful to the reviewers but not
important to a long-term reader (a year from now, we won't care if it
was v2 or v10 that was committed, because git only stores the version
that was checked in, and not the iterations prior to it).

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--nD9kgiBH9JL2AV2PFVktc7m12gJ8GM3FR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYtiszAAoJEKeha0olJ0NqaYQH/2J6IttOt3syeWzH/fT1OwMx
2SHxHQaJ9Ey35UGia+EknR+0Nls7ECfJEwt9tIsCrRvWcOit7czgYYPuPNdV9kRY
y+HCF+O34EPyQ0lePyPmdd6I+V9YaaM4kGqEq41lNvdnR478KCJIohenVQ3sIAyj
S5N/5/HK88Yg6m7oMt5G2MK4mAC1QMDWbco2FdyswgIlPDhr6wEzcAcQqinu9BKb
iAAzqDV9fdh0bYEzxx7V2gS1W3DGWvpp5iVlYMCZTEC/T8j5Eo7b0PL6Wo+86Ivh
9RXwDbUYlVQOIdQqOblyK0M9LkARd9ISJRJm/9+zq1/TxB48UX3xbvf5Pqx8SEg=
=XySf
-----END PGP SIGNATURE-----

--nD9kgiBH9JL2AV2PFVktc7m12gJ8GM3FR--
