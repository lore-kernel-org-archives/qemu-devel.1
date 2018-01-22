Received: from eggs.gnu.org ([2001:4830:134:3::10]:35309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1edj0M-0002dR-Or
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 15:47:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1edj0L-0006tm-OA
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 15:47:46 -0500
References: <1516366207-109842-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1516366207-109842-3-git-send-email-anton.nefedov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <260e0e0b-97a3-073f-a020-390e047d6b9d@redhat.com>
Date: Mon, 22 Jan 2018 14:47:32 -0600
MIME-Version: 1.0
In-Reply-To: <1516366207-109842-3-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="jGjihQewYjGMGYzmJrEFu4oFRkZi7yVvU"
Subject: Re: [Qemu-devel] [PATCH v2 2/8] qapi: add unmap to BlockDeviceStats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, jsnow@redhat.com, pbonzini@redhat.com, den@virtuozzo.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jGjihQewYjGMGYzmJrEFu4oFRkZi7yVvU
From: Eric Blake <eblake@redhat.com>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com,
 armbru@redhat.com, jsnow@redhat.com, pbonzini@redhat.com, den@virtuozzo.com
Message-ID: <260e0e0b-97a3-073f-a020-390e047d6b9d@redhat.com>
Subject: Re: [PATCH v2 2/8] qapi: add unmap to BlockDeviceStats
References: <1516366207-109842-1-git-send-email-anton.nefedov@virtuozzo.com>
 <1516366207-109842-3-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1516366207-109842-3-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/19/2018 06:50 AM, Anton Nefedov wrote:
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Alberto Garcia <berto@igalia.com>
> ---
>  qapi/block-core.json       | 29 +++++++++++++++++++++++------
>  include/block/accounting.h |  1 +
>  block/qapi.c               |  6 ++++++
>  3 files changed, 30 insertions(+), 6 deletions(-)
>=20

> @@ -688,6 +693,9 @@
>  #
>  # @rd_total_time_ns: Total_time_spend on reads in nano-seconds (since =
0.15.0).

While we are here, we could change s/Total_time_spend/Total time spent/

>  #
> +# @unmap_total_time_ns: Total time spent on unmap operations in nano-s=
econds
> +#                       (Since 2.12)

Also, s/nano-seconds/nanoseconds/ (for both lines, if we are touching bot=
h).

The QAPI maintainer can touch that up (that may be me, depending on
Markus' schedule in the next few weeks); but I'm not seeing any UI
problems with the addition, so

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--jGjihQewYjGMGYzmJrEFu4oFRkZi7yVvU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpmTeQACgkQp6FrSiUn
Q2pxrwf9HHEw+jCoNW32dxHwMinH+ANdFTAG3U5zilBuf+7bb8UkbUxau4MYDQzk
o+Ke8Xhcd6CaMgZxPmxFKJs9E7jfozMS+4ayJKcuyR+nLLm06JzmViEanSB4G9AO
f/NCB+G3ZlvcqsIohWAvCEOVWbk5T22ahKvLZ5OeO6wXQAt1W7TYJRv89gmoAfra
+auv4kW2xL4aFgLoydklyCz+eI8w/y9PI8pRhgZhr19G0qmjmiDTAm3BBOIenXSe
/OMvog9m59a7/+wigzAZq0qZmPJReaZQE+0A95TAhYmOaiqgGghPal+Y8283m0lx
hC5YgkT4PzjFfSyfLHZpd6CE6KmNAQ==
=qxgE
-----END PGP SIGNATURE-----

--jGjihQewYjGMGYzmJrEFu4oFRkZi7yVvU--
