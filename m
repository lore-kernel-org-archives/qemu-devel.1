Received: from eggs.gnu.org ([2001:4830:134:3::10]:54233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cxx9z-00019M-GQ
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 10:52:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cxx9y-0008PC-NW
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 10:52:47 -0400
References: <20170411145050.31290-1-mreitz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <97a7574e-4c00-62bb-e154-a4085b6243e0@redhat.com>
Date: Tue, 11 Apr 2017 16:52:21 +0200
MIME-Version: 1.0
In-Reply-To: <20170411145050.31290-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="StrRKNJxepu6wOg29X7oVHX3djtQQr5HD"
Subject: Re: [Qemu-devel] [PATCH for-2.9?] block/io: Comment out permission
 assertions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--StrRKNJxepu6wOg29X7oVHX3djtQQr5HD
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <famz@redhat.com>
Message-ID: <97a7574e-4c00-62bb-e154-a4085b6243e0@redhat.com>
Subject: Re: [PATCH for-2.9?] block/io: Comment out permission assertions
References: <20170411145050.31290-1-mreitz@redhat.com>
In-Reply-To: <20170411145050.31290-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11.04.2017 16:50, Max Reitz wrote:
> In case of block migration, there may be writes to BlockBackends that d=
o
> not have the write permission taken. Before this issue is fixed (which
> is not going to happen in 2.9), we therefore cannot assert that this is=

> the case.
>=20
> Suggested-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block.c    |  6 +++++-
>  block/io.c | 12 ++++++++++--
>  2 files changed, 15 insertions(+), 3 deletions(-)

I'll send a revert for 2.10 if/when this is merged.

Max


--StrRKNJxepu6wOg29X7oVHX3djtQQr5HD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljs7aUSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AoTQH/3Ddmdq4Ym2f6gItxO+FjsJwLi6muMdJ
3u+9WmrjNjn2BWmjKJaESYw9ffZSfnZdi5ndOFMTtXiIbvWCPc8UfeLysYIvbbbn
LwimxIPtEZt2cBHg7fNy5hhiPWq+FMKQNNKx2LoebZzZVnWmVeYRxjTfGUv7UEPk
ZsooiwMmGzsOVYcvrt2om8dcuL40NwzinxQnsARdPaFs/n1iRXKjmZhh+bpgJlvX
2t3teqdkM8Rkk9xevAfqZ8XqrwMNElnzMi8ajLphYAFnzj6oITJvBhicvxRQ1mPy
fBfdJM0dA57KcztNJe4Lvcdc3JL9aKOfSN1qZGTmcmQKdai5qCQHqjE=
=tYYR
-----END PGP SIGNATURE-----

--StrRKNJxepu6wOg29X7oVHX3djtQQr5HD--
