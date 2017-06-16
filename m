Received: from eggs.gnu.org ([2001:4830:134:3::10]:37833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dLuGv-0006Yi-O5
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 12:38:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dLuGu-00049z-Oe
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 12:38:57 -0400
References: <20170613205726.13544-1-mreitz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <93df6700-6dd0-69a0-053e-a840a4bad2aa@redhat.com>
Date: Fri, 16 Jun 2017 18:38:49 +0200
MIME-Version: 1.0
In-Reply-To: <20170613205726.13544-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="9wFbtGHrLvP5kjOADlmatuTKVPNNK6aih"
Subject: Re: [Qemu-devel] [PATCH v2] block: Do not strcmp() with NULL
 uri->scheme
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9wFbtGHrLvP5kjOADlmatuTKVPNNK6aih
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <93df6700-6dd0-69a0-053e-a840a4bad2aa@redhat.com>
Subject: Re: [PATCH v2] block: Do not strcmp() with NULL uri->scheme
References: <20170613205726.13544-1-mreitz@redhat.com>
In-Reply-To: <20170613205726.13544-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-06-13 22:57, Max Reitz wrote:
> uri_parse(...)->scheme may be NULL. In fact, probably every field may b=
e
> NULL, and the callers do test this for all of the other fields but not
> for scheme (except for block/gluster.c; block/vxhs.c does not access
> that field at all).
>=20
> We can easily fix this by using g_strcmp0() instead of strcmp().
>=20
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
> v2:
> - Fix all affected block drivers, not just nfs [Peter]
> - Use g_strcmp0() [Markus]
> ---
>  block/nbd.c      | 6 +++---
>  block/nfs.c      | 2 +-
>  block/sheepdog.c | 6 +++---
>  block/ssh.c      | 2 +-
>  4 files changed, 8 insertions(+), 8 deletions(-)

Applied to my block tree:

https://github.com/XanClic/qemu/commits/block

Max


--9wFbtGHrLvP5kjOADlmatuTKVPNNK6aih
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZRAmaEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQCqu
B/9JEqyqcqrKhUb9EnC7hv3kyD4JqBOssI+XY+HgqfuyfUSDjcKZL8n96vs86BUF
bhPY9s7y2o0WaZBPc1T52VQSilHvD++NFSnWfZhJ2B7imZfB6ozfmSzXUBZxiKqr
QHVuGBZUbZZ4f8exg2GiR5o9dhvuyZUMEdOeGExxs60iwGAk+Lb6BbnXm3sdWakA
2IYXRaz6tsekJECkQDYY3vftges/NmGymyr/1THs5d6KTO4IAtzsw0pk0p0I5f37
13rwFyyV6BrQJ0EfrI2MLgtbiDVzE2gf8gRYg6lKy+dGLziypP+3OH7z4g883SfD
ip25uHc4Lhq8RJyouE/Qi2gq
=kD0B
-----END PGP SIGNATURE-----

--9wFbtGHrLvP5kjOADlmatuTKVPNNK6aih--
