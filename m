Received: from eggs.gnu.org ([2001:4830:134:3::10]:36452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g0ZgC-0006jB-84
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 18:01:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g0Zfs-0005eV-0A
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 18:01:32 -0400
References: <20180913125217.23173-1-kwolf@redhat.com>
	<20180913125217.23173-15-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <70daa940-8bf8-39f0-faac-54bb7d88061b@redhat.com>
Date: Thu, 13 Sep 2018 23:55:59 +0200
MIME-Version: 1.0
In-Reply-To: <20180913125217.23173-15-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="eXcB9ug9RElyPKMvnHJkA3xhs54MGrDi5"
Subject: Re: [Qemu-devel] [PATCH v2 14/17] block: Remove aio_poll() in
 bdrv_drain_poll variants
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: famz@redhat.com, pbonzini@redhat.com, slp@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eXcB9ug9RElyPKMvnHJkA3xhs54MGrDi5
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: famz@redhat.com, pbonzini@redhat.com, slp@redhat.com, jsnow@redhat.com,
 qemu-devel@nongnu.org
Message-ID: <70daa940-8bf8-39f0-faac-54bb7d88061b@redhat.com>
Subject: Re: [PATCH v2 14/17] block: Remove aio_poll() in bdrv_drain_poll
 variants
References: <20180913125217.23173-1-kwolf@redhat.com>
 <20180913125217.23173-15-kwolf@redhat.com>
In-Reply-To: <20180913125217.23173-15-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 13.09.18 14:52, Kevin Wolf wrote:
> bdrv_drain_poll_top_level() was buggy because it didn't release the
> AioContext lock of the node to be drained before calling aio_poll().
> This way, callbacks called by aio_poll() would possibly take the lock a=

> second time and run into a deadlock with a nested AIO_WAIT_WHILE() call=
=2E
>=20
> However, it turns out that the aio_poll() call isn't actually needed an=
y
> more. It was introduced in commit 91af091f923, which is effectively
> reverted by this patch. The cases it was supposed to fix are now covere=
d
> by bdrv_drain_poll(), which waits for block jobs to reach a quiescent
> state.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Fam Zheng <famz@redhat.com>
> ---
>  block/io.c | 8 --------
>  1 file changed, 8 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--eXcB9ug9RElyPKMvnHJkA3xhs54MGrDi5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlua3O8ACgkQ9AfbAGHV
z0DMUQf+LJuMFMVyGrmNdY3bz8YaZw+cWo8A4dXsroPKu8k/b3/BAzK3SKxZbb+V
zo+G7xCjcAkpNfpHE7X9kOTymVZXJg+YFPhx/n+ktieBB/PSYK9/8HhQT2+cre9k
tdrgTANOQ7WdSmNC15JiGfQrvxr2Xhf/MLk7HiRzaBHnEMsl6x+2caHveb9V/wub
H0MAs7Tb+MrvIEa7nAYR7G6u6UBYA3v8BOmFhDnLr8UPlL0+hlWS8vP4nnbb2alA
0018e45fLB79kkxOGxbr1vJ6ck2gUMUTE387XdfK91CyLfFp+cntOKeKd4TxJZK9
lmRfepxz959EYDfKpJjW2sArH2a4ew==
=wK7+
-----END PGP SIGNATURE-----

--eXcB9ug9RElyPKMvnHJkA3xhs54MGrDi5--
