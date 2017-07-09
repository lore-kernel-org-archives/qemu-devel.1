Received: from eggs.gnu.org ([2001:4830:134:3::10]:43063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUKNJ-0004LM-Ar
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 18:08:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUKNI-0007kI-Hy
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 18:08:21 -0400
References: <20170707143028.692-1-pbutsykin@virtuozzo.com>
	<20170707143028.692-4-pbutsykin@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <144bc29f-5d9f-6cf5-ec65-193ad64c9fc9@redhat.com>
Date: Mon, 10 Jul 2017 00:08:10 +0200
MIME-Version: 1.0
In-Reply-To: <20170707143028.692-4-pbutsykin@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="LqmffrBltSrLHteUXKr0iqw7hxM4ubFq1"
Subject: Re: [Qemu-devel] [PATCH v3 3/4] qcow2: add shrink image support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Butsykin <pbutsykin@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, eblake@redhat.com, armbru@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LqmffrBltSrLHteUXKr0iqw7hxM4ubFq1
From: Max Reitz <mreitz@redhat.com>
To: Pavel Butsykin <pbutsykin@virtuozzo.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: kwolf@redhat.com, eblake@redhat.com, armbru@redhat.com, den@openvz.org
Message-ID: <144bc29f-5d9f-6cf5-ec65-193ad64c9fc9@redhat.com>
Subject: Re: [PATCH v3 3/4] qcow2: add shrink image support
References: <20170707143028.692-1-pbutsykin@virtuozzo.com>
 <20170707143028.692-4-pbutsykin@virtuozzo.com>
In-Reply-To: <20170707143028.692-4-pbutsykin@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-07-07 16:30, Pavel Butsykin wrote:
> This patch add shrinking of the image file for qcow2. As a result, this=
 allows
> us to reduce the virtual image size and free up space on the disk witho=
ut
> copying the image. Image can be fragmented and shrink is done by punchi=
ng holes
> in the image file.
>=20
> Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
> ---
>  block/qcow2-cluster.c  |  40 +++++++++++++++++++
>  block/qcow2-refcount.c | 103 +++++++++++++++++++++++++++++++++++++++++=
++++++++
>  block/qcow2.c          |  42 +++++++++++++++-----
>  block/qcow2.h          |  14 +++++++
>  qapi/block-core.json   |   3 +-
>  5 files changed, 191 insertions(+), 11 deletions(-)

[...]

> diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
> index 0141c9cbe7..443fca6a98 100644
> --- a/block/qcow2-refcount.c
> +++ b/block/qcow2-refcount.c

[...]

> @@ -2945,3 +2946,105 @@ done:

[...]

> +            ret =3D qcow2_cache_get(bs, s->refcount_block_cache, refbl=
ock_offs,
> +                                  &refblock);
> +            if (ret < 0) {
> +                goto out;
> +            }
> +
> +            if (s->get_refcount(refblock, block_index) !=3D 1) {
> +                qcow2_cache_put(bs, s->refcount_block_cache, &refblock=
);
> +                ret =3D -EINVAL;

Optional: You could mark the image corrupt here.

Anyway:

Reviewed-by: Max Reitz <mreitz@redhat.com>

> +                goto out;
> +            }
> +            s->set_refcount(refblock, block_index, 0);


--LqmffrBltSrLHteUXKr0iqw7hxM4ubFq1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZYqlKEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQJ4p
B/wIt+YCqwA3rWbNqRAnjD0edGB3Oh2//gNYdeFO/CD7H+aZMc57wXgdgM8VWm4p
0uscIpUhHHx3IIz5Qn1GCnI3S/ejxRAWRLAnOOGSzGDilX30X/MDRyortnNZ7kyk
e3/+0WJdG/+iWKVuzLIpXl2fmTHAwE3FSzw/ammZAjsR0gQpk79cDAPVOow+bGHv
h/oX432UNrYn6hycQtu5gFZ83nGpl1PTS76JhuKskss0Uo4GnV+8mV+43FTpR66z
gHlEIs3FkSgRmNa8bq3shSQ/tvYd2jtVZYDEd8SKjeUz0UI4GInWceU+SIRsBLWZ
b3YsGCeXu9KBM9APXrYmVgo5
=Ftng
-----END PGP SIGNATURE-----

--LqmffrBltSrLHteUXKr0iqw7hxM4ubFq1--
