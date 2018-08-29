Received: from eggs.gnu.org ([2001:4830:134:3::10]:43222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fuyrO-00027v-Bz
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 07:42:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fuyiz-0004Wv-Ed
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 07:33:26 -0400
References: <cover.1535291602.git.berto@igalia.com>
	<599f98e81407a82d8b05764eeac7dbcf5f52142d.1535291602.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <8530786e-50b2-3dc2-2f1c-834ccd163b3a@redhat.com>
Date: Wed, 29 Aug 2018 13:33:13 +0200
MIME-Version: 1.0
In-Reply-To: <599f98e81407a82d8b05764eeac7dbcf5f52142d.1535291602.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ku80OT2eS7IEH847tduSYAmXWiM1CBJPV"
Subject: Re: [Qemu-devel] [PATCH 6/9] file-posix: Forbid trying to change
 unsupported options during reopen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ku80OT2eS7IEH847tduSYAmXWiM1CBJPV
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <8530786e-50b2-3dc2-2f1c-834ccd163b3a@redhat.com>
Subject: Re: [PATCH 6/9] file-posix: Forbid trying to change unsupported
 options during reopen
References: <cover.1535291602.git.berto@igalia.com>
 <599f98e81407a82d8b05764eeac7dbcf5f52142d.1535291602.git.berto@igalia.com>
In-Reply-To: <599f98e81407a82d8b05764eeac7dbcf5f52142d.1535291602.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-26 16:09, Alberto Garcia wrote:
> The file-posix code is used for the "file", "host_device" and
> "host_cdrom" drivers, and it allows reopening images. However the only
> option that is actually processed is "x-check-cache-dropped", and
> changes in all other options (e.g. "filename") are silently ignored:
>=20
>    (qemu) qemu-io virtio0 "reopen -o file.filename=3Dno-such-file"
>=20
> While we could allow changing some of the other options, let's keep
> things as they are for now but return an error if the user tries to
> change any of them.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/file-posix.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

Looks OK, but the same question from the last patch arises.  If
unspecified options mean using the default, shouldn't the user have to
re-specify all mandatory options, so at least @filename in this case?

Max


--ku80OT2eS7IEH847tduSYAmXWiM1CBJPV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluGhHkACgkQ9AfbAGHV
z0ASSQf/c806QvCH7TrT5XXD15lhn0YTQykKkrDD9prRyJjsnq9IKpda+YBw538u
qNLS6xWkxpce7EfkJLH5PZAB1YILj9MatDn9iE6wXQaLYSrkv62wCPRNb6l4EkTY
gwE9CubFTLVzWXieGzGbeBPoSN+BTTf5x+aAaBwydSNr2CpejBqnGf7c2OvmOtqp
JStxwoXL5dipgMoqeU8uJ31tFwkfDhGJmpbdSuzQwN2GcGOu+iTSVzItkF34A7zM
BYNrAfCeEnoWn9eYiFh4h/+rZtCQ3GAgnh3G23jQ28umJmX+K/FnUcv/60MyPq+O
F1wMpc4ImfUUJJgWXts1NPeifubMtg==
=t1sS
-----END PGP SIGNATURE-----

--ku80OT2eS7IEH847tduSYAmXWiM1CBJPV--
