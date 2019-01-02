Received: from eggs.gnu.org ([208.118.235.92]:54723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1geikc-0001gk-Q8
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 10:48:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1geikb-0004Y1-R5
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 10:48:10 -0500
References: <20190102100415.24680-1-mahaocong_work@163.com>
	<20190102100415.24680-2-mahaocong_work@163.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f256ef6c-8627-5fd0-e814-b59241c0048d@redhat.com>
Date: Wed, 2 Jan 2019 09:47:45 -0600
MIME-Version: 1.0
In-Reply-To: <20190102100415.24680-2-mahaocong_work@163.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="jGpVRUlOrBCjaXY37YSdV1eRz7BRIp5I2"
Subject: Re: [Qemu-devel] [PATCH v2 1/1] drive-mirror: add incremental mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mahaocong <mahaocong_work@163.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, jcody@redhat.com, mahaocong <mahaocong@didichuxing.com>, qemu-devel@nongnu.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jGpVRUlOrBCjaXY37YSdV1eRz7BRIp5I2
From: Eric Blake <eblake@redhat.com>
To: mahaocong <mahaocong_work@163.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, jcody@redhat.com, mahaocong
 <mahaocong@didichuxing.com>, qemu-devel@nongnu.org, mreitz@redhat.com
Message-ID: <f256ef6c-8627-5fd0-e814-b59241c0048d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/1] drive-mirror: add incremental mode
References: <20190102100415.24680-1-mahaocong_work@163.com>
 <20190102100415.24680-2-mahaocong_work@163.com>
In-Reply-To: <20190102100415.24680-2-mahaocong_work@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/2/19 4:04 AM, mahaocong wrote:
> From: mahaocong <mahaocong@didichuxing.com>
>=20
> Signed-off-by: mahaocong <mahaocong@didichuxing.com>

The subject line says "what" changed, but you are missing a commit body
that says "why" the change is useful.  Much of the content in your cover
letter should be copied into this commit body, as the cover letter does
not get stored into git.

> ---
>  block/mirror.c            | 55 ++++++++++++++++++++++++++++++++++++---=
--------
>  blockdev.c                | 37 +++++++++++++++++++++++++++++--
>  include/block/block_int.h |  3 ++-
>  qapi/block-core.json      |  9 +++++++-
>  4 files changed, 88 insertions(+), 16 deletions(-)
>=20

> +++ b/qapi/block-core.json
> @@ -1727,6 +1727,13 @@
>  #        (all the disk, only the sectors allocated in the topmost imag=
e, or
>  #        only new I/O).
>  #
> +# @bitmap: the name of user-created-bitmap which is used to initialize=
 the
> +#          unnamed-bitmap used on incremental drive-mirror. It's hbitm=
ap

"It's" should only be used when you could also have said "It is" or "It
has" - but in this sentence, you are using a possessive which is spelled
"Its".  However, the entire concept of an hbitmap is an internal
implementation detail, so I don't know if it makes sense to be
mentioning an hbitmap in this location.

> +#          will be copy to mirror bitmap. If user select incremental m=
ode,
> +#          bitmap-name should not be null, and can not set granularity=
 for
> +#          the mirror bitmap should have the same granularity with
> +#          user-created-bitmap.

Missing a '(since 4.0)' tag.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--jGpVRUlOrBCjaXY37YSdV1eRz7BRIp5I2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEY3OaSlgimHGqKqRv3g5py3orov0FAlws3SEACgkQ3g5py3or
ov07Lwf/c4v4HZkhFIyzKxV6jd5jnXBVMQw2s5aL8dp3iONegJMZRlonl+3+7ic7
S0jB5BL6+xLI3oBmqlFzg9ONomTGUKvN9Agc8wHtmyU/9elTv8UzIiY95jVckz8y
tiSrSpmtH0H9UyOJIbI5J4vgJ6yHUT7GjVOj0Y1lAFPO7XLlskwUxZZlbKL6u2ic
7ot/24junYukn1xThtO8KHP6GIGxx2+V3AJVDpFAh6pgXAtHfqSDMTaI8FwDPxVE
9VvmsBWlLxlZdXe3PzLHY4G5AMi5cxueBFRwPEfFu8sRBJaZE/YP/RCHjNEucFbt
HN4NtQkvtg0LDIhgWebNIUSpj2etSA==
=1Ud6
-----END PGP SIGNATURE-----

--jGpVRUlOrBCjaXY37YSdV1eRz7BRIp5I2--
