Received: from eggs.gnu.org ([2001:4830:134:3::10]:42582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1diIbi-0000BO-Bb
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 07:04:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1diIbh-00070S-7N
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 07:04:58 -0400
References: <20170817091542.9403-1-pbutsykin@virtuozzo.com>
	<20170817091542.9403-4-pbutsykin@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8b89c494-29d8-515f-ac06-69c70c9f34f5@redhat.com>
Date: Thu, 17 Aug 2017 06:04:49 -0500
MIME-Version: 1.0
In-Reply-To: <20170817091542.9403-4-pbutsykin@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="SfQGg96n3qc8KEmlmebNTit4315S9GTOe"
Subject: Re: [Qemu-devel] [PATCH v7 3/4] qcow2: add shrink image support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Butsykin <pbutsykin@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: jsnow@redhat.com, kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SfQGg96n3qc8KEmlmebNTit4315S9GTOe
From: Eric Blake <eblake@redhat.com>
To: Pavel Butsykin <pbutsykin@virtuozzo.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: jsnow@redhat.com, kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com,
 den@openvz.org
Message-ID: <8b89c494-29d8-515f-ac06-69c70c9f34f5@redhat.com>
Subject: Re: [PATCH v7 3/4] qcow2: add shrink image support
References: <20170817091542.9403-1-pbutsykin@virtuozzo.com>
 <20170817091542.9403-4-pbutsykin@virtuozzo.com>
In-Reply-To: <20170817091542.9403-4-pbutsykin@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/17/2017 04:15 AM, Pavel Butsykin wrote:
> This patch add shrinking of the image file for qcow2. As a result, this=
 allows
> us to reduce the virtual image size and free up space on the disk witho=
ut
> copying the image. Image can be fragmented and shrink is done by punchi=
ng holes
> in the image file.
>=20
> Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> ---

> +++ b/qapi/block-core.json
> @@ -2495,7 +2495,8 @@
>              'cluster_alloc_bytes', 'cluster_free', 'flush_to_os',
>              'flush_to_disk', 'pwritev_rmw_head', 'pwritev_rmw_after_he=
ad',
>              'pwritev_rmw_tail', 'pwritev_rmw_after_tail', 'pwritev',
> -            'pwritev_zero', 'pwritev_done', 'empty_image_prepare' ] }
> +            'pwritev_zero', 'pwritev_done', 'empty_image_prepare',
> +            'l1_shrink_write_table', 'l1_shrink_free_l2_clusters' ] }

Missing documentation of the new enum members (at a minimum, something
that says 'since 2.11').

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--SfQGg96n3qc8KEmlmebNTit4315S9GTOe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmVeFEACgkQp6FrSiUn
Q2oPxQgAreS3I5+uc5kNp38YG7zwrRUBXURA77aNK+AlD8Xf3IG8fTZoLM51cnPG
vp+HWhQU2Y6mwuE3K5GJ99TOa0PLoAeD86U6m8GJqD2Lrbw9X3VkFJiyGy7B9e9g
jJ2YmOUsVMVSGlYHw7pJzuyrZ3BQjp4sB8IOhrl9bfDVEa9306LpfG7I/YEXbh64
KY0hfYIDhdQUHOTnGH6nA3YXEbHup/pkp6InA/1mlpgajZwcwZIG28XbTvWsrtz6
qXl5J9+cJYM2w1srT6Dp3Ouk8+vbZlSIAXBcBjNqxtt+8yEsZng/zFhKBfev9ctR
UrvKoY5LbJ6zYWn7P/FVFc1DR5Dj3g==
=bHOX
-----END PGP SIGNATURE-----

--SfQGg96n3qc8KEmlmebNTit4315S9GTOe--
