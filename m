Received: from eggs.gnu.org ([2001:4830:134:3::10]:38859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g0S6q-0006u5-LV
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 09:56:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g0S6m-0000d1-Qx
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 09:56:38 -0400
References: <20180913125217.23173-1-kwolf@redhat.com>
	<20180913125217.23173-2-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <27774579-a5a3-0936-b8c8-e4819492bd07@redhat.com>
Date: Thu, 13 Sep 2018 15:56:15 +0200
MIME-Version: 1.0
In-Reply-To: <20180913125217.23173-2-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="THVa5PhYkcQnLKxbdF5vuka1RTo2rFXQG"
Subject: Re: [Qemu-devel] [PATCH v2 01/17] job: Fix missing locking due to
 mismerge
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
--THVa5PhYkcQnLKxbdF5vuka1RTo2rFXQG
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: famz@redhat.com, pbonzini@redhat.com, slp@redhat.com, jsnow@redhat.com,
 qemu-devel@nongnu.org
Message-ID: <27774579-a5a3-0936-b8c8-e4819492bd07@redhat.com>
Subject: Re: [PATCH v2 01/17] job: Fix missing locking due to mismerge
References: <20180913125217.23173-1-kwolf@redhat.com>
 <20180913125217.23173-2-kwolf@redhat.com>
In-Reply-To: <20180913125217.23173-2-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 13.09.18 14:52, Kevin Wolf wrote:
> job_completed() had a problem with double locking that was recently
> fixed independently by two different commits:
>=20
> "job: Fix nested aio_poll() hanging in job_txn_apply"
> "jobs: add exit shim"
>=20
> One fix removed the first aio_context_acquire(), the other fix removed
> the other one. Now we have a bug again and the code is run without any
> locking.
>=20
> Add it back in one of the places.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  job.c | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--THVa5PhYkcQnLKxbdF5vuka1RTo2rFXQG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluabH8ACgkQ9AfbAGHV
z0DihAf/ab9V4K9YrxI5KM9q7L3nax0Sv+GQXqy0AcTY1hfPvBl91Egx3ko3QXsj
0ZHZN5tP4ZpLqKFgP4ik4MiWkWinD5J6Uvylb0a3M2SSOQilwMmG3fmgx2Pjx2uh
9GVMi6sCMroN9zq2/z5mbaX6YUoXlR3jFNDZnnF/BDvf4AZxDs9evHjjzjU9RUPS
tWeWsDVSQ+HUnWBTnY/5CNc7l9TohHm/kUqJyfFphZnGdWsACBzJxTfDzdvdztz9
VXWpuUpdqZTZ/e78o3iFqAyJqIKaaCsBc/v5xBvoY6oEdDA9uhSapr+15mHH+mpc
zCFdaMlPAIa84piv+f8NMS/w0O386A==
=8VZs
-----END PGP SIGNATURE-----

--THVa5PhYkcQnLKxbdF5vuka1RTo2rFXQG--
