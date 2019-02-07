Received: from eggs.gnu.org ([209.51.188.92]:54138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1grlmM-0005Yj-QA
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 10:39:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1grlmM-0004Rl-0R
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 10:39:54 -0500
References: <20190207102445.71998-1-vsementsov@virtuozzo.com>
	<20190207102445.71998-18-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4b81d977-944e-4d39-2356-826a1a69766c@redhat.com>
Date: Thu, 7 Feb 2019 09:39:25 -0600
MIME-Version: 1.0
In-Reply-To: <20190207102445.71998-18-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="YoZXJMqwr2YmI9XFIPLHk27SnQa9urAUz"
Subject: Re: [Qemu-devel] [PATCH v3 17/17] hw/ide: drop iov field from IDEDMA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: fam@euphon.net, kwolf@redhat.com, quintela@redhat.com, jcody@redhat.com, dgilbert@redhat.com, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org, jsnow@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--YoZXJMqwr2YmI9XFIPLHk27SnQa9urAUz
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: fam@euphon.net, kwolf@redhat.com, quintela@redhat.com, jcody@redhat.com,
 dgilbert@redhat.com, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org,
 jsnow@redhat.com
Message-ID: <4b81d977-944e-4d39-2356-826a1a69766c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 17/17] hw/ide: drop iov field from IDEDMA
References: <20190207102445.71998-1-vsementsov@virtuozzo.com>
 <20190207102445.71998-18-vsementsov@virtuozzo.com>
In-Reply-To: <20190207102445.71998-18-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/7/19 4:24 AM, Vladimir Sementsov-Ogievskiy wrote:
> @iov is used only to initialize @qiov. Let's use new
> qemu_iovec_init_buf() instead, which simplifies the code.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  include/hw/ide/internal.h | 1 -
>  hw/ide/atapi.c            | 5 ++---
>  2 files changed, 2 insertions(+), 4 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--YoZXJMqwr2YmI9XFIPLHk27SnQa9urAUz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxcUS0ACgkQp6FrSiUn
Q2rH4AgAlqzt7MQ03m3ZCyfYQfVnVvsga0I9GwOhp+CuSwBEbErh/ddCIhYYy0CC
/kYCz330/gkmET/0yhxcH77ad3uBuWry0A/OO6hhvruPiG6uZSb/f6GBmWRygJEG
Jqk+PNRooFIyc/eIcwETNsG3QwS+KOkho+durPobZ2fCNfE7Y3Yv3Pua7ScCc4S9
UOvG1DfiFYjbr4gqgwnzOBKaKPGXICnok1n08UaqfqLrUjo/ZRw3UVpcS3sw37me
RzYwKvf5qv6HZ0e30d2MtZgygJQeqKrfvynbxlUeOqY4lrFcZiX9GkZ/dsdPcrOz
KSzW8sFrT/Ra7D4z80j/Md+6wwRy1w==
=mEiK
-----END PGP SIGNATURE-----

--YoZXJMqwr2YmI9XFIPLHk27SnQa9urAUz--
