Received: from eggs.gnu.org ([2001:4830:134:3::10]:52501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dG2gJ-0008AJ-QM
	for qemu-devel@nongnu.org; Wed, 31 May 2017 08:24:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dG2gE-0006K3-2w
	for qemu-devel@nongnu.org; Wed, 31 May 2017 08:24:55 -0400
Date: Wed, 31 May 2017 13:24:20 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170531122420.GF16733@stefanha-x1.localdomain>
References: <1495830130-30611-1-git-send-email-kwolf@redhat.com>
	<1495830130-30611-6-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wtjvnLv0o8UUzur2"
Content-Disposition: inline
In-Reply-To: <1495830130-30611-6-git-send-email-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 05/29] qed: Remove callback
 from qed_find_cluster()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, pbonzini@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com, mreitz@redhat.com


--wtjvnLv0o8UUzur2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 26, 2017 at 10:21:46PM +0200, Kevin Wolf wrote:
> diff --git a/block/qed.c b/block/qed.c
> index a837a28..031bb0a 100644
> --- a/block/qed.c
> +++ b/block/qed.c
> @@ -776,14 +776,14 @@ static int64_t coroutine_fn bdrv_qed_co_get_block_s=
tatus(BlockDriverState *bs,
>          .file =3D file,
>      };
>      QEDRequest request =3D { .l2_table =3D NULL };
> +    uint64_t offset;
> +    int ret;
> =20
> -    qed_find_cluster(s, &request, cb.pos, len, qed_is_allocated_cb, &cb);
> +    ret =3D qed_find_cluster(s, &request, cb.pos, &len, &offset);
> +    qed_is_allocated_cb(&cb, ret, offset, len);

qed_is_allocated_cb() used to be called within qed_acquire/release().
Now it's not?

--wtjvnLv0o8UUzur2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZLrX0AAoJEJykq7OBq3PIkosH/2ieBgGFzEOGvOvdvGSQKSJC
qDlPfvH/HNKZlRGsKyfmyQ3KVr/5MWtxLOXti3btVR+HeMXTlKjkJOxHW8qhxQus
tX4qRKFZNwfdZtBcjlc9ARyeJoFSldRhRuS31p9tsXdDrRXKqh8b66BtWfaJjHfR
zMlmoPtrR2/2BetKjIOAdwqXnI7d/vC4nnjG+JhNsr8dsbHXo2uHr9yOhGmP5D9l
0oicid/5foLNNfT33sIIGXP7KF0lLyMKlazzd/jgvvAoaKVtvA/9cg2DudspJ6CN
7m8Emr4MB9EB9FgDoUi1Xdn9ou44vrAC3IHn62NDN9uzIlzQzSMarrRd5qdFGrM=
=7XIm
-----END PGP SIGNATURE-----

--wtjvnLv0o8UUzur2--
