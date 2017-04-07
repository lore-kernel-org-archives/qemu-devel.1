Received: from eggs.gnu.org ([2001:4830:134:3::10]:54558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cwTLz-00044T-3W
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 08:51:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cwTLy-0002sQ-Ct
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 08:51:03 -0400
Date: Fri, 7 Apr 2017 13:50:51 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170407125051.GB16146@stefanha-x1.localdomain>
References: <20170407065414.9143-1-famz@redhat.com>
	<20170407065414.9143-5-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="24zk1gE8NUlDmwG9"
Content-Disposition: inline
In-Reply-To: <20170407065414.9143-5-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 4/6] block: Quiesce old aio context
 during bdrv_set_aio_context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Ed Swierk <eswierk@skyportsystems.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>


--24zk1gE8NUlDmwG9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 07, 2017 at 02:54:12PM +0800, Fam Zheng wrote:
> @@ -4413,6 +4416,10 @@ void bdrv_set_aio_context(BlockDriverState *bs, AioContext *new_context)
>      aio_context_acquire(new_context);
>      bdrv_attach_aio_context(bs, new_context);
>      aio_context_release(new_context);
> +    if (bs->job) {
> +        block_job_resume(bs->job);
> +    }

Should this be called before aio_context_release(new_context)?

--24zk1gE8NUlDmwG9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY54srAAoJEJykq7OBq3PIBQAIAInOqZt8BpOSxvvAPqZ1n3v5
PMOeKPk4o3jszQWQ2830tljvSKNEnoZft7M8/nKtimHreyCwJOs6phKyPvlXL7ot
wz7TlZ6jXejXun55SspJ7QQMsyM21qyLDIFE0IpUmihIe8vWHh7cKDnvASC0tpJv
pGvzdg51gQ9oJ4rViKNSrWvTZBH6uRzXdGwi29LiUu2Hx6HhpT5djhNAgcJV6nII
stvMSV91NcWcRpu+ZaGR9D8j2E4XR8SEzKedmqCxCZn6mwLQmOR2+7bAgkJws4m0
JtsypLz9n17w/Z8piBZdiMp8aWIXe1tFLhfryymctbXc2CreEnfmkiAcRTu6kyc=
=J+Yt
-----END PGP SIGNATURE-----

--24zk1gE8NUlDmwG9--
